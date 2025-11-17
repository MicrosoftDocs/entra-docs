---
title: Learn how to migrate users to Microsoft Entra External ID using Just-In-Time (JIT) Migration
description: Learn how to migrate users from another identity provider to Microsoft Entra External ID using Just-In-Time (JIT) Migration.

author: garrodonnell
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 10/01/2025
ms.author: godonnell

## Customer intent: As a developer or administrator responsible for managing user identities, I want to implement Just-In-Time (JIT) password migration to migrate user credentials from a legacy identity provider to Microsoft Entra External ID, so that users can continue using their existing passwords without requiring an immediate password reset or bulk migration of password hashes.
---
# Migrating users to Microsoft Entra External ID using Just-In-Time (JIT) Migration (Preview)

This tutorial describes how to implement Just-In-Time (JIT) password migration to migrate user credentials from a legacy identity provider to Microsoft Entra External ID. If you are a developer or administrator responsible for managing user identities, this guide will help you understand the steps involved in the migration process.

> [!Note]
> If you have access to user passwords, either at REST or runtime, in your legacy system, you can also proactively populate these. For more information, see [Learn how to migrate users to Microsoft Entra External ID](how-to-migrate-users.md).

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](../includes/active-directory-b2c-end-of-sale-notice.md)]

## Overview of the JIT migration process

JIT migration works by invoking a custom API during the sign-in process to validate user credentials against the legacy identity provider. Entra External ID supports this process by using custom authentication extensions to facilitate the integration. These extensions allow you to define custom logic that runs during the authentication process, enabling you to interact with external systems and perform additional processing as part of the sign-in flow.

When a user enters a password during sign in and their account is marked as not having been migrated yet, the password is sent to an external API endpoint specified by the admin. The external API validates the password against the legacy identity provider. If the password is valid, the API responds with a success message, and the password is securely stored in External ID. The user's account is then marked as migrated, allowing them to sign in seamlessly in the future.

## Define an extension property for tracking migration status

To implement JIT migration, you first need to define an extension property in your External ID tenant to track the migration status of each user. This property will indicate whether a user's credentials have been migrated from the legacy identity provider.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Navigate to **External Identities**, then click on **Custom user attributes**.
1. Enter a unique name for the property, such as `toBeMigrated`, and select the data type as **Boolean**.
1. Click **Create** to add the property to your directory.

You can also create a custom extension using Graph API. The below example demonstrates how to create an extension property using the Microsoft Graph API. To learn more, see [Add custom data to resources by using extensions](/graph/extensibility-overview).

``` http
POST https://graph.microsoft.com/v1.0/applications/30a5435a-1871-485c-8c7b-65f69e287e7b/extensionProperties 

{ 
    "name": "toBeMigrated", 
    "dataType": "Boolean", 
    "targetObjects":[ 
    "User" 
] 
} 
```

### Get the extension property ID for use in your custom authentication extension

After creating the extension property, you need to retrieve its unique identifier to use it in your custom authentication extension. The extension property ID is required to read and update the migration status of users during the authentication process. It's a combination of an application id and the property name.

1. Navigate to **Entra ID** and then **App registrations** in the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Choose **All applications** from above the the application list.
1. Select the application named `b2c-extensions-app` and copy the **Application (client) ID** value without hyphens. This is your application id.
1. Your extension property id is in the format `extension_[application-id]_[attribute-name]`. For example, if your application id is `00001111-aaaa-2222-bbbb-3333cccc4444` and your attribute name is `toBeMigrated`, your extension property id would be `extension_00001111aaaa2222bbbb3333cccc4444_toBeMigrated`.


## Create a custom authentication extension for password validation

Next, create a custom authentication extension that will be invoked during the sign-in process to validate user credentials against the legacy identity provider. 

You can use your own code or deploy the following sample Azure Function to your Azure environment. Make sure to replace the placeholders for *client ID*, *client secret*, *tenant ID*, and *extension attribute* with values from your tenants. This example function simulates the validation process and demonstrates how to handle different response actions, including migrating the password, blocking the sign-in, prompting for a password update, or retrying the authentication based on the outcome of the validation.

``` csharp
using System;
using System.IO;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Security.Cryptography;
using Jose;

namespace cust_auth_functions
{
    /// <summary>
    /// Azure Function for Just-In-Time (JIT) user migration in Entra External ID.
    /// This function handles authentication events and migrates users from legacy systems.
    /// </summary>
    public static class JitMigrationTemplate
    {
        #region Configuration Constants
        
        /// Private key for decrypting the encrypted password context
        /// This should be the private part of the key configured in your External ID tenant
        /// The key here is in a PEM‑encoded PKCS#8 format
        ///
        private const string DECRYPTION_PRIVATE_KEY = @"-----BEGIN PRIVATE KEY-----
-----END PRIVATE KEY-----";

        #endregion


        /// <summary>
        /// Main Azure Function entry point for handling JIT migration requests
        /// </summary>
        /// <param name="req">The HTTP request from Entra External ID</param>
        /// <param name="log">Logger instance for tracking execution</param>
        /// <returns>Action result containing the migration response</returns>
        [FunctionName("JitMigrationTemplate")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)]
            HttpRequest req,
            ILogger log)
        {
            log.LogInformation($"Processing {req.Method} request for JIT migration.");

            // Handle GET requests (health check)
            if (req.Method == HttpMethods.Get)
            {
                log.LogInformation("GET request received. Returning 200 OK for health check.");
                return new OkResult();
            }

            // Validate request body
            if (req.Body == null || req.Body.Length == 0)
            {
                log.LogError("Request body is empty or null.");
                return new BadRequestObjectResult("Request body is required for POST requests.");
            }

            try
            {
                // Parse the incoming request to extract user information
                var (userId, userPassword, nonce) = await ParseRequestAsync(req, log);
                
                if (string.IsNullOrEmpty(userId))
                {
                    log.LogError("User ID is missing from the request.");
                    return new BadRequestObjectResult("User ID is required in the authentication context.");
                }

                if (string.IsNullOrEmpty(userPassword))
                {
                    log.LogError("User password is missing from the request.");
                    return new BadRequestObjectResult("User password is required for migration.");
                }

                // Process the response based on legacy system validation
                ResponseContent response = await ProcessResponse(req, userId, userPassword, nonce, log);
                
                log.LogInformation($"Returning response action: {response.Data.Actions[0].OdataType}.");

                return new OkObjectResult(response);
            }
            catch (Exception ex)
            {
                log.LogError($"Unexpected error during JIT migration processing: {ex.Message}");
                log.LogError($"Stack trace: {ex.StackTrace}");
                
                // Return a generic error response to avoid exposing internal details
                return new StatusCodeResult(StatusCodes.Status500InternalServerError);
            }
        }

        #region Core Processing Methods

        /// <summary>
        /// Processes the migration response by validating credentials against a legacy authentication system.
        /// This example demonstrates how to integrate with your existing user store to determine migration actions.
        /// </summary>
        /// <param name="req">The HTTP request containing query parameters</param>
        /// <param name="userId">The user ID to validate</param>
        /// <param name="password">The user's password to validate</param>
        /// <param name="nonce">The nonce from the request</param>
        /// <param name="log">Logger instance</param>
        /// <returns>ResponseContent with appropriate action based on legacy system validation</returns>
        private static async Task<ResponseContent> ProcessResponse(HttpRequest req, string userId, string password, string nonce, ILogger log)
        {
            log.LogInformation($"Processing JIT migration response for user: {userId}");

            // TODO: Call your legacy authentication provider here
            //
            // Then based on the response from your legacy provider:
            // - If authentication successful AND password strong: return MigratePassword
            // - If authentication successful BUT password weak: return UpdatePassword  
            // - If authentication failed: return Retry
            // - If system error: return Block

            // PLACEHOLDER: Always return Retry for now
            log.LogInformation("Using placeholder implementation - returning Retry action");
            
            return CreateResponse(ResponseActionType.Retry, nonce, "Authentication Pending", 
                "Please implement legacy authentication integration.");
        }

        /// <summary>
        /// Creates a response with the specified action type and user-facing messages
        /// </summary>
        /// <param name="actionType">The response action type</param>
        /// <param name="nonce">The nonce from the request</param>
        /// <param name="title">User-facing title (optional)</param>
        /// <param name="message">User-facing message (optional)</param>
        /// <returns>ResponseContent with the specified action and messages</returns>
        private static ResponseContent CreateResponse(ResponseActionType actionType, string nonce, string title = null, string message = null)
        {
            var response = new ResponseContent(actionType, nonce);
            
            if (!string.IsNullOrEmpty(title))
                response.Data.Actions[0].Title = title;
                
            if (!string.IsNullOrEmpty(message))
                response.Data.Actions[0].Message = message;
                
            return response;
        }


        /// <summary>
        /// Parses the incoming request to extract user ID, password, and nonce
        /// </summary>
        private static async Task<(string userId, string userPassword, string nonce)> ParseRequestAsync(HttpRequest req, ILogger log)
        {
            log.LogInformation($"Parsing request from URL: {req.Path}{req.QueryString}");

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            if (string.IsNullOrWhiteSpace(requestBody))
            {
                log.LogError("Request body is empty or whitespace.");
                return (null, null, null);
            }

            try
            {
                JObject jObject = JObject.Parse(requestBody);
                log.LogDebug($"Parsed request body: {jObject}");

                // Extract user ID from authentication context
                string userId = jObject["data"]?["authenticationContext"]?["user"]?["id"]?.ToString();
                
                // Handle both encrypted and plain text password contexts
                string encryptedPasswordContext = jObject["data"]?["encryptedPasswordContext"]?.ToString();

                (string userPassword, string nonce) = ExtractPasswordAndNonce(encryptedPasswordContext, log);

                return (userId, userPassword, nonce);
            }
            catch (JsonReaderException ex)
            {
                log.LogError($"Failed to parse request body as JSON: {ex.Message}");
                return (null, null, null);
            }
        }

        /// <summary>
        /// Extracts password and nonce from encrypted password context using RSA decryption
        /// </summary>
        private static (string password, string nonce) ExtractPasswordAndNonce(string encryptedContext, ILogger log)
        {
            try
            {
                log.LogInformation("Starting password and nonce extraction from encrypted context");

                // Validate input
                if (string.IsNullOrEmpty(encryptedContext))
                {
                    log.LogError("Encrypted context is null or empty");
                    return (string.Empty, string.Empty);
                }

                RSA rsa = null;
                try
                {
                    // Create and configure RSA instance
                    rsa = RSA.Create();
                    log.LogDebug("RSA instance created successfully");

                    // Import the private key
                    rsa.ImportFromPem(DECRYPTION_PRIVATE_KEY);
                    log.LogDebug("Private key imported successfully");
                }
                catch (CryptographicException ex)
                {
                    log.LogError($"Failed to initialize RSA or import private key: {ex.Message}");
                    return (string.Empty, string.Empty);
                }

                string decryptedPayload;
                try
                {
                    // Decrypt the JWT
                    log.LogDebug("Attempting JWT decryption");
                    decryptedPayload = JWT.Decode(encryptedContext, rsa);
                    log.LogDebug($"JWT decrypted successfully, payload length: {decryptedPayload?.Length ?? 0}");
                    
                    if (string.IsNullOrEmpty(decryptedPayload))
                    {
                        log.LogError("JWT decryption resulted in empty payload");
                        return (string.Empty, string.Empty);
                    }
                }
                catch (Jose.JoseException ex)
                {
                    log.LogError($"Jose JWT library error during decryption: {ex.Message}");
                    return (string.Empty, string.Empty);
                }
                finally
                {
                    // Dispose of RSA instance
                    rsa?.Dispose();
                    log.LogDebug("RSA instance disposed");
                }

                JObject payloadObj;
                try
                {
                    // Parse the decrypted JSON payload
                    log.LogDebug("Parsing decrypted JSON payload");
                    string jsonPayload = Jose.JWT.Decode(decryptedPayload, null, JwsAlgorithm.none);
                    payloadObj = JObject.Parse(jsonPayload);
                    log.LogDebug("JSON payload parsed successfully");
                    
                    // Log the parsed JSON token structure (for debugging - remove in production)
                    log.LogDebug($"Decrypted payload structure: {payloadObj.ToString(Formatting.Indented)}");
                }
                catch (JsonReaderException ex)
                {
                    log.LogError($"Failed to parse decrypted payload as JSON: {ex.Message}");
                    return (string.Empty, string.Empty);
                }

                // Extract password and nonce from the payload
                string password = payloadObj["user-password"]?.ToString();
                string nonce = payloadObj["nonce"]?.ToString();

                log.LogInformation($"Password extraction: {(string.IsNullOrEmpty(password) ? "FAILED" : "SUCCESS")}");
                log.LogInformation($"Nonce extraction: {(string.IsNullOrEmpty(nonce) ? "FAILED" : "SUCCESS")}");

                return (password ?? string.Empty, nonce ?? string.Empty);
            }
            catch (Exception ex)
            {
                log.LogError($"Critical error in ExtractPasswordAndNonce: {ex.Message}");
                log.LogError($"Stack trace: {ex.StackTrace}");
                
                // Return empty values to allow the function to continue with fallback behavior
                return (string.Empty, string.Empty);
            }
        }

        #endregion

        #region Response Models

        /// <summary>
        /// Root response object for JIT migration
        /// </summary>
        public class ResponseContent
        {
            [JsonProperty("data")]
            public Data Data { get; set; }

            public ResponseContent(ResponseActionType actionType, string nonce = null)
            {
                Data = new Data(actionType, nonce);
            }
        }

        /// <summary>
        /// Data payload containing actions and metadata
        /// </summary>
        public class Data
        {
            [JsonProperty("@odata.type")]
            public string OdataType { get; set; }

            [JsonProperty("actions")]
            public List<ActionItem> Actions { get; set; }

            [JsonProperty("nonce")]
            public string Nonce { get; set; }

            public Data(ResponseActionType actionType, string nonce = null)
            {
                OdataType = "microsoft.graph.onPasswordSubmitResponseData";
                Nonce = nonce;
                Actions = new List<ActionItem> { new ActionItem(actionType) };
            }
        }

        /// <summary>
        /// Individual action item in the response
        /// </summary>
        public class ActionItem
        {
            [JsonProperty("@odata.type")]
            public string OdataType { get; set; }

            [JsonProperty("title", DefaultValueHandling = DefaultValueHandling.Ignore)]
            public string Title { get; set; }

            [JsonProperty("message", DefaultValueHandling = DefaultValueHandling.Ignore)]
            public string Message { get; set; }

            public ActionItem(ResponseActionType type)
            {
                OdataType = type switch
                {
                    ResponseActionType.MigratePassword => "microsoft.graph.passwordsubmit.MigratePassword",
                    ResponseActionType.UpdatePassword => "microsoft.graph.passwordsubmit.UpdatePassword",
                    ResponseActionType.Block => "microsoft.graph.passwordsubmit.Block",
                    ResponseActionType.Retry => "microsoft.graph.passwordsubmit.Retry",
                    _ => throw new ArgumentOutOfRangeException(nameof(type), type, null)
                };

                // Set user-facing messages for block actions
                if (type == ResponseActionType.Block)
                {
                    Title = "Sign-in blocked";
                    Message = "Admin has blocked your sign-in attempt. Please contact support.";
                }
            }
        }

        /// <summary>
        /// Available response action types for JIT migration
        /// </summary>
        public enum ResponseActionType
        {
            /// <summary>
            /// Migrate the user's password to Azure AD
            /// </summary>
            MigratePassword,
            
            /// <summary>
            /// Update the user's existing password
            /// </summary>
            UpdatePassword,
            
            /// <summary>
            /// Block the user's sign-in attempt
            /// </summary>
            Block,
            
            /// <summary>
            /// Retry the authentication process
            /// </summary>
            Retry
        }

        #endregion
    }
}
```
Each of the response actions corresponds to a specific scenario during the authentication process. This table describes the possible response actions and when to use them.

| Response Action  | Scenario  | Entra Behavior |
|---|---|---|
| microsoft.graph.passwordSubmit.MigratePassword  | Password validation succeeds; Entra continues authentication. If password is weak, triggers UpdatePassword flow. | Use when password meets basic validation but fails strength requirements.|
| microsoft.graph.passwordSubmit.UpdatePassword  | Password is correct but weak or expired. | Routes user through password reset flow. |
| microsoft.graph.passwordSubmit.Retry  | Password is incorrect. | Allows user to retry authentication if permitted.|
| microsoft.graph.passwordSubmit.Block  | Authentication must be blocked. | Displays block screen with custom message provided by the app.|

When sending a request to your custom authentication extension, Entra will include a payload with the following schema. This sample payload includes dummy data for illustration purposes only.

```json
{  
  "type": "microsoft.graph.authenticationEvent.passwordSubmit",  
  "source": "/tenants/aaaabbbb-0000-cccc-1111-dddd2222eeee/applications/    00001111-aaaa-2222-bbbb-3333cccc4444",  "data": {  
    "@odata.type": "microsoft.graph.onPasswordSubmitCalloutData",  
    "tenantId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",  
    "authenticationEventListenerId": "11112222-bbbb-3333-cccc-4444dddd5555",  
    "customAuthenticationExtensionId": "22223333-cccc-4444-dddd-5555eeee6666", 
      "encryptedPasswordContext": “{5-part-JWE}”, 
    "authenticationContext": {  
      "correlationId": "aaaa0000-bb11-2222-33cc-444444dddddd",  
      "client": {  
        "ip": "127.0.0.1",  
        "locale": "en-us",  
        "market": "en-us"  
      },  
      "protocol": "OAUTH2.0",  
      "clientServicePrincipal": {  
        "id": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",  
        "appId": "00001111-aaaa-2222-bbbb-3333cccc4444",  
        "appDisplayName": "My Test application",  
        "displayName": "My Test application"  
      },  
      "resourceServicePrincipal": {  
        "id": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",  
        "appId": "00001111-aaaa-2222-bbbb-3333cccc4444",  
        "appDisplayName": "My Test application",  
        "displayName": "My Test application"  
      },  
      "user": {  
        "companyName": "Casey Jensen",  
        "createdDateTime": "2023-08-16T00:00:00Z",  
        "displayName": "Casey Jensen",  
        "givenName": "Casey",  
        "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",  
        "mail": "casey@contoso.com",  
        "onPremisesSamAccountName": "Casey Jensen",  
        "onPremisesSecurityIdentifier": "<Enter Security Identifier>",  
        "onPremisesUserPrincipalName": "Casey Jensen",  
        "preferredLanguage": "en-us",  
        "surname": "Jensen",  
        "userPrincipalName": "casey@contoso.com",  
        "userType": "Member"   
      } 

    }  
  }  
} 

```
Response schema:  

```json
{  
  "data": {  
    "@odata.type": "microsoft.graph.onPasswordSubmitResponseData",  
    "actions": [  
      {  
        "@odata.type": "microsoft.graph.passwordSubmit.MigratePassword"  
      } 
    ]  
  }  
}  
```

### Create an app registration for the custom authentication extension 

Next, create an application in your External ID tenant. This application registration will represent the custom authentication extension and will be used to configure the extension policy.

1. Navigate to **Entra ID** and then **App registrations** in the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Click on **New registration**.
1. Enter a unique name for your application.
1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. Click **Register** to create the application.

### Configure the application manifest

You also need to configure the application's manifest to define the necessary properties for the custom authentication extension. Specifically, you need to add a value to identify your API endpoint and additional permissions required by the application.

1. Under the **Manage** section, select **Manifest**.
1. Search the **App Manifest** for *identifierURIs* add the value for your API endpoint as shown in the example below by replacing *Function_URL_Hostname* and *App_ID* with your own values.

```json
"identifierUris": [  
    "api://[Function_URL_Hostname]/[App_ID]"  
], 
```

Your *Function_URL_Hostname* is the host name for the custom extension. For example if the full URL is `https://contoso.onmicrosoft.com/api/JitMigrationEndpoint`,the hostname would be `contoso.onmicrosoft.com`. Your *App_ID* is the application ID from the application you just registered. You can find the application ID on the application's **Overview** page.

Next you will be adding the *CustomAuthenticationExtension.Receive.Payload* permission which allows the extension to receive HTTP requests triggered by authentication events. You can find more information on these permissions in the [Microsoft Graph permissions reference](/graph/permissions-reference).

1. Within the application registration you just created select **API Permissions**. 
1. Click **Add a permission** and choose **Microsoft Graph** then **Application permissions**
1. Search for **CustomAuthenticationExtension.Receive.Payload**, select it and click **Add permissions**.

## Create a custom extension policy

After creating the custom authentication application, you need to create a custom extension policy that defines how the JIT migration process will be executed during user sign-in.

Use the following example to create a custom extension policy using Microsoft Graph API. This policy will invoke your custom authentication application during the sign-in process.

```http
POST https://graph.microsoft.com/beta/identity/customAuthenticationExtensions 
{   
    "@odata.type": "#microsoft.graph.onPasswordSubmitCustomExtension",   
    "displayName": "OnPasswordSubmitCustomExtension",   
    "description": "Validate password",   
    "endpointConfiguration": {   
        "@odata.type": "#microsoft.graph.httpRequestEndpoint",   
        "targetUrl": "{extension-url-from-create-custom-extension-section}"   
    },   
    "authenticationConfiguration": {   
        "@odata.type": "#microsoft.graph.azureAdTokenAuthentication",   
        "resourceId": "{identifierUri-used-in-above-section}"   
    } , 
    "clientConfiguration": { 
       "timeoutInMilliseconds": 2000, 
       "maximumRetries": 1 
   }, 
}  
```

## Register a client application for testing

To test the migration process you need to register a client web application. This application will simulate user sign-in and trigger the custom authentication extension. You can use an app registration or register a new one by following these steps:

1. Navigate to **Entra ID** and then **App registrations** in the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Click on **New registration**.
1. Enter a unique name for your application.
1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. In the **Redirect URI** section, select **Web** and then enter `https://jwt.ms` in the URL text box.
1. Click **Register** to create the application.
1. Under the **Manage** section, select **Authentication**.
1. Under the **Implicit grant and hybrid flows** section, select the **ID tokens (used for implicit and hybrid flows)** checkbox.
1. Under **API Permissions**, grant admin consent for **User.Read** delegated MS Graph permissions.
1. Select **Save** to save your changes.

## Create a listener policy

Finally, create a listener policy that links the custom extension policy to the client application. This policy will ensure that the custom authentication extension is invoked during user sign-in.

Use the following example to create a listener policy using Microsoft Graph API. This policy will associate your client application with the custom authentication extension.

Replace these placeholders with the following information from your configuration:

- *App_ID*: The application ID from the client application you just registered. You can find the application ID on the application's **Overview** page.

- *migrationAttributeID*: The extension attribute ID you created earlier in this tutorial to track the migration status of users.

- *customExtensionObjectId*: The policy ID from the custom authentication extension you created earlier in this tutorial. 

```http
POST https://graph.microsoft.com/beta/identity/authenticationEventListeners 

Content-type: application/json  

{  
    "@odata.type": "#microsoft.graph.onPasswordSubmitListener",  
    "conditions": {  
        "applications": {  
            "includeAllApplications": false,  
            "includeApplications": [  
                {  
                    "appId": "{client-appid-you-created-above }"  
                }  
            ]  
        }  
    },  
    "priority": 500,  
    "handler": {  
        "@odata.type": "#microsoft.graph.onPasswordMigrationCustomExtensionHandler",  
        "migrationAttributeId": "{migrationAttributeID}",  
        "customExtension": {  
            "id": "{customExtensionObjectId}"  
        }  
    }  
}  
```

### Set up encryption for password handling

To secure the decryption private key and other sensitive configuration values used in your Azure Function, you should store them in Azure Key Vault instead of hardcoding them in your application. This section describes how to set up Azure Key Vault integration with your Azure Function to securely manage the RSA private key used for decrypting password contexts and other sensitive credentials.

#### Prerequisites for Azure Key Vault integration

Before you begin, ensure you have:
- An Azure Key Vault instance in your Azure subscription
- Your Azure Function deployed to Azure (Key Vault references work with Azure-hosted functions)
- The RSA private key that matches the public key configured in your External ID tenant

#### Create an Azure Key Vault

If you don't already have a Key Vault, create one using the Azure portal, Azure CLI, or Azure PowerShell. Follow best practices by creating a separate Key Vault per application per environment.

**Using Azure CLI:**

```azurecli
az keyvault create --name <your-key-vault-name> --resource-group <your-resource-group> --location <your-location>
```

**Using Azure PowerShell:**

```azurepowershell
New-AzKeyVault -Name <your-key-vault-name> -ResourceGroupName <your-resource-group> -Location <your-location>
```

> [!TIP]
> Use a naming convention that includes your application name and environment, such as `kv-jitmigration-prod`.

#### Store sensitive values in Key Vault

Store the following sensitive values as secrets in your Key Vault:

1. **Decryption Private Key** - The RSA private key used to decrypt the password context
2. **Legacy Authentication Credentials** - Connection strings, API keys, or credentials needed to validate passwords against your legacy identity provider
3. **Extension Client Secret** (if applicable) - Credentials for authentication between your Azure Function and External ID

**Store the RSA private key:**

```azurecli
az keyvault secret set --vault-name <your-key-vault-name> --name "DecryptionPrivateKey" --value "-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC...
-----END PRIVATE KEY-----"
```

**Store legacy API credentials (example):**

```azurecli
az keyvault secret set --vault-name <your-key-vault-name> --name "LegacyApiConnectionString" --value "Server=myserver;Database=mydb;User Id=myuser;Password=mypassword;"
```

> [!IMPORTANT]
> When storing multi-line values like private keys, ensure the entire PEM-encoded key is stored as a single secret value, including the BEGIN and END markers.

#### Enable Managed Identity for your Azure Function

To allow your Azure Function to securely access Key Vault without storing credentials, enable a system-assigned managed identity.

**Using Azure CLI:**

```azurecli
az functionapp identity assign --name <your-function-app-name> --resource-group <your-resource-group>
```

**Using Azure PowerShell:**

```azurepowershell
Update-AzFunctionApp -Name <your-function-app-name> -ResourceGroupName <your-resource-group> -IdentityType SystemAssigned
```

The output will include a `principalId` (Object ID) that represents your function's managed identity. Save this value for the next step.

#### Grant Key Vault access to your Azure Function

Assign the **Key Vault Secrets User** role to your Azure Function's managed identity using Azure RBAC (recommended) or access policies.

**Using Azure CLI (RBAC - Recommended):**

```azurecli
az role assignment create --role "Key Vault Secrets User" \
  --assignee <principal-id-from-previous-step> \
  --scope /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.KeyVault/vaults/<key-vault-name>
```

**Using Azure PowerShell (RBAC - Recommended):**

```azurepowershell
New-AzRoleAssignment -ObjectId <principal-id-from-previous-step> `
  -RoleDefinitionName "Key Vault Secrets User" `
  -Scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.KeyVault/vaults/<key-vault-name>"
```

> [!NOTE]
> If your Key Vault uses the legacy Access Policies permission model, you'll need to grant "Get" and "List" permissions for secrets. However, RBAC is the recommended approach for new implementations.

#### Configure Key Vault references in Azure Function

Add Key Vault references to your Azure Function's application settings. Azure Functions will automatically retrieve these values from Key Vault at runtime.

Key Vault references use the following syntax:
```
@Microsoft.KeyVault(SecretUri=https://<key-vault-name>.vault.azure.net/secrets/<secret-name>/<version>)
```

You can omit the version to always use the latest version of the secret.

**Using Azure CLI:**

```azurecli
az functionapp config appsettings set --name <your-function-app-name> \
  --resource-group <your-resource-group> \
  --settings "DecryptionPrivateKey=@Microsoft.KeyVault(SecretUri=https://<your-key-vault-name>.vault.azure.net/secrets/DecryptionPrivateKey/)"
```

**Using Azure PowerShell:**

```azurepowershell
Update-AzFunctionAppSetting -Name <your-function-app-name> `
  -ResourceGroupName <your-resource-group> `
  -AppSetting @{
    "DecryptionPrivateKey" = "@Microsoft.KeyVault(SecretUri=https://<your-key-vault-name>.vault.azure.net/secrets/DecryptionPrivateKey/)"
  }
```

**Using Azure Portal:**

1. Navigate to your Azure Function in the [Azure portal](https://portal.azure.com/).
2. Under **Settings**, select **Configuration**.
3. Under **Application settings**, click **+ New application setting**.
4. Enter the name (e.g., `DecryptionPrivateKey`) and the Key Vault reference as the value.
5. Click **OK** and then **Save**.

#### Update your Azure Function code to use Key Vault references

Modify your Azure Function code to read the decryption private key and other sensitive values from environment variables instead of hardcoding them as constants.

Replace the hardcoded constant in your function:

```csharp
// OLD - Hardcoded (INSECURE)
private const string DECRYPTION_PRIVATE_KEY = @"-----BEGIN PRIVATE KEY-----
-----END PRIVATE KEY-----";
```

With code that reads from environment variables:

```csharp
// NEW - Read from environment variable (secured by Key Vault)
private static readonly string DECRYPTION_PRIVATE_KEY = Environment.GetEnvironmentVariable("DecryptionPrivateKey");
```

Similarly, update any other sensitive configuration values:

```csharp
// Read legacy API credentials from Key Vault
private static readonly string LEGACY_API_CONNECTION_STRING = Environment.GetEnvironmentVariable("LegacyApiConnectionString");
```

#### Verify Key Vault integration

After deploying your updated function code:

1. Navigate to your Azure Function in the Azure portal.
2. Go to **Configuration** > **Application settings**.
3. Verify that your Key Vault references show a green checkmark (✓) indicating successful resolution.
4. Test your JIT migration flow by signing in with a test user to ensure the function can decrypt passwords correctly.

#### Best practices for Key Vault with Azure Functions

- **Use separate Key Vaults per environment**: Create dedicated Key Vaults for development, staging, and production environments.
- **Enable purge protection**: Turn on purge protection to prevent accidental deletion of secrets.
- **Configure network restrictions**: Limit Key Vault access to specific virtual networks or IP addresses when possible.
- **Enable Key Vault logging**: Monitor access to your secrets using Azure Monitor or Azure Event Grid.
- **Cache secrets appropriately**: Key Vault references are cached by Azure Functions, reducing latency and throttling concerns.
- **Rotate secrets regularly**: Implement a rotation strategy for your private keys and credentials, updating them at least every 60-90 days.
- **Use Key Vault as Event Grid source**: Monitor secret lifecycle events by integrating with Azure Event Grid and Azure Functions.

For more information about securing Azure Functions with Key Vault, see:
- [Use Key Vault references for Azure Functions](/azure/app-service/app-service-key-vault-references)
- [Best practices for secrets management in Key Vault](/azure/key-vault/secrets/secrets-best-practices)
- [Authentication in Azure Key Vault](/azure/key-vault/general/authentication)

## Outstanding configuration requirements

After setting up Key Vault integration, ensure the following items are completed for your JIT migration implementation:

### Required: Generate and configure RSA key pair

You need to generate an RSA key pair and configure it in your External ID tenant for password encryption:

1. **Generate the RSA key pair** using OpenSSL or a similar tool:
   ```bash
   openssl genrsa -out private-key.pem 2048
   openssl rsa -in private-key.pem -pubout -out public-key.pem
   ```

2. **Store the private key in Key Vault** as described in the previous section.

3. **Configure the public key in your External ID tenant** using Microsoft Graph API:
   ```http
   POST https://graph.microsoft.com/beta/identity/customAuthenticationExtensions/{customExtensionId}/validateAuthenticationConfiguration
   
   {
     "@odata.type": "#microsoft.graph.customExtensionEncryptionConfiguration",
     "encryptionType": "asymmetric",
     "certificate": "-----BEGIN PUBLIC KEY-----\nYOUR_PUBLIC_KEY_HERE\n-----END PUBLIC KEY-----"
   }
   ```

### Required: Implement legacy authentication provider integration

The sample Azure Function code includes a placeholder for legacy authentication. You must implement the actual integration with your legacy identity provider:

1. **Update the `ProcessResponse` method** to call your legacy authentication API or database.
2. **Handle different authentication outcomes**:
   - If authentication succeeds and password is strong: Return `MigratePassword` response
   - If authentication succeeds but password is weak: Return `UpdatePassword` response
   - If authentication fails: Return `Retry` response
   - If there's a system error: Return `Block` response
3. **Store legacy API credentials in Key Vault** and reference them in your function code.

### Required: Mark users for migration

Before enabling JIT migration, mark the users that need to be migrated by setting the custom extension property:

```http
PATCH https://graph.microsoft.com/v1.0/users/{userId}
{
  "extension_00001111aaaa2222bbbb3333cccc4444_toBeMigrated": true
}
```

You can also set this property during user provisioning if you're migrating users from your legacy system.

### Recommended: Configure network security

For production deployments:

1. **Enable Azure Function network restrictions** to limit inbound traffic to trusted sources.
2. **Configure Key Vault firewall** to allow access only from your Azure Function's virtual network or specific IP addresses.
3. **Enable Azure Function managed identity** for all Azure service connections.
4. **Configure Private Link** for Key Vault to keep all traffic within the Azure network.

### Recommended: Set up monitoring and alerting

Monitor your JIT migration process:

1. **Enable Application Insights** for your Azure Function to track execution metrics and errors.
2. **Configure Key Vault logging** to audit secret access.
3. **Set up alerts** for:
   - Failed authentication attempts
   - Key Vault access failures
   - Function execution errors or timeouts
4. **Create a dashboard** to track migration progress (number of users migrated, failure rates, etc.).

## Next steps


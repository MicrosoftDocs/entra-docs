---
title: Migrating users to Microsoft Entra External ID using Just-In-Time (JIT) Migration (Preview)
description: Learn how to migrate users from another identity provider to Microsoft Entra External ID using Just-In-Time (JIT) Migration.

author: garrodonnell
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 10/01/2025
ms.author: godonnell

## Customer intent: As a developer or administrator responsible for managing user identities, I want to implement Just-In-Time (JIT) password migration to migrate user credentials from a legacy identity provider to Microsoft Entra External ID, so that users can continue using their existing passwords without requiring an immediate password reset or bulk migration of password hashes.
---
# Migrating users to Microsoft Entra External ID using Just-In-Time (JIT) Migration (Preview)

This guide describes how to implement Just-In-Time (JIT) password migration to migrate user credentials from a legacy identity provider to Microsoft Entra External ID. If you are a developer or administrator responsible for managing user identities, this guide will help you understand the steps involved in the migration process.

> [!NOTE]
> If you have access to user passwords, either at rest or runtime, in your legacy system, you can also proactively populate these. For more information, see [Learn how to migrate users to Microsoft Entra External ID](how-to-migrate-users.md).

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](../includes/active-directory-b2c-end-of-sale-notice.md)]

## Prerequisites

Before you begin, ensure you have:

- **Microsoft Entra External ID tenant**: An active External ID tenant. If you don't have one, see [Get started with Microsoft Entra External ID](/entra/external-id/customers/quickstart-tenant-setup).
- **Legacy identity provider access**: Ability to validate user credentials against your existing identity provider.
- **Development environment**: To test your migration implementation before deploying to production.
- **Understanding of the following concepts**:
  - [User management in Microsoft Entra ID](/entra/fundamentals/how-to-create-delete-users): Creating and managing user accounts
  - [App registrations](/entra/identity-platform/quickstart-register-app): Registering applications in Microsoft Entra ID
  - [Microsoft Graph API](/graph/api/user-post-users): Programmatic user and directory management
  - [Directory extensions](/graph/extensibility-overview): Adding custom properties to directory objects
  - [Azure Functions](/azure/azure-functions/functions-overview): Serverless compute for hosting custom logic

## Overview of the JIT migration process

JIT migration works by invoking a custom API during the sign-in process to validate user credentials against the legacy identity provider. Entra External ID supports this process by using [custom authentication extensions](/graph/api/resources/customauthenticationextension) to facilitate the integration. These extensions allow you to define custom logic that runs during the authentication process, enabling you to interact with external systems and perform additional processing as part of the sign-in flow.

From the user's perspective, the migration is completely seamless. Users simply sign in with their existing credentials from the legacy system. If the credentials are correct, they're authenticated successfully and can access your application. Behind the scenes, their password is securely migrated to Microsoft Entra External ID, and subsequent sign-ins authenticate directly against Entra without invoking the legacy system. This approach minimizes disruption during migration and eliminates the need for users to reset their passwords or learn new credentials.

The JIT migration process is illustrated in the following diagram:

:::image type="content" source="media/how-to-migrate-users-jit/jit-migration-flow-diagram.png" alt-text="Diagram of the Just-In-Time password migration flow showing user authentication from a legacy identity provider to Microsoft Entra External ID." lightbox="media/how-to-migrate-users-jit/jit-migration-flow-diagram.png":::

### How the JIT migration process works

When a user with the migration flag set to `true` signs in, the following process occurs:

- **User signs in** - User enters credentials from the legacy identity provider.
- **Migration flag check** - If the password entered does not match the dummy password on record for the user, Entra External ID checks the custom extension property and invokes the OnPasswordSubmit listener if migration is needed.    
- **Password encryption** - Entra encrypts the password using the public key (RSA JWE format) ensuring plaintext is never transmitted.
- **Custom extension invocation** - Entra calls your Azure Function with the encrypted payload, user information, and authentication context.
- **Decryption and validation** - Your function decrypts the password using the private key from Key Vault and validates credentials against your legacy identity provider.
- **Response action** - Your function returns one of four actions:
   - **MigratePassword**: Password is valid; Entra stores it and sets migration flag to `false`
   - **UpdatePassword**: Password is correct but weak; user must reset password
   - **Retry**: Password is incorrect; user can try again
   - **Block**: Authentication blocked (e.g., account locked in legacy system)
- **Authentication completion** - If successful, the user is authenticated and future sign-ins bypass the custom extension.

> [!NOTE]
> Passwords are encrypted end-to-end using asymmetric RSA encryption. The private key remains in Azure Key Vault and is never exposed in your function code.

## 1. Bulk migrate users

Before implementing JIT migration, you need to prepare your users in Microsoft Entra External ID. This involves defining a custom extension property to track migration status, generating temporary passwords, and creating user accounts.

### 1.1 Define an extension property for tracking migration status

To implement JIT migration, you need to define a directory extension property to track whether each user's credentials have been migrated from the legacy identity provider. Microsoft Graph supports adding custom properties to directory objects through [directory (Microsoft Entra ID) extensions](/graph/extensibility-overview). For detailed information about extension types and their usage, see [Add custom data to resources by using extensions](/graph/extensibility-overview).

Create an extension property using the Microsoft Graph API with a default value of `true`:

``` http
POST https://graph.microsoft.com/v1.0/applications/30a5435a-1871-485c-8c7b-65f69e287e7b/extensionProperties 

{ 
    "name": "toBeMigrated", 
    "dataType": "Boolean",
    "defaultValue": true,
    "targetObjects":[ 
    "User" 
] 
} 
```

Replace `30a5435a-1871-485c-8c7b-65f69e287e7b` with the object ID of your application. By setting `defaultValue` to `true`, all new users will automatically be flagged for migration.

#### 1.1.1 Get the extension property ID for use in your custom authentication extension

After creating the extension property, you need to retrieve its unique identifier to use in your custom authentication extension. The extension property ID follows this naming convention: `extension_{applicationId-without-hyphens}_{attributeName}`.

To construct your extension property ID:

1. Navigate to **Entra ID** > **App registrations** in the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Select **All applications** from above the application list.
1. Find the application named `b2c-extensions-app` and copy its **Application (client) ID** value.
1. Remove the hyphens from the application ID and combine it with your attribute name.

For example, if your application ID is `00001111-aaaa-2222-bbbb-3333cccc4444` and your attribute name is `toBeMigrated`, your extension property ID would be `extension_00001111aaaa2222bbbb3333cccc4444_toBeMigrated`.

### 1.2 Generate random strong password

Before creating users, generate unique, strong temporary passwords for each user account. These passwords will be replaced with the user's actual password from the legacy identity provider during their first sign-in through the JIT migration process.

> [!IMPORTANT]
> Ensure that the temporary passwords are unique and strong to maintain security during the migration process. Consider using a password generation library or service that meets your organization's security requirements.

### 1.3 Create users with migration property

Create user accounts in your External ID tenant. You can create users through the [Microsoft Entra admin center](https://entra.microsoft.com/) or programmatically using the [Microsoft Graph API](/graph/api/user-post-users). For detailed instructions on user creation, see [How to create, invite, and delete users](/entra/fundamentals/how-to-create-delete-users).

## 2. Configure the custom authentication extension

After preparing your users, configure the components that enable JIT migration during the authentication process. This includes registering your legacy API with Azure resources, configuring the External ID authentication extension app with encryption settings, and creating the custom extension policy.

### 2.1 Register your legacy API

Create the encryption certificate and deploy an Azure Function that validates user credentials against your legacy identity provider.

#### 2.1.1 Generate certificate in Azure Key Vault

Before creating your app registration, generate an encryption certificate in Azure Key Vault. The public key is configured in your Entra External ID app registration, while the private key remains in Key Vault and is accessed by your Azure Function using managed identity.

1. Sign in to the [Azure portal](https://portal.azure.com) and browse to **Key vaults**.
1. Select your existing Key Vault or [create a new one](/azure/key-vault/general/quick-create-portal).
1. In the left menu, under **Objects**, select **Certificates**.
1. Select **Generate/Import**.
1. On the **Create a certificate** page, enter the following values:
   - **Method of Certificate Creation**: Select **Generate**.
   - **Certificate Name**: Enter **JitMigrationEncryptionCert**.
   - **Type of Certificate Authority (CA)**: Select **Self-signed certificate**.
   - **Subject**: Enter **CN=JitMigration**.
   - **Content Type**: Select **PKCS #12**.
1. Expand **Advanced Policy Configuration** and enter the following values:
   - **Key Type**: Select **RSA**.
   - **Key Size**: Select **2048** or **4096** for enhanced security.
   - **Reuse Key**: Leave unchecked.
   - **Exportable Private Key**: Select this option (required for function access).
1. Select **Create**.

> [!TIP]
> Generating certificates directly in Azure Key Vault ensures the private key never leaves the secure environment and provides enterprise features like automatic key rotation, access auditing, and HSM protection.

#### 2.1.2 Create custom authentication extension

Create an Azure Function that validates user credentials against your legacy identity provider. When sending a request to your custom authentication extension, Entra will include a payload with the following schema. This sample payload includes dummy data for illustration purposes only.

```json
{  
  "type": "microsoft.graph.authenticationEvent.passwordSubmit",  
  "source": "/tenants/aaaabbbb-0000-cccc-1111-dddd2222eeee/applications/    00001111-aaaa-2222-bbbb-3333cccc4444",  "data": {  
    "@odata.type": "microsoft.graph.onPasswordSubmitCalloutData",  
    "tenantId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",  
    "authenticationEventListenerId": "11112222-bbbb-3333-cccc-4444dddd5555",  
    "customAuthenticationExtensionId": "22223333-cccc-4444-dddd-5555eeee6666", 
      "encryptedPasswordContext": "{5-part-JWE}", 
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
    "nonce": // This should be the nonce value acquired after decrypting the password context from the request payload.
  }  
}  
```

Each of the available response actions corresponds to a specific scenario during the authentication process. This table describes the possible response actions and when to use them.

| Response Action  | Scenario  | Entra Behavior |
|---|---|---|
| microsoft.graph.passwordSubmit.MigratePassword  | Password validation succeeds; Entra continues authentication. If password is weak, triggers UpdatePassword flow. | Use when password meets basic validation but fails strength requirements.|
| microsoft.graph.passwordSubmit.UpdatePassword  | Password is correct but weak or expired. | Routes user through password reset flow. |
| microsoft.graph.passwordSubmit.Retry  | Password is incorrect. | Allows user to retry authentication if permitted.|
| microsoft.graph.passwordSubmit.Block  | Authentication must be blocked. | Displays block screen with custom message provided by the app.|

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

### 2.2 Configure Azure Function for Key Vault access

Your Azure Function needs to access the private key stored in Key Vault to decrypt the password payload.

#### 2.2.1 Enable managed identity

1. Sign in to the [Azure portal](https://portal.azure.com) and browse to **Function App**.
1. Select your function app.
1. In the left menu, under **Settings**, select **Identity**.
1. Under the **System assigned** tab, set **Status** to **On**.
1. Select **Save**.
1. After the identity is created, copy the **Object (principal) ID** value. You'll need it in the next step.

#### 2.2.2 Grant Key Vault access

1. In the Azure portal, go to your Key Vault.
1. In the left menu, under **Settings**, select **Access policies**.
1. Select **Create**.
1. Under **Secret permissions**, select **Get**, and then select **Next**.
1. On the **Principal** page, paste the object ID you copied in the previous step.
1. Select your function app's managed identity from the search results.
1. Select **Next**, and then select **Next** again.
1. Select **Create** to create the access policy with the following permissions:
   - **Secret permissions**: Get
   - **Principal**: Your function app name

#### 2.2.3 Install required packages

Your function project requires the following NuGet packages to access Key Vault:

1. Open your function project in Visual Studio or Visual Studio Code.
1. Right-click the project and select **Manage NuGet Packages**.
1. Search for and install the following packages:
   - **Azure.Identity** (version 1.12.0 or later)
   - **Azure.Security.KeyVault.Secrets** (version 4.6.0 or later)

#### 2.2.4 Configure application settings

Add the following settings to your function configuration.

For local development, add these values to your `local.settings.json` file:

```json
{
  "Values": {
    "KeyVaultUrl": "https://your-keyvault-name.vault.azure.net/",
    "CiamJitMigrationEncryptionCertName": "JitMigrationEncryptionCert"
  }
}
```

For Azure deployment:

1. In the Azure portal, go to your function app.
1. In the left menu, under **Settings**, select **Configuration**.
1. Under **Application settings**, select **New application setting** and add the following settings:
   - **Name**: `KeyVaultUrl`, **Value**: `https://your-keyvault-name.vault.azure.net/`
   - **Name**: `CiamJitMigrationEncryptionCertName`, **Value**: `JitMigrationEncryptionCert`
1. Select **Save** to save the settings and restart the function app.

#### 2.2.5 Update your function code

Update your function code to retrieve the certificate from Key Vault using managed identity instead of using a hardcoded private key. Add the following code to your function:

```csharp
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
using System.Security.Cryptography.X509Certificates;

// Remove the hardcoded constant:
// private const string DECRYPTION_PRIVATE_KEY = @"-----BEGIN PRIVATE KEY-----...";

// Add method to retrieve certificate from Key Vault:
private static X509Certificate2 GetCertificateFromKeyVault()
{
    var keyVaultUrl = Environment.GetEnvironmentVariable("KeyVaultUrl") 
        ?? throw new InvalidOperationException("KeyVaultUrl not configured");
    var certName = Environment.GetEnvironmentVariable("CiamJitMigrationEncryptionCertName") 
        ?? throw new InvalidOperationException("CiamJitMigrationEncryptionCertName not configured");

    var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential());
    KeyVaultSecret secret = client.GetSecret(certName);
    
    byte[] certBytes = Convert.FromBase64String(secret.Value);
    return new X509Certificate2(certBytes, (string)null, X509KeyStorageFlags.MachineKeySet);
}
```

Update your decryption code to use the certificate from Key Vault instead of the hardcoded private key.

#### 2.2.6 Deploy the Azure Function

After you configure your function code, deploy it to Azure using Visual Studio 2022:

1. In Solution Explorer, right-click your function project.
1. Select **Publish**.
1. If you haven't set up a publish profile:
   1. Select **Azure**, and then select **Next**.
   1. Select **Azure Function App (Windows)**, and then select **Next**.
   1. Sign in to your Azure account if prompted.
   1. Select your subscription and function app.
   1. Select **Finish**.
1. On the **Publish** page, select **Publish**.
1. Wait for the deployment to complete. A "Publish succeeded" message appears when the deployment is finished.

### 2.3 Create app registration for the custom authentication extension

Create an application registration to represent your custom authentication extension. This application will authenticate calls between Microsoft Entra External ID and your Azure Function. For general guidance on app registrations, see [Register an application](/entra/identity-platform/quickstart-register-app).

Register a new application in the [Microsoft Entra admin center](https://entra.microsoft.com/) with the following settings:

- **Name**: Enter a descriptive name for your JIT migration extension
- **Supported account types**: Accounts in this organizational directory only

### 2.4 Configure encryption key

After you create your app registration, configure the certificate's public key so that Entra External ID can encrypt the password payload before sending it to your custom extension.

#### 2.4.1 Download the certificate

1. In your Key Vault, under **Certificates**, select **JitMigrationEncryptionCert**.
1. Select the current version (shown as a GUID).
1. Select **Download in CER format**.
1. Save the file (for example, `jitmigrationencryptioncert.cer`).

#### 2.4.2 Extract the public key

1. Open PowerShell.
1. Run the following commands, replacing the file path with your certificate location:

   ```powershell
   $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2("C:\Users\YourUsername\Downloads\jitmigrationencryptioncert.cer")
   $certBase64 = [Convert]::ToBase64String($cert.RawData)
   $certBase64
   ```

1. Copy the base64-encoded public key from the output.

#### 2.4.3 Configure the certificate via Graph API

Use Microsoft Graph API to configure the certificate on your custom authentication extension app registration. Make a PATCH request with the following information:

Replace the placeholders with your values:
- `{object-id}`: Your custom authentication extension app's object ID (not the application ID).
- `{end-date}`: Certificate expiration date (for example, `2026-11-25T17:44:47Z`).
- `{unique-guid}`: A new GUID. You can generate one using PowerShell: `[guid]::NewGuid()`.
- `{start-date}`: Certificate start date (for example, `2025-11-25T17:44:47Z`).
- `{base64-encoded-public-key}`: The base64 string from the previous step.

```http
PATCH https://graph.microsoft.com/v1.0/applications/{object-id}
Content-Type: application/json
Authorization: Bearer {access-token}

{
  "keyCredentials": [
    {
      "endDateTime": "{end-date}",
      "keyId": "{unique-guid}",
      "startDateTime": "{start-date}",
      "type": "AsymmetricX509Cert",
      "usage": "Encrypt",
      "key": "{base64-encoded-public-key}",
      "displayName": "CN=JitMigration"
    }
  ],
  "tokenEncryptionKeyId": "{unique-guid}"
}
```

This configuration tells Entra External ID to use the public key when encrypting the password context for your custom extension.

#### 2.4.4 Set the identifier URI

The identifier URI uniquely identifies your custom authentication extension API. Add the following to your application manifest, replacing the placeholders with your values:

```json
"identifierUris": [  
    "api://[Function_URL_Hostname]/[App_ID]"  
], 
```

- **Function_URL_Hostname**: The hostname of your Azure Function (e.g., `contoso.azurewebsites.net`)
- **App_ID**: Your application (client) ID from the app registration **Overview** page

For example: `"api://contoso.azurewebsites.net/12345678-1234-1234-1234-123456789012"`

#### 2.4.5 Grant required permission

Your custom authentication extension requires the `CustomAuthenticationExtension.Receive.Payload` application permission to receive HTTP requests from authentication events. To set this permission follow these steps:

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), navigate to **Entra ID** > **App registrations** and select your custom authentication extension application.
1. Go to **API permissions** > **Add a permission**.
1. Select **Microsoft Graph** > **Application permissions**.
1. Search for **CustomAuthenticationExtension.Receive.Payload**, select it and click **Add permissions**.
1. Finally, click **Grant admin consent for [Your Tenant]** to grant the permission.

### 2.5 Create custom extension policy

After creating the custom authentication application, create a custom extension policy that defines how the JIT migration process will be executed during user sign-in.

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
    } , 
    "clientConfiguration": { 
       "timeoutInMilliseconds": 2000, 
       "maximumRetries": 1 
   }, 
}  
```

## 3. Cutover the legacy app to External ID

After configuring your custom authentication extension, prepare for production cutover by registering your client application and creating the listener policy that activates JIT migration.

### 3.1 Register client application

Register a client application for testing the JIT migration process. This application will trigger the custom authentication extension during sign-in. For detailed instructions on registering applications, see [Quickstart: Register an application](/entra/identity-platform/quickstart-register-app).

Register a new web application with these JIT migration-specific settings:

- **Redirect URI**: Set to `https://jwt.ms` (Web platform) for testing
- **Authentication**: Enable **ID tokens** under implicit grant and hybrid flows
- **API Permissions**: Grant admin consent for **User.Read** (delegated Microsoft Graph permission). Even if the permission already exists, re-granting consent is necessary for proper configuration.

> [!TIP]
> You can use an existing application registration if you have one configured for testing.

### 3.2 Create listener policy

Create a listener policy that links the custom extension policy to the client application. This policy ensures that the custom authentication extension is invoked during user sign-in.

Use the following example to create a listener policy using Microsoft Graph API. This policy will associate your client application with the custom authentication extension.

Replace these placeholders with the following information from your configuration:

- *App_ID*: The application ID from the client application you just registered. You can find the application ID on the application's **Overview** page.

- *migrationPropertyId*: The extension attribute ID you created earlier in this tutorial to track the migration status of users.

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
        "migrationPropertyId": "{migrationPropertyId}",  
        "customExtension": {  
            "id": "{customExtensionObjectId}"  
        }  
    }  
}  
```

## 4. Test and validate before deploying to production

Before deploying JIT migration to production, thoroughly test the implementation to ensure it works correctly and securely.

Consider the following testing checklist:

1. **Test with a subset of users**: Start with a small group of test users before migrating your entire user base.
1. **Verify credential validation**: Ensure your Azure Function correctly validates credentials against your legacy identity provider.
1. **Check migration flag updates**: Confirm that the migration flag is set to `false` after successful migration.
1. **Test different response actions**: Verify that all response actions (MigratePassword, UpdatePassword, Retry, Block) work as expected.
1. **Monitor Azure Function logs**: Review logs to identify any errors or issues during the authentication process.
1. **Validate encryption**: Ensure that passwords are encrypted end-to-end and never exposed in logs or error messages.

## Next steps

- [Learn how to migrate users to Microsoft Entra External ID](how-to-migrate-users.md)
- [Custom authentication extensions overview](/graph/api/resources/customauthenticationextension)
- [Secure Azure Functions](/azure/azure-functions/security-concepts)
- [Azure Key Vault documentation](/azure/key-vault/)

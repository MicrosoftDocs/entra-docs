---
title: Just-In-Time Password Migration to Microsoft Entra External ID (Preview)
description: Learn how to migrate passwords from another identity provider to Microsoft Entra External ID using Just-In-Time (JIT) Migration.
ai-usage: ai-assisted
author: garrodonnell
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 12/12/2025
ms.author: godonnell

## Customer intent: As a developer or administrator responsible for managing user identities, I want to implement Just-In-Time (JIT) password migration to migrate user credentials from a legacy identity provider to Microsoft Entra External ID, so that users can continue using their existing passwords without requiring an immediate password reset or bulk migration of password hashes.
---
# Just-In-Time Password Migration to Microsoft Entra External ID (Preview)

This guide describes how to implement Just-In-Time (JIT) password migration to migrate user credentials from a legacy identity provider to Microsoft Entra External ID. If you're a developer or administrator responsible for managing user identities, this guide will help you understand the steps involved in the migration process.

> [!NOTE]
> If you have access to user passwords, either at rest or runtime, in your legacy system, you can also proactively populate them. For more information, see [Learn how to migrate users to Microsoft Entra External ID](how-to-migrate-users.md).

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
- An account with the following roles assigned:
    - [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator) 
    - [User Administrator](../../identity/role-based-access-control/permissions-reference.md#user-administrator)
    - Authentication Extensibility Password Administrator. This role gives you the necessary permissions to create and manage custom authentication extensions for password migration. The role definition ID is `0b00bede-4072-4d22-b441-e7df02a1ef63`. 
    You can find more information about role assignments in the [Microsoft Entra ID roles documentation](/entra/identity/role-based-access-control/manage-roles-portal?tabs=ms-graph). 


## Overview of the JIT migration process

JIT migration works by invoking a custom API during the sign-in process to validate user credentials against the legacy identity provider. Microsoft Entra External ID supports this process by using [custom authentication extensions](/graph/api/resources/customauthenticationextension) to facilitate the integration. These extensions allow you to define custom logic that runs during the authentication process, enabling you to interact with external systems and perform more processing as part of the sign-in flow.

From the user's perspective, the migration is completely seamless. Users  sign in with their existing credentials from the legacy system. If the credentials are correct, they're authenticated successfully and can access your application. Behind the scenes, their password is securely migrated to Microsoft Entra External ID, and subsequent sign-ins authenticate directly against Entra without invoking the legacy system. This approach minimizes disruption during migration and eliminates the need for users to reset their passwords or learn new credentials.

>[!NOTE]
> This process is for password migration and not password validation. The legacy system is only used to validate the password during the first sign-in. After that, the password is stored and validated directly in Microsoft Entra External ID.

The JIT migration process is illustrated in the following diagram:

:::image type="content" source="media/how-to-migrate-passwords-just-in-time/jit-migration-process-diagram.png" alt-text="Diagram of the JIT migration process showing user sign-in with legacy credentials, migration flag check, and password validation via a custom API." lightbox="media/how-to-migrate-passwords-just-in-time/jit-migration-process-diagram.png":::

### How the JIT migration process works

When a consumer user account with the migration flag set to `true` signs in, the following process occurs:

- **Consumer user signs in** - User enters credentials from the legacy identity provider.   
- **Migration flag check** - Depending on the password entered there are two possible outcomes:
    - If the password entered does not match the password on record for the user, External ID checks the custom extension property and invokes the OnPasswordSubmit listener if migration is needed. 
    - If the password does match the one on record, authentication proceeds normally and the user is silently marked as migrated. 
- **Password encryption** - External ID encrypts the password using the public key (RSA JWE format) ensuring plaintext is never transmitted. The private key remains in Azure Key Vault and is never exposed in your function code.
- **Custom extension invocation** - External ID calls your code with the encrypted payload, user information, and authentication context.
- **Decryption and validation** - Your function decrypts the password using a private key and validates credentials against your legacy identity provider.
- **Response action** - Your function returns one of four actions:
   - **MigratePassword**: Password is valid; External ID stores it and sets migration flag to `false`
   - **UpdatePassword**: Password is correct but weak; user must reset password
   - **Retry**: Password is incorrect; user can try again
   - **Block**: Authentication blocked (e.g., account locked in legacy system)
- **Authentication completion** - If successful, the user is authenticated and future sign-ins bypass the custom extension.

## 1. Bulk migrate users

Before implementing JIT migration, you need to prepare your users in Microsoft Entra External ID. This involves defining a custom extension property to track migration status, generating temporary passwords, and creating user accounts.

### 1.1 Define an extension property for tracking migration status

To implement JIT migration, you need to define a directory extension property to track whether each user's credentials have been migrated from the legacy identity provider. Microsoft Graph supports adding custom properties to directory objects through [directory (Microsoft Entra ID) extensions](/graph/extensibility-overview#directory-microsoft-entra-id-extensions). 


#### [Graph](#tab/graph)

Create an extension property using the Microsoft Graph API:

``` http
POST https://graph.microsoft.com/v1.0/applications/00001111-aaaa-2222-bbbb-3333cccc4444/extensionProperties 

{ 
    "name": "toBeMigrated", 
    "dataType": "Boolean",
    "targetObjects":[ 
        "User" 
    ] 
} 
```
Replace `00001111-aaaa-2222-bbbb-3333cccc4444` with the object ID `b2c-extensions-app` of your application. The value of this extension should be set to true for all users who will require migration.

#### [Admin Center](#tab/admin-center)

To create an extension property using the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Navigate to **Identity** > **External Identities** > **Custom user attributes**.
1. Select **Add**.
1. Enter the following values:
   - **Name**: Enter a name for the property (for example, `toBeMigrated`).
   - **Data Type**: Select **Boolean**.
   - **Description**: Enter a meaningful description (for example, "Tracks user password has migration from legacy system").
1. Select **Create**.

---

#### 1.1.1 Get the extension property ID for use in your custom authentication extension

After creating the extension property, you need to retrieve its unique identifier to use in your custom authentication extension. The extension property ID follows this naming convention: `extension_{applicationId-without-hyphens}_{propertyName}`.

To construct your extension property ID:

1. Navigate to **Entra ID** > **App registrations** in the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Select **All applications** from above the application list.
1. Find the application named `b2c-extensions-app` and copy its **Application (client) ID** value.
1. Remove the hyphens from the application ID and combine it with your attribute name.

For example, if your application ID is `00001111-aaaa-2222-bbbb-3333cccc4444` and your attribute name is `toBeMigrated`, your extension property ID would be `extension_00001111aaaa2222bbbb3333cccc4444_toBeMigrated`.

### 1.2 Generate random strong password

Before creating users, generate unique, strong temporary passwords for each user account. These will be replaced with the user's actual password from the legacy identity provider during their first sign-in through the JIT migration process.

> [!IMPORTANT]
> Ensure that the temporary passwords are unique and strong to maintain security during the migration process. Consider using a password generation library or service that meets your organization's security requirements.

### 1.3 Create users with migration property

Create user accounts in your External ID tenant. You can create users through the [Microsoft Entra admin center](https://entra.microsoft.com/) or programmatically using the [Microsoft Graph API](/graph/api/user-post-users). For detailed instructions on user creation, see [How to create, invite, and delete users](/entra/fundamentals/how-to-create-delete-users).

The following example demonstrates how to create a user with the migration extension property set to `true` using the Microsoft Graph API. Replace `{extension-property-id}` with the actual extension property ID you constructed in the previous step. These properties must be present on the user object to trigger the migration event.

This request includes user details and other values that will be shared with the external API. You can set the required primary properties on the user that can be used during the custom extension execution.

``` http
POST https://graph.microsoft.com/v1.0/users

{
    "creationType": "LocalAccount",
    "accountEnabled": true,
    "passwordProfile": {
        "forceChangePasswordNextSignIn": false,
        "password": "<unique-generated-random-strong-password>"
    },
    "{extension-property-id}": true
}
```
You can find sample code to support your user migration in our [B2C to MEEID migration tool](https://github.com/microsoft/b2c-to-meeid-migration-tool/).

For more information on bulk migrating users, see [Learn how to migrate users to Microsoft Entra External ID](how-to-migrate-users.md).

## 2. Configure the custom authentication extension

After preparing your users, configure the components that enable JIT migration during the authentication process. This includes securely storing certificates, hosting your custom extension, and configuring the authentication extension application.

### 2.1 Store the certificate securely

Create the encryption certificate in Azure Key Vault and configure secure access for your Azure Function.

#### 2.1.1 Enable managed identity

Your Azure Function needs to access the private key stored in Key Vault to decrypt the password payload. Before generating the certificate, set up managed identity for your Azure Function.

1. Sign in to the [Azure portal](https://portal.azure.com) and browse to **Function App**.
1. Select your function app.
1. In the left menu, under **Settings**, select **Identity**.
1. Under the **System assigned** tab, set **Status** to **On**.
1. Select **Save**.
1. After the identity is created, copy the **Object (principal) ID** value. You'll need it in the next step.

#### 2.1.2 Grant Key Vault access

1. In the Azure portal, go to your Key Vault (or [create a new one](/azure/key-vault/general/quick-create-portal) if needed).
1. In the left menu, under **Settings**, select **Access policies**.
1. Select **Create**.
1. Under **Secret permissions**, select **Get**, and then select **Next**.
1. On the **Principal** page, paste the object ID you copied in the previous step.
1. Select your function app's managed identity from the search results.
1. Select **Next**, and then select **Next** again.
1. Select **Create** to create the access policy with the following permissions:
   - **Secret permissions**: Get
   - **Principal**: Your function app name
   
These permissions can also be granted using role based access controls.

#### 2.1.3 Generate certificate in Azure Key Vault

Generate an encryption certificate in Azure Key Vault. The public key is configured in your External ID app registration, while the private key remains in Key Vault and is accessed by your Azure Function using managed identity.

1. In the Azure portal, go to your Key Vault.
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

### 2.2 Host your custom extension

Create an Azure Function that validates user credentials against your legacy identity provider.

> [!IMPORTANT]
> The customer-hosted endpoint configured for the OnPasswordSubmit custom authentication extension must be a customer-managed HTTPS endpoint, typically implemented as an Azure Function. This endpoint is invoked by Microsoft Entra External ID during sign-in to validate the user's password against the legacy identity system and return the migration result.
>
> The URL must not point to Microsoft Graph, a Microsoft Entra service endpoint, or the legacy identity provider's interactive sign-in URL. It must reference the Function App function endpoint that implements your validation logic. You're responsible for securing this endpoint.

#### 2.2.1 Request schema

When sending a request to your custom authentication extension, Entra will include a payload with the following schema. This sample payload includes dummy data for illustration purposes only.

```json
{  
  "type": "microsoft.graph.authenticationEvent.passwordSubmit",  
  "source": "/tenants/aaaabbbb-0000-cccc-1111-dddd2222eeee/applications/00001111-aaaa-2222-bbbb-3333cccc4444",  
  "data": {  
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

The `encryptedPasswordContext` field in the request contains the following claims in encrypted JWE format:

- **user-password**: The password text the user entered at sign-in
- **username**: The sign-in identifier (email/username) the user entered at sign-in  
- **nonce**: A GUID that is unique to the request and must be included in the response for verification

#### 2.2.2 Response schema

Entra expects the response from your custom extension in the below format.  

```json
{  
  "data": {  
    "@odata.type": "microsoft.graph.onPasswordSubmitResponseData",  
    "actions": [  
      {  
        "@odata.type": "microsoft.graph.passwordSubmit.MigratePassword"  
      } 
    ],
    "nonce": "{nonce-value-from-external-id}"
  }  
}  
```
> [!NOTE]
> External ID sends the nonce as a claim in the encryptedPasswordContext from the request payload and expects it in the response from the extension for verification purposes.

Each of the available response actions corresponds to a specific scenario during the authentication process. This table describes the possible response actions and when to use them.

| Response Action  | Scenario  | Entra Behavior |
|---|---|---|
| microsoft.graph.passwordSubmit.MigratePassword  | Password validation succeeds; Entra continues authentication. If password is weak, triggers UpdatePassword flow. | Use when password meets basic validation but fails strength requirements.|
| microsoft.graph.passwordSubmit.UpdatePassword  | Password is correct but weak or expired. | Routes user through password reset flow. |
| microsoft.graph.passwordSubmit.Retry  | Password is incorrect. | Allows user to retry authentication if permitted.|
| microsoft.graph.passwordSubmit.Block  | Authentication must be blocked. | Displays block screen with custom message provided by the app.|

#### 2.2.3 Template code

You can use your own code or deploy the following sample Azure Function to your Azure environment. This example function demonstrates how to:
- Retrieve the encryption certificate from Key Vault using managed identity
- Decrypt the password payload
- Validate credentials against your legacy identity provider
- Return appropriate response actions

> [!NOTE]
> **Required packages**: This function requires the following NuGet packages:
> - **Azure.Identity** (version 1.12.0 or later)
> - **Azure.Security.KeyVault.Secrets** (version 4.6.0 or later)
> - **Jose-jwt** (for JWT decryption)
> - **Newtonsoft.Json** (for JSON parsing)
>
> **Required application settings**:
> - **KeyVaultUrl**: Your Key Vault URL (e.g., `https://your-keyvault-name.vault.azure.net/`)
> - **CiamJitMigrationEncryptionCertName**: The name of your certificate in Key Vault (e.g., `JitMigrationEncryptionCert`)

``` csharp
using Jose;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;

namespace dev_functions
{
    public static class JitMigrationEndpoint
    {
        #region Configuration Constants

        /// <summary>
        /// Static cache for RSA private key retrieved from Key Vault
        /// </summary>
        private static RSA _cachedRsa = null;
        private static readonly object _lockObject = new object();

        /// <summary>
        /// Key Vault URL from environment configuration (fetches the environment variable from local.settings.json)
        /// </summary>
        private static readonly string KeyVaultUrl =
            Environment.GetEnvironmentVariable("KeyVaultUrl");

        /// <summary>
        /// Certificate name in Key Vault (fetches the environment variable from local.settings.json)
        /// </summary>
        private static readonly string CertificateName =
            Environment.GetEnvironmentVariable("CiamJitMigrationEncryptionCertName");

        #endregion

        /// <summary>
        /// Retrieves RSA private key from Key Vault certificate stored as secret with caching
        /// </summary>
        private static async Task<RSA> GetRsaFromKeyVaultAsync(ILogger log)
        {
            // Return cached RSA if available
            if (_cachedRsa != null)
            {
                log.LogDebug("Using cached RSA private key");
                return _cachedRsa;
            }

            // Thread-safe retrieval
            lock (_lockObject)
            {
                // Double-check after acquiring lock
                if (_cachedRsa != null)
                    return _cachedRsa;

                try
                {
                    log.LogInformation($"Retrieving certificate '{CertificateName}' from Key Vault");

                    // Validate configuration
                    if (string.IsNullOrEmpty(KeyVaultUrl))
                    {
                        throw new InvalidOperationException(
                            "KeyVaultUrl environment variable is not configured"
                        );
                    }

                    if (string.IsNullOrEmpty(CertificateName))
                    {
                        throw new InvalidOperationException(
                            "CiamJitMigrationEncryptionCertName environment variable is not configured"
                        );
                    }

                    // Use DefaultAzureCredential for authentication
                    var credential = new DefaultAzureCredential();
                    var secretClient = new SecretClient(new Uri(KeyVaultUrl), credential);

                    // Retrieve the certificate stored as a secret (synchronous for thread safety in lock)
                    KeyVaultSecret secret = secretClient.GetSecret(CertificateName);

                    if (string.IsNullOrEmpty(secret.Value))
                    {
                        throw new InvalidOperationException("Secret value is empty");
                    }

                    // Secret value is base64-encoded certificate (PFX/PKCS12)
                    byte[] certBytes = Convert.FromBase64String(secret.Value);

                    // Load certificate with private key
                    X509Certificate2 certificate = new X509Certificate2(
                        certBytes,
                        (string)null, // No password
                        X509KeyStorageFlags.MachineKeySet | X509KeyStorageFlags.Exportable
                    );

                    if (!certificate.HasPrivateKey)
                    {
                        throw new InvalidOperationException(
                            "Certificate does not contain a private key"
                        );
                    }

                    // Extract RSA private key
                    _cachedRsa = certificate.GetRSAPrivateKey();

                    if (_cachedRsa == null)
                    {
                        throw new InvalidOperationException(
                            "Failed to extract RSA private key from certificate"
                        );
                    }

                    log.LogInformation("RSA private key retrieved and cached successfully");
                    return _cachedRsa;
                }
                catch (Exception ex)
                {
                    log.LogError($"Failed to retrieve certificate from Key Vault: {ex.Message}");
                    log.LogError($"Stack trace: {ex.StackTrace}");
                    throw;
                }
            }
        }

        /// <summary>
        /// Main Azure Function entry point for handling JIT migration requests
        /// </summary>
        /// <param name="req">The HTTP request from Entra External ID</param>
        /// <param name="log">Logger instance for tracking execution</param>
        /// <returns>Action result containing the migration response</returns>
        [FunctionName("JitMigrationEndpoint")]
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
                var userInfo = await ParseRequestAsync(req, log);

                if (userInfo == null)
                {
                    log.LogError("Failed to parse user information from request.");
                    return new BadRequestObjectResult("Failed to parse request body.");
                }

                if (string.IsNullOrEmpty(userInfo.UserId))
                {
                    log.LogError("User ID is missing from the request.");
                    return new BadRequestObjectResult("User ID is required in the authentication context.");
                }

                if (string.IsNullOrEmpty(userInfo.Password))
                {
                    log.LogError("User password is missing from the request.");
                    return new BadRequestObjectResult("User password is required for migration.");
                }

                // Process the response based on legacy system validation
                ResponseContent response = await ProcessResponse(req, userInfo.UserId, userInfo.Password, userInfo.Nonce, log);

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
        /// Parses the incoming request to extract user information including ID, email, password, and nonce
        /// </summary>
        private static async Task<PasswordSubmitUserInfo> ParseRequestAsync(HttpRequest req, ILogger log)
        {
            log.LogInformation($"Parsing request from URL: {req.Path}{req.QueryString}");

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            if (string.IsNullOrWhiteSpace(requestBody))
            {
                log.LogError("Request body is empty or whitespace.");
                return null;
            }

            try
            {
                JObject jObject = JObject.Parse(requestBody);
                log.LogDebug($"Parsed request body: {jObject}");

                // Extract user information from authentication context
                string userId = jObject["data"]?["authenticationContext"]?["user"]?["id"]?.ToString();
                string email = jObject["data"]?["authenticationContext"]?["user"]?["mail"]?.ToString();
                string userPrincipalName = jObject["data"]?["authenticationContext"]?["user"]?["userPrincipalName"]?.ToString();

                // Handle both encrypted and plain text password contexts
                string encryptedPasswordContext = jObject["data"]?["encryptedPasswordContext"]?.ToString();

                (string userPassword, string nonce) = await ExtractPasswordAndNonce(encryptedPasswordContext, log);

                log.LogInformation($"Extracted User Info - UserId: {userId}, Email: {email}, UPN: {userPrincipalName}");

                return new PasswordSubmitUserInfo
                {
                    UserId = userId,
                    Email = email,
                    UserPrincipalName = userPrincipalName,
                    Password = userPassword,
                    Nonce = nonce
                };
            }
            catch (JsonReaderException ex)
            {
                log.LogError($"Failed to parse request body as JSON: {ex.Message}");
                return null;
            }
        }

        /// <summary>
        /// Extracts password and nonce from encrypted password context using Key Vault certificate
        /// </summary>
        private static async Task<(string password, string nonce)> ExtractPasswordAndNonce(
            string encryptedContext,
            ILogger log
        )
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
                    // Get RSA private key from Key Vault (cached after first call)
                    rsa = await GetRsaFromKeyVaultAsync(log);
                    log.LogDebug("RSA private key obtained from Key Vault successfully");
                }
                catch (Exception ex)
                {
                    log.LogError($"Failed to retrieve RSA key from Key Vault: {ex.Message}");
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

                JObject payloadObj;
                try
                {
                    // Parse the decrypted JSON payload
                    log.LogDebug("Parsing decrypted JSON payload");
                    string jsonPayload = Jose.JWT.Decode(decryptedPayload, null, JwsAlgorithm.none);
                    payloadObj = JObject.Parse(jsonPayload);
                    log.LogDebug("JSON payload parsed successfully");
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

        /// <summary>
        /// Data Transfer Object containing user information extracted from password submit request
        /// </summary>
        public class PasswordSubmitUserInfo
        {
            /// <summary>
            /// The user's unique identifier from the authentication context
            /// </summary>
            public string UserId { get; set; }

            /// <summary>
            /// The user's email address from the authentication context
            /// </summary>
            public string Email { get; set; }

            /// <summary>
            /// The user's User Principal Name from the authentication context
            /// </summary>
            public string UserPrincipalName { get; set; }

            /// <summary>
            /// The user's password extracted from the encrypted context
            /// </summary>
            public string Password { get; set; }

            /// <summary>
            /// The nonce value from the encrypted context
            /// </summary>
            public string Nonce { get; set; }
        }

        #endregion
    }
}
```

#### 2.2.4 Deploy your function

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

## 3. Configure custom extension application

Create an application registration to represent your custom authentication extension and configure it with the encryption certificate.

### 3.1 Create EEID Auth extension application

Create an application registration to represent your custom authentication extension. This application will authenticate calls between Microsoft Entra External ID and your Azure Function. For general guidance on app registrations, see [Register an application](/entra/identity-platform/quickstart-register-app).

Register a new application in the [Microsoft Entra admin center](https://entra.microsoft.com/) with the following settings:

- **Name**: Enter a descriptive name for your JIT migration extension
- **Supported account types**: Accounts in this organizational directory only

#### 3.1.1 Create identifier URI

The identifier URI uniquely identifies your custom authentication extension API. Add the following to your application manifest, replacing the placeholders with your values:

```json
"identifierUris": [  
    "api://[Function_URL_Hostname]/[App_ID]"  
], 
```

- **Function_URL_Hostname**: The hostname of your Azure Function (e.g., `contoso.azurewebsites.net`)
- **App_ID**: Your application (client) ID from the app registration **Overview** page

For example: `"api://contoso.azurewebsites.net/12345678-1234-1234-1234-123456789012"`

#### 3.1.2 API permissions

Your custom authentication extension requires the `CustomAuthenticationExtension.Receive.Payload` application permission to receive HTTP requests from authentication events. To set this permission follow these steps:

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), navigate to **Entra ID** > **App registrations** and select your custom authentication extension application.
1. Go to **API permissions** > **Add a permission**.
1. Select **Microsoft Graph** > **Application permissions**.
1. Search for **CustomAuthenticationExtension.Receive.Payload**, select it and click **Add permissions**.
1. Finally, click **Grant admin consent for [Your Tenant]** to grant the permission.

### 3.2 Configure encryption key

Configure the certificate's public key so that External ID can encrypt the password payload before sending it to your custom extension.

#### 3.2.1 Export the public key

1. In your Key Vault, under **Certificates**, select **JitMigrationEncryptionCert**.
1. Select the current version (shown as a GUID).
1. Select **Download in CER format**.
1. Save the file (for example, `jitmigrationencryptioncert.cer`).
1. Open PowerShell.
1. Run the following commands, replacing the file path with your certificate location:

   ```powershell
   $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2("{path-to-your-cer-file}\jitmigrationencryptioncert.cer")
   $certBase64 = [Convert]::ToBase64String($cert.RawData)
   $certBase64
   ```

1. Copy the base64-encoded public key from the output.

#### 3.2.2 Add the key to the application

Use Microsoft Graph API to configure the certificate on your custom authentication extension app registration. Make sure that you use the same GUID for both `keyId` and `tokenEncryptionKeyId`.
Make a PATCH request with the following information:

Replace the placeholders with your values:
- `{object-id}`: Your custom authentication extension app's object ID (not the application ID).
- `{end-date}`: Certificate expiration date (for example, `2026-11-25T17:44:47Z`).
- `{key-guid}`: A new GUID. You can generate one using PowerShell: `[guid]::NewGuid()`.
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
      "keyId": "{key-guid}",
      "startDateTime": "{start-date}",
      "type": "AsymmetricX509Cert",
      "usage": "Encrypt",
      "key": "{base64-encoded-public-key}",
      "displayName": "CN=JitMigration"
    }
  ],
  "tokenEncryptionKeyId": "{key-guid}"
}
```

This configuration tells External ID to use the public key when encrypting the password context for your custom extension.

### 3.3 Custom Extension policy

Create a custom extension policy that defines how the JIT migration process will be executed during user sign-in. This policy will invoke your custom authentication application during the sign-in process.

Use the following example to create a custom extension policy using Microsoft Graph API:

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

## 4. Cutover the legacy app to External ID

After configuring your custom authentication extension, prepare for production cutover by registering your client application and creating the listener policy that activates JIT migration.

### 4.1 Create the app

Register a client application for testing the JIT migration process. This application will trigger the custom authentication extension during sign-in. For detailed instructions on registering applications, see [Quickstart: Register an application](/entra/identity-platform/quickstart-register-app).

Register a new web application with these JIT migration-specific settings:

- **Redirect URI**: Set to `https://jwt.ms` (Web platform) for testing
- **Authentication**: Enable **ID tokens** under implicit grant and hybrid flows
- **API Permissions**: Grant admin consent for **User.Read** (delegated Microsoft Graph permission). Even if the permission already exists, re-granting consent is necessary for proper configuration.

> [!TIP]
> You can use an existing application registration if you have one configured for testing.

### 4.2 Create the listener policy

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

## 5. Test and validate before deploying to production

Before deploying JIT migration to production, thoroughly test the implementation to ensure it works correctly and securely.

Consider the following testing checklist:

- **Test with a subset of users**: Start with a small group of test users before migrating your entire user base.
- **Verify credential validation**: Ensure your Azure Function correctly validates credentials against your legacy identity provider.
- **Check migration flag updates**: Confirm that the migration flag is set to `false` after successful migration.
- **Test different response actions**: Verify that all response actions (MigratePassword, UpdatePassword, Retry, Block) work as expected.
- **Monitor Azure Function logs**: Review logs to identify any errors or issues during the authentication process.
- **Validate encryption**: Ensure that passwords are encrypted end-to-end and never exposed in logs or error messages.

## Frequently asked questions

### Which URL should I use for the OnPasswordSubmit custom authentication extension?

Use a customer-hosted HTTPS endpoint, typically an Azure Function, that validates the password against the legacy identity system. The URL must not reference Microsoft Graph, a Microsoft Entra service, or the legacy identity provider's interactive sign-in endpoint. It must point to your Function App function endpoint that implements the validation logic.

### Why do on-premises attributes appear in the user schema?

External ID uses the shared Microsoft Entra user model, which includes on-premises attributes. In External ID, these attributes are read-only and aren't used for identity matching or write-back during JIT password migration. User resolution occurs earlier in the sign-in flow using configured sign-in identifiers such as UPN or email.

### Where should I deploy JIT migration components?

Deploy JIT migration components in a secure identity subscription with limited RBAC. Tightly control administrative access to prevent unauthorized changes to customer-hosted authentication logic. This separation helps protect the authentication flow and user accounts from compromise.

## Next steps

- [Learn how to migrate users to Microsoft Entra External ID](how-to-migrate-users.md)
- [Custom authentication extensions overview](/graph/api/resources/customauthenticationextension)
- [Secure Azure Functions](/azure/azure-functions/security-concepts)
- [Azure Key Vault documentation](/azure/key-vault/)

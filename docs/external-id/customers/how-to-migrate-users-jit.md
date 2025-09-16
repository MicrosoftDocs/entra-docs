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

Just-In-Time (JIT) password migration is a common method to migrate user credentials. This approach allows users to continue using their existing passwords without requiring an immediate password reset or bulk migration of password hashes. Users are prompted to enter their passwords when they sign in, and the system validates the password against the legacy identity provider. If the password is valid, it is then securely stored in External ID for future use.

> [!Note]
> If you have access to user passwords, either at REST or runtime, in your legacy system, you can also proactively populate these. For more information, see [Learn how to migrate users to Microsoft Entra External ID](how-to-migrate-users.md).

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](../includes/active-directory-b2c-end-of-sale-notice.md)]

## Overview of the JIT migration process

JIT migration works by invoking a custom API during the sign-in process to validate user credentials against the legacy identity provider. Entra External ID supports this process by using custom authentication extensions to facilitate the integration. These extensions allow you to define custom logic that runs during the authentication process, enabling you to interact with external systems and perform additional processing as part of the sign-in flow.

When a user enters a password during sign in and their account is marked as not having been migrated yet, the password is sent to an external API endpoint specified by the admin. The external API validates the password against the legacy identity provider. If the password is valid, the API responds with a success message, and the password is securely stored in External ID. The user's account is then marked as migrated, allowing them to sign in seamlessly in the future.

## Define an extension attribute

To implement JIT migration, you first need to define an extension attribute in your External ID tenant to track the migration status of each user. This attribute will indicate whether a user's credentials have been migrated from the legacy identity provider.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Navigate to **External Identities**, then click on **Custom user attributes**.
1. Enter a unique name for the attribute, such as `isMigrated`, and select the data type as **Boolean**.
1. Click **Create** to add the attribute to your directory.

You can also create a custom extension using Graph API. To learn more, see [Add custom data to resources by using extensions](/graph/extensibility-overview).

## Get the extension attribute ID

After creating the extension attribute, you need to retrieve its unique identifier to use it in your custom authentication extension. The extension attribute ID is required to read and update the migration status of users during the authentication process. It's a combination of an application id and the attribute name.

1. Navigate to **Entra ID** and then **App registrations** in the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Choose **All applications** from above the the application list.
1. Select the application named `b2c-extensions-app` and copy the **Application (client) ID** value without hyphens. This is your application id.
1. Your extension attribute id is in the format `extension_[application-id]_[attribute-name]`. For example, if your application id is `00001111-aaaa-2222-bbbb-3333cccc4444` and your attribute name is `isMigrated`, your extension attribute id would be `extension_00001111aaaa2222bbbb3333cccc4444_isMigrated`.

## Create a custom authentication extension

Next, create a custom authentication extension that will be invoked during the sign-in process to validate user credentials against the legacy identity provider. 

You can use your own code or deploy the following sample Azure Function to your Azure environment. Make sure to replace the placeholders for *client ID*, *client secret*, *tenant ID*, and *extension attribute* with values from your tenants. This example function simulates the validation process and demonstrates how to handle different response actions, including migrating the password, blocking the sign-in, prompting for a password update, or retrying the authentication based on the outcome of the validation.

``` csharp
using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Collections.Generic;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json.Linq;
using System.Net.Http;
using System.Net.Http.Headers;

namespace diadabal_functions
{
    public static class JitMigrationEndpoint
    {
        private static ResponseActionType lastResponseActionType = ResponseActionType.MigratePassword;

        [FunctionName("JitMigrationEndpoint")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)]
            HttpRequest req,
            ILogger log)
        {
            string httpMethod = req.Method;
            log.LogInformation($"C# HTTP trigger function processed a request.HTTP method used: {httpMethod}");
            if (httpMethod == "GET")
            {
                log.LogInformation("GET request received. Returning 200 OK.");
                return new OkResult();
            }

            if (req.Body == null || req.Body.Length == 0)
            {
                return new BadRequestResult();
            }
            
            var (userId, userPassword) = await ParseRequest(req, log);

            // Validate credentials and get the response action type
            ResponseContent response = ProcessResponse(req, log);
            if (response.data.Actions.TrueForAll(action => action.Odatatype.Equals("microsoft.graph.passwordsubmit.MigratePassword")))
            {
                log.LogInformation("Response action type is MigratePassword. Proceeding with user migration.");
                using var client = new HttpClient();
                var accessToken = await FetchAccessTokenWithClientCredentialsAsync(log, client);
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
                await UpdateUserPasswordAsync(log, userId, userPassword, client);
            }
            else
            {
                log.LogInformation($"Response action type is {response.data.Actions[0].Odatatype}. No migration needed.");
            }

            return new OkObjectResult(response);
        }

        private static ResponseContent ProcessResponse(HttpRequest req, ILogger log)
        {
            // Response Action is read from query params to control the behavior dynamically.
            // However, when no input via query param is provided, then the fallsback to random response
            req.Query.TryGetValue("responseActionType", out StringValues responseActionValue);
            ResponseActionType responseActionType;
            if (StringValues.IsNullOrEmpty(responseActionValue))
            {
                responseActionType = GetNextResponseActionType(log);
            }
            else
            {
                log.LogInformation($"Parsed response action type from query: {responseActionValue.ToString()}");
                Enum.TryParse(responseActionValue, out responseActionType);
            }

            ResponseContent response = new ResponseContent(responseActionType);
            log.LogInformation($"EventAction Odata type returned: {response.data.Actions[0].Odatatype}");
            return response;
        }

        private static ResponseActionType GetNextResponseActionType(ILogger log)
        {
            log.LogInformation($"Generating next response action type. Last response action type: {lastResponseActionType}");
            var values = Enum.GetValues(typeof(ResponseActionType));
            int nextIndex = (Array.IndexOf(values, lastResponseActionType) + 1) % values.Length;
            lastResponseActionType = (ResponseActionType)values.GetValue(nextIndex)!;
            return lastResponseActionType;
        }

        private static async Task<(string userId, string userPassword)> ParseRequest(HttpRequest req, ILogger log)
        {
            log.LogInformation($"Request URL: {req.Path}/{req.QueryString}");
            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            JObject jObject = JObject.Parse(requestBody);
            requestBody = jObject.ToString();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            log.LogInformation($"data: {(data == null ? "No data" : data.ToString())}");

            string userId = jObject["data"]?["authenticationContext"]?["user"]?["id"]?.ToString();
            string userPassword = jObject["data"]?["passwordContext"]?["userPassword"]?.ToString();
            
            return (userId, userPassword);
        }

        private static async Task<string> FetchAccessTokenWithClientCredentialsAsync(ILogger log, HttpClient client)
        {
            // Acquire access token using client credentials flow
            log.LogTrace("Acquiring access token using client credentials...");
            var values = new Dictionary<string, string>
            {
                { "client_id", "{clientid}" },
                { "client_secret", "{secret}" },
                { "scope", "https://graph.microsoft.com/.default" },
                { "grant_type", "client_credentials" }
            };
            var content = new FormUrlEncodedContent(values);
            var response = await client.PostAsync("https://login.microsoftonline.com/{tenantid}/oauth2/v2.0/token", content);
            if (!response.IsSuccessStatusCode)
            {
                string errorResponse = await response.Content.ReadAsStringAsync();
                log.LogError($"Error: {response.StatusCode}, Details: {errorResponse}");
                return null;
            }

            string responseString = await response.Content.ReadAsStringAsync();
            var jsonResponse = JObject.Parse(responseString);
            var token = jsonResponse["access_token"];
            if (token == null)
            {
                log.LogError($"Error: Access token not found in the response: {responseString}");
                return null;
            }
            log.LogInformation($"Access token: {token.ToString()}");
            return token.ToString();
        }

        private static async Task UpdateUserPasswordAsync(ILogger log, string userId, string userPassword, HttpClient client)
        {
            var passwordPatchContent = new StringContent(
                $"{{\"passwordProfile\": {{\"forceChangePasswordNextSignIn\": false, \"forceChangePasswordNextSignInWithMfa\": false, \"password\": \"{userPassword}\"}}, \"{extension_attribute}\": false}}",
                System.Text.Encoding.UTF8,
                "application/json");
            var patchUrl = $"https://graph.microsoft.com/v1.0/users/{userId}";
            log.LogInformation($"Patch User Url: {patchUrl}, content: {passwordPatchContent.ReadAsStringAsync().Result}");
            var passwordPatchResponse = await client.PatchAsync(patchUrl, passwordPatchContent);
            if (!passwordPatchResponse.IsSuccessStatusCode)
            {
                string patchErrorResponse = await passwordPatchResponse.Content.ReadAsStringAsync();
                var jsonResponse = JObject.Parse(patchErrorResponse);
                log.LogError($"Password PATCH Error: {passwordPatchResponse.StatusCode}, Details: {jsonResponse}");
            }
        }

        public class ResponseContent
        {
            [JsonProperty("data")] public Data data { get; set; }

            public ResponseContent(ResponseActionType actionType)
            {
                data = new Data(actionType);
            }
        }

        public class Data
        {
            [JsonProperty("@odata.type")]
            public string Odatatype { get; set; }

            public List<Action> Actions { get; }

            public Data(ResponseActionType actionType)
            {
                Odatatype = "microsoft.graph.onPasswordSubmitResponseData";
                Actions = new List<Action> { new(actionType) };
            }
        }

        public class Action
        {
            [JsonProperty("@odata.type")]
            public string Odatatype { get; set; }

            [JsonProperty("title", DefaultValueHandling = DefaultValueHandling.Ignore)]
            public string title { get; set; }

            [JsonProperty("message", DefaultValueHandling = DefaultValueHandling.Ignore)]
            public string message { get; set; }

            public Action(ResponseActionType actionType)
            {
                Odatatype = actionType switch
                {
                    ResponseActionType.MigratePassword => "microsoft.graph.passwordsubmit.MigratePassword",
                    ResponseActionType.Block => "microsoft.graph.passwordsubmit.Block",
                    ResponseActionType.UpdatePassword => "microsoft.graph.passwordsubmit.UpdatePassword",
                    ResponseActionType.Retry => "microsoft.graph.passwordsubmit.Retry",
                    _ => throw new ArgumentOutOfRangeException(nameof(actionType), actionType, null)
                };
                title = actionType switch
                {
                    ResponseActionType.Block => "Sign-in blocked",
                    _ => null
                };
                message = actionType switch
                {
                    ResponseActionType.Block => "Admin has blocked your sign-in attempt. Please contact support.",
                    _ => null
                };
            }
        }

        public enum ResponseActionType
        {
            MigratePassword,
            UpdatePassword,
            Block,
            Retry,
        }
    }
}
```
Each of the response actions corresponds to a specific scenario during the authentication process. This table describes the possible response actions and when to use them.

| Action odataType  | When to Use  | Notes |
|---|---|---|
| microsoft.graph.passwordSubmit  .MigratePassword  | When password validation is successful.   | Upon receiving this action, Entra will continue with the authentication process.  Note that when the submitted password is considered weak by Entra standards, then an UpdatePassword flow is triggered.  |
| microsoft.graph.passwordSubmit  .UpdatePassword  | When the password is correct, but the user needs to update the password (e.g., it is weak or expired.)  | Entra will route the user through a reset password flow.  |
| microsoft.graph.passwordSubmit  .Retry  | When the password is incorrect.  | Let the user retry the authentication process, if allowed.  |
| microsoft.graph.passwordSubmit  .Block  | When to block the authentication and return a custom error to the user.  | Shows a block screen to the user with the custom message provided.  |

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

## Register the custom authentication application

Next, create an application in your External ID tenant. This application will represent the custom authentication extension and will be used to configure the extension policy.

1. Navigate to **Entra ID** and then **App registrations** in the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Click on **New registration**.
1. Enter a unique name for your application.
1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. Click **Register** to create the application.

As part of the registration process, you also need to configure the application's manifest to define the necessary properties for the custom authentication extension. Specifically, you need to add a value to identify your API endpoint and additional permissions required by the application.

1. Under the **Manage** section, select **Manifest**.
1. Search the **App Manifest** for *identifierURIs* add the value for your API endpoint as shown in the example below by replacing *Function_URL_Hostname* and *App_ID* with your own values.

```json
"identifierUris": [  
    "api://[Function_URL_Hostname]/[App_ID]"  
], 
```

Your *Function_URL_Hostname* is the host name for the custom extension. For example if the full URL is `https://contoso.onmicrosoft.com/api/JitMigrationEndpoint`,the hostname would be `contoso.onmicrosoft.com`. Your *App_ID* is the application ID from the application you just registered. You can find the application ID on the application's **Overview** page.

Next you need to update the value for *requiredResourceAccess* to include the permissions your application requires. In this case you will be adding the *CustomAuthenticationExtension.Receive.Payload* permission which allows the extension to receive HTTP requests triggered by authentication events. You can find more information on these permissions in the [Microsoft Graph permissions reference](/graph/permissions-reference).

1. In the **App Manifest**, locate the *requiredResourceAccess* section.
1. Add a new entry for Microsoft Graph with the necessary permissions. 

```json
"requiredResourceAccess": [  
    {  
        "resourceAppId": "00000003-0000-0000-c000-000000000000",  
        "resourceAccess": [  
            {  
                "id": "214e810f-fda8-4fd7-a475-29461495eb00",  
                "type": "Role"  
            }  
        ]  
    }  
]  
```

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

Next, to test the migration process you need to register a client web application. This application will simulate user sign-in and trigger the custom authentication extension.

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

## Next steps




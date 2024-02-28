---
title: Test authentication events token augmentation using Postman
description: Create an Azure function app using the authentication events trigger for Azure Functions for .NET library and test it using Postman.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 08/16/2023 
ms.reviewer: stsoneff
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As an app developer, I want to use Postman to test out the token augmentation of my Azure Function. I want to be able to see the standard claims and custom claims that are added to the token.
---

# Test authentication events token augmentation using Postman

In this how-to guide, you'll test token augmentation in an Azure function app that uses the authentication events trigger for Azure Functions client library for .NET. Using an existing function app, you'll test the token augmentation using Postman.

## Prerequisites

- [Postman](https://www.postman.com/downloads/)
- An Azure function app that uses the authentication events trigger for Azure Functions client library for .NET. You can use the function generated in step 1 of the [Create an Azure function app using the authentication events trigger for Azure Functions for .NET library](./auth-events-trigger.md) or an app that you've created.
- An IDE of your choice.

## Turn off token validation for testing purposes

You can use Postman to test the token augmentation of your Azure Function. To do this, you need to turn off token validation for development purposes. It's important to turn token validation back on before deploying your function to production. 

In your IDE, find the *local.settings.json* file and add the `AuthenticationEvents__BypassTokenValidation` parameter. Set the value to `true`. This will bypass the token validation steps. Your 

```json
{
    "IsEncrypted": false,
    "Values": {
        "AzureWebJobsStorage": "AzureWebJobsStorageConnectionStringValue",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet",
        "AuthenticationEvents__BypassTokenValidation": true
    }
}
```

## Test the function using Postman

With the token validation turned off, you can now test the function locally using Postman. This section shows you how to

1. Open Postman and select **Post** from the left dropdown. Paste in the Function url you copied earlier.
1. Under the main bar, select **Body**, then **raw**, and paste in the following JSON. Modify the values as needed.

    ```json
    {
        "type": "microsoft.graph.authenticationEvent.tokenIssuanceStart",
        "source": "/tenants/{Enter tenant ID here}/applications/{Enter test JWT app ID here}",
        "data": {
            "@odata.type": "microsoft.graph.onTokenIssuanceStartCalloutData",
            "tenantId": "Enter tenant ID here",
            "authenticationEventListenerId": "Enter authentication event listener ID here", ## What is this corresponding to?
            "customAuthenticationExtensionId": "Enter custom authentication extension ID here",
            "authenticationContext": {
                "correlationId": "Enter correlation ID here", ## Do we know this?
                "client": {
                    "ip": "Enter client IP here", ##
                    "locale": "en-us",
                    "market": "en-us"
                },
                "protocol": "OAUTH2.0",
                "clientServicePrincipal": {
                    "id": "Enter correlation ID here", ##
                    "appId": "Enter test JWT app ID here", ##
                    "appDisplayName": "Enter test JWT app display name here", ##
                    "displayName": "Enter test JWT app display name here" ##
                },
                "user": {
                    "createdDateTime": "2023-08-16T00:00:00Z",
                    "displayName": "Enter user display name here", ##
                    "givenName": "Enter user given name here", ##
                    "id": "Enter user ID here", ##
                    "mail": "Enter user email here", ##
                    "preferredLanguage": "en-us",
                    "surname": "Enter user surname here", ##
                    "userPrincipalName": "Enter user principal name here", ##
                    "userType": "Member"
                }
            }
        }
    }
    ```

1. Select **Send**. 
1. You should receive a similar output to the following JSON.

    ```json
    {
        "data": {
            "@odata.type": "microsoft.graph.onTokenIssuanceStartResponseData",
            "actions": [
                {
                    "@odata.type": "microsoft.graph.tokenIssuanceStart.provideClaimsForToken",
                    "claims": {
                        "dateOfBirth": "01/01/2000",
                        "customRoles": [
                            "Writer",
                            "Editor" ## What about nested Json?
                        ]
                    }
                }
    
            ]
        }
    }
    ```

This confirms that the function is working as expected. You can now close Postman and continue to deploy your function to Azure.

## Next step

> [!div class="nextstepaction"]
> [Authentication events trigger for Azure Functions](./auth-events-trigger.md)
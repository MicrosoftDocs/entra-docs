---
title: Troubleshoot a custom authentication extension
description: Troubleshoot and monitor your custom claims provider API.  Learn how to use logging and Microsoft Entra sign-in logs to find errors and issues in your custom claims provider API.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 04/10/2024
ms.reviewer: jasuri
ms.service: identity-platform
ms.topic: troubleshooting
titleSuffix: Microsoft identity platform
ms.custom: sfi-image-nochange
#Customer intent: As a developer integrating external systems with Microsoft Entra ID, I want to troubleshoot issues with my custom authentication extension, so that I can identify and resolve any errors or performance problems affecting the authentication experience.
---

# Troubleshoot your custom authentication extension

Authentication events and [custom claims providers](custom-claims-provider-overview.md) allow you to customize the Microsoft Entra authentication experience by integrating with external systems.  For example, you can create a custom claims provider API and configure an [OpenID Connect app](./custom-extension-tokenissuancestart-configuration.md) to receive tokens with claims from an external store.

## Error behavior

When an API call fails, the error behavior is as follows:

- For OpenId Connect apps - Microsoft Entra ID redirects the user back to the client application with an error. A token isn't minted.
- For SAML apps -  Microsoft Entra ID shows the user an error screen in the authentication experience. The user isn't redirected back to the client application.

The error code sent back to the application or the user is generic. To troubleshoot, check the [sign-in logs](#microsoft-entra-sign-in-logs) for the [error codes](#error-codes-reference).

## Logging

In order to troubleshoot issues with your custom claims provider REST API endpoint, the REST API must handle logging. Azure Functions and other API-development platforms provide in-depth logging solutions. Use those solutions to get detailed information on your APIs behavior and troubleshoot your API logic.

## Microsoft Entra sign-in logs


You can also use [Microsoft Entra sign-in logs](~/identity/monitoring-health/concept-sign-ins.md) in addition to your REST API logs, and hosting environment diagnostics solutions. Using Microsoft Entra sign-in logs, you can find errors, which may affect the users' sign-ins. The Microsoft Entra sign-in logs provide  information about the HTTP status, error code, execution duration, and number of retries that occurred the API was called by Microsoft Entra ID.

Microsoft Entra sign-in logs also integrate with [Azure Monitor](/azure/azure-monitor/). You can set up alerts and monitoring, visualize the data, and integrate with security information and event management (SIEM)  tools. For example, you can set up notifications if the number of errors exceed a certain threshold that you choose.

To access the Microsoft Entra sign-in logs:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Select **Sign-in logs**, and then select the latest sign-in log.
1. For more details, select the **Authentication Events** tab. Information related to the custom authentication extension REST API call is displayed, including any [error codes](#error-codes-reference).

    :::image type="content" source="media/custom-extension-troubleshoot/authentication-events.png" alt-text="Screenshot that shows the authentication events information." lightbox="media/custom-extension-troubleshoot/authentication-events-expanded.png":::

## Error codes reference

Use the following table to diagnose an error code.

|Error code |Error name |Description |
|----|----|----|
|1003000 | EventHandlerUnexpectedError | There was an unexpected error when processing an event handler.|
|1003001 | CustomExtensionUnexpectedError | There was an unexpected error while calling a custom extension API.|
|1003002 | CustomExtensionInvalidHTTPStatus | The custom extension API returned an invalid HTTP status code. Check that the API returns an accepted status code defined for that custom extension type.|
|1003003 | CustomExtensionInvalidResponseBody | There was a problem parsing the custom extension's response body. Check that the API response body is in an acceptable schema for that custom extension type.|
|1003004 | CustomExtensionThrottlingError | There are too many custom extension requests. This exception is thrown for custom extension API calls when throttling limits are reached.|
|1003005 | CustomExtensionTimedOut | The custom extension didn't respond within the allowed timeout. Check that your API is responding within the configured timeout for the custom extension. It can also indicate that the access token is invalid. Follow the steps to [call your REST API directly](#call-your-rest-api-directly). |
|1003006 | CustomExtensionInvalidResponseContentType | The custom extension's response content-type isn't 'application/json'.|
|1003007 | CustomExtensionNullClaimsResponse | The custom extension API responded with a null claims bag.|
|1003008 | CustomExtensionInvalidResponseApiSchemaVersion | The custom extension API didn't respond with the same apiSchemaVersion that it was called for.|
|1003009 | CustomExtensionEmptyResponse | The custom extension API response body was null when that wasn't expected.|
|1003010 | CustomExtensionInvalidNumberOfActions | The custom extension API response included a different number of actions than those supported for that custom extension type.|
|1003011 | CustomExtensionNotFound | The custom extension associated with an event listener couldn't be found.|
|1003012 | CustomExtensionInvalidActionType | The custom extension returned an invalid action type defined for that custom extension type.|
|1003014 | CustomExtensionIncorrectResourceIdFormat | The *identifierUris* property in the manifest for the application registration for the custom extension, should be in the format of "api://{fully qualified domain name}/{appid}.|
|1003015 | CustomExtensionDomainNameDoesNotMatch | The targetUrl and resourceId of the custom extension should have the same fully qualified domain name.|
|1003016 | CustomExtensionResourceServicePrincipalNotFound | The appId of the custom extension resourceId should correspond to a real service principal in the tenant.|
|1003017 | CustomExtensionClientServicePrincipalNotFound | The custom extension resource service principal is not found in the tenant.|
|1003018 | CustomExtensionClientServiceDisabled | The custom extension resource service principal is disabled in this tenant.|
|1003019 | CustomExtensionResourceServicePrincipalDisabled | The custom extension resource service principal is disabled in this tenant.|
|1003020 | CustomExtensionIncorrectTargetUrlFormat | The target URL is in an improper format. It must be a valid URL that starts with https.|
|1003021 | CustomExtensionPermissionNotGrantedToServicePrincipal | The service principal doesn't have admin consent for the Microsoft Graph CustomAuthenticationExtensions.Receive.Payload app role (also known as application permission) which is required for the app to receive custom authentication extension HTTP requests.|
|1003022 | CustomExtensionMsGraphServicePrincipalDisabledOrNotFound |The MS Graph service principal is disabled or not found in this tenant.|
|1003023 | CustomExtensionBlocked | The endpoint used for the custom extension is blocked by the service.|
|1003024 | CustomExtensionResponseSizeExceeded | The custom extension response size exceeded the maximum limit.|
|1003025 | CustomExtensionResponseClaimsSizeExceeded | The total size of claims in the custom extension response exceeded the maximum limit.|
|1003026 | CustomExtensionNullOrEmptyClaimKeyNotSupported | The custom extension API responded with claims containing null or empty key'|
|1003027 | CustomExtensionConnectionError | Error connecting to the custom extension API.|

## Call your REST API directly

Your REST API is protected by a Microsoft Entra access token. You can test your API by;
- Obtaining an access token with an [application registration](custom-extension-tokenissuancestart-configuration.md#12-grant-admin-consent) associated with the custom authentication extensions
- Test your API locally using an API testing tool. 

# [API testing tools](#tab/api-testing-tools)

1. For local development and testing purposes, open *local.settings.json* and replace the code with the following JSON: 

    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "",
        "AzureWebJobsSecretStorageType": "files",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet",
        "AuthenticationEvents__BypassTokenValidation" : false
      }
    }
    ```

    > [!NOTE]
    >
    > If you used the [Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/entra/Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents) NuGet package, be sure to set `"AuthenticationEvents__BypassTokenValidation" : true` for local testing purposes.
    >

1. Using your preferred API testing tool, create a new HTTP request and set the **HTTP method** to `POST`.
1. Use the following JSON body that imitates the request Microsoft Entra ID sends to your REST API.

    ```json
    {
        "type": "microsoft.graph.authenticationEvent.tokenIssuanceStart",
        "source": "/tenants/aaaabbbb-0000-cccc-1111-dddd2222eeee/applications/00001111-aaaa-2222-bbbb-3333cccc4444",
        "data": {
            "@odata.type": "microsoft.graph.onTokenIssuanceStartCalloutData",
            "tenantId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
            "authenticationEventListenerId": "11112222-bbbb-3333-cccc-4444dddd5555",
            "customAuthenticationExtensionId": "22223333-cccc-4444-dddd-5555eeee6666",
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

    > [!TIP]
    >
    > If you're using an access token obtained from Microsoft Entra ID, select **Authorization** and then select **Bearer token**, then paste the access token you received from Microsoft Entra ID.

1. Select **Send**, and you should receive a JSON response similar to the following:

    ```json
    {
        "data": {
            "@odata.type": "microsoft.graph.onTokenIssuanceStartResponseData",
            "actions": [
                {
                    "@odata.type": "microsoft.graph.tokenIssuanceStart.provideClaimsForToken",
                    "claims": {
                        "customClaim1": "customClaimValue1",
                        "customClaim2": [
                            "customClaimString1",
                            "customClaimString2" 
                        ]
                    }
                }
    
            ]
        }
    }
    ```

# [Obtain an access token](#tab/obtain-an-access-token)

After you acquire an access token, pass it the HTTP `Authorization` header. To obtain an access token, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **App registrations**.
1. Select the *Azure Functions authentication events API* app registration, previously configured in [configure a custom claim provider for a token issuance event](custom-extension-tokenissuancestart-configuration.md#step-1-register-a-custom-authentication-extension).
1. Copy the [application ID](custom-extension-tokenissuancestart-configuration.md#12-grant-admin-consent).
1. If you haven't created an app secret, follow these steps:
    1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
    1. Add a description for your client secret.
    1. Select an expiration for the secret or specify a custom lifetime.
    1. Select **Add**.
    1. Record the **secret's value** for use in your client application code. This secret value is never displayed again after you leave this page.
1. From the menu, select **Expose an API** and copy the value of the **Application ID URI**. For example, `api://contoso.azurewebsites.net/aaaabbbb-0000-cccc-1111-dddd2222eeee`.
1. Open your preferred API testing tool and create a new HTTP query.
1. Change the **HTTP method** to `POST`.
1. Enter the following URL. Replace the `{tenantID}` with your tenant ID.

    ```http
    https://login.microsoftonline.com/{tenantID}/oauth2/v2.0/token
    ```

1. Under the **Body**, select **form-data** and add the following keys:

    |Key  |Value  |
    |---------|---------|
    |`grant_type`| `client_credentials`|
    |`client_id`| The **Client ID** of your application.|
    |`client_secret`|The **Client Secret** of your application.|
    |`scope`| The **Application ID URI** of your application, then add `.default`. For example, `api://contoso.azurewebsites.net/aaaabbbb-0000-cccc-1111-dddd2222eeee/.default`|

1. Run the HTTP query and copy the `access_token` into the <https://jwt.ms> web app.
1. Compare the `iss` with the issuer name you [configured in your API](custom-extension-tokenissuancestart-configuration.md#step-4-protect-your-azure-function).
1. Compare the `aud` with the client ID you [configured in your API](custom-extension-tokenissuancestart-configuration.md#step-4-protect-your-azure-function).

---

## Common performance improvements

One of the most common issues is that your custom claims provider API doesn't respond within the two-seconds timeout. If your REST API doesn't respond in subsequent retries, then the authentication fails. To improve the performance of your REST API, follow the below suggestions:

1. If your API accesses any downstream APIs, cache the access token used to call these APIs, so a new token doesn't have to be acquired on every execution.
1. Performance issues are often related to downstream services. Add logging, which records the process time to call to any downstream services.
1. If you use a cloud provider to host your API, use a hosting plan that keeps the API always "warm". For Azure Functions, it can be either [the Premium plan or Dedicated plan](/azure/azure-functions/functions-scale).
1. [Run automated integration tests](test-automate-integration-testing.md) for your authentications. You can also use API testing tools to test just your API performance.

## See also

- [Create a REST API with a token issuance start event](custom-extension-tokenissuancestart-setup.md)
- [Custom claims provider reference](custom-claims-provider-reference.md) article.

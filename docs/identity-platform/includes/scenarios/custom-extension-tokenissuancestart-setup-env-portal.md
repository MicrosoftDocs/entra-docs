---
title: Set up environment variables for custom authentication extensions in the Azure portal
description: Instructions for setting up environment variables for custom authentication extensions in the Azure portal.
author: cilwerner
manager: CelesteDG
ms.service: identity-platform
ms.topic: include
ms.date: 02/27/2024
ms.author: cwerner
ms.reviewer: stsoneff
ms.custom:
---

## Set up environment variables for your Azure Function (optional)

You can set up environment variables for your Azure Functions instead of using the `AuthenticationEventsTrigger` attribute to implement the built-in [Azure App service authentication and authorization](/azure/app-service/overview-authentication-authorization). These environment variables can be hardcoded in the attribute or set up in the Azure portal, but not both.

### Set up environment variables in your code

Modify the `AuthenticationEventsTrigger` include the `AuthorityUrl`, `AudienceAppId` and `AuthorizedPartyAppId` (optional) properties, as shown in the below snippet.

```csharp
[FunctionName("onTokenIssuanceStart")]
public async static Task<AuthenticationEventResponse> Run(
    [AuthenticationEventsTrigger(
    AudienceAppId = "Enter custom authentication extension app ID here",
    AuthorityUrl = "Enter authority URI here", // The .well-known/openid-configuration endpoint is appended to the AuthorityUrl in the SDK
    AuthorizedPartyAppId = "Enter the Authorized Party App Id here")] TokenIssuanceStartRequest request, ILogger log) 
```

### Set up environment variables in the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) or [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Navigate to the function app you created, and under **Settings**, select **Configuration**.
1. Under **Application settings**, select **New application setting** and add the following environment variables and associated values.  

   | Name | Value |
   | ---- | ----- | 
   | *AuthenticationEvents__AudienceAppId* | *Custom authentication extension app ID* |
   | *AuthenticationEvents__AuthorityUrl* | &#8226; Workforce tenant `https://login.microsoftonline.com/<tenantID>` <br> &#8226; external tenant `https://<mydomain>.ciamlogin.com` | 
   | *AuthenticationEvents__AuthorizedPartyAppId* | `99045fe1-7639-4a75-9d4a-577b6ca3810f` | 

1. Select **Save** to save the application settings.

    > [!TIP]
    >
    > The *AuthenticationEvents__AuthorizedPartyAppId* environment variable is optional and can be used for development purposes. It is not strictly required for this scenario.
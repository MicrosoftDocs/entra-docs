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

In the code snippet, the `AuthenticationEventsTrigger` attribute is set up for built-in [Azure App service authentication and authorization](/azure/app-service/overview-authentication-authorization). This is optional as you can also hard-code the `AuthenticationEventsTrigger` attribute to include the `AuthorityUrl`, `AudienceAppId` and `AuthorityUrl` properties, as shown in the below snippet.

```csharp
[FunctionName("onTokenIssuanceStart")]
public async static Task<AuthenticationEventResponse> Run(
    [AuthenticationEventsTrigger(
    AudienceAppId = "Enter custom authentication extension app ID here",
    AuthorityUrl = "Enter authority URI here",
    AuthorizedPartyAppId = "Enter the Authorized Party App Id here")] TokenIssuanceStartRequest request, ILogger log) 
```

Alternatively, you can set up environment variables in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) or [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Navigate to the function app you created, and under **Settings**, select **Configuration**.
1. Under **Application settings**, select **New application setting** and add the following three environment variables and associated values:

   | Name | Value | Description |
   | ---- | ----- | ----------- |
   | *AuthenticationEvents__AudienceAppId* | *Custom authentication extension app ID* | The custom authentication extension has an application ID. You can set this up in the [next article](../../custom-extension-tokenissuancestart-configuration.md) |
   | *AuthenticationEvents__AuthorityUrl* | &#8226; Workforce tenant `https://login.microsoftonline.com/<tenantID>` <br> &#8226; Customer tenant `https://<mydomain>.ciamlogin.com` | The well known configuration endpoint `.well-known/openid-configuration` is appended to this value | 
   | *AuthenticationEvents__AuthorizedPartyAppId* | `99045fe1-7639-4a75-9d4a-577b6ca3810f`| (Optional) The app ID of the authorized party app. This can be used for development purposes for the purposes of this guide, application that issued the token | 

1. Select **Save** to save the application settings.

> [!NOTE]
> 
> Double check your application code to ensure that `AuthorityUrl`, `AudienceAppId` and `AuthorizedPartyAppId` are not hardcoded in the `[AuthenticationEventsTrigger]` attribute. You can have either set the environment variables or hardcoded the values in the attribute, but not both.
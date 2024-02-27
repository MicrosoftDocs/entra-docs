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

In the code snippet, the `AuthenticationEventsTrigger` attribute is set up for built-in [Azure App service authentication and authorization](/azure/app-service/overview-authentication-authorization). This is optional as you can also hard-code the `AuthenticationEventsTrigger` attribute to include the `TenantId` and `AudienceAppId` properties, as shown in the below snippet.

```csharp
[AuthenticationEventsTrigger(TenantId = "Enter tenant ID here", AudienceAppId = "Enter application client ID here")]
```

Alternatively, you can set up environment variables in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) or [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Navigate to the function app you created, and under **Settings**, select **Configuration**.
1. Under **Application settings**, select **New application setting**.
1. For **Name**, enter `AuthenticationEvents__TenantId` and for **Value**, enter the tenant ID of your Microsoft Entra tenant, then select **OK**.
1. Add a second variable with the name `AuthenticationEvents__AudienceAppId` and the app ID of the custom authentication extension you created in the [previous step](#register-a-custom-authentication-extension).
1. Select **Save** to save the application settings.

> [!IMPORTANT]
> 
> Double check your application code to ensure that `TenantId` and `AudienceAppId` are not hardcoded in the `[AuthenticationEventsTrigger]` attribute. You can have either set the environment variables or hardcoded the values in the attribute, but not both.
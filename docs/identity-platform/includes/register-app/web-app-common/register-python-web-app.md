---
author: Dickson-Mwendia
ms.service: identity-platform
ms.topic: include
ms.date: 04/04/2024
ms.author: dmwendia
ms.manager: celested
---

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="./media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations** and select **New registration**.
1. Enter a **Name** for your application, for example *python-webapp*. 
1. Under **Supported account types**, select **Accounts in any organizational directory and personal Microsoft accounts**.
1. Under **Redirect URIs**, select **Web** for the platform.
1. Enter a redirect URI of `http://localhost:5000/getAToken`. You can change this value later.
1. Select **Register**.
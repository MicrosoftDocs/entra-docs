---
title: Register an iOS (Swift) mobile app in a tenant
description: The tutorials provide a step-by-step guide on how to register and configure an iOS mobile app in External ID or workforce tenant.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: identity-platform

ms.topic: tutorial
ms.date: 02/14/2025
ms.custom: developer
zone_pivot_groups: entra-tenants
#Customer intent: As a developer, I want to reigister and configure iOS application in an External ID or tenant.
---

# Tutorial: Register and configure iOS (Swift) mobile app

::: zone pivot="workforce"

This tutorial series demonstrates how to build an iOS or macOS app that integrates with the Microsoft identity platform to sign users and get an access token to call the Microsoft Graph API.

When you've completed the tutorial, your application accepts sign-ins of personal Microsoft accounts (including outlook.com, live.com, and others) and work or school accounts from any company or organization that uses Microsoft Entra ID. This tutorial is applicable to both iOS and macOS apps. Some steps are different between the two platforms.

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

In this tutorial, you:

> [!div class="checklist"]
>
> - Register an application in customers tenant.
> - Add a Platform redirect URL


## Prerequisites

- An Azure account with an active subscription. If you don't have one, [create an account for free](https://azure.microsoft.com/free/).

## Register an application

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations**.
1. Select **New registration**.
1. Enter a **Name** for your application. Users of your app might see this name, and you can change it later.
1. Select **Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant) and personal Microsoft accounts (e.g. Skype, Xbox)** under **Supported account types**.
1. Select **Register**.

## Add a platform redirect URL

To specify your app type to your app registration, follow these steps:

1. Under **Manage**, select **Authentication** > **Add a platform** > **iOS/macOS**.
1. Enter your project's Bundle ID. If downloaded the code sample, the Bundle ID is `com.microsoft.identitysample.MSALiOS`. If you're creating your own project, select your project in Xcode and open the **General** tab. The bundle identifier appears in the **Identity** section.
1. Select **Configure** and save the **MSAL Configuration** that appears in the **MSAL configuration** page so you can enter it when you configure your app later.
1. Select **Done**.

## Next steps

> [!div class="nextstepaction"] 
> [Tutorial: Prepare your iOS app for authentication](tutorial-mobile-app-ios-swift-prepare-app.md)

::: zone-end


::: zone pivot="external"

This tutorial series demonstrates how to build an iOS (Swift) mobile app that authenticates using an external tenant. You register an app within the customer's tenant, create an iOS (Swift) app, and you implement the sign-in, sign-out and call a protected web API.

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

In this tutorial, you:

> [!div class="checklist"]
>
> - Register an application in customers tenant.
> - Add a Platform redirect URL
> - Enable public client flow.
> - Add delegated permission to Microsoft Graph



## Prerequisites  

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

## Register an application

[!INCLUDE [register client app](../external-id/customers/includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [Enable public client](../external-id/customers/includes/register-app/add-platform-redirect-url-ios.md)]

## Enable public client flow

[!INCLUDE [Enable public client](../external-id/customers/includes/register-app/enable-public-client-flow.md)]

## Grant admin consent

[!INCLUDE [Grant API permissions](../external-id/customers/includes/register-app/grant-api-permission-sign-in.md)]

## Next steps

> [!div class="nextstepaction"] 
> [Tutorial: Prepare your iOS app for authentication](tutorial-mobile-app-ios-swift-prepare-app.md)

::: zone-end

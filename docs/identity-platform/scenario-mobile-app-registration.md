---
title: Register mobile apps that call web APIs
description: Learn how to build a mobile app that calls web APIs (app's registration)
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.date: 11/14/2024
ms.reviewer: jmprieur
ms.service: identity-platform
ms.subservice: workforce
ms.topic: how-to
ms.custom: sfi-image-nochange
#Customer intent: As an application developer, I want to know how to write a mobile app that calls web APIs by using the Microsoft identity platform for developers.
---

# Register mobile apps that call web APIs

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

This article contains instructions to help you register a mobile application that you're creating.

## Supported account types

The account types that your mobile applications support depend on the experience that you want to enable and the flows that you want to use.

### Audience for interactive token acquisition

Most mobile applications use interactive authentication. If your app uses this form of authentication, you can sign in users from any [account type](quickstart-register-app.md).

### Audience for integrated Windows authentication, username-password, and B2C

If you have a Universal Windows Platform (UWP) app, you can use integrated Windows authentication (IWA) to sign in users. To use IWA or username-password authentication, your application needs to sign in users in your own line-of-business (LOB) developer tenant. In an independent software vendor (ISV) scenario, your application can sign in users in Microsoft Entra organizations. These authentication flows aren't supported for Microsoft personal accounts.

## Platform configuration and redirect URIs

### Interactive authentication

When you build a mobile app that uses interactive authentication, the most critical registration step is the redirect URI. This experience enables your app to get single sign-on (SSO) through Microsoft Authenticator (and Intune Company Portal on Android). It also supports device management policies.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. Browse to **Entra ID** > **App registrations**.
1. Select **New registration**.
1. Enter a **Name** for the application.
1. For **Supported account types**, select **Accounts in this organizational directory only**.
1. Select **Register**.
1. Select **Authentication** and then select **Add a platform**.

   :::image type="content" source="./media/scenario-mobile-app-registration/add-a-platform.png" alt-text="Add a platform." lightbox="./media/scenario-mobile-app-registration/add-a-platform.png":::

1. When the list of platforms is supported, select **iOS / macOS**.

   :::image type="content" source="./media/scenario-mobile-app-registration/choose-a-mobile-application.png" alt-text="Choose a mobile application." lightbox="./media/scenario-mobile-app-registration/choose-a-mobile-application.png":::

1. Enter your bundle ID, and then select **Configure**.

   :::image type="content" source="./media/scenario-mobile-app-registration/enter-your-bundle-id.png" alt-text="Enter your bundle ID." lightbox="./media/scenario-mobile-app-registration/enter-your-bundle-id.png":::

When you complete the steps, the redirect URI is computed for you, as in the following image.

:::image type="content" source="./media/scenario-mobile-app-registration/resulting-redirect-uri.png" alt-text="Resulting redirect URI." lightbox="./media/scenario-mobile-app-registration/resulting-redirect-uri.png":::

If you prefer to manually configure the redirect URI, you can do so through the application manifest. Here's the recommended format for the manifest:

- **iOS**: `msauth.<BUNDLE_ID>://auth`
  - For example, enter `msauth.com.yourcompany.appName://auth`
- **Android**: `msauth://<PACKAGE_NAME>/<SIGNATURE_HASH>`
  - You can generate the Android signature hash by using the release key or debug key through the KeyTool command.

### Username-password authentication


If your app uses only username-password authentication, you don't need to register a redirect URI for your application. This flow does a round trip to the Microsoft identity platform. Your application won't be called back on any specific URI.

However, identify your application as a public client application. To do so:

1. Still in the Microsoft Entra admin center, select your app in **App registrations**, and then select **Authentication**.
1. In **Advanced settings** > **Allow public client flows** > **Enable the following mobile and desktop flows:**, select **Yes**.

   :::image type="content" source="media/scenarios/default-client-type.png" alt-text="Enable public client setting on Authentication pane in Azure portal":::

## API permissions

Mobile applications call APIs for the signed-in user. Your app needs to request delegated permissions. These permissions are also called scopes. Depending on the experience that you want, you can request delegated permissions statically through the Azure portal. Or you can request them dynamically at runtime.

By statically registering permissions, you allow administrators to easily approve your app. Static registration is recommended.

## Next steps

Move on to the next article in this scenario,
[App code configuration](scenario-mobile-app-configuration.md).
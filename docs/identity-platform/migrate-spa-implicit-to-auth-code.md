---
title: Migrate JavaScript single-page app from implicit grant to authorization code flow
description: How to update a JavaScript SPA using MSAL.js 2.x and the authorization code flow with PKCE and CORS support.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 05/12/2025
ms.service: identity-platform
ms.topic: how-to
ms.custom: sfi-ropc-nochange
#Customer intent: As a developer currently using MSAL.js 1.x with implicit grant flow, I want to migrate my JavaScript single-page app to MSAL.js 2.x with auth code flow, so that I can improve security and take advantage of new features like PKCE and CORS support.
---

# Migrate a JavaScript single-page app from implicit grant to auth code flow

The Microsoft Authentication Library for JavaScript (MSAL.js) v2.0 brings support for the authorization code flow with PKCE and CORS to single-page applications on the Microsoft identity platform. Follow the steps in the sections below to migrate your MSAL.js 1.x application using the implicit grant to MSAL.js 2.0+ (hereafter *2.x*) and the auth code flow.

MSAL.js 2.x improves on MSAL.js 1.x by supporting the authorization code flow in the browser instead of the implicit grant flow. MSAL.js 2.x does **NOT** support the implicit flow.

## Perform migration steps

To update your application to MSAL.js 2.x and the auth code flow, there are three primary steps:

1. Switch your [app registration](#switch-redirect-uris-to-spa-platform) redirect URI(s) from **Web** platform to **Single-page application** platform.
1. Update your [code](#switch-redirect-uris-to-spa-platform) from MSAL.js 1.x to **2.x**.
1. Disable the [implicit grant](#disable-implicit-grant-settings) in your app registration when all applications sharing the registration have been updated to MSAL.js 2.x and the auth code flow.

The following sections describe each step in additional detail.

## Switch redirect URIs to SPA platform

If you'd like to continue using your existing app registration for your applications, use the Microsoft Entra admin center to update the registration's redirect URIs to the SPA platform. Doing so enables the authorization code flow with PKCE and CORS support for apps that use the registration (you still need to update your application's code to MSAL.js v2.x).

Follow these steps for app registrations that are currently configured with **Web** platform redirect URIs:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **App registrations**, select your application, and then **Authentication**.
1. In the **Web** platform tile under **Redirect URIs**, select the warning banner indicating that you should migrate your URIs.

    :::image type="content" source="media/migrate-spa-implicit-to-auth-code/portal-01-implicit-warning-banner.png" alt-text="Implicit flow warning banner on web app tile in the Entra admin center.":::

1. Select *only* those redirect URIs whose applications will use MSAL.js 2.x, and then select **Configure**.

    :::image type="content" source="media/migrate-spa-implicit-to-auth-code/portal-02-select-redirect-uri.png" alt-text="Select redirect URI pane in SPA pane in the Entra admin center.":::

These redirect URIs should now appear in the **Single-page application** platform tile, showing that CORS support with the authorization code flow and PKCE is enabled for these URIs.

:::image type="content" source="media/migrate-spa-implicit-to-auth-code/portal-03-spa-redirect-uri-tile.png" alt-text="Single-page application tile in app registration in Azure portal":::

## Update your code to MSAL.js 2.x

In MSAL 1.x, you created an application instance by initializing a UserAgentApplication as follows:

```javascript
// MSAL 1.x
import * as msal from "msal";

const msalInstance = new msal.UserAgentApplication(config);
```

In MSAL 2.x, initialize instead a [PublicClientApplication][msal-js-publicclientapplication]:

```javascript
// MSAL 2.x
import * as msal from "@azure/msal-browser";

const msalInstance = new msal.PublicClientApplication(config);
```

For additional changes you might need to make to your code, see the [migration guide](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/v1-migration.md) on GitHub.

## Disable implicit grant settings

Once you've updated all your production applications that use this app registration and its client ID to MSAL 2.x and the authorization code flow, you should uncheck the implicit grant settings under the **Authentication** menu of the app registration.

When you uncheck the implicit grant settings in the app registration, the implicit flow is disabled for all applications using registration and its client ID.

**Do not** disable the implicit grant flow before you've updated all your applications to MSAL.js 2.x and the [PublicClientApplication][msal-js-publicclientapplication].

## Next steps

- To learn more about the authorization code flow, including the differences between the implicit and auth code flows, see the [Microsoft identity platform and OAuth 2.0 authorization code flow](v2-oauth2-auth-code-flow.md).

- Learn more by building a React Single-page application (SPA) that signs in users in the following multi-part [tutorial series](tutorial-single-page-app-react-prepare-app.md).
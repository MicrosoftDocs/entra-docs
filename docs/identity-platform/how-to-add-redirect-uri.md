---
title: "How to add a redirect URI to your application"
description: Learn how to add a redirect URI to your application in Microsoft Entra to securely handle authentication tokens and enhance app security.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: mode-other
ms.date: 05/23/2025
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As developer, I want to know how to register my application in Microsoft Entra tenant. I want to understand the additional configurations to help make my application secure. 
---

# How to add a redirect URI to your application

To sign in a user, your application must send a login request to the Microsoft Entra authorization endpoint, with a redirect URI specified as a parameter. The redirect URI is a critical security feature that ensures the Microsoft Entra authentication server only sends authorization codes and access tokens to the intended recipient.

## Prerequisites

* [Quickstart: Register an app in Microsoft Entra ID](quickstart-register-app.md).

## Add a redirect URI

A *redirect URI* is where the Microsoft identity platform sends security tokens after authentication. Redirect URIs are configured in **Platform configurations** in the Microsoft Entra admin center. For **Web** and **Single-page applications**, you need to specify a redirect URI manually. For **Mobile and desktop** platforms, you select from generated redirect URIs. 

Follow these steps to configure settings based on your target platform or device:

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Under **Manage**, select **Authentication**.
1. Under **Platform configurations**, select **Add a platform**.
1. Under **Configure platforms**, select the tile for your application type (platform) to configure its settings.

   :::image type="content" source="./media/quickstart-register-app/portal-04-app-reg-03-platform-config.png" alt-text="Screenshot of the platform configuration pane in the Azure portal." border="false":::

   | Platform  | Configuration settings | Example |
   | --------- |------------------------|---------|
   | **Web**   | Enter the **Redirect URI** for a web app that runs on a server. Front channel logout URLs can also be added | `https://contoso.com/auth-response`  or <br> `http://localhost:3000/auth-response` if you run your app locally. |
   | **Single-page application** | Enter a **Redirect URI** for client-side apps using JavaScript, Angular, React.js, or Blazor WebAssembly. Front channel logout URLs can also be added | `https://contoso.com/auth-response`  or <br> `http://localhost:3000/auth-response` if you run your app locally.|
   | **iOS / macOS** | Enter the app **Bundle ID**, which generates a redirect URI for you. Find it in **Build Settings** or in Xcode in *Info.plist*. | `com.microsoft.identityapp.ciam.MSALiOS`. |
   | **Android** | Enter the app **Package name**, which generates a redirect URI for you. Find it in the *AndroidManifest.xml* file. Also generate and enter the **Signature hash**. | Package name: <br>&#8226; `com.azuresamples.msalandroidapp` <br> Signature has: <br>&#8226; `aB1cD2eF-3gH4iJ5kL6-mN7oP8qR=`. |
   | **Mobile and desktop applications** | Select this platform for desktop apps or mobile apps not using MSAL or a broker. Select a suggested **Redirect URI**, or specify one or more **Custom redirect URIs** | `https://login.microsoftonline.com/common/oauth2/nativeclient` |

1. Select **Configure** to complete the platform configuration.

### Redirect URI restrictions

There are some restrictions on the format of the redirect URIs you add to an app registration. For details about these restrictions, see [Redirect URI (reply URL) restrictions and limitations](./reply-url.md).

## Related content

- [Redirect URI (reply URL) restrictions and limitations](./reply-url.md).
- [Add credentials to your application](how-to-add-credentials.md)
- [Create a sign-up and sign-in user flow for an external tenant app](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md)
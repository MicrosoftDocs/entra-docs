---
title: "How to add a redirect URI in your application"
description: In this how to, you learn how to add a redirect URI to your application in Microsoft Entra.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: mode-other
ms.date: 01/29/2025
ms.service: identity-platform
ms.topic: quickstart
#Customer intent: As developer, I want to know how to register my application in Microsoft Entra tenant. I want to understand the additional configurations to help make my application secure. 
---

# How to add a redirect URI in your application

A *redirect URI* is where the Microsoft identity platform sends security tokens after authentication. You can configure redirect URIs in **Platform configurations** in the Microsoft Entra admin center. For **Web** and **Single-page applications**, you need to specify a redirect URI manually. For **Mobile and desktop** platforms, you select from generated redirect URIs. 

## Add a redirect URI

Follow these steps to configure settings based on your target platform or device:

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Under **Manage**, select **Authentication**.
1. Under **Platform configurations**, select **Add a platform**.
1. Under **Configure platforms**, select the tile for your application type (platform) to configure its settings.

   :::image type="content" source="./media/quickstart-register-app/portal-04-app-reg-03-platform-config.png" alt-text="Screenshot of the platform configuration pane in the Azure portal." border="false":::

   | Platform  | Configuration settings | Example |
   | --------- |------------------------|---------|
   | **Web**   | Enter the **Redirect URI** for a web app that runs on a server. Front channel logout URLs can also be added | Node.js: <br>&#8226; `http://localhost:3000/auth/redirect` <br> ASP.NET Core:<br>  &#8226; `https://localhost:7274/signin-oidc` <br>  &#8226; `https://localhost:7274/signout-callback-oidc` (Front-channel logout URL) <br> Python: <br>&#8226; `http://localhost:3000/getAToken` |
   | **Single-page application** | Enter a **Redirect URI** for client-side apps using JavaScript, Angular, React.js, or Blazor WebAssembly. Front channel logout URLs can also be added | JavaScript, React: <br>&#8226; `http://localhost:3000` <br>Angular: <br>&#8226; `http://localhost:4200/`|
   | **iOS / macOS** | Enter the app **Bundle ID**, which generates a redirect URI for you. Find it in **Build Settings** or in Xcode in *Info.plist*. | <br>Workforce tenant: <br>&#8226; `com.<yourname>.identitysample.MSALMacOS` <br>External tenant: <br>&#8226; `com.microsoft.identitysample.ciam.MSALiOS` |
   | **Android** | Enter the app **Package name**, which generates a redirect URI for you. Find it in the *AndroidManifest.xml* file. Also generate and enter the **Signature hash**. | Kotlin: <br>&#8226; `com.azuresamples.msaldelegatedandroidkotlinsampleapp` <br>.NET MAUI: <br>&#8226; `msal{CLIENT_ID}://auth`  <br> Java: <br>&#8226; `com.azuresamples.msalandroidapp` |
   | **Mobile and desktop applications** | Select this platform for desktop apps or mobile apps not using MSAL or a broker. Select a suggested **Redirect URI**, or specify one or more **Custom redirect URIs** | Embedded browser desktop app: <br>&#8226; `https://login.microsoftonline.com/common/oauth2/nativeclient` <br> System browser desktop app:<br>&#8226; `http://localhost` |

1. Select **Configure** to complete the platform configuration.

### Redirect URI restrictions

There are some restrictions on the format of the redirect URIs you add to an app registration. For details about these restrictions, see [Redirect URI (reply URL) restrictions and limitations](./reply-url.md).

## Related content

- [Redirect URI (reply URL) restrictions and limitations](./reply-url.md).
- [Add credentials to your application](how-to-add-credentials.md)
- [Add your application to a user flow](/entra/external-id/customers/how-to-user-flow-add-application)
- [Add credentials to your application](./how-to-add-credentials.md).
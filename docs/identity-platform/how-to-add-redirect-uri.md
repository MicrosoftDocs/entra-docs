---
title: Add a platform to your app registration
description: Learn how to add a platform to your app in Microsoft Entra to securely handle authentication tokens and enhance your application's security.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: mode-other
ms.date: 04/28/2025
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As developer, I want to know how to register my application in Microsoft Entra tenant. I want to understand the additional configurations to help make my application secure. 
---

# Add a platform to your app registration

Microsoft identity platform supports authentication for various modern application types such as web applications, Single-page applications (SPA) and mobile and desktop apps. Once you register your app on the Microsoft Entra admin center, you need to specify the app type by configuring the app platform along with other authentication settings specific to each platform.

## Prerequisites

* [Quickstart: Register an app in Microsoft Entra ID](quickstart-register-app.md).

## Add a platform to your app

Follow these steps to specify your app type to your app registration:

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Under **Manage**, select **Authentication**.
1. Under **Platform configurations**, select **Add a platform**.
1. Under **Configure platforms**, select the tile for your application type (platform) to configure its settings.

   :::image type="content" source="./media/quickstart-register-app/portal-04-app-reg-03-platform-config.png" alt-text="Screenshot of the platform configuration pane in the Azure portal." border="false":::

1. Enter the configuration settings as shown in the following table:

   | Platform  | Configuration settings | Example |
   | --------- |------------------------|---------|
   | **Web**   | A **Redirect URI**, which is the location where the Microsoft Entra authentication server sends the user once they have successfully authorized and been granted an access token. <br> <br> If you configure **Web** app platform for a *native authentication* app registration, you require a redirect URI, but isn't used. Use any redirect URI value, but ensure that the URI meets the required format. |`https://contoso.com/auth-response`  or <br> `http://localhost:3000/auth-response` if you run your app locally.   |
   | **Single-page application** | A **Redirect URI**, which is the location where the Microsoft Entra authentication server sends the user once they have successfully authorized and been granted an access token. | `https://contoso.com/auth-response`  or <br> `http://localhost:3000/auth-response` if you run your app locally.|
   | **iOS / macOS** | **Bundle ID**, which is your app's bundle ID. Microsoft Entra admin center then generates the **Redirect URI** for your app registration.| `com.microsoft.identityapp.ciam.MSALiOS`. |
   | **Android** | **Package name**, which's your app's  Package Name and **Signature hash**, which you generate via command line by following the portal instructions. One you enter the two values, Microsoft Entra admin center generates a redirect URI for you. | Package name: <br>&#8226; `com.azuresamples.msalandroidapp` <br> Signature has: <br>&#8226; `aB1cD2eF-3gH4iJ5kL6-mN7oP8qR=`. |
   | **Mobile and desktop applications** | Select a suggested **Redirect URI**, or specify one or more **Custom redirect URIs** | `https://login.microsoftonline.com/common/oauth2/nativeclient` |

1. Select **Configure** to complete the platform configuration.

### Redirect URI restrictions

There are some restrictions on the format of the redirect URIs you add to an app registration. For details about these restrictions, see [Redirect URI (reply URL) restrictions and limitations](./reply-url.md).

## Related content

- [Redirect URI (reply URL) restrictions and limitations](./reply-url.md).
- [Add credentials to your application](how-to-add-credentials.md)
- [Create a sign-up and sign-in user flow for an external tenant app](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md)
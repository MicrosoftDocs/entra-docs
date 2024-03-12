---
title: Native authentication
description: Learn how you can use native authentication to take greater control over the user interface and experience for your customer-facing mobile and desktop apps.
 
author: csmulligan
manager: celestedg
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: concept-article
ms.date:  03/08/2024
ms.author: cmulligan

#Customer intent: As a developer, devops, I want to learn more how to host the user interface (UI) within the client app by using native authentication so that I can take greater control over the UI and experience of my customer apps.
---
# Native authentication (preview)

Microsoft Entra's native authentication allows you to create and host the user interface (UI) of your customer apps within the client application. By using native authentication, you have full control over the UI, so you can customize the design, logo placement, layout, and other elements to create a consistent, branded look. 

Native authentication is an alternative to browser-delegated authentication, where your app uses the system browser for authentication, then redirect back to the app when the authentication process is complete. While browser-delegated methods can reduce attack vectors and support single sign-on (SSO), it suffers from UI customization is limited and users experience is poor.

Native authentication is the solution for app developers looking for solutions that give them greater control over the user interface and experience.

Watch this [video](https://www.youtube.com/embed/20Tp0CM55rw) for an overview of native authentication capabilities.

[!INCLUDE [preview-alert](../customers/includes/preview-alert/preview-alert-ciam.md)]

## Available authentication methods

Currently, native authentication supports local account identity provider for two authentications methods: 

- Email with one-time passcode (OTP) sign-in.
- Email and password sign-in with support for self-service password reset (SSPR). 

Native authentication doesn't yet support federated identity providers such as social or enterprise identities. 

## When to use native authentication

When it comes to implementing authentication for mobile apps on External ID for customers, you have two options: 

- Microsoft-hosted browser-delegated authentication.
- Fully custom SDK based native authentication. 

The approach you choose depends on your app’s specific requirements. While each app has unique authentication needs, there are some common considerations to keep in mind. Whether you choose native authentication or browser-delegated authentication, Microsoft Entra ID supports both of them.

The following table compares the two authentication methods to help you decide then right option for your app.

|   | Browser-delegated authentication | Native authentication | 
| ---- | --- |  --- |
| **User authentication experience** | Users are taken to a system browser for authentication, then redirect back to the app when the authentication process is complete. This is recommended if the redirection doesn't negatively impact the end user experience. | Users are guided through a [rich, native mobile-first sign-up and sign-in journey](https://devblogs.microsoft.com/identity/wp-content/uploads/sites/74/2023/11/Native-Authentication.mp4) without ever leaving the app. |
| **Customization experience** |Managed [branding and customization options](how-to-customize-branding-customers.md) are available as an out-of-the-box feature.  | This API-centric approach offers a high level of customization, providing extensive flexibility in design and the ability to create tailored interactions and flows. |
| **Applicability**  | Suitable for workforce, B2B, and B2C apps, it can be used for native apps, single-page applications, and web apps. | For customer first-party apps, when the authorization server and app are operated by the same entity and the user perceives them both as the same entity.|
| **Go live effort** |  Low. Use it straight out of the box.  |High. The developer builds, owns, and maintains the authentication experience. |
| **Maintenance effort** | Low. |High. For each feature that Microsoft releases, you need to update the SDK to use it.  |
| **Security** | Most secure option. |Security responsibility is shared with developers, and best practices need to be followed. It's prone to phishing attacks. |
| **Supported languages and frameworks** | <ul><li>ASP.NET Core</li><li>Android (Kotlin, Java)</li><li>iOS (Swift, Objective-C)</li><li>JavaScript</li><li>React</li><li>Angular</li><li>Nodejs</li><li>Python</li><li>Java</li></ul>  |<ul><li>Android (Kotlin, Java)</li><li>iOS (Swift, Objective-C)</li></ul> For other languages and platforms, you can use our [native authentication API](../../identity-platform/reference-native-authentication-overview.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json).  |


## Feature availability

The following table shows the availability of features for native and browser-delegated authentication. 

|   | Browser-delegated authentication | Native authentication | 
| ---- | --- |  --- |
| **Sign-up and sign-in with email one-time passcode (OTP)** | :heavy_check_mark:  | :heavy_check_mark:  |
| **Sign-up and sign-in with email and password** | :heavy_check_mark:  | :heavy_check_mark:  |
| **Self-service password reset (SSPR)** | :heavy_check_mark:  | :heavy_check_mark:  |
| **Social identity provider sign-in** | :heavy_check_mark:  | :x: |
| **Multifactor authentication with email one-time passcode (OTP)**| :heavy_check_mark:  | :x:  |
| **Single sign-on (SSO)** | :heavy_check_mark:  | :x:  |

## How to use native authentication

You can build your customer-facing apps that use native authentication by using our native authentication APIs or Microsoft Authentication Library (MSAL) SDK for Android and iOS. Whenever possible, we recommend you use the MSAL SDK to add native authentication to your apps. 

The native authentication APIs detail required only when you manually make raw HTTP requests to authenticate with Microsoft Entra. However, we don't recommend this approach. So, whenever possible, we recommend you use the MSAL SDK to add native authentication to your apps. For more information, explore our [Android](how-to-run-native-authentication-sample-android-app.md) and [iOS](how-to-run-native-authentication-sample-ios-app.md) tutorials. 

## Related content 

- [Android native authentication tutorials](how-to-run-native-authentication-sample-android-app.md).
- [iOS native authentication tutorials](how-to-run-native-authentication-sample-ios-app.md).
- [Native authentication API reference](../../identity-platform/reference-native-authentication-overview.md).
- [Native authentication challenge types](concept-native-authentication-challenge-types.md).
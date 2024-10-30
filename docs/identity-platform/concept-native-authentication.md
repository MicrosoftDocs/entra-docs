---
title: Native authentication
description: Learn how to set up native authentication in Microsoft Entra External ID. Customize the user interface for mobile and desktop apps, and provide a seamless sign-in experience.
 
author: csmulligan
manager: celestedg
ms.service: entra-external-id 
ms.subservice: external
ms.topic: concept-article
ms.date:  09/30/2024
ms.author: cmulligan

#Customer intent: As a developer, devops, I want to learn more how to host the user interface (UI) within the client app by using native authentication so that I can take greater control over the UI and experience of my customer apps.
---
# Native authentication in Microsoft Entra External ID

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

Microsoft Entra’s native authentication allows you to have full control over the design of your mobile and desktop application sign-in experience. Unlike browser-based solutions, native authentication enables you to create visually appealing, pixel-perfect authentication screens that seamlessly blend into your app’s interface. With this approach, you can fully customize the user interface, including design elements, logo placement, and layout, ensuring a consistent and branded look.

The standard app sign-in process, which relies on browser-delegated authentication, often results in a disruptive transition during authentication. Users are temporarily redirected to a system browser for authentication, only to be brought back to the app once the sign-in is complete.

While browser-delegated authentication offers benefits such as reduced attack vectors and support for single sign-on (SSO), it offers limited UI customization options and a poor user experience.

## Available authentication methods

Currently, native authentication supports local account identity provider for two authentications methods: 

- Email with one-time passcode (OTP) sign-in.
- Email and password sign-in with support for self-service password reset (SSPR). 

Native authentication doesn't yet support federated identity providers such as social or enterprise identities. 

## When to use native authentication

When it comes to implementing authentication for mobile and desktop apps on External ID, you have two options: 

- Microsoft-hosted browser-delegated authentication.
- Fully custom SDK based native authentication. 

The approach you choose depends on your app’s specific requirements. While each app has unique authentication needs, there are some common considerations to keep in mind. Whether you choose native authentication or browser-delegated authentication, Microsoft Entra External ID supports both of them.

The following table compares the two authentication methods to help you decide then right option for your app.

|   | Browser-delegated authentication | Native authentication | 
| ---- | --- |  --- |
| **User authentication experience** | Users are taken to a system browser or embedded browser for authentication only to be redirected back to the app when the sign-in is complete. This method is recommended if the redirection doesn't negatively affect the end user experience. | Users have a rich, native sign-up and sign-in journey without ever leaving the app. |
| **Customization experience** |Managed [branding and customization options](/entra/external-id/customers/how-to-customize-branding-customers) are available as an out-of-the-box feature.  | This API-centric approach offers a high level of customization, providing extensive flexibility in design and the ability to create tailored interactions and flows. |
| **Applicability**  | Suitable for workforce, B2B, and B2C apps, it can be used for native apps, single-page applications, and web apps. | For customer first-party apps, when the same entity operates the authorization server and the app and the user perceives them both as the same entity.|
| **Go live effort** |  Low. Use it straight out of the box.  |High. The developer builds, owns, and maintains the authentication experience. |
| **Maintenance effort** | Low. |High. For each feature that Microsoft releases, you need to update the SDK to use it.  |
| **Security** | Most secure option. |Security responsibility is shared with developers, and best practices need to be followed. It's prone to phishing attacks. |
| **Supported languages and frameworks** | <ul><li>ASP.NET Core</li><li>Android (Kotlin, Java)</li><li>iOS/macOS (Swift, Objective-C)</li><li>JavaScript</li><li>React</li><li>Angular</li><li>Nodejs</li><li>Python</li><li>Java</li></ul>  |<ul><li>Android (Kotlin, Java)</li><li>iOS/macOS (Swift, Objective-C)</li></ul> For other languages and platforms, you can use our [native authentication API](reference-native-authentication-api.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json).  |


## Feature availability

The following table shows the availability of features for browser-delegated and native authentication. 

|   | Browser-delegated authentication | Native authentication | 
| ---- | --- |  --- |
| **Sign-up and sign-in with email one-time passcode (OTP)** | :heavy_check_mark:  | :heavy_check_mark:  |
| **Sign-up and sign-in with email and password** | :heavy_check_mark:  | :heavy_check_mark:  |
| **Self-service password reset (SSPR)** | :heavy_check_mark:  | :heavy_check_mark:  |
| **Custom claims provider** | :heavy_check_mark:  | :heavy_check_mark:  |
| **Social identity provider sign-in** | :heavy_check_mark:  | :x: |
| **Multifactor authentication with email one-time passcode (OTP)**| :heavy_check_mark:  | :x:  |
| **Multifactor authentication with SMS**| :heavy_check_mark:  | :x:  |
| **Single sign-on (SSO)** | :heavy_check_mark:  | :x:  |

## How to enable native authentication

First, review the guidelines above on [when to use native authentication](/entra/external-id/customers/concept-native-authentication#when-to-use-native-authentication). Then, have an internal discussion with your application's business owner, designer, and development team to determine if native authentication is necessary.

If your team has determined that native authentication is necessary for your application, follow these steps to enable native authentication in the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Applications** > **App registrations** and select your app.
1. Navigate to **Authentication** and select the **Settings** tab.
1. Select the **Allow native authentication** and the **Allow public client flow** field.

Once you have enabled both **Allow native authentication** and **Allow public client flow**, update your configuration code accordingly.

## Update your configuration code

After enabling the native authentication APIs in the admin center, you still need to update your application’s configuration code to support native authentication flows for Android or iOS/macOS. To do so, you need to add the challenge type field to your configuration. Challenge types are a list of values that the app uses to notify Microsoft Entra about the authentication method it supports. You can find more information about native authentication challenge types [here](/entra/external-id/customers/concept-native-authentication-challenge-types). 
If the configuration isn’t updated to integrate native authentication components, the native authentication SDKs and APIs won’t be usable. 

## Risk of enabling native authentication

Microsoft Entra's native authentication doesn't support single sign-on (SSO), and the responsibility for ensuring the security of the app lies with your development team.

## How to use native authentication

You can build apps that use native authentication by using our native authentication APIs or the Microsoft Authentication Library (MSAL) SDK for Android and iOS/macOS. Whenever possible, we recommend using MSAL to add native authentication to your apps. 

For more information on native authentication samples and tutorials, see the following table.

| Language/<br/>Platform | Code sample guide | Build and integrate guide |
| ----------- | ----------- |----------- |
|Android (Kotlin) | &#8226; [Sign in users](/entra/external-id/customers/how-to-run-native-authentication-sample-android-app) | &#8226; [Sign in users](/entra/external-id/customers/tutorial-native-authentication-prepare-android-app)|
|iOS (Swift) | &#8226; [Sign in users](/entra/external-id/customers/how-to-run-native-authentication-sample-ios-app) | &#8226; [Sign in users](/entra/external-id/customers/tutorial-native-authentication-prepare-ios-macos-app)|
|macOS (Swift) | &#8226; [Sign in users](/entra/external-id/customers/how-to-run-native-authentication-sample-macos-app) | &#8226; [Sign in users](/entra/external-id/customers/tutorial-native-authentication-prepare-ios-macos-app)|

If you're planning to create an app on a framework currently not supported by MSAL, you can use our authentication API. For more information, follow [this API reference article](reference-native-authentication-api.md).

## Related content 

- [Android native authentication tutorials](/entra/external-id/customers/how-to-run-native-authentication-sample-android-app).
- [iOS native authentication tutorials](/entra/external-id/customers/how-to-run-native-authentication-sample-ios-app).
- [Native authentication API documentation](reference-native-authentication-api.md).
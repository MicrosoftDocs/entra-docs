---
title: Native authentication
description: Learn how you can use native authentication to take greater control over the user interface and experience for your customer-facing mobile and desktop apps.
 
author: csmulligan
manager: celestedg
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: conceptual
ms.date:  02/29/2024
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

- Email with one-time passcode sign-in(OTP).
- Email and password sign-in with support for self-service password reset (SSPR). 

Native authentication doesn't yet support federated identity providers such as social or enterprise identities. 

## When to use native authentication
<!--This section will be updated once I have the most up-to-date content from the PM.-->
Whether you choose native authentication over browser-delegated authentication depends on your requirements. In general, native authentication is an ideal solution for any of the following conditions:  

- A consistently branded experience across touchpoints and applications.
- Your onboarding transactions are low risk, and acquisition far outweighs governance.
- Your browser-delegated capabilities don’t meet all of your UI customization and layout needs.
- The functionalities you require are currently available via native authentication. However, you might need more research to ensure that the native authentication provides all the functionality you need.

Whether you choose native authentication or browser-delegated authentication, Microsoft Entra supports both of them.

## How to use native authentication

You can build apps that use native authentication by using our native authentication APIs or Microsoft Authentication Library (MSAL) SDK for Android and iOS. Whenever possible, we recommend you use the MSAL SDK to add native authentication to your apps. 

The native authentication APIs detail required only when you manually make raw HTTP requests to authenticate with Microsoft Entra. However, we don't recommend this approach. So, whenever possible, we recommend you use the MSAL SDK to add native authentication to your apps. For more information, explore our [Android](how-to-run-native-authentication-sample-android-app.md) and [iOS](how-to-run-native-authentication-sample-ios-app.md) tutorials. 

## Next steps
- [Explore app samples and guides](/entra/external-id/customers/samples-ciam-all).
- [Android native authentication tutorials](how-to-run-native-authentication-sample-android-app.md).
- [iOS native authentication tutorials](how-to-run-native-authentication-sample-ios-app.md).
- [Native authentication API documentation](../../identity-platform/reference-native-authentication-overview.md).
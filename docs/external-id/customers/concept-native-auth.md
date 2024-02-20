---
title: Native authentication
description: Learn 
 
author: csmulligan
manager: celestedg
ms.service: active-directory
 
ms.subservice: ciam
ms.topic: conceptual
ms.date:  02/12/2023
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As an it admin, I want to learn more about native authentication so that I can understand how to use it in my organization.
---
# Native authentication for customer apps

With native authentication you can create streamlined and sleek authentication experiences for your customer-facing mobile and desktop applications using Microsoft Authentication Library (MSAL) for iOS and Android. You can also choose from different authentication methods to create the authentication experience that suits your needs. 

## What is native authentication?

Native authentication provides a deeply integrated experience within an application, without the need for browser delegation. Native authentication allows you to host the user interface within the client application, resulting in a seamless, natively integrated authentication experience. With full control over the user interface, you can customize the design, logo placement, layout, and other elements to create a consistent, branded look using the language of your choice. Whether creating a single screen or splitting it into multiple screens, native authentication enables you to achieve a pixel-perfect experience, all within the application code.

In contrast, browser-delegated methods, such as using a system browser for authentication, may not be suitable for everyone. While these methods can reduce attack vectors and support single sign-on (SSO), the look and feel is limited by the customization capabilities of the identity provider. Matching the browser user interface to the application’s design can be challenging, and the redirection process can be disruptive and slow to load. 

Watch this [video](https://www.youtube.com/embed/20Tp0CM55rw) for an overview of native authentication capabilities.

## Available authentication methods

You can create fully native experiences for local account sign-up, sign-in, and sign-out for your first party applications. We provide the following capabilities: 

- Passwordless authentication with email one-time passcode (OTP) (for sign-up, sign-in, and sign-out).
- Password authentication (for sign-up, sign-in, and sign-out). 
- Collection of user attributes.
- Self-service password reset with email OTP verification.  

:::image type="content" source="media/concept-native-auth/native-auth-experiences.png" alt-text="Native authentication experiences.":::

## When to use native authentication
<!--This section will be updated once I have the most up-to-date content from the PM.-->
Whether you choose native authentication over browser-delegated authentication depends on your requirements. In general, native authentication is an ideal solution for any of the following conditions:  

- Streamlined sign-up and sign-in experiences are critical, and any friction encountered by users may affect revenue or retention.
- A consistently branded experience across touchpoints and applications is of paramount importance.
- Your onboarding transactions are low risk, and acquisition far outweighs governance.
- Your browser-delegated capabilities don’t meet all of your UI customization and layout needs.
- The features you require are currently available via native authentication.

Native authentication isn't a supported solution for:

- Third-party or multitenant applications.
- Microsoft first-party client applications.
- B2B or B2E apps. Native authentication is available only for Microsoft Entra ID for customers applications.

## Out of scope capabilities
<!--This section will be updated once I have the most up-to-date content from the PM.-->
The following capabilities are out of scope:

- Multifactor authentication during sign-in.
- Conditional Access.
- Some of the [Custom authentication extensions (preview)](/entra/identity-platform/custom-extension-overview) events aren't triggered when Microsoft Entra ID doesn't  render the UI. For example, when using native authentication the following event won't trigger:
   - [Custom authentication extensions for attribute collection start and submit events](/entra/identity-platform/custom-extension-attribute-collection?tabs=start-continue%2Csubmit-continue). For applications that use native authentication, it's up to app developer to call the REST API directly from their applications.
   - [Brand your apps via custom authentication extensions](https://github.com/microsoft/entra-previews/blob/PP4/docs/Branding-per-app-via-custom-auth-extension.md). For applications that use native authentication, the developer of the app has full control on the UI.
  
## Available languages for native authentication

For native authentication you can use the unified Microsoft Authentication Library (MSAL) for iOS and Android. It enables you to create applications using Kotlin, Swift, Java, and Objective-C. You can find the underlying native API documentation here, allowing you  to create mobile, desktop, and web applications using the language and framework of your  choice.

:::image type="content" source="media/concept-native-auth/native-auth-sdk-api.png" alt-text="Native authentication SDK and API options.":::

For a demonstration of sample application using iOS MSAL native authentication, see the following [video](https://www.youtube.com/embed/ykf3sm5nxRc).

### Mobile and desktop apps
<!--This section will be updated once I have the most up-to-date content from the PM an the correct links.-->
The following table provides a list of the available languages and platforms for native authentication, along with the corresponding code sample and build and integrate guide.

| Language/Platform   | Code sample guide | Build and integrate guide |
| ------------------- |  ---------------- | ------------------------- |
| **Android (Kotlin)    | [Sign in users in a sample native Android mobile application](Developer-guides/0-Android-Kotlin/0-Run-code-sample.md) | [Add authentication to your Android app](Developer-guides/0-Android-Kotlin/1-Add-authentication-prepare-app.md) |
| **iOS (Swift)         | [Sign in users in a sample native iOS mobile application](Developer-guides/1-iOS-Swift/0-Run-code-sample.md) | [Add authentication to your native iOS mobile application](Developer-guides/1-iOS-Swift/1-Add-authentication-prepare-app.md) |

### API and SDK Reference
<!--This section will be updated once I have the most up-to-date content from the PM an the correct links.-->
The following table provides a list of the available API and SDK references for native authentication.

|  Documentation  | 
|   ---------------- |
|  [Native Authentication REST API Reference](Developer-guides/3-REST-API-reference/0-API-reference-overview.md)   |
|  [MSAL Android Native Auth SDK reference](./Developer-guides/2-Native-SDK-reference/1-Android-SDK-reference.md)   |
|  [MSAL iOS Native Auth SDK reference](./Developer-guides/2-Native-SDK-reference/iOS/msal-ios-sdk-reference.md)   |

## Next steps
<!--This section will be updated with the correct links.-->
- Tutorials 
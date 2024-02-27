---
title: Native authentication
description: Learn about native authentication for customer-facing mobile and desktop applications.
 
author: csmulligan
manager: celestedg
ms.service: active-directory
 
ms.subservice: ciam
ms.topic: conceptual
ms.date:  02/29/2024
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As an it admin, I want to learn more about native authentication so that I can understand how to use it in my organization.
---
# Native authentication (preview)

Native authentication allows you to create and host the user interface of your customer apps within the client application. This results in a seamless, integrated authentication experience using Microsoft Authentication Library (MSAL) for iOS and Android. You have full control over the user interface, so you can customize the design, logo placement, layout, and other elements to create a consistent, branded look. 
In contrast, browser-delegated methods, such as using a system browser for authentication, may not be suitable for everyone. While browser-delegated methods can reduce attack vectors and support single sign-on (SSO), the look and feel is limited by the customization capabilities of the identity provider.

Watch this [video](https://www.youtube.com/embed/20Tp0CM55rw) for an overview of native authentication capabilities.

[!INCLUDE [preview-alert](../customers/includes/preview-alert/preview-alert-ciam.md)]

## Available authentication methods

You can create fully native experiences for local account sign-up, sign-in, and sign-out for your first party applications. We provide the following capabilities: 

- Passwordless authentication with email one-time passcode (OTP).
- Password authentication with self-service password reset (SSPR). 

:::image type="content" source="media/concept-native-authentication/native-authentication-experiences.png" alt-text="Native authentication experiences.":::

## When to use native authentication
<!--This section will be updated once I have the most up-to-date content from the PM.-->
Whether you choose native authentication over browser-delegated authentication depends on your requirements. In general, native authentication is an ideal solution for any of the following conditions:  

- A consistently branded experience across touchpoints and applications.
- Your onboarding transactions are low risk, and acquisition far outweighs governance.
- Your browser-delegated capabilities don’t meet all of your UI customization and layout needs.
- The functionalities you require are currently available via native authentication. However, you might need additional research to ensure that the native authentication provides all the functionality you need.

Native authentication isn't a supported solution for:

- Third-party or multitenant applications.
- Microsoft first-party client applications.
- B2B or B2E apps. Native authentication is available only for Microsoft Entra ID for customers applications.

## Next steps
<!--This section will be updated with the correct links.-->
- [Samples and guides for customer identity and access management (CIAM)](/entra/external-id/customers/samples-ciam-all)
- Native authentication tutorials
- Native authentication API documentation


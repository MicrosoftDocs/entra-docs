---
title: Native authentication challenge types
description: Learn how apps that use native authentication notify Microsoft Entra about the authentication methods that they support. 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: concept-article
ms.date: 02/29/2024

#Customer intent: As a dev, devops, I want to learn about native authentication challenge types, so that I can use them to notify Microsoft Entra about the authentication methods that my app supports.
---

# Native authentication challenge types

Native authentication supports two authentication methods:

- Email with one-time passcode (OTP).
- Email and password with support for self-service password reset (SSPR).

A customer app that uses native authentication to sign in users can use either of the authentication methods. To make successful calls to Microsoft Entra, the app needs to indicate the authentication methods it supports. Microsoft Entra enables the customer app to advertise the authentication methods it supports by using *challenge types*. 

Challenge types are predefined values, which the customer app includes in its request to notify Microsoft Entra about the authentication method the app supports.

## Challenge types

The following table contains the supported challenge type values:

[!INCLUDE [native-auth-challenge-type](../../identity-platform/includes/native-auth-api/native-auth-challenge-type.md)]

New values will be added in the future when native authentication support new authentication methods.

## Challenge types usage

The following table summarizes the challenge type values an app should use for the various authentication flows:

|   | Sign-up flow | Sign-in flow | SSPR |
| ---- | --- |  --- | --- | 
| **Email with password** | *oob*, *password*, and *redirect*  | *oob*, *password*, and *redirect*  | *oob* and *redirect* |
| **Email OTP** | *oob* and *redirect* | *oob* and *redirect*  | Not applicable |

- Apps that use [native authentication API](../../identity-platform/reference-native-authentication-overview.md) must include the *redirect* challenge type in the list when they indicate the challenge type that they support.
- Apps that use Android and iOS SDKs don't need to include the *redirect* challenge type as the SDK automatically includes it.  

### What happens if a client app doesn't support a challenge type?

If a client app doesn't support a challenge type that the administrator configures in the Microsoft Entra admin center, Microsoft Entra notifies the client app to use web fallback.

### What happens if a client app uses a challenge type that Microsoft Entra doesn't support?

If a client app uses a challenge type that Microsoft Entra doesn't support, Microsoft Entra notifies the client as so. The solution to this problem is for the client app to use a supported challenge type.

## Related content 

- [Native authentication Android SDK tutorials](how-to-run-native-authentication-sample-android-app.md).
- [Native authentication iOS SDK tutorials](how-to-run-native-authentication-sample-ios-app.md).
- [Native authentication API reference](../../identity-platform/reference-native-authentication-overview.md).
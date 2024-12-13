---
title: Native authentication challenge types
description: Learn how apps that use native authentication notify Microsoft Entra about the authentication methods that they support. 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: external
ms.topic: concept-article
ms.date: 04/29/2024

#Customer intent: As a dev, devops, I want to learn about native authentication challenge types, so that I can use them to notify Microsoft Entra about the authentication methods that my app supports.
---

# Native authentication challenge types

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Native authentication supports two authentication methods:

- Email with one-time passcode (OTP).
- Email and password with support for self-service password reset (SSPR).

A customer app that uses native authentication to sign in users can use either of the authentication methods. To make successful calls to Microsoft Entra, the app needs to indicate the authentication methods it supports. Microsoft Entra enables the customer app to advertise the authentication methods it supports by using *challenge types*. 

Challenge types are predefined values, which the customer app includes in its request to notify Microsoft Entra about the authentication method the app supports.

## Challenge types

The following table contains the supported challenge type values:

[!INCLUDE [native-auth-challenge-type](../../identity-platform/includes/native-auth-api/native-auth-challenge-type.md)]

We add new values in the future when native authentication support new authentication methods.

## Challenge types usage

The following table summarizes the challenge type values an app should use for the various authentication flows:

|   | Sign-up flow | Sign-in flow | SSPR |
| ---- | --- |  --- | --- | 
| **Email with password** | *oob*, *password*, and *redirect*  | *oob*, *password*, and *redirect*  | *oob* and *redirect* |
| **Email OTP** | *oob* and *redirect* | *oob* and *redirect*  | Not applicable |

- Apps that use [native authentication API](../../identity-platform/reference-native-authentication-overview.md) must include the *redirect* challenge type in the list when they indicate the challenge type that they support.
- Apps that use Android and iOS SDKs don't need to include the *redirect* challenge type as the SDK automatically includes it.  


The following table summarizes what happens if either Microsoft Entra or the client app doesn't support a given challenge type:

|  Scenario | What happens | 
| ---- | --- |
|**A client app includes unsupported challenge type**| Microsoft Entra returns an error as it treats this request as invalid. |
|**A client app fails to include a supported challenge type**| It indicates that the client app doesn't support a challenge type that the administrator configures in the Microsoft Entra admin center. In this case, Microsoft Entra notifies the client app to use [web fallback](concept-native-authentication-web-fallback.md).|

## Related content 

- [Native authentication web fallback](concept-native-authentication-web-fallback.md)
- [Native authentication Android SDK tutorials](how-to-run-native-authentication-sample-android-app.md)
- [Native authentication API reference](../../identity-platform/reference-native-authentication-overview.md)

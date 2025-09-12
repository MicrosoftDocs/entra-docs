---
title: Native authentication challenge types
description: Learn how apps that use native authentication notify native authentication API about the authentication flows that they support. 
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform 
ms.subservice: external
ms.topic: concept-article
ms.date: 09/29/2025

#Customer intent: As a dev, devops, I want to learn about native authentication challenge types and capabilities, so that I can use them to notify native authentication API about the authentication flows that my app supports.
---

# Native authentication challenge types and capabilities

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

Native authentication supports two authentication flows:

- Email with one-time passcode (OTP).
- Email and password with support for self-service password reset (SSPR).

A client app that uses native authentication to sign in users can use either of the authentication flows. To make successful calls to native authentication API, the app needs to indicate the authentication flows or capabilities it supports. Native authentication API enables the client app to advertise the challenge types and capabilities by using predefined values.

## Challenge types

Challenge types are predefined values, which the client app includes in its request to notify the native authentication API about the authentication flow the app supports.

The following table contains the supported challenge type values:

[!INCLUDE [native-auth-challenge-type](includes/native-auth-api/native-auth-challenge-type.md)]

### Challenge types usage

The following table summarizes the challenge type values an app should use for the various authentication flows:

|   | Sign-up flow | Sign-in flow | SSPR |
| ---- | --- |  --- | --- | 
| **Email with password** | *oob*, *password*, and *redirect*  | *oob*, *password*, and *redirect*  | *oob* and *redirect* |
| **Email OTP** | *oob* and *redirect* | *oob* and *redirect*  | Not applicable |

- Apps that use [native authentication API](reference-native-authentication-overview.md) must include the *redirect* challenge type in the list when they indicate the challenge type that they support.
- Apps that use native authentication SDKs, such as Android, iOS and JavaScript SDKs don't need to include the *redirect* challenge type as the SDK automatically includes it.  

## Capabilities

TODO


The following table summarizes what happens if either native authentication API or the client app doesn't support a given challenge type or capability:

|  Scenario | What happens | 
| ---- | --- |
|**A client app includes unsupported challenge type**| Native authentication API returns an error as it treats this request as invalid. |
|**A client app includes unsupported capability**| Native authentication API returns an error as it treats this request as invalid. |
|**A client app fails to include a supported challenge type**| It indicates that the client app doesn't support a challenge type that the administrator configures in the Microsoft Entra admin center. In this case, native authentication API notifies the client app to use [web fallback](concept-native-authentication-web-fallback.md).|
|**A client app fails to include a supported capability**| app works okay if `mfa_required` or `registration_required not rquired, otherwise web fallback happens===<<TODO>>|

## Related content 

- [Native authentication web fallback](concept-native-authentication-web-fallback.md)
- [Native authentication Android SDK tutorials](/entra/external-id/customers/how-to-run-native-authentication-sample-android-app)
- [Native authentication API reference](reference-native-authentication-api.md)

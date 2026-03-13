---
title: Native authentication challenge types
description: Learn how apps that use native authentication notify native authentication API about the authentication flows that they support. 
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform 
ms.subservice: external
ms.topic: concept-article
ms.date: 02/27/2026

#Customer intent: As a dev, devops, I want to learn about native authentication challenge types and capabilities, so that I can use them to notify native authentication API about the authentication flows that my app supports.
---

# Native authentication challenge types and capabilities

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

Native authentication supports two authentication flows:

- Email with one-time passcode (OTP)
- Email and password with support for self-service password reset (SSPR)

A client app that uses native authentication to sign in users can use either authentication flow. To make successful calls to the native authentication API, the app must declare which authentication flows and capabilities it supports. The native authentication API enables client apps to advertise their supported challenge types and capabilities using predefined values.

## Challenge types

Challenge types are predefined values that client apps include in their requests to declare which authentication flows they support to the native authentication API.

The following table contains the supported challenge type values:

[!INCLUDE [native-auth-challenge-type](includes/native-auth-api/native-auth-challenge-type.md)]

New values are added when native authentication supports new authentication methods.

## Challenge type values for native authentication flows

The following table summarizes the challenge type values an app should use for various authentication flows:

|   | Sign-up flow | Sign-in flow | SSPR |
| ---- | --- |  --- | --- | 
| **Email with password** | *oob*, *password*, and *redirect*  | *oob*, *password*, and *redirect*  | *oob* and *redirect* |
| **Email OTP** | *oob* and *redirect* | *oob* and *redirect*  | Not applicable |

**Important notes:**
- Apps that use the [native authentication API](reference-native-authentication-api.md) directly must include the *redirect* challenge type when declaring their supported challenge types.
- Apps that use native authentication SDKs (Android, iOS, or JavaScript) don't need to include the *redirect* challenge type as the SDK automatically includes it.

## Capabilities

In addition to challenge types, client apps can specify a list of *capabilities*. While `challenge_type` defines which authentication methods the app supports, `capabilities` indicate which additional flows the client app can handle and what UI experiences it can provide to users.

Native authentication API supports the following capabilities:

- `mfa_required`: Indicates that the client app can handle multifactor authentication (MFA) flows, including displaying the appropriate UI for users to complete MFA challenges when required.
- `registration_required`: The client can handle strong authentication registration: it can call the registration APIs and show UI to guide users through registering strong authentication methods.

## Behavior for unsupported challenge types and capabilities

The following table summarizes the behavior when either the native authentication API or the client app doesn't support a given challenge type or capability:

| Scenario | Behavior | 
| ---- | --- |
| **Client app includes unsupported challenge type** | Native authentication API returns an error and treats the request as invalid. |
| **Client app includes unsupported capability** | Native authentication API returns an error and treats the request as invalid. |
| **Client app fails to include a required challenge type** | The app doesn't support a challenge type configured by the administrator. Native authentication API initiates a [web fallback](concept-native-authentication-web-fallback.md). |
| **Client app fails to include a required capability** | The app functions normally if MFA or strong authentication registration is not required. If these capabilities are required but not supported, native authentication API initiates a [web fallback](concept-native-authentication-web-fallback.md) to complete the authentication flow. |



## Related content 

- [Native authentication web fallback](concept-native-authentication-web-fallback.md)
- [Native authentication Android SDK tutorials](quickstart-native-authentication-android-sign-in.md)
- [Native authentication API reference](reference-native-authentication-api.md)

---
title: Native authentication challenge types
description: Find out how to use Native authentication with email OTP API reference for Microsoft Entra ID for customers. 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: concept-article
ms.date: 02/29/2024

#Customer intent: As a dev, devops, I want to learn how to integrate customer apps with Native authentication's email OTP API that in Microsoft Entra ID for customers supports.
---

# Native authentication challenge types

Currently, native authentication supports two authentication methods:

- Email with one-time passcode (OTP).
- Email and password sign-in with support for self-service password reset (SSPR).

A customer app that uses native authentication to sign in users can use either of the authentication methods. To make successful calls to Microsoft Entra, the app needs to indicate the authentication methods it supports. Microsoft Entra enables the customer app to advertise the authentication methods it supports by using a *challenge types*. 

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

## Related content 

- [Android native authentication tutorials](how-to-run-native-authentication-sample-android-app.md).
- [iOS native authentication tutorials](how-to-run-native-authentication-sample-ios-app.md).
- [Native authentication API reference](../../identity-platform/reference-native-authentication-overview.md).
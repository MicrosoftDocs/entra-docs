---
title: Overview of native authentication APIs references
description: Find out the use, and the available API options for native authentication in Microsoft Entra ID for customers 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: active-directory 
ms.subservice: ciam
ms.topic: reference
ms.date: 02/29/2024

#Customer intent: As a dev, devops, I want to learn how to integrate apps with native authentication APIs that Microsoft Entra ID for customers supports.
---

# Overview of native authentication API reference

Microsoft Entra ID's [native authentication](../external-id/customers/overview-customers-ciam.md) enables you to host the user interface of your app in the client application instead of delegating authentication to browsers, resulting in a natively integrated authentication experience. As a developer, you have full control over the look and feel of the sign-in interface.

[!INCLUDE [native-auth-api-common-description](./includes/native-auth-api/native-auth-api-common-description.md)]

Currently, our identity platform's native authentication API supports sign-up and sign-in for two authentication methods:

- [Email with password](reference-native-auth-email-password.md), which supports sign-up and sign-in with an email and password, and self-service password reset (SSPR).

- [Email one-time password or passcode (OTP)](reference-native-auth-email-otp.md), which supports sign-up and sign-in with email OTP.


[!INCLUDE [native-auth-api-cors-note](./includes/native-auth-api/native-auth-api-cors-note.md)]


## Next steps

- [Native authentication API reference with Email OTP](reference-native-auth-email-otp.md).

- [Native authentication API reference with Email and password](reference-native-auth-email-password.md).

- [Native authentication API reference with Email and password - Self-service password reset option](reference-native-auth-email-password.md).
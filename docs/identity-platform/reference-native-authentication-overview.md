---
title: Native authentication API reference
description: Find out the use, and the available API options for Native authentication in Microsoft Entra External ID for customers 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: reference
ms.date: 03/29/2024

#Customer intent: As a dev, devops, I want to learn how to integrate apps with Native authentication APIs that Microsoft Entra External ID for customers supports.
---

# Native authentication API reference

Microsoft Entra's [Native authentication](../external-id/customers/concept-native-authentication.md) enables you to host the user interface of your app in the client application instead of delegating authentication to browsers, resulting in a natively integrated authentication experience. As a developer, you have full control over the look and feel of the sign-in interface.

[!INCLUDE [native-auth-api-common-description](./includes/native-auth-api/native-auth-api-common-description.md)]

Currently, our identity platform's Native authentication API supports sign-up and sign-in for two authentication methods:

- [Email with password](reference-native-authentication-email-password.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json), which supports sign-up and sign-in with an email and password, and self-service password reset (SSPR).

- [Email one-time password or passcode](reference-native-authentication-email-otp.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json), which supports sign-up and sign-in with email one-time passcode.


[!INCLUDE [native-auth-api-cors-note](./includes/native-auth-api/native-auth-api-cors-note.md)]


## Next steps

- [Native authentication API reference with email one-time passcode](reference-native-authentication-email-otp.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json).

- [Native authentication API reference with Email and password](reference-native-authentication-email-password.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json).

- [Native authentication API reference with Email and password - Self-service password reset option](reference-native-authentication-email-password.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json#self-service-password-reset-sspr).
---
title: Overview of native authentication APIs reference
description: Find out the use, and the available API options for native authentication in Microsoft Entra ID for customers 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: active-directory 
ms.subservice: ciam
ms.topic: reference
ms.date: 02/29/2024

#Customer intent: As a dev, devops, I want to know the use, and the API options for native authentication in Microsoft Entra ID for customers
---

# Overview of native authentication APIs reference

Microsoft Entra ID's [native authentication](refer-to-native-auth-conceptual-article.md) enables you to host the user interface of your app in the client application instead of delegating authentication to browsers, resulting in a natively integrated authentication experience. As a developer, you have full control over the look and feel of the sign-in interface.

This API reference article describes details required only when you manually make raw HTTP requests to execute the flow. However, we recommend, when possible, you use the Microsoft-built and supported authentication library such as [Android native SDK](refer-to-Native-SDK-reference.md) and [iOS native SDK](refer-to-Native-SDK-reference.md), to get security tokens. 

When a call to the API endpoints is successful, you receive both an [ID token](https://learn.microsoft.com/entra/identity-platform/id-tokens) for user identification and an [access token](https://learn.microsoft.com/entra/identity-platform/access-tokens) to call protected APIs. All responses form the API are in a JSON format. The API is based on an ongoing effort by the IETF to extend OAuth2.0 to include native authentication.

Currently, our identity platform's native authentication API supports sign-up and sign-in for two options:

- [Email with password](./2-API-reference-email-password.md), which supports sign-up and sign-in with an email and password, and self-service password reset (SSPR).

- [Email OTP](./1-API-reference-email-otp.md), which supports sign-up and sign-in with email OTP.


> [!NOTE]  
> Currently, the native authentication API endpoints don't support [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS).


## Next steps

- [Native authentication API reference with Email OTP](./1-API-reference-email-otp.md).

- [Native authentication API reference with Email and password](./2-API-reference-email-password.md).

- [Native authentication API reference with Email and password - Self-service password reset option](./2-API-reference-email-password.md#self-service-password-reset-sspr).
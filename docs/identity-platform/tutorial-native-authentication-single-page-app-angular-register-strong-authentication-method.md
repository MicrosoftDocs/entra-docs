---
title: Register Strong Auth Method in a Angular SPA by Using Native Authentication JavaScript SDK
description: Learn how to register a strong auth method in a Angular single-page application that uses native authentication JavaScript SDK

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 11/18/2025

#Customer intent: As a developer, I want to enable strong authentication method registration flow in a Angular single-page application that uses native authentication's JavaScript SDK so that users can register a strong method registration during sign-in or after password reset or after sign-up.
---

# Tutorial: Register strong authentication method in a Angular single-page app by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you will register strong authentication method for a user in your Angular single-page application (SPA) by using native authentication's JavaScript SDK.

If you enable multifactor authentication (MFA), but the user has no registered strong authentication method, you need to enable the user register one before tokens can be issued.

The strong authentication method registration flow occurs in three scenarios:
- **During sign-in**: The user signs in but does not have a strong authentication method registered.
- **After sign-up**: The user successfully signs up and automatically proceeds to sign in.
- **After self-service password reset (SSPR)**: The user successfully resets their password and automatically proceeds to sign in.

When strong authentication method registration is required, the user selects a method of choice from a list of supported methods. The available methods are **email** and **SMS** one-time passcode.

The flow diagram below illustrates the three scenarios:

:::image type="content" source="media/tutorial-native-authentication-single-page-app-react-register-strong-authentication-method/register-strong-authentication-method.png" alt-text="Register strong authentication method."::: 

## Prerequisites
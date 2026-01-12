---
title: Enable MFA in a Angular SPA by Using Native Authentication JavaScript SDK
description: Learn how to enable multifactor authentication in a Angular single-page application that uses native authentication JavaScript SDK

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 01/18/2026
#Customer intent: As a developer, I want enable multifactor authentication in a Angular single-page application that uses native authentication's JavaScript SDK so that users can complete an MFA challenge during sign in and password reset.
---

# Tutorial: Enable multifactor authentication in a Angular single-page app by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to add multifactor authentication (MFA) in your Angular single-page application (SPA) by using native authentication's JavaScript SDK.

Just like in [strong authentication method registration](tutorial-native-authentication-single-page-app-angular-register-strong-authentication-method.md), MFA flow occurs in three scenarios:
- **During sign-in**: The user signs in and has a strong authentication method registered.
- **After sign-up**: After the user completes sign-up, they proceed to sign in. New users need to [register a strong authentication method](tutorial-native-authentication-single-page-app-angular-register-strong-authentication-method.md) before any MFA challenge. Because the strong authentication method also gets verified during registration, they might not be prompted for an additional MFA challenge.
- **After self-service password reset (SSPR)**: The user successfully resets their password and automatically proceeds to sign in. If the user has a strong authentication method registered, they're prompted to complete MFA challenge.

When MFA is required, the user chooses a MFA challenge method from a list of registered methods. Available options are **email** one-time passcode, **SMS** one-time passcode, or both, depending on what the user previously registered.

The flow diagram below illustrates the three scenarios:

:::image type="content" source="media/tutorial-native-authentication-single-page-app-react-register-strong-authentication-method/register-strong-authentication-method.png" alt-text="Complete multifactor authentication challenge.":::
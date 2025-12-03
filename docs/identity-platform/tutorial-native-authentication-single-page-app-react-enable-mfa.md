---
title: Enable MFA in a React SPA by Using Native Authentication JavaScript SDK
description: Learn how to enable multifactor authentication in a React single-page application that uses native authentication JavaScript SDK

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 11/18/2025
#Customer intent: As a developer, I want enable multifactor authentication in a React single-page application that uses native authentication's JavaScript SDK so that users can complete an MFA challenge during sign in and password reset.
---

# Tutorial: Enable multifactor authentication in a React single-page app by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to add multifactor authentication (MFA) in your React single-page application (SPA) by using native authentication's JavaScript SDK.

Just like in [strong authentication method registration](tutorial-native-authentication-single-page-app-react-register-strong-authentication-method.md), MFA flow occurs in three scenarios:
- **During sign-in**: The user signs in and has a strong authentication method registered.
- **After sign-up**: The user successfully signs up and automatically proceeds to sign in. If the user has a strong authentication method registered, they're prompted to complete MFA challenge.
- **After self-service password reset (SSPR)**: The user successfully resets their password and automatically proceeds to sign in. If the user has a strong authentication method registered, they're prompted to complete MFA challenge.

When MFA is required, the user chooses a registered method. Available options are **email** one-time passcode, **SMS** one-time passcode, or both, depending on what the user previously registered.

The flow diagram below illustrates the three scenarios:

:::image type="content" source="media/tutorial-native-authentication-single-page-app-react-register-strong-authentication-method/register-strong-authentication-method.png" alt-text="Complete multifactor authentication challenge.":::

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-react-sdk-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-react-sdk-sign-in.md), and [register strong authentication method](tutorial-native-authentication-single-page-app-react-register-strong-authentication-method.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- [Enable multifactor authentication (MFA) for your app](../external-id/customers/how-to-multifactor-authentication-customers.md).

## Enable app to handle multifactor authentication 

To enable MFA in your React app, update the app configuration by adding the required capability.

1. Locate the *src/config/auth-config.ts* file.
1. In the `customAuth` object, add or update `capabilities` property to include the `mfa_required` value in the array as shown in the following coe snippet:

    ```typescript
    const customAuthConfig: CustomAuthConfiguration = {
        customAuth: {
            ...
            capabilities: ["mfa_required"],
            ...
        },
        ...
    };
    ```

The capability value `mfa_required` informs Microsoft Entra that your app can handle MFA flow. Learn more about [native authentication challenge types and capabilities](concept-native-authentication-challenge-types.md).


## Create UI components



## Register strong authentication method during sign-in

TODO

## Register strong authentication method after sign-up

TODO

## Register strong authentication method after password reset

TODO

## Run and test your app

[test during sign-in, sign-up and SSPR]

## Related content

TODO
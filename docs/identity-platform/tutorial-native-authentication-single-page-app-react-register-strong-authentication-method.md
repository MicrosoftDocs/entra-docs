---
title: Register Strong Auth Method in a React SPA by Using Native Authentication JavaScript SDK
description: Learn how to register a strong auth method in a React single-page application that uses native authentication JavaScript SDK

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 11/18/2025
#Customer intent: As a developer, I want enable multifactor authentication in a React single-page application that uses native authentication's JavaScript SDK so that users can complete an MFA challenge during sign in and password reset.
---

# Tutorial: Register strong authentication method in a React single-page app by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you will register strong authentication method for a user in your React single-page application (SPA) by using native authentication's JavaScript SDK.

If you enable multifactor authentication (MFA), but the user has no registered strong authentication method, you need to enable the user register one before tokens can be issued.

The strong authentication method registration flow occurs in three scenarios:
- **During sign-in**: The user signs in but does not have a strong authentication method registered.
- **After sign-up**: The user successfully signs up and automatically proceeds to sign in.
- **After self-service password reset (SSPR)**: The user successfully resets their password and automatically proceeds to sign in.

The available strong authentication methods is **email** and **SMS** one-time passcode.

The flow diagram below illustrates the three scenarios:

:::image type="content" source="media/tutorial-native-authentication-single-page-app-react-register-strong-authentication-method/register-strong-authentication-method.png" alt-text="Register strong authentication method."::: 

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-react-sdk-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-react-sdk-sign-in.md) and [password reset](tutorial-native-authentication-single-page-app-react-sdk-reset-password.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- [Enable multifactor authentication (MFA) for your app](../external-id/customers/how-to-multifactor-authentication-customers.md).

## Enable app to handle strong authentication method registration 

To enable the strong authentication method registration in your React app, update the app configuration by adding the required capability.

1. Locate the *src/config/auth-config.ts* file.
1. In the `customAuth` object, add `capabilities` property with the `registration_required` value in the array as shown in the following coe snippet:

    ```typescript
    const customAuthConfig: CustomAuthConfiguration = {
        customAuth: {
            ...
            capabilities: ["registration_required"],
            ...
        },
        ...
    };
    ```

The capability value `registration_required` informs Microsoft Entra that your app can handle strong authentication method registration flow. [Learn more about native authentication challenge types and capabilities](concept-native-authentication-challenge-types.md). 

## Create UI components

You require form components to handle strong authentication method registration. Use the following steps to add these components to your app:

1. Create a new folder, *src/app/shared/components* to store reusable components.
1. In the new folder, create a file, `AuthMethodRegistrationForm.tsx`, to display a form that allows users to select and register a strong authentication method. Add the code in [AuthMethodRegistrationForm](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/shared/components/AuthMethodRegistrationForm.tsx) into the file.
1. In the new folder, create another file, `AuthMethodRegistrationChallengeForm.tsx`, to display a form for verifying the strong authentication method by using the one-time passcode that the user receives. Add the code in [AuthMethodRegistrationChallengeForm](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/shared/components/AuthMethodRegistrationChallengeForm.tsx) into the file.

When needed, you can import then use reusable components in your sign-in, sign-in after sign-up, and sign-in after SSPR flows. 
 

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
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

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-angular-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-angular-sign-in.md), [password reset](tutorial-native-authentication-single-page-app-angular-reset-password.md) and [register strong authentication method](tutorial-native-authentication-single-page-app-angular-register-strong-authentication-method.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- [Enable multifactor authentication (MFA) for your app](../external-id/customers/how-to-multifactor-authentication-customers.md).


## Enable app to handle multifactor authentication

To enable MFA in your Angular app, update the app configuration by adding the required capability:

1. Locate the *src/app/config/auth-config.ts* file.

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

The capability value `mfa_required` informs Microsoft Entra that your app can handle an MFA flow. Learn more about [native authentication challenge types and capabilities](concept-native-authentication-challenge-types.md).

## Create UI components

You require form components in your app to support MFA flow, such as to select MFA challenge method and submit MFA challenge. 

### Create multifactor authentication method selection form

1. In in your console, navigate to the *src/app/components/shared* folder, then use Angular CLI to create a component, such as *mfa-auth-method-selection-form* by using the following command:

    ```console
    ng generate component mfa-auth-method-selection-form
    ```

    This command generates *mfa-auth-method-selection-form.component.html* and *mfa-auth-method-selection-form.component.ts* files in the folder *src/app/components/shared/mfa-auth-method-selection-form/*.

1. Open the *mfa-auth-method-selection-form.component.ts* file, then replace its contents with the content in [mfa-auth-method-selection-form.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/mfa-auth-method-selection-form/mfa-auth-method-selection-form.component.ts).
1. Open the *mfa-auth-method-selection-form.component.html* file, then add the contents in [mfa-auth-method-selection-form.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/mfa-auth-method-selection-form/mfa-auth-method-selection-form.component.html). 

### Create multifactor authentication challenge form

1. In in your console, navigate to the *src/app/components/shared* folder, then use Angular CLI to create a component, such as *mfa-challenge-form* by using the following command:

    ```console
    ng generate component mfa-challenge-form
    ```
    
    This command generates *mfa-challenge-form.component.ts* and *mfa-challenge-form.component.html* files in the folder *src/app/components/shared/mfa-challenge-form/*.

1. Open the *mfa-challenge-form.component.ts* file, then replace its contents with the content in [mfa-challenge-form.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/mfa-challenge-form/mfa-challenge-form.component.ts).
1. Open the *mfa-challenge-form.component.html* file, then add the contents in [mfa-challenge-form.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/mfa-challenge-form/mfa-challenge-form.component.html).


## Handle multifactor authentication during sign-in

Update the *src/app/components/sign-in/sign-in.component.ts* file to enable your app to handle MFA flow during sign-in. See the complete code in [sign-in.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.ts):

1. 
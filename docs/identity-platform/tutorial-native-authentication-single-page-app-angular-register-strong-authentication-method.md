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

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-angular-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-angular-sign-in.md) and [password reset](tutorial-native-authentication-single-page-app-angular-reset-password.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js 20.x or later](https://nodejs.org/en/download/).
- [Angular CLI](https://angular.dev/tools/cli/setup-local) installed globally. This example uses version 19.2.1.
- [Enable multifactor authentication (MFA) for your app](../external-id/customers/how-to-multifactor-authentication-customers.md).


## Enable app to handle strong authentication method registration

To enable the strong authentication method registration in your React app, update the app configuration by adding the required capability:

1. Locate the *src/app/config/auth-config.ts* file.
1. In the `customAuth` object, add or update the `capabilities` property to include the `registration_required` value in the array as shown in the following coe snippet:

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

The capability value `registration_required` informs Microsoft Entra that your app can handle strong authentication method registration flow. Learn more about [native authentication challenge types and capabilities](concept-native-authentication-challenge-types.md). 


## Create UI components

You require form components to handle strong authentication method registration.

### Create strong authentication method selection form 

1. In in your console, navigate to the *src/app/components/shared* folder, the create a component, such as *auth-method-selection-form* by running the following command:
    ```console
    ng generate component auth-method-selection-form
    ```

    This command generates *src/app/components/shared/auth-method-selection-form/auth-method-selection-form.component.html* and *src/app/components/shared/auth-method-selection-form/auth-method-selection-form.component.ts* files.
1. Open the *auth-method-selection-form.component.ts* file, then replace its contents with the content in [auth-method-selection-form.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/auth-method-selection-form/auth-method-selection-form.component.ts).
1. Open the *auth-method-selection-form.component.html* file, then add the contents in [auth-method-selection-form.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/auth-method-selection-form/auth-method-selection-form.component.html)


### Create strong authentication method challenge form 

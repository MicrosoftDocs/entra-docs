---
title: Register Strong Auth Method in an Angular SPA by Using Native Authentication JavaScript SDK
description: Learn how to register a strong auth method in an Angular single-page application that uses native authentication JavaScript SDK

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 01/18/2026

#Customer intent: As a developer, I want to enable strong authentication method registration flow in an Angular single-page application that uses native authentication's JavaScript SDK so that users can register a strong method registration during sign-in or after password reset or after sign-up.
---

# Tutorial: Register strong authentication method in an Angular single-page app by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you register a strong authentication method for a user in your Angular single-page application (SPA) by using native authentication's JavaScript SDK.

If you enable multifactor authentication (MFA), but the user has no registered strong authentication method, you need to have the user register one before tokens can be issued.

The strong authentication method registration flow occurs in three scenarios:

- **During sign-in**: The user signs in but doesn't have a strong authentication method registered.
- **After signup**: The user successfully signs up and automatically proceeds to sign in.
- **After self-service password reset (SSPR)**: The user successfully resets their password and automatically proceeds to sign in.

When strong authentication method registration is required, the user selects a method of choice from a list of supported methods. The available methods are **email** and **SMS** one-time passcode.

The flow diagram below illustrates the three scenarios:

:::image type="content" source="media/native-authentication-single-page-app-react-register-authentication-method/register-strong-authentication-method.png" alt-text="Register strong authentication method."::: 

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-angular-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-angular-sign-in.md) and [password reset](tutorial-native-authentication-single-page-app-angular-reset-password.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js 20.x or later](https://nodejs.org/en/download/).
- [Angular CLI](https://angular.dev/tools/cli/setup-local) installed globally. This example uses version 19.2.1.
- [Enable multifactor authentication (MFA) for your app](../external-id/customers/how-to-multifactor-authentication-customers.md).


## Enable app to handle strong authentication method registration

To enable the strong authentication method registration in your React app, update the app configuration by adding the required capability:

1. Locate the *src/app/config/auth-config.ts* file.
1. In the `customAuth` object, add or update the `capabilities` property to include the `registration_required` value in the array as shown in the following code snippet:

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

You require form components to handle strong authentication method registration. The following sections show how to add form components.

### Create strong authentication method selection form 

1. In in your console, navigate to the *src/app/components/shared* folder, then use Angular CLI to create a component such as *auth-method-selection-form* by using the following command:

    ```console
    ng generate component auth-method-selection-form
    ```

    This command generates *auth-method-selection-form.component.html* and *auth-method-selection-form.component.ts* files in the folder *src/app/components/shared/auth-method-selection-form/*.
1. Open the *auth-method-selection-form.component.ts* file, then replace its contents with the content in [auth-method-selection-form.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/auth-method-selection-form/auth-method-selection-form.component.ts).
1. Open the *auth-method-selection-form.component.html* file, then add the contents in [auth-method-selection-form.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/auth-method-selection-form/auth-method-selection-form.component.html)


### Create strong authentication method challenge form 

1. In in your console, navigate to the *src/app/components/shared* folder, then use Angular CLI to create a component, such as *auth-method-challenge-form* by using the following command:

    ```console
    ng generate component auth-method-challenge-form
    ```
    
    This command generates *auth-method-challenge-form.component.ts* and *auth-method-challenge-form.component.html* files in the folder *src/app/components/shared/auth-method-challenge-form/*.

1. Open the *auth-method-challenge-form.component.ts* file, then replace its contents with the content in [auth-method-challenge-form.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/auth-method-challenge-form/auth-method-challenge-form.component.ts).
1. Open the *auth-method-challenge-form.component.html* file, then add the contents in [auth-method-challenge-form.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/auth-method-challenge-form/auth-method-challenge-form.component.html)

## Register strong authentication method during sign-in

Update the *src/app/components/sign-in/sign-in.component.ts* file to enable your app to handle strong authentication method registration flow during sign-in. See the complete code in [sign-in.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.ts):

1. Import the necessary types and components:
    
    ```typescript
    import {
        AuthMethodRegistrationRequiredState,
        AuthenticationMethod,
        AuthMethodVerificationRequiredState,
    } from "@azure/msal-browser/custom-auth";
    import { AuthMethodSelectionFormComponent } from "../shared/auth-method-selection-form/auth-method-selection-form.component";
    import { AuthMethodChallengeFormComponent } from "../shared/auth-method-challenge-form/auth-method-challenge-form.component";
    
    @Component({
        selector: "app-sign-in",
        templateUrl: "./sign-in.component.html",
        standalone: true,
        imports: [
            ...
            AuthMethodSelectionFormComponent,
            AuthMethodChallengeFormComponent,
            ...
        ],
    })
    ```

1. Add new variables for strong authentication method registration:

    ```typescript
    showAuthMethodsForRegistration = false;
    showChallengeForRegistration = false;
    authMethodsForRegistration: AuthenticationMethod[] = [];
    selectedAuthMethodForRegistration: AuthenticationMethod | undefined = undefined;
    verificationContactForRegistration: string | undefined = undefined;
    challengeForRegistration: string | undefined = undefined;
    ```

1. Update the `startSignIn`, `handlePasswordSubmit` and `handleCodeSubmit` functions to check if strong authentication method registration is required:

    ```typescript
    async startSignIn() {
        const client = await this.auth.getClient();
        const result: SignInResult = await client.signIn({ username: this.username });
        
        ...
        
        if (result.isAuthMethodRegistrationRequired()) {
            this.showAuthMethodsForRegistration = true;
            this.showPassword = false;
            this.showCode = false;
            this.showChallengeForRegistration = false;
            this.showMfaAuthMethods = false;
            this.showMfaChallenge = false;
            this.authMethodsForRegistration = result.state.getAuthMethods();
            // Set default selection to the first auth method
            this.selectedAuthMethodForRegistration =
                this.authMethodsForRegistration.length > 0 ? this.authMethodsForRegistration[0] : undefined;
            this.signInState = result.state;
        }
    
        ...
    }
    
    async submitPassword() {
        if (this.signInState instanceof SignInPasswordRequiredState) {
            const result = await this.signInState.submitPassword(this.password);
            
            ...
            
            if (result.isAuthMethodRegistrationRequired()) {
                this.showAuthMethodsForRegistration = true;
                this.showPassword = false;
                this.showCode = false;
                this.showChallengeForRegistration = false;
                this.showMfaAuthMethods = false;
                this.showMfaChallenge = false;
                this.authMethodsForRegistration = result.state.getAuthMethods();
                // Set default selection to the first auth method
                this.selectedAuthMethodForRegistration =
                    this.authMethodsForRegistration.length > 0 ? this.authMethodsForRegistration[0] : undefined;
                this.signInState = result.state;
            }
    
            ...
        }
    }
    
    async submitCode() {
        if (this.signInState instanceof SignInCodeRequiredState) {
            const result = await this.signInState.submitCode(this.code);
    
            ...
    
            if (result.isAuthMethodRegistrationRequired()) {
                this.showAuthMethodsForRegistration = true;
                this.showPassword = false;
                this.showCode = false;
                this.showChallengeForRegistration = false;
                this.showMfaAuthMethods = false;
                this.showMfaChallenge = false;
                this.authMethodsForRegistration = result.state.getAuthMethods();
                // Set default selection to the first auth method
                this.selectedAuthMethodForRegistration =
                    this.authMethodsForRegistration.length > 0 ? this.authMethodsForRegistration[0] : undefined;
                this.signInState = result.state;
            }
        }
    }
    ```

    In each of the functions, notice that we check if strong authentication method registration is required by using the following code snippet:

    ```typescript
    if (result.isAuthMethodRegistrationRequired()) {...}
    ```

1. Add the handler for strong authentication method selection:

    ```typescript
    async submitAuthMethodForRegistration() {
        this.error = "";
        this.loading = true;
    
        if (!this.selectedAuthMethodForRegistration || !this.verificationContactForRegistration) {
            this.error = "Please select an authentication method and enter a verification contact.";
            this.loading = false;
            return;
        }
    
        if (this.signInState instanceof AuthMethodRegistrationRequiredState) {
            const result = await this.signInState.challengeAuthMethod({
                authMethodType: this.selectedAuthMethodForRegistration,
                verificationContact: this.verificationContactForRegistration,
            });
    
            if (result.isFailed()) {
                if (result.error?.isInvalidInput()) {
                    this.error = "Incorrect verification contact.";
                } else if (result.error?.isVerificationContactBlocked()) {
                    this.error =
                        "The verification contact is blocked. Consider using a different contact or a different authentication method.";
                } else {
                    this.error =
                        result.error?.errorData?.errorDescription ||
                        "An error occurred while verifying the authentication method.";
                }
            }
    
            if (result.isCompleted()) {
                this.isSignedIn = true;
                this.userData = result.data;
                this.showAuthMethodsForRegistration = false;
                this.signInState = result.state;
            }
    
            if (result.isVerificationRequired()) {
                this.showAuthMethodsForRegistration = false;
                this.showChallengeForRegistration = true;
                this.signInState = result.state;
            }
        }
        this.loading = false;
    }
    ```
1. Add the handler for strong authentication method verification:

    ```typescript
    async submitChallengeForRegistration() {
        this.error = "";
        this.loading = true;
    
        if (!this.challengeForRegistration) {
            this.error = "Please enter a code.";
            this.loading = false;
            return;
        }
    
        if (this.signInState instanceof AuthMethodVerificationRequiredState) {
            const result = await this.signInState.submitChallenge(this.challengeForRegistration);
    
            if (result.isFailed()) {
                if (result.error?.isIncorrectChallenge()) {
                    this.error = "Incorrect code.";
                } else {
                    this.error =
                        result.error?.errorData?.errorDescription ||
                        "An error occurred while verifying the challenge response.";
                }
            }
    
            if (result.isCompleted()) {
                this.isSignedIn = true;
                this.userData = result.data;
                this.showChallengeForRegistration = false;
                this.signInState = result.state;
            }
        }
        this.loading = false;
    }
    ```

1. Update the *sign-in.component.html* file to include the authentication method registration forms. See a complete example in [sign-in.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.html):

    ```typescript
    <!-- Use shared auth method selection form -->
    <app-auth-method-selection-form *ngIf="showAuthMethodsForRegistration" [authMethods]="authMethodsForRegistration"
        [selectedAuthMethod]="selectedAuthMethodForRegistration"
        [verificationContact]="verificationContactForRegistration" [loading]="loading"
        [getPlaceholderText]="getPlaceholderTextForVerificationContact.bind(this)"
        (selectedAuthMethodChange)="selectedAuthMethodForRegistration = $event"
        (verificationContactChange)="verificationContactForRegistration = $event"
        (submitForm)="submitAuthMethodForRegistration()">
    </app-auth-method-selection-form>
    
    <!-- Use shared challenge form -->
    <app-auth-method-challenge-form *ngIf="showChallengeForRegistration" [challenge]="challengeForRegistration"
        [loading]="loading" (challengeChange)="challengeForRegistration = $event"
        (submitForm)="submitChallengeForRegistration()">
    </app-auth-method-challenge-form>
    ```

## Register strong authentication method after signup or password reset

Strong authentication method registration flow after signup and password reset works similar to the method registration during sign-in flow. After a successful signup or password reset, the SDK can automatically continue with the sign-in. If the user doesn't have a strong authentication method registered, the flow transitions to the authentication method registration states.

### Register strong authentication method after signup

For strong authentication method registration after signup flow, you need you update the *src/app/components/sign-up/sign-up.component.ts* file. See the complete code in [sign-up.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.ts):

1. Make sure you import the required types and components.

1. Handle the strong authentication method registration states in a similar manner as it happens in the sign-in flow. After signup completes successfully, you can use the result to automatically trigger a sign-in as shown in the following code snippet:

    ```typescript
    // In your sign-up completion handler
    if (this.signUpState instanceof SignUpCompletedState) {
        const result = await this.signUpState.signIn();
    
        ...
    
        if (result.isAuthMethodRegistrationRequired()) {
            this.showAuthMethodsForRegistration = true;
            this.showPassword = false;
            this.showCode = false;
            this.showChallengeForRegistration = false;
            this.showMfaAuthMethods = false;
            this.showMfaChallenge = false;
            this.authMethodsForRegistration = result.state.getAuthMethods();
            // Set default selection to the first auth method
            this.selectedAuthMethodForRegistration =
                this.authMethodsForRegistration.length > 0 ? this.authMethodsForRegistration[0] : undefined;
            this.signUpState = result.state;
        } 
    
        ...
    }
    ```

1. Update the *sign-up.component.html* file to add the authentication method registration forms (*auth-method-selection-form* and *auth-method-challenge-form*) in a similar manner as shown in the sign-in flow. See a complete example in [sign-up.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.html).


### Register strong authentication method after password reset

For strong authentication method registration after SSPR, you need to update the */src/app/components/reset-password/reset-password.component.ts* file. See the complete code in [reset-password.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/reset-password/reset-password.component.ts):

1. Make sure you import the required types and components.
1. Handle the strong authentication method registration states in a similar manner as in the sign-in flow. After SSPRS completes successfully, you can use the result to automatically trigger a sign-in as shown in the following code snippet:


    ```typescript
    if (this.resetState instanceof ResetPasswordCompletedState) {
        const result = await this.resetState.signIn();
    
        ...
    
        if (result.isAuthMethodRegistrationRequired()) {
            this.showAuthMethodsForRegistration = true;
            this.showCode = false;
            this.showNewPassword = false;
            this.showChallengeForRegistration = false;
            this.showMfaAuthMethods = false;
            this.showMfaChallenge = false;
            this.isReset = false;
            this.authMethodsForRegistration = result.state.getAuthMethods();
            // Set default selection to the first auth method
            this.selectedAuthMethodForRegistration =
                this.authMethodsForRegistration.length > 0 ? this.authMethodsForRegistration[0] : undefined;
            this.resetState = result.state;
        }
    
        ...
    }    
    ```

 1. Update the *reset-password.component.html* file to add the authentication method registration forms (*auth-method-selection-form* and *auth-method-challenge-form*) in a similar manner as shown in the sign-in flow. See a complete example in [reset-password.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/reset-password/reset-password.component.html).

## Run and test your app

Use the steps in [Run and test your app](tutorial-native-authentication-single-page-app-angular-sign-up.md#test-the-sign-up-flow) to run your app, but this time, test the strong authentication method registration flow. 

### Test authentication method registration after signup 

1. Navigate to [http://localhost:4200/sign-up](http://localhost:3000/sign-up) to display the signup form.

1. Enter the required details, then sign up by following prompts. After you successfully sign up, the app automatically continues to sign-in flow by displaying the strong authentication method registration form.

1. Select the strong authentication method of choice, such as **Emails OTP**, then enter an email address.

1. Select **Continue** to submit the form details. You should receive a verification code to your email address.

1. Enter the verification code in the challenge form textbox, then select **Continue** button. After the code is verified, your strong authentication method is registered and you're signed in. 

### Test strong authentication method registration during sign-in

To test strong authentication method registration during sign-in, make sure you have a user account that doesn't have a strong authentication method registered.

1. Navigate to [http://localhost:4200/sign-in](http://localhost:3000/sign-in) to display the sign-in form.

1. Input your details, select the **Continue** button, then follow the prompts. The app enters strong authentication method registration flow. 

1. Follow the app prompts to complete strong authentication method registration.

### Test authentication method registration after password reset 

To test strong authentication method registration after SSPR, make sure you have a user account that doesn't have a strong authentication method registered.

1. Navigate to [http://localhost:4200/reset-password](http://localhost:3000/reset-password) to display the password reset form.

1. Input your details, select the **Continue** button, then follow app prompts to complete the password reset flow. After you successfully reset your password, the app continues to sign-in flow by displaying the strong authentication method registration form.

1. Follow the app prompts to complete strong authentication method registration.

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Enable multifactor authentication in an Angular SPA by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-angular-enable-mfa.md)

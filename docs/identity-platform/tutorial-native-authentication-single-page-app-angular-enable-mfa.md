---
title: Enable MFA in an Angular SPA by Using Native Authentication JavaScript SDK
description: Learn how to enable multifactor authentication in an Angular single-page application that uses native authentication JavaScript SDK

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 01/18/2026
#Customer intent: As a developer, I want enable multifactor authentication in an Angular single-page application that uses native authentication's JavaScript SDK so that users can complete an MFA challenge during sign in and password reset.
---

# Tutorial: Enable multifactor authentication in an Angular single-page app by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to add multifactor authentication (MFA) in your Angular single-page application (SPA) by using native authentication's JavaScript SDK.

Just like in [strong authentication method registration](tutorial-native-authentication-single-page-app-angular-register-strong-method.md), MFA flow occurs in three scenarios:

- **During sign-in**: The user signs in and has a strong authentication method registered.
- **After signup**: After the user completes signup, they proceed to sign in. New users need to [register a strong authentication method](tutorial-native-authentication-single-page-app-angular-register-strong-method.md) before any MFA challenge. Because the strong authentication method also gets verified during registration, they might not be prompted for an additional MFA challenge.
- **After self-service password reset (SSPR)**: The user successfully resets their password and automatically proceeds to sign in. If the user has a strong authentication method registered, they're prompted to complete MFA challenge.

When MFA is required, the user chooses an MFA challenge method from a list of registered methods. Available options are **email** one-time passcode, **SMS** one-time passcode, or both, depending on what the user previously registered.

The flow diagram below illustrates the three scenarios:

:::image type="content" source="media/native-authentication-single-page-app-react-register-authentication-method/register-strong-authentication-method.png" alt-text="Complete multifactor authentication challenge.":::

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-angular-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-angular-sign-in.md), [password reset](tutorial-native-authentication-single-page-app-angular-reset-password.md) and [register strong authentication method](tutorial-native-authentication-single-page-app-angular-register-strong-method.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- [Enable multifactor authentication (MFA) for your app](../external-id/customers/how-to-multifactor-authentication-customers.md).


## Enable app to handle multifactor authentication

To enable MFA in your Angular app, update the app configuration by adding the required capability:

1. Locate the *src/app/config/auth-config.ts* file.

1. In the `customAuth` object, add or update `capabilities` property to include the `mfa_required` value in the array as shown in the following code snippet:

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

1. In in your console, navigate to the *src/app/components/shared* folder, then use Angular CLI to create a component such as *mfa-auth-method-selection-form* by using the following command:

    ```console
    ng generate component mfa-auth-method-selection-form
    ```

    This command generates *mfa-auth-method-selection-form.component.html* and *mfa-auth-method-selection-form.component.ts* files in the folder *src/app/components/shared/mfa-auth-method-selection-form/*.

1. Open the *mfa-auth-method-selection-form.component.ts* file, then replace its contents with the content in [mfa-auth-method-selection-form.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/mfa-auth-method-selection-form/mfa-auth-method-selection-form.component.ts).
1. Open the *mfa-auth-method-selection-form.component.html* file, then add the contents in [mfa-auth-method-selection-form.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/mfa-auth-method-selection-form/mfa-auth-method-selection-form.component.html). 

### Create multifactor authentication challenge form

1. In in your console, navigate to the *src/app/components/shared* folder, then use Angular CLI to create a component such as *mfa-challenge-form* by using the following command:

    ```console
    ng generate component mfa-challenge-form
    ```
    
    This command generates *mfa-challenge-form.component.ts* and *mfa-challenge-form.component.html* files in the folder *src/app/components/shared/mfa-challenge-form/*.

1. Open the *mfa-challenge-form.component.ts* file, then replace its contents with the content in [mfa-challenge-form.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/mfa-challenge-form/mfa-challenge-form.component.ts).
1. Open the *mfa-challenge-form.component.html* file, then add the contents in [mfa-challenge-form.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/shared/mfa-challenge-form/mfa-challenge-form.component.html).


## Handle multifactor authentication during sign-in

Update the *src/app/components/sign-in/sign-in.component.ts* file to enable your app to handle MFA flow during sign-in. See the complete code in [sign-in.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.ts):

1. Import the required types and components as shown in the following code snippet:

    ```typescript
    import {
        AuthenticationMethod,
        MfaAwaitingState,
        MfaVerificationRequiredState,
    } from "@azure/msal-browser/custom-auth";
    import { MfaAuthMethodSelectionFormComponent } from "../shared/mfa-auth-method-selection-form/mfa-auth-method-selection-form.component";
    import { MfaChallengeFormComponent } from "../shared/mfa-challenge-form/mfa-challenge-form.component";
    
    @Component({
        selector: "app-sign-in",
        templateUrl: "./sign-in.component.html",
        standalone: true,
        imports: [
            ...
            MfaAuthMethodSelectionFormComponent,
            MfaChallengeFormComponent,
            ...
        ],
    })
    ```

1. Add new state variables for MFA:

    ```typescript
    export default function SignIn() {
        ...
        // MFA states
    const [mfaAuthMethods, setMfaAuthMethods] = useState<AuthenticationMethod[]>([]);
    const [selectedMfaAuthMethod, setSelectedMfaAuthMethod] = useState<AuthenticationMethod | undefined>(undefined);
    const [mfaChallenge, setMfaChallenge] = useState("");
    
        // ... initialization code
    }
    ```

1. Update the `startSignIn`, `handlePasswordSubmit`, and `handleCodeSubmit` functions to check if MFA is required:

    ```typescript
    async startSignIn() {
        const client = await this.auth.getClient();
        const result: SignInResult = await client.signIn({ username: this.username });
        
        ...
        
        if (result.isMfaRequired()) {
            this.showMfaAuthMethods = true;
            this.showPassword = false;
            this.showCode = false;
            this.showAuthMethodsForRegistration = false;
            this.showChallengeForRegistration = false;
            this.showMfaChallenge = false;
            this.mfaAuthMethods = result.state.getAuthMethods();
            // Set default selection to the first MFA auth method
            this.selectedMfaAuthMethod = this.mfaAuthMethods.length > 0 ? this.mfaAuthMethods[0] : undefined;
            this.signInState = result.state;
        }
    
        ...
    }
    
    async submitPassword() {
        if (this.signInState instanceof SignInPasswordRequiredState) {
            const result = await this.signInState.submitPassword(this.password);
            
            ...
            
            if (result.isMfaRequired()) {
                this.showMfaAuthMethods = true;
                this.showPassword = false;
                this.showCode = false;
                this.showAuthMethodsForRegistration = false;
                this.showChallengeForRegistration = false;
                this.showMfaChallenge = false;
                this.mfaAuthMethods = result.state.getAuthMethods();
                // Set default selection to the first MFA auth method
                this.selectedMfaAuthMethod = this.mfaAuthMethods.length > 0 ? this.mfaAuthMethods[0] : undefined;
                this.signInState = result.state;
            }
    
            ...
        }
    }
    
    async submitCode() {
        if (this.signInState instanceof SignInCodeRequiredState) {
            const result = await this.signInState.submitCode(this.code);
    
            ...
    
            if (result.isMfaRequired()) {
                this.showMfaAuthMethods = true;
                this.showPassword = false;
                this.showCode = false;
                this.showAuthMethodsForRegistration = false;
                this.showChallengeForRegistration = false;
                this.showMfaChallenge = false;
                this.mfaAuthMethods = result.state.getAuthMethods();
                // Set default selection to the first MFA auth method
                this.selectedMfaAuthMethod = this.mfaAuthMethods.length > 0 ? this.mfaAuthMethods[0] : undefined;
                this.signInState = result.state;
            }
        }
    }
    ```

    In each of the functions, notice that we check if MFA is required by using the following code snippet:

    ```typescript
    if (result.isMfaRequired()) {...}
    ```
 
1. Add the handler for MFA challenge selection:

    ```typescript
    async submitMfaAuthMethod() {
        this.error = "";
        this.loading = true;
    
        if (!this.selectedMfaAuthMethod) {
            this.error = "Please select an authentication method.";
            this.loading = false;
            return;
        }
    
        if (this.signInState instanceof MfaAwaitingState) {
            const result = await this.signInState.requestChallenge(this.selectedMfaAuthMethod.id);
    
            if (result.isFailed()) {
                if (result.error?.isInvalidInput()) {
                    this.error = "Incorrect verification contact.";
                } else {
                    this.error =
                        result.error?.errorData?.errorDescription ||
                        "An error occurred while verifying the authentication method.";
                }
            }
    
            if (result.isVerificationRequired()) {
                this.showMfaAuthMethods = false;
                this.showMfaChallenge = true;
                this.signInState = result.state;
            }
        }
        this.loading = false;
    }
    ```

1. Add the handler for MFA challenge verification:

    ```typescript
    async submitMfaChallenge() {
        this.error = "";
        this.loading = true;
    
        if (!this.mfaChallenge) {
            this.error = "Please enter a code.";
            this.loading = false;
            return;
        }
    
        if (this.signInState instanceof MfaVerificationRequiredState) {
            const result = await this.signInState.submitChallenge(this.mfaChallenge);
    
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
                this.showMfaChallenge = false;
                this.signInState = result.state;
            }
        }
        this.loading = false;
    }
    ```

1. Update the */src/app/components/sign-in/sign-in.component.html* files to display the correct MFA challenge forms (MFA challenge method selection or MFA challenge method verification):

    ```typescript
    <!-- Use shared MFA auth method selection form -->
    <app-mfa-auth-method-selection-form *ngIf="showMfaAuthMethods" [authMethods]="mfaAuthMethods"
        [selectedAuthMethod]="selectedMfaAuthMethod" [loading]="loading"
        (selectedAuthMethodChange)="selectedMfaAuthMethod = $event" (submitForm)="submitMfaAuthMethod()">
    </app-mfa-auth-method-selection-form>
    
    <!-- Use shared MFA challenge form -->
    <app-mfa-challenge-form *ngIf="showMfaChallenge" [challenge]="mfaChallenge" [loading]="loading"
        (challengeChange)="mfaChallenge = $event" (submitForm)="submitMfaChallenge()">
    </app-mfa-challenge-form>
    ```

## Handle multifactor authentication after signup or password reset

MFA flow after signup and password reset works similar to the MFA in the sign-in flow. After a successful signup or password reset, the SDK can automatically continue with the sign-in flow. If the user has a strong authentication method registered, the flow transitions to MFA challenge verification.

### Handle multifactor authentication after signup

For MFA flow after signup, you need you update the */src/app/components/sign-up/sign-up.component.ts* file. See the complete code in [sign-up.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.ts):

1. Make sure you import the required types and components.

1. Handle MFA requirements states in a similar manner as it happens in the sign-in flow; after signup completes successfully, use the result to automatically trigger a sign-in flow as shown in the following code snippet:

    ```typescript
    // In your sign-up completion handler
    if (this.signUpState instanceof SignUpCompletedState) {
        const result = await this.signUpState.signIn();
    
        ...
    
        if (result.isMfaRequired()) {
            this.showMfaAuthMethods = true;
            this.showPassword = false;
            this.showCode = false;
            this.showAuthMethodsForRegistration = false;
            this.showChallengeForRegistration = false;
            this.showMfaChallenge = false;
            this.mfaAuthMethods = result.state.getAuthMethods();
            // Set default selection to the first MFA auth method
            this.selectedMfaAuthMethod = this.mfaAuthMethods.length > 0 ? this.mfaAuthMethods[0] : undefined;
            this.signUpState = result.state;
        }
    
        ...
    }
    ```

1. Update your */src/app/components/sign-up/sign-up.component.html* file to add the MFA forms (MFA method selection form and MFA challenge verification form). See a complete example in [sign-up.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.html).


### Handle multifactor authentication after password reset

For MFA flow after SSPR, you need you update the */src/app/components/reset-password/reset-password.component.ts* file. See the complete code in [reset-password.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/reset-password/reset-password.component.ts):

1. Make sure you import the required types and components.

1. Handle MFA requirements states in a similar manner as it happens in the sign-in flow; after signup completes successfully, use the result to automatically trigger a sign-in flow as shown in the following code snippet:

    ```typescript
    if (this.resetState instanceof ResetPasswordCompletedState) {
        const result = await this.resetState.signIn();
    
        ...
    
        if (result.isMfaRequired()) {
            this.showMfaAuthMethods = true;
            this.showCode = false;
            this.showNewPassword = false;
            this.showAuthMethodsForRegistration = false;
            this.showChallengeForRegistration = false;
            this.showMfaChallenge = false;
            this.isReset = false;
            this.mfaAuthMethods = result.state.getAuthMethods();
            // Set default selection to the first MFA auth method
            this.selectedMfaAuthMethod = this.mfaAuthMethods.length > 0 ? this.mfaAuthMethods[0] : undefined;
            this.resetState = result.state;
        }
    
        ...
    }
    ```

1. Update your */src/app/components/reset-password/reset-password.component.html* file to add the MFA forms (MFA method selection form and MFA challenge verification form). See a complete example in [reset-password.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/reset-password/reset-password.component.html).

## Run and test your app

Before you test your app, make sure you have a user account that has a registered strong authentication method. Use the steps in [Run and test your app](tutorial-native-authentication-single-page-app-angular-register-strong-method.md#run-and-test-your-app) to run your app, but this time, test the MFA flow.

## Related content

- [Native authentication in Microsoft Entra External ID](concept-native-authentication.md)
- [Native authentication capabilities and challenge types](concept-native-authentication-challenge-types.md)
- [Native authentication web fallback](concept-native-authentication-web-fallback.md)

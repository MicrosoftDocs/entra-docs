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

Just like in [strong authentication method registration](tutorial-native-authentication-single-page-app-react-register-strong-method.md), MFA flow occurs in three scenarios:

- **During sign-in**: The user signs in and has a strong authentication method registered.
- **After signup**: After the user completes signup, they proceed to sign in. New users need to [register a strong authentication method](tutorial-native-authentication-single-page-app-react-register-strong-method.md) before any MFA challenge. Because the strong authentication method also gets verified during registration, they might not be prompted for an additional MFA challenge.
- **After self-service password reset (SSPR)**: The user successfully resets their password and automatically proceeds to sign in. If the user has a strong authentication method registered, they're prompted to complete MFA challenge.

When MFA is required, the user chooses an MFA challenge method from a list of registered methods. Available options are **email** one-time passcode, **SMS** one-time passcode, or both, depending on what the user previously registered.

The flow diagram below illustrates the three scenarios:

:::image type="content" source="media/native-authentication-single-page-app-react-register-authentication-method/register-strong-authentication-method.png" alt-text="Complete multifactor authentication challenge.":::

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-react-sdk-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-react-sdk-sign-in.md), [password reset](tutorial-native-authentication-single-page-app-react-sdk-reset-password.md) and [register strong authentication method](tutorial-native-authentication-single-page-app-react-register-strong-method.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- [Enable multifactor authentication (MFA) for your app](../external-id/customers/how-to-multifactor-authentication-customers.md).

## Enable app to handle multifactor authentication 

To enable MFA in your React app, update the app configuration by adding the required capability:

1. Locate the *src/config/auth-config.ts* file.
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

You require form components in your app to support MFA flow. Use the following steps to add these components to your app:

1. Create a new folder, *src/app/shared/components* for reusable components (if it doesn’t already exist).
1. In the new folder, create a file named *MfaAuthMethodSelectionForm.tsx* to display a form that allows users to select a registered strong authentication method. Add the code in [MfaAuthMethodSelectionForm](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/shared/components/MfaAuthMethodSelectionForm.tsx) into the file.
1. In the new folder, create another file named *MfaChallengeForm.tsx* to display a form for verifying the strong authentication method by using the one-time passcode that the user receives. Add the code in [MfaChallengeForm](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/shared/components/MfaChallengeForm.tsx) into the file.

When needed, you can import and use reusable components in your sign-in, sign-in after signup, and sign-in after SSPR flows. 

## Handle multifactor authentication during sign-in

Update the *src/app/sign-in/page.tsx* file to enable your app to handle MFA flow during sign-in. See the complete code in [page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/page.tsx):

1. Import the required types and components as shown in the following code snippet:

    ```typescript
    import {
        CustomAuthPublicClientApplication,
        ICustomAuthPublicClientApplication,
        SignInCodeRequiredState,
        SignInCompletedState,
        AuthFlowStateBase,
        MfaAwaitingState,
        MfaVerificationRequiredState,
    } from "@azure/msal-browser/custom-auth";
    import { MfaAuthMethodSelectionForm } from "../components/shared/MfaAuthMethodSelectionForm";
    import { MfaChallengeForm } from "../components/shared/MfaChallengeForm";
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

1. Update the `startSignIn`, `handlePasswordSubmit` and `handleCodeSubmit` functions to check if MFA is required:

    ```typescript
    const startSignIn = async (e: React.FormEvent) => {
        // Start the sign-in flow
        const result = await authClient.signIn({
            username,
        });
    
        ...
    
        if (result.isMfaRequired()) {
            const methods = result.state.getAuthMethods();
            setMfaAuthMethods(methods);
            setSelectedMfaAuthMethod(methods.length > 0 ? methods[0] : undefined);
        }
    
        ...
    };
    
    const handlePasswordSubmit = async (e: React.FormEvent) => {
        if (signInState instanceof SignInPasswordRequiredState) {
            const result = await signInState.submitPassword(password);
    
            ...
    
            // Check for MFA requirement
            if (result.isMfaRequired()) {
                const methods = result.state.getAuthMethods();
                setMfaAuthMethods(methods);
                setSelectedMfaAuthMethod(methods.length > 0 ? methods[0] : undefined);
                setSignInState(result.state);
            }
            
            ...
        }
    };
    
    const handleCodeSubmit = async (e: React.FormEvent) => {
        if (signInState instanceof SignInCodeRequiredState) {
            const result = await signInState.submitCode(code);
    
            ...
            
            // Check for MFA requirement
            if (result.isMfaRequired()) {
                const methods = result.state.getAuthMethods();
                setMfaAuthMethods(methods);
                setSelectedMfaAuthMethod(methods.length > 0 ? methods[0] : undefined);
                setSignInState(result.state);
            }
    
            ...
        }
    };
    ```

    In each of the function, notice that we check if MFA is required by using the following code snippet:

    ```typescript
    if (result.isMfaRequired()) {...}
    ```

1. Add the handler for MFA challenge selection:

    ```typescript
    const handleMfaAuthMethodSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        if (!selectedMfaAuthMethod) {
            setError("Please select an authentication method.");
            setLoading(false);
            return;
        }
    
        if (signInState instanceof MfaAwaitingState) {
            const result = await signInState.requestChallenge(selectedMfaAuthMethod.id);
    
            if (result.isFailed()) {
                if (result.error?.isInvalidInput()) {
                    setError("Incorrect verification contact.");
                } else {
                    setError(
                        result.error?.errorData?.errorDescription ||
                            "An error occurred while verifying the authentication method"
                    );
                }
            }
    
            if (result.isVerificationRequired()) {
                setSignInState(result.state);
            }
        }
    
        setLoading(false);
    };
    ```

1. Add the handler for MFA challenge verification:

    ```typescript
    const handleMfaChallengeSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        if (!mfaChallenge) {
            setError("Please enter a code.");
            setLoading(false);
            return;
        }
    
        if (signInState instanceof MfaVerificationRequiredState) {
            const result = await signInState.submitChallenge(mfaChallenge);
    
            if (result.isFailed()) {
                if (result.error?.isIncorrectChallenge()) {
                    setError("Incorrect code.");
                } else {
                    setError(
                        result.error?.errorData?.errorDescription ||
                            "An error occurred while verifying the challenge response"
                    );
                }
            }
    
            if (result.isCompleted()) {
                setData(result.data);
                setCurrentSignInStatus(true);
                setSignInState(result.state);
            }
        }
    
        setLoading(false);
    };
    ```

1. Update the `renderForm()` function to display the correct MFA challenge forms (MFA challenge method selection or MFA challenge method verification):

    ```typescript
    const renderForm = () => {
        if (loadingAccountStatus) {
            return;
        }
    
        ...
    
        // Display MfaAuthMethodSelectionForm if the current state is MFA awaiting state
        if (signInState instanceof MfaAwaitingState) {
            return (
                <MfaAuthMethodSelectionForm
                    onSubmit={handleMfaAuthMethodSubmit}
                    authMethods={mfaAuthMethods}
                    selectedAuthMethod={selectedMfaAuthMethod}
                    setSelectedAuthMethod={setSelectedMfaAuthMethod}
                    loading={loading}
                    styles={styles}
                />
            );
        }
    
        // Display MfaChallengeForm if the current state is MFA verification required state
        if (signInState instanceof MfaVerificationRequiredState) {
            return (
                <MfaChallengeForm
                    onSubmit={handleMfaChallengeSubmit}
                    challenge={mfaChallenge}
                    setChallenge={setMfaChallenge}
                    loading={loading}
                    styles={styles}
                />
            );
        }
    
        ...
    };
    ```

## Handle multifactor authentication after sign-up or password reset 

MFA flow after signup and password reset works similar to the MFA in the sign-in flow. After a successful signup or password reset, the SDK can automatically continue with the sign-in flow. If the user has a strong authentication method registered, the flow transitions to MFA challenge verification. 

### Handle multifactor authentication after signup

For MFA flow after signup, you need you update the */src/app/sign-up/page.tsx* file. See the complete code in [page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx):
 
1. Make sure you import the required types and components.
1. Handle MFA requirements states in a similar manner as it happens in the sign-in flow; after sign-up completes successfully, use the result to automatically trigger a sign-in flow as shown in the following code snippet:

    ```typescript
    // In your sign-up completion handler
    if (signUpState instanceof SignUpCompletedState) {
        // Continue with sign-in using the continuation token
        const result = await signUpState.signIn();
    
        ...
    
        if (result.isMfaRequired()) {
            const methods = result.state.getAuthMethods();
            setMfaAuthMethods(methods);
            setSelectedMfaAuthMethod(methods.length > 0 ? methods[0] : undefined);
            setSignUpState(state);
        }
    
        ...
    }
    
    // Then use the same renderForm logic to display MfaAuthMethodSelectionForm
    // and MfaChallengeForm components
    ```

### Handle multifactor authentication after password reset

For MFA flow after SSPR, you need to update the */src/app/reset-password/page.tsx* file. See the complete code in [page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/page.tsx):

1. Make sure you import the required types and components.
1. Handle MFA requirement states in a similar manner as in the sign-in flow. After SSPRS completes successfully, you can use the result to automatically trigger a sign-in as shown in the following code snippet:

    ```typescript
    // In your password reset completion handler
    if (resetPasswordState instanceof ResetPasswordCompletedState) {
        // Continue with sign-in using the continuation token
        const result = await signUpState.signIn();
    
        ...
    
        if (result.isMfaRequired()) {
            const methods = result.state.getAuthMethods();
            setMfaAuthMethods(methods);
            setSelectedMfaAuthMethod(methods.length > 0 ? methods[0] : undefined);
            setResetState(state);
        }
    
        ...
    }
    
    // Then use the same renderForm logic to display MfaAuthMethodSelectionForm
    // and MfaChallengeForm components
    ```

## Run and test your app

Before you test your app, make sure you have a user account that has a registered strong authentication method. Use the steps in [Run and test your app](tutorial-native-authentication-single-page-app-react-register-strong-method.md#run-and-test-your-app) to run your app, but this time, test the MFA flow. 

## Related content

- [Native authentication in Microsoft Entra External ID](concept-native-authentication.md)
- [Native authentication capabilities and challenge types](concept-native-authentication-challenge-types.md)
- [Native authentication web fallback](concept-native-authentication-web-fallback.md)

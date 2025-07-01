---
title: Sign in users in React SPA by using native authentication JavaScript SDK
description: Learn how to build a React single-page app that signs in users in a React single-page app into an external tenant by using native authentication JavaScript SDK .

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 06/30/2025
#Customer intent: As a developer, I want to build a React single-page application that uses native authentication JavaScript SDK so that I can sign in users with a username (email) and password or email with one-time passcode.
---

# Tutorial: Sign in users into a React single-page app by using native authentication JavaScript SDK (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to sign in users into a React single-page app (SPA) by using native authentication JavaScript SDK. 

In this tutorial, you:

>[!div class="checklist"]
>
> - Update a React app to sign in users.
> - Test the sign-in flow.

## Prerequisites

- Complete the steps in [Tutorial: Setup CORS Proxy server to manage CORS headers for native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-react-sdk-set-up-local-cors.md).


## Create UI components

In this section, you create the form that collects the user's sign-in information:

1. Create a folder called *src/app/sign-in*.

1. Create *sign-in/components/InitialForm.tsx* file, then paste the code from [sign-in/components/InitialForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/components/InitialForm.tsx). This component displays a form that collects a user's username (email). 

1. In your choice of authentication method is email and one-time passcode, create a *sign-in/components/CodeForm.tsx* file, then paste the code from [sign-in/components/CodeForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/components/CodeForm.tsx). If the administrator set email one-time passcode as the sign-in flow in the Microsoft Entra admin center, this component displays a form to collect the one-time passcode from the user. 

1. In your choice of authentication method is email and password, create a *sign-in/components/PasswordForm.tsx* file, then paste the code from [sign-in/components/PasswordForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/CodeForm.tsx). This component displays a form that collects a user's password.

1. Create a *sign-in/components/UserInfo.tsx* file, then paste the code from [sign-in/components/UserInfo.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/components/UserInfo.tsx). This component displays a signed-in user's username and sign-in status. 


## Handle form interactions

In this section, you add code that handles sign-in form interactions such as starting a sign-in flow, submitting user password or a one-time passcode.

Create *sign-in/page.tsx* file to handle logic for a sign-in flow. In this file:

- Import the necessary components and display the proper form based on the state. See a full example in [sign-in/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/page.tsx):

    ```typescript
    import {
      CustomAuthPublicClientApplication,
      ICustomAuthPublicClientApplication,
      SignInCodeRequiredState,
      // Uncommon if using a Email + Password flow
      // SignInPasswordRequiredState,
      SignInCompletedState,
      AuthFlowStateBase,
    } from "@azure/msal-browser/custom-auth";
    
    export default function SignIn() {
        const [authClient, setAuthClient] = useState<ICustomAuthPublicClientApplication | null>(null);
        const [username, setUsername] = useState("");
        //If you are sign in using a Email + Password flow, uncomment the following line
        //const [password, setPassword] = useState("");
        const [code, setCode] = useState("");
        const [error, setError] = useState("");
        const [loading, setLoading] = useState(false);
        const [signInState, setSignInState] = useState<AuthFlowStateBase | null>(null);
        const [data, setData] = useState<CustomAuthAccountData | undefined>(undefined);
        const [loadingAccountStatus, setLoadingAccountStatus] = useState(true);
        const [isSignedIn, setCurrentSignInStatus] = useState(false);
    
        useEffect(() => {
            const initializeApp = async () => {
                const appInstance = await CustomAuthPublicClientApplication.create(customAuthConfig);
                setAuthClient(appInstance);
            };
    
            initializeApp();
        }, []);
    
        useEffect(() => {
            const checkAccount = async () => {
                if (!authClient) return;
    
                const accountResult = authClient.getCurrentAccount();
    
                if (accountResult.isCompleted()) {
                    setCurrentSignInStatus(true);
                }
    
                setData(accountResult.data);
    
                setLoadingAccountStatus(false);
            };
    
            checkAccount();
        }, [authClient]);
    
        const renderForm = () => {
            if (loadingAccountStatus) {
                return;
            }
    
            if (isSignedIn || signInState instanceof SignInCompletedState) {
                return <UserInfo userData={data} />;
            }
            //If you are signing up using Email + Password flow, uncomment the following block of code
            /*
            if (signInState instanceof SignInPasswordRequiredState) {
                return (
                    <PasswordForm
                        onSubmit={handlePasswordSubmit}
                        password={password}
                        setPassword={setPassword}
                        loading={loading}
                    />
                );
            }
            */
            if (signInState instanceof SignInCodeRequiredState) {
                return <CodeForm onSubmit={handleCodeSubmit} code={code} setCode={setCode} loading={loading} />;
            }
    
            return <InitialForm onSubmit={startSignIn} username={username} setUsername={setUsername} loading={loading} />;
        };
    
        return (
            <div style={styles.container}>
                <h2 style={styles.h2}>Sign In</h2>
                <>
                    {renderForm()}
                    {error && <div style={styles.error}>{error}</div>}
                </>
            </div>
        );
    }
    ```

- To start the sign-in flow, use the following code snippet. See a full example at [sign-in/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/page.tsx) to learn where to place the code snippet:

    ```typescript
    const startSignIn = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        if (!authClient) return;
    
        // Start the sign-in flow
        const result = await authClient.signIn({
            username,
        });
    
        // Thge result may have the different states,
        // such as Password required state, OTP code rquired state, Failed state and Completed state.
    
        if (result.isFailed()) {
            if (result.error?.isUserNotFound()) {
                setError("User not found");
            } else if (result.error?.isInvalidUsername()) {
                setError("Username is invalid");
            } else if (result.error?.isPasswordIncorrect()) {
                setError("Password is invalid");
    
            } else {
                setError(`An error occurred: ${result.error?.errorData?.errorDescription}`);
            }
        }
    
        if (result.isCompleted()) {
            setData(result.data);
        }
    
        setSignInState(result.state);
    
        setLoading(false);
    };
    ```

    The SDK's instance method, `signIn()`, starts the sign-in flow.

- If your choice of authentication flow is email and one-time passcode, submit the one-time passcode by using the following code snippet. See a full example at [sign-in/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx) to learn where to place the code snippet: 


    ```typescript
    const handleCodeSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        if (signInState instanceof SignInCodeRequiredState) {
            const result = await signInState.submitCode(code);
    
            // the result object may have the different states, such as Failed state and Completed state.
    
            if (result.isFailed()) {
                if (result.error?.isInvalidCode()) {
                    setError("Invalid code");
                } else {
                    setError(result.error?.errorData?.errorDescription || "An error occurred while verifying the code");
                }
            }
    
            if (result.isCompleted()) {
                setData(result.data);
                setSignInState(result.state);
            }
        }
    
        setLoading(false);
    };
    ```

    Sign in state's `submitCode()` submits the one-time passcode.

- If your choice of authentication flow is email and password, submit the user's password by using the following code snippet. See a full example at [sign-in/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx) to learn where to place the code snippet: 
    
    ```typescript
    const handlePasswordSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        if (signInState instanceof SignInPasswordRequiredState) {
            const result = await signInState.submitPassword(password);
    
            if (result.isFailed()) {
                if (result.error?.isInvalidPassword()) {
                    setError("Incorrect password");
                } else {
                    setError(
                        result.error?.errorData?.errorDescription || "An error occurred while verifying the password"
                    );
                }
            }
    
            if (result.isCompleted()) {
                setData(result.data);
    
                setSignInState(result.state);
            }
        }
    
        setLoading(false);
    };
    ```

    Sign in state's `submitPassword()` submits the user's password.


## Handle sign-up errors

During sign-in, not all actions succeed. For instance, the user might attempt to sign in with a username that doesn't exist or submit an invalid email one-time passcode or a password that doesn't meet the minimum requirements. Make sure you handle errors properly when you:

- Start the sign-in flow in the `signIn()` method.

- Submit the one-time passcode in the `submitCode()` method.

- Submit password in the `submitPassword()` method. You handle this error if your choice of sign-up flow is by email and password.


One of the errors that can result from the `signIn()` method is `result.error?.isRedirectRequired()`. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For example, if the authorization server requires capabilities that the client can't provide. Learn more about [native authentication web fallback](concept-native-authentication-web-fallback.md) and how to [support web fallback](tutorial-native-authentication-single-page-app-javascript-sdk-web-fallback.md) in your React app.

## Run and test your app

Use the steps in [Run and test your app](tutorial-native-authentication-single-page-app-react-sdk-set-up-local-cors.md#run-and-test-you-app) to run your app, then test sign-in flow. 

## Related content

- [Tutorial: Reset password in a React single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-react-sdk-reset-password.md)
- [support web fallback](tutorial-native-authentication-single-page-app-javascript-sdk-web-fallback.md) in your React app.
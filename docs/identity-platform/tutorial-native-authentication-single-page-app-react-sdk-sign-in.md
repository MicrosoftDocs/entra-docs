---
title: Sign in users in React SPA by using native authentication JavaScript SDK
description: Learn how to build a React single-page app that signs in users in a React single-page app into an external tenant by using native authentication.

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

1. Create a folder called *src/app/sign-in* in the *src* folder.

1. Create *sign-in/components/InitialForm.tsx* file, then paste the code from [sign-in/components/InitialForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/components/InitialForm.tsx). This component displays a form that collects a user's username (email). 

1. Create a *sign-in/components/PasswordForm.tsx* file, then paste the code from [sign-in/components/PasswordForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/CodeForm.tsx). This component displays a form that collects a user's password.

1. Create a *sign-in/components/UserInfo.tsx* file, then paste the code from [sign-in/components/UserInfo.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/components/UserInfo.tsx). This component displays a signed-in user's username and sign-in status. 

1. Create a *sign-in/components/CodeForm.tsx* file, then paste the code from [sign-in/components/CodeForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/components/CodeForm.tsx). If the administrator set email one-time passcode as the sign-in method in the Microsoft Entra admin center, this component displays form to collect the one-time passcode from the user.


## Handle form interactions

In this section, you add code that handles sign-in form interactions such as submitting user password.

Create *sign-in/page.tsx* file, then paste the code in [sign-in/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/page.tsx). In this file:

- Import the necessary components and display a proper form based on the state:

    ```typescript
    export default function SignUpPassword() {
        const [username, setUsername] = useState("");
        const [password, setPassword] = useState("");
        const [code, setCode] = useState("");
        const [error, setError] = useState("");
        const [loading, setLoading] = useState(false);
        const [signInState, setSignInState] = useState<any>(null);
        const [data, setData] = useState<any>(null);
    
        const renderForm = () => {
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
            if (signInState instanceof SignInCompletedState) {
                return <UserInfo signInState={data} />;
            }
    
            return (
                <InitialForm
                    onSubmit={handleInitialSubmit}
                    username={username}
                    setUsername={setUsername}
                    loading={loading}
                />
            );
        };
    
        return (
            <div style={styles.container}>
                <h2>Sign In</h2>
                <>
                    {renderForm()}
                    {error && <div style={styles.error}>{error}</div>}
                </>
            </div>
        );
    }
    ```

- Handle the initial submit...

    ```typescript
    {TODO: TODO}
    ```

- Handle the password submission:

    ```typescript
    const handlePasswordSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        try {
            if (signInState instanceof SignInPasswordRequiredState) {
                const result = await signInState.submitPassword(password);
    
                if (result.error) {
                    if (result.error.errorData?.error === "invalid_password") {
                        setError("Incorrect password");
                    } else {
                        setError(
                            result.error.errorData?.errorDescription || "An error occurred while verifying the password"
                        );
                    }
                    return;
                }
                setData(result.data);
                setSignInState(result.state);
            }
        } catch (err) {
            handleError(err, setError);
        } finally {
            setLoading(false);
        }
    };
    ```




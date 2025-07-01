---
title: Reset password in a React SPA app by using native authentication JavaScript SDK
description: Learn how to build a React single-page app that enables users to reset their passwords in a React single-page app into an external tenant by using native authentication JavaScript SDK.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 06/30/2025
#Customer intent: As a developer, I want to build a React single-page application that uses native authentication JavaScript SDK so that I can sign in users with a username (email) and password or email with one-time passcode.
---

# Tutorial: Reset password in a React single-page app by using native authentication JavaScript SDK(preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to enable password reset in a React single-page app by using native authentication JavaScript SDK. 

In this tutorial, you:

>[!div class="checklist"]
>
> - Update the React app to reset user's password.
> - Test password reset flow


## Prerequisites

- Complete the steps in [Tutorial: Set up CORS proxy server to manage CORS headers for native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-react-sdk-set-up-local-cors.md).
- [Enable self-service password reset (SSPR)](../external-id/customers/how-to-enable-password-reset-customers.md) for customer users in the external tenant. SSPR is available for customer users for apps that use email with password authentication flow.

## Create UI components

During password reset flow, this app, collects the user's username (email), a one-time passcode, and a new user password on different screens. In this section, you create the forms that collects the information the app requires to reset the password.

1. Create a folder called *src/app/reset-password*.

1. Create *reset-password/components/InitialForm.tsx* file, then paste the code from [reset-password/components/InitialForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/components/InitialForm.tsx). This component displays a form that collects a user's username (email). 

1. Create *reset-password/components/CodeForm.tsx* file, then paste the code from [reset-password/components/CodeForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/components/CodeForm.tsx). This component displays a form that collects the one-time passcode that the user receives in their email inbox. 

1. Create *reset-password/components/NewPasswordForm.tsx* file, then paste the code from [reset-password/components/NewPasswordForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/components/NewPasswordForm.tsx). This component displays a form that collects a user's new password. 

1. Create *reset-password/components/ResetPasswordResult.tsx* file, then paste the code from [reset-password/components/ResetPasswordResult.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/components/ResetPasswordResult.tsx). This component displays password reset status.


### Handle form interactions

Create *reset-password/page.tsx* file to handle logic for a sign-in flow. In this file:

- Import the necessary components and display the proper form based on the state. See a full example in [reset-password/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/page.tsx):

    
    ```typescript
    import {
      CustomAuthPublicClientApplication,
      ICustomAuthPublicClientApplication,
      ResetPasswordCodeRequiredState,
      ResetPasswordPasswordRequiredState,
      ResetPasswordCompletedState,
      AuthFlowStateBase,
    } from "@azure/msal-browser/custom-auth";
  
    export default function ResetPassword() {
      const [app, setApp] = useState<ICustomAuthPublicClientApplication | null>(
        null
      );
      const [loadingAccountStatus, setLoadingAccountStatus] = useState(true);
      const [isSignedIn, setSignInState] = useState(false);
      const [email, setEmail] = useState("");
      const [code, setCode] = useState("");
      const [newPassword, setNewPassword] = useState("");
      const [error, setError] = useState("");
      const [loading, setLoading] = useState(false);
      const [resetState, setResetState] = useState<AuthFlowStateBase | null>(
        null
      );
  
      useEffect(() => {
        const initializeApp = async () => {
          const appInstance = await CustomAuthPublicClientApplication.create(
            customAuthConfig
          );
          setApp(appInstance);
        };
  
        initializeApp();
      }, []);
  
      useEffect(() => {
        const checkAccount = async () => {
          if (!app) return;
  
          const accountResult = app.getCurrentAccount();
  
          if (accountResult.isCompleted()) {
            setSignInState(true);
          }
  
          setLoadingAccountStatus(false);
        };
  
        checkAccount();
      }, [app]);
  
      const renderForm = () => {
        if (loadingAccountStatus) {
          return;
        }
  
        if (isSignedIn) {
          return (
            <div style={styles.signed_in_msg}>
              Please sign out before processing the password reset.
            </div>
          );
        }
  
        if (resetState instanceof ResetPasswordPasswordRequiredState) {
          return (
            <NewPasswordForm
              onSubmit={handleNewPasswordSubmit}
              newPassword={newPassword}
              setNewPassword={setNewPassword}
              loading={loading}
            />
          );
        }
  
        if (resetState instanceof ResetPasswordCodeRequiredState) {
          return (
            <CodeForm
              onSubmit={handleCodeSubmit}
              code={code}
              setCode={setCode}
              loading={loading}
            />
          );
        }
  
        if (resetState instanceof ResetPasswordCompletedState) {
          return <ResetPasswordResultPage />;
        }
  
        return (
          <InitialForm
            onSubmit={handleInitialSubmit}
            email={email}
            setEmail={setEmail}
            loading={loading}
          />
        );
      };
  
      return (
        <div style={styles.container}>
          <h2 style={styles.h2}>Reset Password</h2>
          {renderForm()}
          {error && <div style={styles.error}>{error}</div>}
        </div>
      );
    }
    ```

- To start the password reset flow, use the following code snippet. See a full example at [reset-password/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/page.tsx) to learn where to place the code snippet:


    ```typescript
    const handleInitialSubmit = async (e: React.FormEvent) => {
        if (!app) return;
        e.preventDefault();
        setError("");
        setLoading(true);
        const result = await app.resetPassword({
            username: email,
        });
        const state = result.state;
        if (result.isFailed()) {
            if (result.error?.isInvalidUsername()) {
                setError("Invalid email address");
            } else if (result.error?.isUserNotFound()) {
                setError("User not found");
            } else {
                setError(
                    result.error?.errorData.errorDescription || "An error occurred while initiating password reset"
                );
            }
        } else {
            setResetState(state);
        }
        setLoading(false);
    };
    ```

    The SDK's instance method, `resetPassword()`, starts the sign-in flow.

- To submit the one-time passcode, use the following code snippet. See a full example at [reset-password/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/page.tsx) to learn where to place the code snippet: 

    ```typescript
    const handleCodeSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
        if (resetState instanceof ResetPasswordCodeRequiredState) {
            const result = await resetState.submitCode(code);
            const state = result.state;
            if (result.isFailed()) {
                if (result.error?.isInvalidCode()) {
                    setError("Invalid verification code");
                } else {
                    setError(result.error?.errorData.errorDescription || "An error occurred while verifying the code");
                }
            } else {
                setResetState(state);
            }
        }
        setLoading(false);
    };
    ```

    Password reset state's `submitCode()` submits the one-time passcode.

- To submit the user's new password, use the following code snippet. See a full example at [reset-password/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/page.tsx) to learn where to place the code snippet: 


    ```typescript
    const handleNewPasswordSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
        if (resetState instanceof ResetPasswordPasswordRequiredState) {
            const result = await resetState.submitNewPassword(newPassword);
            const state = result.state;
            if (result.isFailed()) {
                if (result.error?.isInvalidPassword()) {
                    setError("Invalid password");
                } else {
                    setError(result.error?.errorData.errorDescription || "An error occurred while setting new password");
                }
            } else {
                setResetState(state);
            }
        }
        setLoading(false);
    };
    ```

    Password reset state's `submitNewPassword()` submits the user's new password.


- To use the reset password result, use the following code snippet. See a full example at [reset-password/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/reset-password/page.tsx) to learn where to place the code snippet: 

    ```typescript
    if (resetState instanceof ResetPasswordCompletedState) {
        return <ResetPasswordResultPage state={resetState} />;
    }

## Optional: Sign in users automatically after password reset

After a user successfully resets their password, you can directly sign them into the app without initiating a new sign-in flow. To do so, use the following code snippet: 

```typescript
if (resetState instanceof ResetPasswordCompletedState) {
    const result = await resetState.signIn();
    const state = result.state;
    if (result.isFailed()) {
        setError(result.error?.errorData?.errorDescription || "An error occurred during auto sign-in");
    }
    if (result.isCompleted()) {
        setData(result.data);
        setResetState(state);
    }
}
```

## Run and test your app

Use the steps in [Run and test your app](tutorial-native-authentication-single-page-app-react-sdk-set-up-local-cors.md#run-and-test-you-app) to run your app, then test sign-in flow. 


## Related content

- [Set up a reverse proxy for a single-page app that uses MSAL JS SDK with native authentication by using Azure Function App](how-to-native-authentication-cors-solution-test-environment.md).
- [Use Azure Front Door as a reverse proxy in production environment for a single-page app that uses MSAL JS SDK with native authentication](how-to-native-authentication-cors-solution-production-environment.md).
- [MSAL JS SDK Reference](/javascript/api/overview/msal-overview).
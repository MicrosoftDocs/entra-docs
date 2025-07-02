---
title: Sign up users into a React SPA by using native authentication SDK
description: Learn how to build a React single-page application that uses native authentication JavaScript SDK to sign up users.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 06/30/2025
#Customer intent: As a developer, I want to build a React single-page application that uses native authentication's JavaScript SDK so that I can sign up users with email with password or email one-timepasscode authentication menthods
---

# Tutorial: Sign up users into a React single-page app by using native authentication JavaScript SDK (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to build a React single-page app that signs up users by using native authentication's JavaScript SDK.

In this tutorial, you:

>[!div class="checklist"]
> - Create a React Next.js project.
> - Add MSAL JS SDK to it.
> - Add UI components of the app.
> - Setup the project to sign up users.

## Prerequisites

- Complete the steps in [Quickstart: Sign in users in a React single-page app by using native authentication JavaScript SDK ](quickstart-native-authentication-single-page-app-react-sdk-sign-in.md). This quickstart shows you run a sample React code sample.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).


## Create a React project and install dependencies

In a location of choice in your computer, run the following commands to create a new React project with the name *reactspa*, navigate into the project folder, then install packages:

```console
npx create-next-app@latest
cd reactspa
npm install
```

After you successfully run the commands, you should have an app with the following structure:

```console
spasample/
└──node_modules/
   └──...
└──public/
   └──...
└──src/
   └──app/
      └──favicon.ico
      └──globals.css
      └──page.tsx
      └──layout.tsx
└──postcss.config.mjs
└──package-lock.json
└──package.json
└──tsconfig.json
└──README.md
└──next-env.d.ts
└──next.config.ts
```

## Add JavaScript SDK to your project

To use the native authentication JavaScript SDK into your project, use your terminal to install it by using the following command:

```console
npm intall @azure/msal-browser
```

The native authentication capabilities are part of the `azure-msal-browser` library. To use native authentication features, you import from `@azure/msal-browser/custom-auth`. For example:

```typescript
  import CustomAuthPublicClientApplication from "@azure/msal-browser/custom-auth";
```


## Add client configuration

In this section, you define a configuration for native authentication public client application to enable it to interact with the interface of the SDK. To do so, create a file called *src/config/auth-config.ts*, then add the following code:

```typescript
export const customAuthConfig: CustomAuthConfiguration = {
  customAuth: {
    challengeTypes: ["password", "oob", "redirect"],
    authApiProxyUrl: "http://localhost:3001/api",
  },
  auth: {
    clientId: "Enter_the_Application_Id_Here",
    authority: "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com",
    redirectUri: "/",
    postLogoutRedirectUri: "/",
    navigateToLoginRequestUrl: false,
  },
  cache: {
    cacheLocation: "sessionStorage",
  },
  system: {
    loggerOptions: {
      loggerCallback: (
        level: LogLevel,
        message: string,
        containsPii: boolean
      ) => {
        if (containsPii) {
          return;
        }
        switch (level) {
          case LogLevel.Error:
            console.error(message);
            return;
          case LogLevel.Info:
            console.info(message);
            return;
          case LogLevel.Verbose:
            console.debug(message);
            return;
          case LogLevel.Warning:
            console.warn(message);
            return;
        }
      },
    },
  },
};
```


In the code, find the placeholder:

- `Enter_the_Application_Id_Here` then replace it with the Application (client) ID of the app you registered earlier.

- `Enter_the_Tenant_Subdomain_Here` then replace it with the tenant subdomain in your Microsoft Entra admin center. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

## Create UI components

This app collects user details such as given name, username (email), password and a one-time passcode from the user. So, the app needs to have a form that collects this information.

1. Create a folder called *src/app/sign-up* in the *src* folder.

1. Create *sign-up/components/InitialForm.tsx* file, then paste the code from [sign-up/components/InitialForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/InitialForm.tsx). This component displays a form that collects user sign-up attributes. 

1. Create a *sign-up/components/CodeForm.tsx* file, then paste the code from [sign-up/components/CodeForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/CodeForm.tsx). This component displays a form that collects a one-time passcode sent to the user. You require this form for either email with password or email with one-time passcode authentication method. 

1. Create a *sign-up/components/SignUpResult.tsx* file, then paste the code from [sign-up/components/SignUpResult.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/SignUpResult.tsx). This component displays sing-up result. 

1. If your choice of authentication method is *email with password*, create a *sign-up/components/PasswordForm.tsx* file, then paste the code from [sign-up/components/PasswordForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/PasswordForm.tsx). This component displays a password input form. 

## Handle form interaction

In this section, you add code that handles sign-up form interactions such as submitting user sign-up details or a one-time passcode or a password.

Create *sign-up/page.tsx* to handle logic for a sign-up flow. In this file:

- Import the necessary components and display the proper form based on the state. See a full example in [sign-up/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx):

    ```typescript
        import { useEffect, useState } from "react";
        import { customAuthConfig } from "../../config/auth-config";
        import { styles } from "./styles/styles";
        import { InitialFormWithPassword } from "./components/InitialFormWithPassword";

        import {
        CustomAuthPublicClientApplication,
        ICustomAuthPublicClientApplication,
        SignUpCodeRequiredState,
        // Uncomment if your choice of authentication method is email with password
        // SignUpPasswordRequiredState,
        SignUpCompletedState,
        AuthFlowStateBase,
      } from "@azure/msal-browser/custom-auth";

        import { SignUpResultPage } from "./components/SignUpResult";
        import { CodeForm } from "./components/CodeForm";
        import { PasswordForm } from "./components/PasswordForm";    
    export default function SignUpPassword() {
        const [authClient, setAuthClient] = useState<ICustomAuthPublicClientApplication | null>(null);
        const [firstName, setFirstName] = useState("");
        const [lastName, setLastName] = useState("");
        const [jobTitle, setJobTitle] = useState("");
        const [city, setCity] = useState("");
        const [country, setCountry] = useState("");
        const [email, setEmail] = useState("");
        //Uncomment if your choice of authentication method is email with password
        //const [password, setPassword] = useState("");
        const [code, setCode] = useState("");
        const [error, setError] = useState("");
        const [loading, setLoading] = useState(false);
        const [signUpState, setSignUpState] = useState<AuthFlowStateBase | null>(null);
        const [loadingAccountStatus, setLoadingAccountStatus] = useState(true);
        const [isSignedIn, setSignInState] = useState(false);
    
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
                    setSignInState(true);
                }
                setLoadingAccountStatus(false);
            };
            checkAccount();
        }, [authClient]);
    
        const renderForm = () => {
            if (loadingAccountStatus) {
                return;
            }
            if (isSignedIn) {
                return (
                    <div style={styles.signed_in_msg}>Please sign out before processing the sign up.</div>
                );
            }
            if (signUpState instanceof SignUpCodeRequiredState) {
                return (
                    <CodeForm
                        onSubmit={handleCodeSubmit}
                        code={code}
                        setCode={setCode}
                        loading={loading}
                    />
                );
            } 
            //Uncomment the following block of code if your choice of authentication method is email with password 
            /*
            else if(signUpState instanceof SignUpPasswordRequiredState) {
                return <PasswordForm
                    onSubmit={handlePasswordSubmit}
                    password={password}
                    setPassword={setPassword}
                    loading={loading}
                />;
            }
            */
            else if (signUpState instanceof SignUpCompletedState) {
                return <SignUpResultPage />;
            } else {
                return (
                    <InitialForm
                        onSubmit={handleInitialSubmit}
                        firstName={firstName}
                        setFirstName={setFirstName}
                        lastName={lastName}
                        setLastName={setLastName}
                        jobTitle={jobTitle}
                        setJobTitle={setJobTitle}
                        city={city}
                        setCity={setCity}
                        country={country}
                        setCountry={setCountry}
                        email={email}
                        setEmail={setEmail}
                        loading={loading}
                    />
                );
            }
        }
        return (
            <div style={styles.container}>
                <h2 style={styles.h2}>Sign Up</h2>
                {renderForm()}
                {error && <div style={styles.error}>{error}</div>}
            </div>
        );
    }
    ```

    This code also creates an instance of the native authentication public client app by using the [client configuration](#add-client-configuration):

    ```typescript
    const appInstance = await CustomAuthPublicClientApplication.create(customAuthConfig);
    setAuthClient(appInstance);
    ```
    


- To handle the initial form submission, use the following code snippet. See a full example at [sign-up/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx) to learn where to place the code snippet:

    ```typescript
    const handleInitialSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        if (!authClient) return;
    
        const attributes: UserAccountAttributes = {
            displayName: `${firstName} ${lastName}`,
            givenName: firstName,
            surname: lastName,
            jobTitle: jobTitle,
            city: city,
            country: country,
        };
    
        const result = await authClient.signUp({
            username: email,
            attributes
        });
        const state = result.state;
    
        if (result.isFailed()) {
            if (result.error?.isUserAlreadyExists()) {
                setError("An account with this email already exists");
            } else if (result.error?.isInvalidUsername()) {
                setError("Invalid uername");
            } else if (result.error?.isInvalidPassword()) {
                setError("Invalid password");
            } else if (result.error?.isAttributesValidationFailed()) {
                setError("Invalid attributes");
            } else if (result.error?.isMissingRequiredAttributes()) {
                setError("Missing required attributes");
            } else {
                setError(result.error?.errorData.errorDescription || "An error occurred while signing up");
            }
        } else {
            setSignUpState(state);
        }
        setLoading(false);
    };
    ```
    The SDK's instance method, `signUp()` starts the sign-up flow.
    
- To handle the one-time passcode submission, use the following code snippet. See a full example at [sign-up/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx) to learn where to place the code snippet:

    ```typescript
    const handleCodeSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        try {
            if (signUpState instanceof SignUpCodeRequiredState) {
                const result = await signUpState.submitCode(code);
                if (result.error) {
                    if (result.error.isInvalidCode()) {
                        setError("Invalid verification code");
                    } else {
                        setError("An error occurred while verifying the code");
                    }
                    return;
                }
                if (result.state instanceof SignUpCompletedState) {
                    setSignUpState(result.state);
                }
            }
        } catch (err) {
            setError("An unexpected error occurred");
            console.error(err);
        } finally {
            setLoading(false);
        }
    };
    ```


- To handle password submission, use the following code snippet. You handle password submission if your choice of authentication method is *email with password*. See a full example at [sign-up/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx) to learn where to place the code snippet:

    ```typescript
        const handlePasswordSubmit = async (e: React.FormEvent) => {
            e.preventDefault();
            setError("");
            setLoading(true);
    
            if (signUpState instanceof SignUpPasswordRequiredState) {
                const result = await signUpState.submitPassword(password);
                const state = result.state;
    
                if (result.isFailed()) {
                    if (result.error?.isInvalidPassword()) {
                        setError("Invalid password");
                    } else {
                        setError(result.error?.errorData.errorDescription || "An error occurred while submitting the password");
                    }
                } else {
                    setSignUpState(state);
                }
            }
    
            setLoading(false);
        };
    ```

- Use the `signUpState instanceof SignUpCompletedState` to indicate that the user has been signed up and the flow is complete. See a full example at [sign-up/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx):

    ```typescript
    if (signUpState instanceof SignUpCompletedState) {
        return <SignUpResultPage/>;
    }
    ```
   
## Handle sign-up errors

During sign-up, not all actions succeed. For instance, the user might attempt to sign up with an already used email address or submit an invalid email one-time passcode. Make sure you handle errors properly when you:

- Start the sign-up flow in the `signUp()` method.

- Submit the one-time passcode in the `submitCode()` method.

- Submit password in the `submitPassword()` method. You handle this error if your choice of sign-up flow is by email and password.


One of the errors that can result from the `signUp()` method is `result.error?.isRedirectRequired()`. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For example, if the authorization server requires capabilities that the client can't provide. Learn more about [native authentication web fallback](concept-native-authentication-web-fallback.md) and how to [support web fallback](tutorial-native-authentication-single-page-app-javascript-sdk-web-fallback.md) in your React app.


## Optional: Sign in users automatically after sign-up

After a user successfully signs up, you can directly sign them into the app without initiating a new sign-in flow. To do so, use the following code snippet. See a full example at [sign-up/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx): 

```typescript
if (signUpState instanceof SignUpCompletedState) {
    const result = await signUpState.signIn();
    const state = result.state;
    if (result.isFailed()) {
        setError(result.error?.errorData?.errorDescription || "An error occurred during auto sign-in");
    }
    
    if (result.isCompleted()) {
        setData(result.data);
        setSignUpState(state);
    }
}
```

At this point, you can run your app, then view your sign-up UI at *http://localhost:3000/sign-up*. However, since native authentication API doesn't support CORS, you need to set up the CORS proxy server to manage the CORS headers.

## Set up poweredByHeader to false in next.config.js

By default, the `x-powered-by` header is included in the HTTP responses to indicate that the application is powered by Next.js. However, for security or customization reasons, you might want to remove or modify this header:

```typescript
const nextConfig: NextConfig = {
  poweredByHeader: false,
  /* other config options here */
};
```

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Set up CORS proxy server to manage CORS headers for native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-react-sdk-set-up-local-cors.md)
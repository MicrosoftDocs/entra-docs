---
title: Sign up users into a React SPA by using native authentication SDK
description: Learn how to build a React single-page application that uses native authentication API to sign up users.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 06/30/2025
#Customer intent: As a developer, I want to build a React single-page application that uses native authentication's JavaScript SDK so that I can sign up users with a username (email) and password.
---

# Tutorial: Sign up users into a React single-page app by using native authentication JavaScript SDK (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to build a React single-page app that signs up users by using native authentication's JavaScript SDK.

In this tutorial, you:

>[!div class="checklist"]
> - Create a React Next.js project.
> - Add MSAL JS SDK to it.
> - Add UI components of the app.
> - Setup the project to sign up user using username (email) and password.

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

## Add JavaScript SDK to your project

To use the native authentication JavaScript SDK into your project, opent the *package.json* file, then add the following dependencies:

```typescript
"dependencies": {
        "@azure/msal-common": "https://raw.githubusercontent.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/main/typescript/native-auth/azure-msal-common-15.2.1.tgz",
        "@azure/msal-browser": "https://raw.githubusercontent.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/main/typescript/native-auth/azure-msal-browser-4.7.0.tgz",
        ...
}
```

The native authentication capabilities are part of the `azure-msal-browser` library.

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
        storeAuthStateInCookie: false,
    },
    system: {
        loggerOptions: {
            loggerCallback: (level: LogLevel, message: string, containsPii: boolean) => {
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

* `Enter_the_Application_Id_Here` then replace it with the Application (client) ID of the app you registered earlier.

* `Enter_the_Tenant_Subdomain_Here` then replace it with the tenant subdomain in your Microsoft Entra admin center. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

## Create UI components

This app collects user details such as given name, username (email), and password and a one-time passcode from the user. So, the app needs to have a sign-up and a one-time passcode collection form.

1. Create a folder called *src/app/sign-up* in the src folder.

1. Create *sign-up/components/InitialFormWithPassword.tsx* file, then paste the code from [sign-up/components/InitialFormWithPassword.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/InitialFormWithPassword.tsx). This component displays a form that collects user sign-up details. 

1. Create a *sign-up/components/CodeForm.tsx* file, then paste the code from [sign-up/components/CodeForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/CodeForm.tsx). This component displays a form that collects a one-time passcode sent to the user.

1. Create a *sign-up/components/SignUpResult.tsx* file, then paste the code from [sign-up/components/SignUpResult.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/SignUpResult.tsx). This component displays sing-up result. 

## Handle form interaction

In this section, you add code that handles sign-up form interactions such as submitting user sign-up details or submitting a one-time passcode.

Create *sign-up/page.tsx* file, then paste the code in [sign-up/page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx). In this file:

- Import the necessary components and display the proper form based on the state:

    ```typescript
    export default function SignUpPassword() {
        const router = useRouter();
        const [firstName, setFirstName] = useState("");
        const [lastName, setLastName] = useState("");
        const [email, setEmail] = useState("");
        const [password, setPassword] = useState("");
        const [code, setCode] = useState("");
        const [error, setError] = useState("");
        const [loading, setLoading] = useState(false);
        const [signUpState, setSignUpState] = useState<any>(null);
    
        return (
            <div style={styles.container}>
                <h2>Sign Up with Password</h2>
                {signUpState instanceof SignUpCodeRequiredState ? (
                    <CodeForm onSubmit={handleCodeSubmit} code={code} setCode={setCode} loading={loading} />
                ) : (
                    <InitialFormWithPassword
                        onSubmit={handleInitialSubmit}
                        firstName={firstName}
                        setFirstName={setFirstName}
                        lastName={lastName}
                        setLastName={setLastName}
                        email={email}
                        setEmail={setEmail}
                        password={password}
                        setPassword={setPassword}
                        loading={loading}
                    />
                )}
                {error && <div style={styles.error}>{error}</div>}
            </div>
        );
    }
    ```

- Handle the initial form submission:

    ```typescript
    const handleInitialSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError("");
        setLoading(true);
    
        try {
            const app = await CustomAuthPublicClientApplication.create(customAuthConfig);
            const account = app.getCurrentAccount();
            account.data?.signOut();
    
            const attributes = new UserAccountAttributes();
            attributes.setDisplayName(`${firstName} ${lastName}`);
    
            const result = await app.signUp({
                username: email,
                password: password,
                attributes,
            });
    
            if (result.error) {
                if (result.error.isUserAlreadyExists()) {
                    setError("An account with this email already exists");
                } else {
                    setError(result.error.errorData.errorDescription || "An error occurred while signing up");
                }
                return;
            }
    
            setSignUpState(result.state);
        } catch (err) {
            setError("An unexpected error occurred");
            console.error(err);
        } finally {
            setLoading(false);
        }
    };
    ```

- Handle the one-time passcode submission:

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

At this point, you can run your app, then view your sign-up UI at *http://localhost:3000/sign-up*. However, since native authentication APIs don't support CORS, you need to set up the CORS proxy server to manage the CORS headers.

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Set up CORS proxy server to manage CORS headers for native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-react-sdk-set-up-local-cors.md)
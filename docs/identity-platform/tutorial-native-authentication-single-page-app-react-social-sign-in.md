---
title: Support Social Sign-in in a React SPA With Native Auth JS SDK
description: Learn how to add social sign-in with Google, Facebook, Apple, or custom OIDC providers to your React SPA using native authentication JavaScript SDK.
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 03/30/2026
ai-usage: ai-assisted
#Customer intent: As a developer, I want to support federated identity providers (social sign-in) in my React single-page application that uses native authentication JavaScript SDK so that users can sign up and sign in with Google, Facebook, Apple, or custom OIDC identity providers.
---

# Tutorial: Support federated identity providers in a React single-page app by using native authentication JavaScript SDK (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to let users sign up and sign in with their existing social accounts, such as Google, Facebook, or Apple, in your React single-page application (SPA) by using native authentication's JavaScript SDK for external tenants.


In this tutorial, you:

>[!div class="checklist"]
>
> * Update the app configuration to set a redirect URI.
> * Add federated identity provider buttons to sign-in and sign-up forms.
> * Handle sign-in and sign-up with federated identity providers.
> * Test the social sign-in flow.

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-react-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-react-sign-in.md), [password reset](tutorial-native-authentication-single-page-app-react-reset-password.md), [register strong authentication method](tutorial-native-authentication-single-page-app-react-register-strong-method.md), and [enable MFA](tutorial-native-authentication-single-page-app-react-enable-mfa.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js 20.x or later](https://nodejs.org/en/download/).
- Configure the federated identity providers you want to enable. Follow the steps in [Identity providers for external tenants](../external-id/customers/concept-authentication-methods-customers.md) for your chosen providers:
    - [Google](../external-id/customers/how-to-google-federation-customers.md)
    - [Facebook](../external-id/customers/how-to-facebook-federation-customers.md)
    - [Apple](../external-id/customers/how-to-apple-federation-customers.md)
    - [Custom OIDC identity providers](../external-id/customers/how-to-custom-oidc-federation-customers.md)

## Update the configuration to set the redirect URI

Make sure that the redirect URI is configured in the `CustomAuthConfiguration` interface and that its value matches one of the redirect URIs [configured in your app registration](how-to-add-redirect-uri.md) in the Microsoft Entra admin center:

1. Locate the *src/config/auth-config.ts* file.

1. In the `auth` object, add or update the `redirectUri` property, then make sure that its value matches one of the redirect URIs configured in your app registration in the Microsoft Entra admin center:

    ```typescript
    const customAuthConfig: CustomAuthConfiguration = {
        auth: {
            ...
            redirectUri: "/",
            ...
        },
        ...
    };
    ```

## Create UI components

In this section, you add federated identity provider buttons to your sign-in and sign-up forms, allowing users to authenticate with social identity providers (Google, Facebook, Apple) or custom OIDC identity providers (such as LinkedIn).

### Update the sign-in initial form

Update your sign-in `InitialForm.tsx` component to include federated identity provider buttons. You can find the complete example in [InitialForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/components/InitialForm.tsx).

1. Open `src/app/sign-in/components/InitialForm.tsx` and update the component to include the social provider buttons:

    ```typescript
    import type { SignInInitialFormProps } from "../types/formProperties";

    const socialProviders = [
        {
            name: "Google",
            domainHint: "Google",
        },
        {
            name: "Facebook",
            domainHint: "Facebook",
        },
        {
            name: "Apple",
            domainHint: "Apple",
        },
        {
            name: "LinkedIn",
            domainHint: "www.linkedin.com",
        },
    ];

    export const InitialForm = ({
        onSubmit,
        username,
        setUsername,
        loading,
        onSignInWithSocial,
    }: SignInInitialFormProps) => (
        <form onSubmit={onSubmit} style={styles.form}>
            ...

            <div style={styles.separator}>
                <div style={styles.separatorLine}></div>
                <span style={styles.separatorText}>OR</span>
                <div style={styles.separatorLine}></div>
            </div>

            {socialProviders.map((provider) => (
                <button
                    key={provider.domainHint}
                    type="button"
                    style={styles.socialButton}
                    onClick={() => onSignInWithSocial(provider.domainHint)}
                >
                    <span>Sign In with {provider.name}</span>
                </button>
            ))}
        </form>
    );
    ```

1. Update the `SignInInitialFormProps` interface in `src/app/sign-in/types/formProperties.ts`:

    ```typescript
    import { FormProps } from "@/app/shared/types/formProperties";

    export interface SignInInitialFormProps extends FormProps {
        ...
        onSignInWithSocial: (domainHint: string) => Promise<void>;
    }
    ```

### Update the sign-up initial form

Similarly, update your sign-up `InitialForm.tsx` component. You can find the complete example in [InitialForm.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/components/InitialForm.tsx).

1. Open `src/app/sign-up/components/InitialForm.tsx` and add the social providers array and buttons. Use the same structure from the sign-in `InitialForm.tsx`, but update the click handler to call `onSignUpWithSocial` and update the button text to say "Sign Up with."

1. Update the `SignUpInitialFormProps` interface in `src/app/sign-up/types/formProperties.ts`:

    ```typescript
    import { FormProps } from "@/app/shared/types/formProperties";

    export interface SignUpInitialFormProps extends FormProps {
        ...
        onSignUpWithSocial: (domainHint: string) => Promise<void>;
    }
    ```

## Handle form interaction

In this section, you implement the logic to handle sign-in and sign-up with federated identity providers. The implementation uses the `loginPopup` method from MSAL with a `PopupRequest` that includes the `domainHint` property. This property specifies which federated identity provider to use. For more information about `domainHint` configuration and issuer acceleration, see [Identity providers for External ID](../external-id/customers/concept-authentication-methods-customers.md).

### Update sign-up page to support federated identity providers

Update your sign-up `page.tsx` to handle authentication with federated identity providers. You can find the complete example in [page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-up/page.tsx).

1. Import the necessary types:

    ```typescript
    import { PopupRequest } from "@azure/msal-browser";
    ```

1. Add the handler function for federated identity provider sign-up in your sign-up `page.tsx`:

    ```typescript
    const startSignUpWithSocial = async (domainHint: string) => {
        setError("");
        setLoading(false);

        if (!authClient) return;

        const popUpRequest: PopupRequest = {
            authority: customAuthConfig.auth.authority,
            scopes: [],
            redirectUri: customAuthConfig.auth.redirectUri || "",
            prompt: "login",
            domainHint: domainHint,
        };

        try {
            await authClient.loginPopup(popUpRequest);

            const accountResult = authClient.getCurrentAccount();

            if (accountResult.isFailed()) {
                setError(
                    accountResult.error?.errorData?.errorDescription ??
                        "An error occurred while getting the account from cache"
                );
            }

            if (accountResult.isCompleted()) {
                setData(accountResult.data);
                setSignInState(true);
            }
        } catch (error) {
            if (error instanceof Error) {
                setError(error.message);
            } else {
                setError("An unexpected error occurred while logging in with popup");
            }
        }
    };
    ```

1. Update the `renderForm()` function to pass the handler to the `InitialForm` component:

    ```typescript
    const renderForm = () => {

        ... other state checks ...

        if (!signUpState) {
            return (
                <InitialForm
                    ...
                    onSignUpWithSocial={startSignUpWithSocial}
                />
            );
        }
    };
    ```

### Update sign-in page to support federated identity providers

Update your sign-in `page.tsx` to handle authentication with federated identity providers. You can find the complete example in [page.tsx](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/react-nextjs-sample/src/app/sign-in/page.tsx).

1. Import the necessary types:

    ```typescript
    import { PopupRequest } from "@azure/msal-browser";
    ```

1. Add the handler function for federated identity provider sign-in in your sign-in `page.tsx`:

    ```typescript
    const startSignInWithSocial = async (domainHint: string) => {
        setError("");
        setLoading(false);

        if (!authClient) return;

        const popUpRequest: PopupRequest = {
            authority: customAuthConfig.auth.authority,
            scopes: [],
            redirectUri: customAuthConfig.auth.redirectUri || "",
            prompt: "login",
            domainHint: domainHint,
        };

        try {
            await authClient.loginPopup(popUpRequest);

            const accountResult = authClient.getCurrentAccount();

            if (accountResult.isFailed()) {
                setError(
                    accountResult.error?.errorData?.errorDescription ??
                        "An error occurred while getting the account from cache"
                );
            }

            if (accountResult.isCompleted()) {
                setData(accountResult.data);
                setCurrentSignInStatus(true);
            }
        } catch (error) {
            if (error instanceof Error) {
                setError(error.message);
            } else {
                setError("An unexpected error occurred while logging in with popup");
            }
        }
    };
    ```

1. Update the `renderForm()` function to pass the handler to the `InitialForm` component:

    ```typescript
    const renderForm = () => {

        ... other state checks ...

        return (
            <InitialForm
                ...
                onSignInWithSocial={startSignInWithSocial}
            />
        );
    };
    ```

> [!NOTE]
> Microsoft Entra accounts and Microsoft accounts (MSA) identity providers aren't currently supported.

### PopupRequest configuration details

When you configure the `PopupRequest` for federated identity provider authentication:

- **authority**: Use your configured external tenant authority.
- **redirectUri**: The redirect URI you configured in your app registration.
- **prompt**: Set to `"login"` to force the user to enter credentials.
- **domainHint**: The key parameter that determines which federated identity provider to use.

The `loginPopup` method opens a popup window where the user completes the authentication flow with the selected federated identity provider. After authentication succeeds, the popup closes automatically, and the account information is available in your app.

## Run and test your app

Before you test your app, make sure your CORS proxy and app are running:

1. Make sure your CORS proxy is running:

    ```console
    npm run cors
    ```

1. Start your application:

    ```console
    npm run dev
    ```

### Test sign-up with federated identity providers

1. Navigate to `http://localhost:3000/sign-up` to see the sign-up form.

1. Select the button for the federated identity provider that you want to authenticate with, such as **Sign Up with Google**. A popup window opens, redirecting you to the Google authentication page.

1. Sign in with your Google account credentials (or create a new Google account if needed).

1. Grant the necessary permissions when prompted.

After successful authentication, you might be required to complete attribute collection if your tenant is configured to collect additional user attributes during sign-up. For more information, see [Collect user attributes during sign-up](../external-id/customers/concept-user-attributes.md).

The popup window closes automatically. You should be signed in and see your account information displayed in the app. A new user account is created in your external tenant using the information from your Google profile.

### Test sign-in with federated identity providers

1. Navigate to `http://localhost:3000/sign-in` to see the sign-in form.

1. Select the button for the federated identity provider that you want to authenticate with, such as **Sign In with Google**. A popup window opens, redirecting you to the Google authentication page.

1. Sign in with your Google account credentials. If this is your first time signing in with this identity provider, you might be prompted to consent to sharing your information with the application.

After successful authentication, you might be required to complete attribute collection if your tenant is configured to collect additional user attributes during sign-up. For more information, see [Collect user attributes during sign-up](../external-id/customers/concept-user-attributes.md).

The popup window closes automatically. You should now be signed in and see your account information displayed in the app.

### Multifactor authentication

When SMS or email one-time passcode (OTP) MFA is enabled, the MFA challenge is presented in the browser-delegated user experience after the social identity provider authentication completes.

For more information about enabling MFA, refer to [Multifactor authentication in external tenants](../external-id/customers/concept-multifactor-authentication-customers.md) and [Add multifactor authentication to an app](../external-id/customers/how-to-multifactor-authentication-customers.md).

## Troubleshoot common errors

Use this section to resolve common issues you might encounter when integrating federated identity providers.

### Popup window is blocked by the browser

The `loginPopup` method requires browser popups. If the popup is blocked, the authentication flow fails silently or throws an error.

**Solution**: Check your browser's popup blocker settings and allow popups from your application's domain (for example, `localhost:3000`). Instruct your users to do the same. Most browsers display a notification in the address bar when a popup is blocked.

### Domain hint not recognized

The federated identity provider authentication page doesn't appear, or you receive an error indicating the `domainHint` value is invalid.

**Solution**: Verify that the `domainHint` value in your `PopupRequest` matches exactly what you configured in your external tenant. Use the following values:

| Provider | Expected `domainHint` value |
|---|---|
| Google | `"Google"` |
| Facebook | `"Facebook"` |
| Apple | `"Apple"` |
| Custom OIDC (for example, LinkedIn) | The issuer URI you configured, such as `"www.linkedin.com"` |

### Authentication fails after the popup opens

The popup opens and redirects to the identity provider, but the authentication doesn't complete. Check the browser console for error messages.

**Solution**: Verify the following configurations:

1. The `redirectUri` in your `PopupRequest` matches one of the redirect URIs registered in your app registration in the Microsoft Entra admin center.
1. The client ID in your app configuration is correct.
1. The federated identity provider is properly configured in your external tenant and added to the relevant user flow.

### User account isn't created after sign-up

The user completes federated identity provider authentication, but a new account isn't created in the tenant.

**Solution**: Confirm that the federated identity provider is configured and enabled in the user flows for both sign-up and sign-in scenarios in your external tenant. When a user signs in with a federated identity provider for the first time, a new account is automatically created and linked to that provider. Subsequent sign-ins with the same provider use the existing account.

### CORS-related errors appear in the console

You see `Access-Control-Allow-Origin` or similar CORS errors in the browser console.

**Solution**: Make sure your CORS proxy is running correctly. Restart the proxy with `npm run cors` and verify it's accessible before retrying.

## Related content

- [Set up a reverse proxy for CORS in test environment](how-to-native-authentication-cors-solution-test-environment.md)
- [Set up a reverse proxy for CORS in production environment](how-to-native-authentication-cors-solution-production-environment.md)
- [MSAL JS SDK Reference](/javascript/api/overview/msal-overview?view=msal-js-latest&preserve-view=true)

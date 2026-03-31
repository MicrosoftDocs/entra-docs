---
title: Support Social Sign-in in an Angular SPA With Native Auth JS SDK
description: Learn how to add social sign-in with Apple, Facebook and Google identity providers to your Angular SPA using native authentication JavaScript SDK.
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 03/30/2026
ms.custom: msecd-doc-authoring-108
ai-usage: ai-assisted
#Customer intent: As a developer, I want to support federated identity providers (social sign-in) in my Angular single-page application that uses native authentication JavaScript SDK so that users can sign up and sign in with Apple, Facebook and Google identity providers.
---

# Tutorial: Support federated identity providers in an Angular single-page app by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to let users sign up and sign in with their existing social accounts, such as Apple, Facebook and Google, in your Angular single-page application (SPA) by using native authentication's JavaScript SDK for external tenants.

In this tutorial, you:

>[!div class="checklist"]
>
> * Update the app configuration to set a redirect URI.
> * Add federated identity provider buttons to sign-in and sign-up forms.
> * Handle sign-in and sign-up with federated identity providers.
> * Test the social sign-in flow.

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-angular-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-angular-sign-in.md), [password reset](tutorial-native-authentication-single-page-app-angular-reset-password.md), [register strong authentication method](tutorial-native-authentication-single-page-app-angular-register-strong-method.md) and [Enable MFA](tutorial-native-authentication-single-page-app-angular-enable-mfa.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js 20.x or later](https://nodejs.org/en/download/).
- Configure the federated identity providers you want to enable. Follow the steps in [Identity providers for external tenants](../external-id/customers/concept-authentication-methods-customers.md) for your chosen providers:
    - [Apple](../external-id/customers/how-to-apple-federation-customers.md)
    - [Facebook](../external-id/customers/how-to-facebook-federation-customers.md)
    - [Google](../external-id/customers/how-to-google-federation-customers.md)

## Update the configuration to set the redirect URI

Make sure that the redirect URI is configured in the `CustomAuthConfiguration` interface and that its value matches one of the redirect URIs [configured in your app registration](how-to-add-redirect-uri.md) in the Microsoft Entra admin center:

1. Locate the *src/app/config/auth-config.ts* file.

1. In the `auth` object, add or update `redirectUri` property, then make sure that its value matches one of the redirect URIs configured in your app registration in the Microsoft Entra admin center:

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

In this section, you add federated identity provider buttons to your sign-in and sign-up forms, allowing users to authenticate with social identity providers (Apple, Facebook and Google).

### Update the sign-in form

Update your `sign-in.component.html` to include federated identity provider buttons. You can find the complete example in [sign-in.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.html):

- Open `src/app/components/sign-in/sign-in.component.html` and add the social provider buttons to the initial form:

    ```html
    <div class="auth-container">
        ...
        <form
            *ngIf="!showPassword && !showCode && !isSignedIn && !showAuthMethodsForRegistration && !showChallengeForRegistration && !showMfaAuthMethods && !showMfaChallenge"
            (ngSubmit)="startSignIn()">
            ...

            <div class="separator">
                <div class="separator-line"></div>
                <span class="separator-text">OR</span>
                <div class="separator-line"></div>
            </div>

            <button *ngFor="let provider of socialProviders" type="button" class="social-button"
                (click)="startSignInWithSocial(provider.domainHint)">
                <img [src]="provider.logo" [alt]="provider.name + ' logo'" class="provider-logo" />
                <span>Sign In with {{ provider.name }}</span>
            </button>
        </form>
        ...
    </div>
    ```

### Update the sign-up form

Similarly, update your `sign-up.component.html` component. You can find the complete example in [sign-up.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.html):

- Open `src/app/components/sign-up/sign-up.component.html` and add the social provider buttons after the regular sign-up button. Use the same HTML block from the sign-in form to include the social provider buttons.

## Handle form interaction

In this section, you implement the logic to handle sign-in and sign-up with federated identity providers. The implementation uses the `loginPopup` method from MSAL with a `PopupRequest` that includes the `domainHint` property. This property specifies which federated identity provider to use. For more information about `domainHint` configuration and issuer acceleration, see [Identity providers for External ID](../external-id/customers/concept-authentication-methods-customers.md).

### Update sign-up component to support federated identity providers

Update your `sign-up.component.ts` to handle authentication with federated identity providers. You can find the complete example in [sign-up.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.ts).

1. Import the necessary types in `sign-up.component.ts`:

    ```typescript
    import { customAuthConfig } from "../../config/auth-config";
    import { PopupRequest } from "@azure/msal-browser";
    ```

1. Add the identity provider list in `sign-up.component.ts`:

    ```typescript
    socialProviders = [
        { name: "Google", domainHint: "Google", logo: "/logos/google.svg" },
        { name: "Facebook", domainHint: "Facebook", logo: "/logos/facebook.svg" },
        { name: "Apple", domainHint: "Apple", logo: "/logos/apple.svg" },
    ];
    ```

1. Add the handler function for federated identity provider sign-up in `sign-up.component.ts`:

    ```typescript
    async startSignUpWithSocial(domainHint: string) {
        this.error = "";
        this.loading = false;

        const popUpRequest: PopupRequest = {
            authority: customAuthConfig.auth.authority,
            scopes: [],
            redirectUri: customAuthConfig.auth.redirectUri || "",
            prompt: "login",
            domainHint: domainHint,
        };

        try {
            const client = await this.auth.getClient();

            await client.loginPopup(popUpRequest);

            const accountResult = client.getCurrentAccount();

            if (accountResult.isFailed()) {
                this.error =
                    accountResult.error?.errorData?.errorDescription ??
                    "An error occurred while getting the account from cache";
            }

            if (accountResult.isCompleted()) {
                this.userData = accountResult.data;
                this.isSignedIn = true;
            }
        } catch (error) {
            if (error instanceof Error) {
                this.error = error.message;
            } else {
                this.error = "An unexpected error occurred while logging in with popup";
            }
        }
    }
    ```

### Update sign-in component to support federated identity providers

Update your `sign-in.component.ts` to handle authentication with federated identity providers. You can find the complete example in [sign-in.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.ts).

1. Add the identity provider list in `sign-in.component.ts`:

    ```typescript
    socialProviders = [
        { name: "Google", domainHint: "Google", logo: "/logos/google.svg" },
        { name: "Facebook", domainHint: "Facebook", logo: "/logos/facebook.svg" },
        { name: "Apple", domainHint: "Apple", logo: "/logos/apple.svg" },
    ];
    ```

1. Add the handler function for federated identity provider sign-in in `sign-in.component.ts`:

    ```typescript
    async startSignInWithSocial(domainHint: string) {
        this.error = "";
        this.loading = false;

        const popUpRequest: PopupRequest = {
            authority: customAuthConfig.auth.authority,
            scopes: [],
            redirectUri: customAuthConfig.auth.redirectUri || "",
            prompt: "login",
            domainHint: domainHint,
        };

        try {
            const client = await this.auth.getClient();

            await client.loginPopup(popUpRequest);

            const accountResult = client.getCurrentAccount();

            if (accountResult.isFailed()) {
                this.error =
                    accountResult.error?.errorData?.errorDescription ??
                    "An error occurred while getting the account from cache";
            }

            if (accountResult.isCompleted()) {
                this.userData = accountResult.data;
                this.isSignedIn = true;
            }
        } catch (error) {
            if (error instanceof Error) {
                this.error = error.message;
            } else {
                this.error = "An unexpected error occurred while logging in with popup";
            }
        }
    }
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

Before you test your app, make sure your CORS proxy and app are runing:

1. Make sure your CORS proxy is running:

    ```console
    npm run cors
    ```

1. Start your application:

    ```console
    npm run start
    ```

### Test sign-up with federated identity providers

1. Navigate to `http://localhost:4200/sign-up` to see the sign-up form.

1. Select the button for the federated identity provider that you want to authenticate with, such as **Sign Up with Google**. A popup window opens, redirecting you to the Google authentication page.

1. Sign in with your Google account credentials (or create a new Google account if needed).

1. Grant the necessary permissions when prompted.


After successful authentication, you might be required to complete attribute collection if your tenant is configured to collect additional user attributes during sign-up. For more information, see [Collect user attributes during sign-up](../external-id/customers/concept-user-attributes.md).

The popup window closes automatically. You should be signed in and see your account information displayed in the app. A new user account is created in your external tenant using the information from your Google profile.


### Test sign-in with federated identity providers

1. Navigate to `http://localhost:4200/sign-in` to see the sign-in form.

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

**Solution**: Check your browser's popup blocker settings and allow popups from your application's domain. Instruct your users to do the same. Most browsers display a notification in the address bar when a popup is blocked.

### Domain hint not recognized

The federated identity provider authentication page doesn't appear, or you receive an error indicating the `domainHint` value is invalid.

**Solution**: Verify that the `domainHint` value in your `PopupRequest` matches exactly what you configured in your external tenant. Use the following values:

| Provider | Expected `domainHint` value |
|---|---|
| Apple | `"Apple"` |
| Facebook | `"Facebook"` |
| Google | `"Google"` |




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
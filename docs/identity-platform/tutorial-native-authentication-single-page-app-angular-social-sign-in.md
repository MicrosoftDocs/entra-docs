---
title: Support Federated Identity Providers in an Angular SPA by Using Native Authentication JavaScript SDK
description: Learn how to support federated identity providers (social sign-in) during sign-up and sign-in in an Angular single-page application that uses native authentication JavaScript SDK for external tenants.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 03/25/2026
ai-usage: ai-assisted
#Customer intent: As a developer, I want to support federated identity providers (social sign-in) in my Angular single-page application that uses native authentication JavaScript SDK so that users can sign up and sign in with Google, Facebook, Apple, or custom OIDC identity providers.
---

# Tutorial: Support federated identity providers in an Angular single-page app by using native authentication JavaScript SDK (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to support federated identity providers (social identity providers and custom OIDC identity providers) during sign-up and sign-in in your Angular single-page application (SPA) by using native authentication's JavaScript SDK for external tenants. This tutorial builds on the previous tutorials in the series.

> [!NOTE]
> The [sample app repo](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples) linked in this article is provided as example code to demonstrate the integration and usage of the Microsoft Entra ID native authentication SDK in web applications. It isn't intended for production use and doesn't include all security controls required for a secure, real-world deployment.

In this tutorial, you:

>[!div class="checklist"]
>
> - Update the app configuration to set a redirect URI.
> - Add federated identity provider buttons to sign-in and sign-up forms.
> - Handle sign-in and sign-up with federated identity providers.
> - Test the social sign-in flow.

## Prerequisites

- Complete the steps in [sign up](tutorial-native-authentication-single-page-app-angular-sign-up.md), [sign in](tutorial-native-authentication-single-page-app-angular-sign-in.md), and [password reset](tutorial-native-authentication-single-page-app-angular-reset-password.md) tutorials.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js 20.x or later](https://nodejs.org/en/download/).
- [npm 10.x or later](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm).
- [Angular CLI](https://angular.dev/tools/cli) installed globally. This tutorial uses version `19.2.1`.
- A Microsoft Entra External ID tenant. If you don't have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.
- Configure the federated identity providers you want to enable. Follow the steps in [Identity providers for external tenants](../external-id/customers/concept-authentication-methods-customers.md) for your chosen providers:
    - [Google](../external-id/customers/how-to-google-federation-customers.md)
    - [Facebook](../external-id/customers/how-to-facebook-federation-customers.md)
    - [Apple](../external-id/customers/how-to-apple-federation-customers.md)
    - [Custom OIDC identity providers](../external-id/customers/how-to-custom-oidc-federation-customers.md)
- Complete the steps in [Set up CORS proxy server to manage CORS headers for native authentication](how-to-native-authentication-single-page-app-javascript-sdk-set-up-local-cors.md).
- Review the [folder structure](tutorial-native-authentication-single-page-app-angular-sign-up.md#create-a-angular-project-and-install-dependencies) and [CustomAuthConfiguration](tutorial-native-authentication-single-page-app-angular-sign-up.md#set-up-a-customauthconfiguration-to-use-when-creating-the-customauthpublicclientapplication) setup from the sign-up tutorial.

## Update the configuration to set the redirect URI

Ensure that the redirect URI is configured in the `CustomAuthConfiguration` interface and that its value matches one of the redirect URIs configured in your app registration in the Microsoft Entra admin center.

```typescript
const customAuthConfig: CustomAuthConfiguration = {
    customAuth: {
        ...
        redirectUri: "/",
        ...
    },
    ...
};
```

## Create UI components

In this section, you add federated identity provider buttons to your sign-in and sign-up forms, allowing users to authenticate with social identity providers (Google, Facebook, Apple) or custom OIDC identity providers (such as LinkedIn).

### Update the sign-in form

Update your `sign-in.component.html` to include federated identity provider buttons. You can find the complete example in [sign-in.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.html).

1. Open `src/app/components/sign-in/sign-in.component.html` and add the social provider buttons to the initial form:

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

Similarly, update your `sign-up.component.html` component. You can find the complete example in [sign-up.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.html).

- Open `src/app/components/sign-up/sign-up.component.html` and add the social provider buttons after the regular sign-up button. Use the same HTML block from the sign-in form to include the social provider buttons.

## Handle form interaction

In this section, you implement the logic to handle sign-in and sign-up with federated identity providers. The implementation uses the `loginPopup` method from MSAL with a `PopupRequest` that includes the `domainHint` property to specify which federated identity provider to use.

### Understand domain hints

The `domainHint` property in the `PopupRequest` tells Microsoft Entra ID which federated identity provider the user wants to authenticate with. Different federated identity providers have different `domainHint` values:

- **Apple**: Use `"Apple"`.
- **Facebook**: Use `"Facebook"`.
- **Google**: Use `"Google"`.
- **Custom OIDC (for example, LinkedIn)**: Use the configured issuer URI, such as `"www.linkedin.com"` for LinkedIn.

For custom OIDC identity providers, the `domainHint` should match the issuer URI that you configured in your Microsoft Entra External ID tenant during the identity provider setup.

> [!NOTE]
> Microsoft Entra and Microsoft Account (MSA) identity providers aren't currently supported.

For more information about `domainHint` configuration and issuer acceleration, see [Identity providers for External ID](../external-id/customers/concept-authentication-methods-customers.md).

### Update sign-in component to support federated identity providers

Update your `sign-in.component.ts` to handle authentication with federated identity providers. You can find the complete example in [sign-in.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.ts).

1. Add the identity provider list in `sign-in.component.ts`:

    ```typescript
    socialProviders = [
        { name: "Google", domainHint: "Google", logo: "/logos/google.svg" },
        { name: "Facebook", domainHint: "Facebook", logo: "/logos/facebook.svg" },
        { name: "Apple", domainHint: "Apple", logo: "/logos/apple.svg" },
        { name: "LinkedIn", domainHint: "www.linkedin.com", logo: "/logos/linkedin.svg" },
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
        { name: "LinkedIn", domainHint: "www.linkedin.com", logo: "/logos/linkedin.svg" },
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

### Key points about PopupRequest configuration

When configuring the `PopupRequest` for federated identity provider authentication:

- **authority**: Use your configured Microsoft Entra External ID tenant authority.
- **redirectUri**: The redirect URI you configured in your app registration.
- **prompt**: Set to `"login"` to force the user to enter credentials.
- **domainHint**: The key parameter that determines which federated identity provider to use.

The `loginPopup` method opens a popup window where the user completes the authentication flow with the selected federated identity provider. After authentication succeeds, the popup closes automatically, and the account information is available in your app.

## Run and test your app

### Run the app

1. Make sure your CORS proxy is running:

    ```console
    npm run cors
    ```

1. Start your application:

    ```console
    npm run start
    ```

### Test sign-in with federated identity providers

1. Navigate to `http://localhost:4200/sign-in` to see the sign-in form.

1. You should see the regular email input field and sign-in button, followed by a separator with "OR" text, and then buttons for each configured federated identity provider (Google, Facebook, Apple, LinkedIn).

1. Select one of the federated identity provider buttons, for example, **Sign In with Google**.

1. A popup window opens, redirecting you to the Google authentication page.

1. Sign in with your Google account credentials.

1. If this is your first time signing in with this identity provider, you might be prompted to consent to sharing your information with the application.

1. After successful authentication, you might be required to complete attribute collection if your tenant is configured to collect additional user attributes during sign-up. For more information about attribute collection, see [Collect user attributes during sign-up](../external-id/customers/concept-user-attributes.md).

1. The popup window closes automatically. You should now be signed in and see your account information displayed in the app.

### Test sign-up with federated identity providers

1. Navigate to `http://localhost:4200/sign-up` to see the sign-up form.

1. You should see the regular sign-up form, followed by a separator with "OR" text, and then buttons for each configured federated identity provider.

1. Select one of the federated identity provider buttons, for example, **Sign Up with Google**.

1. A popup window opens, redirecting you to the Google authentication page.

1. Sign in with your Google account credentials (or create a new Google account if needed).

1. Grant the necessary permissions when prompted.

1. After successful authentication, you might be required to complete attribute collection if your tenant is configured to collect additional user attributes during sign-up. For more information about attribute collection, see [Collect user attributes during sign-up](../external-id/customers/concept-user-attributes.md).

1. The popup window closes automatically. A new user account is created in your Microsoft Entra External ID tenant using the information from your Google profile.

1. You should be signed in automatically and see your account information displayed in the app.

### Multifactor authentication

When SMS or email one-time passcode (OTP) MFA is enabled, the MFA challenge is presented in the web flow user experience after the social identity provider authentication completes.

- For more information about enabling MFA, refer to [Multifactor authentication in external tenants](../external-id/customers/concept-multifactor-authentication-customers.md) and [Add multifactor authentication to an app](../external-id/customers/how-to-multifactor-authentication-customers.md).

### Important notes

- **First-time sign-in**: When a user signs in with a federated identity provider for the first time, a new account is automatically created in your Microsoft Entra External ID tenant. The account is linked to the federated identity provider, and subsequent sign-ins with the same provider use the existing account.

- **Popup blockers**: Make sure your browser allows popups from your application. If popups are blocked, the authentication flow fails, and users need to enable popups for your application's domain.

- **Redirect URI**: Ensure that the redirect URI used in your `PopupRequest` matches one of the redirect URIs configured in your app registration in the Microsoft Entra admin center.

- **Federated identity provider configuration**: Verify that you properly configured each federated identity provider in your Microsoft Entra External ID tenant and added them to your user flows.

## Common issues and troubleshooting

If you encounter issues:

- **Popup blocked**: Check your browser's popup blocker settings and allow popups from `localhost:4200`.

- **Domain hint not recognized**: Verify that the `domainHint` value matches exactly what you configured in your Microsoft Entra External ID tenant. For custom OIDC providers, ensure the `domainHint` matches the configured issuer URI.

- **Authentication fails**: Check the browser console for error messages. Common issues include:
    - Incorrect redirect URI configuration.
    - Missing or incorrect client ID in the app configuration.
    - Federated identity provider not properly configured in the tenant.

- **Account creation fails**: Ensure your Microsoft Entra External ID tenant has the federated identity provider configured and enabled in the user flows for both sign-up and sign-in scenarios.

- **CORS errors**: If you see CORS-related errors, make sure your CORS proxy is running correctly as described in the prerequisites.

## Related content

- [Set up a reverse proxy for CORS in test environment](how-to-native-authentication-cors-solution-test-environment.md)
- [Set up a reverse proxy for CORS in production environment](how-to-native-authentication-cors-solution-production-environment.md)
- [MSAL JS SDK Reference](/javascript/api/overview/msal-overview?view=msal-js-latest&preserve-view=true)

---
title: Configure OIDC SSO for gallery and custom applications
description: Learn how to configure OpenID Connect-based single sign-on (SSO) in Microsoft Entra ID for both gallery applications and your own custom (non-gallery) applications.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to

ms.date: 07/15/2025
ms.author: jomondi
ms.reviewer: ergreenl
ms.custom: enterprise-apps

#customer intent: As an administrator, I want to configure OpenID Connect-based single sign-on (SSO) for both gallery and custom applications  so that I can provide a seamless and secure authentication experience for my users across all applications.
---

# Configure OIDC SSO for gallery and custom applications

This article shows you how to configure OpenID Connect (OIDC) Single sign-on (SSO) in Microsoft Entra ID for both gallery applications and custom (non-gallery) applications. With OIDC SSO, your users can sign in to applications using their Microsoft Entra credentials, providing a seamless authentication experience.

OpenID Connect is an authentication protocol built on top of OAuth 2.0 that enables secure user authentication and single sign-on. For detailed information about the OIDC protocol, see [OpenID Connect authentication with the Microsoft identity platform](~/identity-platform/v2-protocols-oidc.md).

We recommend you use a nonproduction environment to test the steps in this article.

Before configuring OIDC SSO, it's helpful to understand the following core concepts:

- **App registrations vs. Enterprise applications**: App registrations define your application's identity and configuration, while enterprise applications represent instances of those apps in your tenant. To learn more, see [Application and service principal objects in Microsoft Entra ID](~/identity-platform/app-objects-and-service-principals.md).
- **Permissions and consent**: Applications request permissions to access resources, and users or administrators grant consent. For details on the consent framework, see [Permissions and consent in the Microsoft identity platform](~/identity-platform/permissions-consent-overview.md).
- **Multi-tenant applications**: Applications that can be used by multiple organizations. For guidance on multi-tenancy, see [How to: Convert your app to be multitenant](~/identity-platform/howto-convert-app-to-be-multi-tenant.md).
- **Authentication flows**: Different methods for authenticating users, such as the Authorization Code flow with PKCE for single-page applications. For more information, see [Microsoft identity platform authentication flows](~/identity-platform/msal-authentication-flows.md).
- **OIDC SSO**: A method of single sign-on that uses the OpenID Connect protocol to authenticate users across applications. It allows users to sign in once and access multiple applications without needing to reenter credentials.

## Prerequisites

To configure OIDC-based SSO, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles:
  - Cloud Application Administrator
  - Application Administrator
  - Owner of the service principal
- For custom applications: Details about your application including its redirect URIs and authentication requirements

## Configure OIDC SSO for Microsoft Entra app gallery apps

Gallery applications in Microsoft Entra ID come preconfigured with OIDC support, making setup straightforward through a consent-based process.

When you add an enterprise application that uses the OIDC standard for SSO, you select the **Sign Up** button. The button is found on the app's pane that appears on the right when you select the app from the app gallery. When you select the button, you complete the sign-up process for the application.

To configure OIDC-based SSO for a gallery application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. In the **All applications** pane, select **New application**.
1. The **Browse Microsoft Entra Gallery** pane opens. In this example, we use **SmartSheet**.
1. Select **Sign-up for SmartSheet**. Sign in with the user account credentials from Microsoft Entra ID. If you already have a subscription to the application, then user details and tenant information is validated. If the application isn't able to verify the user, then it redirects you to sign up for the application service.

    :::image type="content" source="media/add-application-portal-setup-oidc-sso/oidc-sso-configuration.png" alt-text="Complete the consent screen for an application." lightbox="media/add-application-portal-setup-oidc-sso/oidc-sso-configuration.png":::

After entering the sign-in credentials, the consent screen appears. The consent screen provides information about the application and the permissions it requires.
1. Select **Consent on behalf of your organization** and then select **Accept**. The application is added to your tenant and the application home page appears.

> [!NOTE]
> You can add only one instance of a gallery application. If you have already added an application and try to provide consent again, it won't be added again to the tenant.

For more information about user and admin consent, see [Understand user and admin consent](~/identity-platform/howto-convert-app-to-be-multi-tenant.md#understand-user-and-admin-consent-and-make-appropriate-code-changes). For comprehensive information about the consent framework, see [Permissions and consent in the Microsoft identity platform](~/identity-platform/permissions-consent-overview.md).

## Configure OIDC SSO for custom (non-gallery) applications

For applications not available in the Microsoft Entra gallery, you need to manually register and configure the application. This section provides step-by-step guidance for setting up OIDC SSO with a custom application.

### Step 1: Register your application

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **App registrations** > **New registration**.
1. Enter a **Name** for your application (for example, "My Custom Web App").
1. Under **Supported account types**, select the appropriate option:
   - **Accounts in this organizational directory only** for single-tenant applications
   - **Accounts in any organizational directory** for more information on multitenant applications, see [multitenant applications](~/identity-platform/howto-convert-app-to-be-multi-tenant.md)
   - **Accounts in any organizational directory and personal Microsoft accounts** if you want to support both work/school and personal accounts
1. For **Redirect URI**, select the platform type and enter your application's redirect URI:
   - **Web**: For server-side web applications (for example, `https://yourdomain.com/auth/callback`)
   - **Single-page application (SPA)**: For client-side applications using modern auth flows (for example, `https://yourdomain.com` or `http://localhost:3000` for development)
   - **Public client/native**: For mobile and desktop applications
1. Select **Register**.

### Step 2: Configure authentication settings

1. In your app registration, navigate to **Authentication**.
1. Verify your redirect URIs are correctly configured for your platform type.
1. **Configure authentication flows** (important for security):

   **For Single-Page Applications (SPAs):**
   - Ensure your redirect URIs are listed under the **Single-page application** platform
   - This automatically configures the secure **Authorization Code flow with PKCE**, which is the recommended approach for SPAs
   - **Do NOT enable** the implicit grant option unless necessary for legacy applications

   **For Web Applications:**

   - Ensure your redirect URIs are listed under the **Web** platform
   - This configures the standard **Authorization Code flow**
   
   > [!WARNING]
   > The implicit grant flow is **not recommended** for new applications due to security vulnerabilities, including token leakage in browser history. Microsoft strongly recommends using the **Authorization Code flow with PKCE** for single-page applications instead. Only enable these options if you have a legacy application that can't be updated to support more secure flows and you understand the associated security risks.
   > 
   > For more information on authentication flows, see [Microsoft identity platform authentication flows](~/identity-platform/msal-authentication-flows.md).

### Step 3: Configure client credentials (for web applications)

If your application is a confidential client (server-side web application that can securely store secrets):

1. Navigate to **Certificates & secrets**.
1. Select **New client secret**.
1. Add a description and select an expiration period.
1. Select **Add** and copy the secret value immediately (it won't be shown again).
1. Store the client secret securely in your application configuration.

> [!TIP]
> For production applications, consider using certificates instead of client secrets for enhanced security. See [Certificate credentials](~/identity-platform/certificate-credentials.md).

### Step 4: Configure API permissions

1. Navigate to **API permissions**.
1. The `User.Read` permission for Microsoft Graph is added by default.
1. For OIDC authentication, you typically need these delegated permissions:
   - **openid**: Required for OpenID Connect authentication
   - **profile**: To access user's profile information
   - **email**: To access user's email address
1. To add more permissions:
   - Select **Add a permission**
   - Choose **Microsoft Graph**
   - Select **Delegated permissions**
   - Search for and select the required permissions (for example, openid, profile, email)
   - Select **Add permissions**
1. If your application requires permissions that need admin consent, select **Grant admin consent for [your tenant]**.

For an introduction to permissions and consent, see [Permissions and consent in the Microsoft identity platform](~/identity-platform/permissions-consent-overview.md).

### Step 5: Configure optional claims (if needed)
1. Navigate to **Token configuration**.
1. Select **Add optional claim**.
1. Choose the optional claims you want to add (for example, `email`, `given_name`, `family_name`).
1. Select **Add** to apply the changes.

### Step 6: Gather application details

After registration and configuration, collect the following information needed for your application:

1. From the **Overview** page, note:
   - **Application (client) ID**: Your app's unique identifier
   - **Directory (tenant) ID**: Your tenant's unique identifier
1. Select **Endpoints** to view the OpenID Connect metadata and endpoints:
   - **OpenID Connect metadata document**: `https://login.microsoftonline.com/{tenant}/v2.0/.well-known/openid_configuration`
   - **Authorization endpoint**: For initiating sign-in flows
   - **Token endpoint**: For exchanging authorization codes for tokens
   - **JWKS URI**: For token signature validation

These details are used in your application's OIDC library configuration.

### Step 7: Configure your application code

Use the gathered information to configure your application's OIDC library with:

- **Client ID**: The Application (client) ID from step 5
- **Client Secret**: If applicable (for web applications)
- **Redirect URI**: The same URI configured in step 1
- **Authority/Issuer**: `https://login.microsoftonline.com/{tenant}/v2.0/` (replace {tenant} with your tenant ID)
- **Scopes**: Typically `openid profile email` for basic OIDC authentication

For specific implementation guidance, see [Authorization Code flow with PKCE](~/identity-platform/v2-oauth2-auth-code-flow.md) for web applications.

### Step 8: Test your OIDC SSO configuration

1. **Using an online tool**: You can test the basic authentication flow using [https://jwt.ms](https://jwt.ms):
   - Construct a sign-in URL: `https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize?client_id={client_id}&response_type=id_token&redirect_uri=https://jwt.ms&scope=openid&nonce={random_value}`
   - Replace `{tenant}` and `{client_id}` with your values
   - Navigate to this URL in a browser to test the authentication flow

1. **Within your application**: Integrate the OIDC library in your application and test the complete sign-in experience.

1. **Assign users**: Navigate to **Enterprise applications**, find your app, and assign users or groups under **Users and groups**.

## Multitenant app considerations

If your application needs to support users from multiple organizations:

1. Configure the app registration with **Accounts in any organizational directory**
2. Use the common endpoint: `https://login.microsoftonline.com/common/`
3. Implement proper tenant validation in your application logic

For detailed guidance, see [How to: Convert your app to be multitenant](~/identity-platform/howto-convert-app-to-be-multi-tenant.md).

## Troubleshooting common issues

- **Invalid redirect URI**: Ensure the redirect URI in your app registration exactly matches what your application sends
- **Consent issues**: Check if admin consent is required for the requested permissions
- **Token validation errors**: Verify you're using the correct JWKS URI and validating the token signature
- **Multi-tenant issues**: Ensure you're using the correct endpoint (common vs. tenant-specific)

For comprehensive troubleshooting guidance, see [Microsoft identity platform error codes](~/identity-platform/reference-error-codes.md).

## Related content

- [OpenID Connect authentication with the Microsoft identity platform](~/identity-platform/v2-protocols-oidc.md)
- [Microsoft identity platform authentication flows](~/identity-platform/msal-authentication-flows.md)
- [Migrate from implicit grant to auth code flow](~/identity-platform/migrate-spa-implicit-to-auth-code.md)

---
title: Identity Providers
description: Explore identity providers in Microsoft Entra External ID, including email, social accounts, and federation, to plan customer sign-up and sign-in.
ms.topic: concept-article
ms.date: 11/12/2026
ai-usage: ai-assisted
ms.custom: it-pro, seo-july-2024, msecd-doc-authoring-1030
#customer intent: As a Microsoft Entra External ID administrator, I want to configure identity providers so that customers can sign up and sign in to my applications.
---

# Identity providers in Microsoft Entra External ID

> [!TIP]
> This article applies to External ID in external tenants. For information about workforce tenants, see [Identity providers for External ID in workforce tenants](../identity-providers.md).

Microsoft Entra External ID supports several identity providers for your customer-facing apps.

[!INCLUDE [authentication-approaches](../includes/applies-to-authentication-approaches.md)]

Customers can create a local account with an email address and a password or one-time passcode (OTP). They can also use an external identity provider (IdP), such as Facebook, Google, Apple, or another Microsoft Entra ID tenant. For custom providers, configure OpenID Connect (OIDC), Security Assertion Markup Language (SAML), or WS-Federation (WS-Fed). During sign-up, Microsoft Entra External ID creates a user object in your directory with the collected identity information.

This article describes the identity providers that are available for primary authentication when signing up and signing in to apps in external tenants. You can also configure a [multifactor authentication (MFA) policy](concept-multifactor-authentication-customers.md) to require additional verification when the policy applies.

## Authentication approach applicability

Configure identity providers in your external tenant. Confirm sign-up, sign-in, and recovery availability for each required method in the [methods and journeys comparison](concept-supported-features-customers.md#methods-and-journeys-by-approach). Review [Choose an authentication approach](concept-choose-authentication-approach.md) for architectural guidance and [Supported features](concept-supported-features-customers.md) for tenant capabilities.

[!INCLUDE [native-authentication-public-preview](../includes/native-authentication-public-preview.md)]

For integration guidance, see the [Native Authentication API reference](~/identity-platform/reference-native-authentication.md), [platform-specific SDK guidance](~/identity-platform/concept-native-authentication.md#how-to-use-native-authentication), or [Bring Your Own UX requirements](concept-choose-authentication-approach.md#when-to-use-bring-your-own-ux).

The provider-specific page interactions below describe Microsoft-hosted authentication. Configuring a provider in your tenant doesn't make it available through every Native Authentication API or SDK contract; verify the selected integration in the comparison.

## Email and password sign-in

Email sign-up is enabled by default in your local account identity provider settings. With the email option, users can sign up and sign in with their email address and a password.

- **Sign-up**: Users enter an email address and verify it with a one-time passcode. They then enter any other information requested on the sign-up page, such as display name, given name, and surname, and select **Continue** to create an account.

- **Sign-in**: After the user signs up and creates an account, they can sign in by entering their email address and password.

- **Password reset**: If you enable email and password sign-in, a password reset link appears on the password page. If the user forgets their password, selecting this link sends a one-time passcode to their email address. After verification, the user can choose a new password.

   :::image type="content" source="media/concept-authentication-methods-customers/email-password-sign-in.png" alt-text="Screenshot of email and password screens during local account sign-up and sign-in." border="false":::

When you [create a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md#create-and-customize-a-user-flow), **Email with password** is the default option.

<a name="username-or-alias-sign-in-preview"></a>

## Username or alias sign-in

You can enable users with an email and password local account to sign in with an [alias or username](how-to-sign-in-alias.md) as an alternative to their email address. The username can be a customer ID, membership ID, insurance number, frequent flyer number, or another identifier.

When users sign in with their username, they're prompted for a password, just as with email and password sign-in. If you [enable password reset](how-to-customize-branding-customers.md#to-customize-self-service-password-reset), users can reset their password by selecting the password reset link on the sign-in page.

   :::image type="content" source="media/how-to-sign-in-alias/alias-sign-in.png" alt-text="Screenshot of the username sign-in option on the sign-in page.":::

## Email with one-time passcode sign-in

Email with one-time passcode is an option in your local account identity provider settings. With this option, the user signs in with a temporary passcode instead of a stored password each time they sign in.

- **Sign-up**: Users can sign up with their email address and request a temporary code, which is sent to their email address. Then they enter this code to continue signing in.

- **Sign-in**: After the user signs up and creates an account, each time they sign in they'll enter their email address and receive a temporary passcode.

   :::image type="content" source="media/concept-authentication-methods-customers/email-passcode-sign-in.png" alt-text="Screenshot of email one-time passcode screens during sign-up and sign-in." border="false":::

You can also [show, hide, or customize the password reset link](how-to-customize-branding-customers.md#to-customize-self-service-password-reset) on the sign-in page.

When you [create a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md#create-and-customize-a-user-flow), **Email one-time passcode** is one of the local account options.

## Social identity providers: Facebook, Google, and Apple

Federation with social identity providers lets users sign up and sign in with their existing Facebook, Google, or Apple accounts.

Users select from the social identity providers you enable on the sign-up page. To set up a social identity provider, create an application at that provider and configure credentials. Use the resulting client or app ID, client or app secret, or certificate to configure your external tenant.

### Google sign-in

Set up federation with Google to let users sign in to your applications with their existing Google accounts.

Users select **Sign-in with Google** on the sign-in page and are redirected to Google to complete sign-in.

   :::image type="content" source="media/concept-authentication-methods-customers/google-sign-in.png" alt-text="Screenshot of the Google sign-in flow after the user selects Sign in with Google." border="false":::

Learn how to [add Google as an identity provider](how-to-google-federation-customers.md).

### Facebook sign-in

Set up federation with Facebook to let users sign in to your applications with their existing Facebook accounts.

Users select **Sign-in with Facebook** on the sign-in page and are redirected to Facebook to complete sign-in.

   :::image type="content" source="media/concept-authentication-methods-customers/facebook-sign-in.png" alt-text="Screenshot of the Facebook sign-in flow after the user selects Sign in with Facebook." border="false":::

Learn how to [add Facebook as an identity provider](how-to-facebook-federation-customers.md).

### Apple sign-in

Set up federation with Apple to let users sign in to your applications with their existing Apple accounts.

Users select **Sign-in with Apple** on the sign-in page and are redirected to Apple to complete sign-in.
Learn how to [add Apple as an identity provider](how-to-apple-federation-customers.md).

## Microsoft Entra ID federation

By setting up OpenID Connect (OIDC) federation with a Microsoft Entra ID tenant, you enable users from that tenant to sign up and sign in to your applications using their existing organizational accounts. This approach uses the custom OIDC identity provider feature to federate with a Microsoft Entra ID tenant.

Learn how to [add a Microsoft Entra ID tenant as an OIDC identity provider](how-to-entra-id-federation-customers.md).

## Custom OIDC identity provider

You can set up a custom OpenID Connect (OIDC) identity provider to allow users to sign up and sign in through Microsoft-hosted authentication using their credentials in that provider. Federation lets you use the provider for authentication; migration moves identities to a destination tenant. If you're migrating from Azure AD B2C, see the [Azure AD B2C migration planning guidance](plan-your-migration-from-b2c-to-external-id.md).

Learn how to [set up a custom OIDC identity provider](how-to-custom-oidc-federation-customers.md).

## Custom SAML/WS-Fed identity providers

You can set up a SAML or WS-Fed identity provider to let users sign up and sign in with their existing account at that provider. Users select **Sign up with** or **Sign in with**, authenticate at the identity provider, and return to Microsoft Entra External ID. In external tenants, a user's sign-in email doesn't need to match the predefined domains configured for SAML federation. Adding, changing, or removing domains won't affect existing users' experience.

A user whose email address matches a predefined domain is redirected to that identity provider. If the user doesn't have an account, they might be prompted for additional details to create one.

For more information, see [SAML/WS-Fed identity providers](../direct-federation-overview.md). For detailed setup steps, see [Add federation with SAML/WS-Fed identity providers](../direct-federation.md).

### Domain acceleration

When you federate with custom SAML/WS-Fed IdPs, users usually see the Microsoft sign-in page first and then choose their identity provider. These IdPs can be associated with one or more domains. Including the `domain_hint` parameter in the sign-in URL allows users to go directly to the sign-in page for the identity provider associated with the specified domain.

For a custom SAML identity provider, use the domain specified in the **Domain name of federating IdP** field in the `domain_hint` syntax: `domain_hint=<domain name of federating idp>`

:::image type="content" source="media/concept-authentication-methods-customers/domain-issuer-saml.png" alt-text="Screenshot of the federating identity provider domain used for domain_hint in SAML configuration.":::

## Issuer acceleration

When you federate with Facebook, Google, Apple, or a custom OpenID Connect IdP, users usually see the Microsoft sign-in page first and then choose their identity provider. Including the `domain_hint` parameter in the sign-in URL allows users to go directly to the sign-in page for the identity provider associated with the specified domain.

You can use the following `domain_hint` values to go directly to the sign-in page for these identity providers:

- **Facebook**: `domain_hint=facebook`.
- **Google**: `domain_hint=Google`. The value is case-sensitive: `google` returns `AADSTS90023` and `google.com` shows the sign-in page instead of redirecting.
- **Apple**: `domain_hint=apple`.
- **Custom OIDC**: `domain_hint=<issuer URI>`. For a custom OIDC identity provider, use the domain part of the **Issuer URI** in the `domain_hint` syntax such as `"www.linkedin.com"` for LinkedIn.
- **Custom OIDC - Microsoft Entra ID**: For a custom OIDC Microsoft Entra ID identity provider, use the tenant's domain name, such as `domain_hint=contoso.onmicrosoft.com`.
  
   :::image type="content" source="media/concept-authentication-methods-customers/domain-issuer-open-id-connect.png" alt-text="Screenshot of the issuer URI domain used for domain_hint in custom OpenID Connect configuration.":::

<a name="updating-sign-in-methods"></a>

## Update sign-in methods

At any time, you can update the sign-in options for an app. For example, you can add social identity providers or change the local account sign-in method.

When you change sign-in methods, the change affects only new users. Existing users continue to sign in using their original method. For example, suppose you start out with the email and password sign-in method, and then change to email with one-time passcode. New users sign in using a one-time passcode, but any users who already signed up with an email and password continue to be prompted for their email and password.

## Microsoft Graph APIs

Use the following Microsoft Graph API operations to manage identity providers and authentication methods in Microsoft Entra External ID.

These administrative operations configure the tenant. They don't establish profile or credential-management interoperability for native-issued tokens or direct Microsoft Graph access from a BYO UX page.

- To identify what identity providers and authentication methods are supported, you call the [List availableProviderTypes](/graph/api/identityproviderbase-availableprovidertypes) API.
- To identify the identity providers and authentication methods that are already configured and enabled in the tenant, you call the [List identityProviders](/graph/api/identitycontainer-list-identityproviders) API.
- To enable a supported identity provider or authentication method, you call the [Create identityProvider](/graph/api/identitycontainer-post-identityproviders) API.

## Related content

- [Add Facebook as an identity provider](how-to-facebook-federation-customers.md).
- [Add Google as an identity provider](how-to-google-federation-customers.md).
- [Add Apple as an identity provider](how-to-apple-federation-customers.md).
- [Add a Microsoft Entra ID tenant as an OIDC identity provider](how-to-entra-id-federation-customers.md).
- [Add federation with SAML/WS-Fed identity providers](../direct-federation.md).
- [Add OpenID Connect as an external identity provider](how-to-custom-oidc-federation-customers.md).

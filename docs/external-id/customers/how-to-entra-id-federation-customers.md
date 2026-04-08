---
title: Add Microsoft Entra ID for customer sign-in
description: Learn how to configure a Microsoft Entra ID tenant as an OpenID Connect identity provider in Microsoft Entra External ID, enabling users to sign in using their existing organizational accounts.
ms.topic: how-to
ms.date: 03/09/2026
ms.author: godonnell
author: garrodonnell
ms.custom: it-pro
ai-usage: ai-assisted

#Customer intent: As a developer, DevOps, or IT administrator, I want to learn how to add a Microsoft Entra ID tenant as an OpenID Connect identity provider in my external tenant.
---
# Add a Microsoft Entra ID tenant as an OpenID Connect identity provider (Preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

By setting up OpenID Connect (OIDC) federation with a Microsoft Entra ID tenant, you enable users from that tenant to sign up and sign in to your applications using their existing organizational accounts. This approach uses the custom OIDC identity provider feature to federate with a Microsoft Entra ID tenant.

When you add a Microsoft Entra ID identity provider to your user flow's sign-in options, users can sign up and sign in to the registered applications defined in that user flow using their Microsoft Entra ID credentials. (Learn more about [authentication methods and identity providers for customers](concept-authentication-methods-customers.md).)

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A Microsoft Entra ID tenant to use as the identity provider. If you don't have one, [create a new tenant](../../identity-platform/quickstart-create-new-tenant.md).
- A [registered application](/entra/identity-platform/quickstart-register-app) in the external tenant.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).

## Register the external tenant in your Microsoft Entra ID tenant

To federate users from your Microsoft Entra ID tenant, first register the external tenant as an application in the Microsoft Entra ID tenant that acts as the identity provider. 

When you register the application, use the following federation-specific settings:

1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. Under **Redirect URI**, select **Web** and add the following URIs:

   `https://<tenant-subdomain>.ciamlogin.com/<tenant-ID>/federation/oauth2`

   `https://<tenant-subdomain>.ciamlogin.com/<tenant-subdomain>.onmicrosoft.com/federation/oauth2`

   Replace `<tenant-subdomain>` and `<tenant-ID>` with the values from your external tenant. If your external tenant uses a custom domain, add the redirect URI with the custom domain as well, for example:

   `https://<tenant-subdomain>.ciamlogin.com/<custom-domain>/federation/oauth2`

For step-by-step guidance, see [Register an application](/entra/identity-platform/quickstart-register-app).

After the app is registered, complete the following configuration:

1. Add a [client secret](/entra/identity-platform/how-to-add-credentials?tabs=client-secret) and record the secret value (not the secret ID). You need this value when you configure the identity provider in your external tenant.
1. Under **Token configuration**, add the optional claims you want the identity provider to send.
1. Under **API permissions**, add Microsoft Graph [delegated permissions](/entra/identity-platform/howto-update-permissions): `email`, `openid`, `profile`, and `User.Read`. Then grant admin consent for the identity provider tenant.
1. Under **Overview**, record the **Application (client) ID** and **Directory (tenant) ID**. You need these values to configure federation in the external tenant.

## Configure the identity provider in the external tenant

After you register the external tenant in the Microsoft Entra ID tenant, add it as a custom OIDC identity provider in the external tenant. Follow the steps in [Configure a new OpenID Connect identity provider in the admin center](how-to-custom-oidc-federation-customers.md#configure-a-new-openid-connect-identity-provider-in-the-admin-center) and use the following Microsoft Entra ID-specific values:

| Setting | Value |
|---------|-------|
| **Display name** | A name your users see during sign-in, for example *Sign in with Contoso*. |
| **Well-known endpoint** | `https://login.microsoftonline.com/organizations/v2.0/.well-known/openid-configuration` |
| **OpenID Issuer URI** | `https://login.microsoftonline.com/<tenant-ID>/v2.0`, where `<tenant-ID>` is the directory (tenant) ID of the Microsoft Entra ID tenant. |
| **Client ID** | The application (client) ID from the app registration you created in the Microsoft Entra ID tenant. |
| **Client Authentication** | `client_secret` |
| **Client Secret** | The client secret value you recorded from the app registration. |
| **Scope** | `openid profile` |
| **Response type** | `code` |

## Add the identity provider to a user flow

After you set up the identity provider, add it to a user flow so it appears on the sign-in page. Follow the steps in [Add OIDC identity provider to a user flow](how-to-custom-oidc-federation-customers.md#add-oidc-identity-provider-to-a-user-flow), selecting the Microsoft Entra ID OIDC identity provider you configured.

## Test the user flow

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow you configured. At least one application with a redirect URI must be associated with this user flow.
1. Select **Run user flow**.
1. In the **Run user flow** pane, for **Application**, select the application you want to test. The remaining fields, including **Reply URL** and **Response type**, are auto-populated from the application registration.
1. Select the **Run user flow** button, or copy the **Run user flow endpoint** URL and open it in a new browser window.
1. On the sign-in page, select the Microsoft Entra ID identity provider and sign in with an account from the federated tenant.

## Known limitations

Conditional Access policies that require MFA registration don't work as expected when External ID is federated to Microsoft Entra ID. Users can't register an MFA method and can't complete sign-in. This limitation applies only for External ID to Microsoft Entra ID federation and doesn't affect other external identity provider federations.

## Frequently asked questions

**I get an error: "No email address was obtained from the external OIDC identity provider." How do I fix it?**

The email claim is required for External ID federation scenarios. Make sure the `email` claim is included in the application's **Token configuration** in the Microsoft Entra ID tenant used as the external identity provider.

**I configured Microsoft Entra ID as my federated identity provider, but it doesn't appear on the sign-in page. What should I check?**

Verify that the issuer URI and well-known OpenID configuration endpoint are correctly configured. An incorrect issuer or discovery endpoint prevents the identity provider from appearing during sign-in. Also check that:

- The Microsoft Entra ID tenant is fully configured as a custom OIDC identity provider.
- Required redirect URIs, issuer values, and scopes are present and correct.
- The identity provider is added to the user flow, not just to the tenant.
- Configuration changes have fully propagated. Re-saving or recreating the user flow after configuration changes often resolves this issue.

**What does the error `AADSTS500208: The domain is not a valid login domain for the account type` mean?**

This error indicates that sign-in failed because the account type isn't permitted to use the login URL or tenant being accessed. Verify that the correct sign-in endpoint is being used and that the account has access to the target tenant.

**What does error `40015` mean when using a custom OIDC identity provider?**

Error `40015` means that authentication at the external identity provider succeeded, but External ID rejected the response because the custom OIDC identity provider configuration or returned tokens couldn't be validated. Common causes include:

- The issuer URI doesn't exactly match the issuer value in the identity provider's discovery document.
- Authorization, token, or JWKS endpoints are incorrect or unreachable.
- Required attributes (such as subject or email) aren't returned by the identity provider.

**How is adding Microsoft Entra ID as a custom OIDC federation different from inviting Microsoft Entra ID users as B2B guests?**

With Microsoft Entra ID federation:

- User authentication always occurs in the home Microsoft Entra ID tenant.
- Workforce Conditional Access and MFA policies are enforced.
- The sign-in experience is a full redirect to the home tenant, rather than the mixed-branding experience associated with B2B guest sign-in.

**Do Microsoft Entra ID Conditional Access and MFA policies apply?**

Yes. Because all authentication occurs in the user's home Microsoft Entra ID tenant, the following are enforced exactly as they are for native Microsoft Entra ID sign-ins:

- Conditional Access policies
- MFA requirements
- Device-based and risk-based controls

> [!NOTE]
> External ID Conditional Access policies that require MFA registration aren't honored by the home tenant. For details, see [Known limitations](#known-limitations).

**Why do I see a domain confirmation dialog when using domain_hint?**

When `domain_hint` is used, a domain confirmation dialog appears to ensure the user is intentionally signing in to the correct organization and to protect against unauthorized or unexpected redirection. This security check can't be suppressed today, even when the redirect is expected.

**Can new users be automatically redirected based on their email domain when they enter their email address on the sign-in page?**

There's limited support today. Domain-based acceleration using `domain_hint` is supported in specific configurations, but fully automatic redirection based solely on email domain for new users isn't yet supported. If domain-based routing is required, consider using explicit identity provider buttons or passing a `domain_hint` parameter when initiating sign-in. The domain_hint value for Entra ID should be the domain name like domain_hint=contoso.onmicrosoft.com. For more information see [Issuer Acceleration](./concept-authentication-methods-customers.md#issuer-acceleration)

**Can I hide other identity provider buttons and show only Microsoft Entra ID?**

You can hide identity provider buttons by not including them in the user flow, but new users can only register if `domain_hint` is utilized.

**Are ID tokens returned as opaque values?**

No. Microsoft Entra ID issues standard signed JWT tokens. ID tokens are readable and conform to OpenID Connect specifications.

**Can I use multiple Microsoft Entra ID tenants with a single external tenant?**

Yes. You can configure multiple Microsoft Entra ID tenants as separate custom OIDC identity providers and expose them within External ID user flows.

## Related content

- [Add OpenID Connect as an external identity provider](how-to-custom-oidc-federation-customers.md)
- [Add an Azure AD B2C tenant as an OIDC identity provider](how-to-b2c-federation-customers.md)
- [OIDC claims mapping](reference-oidc-claims-mapping-customers.md)

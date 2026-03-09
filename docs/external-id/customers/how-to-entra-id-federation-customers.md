---
title: Add Microsoft Entra ID for customer sign-in
description: Learn how to configure a Microsoft Entra ID tenant as an OpenID Connect identity provider in Microsoft Entra External ID, enabling users to sign in using their existing organizational accounts.
ms.topic: how-to
ms.date: 03/09/2026
ms.reviewer: brozbab
ms.custom: it-pro
ai-usage: ai-assisted

#Customer intent: As a developer, devops, or it administrator, I want to learn how to add a Microsoft Entra ID tenant as an OpenID Connect identity provider in my external tenant.
---
# Add a Microsoft Entra ID tenant as an OpenID Connect identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

By setting up OpenID Connect (OIDC) federation with a Microsoft Entra ID tenant, you enable users from that tenant to sign up and sign in to your applications using their existing organizational accounts. This approach uses the custom OIDC identity provider feature to federate with a Microsoft Entra ID tenant.

When you add a Microsoft Entra ID identity provider to your user flow's sign-in options, users can sign up and sign in to the registered applications defined in that user flow using their Microsoft Entra ID credentials. (Learn more about [authentication methods and identity providers for customers](concept-authentication-methods-customers.md).)

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A Microsoft Entra ID tenant to use as the identity provider. If you don't have one, [create a new tenant](../../identity-platform/quickstart-create-new-tenant.md).
- A [registered application](/entra/identity-platform/quickstart-register-app) in the external tenant.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).

## Register the external tenant in your Microsoft Entra ID tenant

To federate users from your Microsoft Entra ID tenant, first register the external tenant as an application in the Microsoft Entra ID tenant that acts as the identity provider. For general steps, see [Register an application](/entra/identity-platform/quickstart-register-app).

When you register the application, use the following federation-specific settings:

1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. Under **Redirect URI**, select **Web** and add the following URIs:

   `https://<tenant-subdomain>.ciamlogin.com/<tenant-ID>/federation/oauth2`

   `https://<tenant-subdomain>.ciamlogin.com/<tenant-subdomain>.onmicrosoft.com/federation/oauth2`

   Replace `<tenant-subdomain>` and `<tenant-ID>` with the values from your external tenant.

After the app is registered, complete the following configuration:

1. Add a [client secret](/entra/identity-platform/how-to-add-credentials) and record the secret value (not the secret ID). You need this value when you configure the identity provider in your external tenant.
1. Under **Token configuration**, add the optional claims you want the identity provider to send.
1. Under **API permissions**, add Microsoft Graph [delegated permissions](/entra/identity-platform/howto-update-permissions): `email`, `openid`, `profile`, and `User.Read`. Then grant admin consent for the identity provider tenant.
1. Under **Overview**, record the **Application (client) ID** and **Directory (tenant) ID**. You need these values to configure federation in the external tenant.

## Configure the identity provider in the external tenant

After you register the external tenant in the Microsoft Entra ID tenant, add it as a custom OIDC identity provider in the external tenant. Follow the steps in [Configure a new OpenID Connect identity provider in the admin center](how-to-custom-oidc-federation-customers.md#configure-a-new-openid-connect-identity-provider-in-the-admin-center) and use the following Entra ID-specific values:

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

### Use private_key_jwt authentication (optional)

Instead of a client secret, you can use `private_key_jwt` to authenticate with the identity provider's token endpoint. With this method, the external tenant signs a JWT client assertion with a private key, and the identity provider validates it using the corresponding public key.

#### Step 1: Generate and register a key pair

1. Generate an asymmetric key pair (RSA, for example RS256).
1. In the Microsoft Entra ID tenant (the identity provider), go to the app registration you created for federation.
1. Select **Certificates & secrets** > **Certificates** > **Upload certificate**. Upload the public key certificate.
1. Record the key ID (`kid`) associated with the uploaded certificate.

#### Step 2: Configure the identity provider app for private_key_jwt

1. In the identity provider's app registration, go to **Manifest**.
1. Ensure the app accepts `private_key_jwt` as a token endpoint authentication method.
1. Verify that the identity provider's OIDC discovery document exposes a `jwks_uri` that returns a JSON Web Key Set (JWKS) containing the signing keys used for token validation. The JWKS should include keys with `kid`, `kty`, `use=sig`, `alg` (for example RS256), and the appropriate RSA parameters.

#### Step 3: Configure the external tenant to use private_key_jwt

When you configure the custom OIDC identity provider in your external tenant (as described earlier in [Configure the identity provider in the external tenant](#configure-the-identity-provider-in-the-external-tenant)), select the following option instead of `client_secret`:

   - **Client Authentication**: Select `private_key_jwt`.

The public key must be provided in the identity provider's OIDC metadata (well-known endpoint), retrievable via the `jwks_uri` property.

When the external tenant authenticates to the identity provider's token endpoint, it sends a signed JWT client assertion instead of a client secret. The assertion includes the following claims:

| Claim | Value |
|-------|-------|
| `iss` | Application (client) ID |
| `sub` | Application (client) ID |
| `aud` | Identity provider token endpoint URL |
| `exp` | Short lifetime expiration |
| `jti` | Unique identifier |

The JWT header includes `alg` (for example RS256), `typ=JWT`, and the `kid` of the signing key.

#### Validate the configuration

Verify that:

- The identity provider's OIDC discovery document exposes a valid `jwks_uri`.
- The JWKS contains keys with `kid`, `kty`, `use=sig`, `alg`, and the appropriate key parameters.
- The identity provider's token endpoint accepts `client_assertion_type` and `client_assertion` parameters instead of a client secret.
- The external tenant can successfully exchange authorization codes for tokens using the `private_key_jwt` flow.

## Add the identity provider to a user flow

After you set up the identity provider, add it to a user flow so it appears on the sign-in page. Follow the steps in [Add OIDC identity provider to a user flow](how-to-custom-oidc-federation-customers.md#add-oidc-identity-provider-to-a-user-flow), selecting the Microsoft Entra ID OIDC identity provider you configured.

When configuring the user flow, under **User attributes**, select the attributes you want to collect during sign-up, for example **Display Name**, **Given Name**, and **Surname**.

## Test the user flow

1. In your external tenant, browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow you configured.
1. Select **Run user flow**.
1. For **Response type**, select **IDToken**.
1. For **Reply URL**, enter `https://jwt.ms`.
1. Copy the URL under **Run user flow endpoint** and open it in a browser.
1. On the sign-in page, select the Microsoft Entra ID identity provider and sign in with an account from the federated tenant.

## Related content

- [Add OpenID Connect as an external identity provider](how-to-custom-oidc-federation-customers.md)
- [Add an Azure AD B2C tenant as an OIDC identity provider](how-to-b2c-federation-customers.md)
- [OIDC claims mapping](reference-oidc-claims-mapping-customers.md)

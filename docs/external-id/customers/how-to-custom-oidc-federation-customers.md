---
title: Add OIDC for customer sign-in
description: Learn how to set up OpenID Connect as an external identity provider in Microsoft Entra External ID, enabling users to sign in using their existing accounts. 
 
author: csmulligan
manager: dougeby
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: how-to
ms.date: 03/12/2025
ms.author: cmulligan
ms.reviewer: brozbab
ms.custom: it-pro

#Customer intent: As a developer, devops, or it administrator, I want to learn how to add an OpenID Connect identity provider for my external tenant.
---
# Add OpenID Connect as an external identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

By setting up federation with a custom-configured OpenID Connect (OIDC) identity provider, you enable users to sign up and sign in to your applications using their existing accounts from the federated external provider. This OIDC federation allows authentication with various providers that adhere to the OpenID Connect protocol. 

When you add an OIDC identity provider to your user flow's sign-in options, users can sign up and sign in to the registered applications defined in that user flow. They can do this using their credentials from the OIDC identity provider. (Learn more about [authentication methods and identity providers for customers](concept-authentication-methods-customers.md).)

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A [registered application](/entra/identity-platform/quickstart-register-app) in the tenant.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).

## Set up your OpenID Connect identity provider

To be able to federate users to your identity provider, you first need to prepare your identity provider to accept federation requests from your Microsoft Entra ID tenant. To do that, you need to populate your redirect URIs and register to your identity provider to be recognized.

Before moving to next step, populate your redirect URIs as follows:

`https://<tenant-subdomain>.ciamlogin.com/<tenant-ID>/federation/oauth2`

`https://<tenant-subdomain>.ciamlogin.com/<tenant-subdomain>.onmicrosoft.com/federation/oauth2`

## Enable sign-in and sign-up with your identity provider

To enable sign-in and sign-up for users with an account in your identity provider, you need to register Microsoft Entra ID as an application in your identity provider. This step allows your identity provider to recognize and issue tokens to your Microsoft Entra ID for federation.
Register the application using your populated redirect URIs. Save the details of your identity provider configuration to set up federation in your Microsoft Entra External ID tenant.

### Federation settings

To configure OpenID connect federation with your identity provider in Microsoft Entra External ID, you need to have the following settings:

- **Well-known endpoint**
- **Issuer URI**
- **Client ID**
- **Client Authentication Method**
- **Client Secret**
- **Scope**
- **Response Type**
- **Claims mapping**
  - Sub
  - Name
  - Given name
  - Family name
  - Email (required)
  - Email_verified
  - Phone number
  - Phone_number_verified
  - Street address
  - Locality
  - Region
  - Postal code
  - Country

## Configure a new OpenID connect identity provider in the admin center

After you configured your identity provider, in this step you'll configure a new OpenID connect federation in the Microsoft Entra admin center. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Entra ID** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab, and then select **Add new** > **Open ID Connect**.

   :::image type="content" source="media/how-to-custom-oidc-federation-customers/add-new.jpg" alt-text="Screenshot of adding a new custom identity provider.":::

1. Enter the following details for your identity provider:

   - **Display name**: The name of your identity provider that will be displayed to your users during the sign-in and sign-up flows. For example, *Sign in with IdP name* or *Sign up with IdP name*.
   - **Well-known endpoint** (also known as metadata URI) is the OIDC discovery URI to [obtain the configuration information](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig) for your identity provider. The response to be retrieved from a well-known location is a JSON document, including its OAuth 2.0 endpoint locations. Note that the metadata document should, at a minimum, contain the following properties: `issuer`, `authorization_endpoint`, `token_endpoint`, `token_endpoint_auth_methods_supported`, `response_types_supported`, `subject_types_supported` and `jwks_uri`. See [OpenID Connect Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html) specifications for more details.

   - **OpenID Issuer URI**: The entity of your identity provider that issues access tokens for your application. An example, if you use OpenID Connect to [federate with your Azure AD B2C](how-to-b2c-federation-customers.md), your issuer URI can be taken from your discovery URI with the "issuer” tag and will look like: `https://login.b2clogin.com/{tenant}/v2.0/`. Issuer URI is a case-sensitive URL using https scheme contains scheme, host, and optionally, port number and path components and no query or fragment components.
   > [!NOTE]
   > Configuring other Microsoft Entra tenants as an external identity provider is currently not supported. Consequently, the `microsoftonline.com` domain in the issuer URI is not accepted.

   - **Client ID** and **Client Secret** are the identifiers your identity provider uses to identify the registered application service. Client secret needs to be provided if client_secret authentication is selected. If private_key_jwt is selected, private key needs to be provided in the OpenID provider metadata (well-known endpoint), retrievable via the property jwks_uri.
   - **Client Authentication** is the type of client authentication method to be used to authenticate with your identity provider using the token endpoint. `client_secret_post`, `client_secret_jwt` and `private_key_jwt` authentication methods are supported.
   > [!NOTE]
   > Due to possible security issues, client_secret_basic client authentication method is not supported.
   - **Scope** defines the information and permissions you're looking to gather from your identity provider, for example `openid profile`. OpenID Connect requests must contain the `openid` scope value in scope in order to receive the ID token from your identity provider. Other scopes can be appended separated by spaces. Refer to the [OpenID Connect documentation](https://openid.net/specs/openid-connect-core-1_0.html) to see what other scopes may be available such as `profile`, `email`, etc.
   - **Response type** describes what kind of information is sent back in the initial call to the `authorization_endpoint` of your identity provider. Currently, only the `code` response type is supported. `id_token` and `token` are not supported at the moment.
  
1. You can select **Next: Claims mapping** to configure [claims mapping](reference-oidc-claims-mapping-customers.md) or **Review + create** to add your identity provider.

> [!NOTE]
> Microsoft recommends you do *not* use the [implicit grant flow](/entra/identity-platform/v2-oauth2-implicit-grant-flow#security-concerns-with-implicit-grant-flow) or the [ROPC flow](/entra/identity-platform/v2-oauth-ropc). Therefore, OpenID connect external identity provider configuration does not support these flows. The recommended way of supporting SPAs is [OAuth 2.0 Authorization code flow (with PKCE)](/entra/identity-platform/v2-oauth2-auth-code-flow#applications-that-support-the-auth-code-flow) which is supported by OIDC federation configuration.

## Add OIDC identity provider to a user flow

At this point, the OIDC identity provider has been set up in your Microsoft Entra ID, but it's not yet available in any of the sign-in pages. To add the OIDC identity provider to a user flow:

1. In your external tenant, browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow where you want to add the OIDC identity provider.
1. Under Settings, select **Identity providers.**
1. Under **Other Identity Providers**, select **OIDC identity provider**.

   :::image type="content" source="media/how-to-custom-oidc-federation-customers/custom-oidc-provider.png" alt-text="Screenshot of the custom OIDC provider in the IdP list.":::

1. Select **Save**.

## Related content

- [Add an Azure AD B2C tenant as an OIDC identity provider](how-to-b2c-federation-customers.md)
- [OIDC claims mapping](reference-oidc-claims-mapping-customers.md)

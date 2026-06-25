---
title: Add OIDC for customer sign-in
description: Learn how to set up OpenID Connect as an external identity provider in Microsoft Entra External ID, enabling users to sign in using their existing accounts. 
ms.topic: how-to
ms.date: 06/11/2026
ms.reviewer: brozbab
ms.custom: it-pro, msecd-doc-authoring-1012
ai-usage: ai-assisted

#customer intent: As a developer, devops, or it administrator, I want to learn how to add an OpenID Connect identity provider for my external tenant.
---
# Add OpenID Connect as an external identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

By setting up federation with a custom-configured OpenID Connect (OIDC) identity provider, you enable users to sign up and sign in to your applications using their existing accounts from the federated external provider. This OIDC federation allows authentication with various providers that adhere to the OpenID Connect protocol. 

When you add an OIDC identity provider to your user flow's sign-in options, users can sign up and sign in to the registered applications defined in that user flow. They can do this using their credentials from the OIDC identity provider. (Learn more about [authentication methods and identity providers for customers](concept-authentication-methods-customers.md).)

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A [registered application](/entra/identity-platform/quickstart-register-app) in the external tenant.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).

## Set up your OpenID Connect identity provider

To federate users to your identity provider, first prepare your identity provider to accept federation requests from your external tenant. To do this preparation, add your redirect URIs and register your identity provider to be recognized.

Before moving to the next step, add your redirect URIs as follows:

`https://<tenant-subdomain>.ciamlogin.com/<tenant-ID>/federation/oauth2`

`https://<tenant-subdomain>.ciamlogin.com/<tenant-subdomain>.onmicrosoft.com/federation/oauth2`

## Enable sign-in and sign-up with your identity provider

To enable sign-in and sign-up for users with an account in your identity provider, you need to register Microsoft Entra ID as an application in your identity provider. This step allows your identity provider to recognize and issue tokens to your Microsoft Entra ID for federation.
Register the application using your populated redirect URIs. Save the details of your identity provider configuration to set up federation in your external tenant.

### Federation settings

To configure OpenID Connect federation with your identity provider in Microsoft Entra External ID, you need the following settings:

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
  - Email (required by default; can be [made optional](#make-email-optional-for-external-identity-provider-sign-up))
  - Email_verified
  - Phone number
  - Phone_number_verified
  - Street address
  - Locality
  - Region
  - Postal code
  - Country

## Configure a new OpenID Connect identity provider in the admin center

After you configure your identity provider, complete this step to configure a new OpenID Connect federation in the Microsoft Entra admin center. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Entra ID** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab, and then select **Add new** > **Open ID Connect**.

   :::image type="content" source="media/how-to-custom-oidc-federation-customers/add-new.jpg" alt-text="Screenshot of adding a new custom identity provider.":::

1. Enter the following details for your identity provider:

   - **Display name**: The name of your identity provider that you display to your users during the sign-in and sign-up flows. For example, *Sign in with IdP name* or *Sign up with IdP name*.
   - **Well-known endpoint** (also known as metadata URI) is the OIDC discovery URI to [obtain the configuration information](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig) for your identity provider. The response is a JSON document that includes OAuth 2.0 endpoint locations. At a minimum, the metadata document must contain the following properties: `issuer`, `authorization_endpoint`, `token_endpoint`, `token_endpoint_auth_methods_supported`, `response_types_supported`, `subject_types_supported`, and `jwks_uri`. For more details, see [OpenID Connect Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html) specifications.

   - **OpenID Issuer URI**: The entity of your identity provider that issues access tokens for your application. For example, if you use OpenID Connect to [federate with your Azure AD B2C](how-to-b2c-federation-customers.md), your issuer URI looks like: `https://login.b2clogin.com/{tenant}/v2.0/`. The issuer URI is a case-sensitive URL that uses the https scheme. It contains scheme, host, and optionally port number and path components, but no query or fragment components.
   
   > [!NOTE]
   > To federate with a Microsoft Entra ID tenant, see [Add a Microsoft Entra ID tenant as an OpenID Connect identity provider](how-to-entra-id-federation-customers.md). OIDC federation also isn't compatible with the [Invite external user (preview)](/entra/external-id/customers/concept-supported-features-customers#identity-providers-and-authentication-methods) feature.

   - **Client ID** and **Client Secret** are the identifiers your identity provider uses to identify the registered application service. Provide a client secret when you select a `client_secret`-based authentication method.
   - **Client Authentication** is the type of client authentication method to be used to authenticate with your identity provider using the token endpoint. `client_secret_post` and `client_secret_jwt` authentication methods are supported. Although the admin center UI might display `private_key_jwt` as an option, this method isn't currently supported and shouldn't be selected.

   > [!NOTE]
   > Due to possible security problems, the `client_secret_basic` client authentication method isn't supported.
   - **Scope** defines the information and permissions you're looking to gather from your identity provider, for example `openid profile`. OpenID Connect requests must contain the `openid` scope value to receive the ID token from your identity provider. Other scopes can be appended separated by spaces. See the [OpenID Connect documentation](https://openid.net/specs/openid-connect-core-1_0.html) for other available scopes such as `profile`, `email`, and more.
   - **Response type** describes what kind of information is sent back in the initial call to the `authorization_endpoint` of your identity provider. Currently, only the `code` response type is supported. `id_token` and `token` aren't supported.
  
1. Select **Next: Claims mapping** to configure [claims mapping](reference-oidc-claims-mapping-customers.md) or **Review + create** to add your identity provider.

> [!NOTE]
> Microsoft recommends you do *not* use the [implicit grant flow](/entra/identity-platform/v2-oauth2-implicit-grant-flow#security-concerns-with-implicit-grant-flow) or the [ROPC flow](/entra/identity-platform/v2-oauth-ropc). 
Therefore, OpenID Connect external identity provider configuration doesn't support these flows. The recommended way of supporting SPAs is [OAuth 2.0 Authorization code flow (with PKCE)](/entra/identity-platform/v2-oauth2-auth-code-flow#applications-that-support-the-auth-code-flow) which is supported by OIDC federation configuration.

## Add OIDC identity provider to a user flow

At this point, you set up the OIDC identity provider in your Microsoft Entra ID, but it's not yet available in any of the sign-in pages. To add the OIDC identity provider to a user flow:

1. In your external tenant, browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow where you want to add the OIDC identity provider.
1. Under Settings, select **Identity providers**.
1. Under **Other Identity Providers**, select **OIDC identity provider**.

   :::image type="content" source="media/how-to-custom-oidc-federation-customers/custom-oidc-provider.png" alt-text="Screenshot of the custom OIDC provider in the IdP list.":::

1. Select **Save**.

## Make email optional for external identity provider sign-up

By default, an email address is required when users sign up with an external identity provider (IdP). If your external IdP doesn't send an email claim, users encounter the error `AADSTS901011: No email address was obtained from the external oidc identity provider` during sign-up. To avoid this error, configure your user flow to make the email attribute optional. Users can then complete sign-up with only their external IdP identity, without providing an email address.

> [!IMPORTANT]
> Making email optional is a user flow–level setting. This change applies to sign-ups for **all applications** associated with the user flow.

> [!NOTE]
> When email isn't collected, email one-time passcode (OTP) can't be used for MFA. Make sure an alternative MFA method (such as SMS) is enabled if your policies require MFA.

> [!TIP]
> The account picker typically displays the user's email address. When no email address is collected, the display name is shown instead. To help users easily identify their account, map the `name` claim in [Claims mapping](reference-oidc-claims-mapping-customers.md) or collect display name during sign-up.

### Update the user flow to make email optional

To make the email attribute optional in your user flow, use the Microsoft Graph API to update the `onAttributeCollection` property of the user flow.

1. Find the ID of the user flow you want to update. One way to do this is to use [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to list all your user flows:

   ```http
   GET https://graph.microsoft.com/v1.0/identity/authenticationEventsFlows
   ```

   Locate the `id` of the user flow and the `onAttributeCollection` property in the response.

1. Copy the `onAttributeCollection` property from the response, and use it to update the user flow with a `PATCH` request. The only change you need to make is to set the `required` property on the email attribute to `false`:

   ```http
   PATCH https://graph.microsoft.com/v1.0/identity/authenticationEventsFlows/{user-flow-id}
   Content-Type: application/json

   {
       "@odata.type": "#microsoft.graph.externalUsersSelfServiceSignUpEventsFlow",
       "onAttributeCollection": {
           "@odata.type": "#microsoft.graph.onAttributeCollectionExternalUsersSelfServiceSignUp",
           "attributeCollectionPage": {
               "views": [
                   {
                       "title": null,
                       "description": null,
                       "inputs": [
                           {
                               "attribute": "email",
                               "label": "Email Address",
                               "inputType": "text",
                               "defaultValue": null,
                               "hidden": false,
                               "editable": true,
                               "writeToDirectory": true,
                               "required": false,
                               "validationRegEx": "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$",
                               "options": []
                           }
                       ]
                   }
               ]
           }
       }
   }
   ```

   > [!NOTE]
   > Include all the attribute inputs from your existing user flow in the `PATCH` request, not just the email attribute. The preceding example shows only the email input, but your user flow might include additional attributes. For the full schema, see [authenticationAttributeCollectionPage resource type](/graph/api/resources/authenticationattributecollectionpage).

## Known limitations

Conditional Access policies that require MFA registration don't function as expected when an external tenant is federated with an external identity provider (IdP). This limitation can result in one of the following behaviors:

- Users can't register an MFA method and can't complete sign-in, and often encounter an error.
- Users aren't redirected to the MFA registration (sign-up) flow during sign-in as expected.
- A user created without an email address can't register an email address for use with email one-time passcode (OTP) as an MFA method.

## Related content

- [Add a Microsoft Entra ID tenant as an OIDC identity provider](how-to-entra-id-federation-customers.md)
- [Add an Azure AD B2C tenant as an OIDC identity provider](how-to-b2c-federation-customers.md)
- [OIDC claims mapping](reference-oidc-claims-mapping-customers.md)

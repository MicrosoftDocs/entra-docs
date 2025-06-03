---
title: Add Azure AD B2C for customer sign-in
description: Learn how to configure an Azure AD B2C tenant as an external identity provider in Microsoft Entra External ID, enabling users to sign in using their existing accounts. 
 
author: csmulligan
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: how-to
ms.date: 05/20/2025
ms.author: cmulligan
ms.reviewer: brozbab
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn how to configure an Azure AD B2C tenant as an identity provider for my external tenant.
---
# Add Azure AD B2C tenant as an OpenID Connect identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](../includes/active-directory-b2c-end-of-sale-notice.md)]

To configure your Azure AD B2C tenant as an identity provider, you need to create an Azure AD B2C custom policy, and then an application.

## Prerequisites

- Your Azure AD B2C tenant configured with the custom policy starter pack. See [Tutorial - Create user flows and custom policies - Azure Active Directory B2C | Microsoft Learn](/azure/active-directory-b2c/tutorial-create-user-flows?pivots=b2c-custom-policy)
  - When the email is a required claim in the ID Token, to receive the email claim, you might need to use a custom policy in your Azure AD B2C tenant.
  - You can use the [custom policy deployment tool](https://aka.ms/iefsetup)

## Configure your custom policy

If it's enabled in the user flow, the external tenant may require the email claim to be returned in the token from your Azure AD B2C custom policy.

After provisioning the custom policy starter pack, download the `B2C_1A_signup_signin` file from the **Identity Experience Framework** blade within your Azure AD B2C tenant.

1. Sign in to the [Azure portal](https://portal.azure.com) and select **Azure AD B2C**.
1. On the overview page, under **Policies**, select **Identity Experience Framework**.
1. Search and select the `B2C_1A_signup_signin` file.
1. Download `B2C_1A_signup_signin`.

Open the `B2C_1A_signup_signin.xml` file in a text editor. Under the `<OutputClaims>` node, add the following output claim:

```xml
<OutputClaim ClaimTypeReferenceId="signInName" PartnerClaimType="email"/>
```

Save the file as `B2C_1A_signup_signin.xml` and upload it through the **Identity Experience Framework** blade within your Azure AD B2C tenant. Select to **Overwrite existing policy**. This step will ensure that the email address is issued as a claim to Microsoft Entra ID after authentication at Azure AD B2C.

## Register Microsoft Entra ID as an application

You must register Microsoft Entra ID as an application in your Azure AD B2C tenant. This step allows Azure AD B2C to issue tokens to your Microsoft Entra ID for federation.

To create an application:

1. Sign in to the [Azure portal](https://portal.azure.com) and select **Azure AD B2C**.
1. Select **App registrations**, and then select **New registration**.
1. Under **Name**, enter "Federation with Microsoft Entra ID".
1. Under **Supported account types**, select **Accounts in any identity provider or organizational directory (for authenticating users with user flows)**.
1. Under **Redirect URI**, select **Web**, and then enter the following URL in all lowercase letters, where `tenant-subdomain` is replaced with the name of your Entra tenant (for example, Contoso):
  
    `https://<tenant-subdomain>.ciamlogin.com/<tenant-ID>/federation/oauth2`
    
    `https://<tenant-subdomain>.ciamlogin.com/<tenant-subdomain>.onmicrosoft.com/federation/oauth2`
    
    For example:
      
    `https://contoso.ciamlogin.com/00aa00aa-bb11-cc22-dd33-44ee44ee44ee/federation/oauth2`
    
    `https://contoso.ciamlogin.com/contoso.onmicrosoft.com/federation/oauth2`
    
    If you use a custom domain, enter:
      
    `https://<your-domain-name>/<your-tenant-name>.onmicrosoft.com/oauth2/authresp`
    
    Replace `your-domain-name` with your custom domain, and `your-tenant-name` with the name of your tenant.
    
6. Under **Permissions**, select the **Grant admin consent to openid and offline_access permissions** check box.
7. Select **Register**.
8. In the Azure AD B2C - App registrations page, select the application you created and record the **Application (client) ID** shown on the application overview page. You need this ID when you configure the identity provider in the next section.
9. In the left menu, under **Manage**, select **Certificates & secrets**.
10. Select **New client secret**.
11. Enter a description for the client secret in the **Description** box. For example: "FederationWithEntraID".
12. Under **Expires**, select a duration for which the [secret is valid](/azure/active-directory-b2c/policy-keys-overview), and then select **Add**.
13. Record the secret's **Value**. You need this value when you configure the identity provider in the next section.


## Configure your Azure AD B2C tenant as an identity provider in your external tenant

Construct your OpenID Connect `well-known` endpoint: replace `<your-B2C-tenant-name>` with the name of your Azure AD B2C tenant. 

If you're using a custom domain name, replace `<custom-domain-name>` with your custom domain. Replace the `<policy>` with the policy name you configured in your B2C tenant. If you're using the starter pack, it's the `B2C_1A_signup_signin` file.

`https://<your-B2C-tenant-name>.b2clogin.com/<your-B2C-tenant-name>.onmicrosoft.com/<policy>/v2.0/.well-known/openid-configuration`

OR

`https://<custom-domain-name>/<your-B2C-tenant-name>.onmicrosoft.com/<policy>/v2.0/.well-known/openid-configuration`

1. Configure the issuer URI as: `https://<your-b2c-tenant-name>.b2clogin.com/<your-b2c-tenant-id>/v2.0/`, or if you're using a custom domain, use your custom domain, domain instead of `your-b2c-tenant-name.b2clogin.com`.
1. For **Client ID**, enter the application ID that you previously recorded.
1. Select **Client authentication** as `client_secret`.
1. For **Client secret**, enter the client secret that you previously recorded.
1. For the **Scope**, enter `openid profile email offline_access`
1. Select `code` as the response type.
1. Configure the following for claim mappings:
  - **Sub**: sub
  - **Name**: name
  - **Given name**: given_name
  - **Family name**: family_name
  - **Email** (required): email

Create the identity provider and attach it to your user flow associated with your application for sign in and sign up.

## Related content

- [Add a custom OIDC identity provider as an external identity provider](how-to-custom-oidc-federation-customers.md)
- [Set up OIDC claims mapping](reference-oidc-claims-mapping-customers.md)

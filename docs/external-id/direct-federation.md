---
title: Add a SAML/WS-Fed identity provider
description: Set up direct federation with SAML 2.0 or WS-Fed identity providers so users can sign in with work accounts. Understand attributes and claims for federation.
ms.topic: how-to
ms.date: 11/05/2026
ms.collection: M365-identity-device-management
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done, seo-july-2024, sfi-image-nochange, msecd-doc-authoring-1012
ai-usage: ai-assisted
#customer intent: As an IT admin setting up federation with SAML/WS-Fed identity providers, I want to configure the required attributes and claims for the SAML 2.0 or WS-Fed protocol, so that guest users can sign in to my Microsoft Entra tenant using their own organizational account.
---

# Add federation with SAML/WS-Fed identity providers

[!INCLUDE [applies-to-workforce-external](./includes/applies-to-workforce-external.md)]

Your Microsoft Entra tenant can be directly federated with external organizations that use a SAML or WS-Fed identity provider (IdP). Users from the external organization can then use their own IdP-managed accounts to sign in to your apps or resources, either during invitation redemption or self-service sign-up, without having to create new Microsoft Entra credentials. The user is redirected to their IdP when signing up or signing in to your app, and then returned to Microsoft Entra once they successfully sign in. 

## Prerequisites

- Review the configuration considerations in [SAML/WS-Fed identity providers](direct-federation-overview.md).
- A workforce tenant or an [external tenant](customers/how-to-create-external-tenant-portal.md).

> [!NOTE]
> The Issuer value for the IdP must be a valid URI following RFC 3986 format (for example, `https://testdev.example.com` or `http://www.example.com/exk10l6w90DHM0yi`). Single-word or non-URI values (for example, `testdev`) aren't supported and are rejected by the portal.
> This aligns with Microsoft Entra ID's secure identifier patterns, as documented in [Restrictions on identifier URIs](~/identity-platform/identifier-uri-restrictions.md). For SAML IdPs, the Issuer must uniquely identify the provider as a URI, per SAML 2.0 standards and [Microsoft Entra validation rules](~/identity/hybrid/connect/how-to-connect-fed-saml-idp.md#required-attributes).

## How to configure SAML/WS-Fed IdP federation

### Step 1: Determine if the partner needs to update their DNS text records

Use the following steps to determine if the partner needs to update their DNS records to enable federation with you. 

1. Check the partner's IdP passive authentication URL to see if the domain matches the target domain or a host within the target domain. In other words, when setting up federation for `fabrikam.com`:

   - If the passive authentication endpoint is `https://fabrikam.com` or `https://sts.fabrikam.com/adfs` (a host in the same domain), no DNS changes are needed.
   - If the passive authentication endpoint is `https://fabrikamconglomerate.com/adfs` or `https://fabrikam.co.uk/adfs`, the domain doesn't match the fabrikam.com domain, so the partner needs to add a text record for the authentication URL to their DNS configuration.

1. If DNS changes are needed based on the previous step, ask the partner to add a TXT record to their domain's DNS records, like the following example:

   `fabrikam.com.  IN   TXT   DirectFedAuthUrl=https://fabrikamconglomerate.com/adfs`

### Step 2: Configure the partner organization’s IdP

Next, your partner organization needs to configure their IdP with the required claims and relying party trusts. For federation to work properly, Microsoft Entra External ID requires the external IdP to send certain attributes and claims, which must be configured at the external IdP.

> [!NOTE]
> To illustrate how to configure a SAML/WS-Fed IdP for federation, we use Active Directory Federation Services (AD FS) as an example. See the article [Configure SAML/WS-Fed IdP federation with AD FS](direct-federation-adfs.md), which gives examples of how to configure AD FS as a SAML 2.0 or WS-Fed IdP in preparation for federation.

#### To configure a SAML 2.0 identity provider

Microsoft Entra External ID requires the SAML 2.0 response from the external IdP to include specific attributes and claims. The necessary attributes and claims can be configured at the external IdP by either:

- Linking to the online security token service XML file, or
- Manually entering the values

Refer to the following tables for the required values.

> [!NOTE]
> Ensure the value matches the cloud for which you're setting up external federation.

**Table 1. Required attributes for the SAML 2.0 response from the IdP.**

|Attribute                |Value for a workforce tenant                   |Value for an external tenant                |
|-------------------------|-----------------------------------------------|--------------------------------------------|
|AssertionConsumerService |`https://login.microsoftonline.com/login.srf`  |`https://<tenantID>.ciamlogin.com/login.srf` Add `https://<tenantID>.ciamlogin.com/login.srf` as the callback/ACS URL on the external IdP if required by that provider.|
|Audience                 |`https://login.microsoftonline.com/<tenant ID>/` (Recommended) Replace `<tenant ID>` with the tenant ID of the Microsoft Entra tenant you're setting up federation with.<br></br> In the SAML request sent by Microsoft Entra ID for external federations, the Issuer URL is a tenanted endpoint (for example, `https://login.microsoftonline.com/<tenant ID>/`). For any new federations, we recommend that all our partners set the audience of the SAML or WS-Fed based IdP to a tenanted endpoint. Any existing federations configured with the global endpoint (for example, `urn:federation:MicrosoftOnline`) continue to work, but new federations stop working if your external IdP is expecting a global issuer URL in the SAML request sent by Microsoft Entra ID.      |`https://login.microsoftonline.com/<tenant ID>/`<br>Replace `<tenant ID>` with the tenant ID of the Microsoft Entra tenant you're setting up federation with.      |
|Issuer                   |The issuer URI of the partner's IdP, for example `http://www.example.com/exk10l6w90DHM0yi...`    |The issuer URI of the partner's IdP, for example `http://www.example.com/exk10l6w90DHM0yi...` |


**Table 2. Required claims for the SAML 2.0 token issued by the IdP.**

|Attribute Name                                                        |Value                                                  |
|----------------------------------------------------------------------|-------------------------------------------------------|
|NameID Format                                                         |`urn:oasis:names:tc:SAML:2.0:nameid-format:persistent` |
|`http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`  | The user's email address                              |

#### To configure a WS-Fed identity provider

Microsoft Entra External ID requires the WS-Fed message from the external IdP to include specific attributes and claims. The necessary attributes and claims can be configured at the external IdP by either:

- Linking to the online security token service XML file, or
- Manually entering the values

> [!NOTE]
> Currently, the two WS-Fed providers that have been tested for compatibility with Microsoft Entra ID are AD FS and Shibboleth.

##### Required WS-Fed attributes and claims

The following tables show requirements for specific attributes and claims that must be configured at the third-party WS-Fed IdP. To set up federation, the following attributes must be received in the WS-Fed message from the IdP. These attributes can be configured by linking to the online security token service XML file or by entering them manually.

Refer to the following tables for the required values.

> [!NOTE]
> Ensure the value matches the cloud for which you're setting up external federation.

**Table 3. Required attributes in the WS-Fed message from the IdP.**
 
|Attribute               |Value for a workforce tenant                 |Value for an external tenant                |
|------------------------|---------------------------------------------|--------------------------------------------|
|PassiveRequestorEndpoint|`https://login.microsoftonline.com/login.srf`|`https://<tenantID>.ciamlogin.com/login.srf`|
|Audience                |`https://login.microsoftonline.com/<tenant ID>/` (Recommended) Replace `<tenant ID>` with the tenant ID of the Microsoft Entra tenant you're setting up federation with.<br></br> In the SAML request sent by Microsoft Entra ID for external federations, the Issuer URL is a tenanted endpoint (for example, `https://login.microsoftonline.com/<tenant ID>/`). For any new federations, we recommend that all our partners set the audience of the SAML or WS-Fed based IdP to a tenanted endpoint. Any existing federations configured with the global endpoint (for example, `urn:federation:MicrosoftOnline`) continue to work, but new federations stop working if your external IdP is expecting a global issuer URL in the SAML request sent by Microsoft Entra ID.          |`https://login.microsoftonline.com/<tenant ID>/` <br>Replace `<tenant ID>` with the tenant ID of the Microsoft Entra tenant you're setting up federation with. |
|Issuer                   |The issuer URI of the partner's IdP, for example `http://www.example.com/exk10l6w90DHM0yi...`   |The issuer URI of the partner's IdP, for example `http://www.example.com/exk10l6w90DHM0yi...` |

**Table 4. Required claims for the WS-Fed token issued by the IdP.**

|Attribute  |Value  |
|---------|---------|
|ImmutableID     |`http://schemas.microsoft.com/LiveID/Federation/2008/05/ImmutableID`         |
|emailaddress     |`http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`         |

<a name='step-3-configure-samlws-fed-idp-federation-in-azure-ad'></a>

### Step 3: Configure SAML/WS-Fed IdP federation in Microsoft Entra External ID

After your partner configures their IdP in step 2, configure federation in Microsoft Entra External ID. You can use the Microsoft Entra admin center, [Microsoft Graph](#to-configure-federation-using-the-microsoft-graph-api), or [Microsoft Graph PowerShell](#configure-federation-with-microsoft-graph-powershell). It might take 5-10 minutes before the federation policy takes effect. During this time, don't attempt to complete self-service sign-up or redeem an invitation for the federation domain. The following attributes are required:

- Issuer URI of the partner's IdP.
- Passive authentication endpoint of the partner's IdP. Only HTTPS is supported.
- The public portion of the IdP's token-signing certificate.

#### To add the IdP to your tenant in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your tenant from the **Directories** menu.
1. Browse to **Microsoft Entra ID** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab, and then select **Add new** > **SAML/WS-Fed**.

    :::image type="content" source="media/direct-federation/new-saml-wsfed-idp.png" alt-text="Screenshot showing button for adding a new SAML or WS-Fed IdP." lightbox="media/direct-federation/new-saml-wsfed-idp.png":::

1. On the **New SAML/WS-Fed IdP** page, enter the following:
    - **Display name** - Enter a name to help you identify the partner's IdP.
    - **Identity provider protocol** - Select **SAML** or **WS-Fed**.
    - **Domainless** - For domain-based federation, leave this option cleared. To configure a SAML IdP without matching the user's email domain, see [Configure domainless SAML IdP federation](#configure-domainless-saml-idp-federation).
    - **Domain name of federating IdP** - Enter your partner's IdP target domain name for federation. During this initial configuration, enter just one domain name. You can add more domains later.

    :::image type="content" source="media/direct-federation/new-saml-wsfed-idp-parse.png" alt-text="Screenshot showing the new SAML or WS-Fed IdP page.":::

1. Select a method for populating metadata. If you have a file that contains the metadata, you can automatically populate the fields by selecting **Parse metadata file** and browsing for the file. Or, you can select **Input metadata manually** and enter the following information:

    - The **Issuer URI** of the partner's SAML IdP, or the **Entity ID** of the partner's WS-Fed IdP.
    - The **Passive authentication endpoint** of the partner's SAML IdP, or the **Passive requestor endpoint** of the partner's WS-Fed IdP.
    - **Certificate** - Enter the Base64-encoded public portion of the IdP's token-signing certificate.
    - **Metadata URL** - The location of the IdP's metadata for automatic renewal of the signing certificate.

    :::image type="content" source="media/direct-federation/new-saml-wsfed-idp-input.png" alt-text="Screenshot showing metadata fields.":::

    > [!NOTE]
    > Metadata URL is optional. However, we strongly recommend it. If you provide the metadata URL, Microsoft Entra ID can automatically renew the signing certificate when it expires. If the certificate is rotated for any reason before the expiration time or if you don't provide a metadata URL, Microsoft Entra ID is unable to renew it. In this case, you need to update the signing certificate manually.

1. Select **Save**. The identity provider is added to the **SAML/WS-Fed identity providers** list.

    :::image type="content" source="media/direct-federation/new-saml-wsfed-idp-list.png" alt-text="Screenshot showing the SAML/WS-Fed identity provider list with the new entry." lightbox="media/direct-federation/new-saml-wsfed-idp-list.png":::

1. (Optional) To add more domain names to this federating identity provider:

    1. Select the link in the **Domains** column.

        :::image type="content" source="media/direct-federation/new-saml-wsfed-idp-add-domain.png" alt-text="Screenshot showing the link for adding domains to the SAML/WS-Fed identity provider." lightbox="media/direct-federation/new-saml-wsfed-idp-add-domain.png":::

    1. Next to **Domain name of federating IdP**, type the domain name, and then select **Add**. Repeat for each domain you want to add. When you're finished, select **Done**.

        :::image type="content" source="media/direct-federation/add-domain.png" alt-text="Screenshot showing the Add button in the domain details pane.":::

#### To configure federation using the Microsoft Graph API

Use the Microsoft Graph v1.0 [samlOrWsFedExternalDomainFederation](/graph/api/resources/samlorwsfedexternaldomainfederation?view=graph-rest-1.0&preserve-view=true) resource to retrieve or create federation configurations. The examples in this section use SAML. To configure a WS-Fed IdP, use the partner's WS-Fed settings and set `preferredAuthenticationProtocol` to `wsFed`.

For delegated access, sign in as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator). The access token must have the permissions required for the operation:

| Operation | Microsoft Graph permission |
| --- | --- |
| List or retrieve federation configurations. | `Domain.Read.All` |
| Create a federation configuration. | `IdentityProvider.ReadWrite.All` |
| Delete a federation configuration. | `Domain.ReadWrite.All` or `IdentityProvider.ReadWrite.All` |

Replace `{token}` with an access token for Microsoft Graph. The sample responses are illustrative and shortened for readability. IDs and configuration values differ in your tenant, and the certificate placeholder isn't a usable certificate.

##### List SAML/WS-Fed IdP federations

Use the following request to [list the SAML/WS-Fed federation configurations](/graph/api/samlorwsfedexternaldomainfederation-list?view=graph-rest-1.0&preserve-view=true) in your tenant:

```http
GET https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation
Authorization: Bearer {token}
```

A successful request returns `200 OK` and a collection in `value`:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "value": [
    {
      "@odata.type": "#microsoft.graph.samlOrWsFedExternalDomainFederation",
      "id": "11111111-2222-3333-4444-555555555555",
      "displayName": "Contoso SAML IdP",
      "issuerUri": "https://idp.contoso.com/saml",
      "passiveSignInUri": "https://idp.contoso.com/sso/saml",
      "metadataExchangeUri": "https://idp.contoso.com/metadata",
      "preferredAuthenticationProtocol": "saml",
      "signingCertificate": "<Base64-encoded-signing-certificate>",
      "domains": [
        {
          "id": "contoso.com"
        }
      ]
    }
  ]
}
```

If the response includes `@odata.nextLink`, request that URL to retrieve the next page. Continue until no next link is returned. For more information, see [Paging Microsoft Graph data](/graph/paging).

##### Find a federation by domain

Use a `domains/any` filter to [find the federation configuration for a specific domain](/graph/api/samlorwsfedexternaldomainfederation-get?view=graph-rest-1.0&preserve-view=true). The following request filters for `contoso.com`.

```http
GET https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation?$filter=domains/any(x:x/id%20eq%20'contoso.com')
Authorization: Bearer {token}
```

The response is still a collection, even when only one federation matches:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "value": [
    {
      "@odata.type": "#microsoft.graph.samlOrWsFedExternalDomainFederation",
      "id": "11111111-2222-3333-4444-555555555555",
      "displayName": "Contoso SAML IdP",
      "issuerUri": "https://idp.contoso.com/saml",
      "passiveSignInUri": "https://idp.contoso.com/sso/saml",
      "metadataExchangeUri": "https://idp.contoso.com/metadata",
      "preferredAuthenticationProtocol": "saml",
      "signingCertificate": "<Base64-encoded-signing-certificate>",
      "domains": [
        {
          "id": "contoso.com"
        }
      ]
    }
  ]
}
```

If no federation matches the domain, `value` is an empty array.

##### Get a federation by ID

To retrieve one federation configuration, use its `id` from a list or domain-filter response:

```http
GET https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation/11111111-2222-3333-4444-555555555555
Authorization: Bearer {token}
```

The response contains a single federation object rather than a `value` collection:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "@odata.type": "#microsoft.graph.samlOrWsFedExternalDomainFederation",
  "id": "11111111-2222-3333-4444-555555555555",
  "displayName": "Contoso SAML IdP",
  "issuerUri": "https://idp.contoso.com/saml",
  "passiveSignInUri": "https://idp.contoso.com/sso/saml",
  "metadataExchangeUri": "https://idp.contoso.com/metadata",
  "preferredAuthenticationProtocol": "saml",
  "signingCertificate": "<Base64-encoded-signing-certificate>",
  "domains": [
    {
      "id": "contoso.com"
    }
  ]
}
```

##### Create a domain-based SAML IdP

Use the following request to [create a SAML federation configuration](/graph/api/samlorwsfedexternaldomainfederation-post?view=graph-rest-1.0&preserve-view=true) for `contoso.com`:

```http
POST https://graph.microsoft.com/v1.0/directory/federationConfigurations/microsoft.graph.samlOrWsFedExternalDomainFederation
Authorization: Bearer {token}
Content-Type: application/json

{
  "@odata.type": "microsoft.graph.samlOrWsFedExternalDomainFederation",
  "displayName": "Contoso SAML IdP",
  "issuerUri": "https://idp.contoso.com/saml",
  "passiveSignInUri": "https://idp.contoso.com/sso/saml",
  "metadataExchangeUri": "https://idp.contoso.com/metadata",
  "preferredAuthenticationProtocol": "saml",
  "signingCertificate": "<Base64-encoded-signing-certificate>",
  "domains": [
    {
      "@odata.type": "microsoft.graph.externalDomainName",
      "id": "contoso.com"
    }
  ]
}
```

Replace the example values with the partner's IdP settings:

| Property | Example value and purpose |
| --- | --- |
| `displayName` | `Contoso SAML IdP`, a name that helps you identify the provider. |
| `issuerUri` | `https://idp.contoso.com/saml`, the issuer URI that identifies the partner's IdP. |
| `passiveSignInUri` | `https://idp.contoso.com/sso/saml`, the HTTPS endpoint for browser-based sign-in. |
| `metadataExchangeUri` | `https://idp.contoso.com/metadata`, the IdP metadata URL. |
| `preferredAuthenticationProtocol` | `saml` for a SAML IdP. |
| `signingCertificate` | The Base64-encoded public portion of the IdP's token-signing certificate, not a certificate ID or a private key. |
| `domains` | The external domains associated with the IdP, such as `contoso.com`. |

A successful request returns `201 Created` and the resulting federation object. The following response shows its ID and display name:

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": "11111111-2222-3333-4444-555555555555",
  "displayName": "Contoso SAML IdP"
}
```

To create a SAML IdP that doesn't match users by email domain, see [Create a domainless SAML IdP with Microsoft Graph](#create-a-domainless-saml-idp-with-microsoft-graph).

#### Configure federation with Microsoft Graph PowerShell

Install the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation). These examples use [Invoke-MgGraphRequest](/powershell/module/microsoft.graph.authentication/invoke-mggraphrequest) from the `Microsoft.Graph.Authentication` module to call the same v1.0 endpoints.

Use an account with at least the External Identity Provider Administrator role. Replace the sample tenant ID, domain, federation ID, URLs, and certificate with your own values.

##### List federations with PowerShell

Connect to the tenant where you want to configure federation with `Domain.Read.All`. The following example retrieves each page of SAML/WS-Fed federation configurations:

```powershell
Connect-MgGraph -TenantId "<tenant-id>" -Scopes "Domain.Read.All"

$uri = "https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation"

do {
    $result = Invoke-MgGraphRequest -Method GET -Uri $uri
    $result.value | Format-List *
    $uri = $result.'@odata.nextLink'
} while ($uri)
```

##### Find a federation by domain with PowerShell

The following example URL-encodes the filter and retrieves the configuration associated with `contoso.com`:

```powershell
Connect-MgGraph -TenantId "<tenant-id>" -Scopes "Domain.Read.All"

$domain = "contoso.com"
$filter = [Uri]::EscapeDataString("domains/any(x:x/id eq '$domain')")
$uri = "https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation?`$filter=$filter"

$result = Invoke-MgGraphRequest -Method GET -Uri $uri
$result.value | Format-List *
```

##### Get a federation by ID with PowerShell

Use the federation ID from a list or domain-filter response:

```powershell
Connect-MgGraph -TenantId "<tenant-id>" -Scopes "Domain.Read.All"

$federationId = "11111111-2222-3333-4444-555555555555"
$uri = "https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation/$federationId"

$result = Invoke-MgGraphRequest -Method GET -Uri $uri
$result | Format-List *
```

##### Create a domain-based SAML IdP with PowerShell

Connect with `IdentityProvider.ReadWrite.All`, prepare the request body, and create the federation configuration:

```powershell
Connect-MgGraph -TenantId "<tenant-id>" -Scopes "IdentityProvider.ReadWrite.All"

$body = @{
    "@odata.type" = "microsoft.graph.samlOrWsFedExternalDomainFederation"
    displayName = "Contoso SAML IdP"
    issuerUri = "https://idp.contoso.com/saml"
    passiveSignInUri = "https://idp.contoso.com/sso/saml"
    metadataExchangeUri = "https://idp.contoso.com/metadata"
    preferredAuthenticationProtocol = "saml"
    signingCertificate = "<Base64-encoded-signing-certificate>"
    domains = @(
        @{
            "@odata.type" = "microsoft.graph.externalDomainName"
            id = "contoso.com"
        }
    )
} | ConvertTo-Json -Depth 10

$result = Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/v1.0/directory/federationConfigurations/microsoft.graph.samlOrWsFedExternalDomainFederation" `
    -Body $body `
    -ContentType "application/json"

$result | Format-List *
```

To create a domainless SAML IdP instead, see [Create a domainless SAML IdP with PowerShell](#create-a-domainless-saml-idp-with-powershell).

<a name='step-4-test-samlws-fed-idp-federation-in-azure-ad'></a>

### Step 4: Configure redemption order (B2B collaboration in workforce tenants)

If you're configuring federation in your workforce tenant for B2B collaboration with a verified domain, make sure the federated IdP is used first during invitation redemption. [Configure the **Redemption order** settings](cross-tenant-access-settings-b2b-collaboration.yml) in your cross-tenant access settings for inbound B2B collaboration. Move **SAML/WS-Fed identity providers** to the top of the **Primary identity providers** list to prioritize redemption with the federated IdP.

You can test your federation setup by inviting a new B2B guest user. For details, see [Add Microsoft Entra B2B collaboration users in the Microsoft Entra admin center](add-users-administrator.yml).

> [!NOTE]
> You can configure the invitation redemption order using the Microsoft Graph REST API (beta version). See [Example 2: Update default invitation redemption configuration](/graph/api/crosstenantaccesspolicyconfigurationdefault-update?view=graph-rest-beta&tabs=http#example-2-update-default-invitation-redemption-configuration&preserve-view=true) in the Microsoft Graph reference documentation.
 
## Domainless SAML IdP federation

Traditional federation in Microsoft Entra ID requires you to verify a custom domain (for example, `contoso.com`) and configure that domain to redirect authentication requests to an external SAML Identity Provider (IdP). In this setup, the domain of the email claim provided by the external IdP after authentication is validated against the domain associated with the configured SAML IdP in Microsoft Entra ID.

If the user's email domain differs from the domain configured on the SAML IdP (for example, yahoo.com or gmail.com), users might encounter the following error during sign-in:

**AADSTS5000819**: SAML Assertion is invalid. Email address claim is missing or does not match domain from an external realm.

This error typically occurs when:

- The external SAML IdP does not send an email claim, or
- The email address domain provided by the IdP does not match the domain configured on the external IdP in Microsoft Entra ID

Even when an email claim is present, authentication might still fail if the email domain doesn't align with the configured IdP domain due to domain-based matching requirements.

Domainless SAML federation with a SAML Identity Provider allows external users to authenticate into your apps or workforce resources using their IdP-managed credentials, regardless of their email domain. Domainless federation removes the need for domain matching between the user's email and pre-configured IdP domains during sign-in or invitation redemption.

### Configure domainless SAML IdP federation

To address the domain matching limitation, you can configure the SAML IdP as domainless.
When domainless federation is enabled:

- Microsoft Entra ID routes authentication requests to the configured SAML IdP based on the Issuer URI association.
- The user's email address domain isn't matched against the domain configured for the IdP.

Users can then authenticate successfully using email addresses from any domain (for example, yahoo.com or gmail.com) when signing in with the external SAML IdP.

> [!IMPORTANT]
> Only one wildcard IdP can be configured per tenant. In Microsoft Graph, a domainless SAML IdP has a `domains` collection containing a single entry whose `id` is `*`. Don't combine the wildcard with specific domain names.

#### Create a new domainless SAML IdP in the Microsoft Entra admin center

To create a new domainless SAML IdP:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Microsoft Entra ID** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab, and then select **Add new** > **SAML/WS-Fed**.
1. On the **New SAML/WS-Fed IdP** page, enter a **Display name**, such as `Contoso SAML IdP`, select **SAML** for **Identity provider protocol**, and select **Domainless**. You don't need to enter a specific federation domain.

    :::image type="content" source="media/direct-federation/new-saml-wsfed-identity-provider-domain-less.png" alt-text="Screenshot showing the new SAML/WS-Fed identity provider page with Domainless selected." lightbox="media/direct-federation/new-saml-wsfed-identity-provider-domain-less.png":::

1. Parse a metadata file or enter the issuer URI, passive authentication endpoint, signing certificate, and metadata URL manually, as described in [To add the IdP to your tenant in the Microsoft Entra admin center](#to-add-the-idp-to-your-tenant-in-the-microsoft-entra-admin-center).
1. Select **Save**.

#### Create a domainless SAML IdP with Microsoft Graph

Use the same create endpoint and `IdentityProvider.ReadWrite.All` permission as for a [domain-based SAML IdP](#create-a-domain-based-saml-idp). Set the domain entry's `id` to `*`:

```http
POST https://graph.microsoft.com/v1.0/directory/federationConfigurations/microsoft.graph.samlOrWsFedExternalDomainFederation
Authorization: Bearer {token}
Content-Type: application/json

{
  "@odata.type": "microsoft.graph.samlOrWsFedExternalDomainFederation",
  "displayName": "Contoso SAML IdP",
  "issuerUri": "https://idp.contoso.com/saml",
  "passiveSignInUri": "https://idp.contoso.com/sso/saml",
  "metadataExchangeUri": "https://idp.contoso.com/metadata",
  "preferredAuthenticationProtocol": "saml",
  "signingCertificate": "<Base64-encoded-signing-certificate>",
  "domains": [
    {
      "@odata.type": "microsoft.graph.externalDomainName",
      "id": "*"
    }
  ]
}
```

A successful request returns `201 Created` and the new federation object. The following response is shortened:

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": "66666666-7777-8888-9999-000000000000",
  "displayName": "Contoso SAML IdP"
}
```

Retrieve the configuration by its returned ID and confirm that `domains` contains the wildcard entry.

#### Create a domainless SAML IdP with PowerShell

Use the `Microsoft.Graph.Authentication` module and an account with at least the External Identity Provider Administrator role, as described in [Configure federation with Microsoft Graph PowerShell](#configure-federation-with-microsoft-graph-powershell). The following example creates a domainless SAML IdP directly. Don't run both this example and the domain-based creation example for the same provider.

```powershell
Connect-MgGraph -TenantId "<tenant-id>" -Scopes "IdentityProvider.ReadWrite.All"

$body = @{
    "@odata.type" = "microsoft.graph.samlOrWsFedExternalDomainFederation"
    displayName = "Contoso SAML IdP"
    issuerUri = "https://idp.contoso.com/saml"
    passiveSignInUri = "https://idp.contoso.com/sso/saml"
    metadataExchangeUri = "https://idp.contoso.com/metadata"
    preferredAuthenticationProtocol = "saml"
    signingCertificate = "<Base64-encoded-signing-certificate>"
    domains = @(
        @{
            "@odata.type" = "microsoft.graph.externalDomainName"
            id = "*"
        }
    )
} | ConvertTo-Json -Depth 10

$result = Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/v1.0/directory/federationConfigurations/microsoft.graph.samlOrWsFedExternalDomainFederation" `
    -Body $body `
    -ContentType "application/json"

$result | Format-List *
```

### Update domain-based SAML federation to domainless federation

You can change a domain-based SAML IdP to domainless by using the Microsoft Entra admin center, Microsoft Graph, or Microsoft Graph PowerShell. After any conversion, [update the associated user flows](#known-issues).

> [!IMPORTANT]
> If an existing guest can't sign in after the change, or if the IdP issuer URI has changed, [reset their redemption status](reset-redemption-status.md).

#### Convert an existing SAML IdP in the Microsoft Entra admin center

To change a domain-based SAML IdP to domainless in the admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Microsoft Entra ID** > **External Identities** > **All identity providers**.
1. On **All identity providers**, select the **Custom** tab and locate the SAML IdP.
1. Select the link in the **Domains** column to open the domain details pane.
1. Select **Domainless**, and then select **Done**.

    :::image type="content" source="media/direct-federation/edit-domains-domain-less.png" alt-text="Screenshot of the domain details pane with the Domainless option.":::

#### Convert a domain-based SAML IdP with Microsoft Graph

To convert a domain-based SAML IdP to domainless with Microsoft Graph, retrieve and save its settings, delete the existing configuration, and create a replacement with the wildcard domain.

> [!IMPORTANT]
> Deleting a federation configuration can prevent existing federated guests from signing in. Plan and test the change before you use it in production, and save the existing settings before deletion so that you can recreate the original configuration if needed. The replacement IdP has a new ID. Record any user flow associations before deletion. In an external tenant, add the replacement IdP to the appropriate [user flow](customers/how-to-add-identity-provider-to-user-flow-customers.md).

Use `Domain.Read.All` to retrieve the configuration and `IdentityProvider.ReadWrite.All` to create the replacement. The latter permission also permits deletion. For delegated access, the administrator must have at least the External Identity Provider Administrator role.

1. Get the existing SAML IdP by its ID:

    ```http
    GET https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation/11111111-2222-3333-4444-555555555555
    Authorization: Bearer {token}
    ```

1. Save the response and verify that it describes the SAML IdP you intend to replace. The following response shows an IdP associated with `contoso.com`:

    ```http
    HTTP/1.1 200 OK
    Content-Type: application/json

    {
      "@odata.type": "#microsoft.graph.samlOrWsFedExternalDomainFederation",
      "id": "11111111-2222-3333-4444-555555555555",
      "displayName": "Contoso SAML IdP",
      "issuerUri": "https://idp.contoso.com/saml",
      "passiveSignInUri": "https://idp.contoso.com/sso/saml",
      "metadataExchangeUri": "https://idp.contoso.com/metadata",
      "preferredAuthenticationProtocol": "saml",
      "signingCertificate": "<Base64-encoded-signing-certificate>",
      "domains": [
        {
          "id": "contoso.com"
        }
      ]
    }
    ```

1. Prepare the replacement request before you delete the existing IdP. Keep the IdP's configuration values, remove the read-only `id` and any response-only OData annotations, and replace the `domains` collection with a single entry whose `id` is `*`. Confirm that your tenant doesn't already have another wildcard IdP.

1. [Delete the existing federation configuration](/graph/api/samlorwsfedexternaldomainfederation-delete?view=graph-rest-1.0&preserve-view=true). Include its ID in the request URL; don't send DELETE to the collection URL.

    ```http
    DELETE https://graph.microsoft.com/v1.0/directory/federationConfigurations/11111111-2222-3333-4444-555555555555
    Authorization: Bearer {token}
    ```

    A successful deletion returns:

    ```http
    HTTP/1.1 204 No Content
    ```

1. Create the replacement IdP with the saved settings and the wildcard domain:

    ```http
    POST https://graph.microsoft.com/v1.0/directory/federationConfigurations/microsoft.graph.samlOrWsFedExternalDomainFederation
    Authorization: Bearer {token}
    Content-Type: application/json

    {
      "@odata.type": "microsoft.graph.samlOrWsFedExternalDomainFederation",
      "displayName": "Contoso SAML IdP",
      "issuerUri": "https://idp.contoso.com/saml",
      "passiveSignInUri": "https://idp.contoso.com/sso/saml",
      "metadataExchangeUri": "https://idp.contoso.com/metadata",
      "preferredAuthenticationProtocol": "saml",
      "signingCertificate": "<Base64-encoded-signing-certificate>",
      "domains": [
        {
          "@odata.type": "microsoft.graph.externalDomainName",
          "id": "*"
        }
      ]
    }
    ```

    A successful request returns `201 Created` and the replacement federation object. The following response is shortened:

    ```http
    HTTP/1.1 201 Created
    Content-Type: application/json

    {
      "id": "66666666-7777-8888-9999-000000000000",
      "displayName": "Contoso SAML IdP"
    }
    ```

1. Retrieve the replacement by its new ID and verify that `domains` contains `*`. Restore any user flow associations and test sign-in with the configured issuer URI, as described in [User flow for domainless SAML IdP federation](#user-flow-for-domainless-saml-idp-federation).

#### Convert a domain-based SAML IdP with PowerShell

Use the `Microsoft.Graph.Authentication` module and an account with at least the External Identity Provider Administrator role. This procedure deletes and recreates the federation configuration. Review the [Microsoft Graph conversion guidance](#convert-a-domain-based-saml-idp-with-microsoft-graph), including the deletion impact and replacement ID, before you run it.

1. Connect to the target tenant with read and write permissions, retrieve the existing SAML IdP, and save its configuration. Replace the sample tenant ID and federation ID with your own values.

    ```powershell
    Connect-MgGraph -TenantId "<tenant-id>" -Scopes "Domain.Read.All", "IdentityProvider.ReadWrite.All"

    $federationId = "11111111-2222-3333-4444-555555555555"
    $readUri = "https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation/$federationId"
    $federation = Invoke-MgGraphRequest -Method GET -Uri $readUri -ErrorAction Stop

    if ($federation.preferredAuthenticationProtocol -ne "saml") {
        throw "Select a SAML federation configuration."
    }

    $federation | ConvertTo-Json -Depth 10 |
        Set-Content -Path ".\contoso-saml-idp-backup.json" -Encoding utf8 -ErrorAction Stop
    ```

1. Prepare the replacement with the saved IdP settings and a wildcard domain. Don't include the existing federation ID in the create request. Review the backup and request body before you continue, and confirm that the tenant doesn't already have another wildcard IdP.

    ```powershell
    $body = @{
        "@odata.type" = "microsoft.graph.samlOrWsFedExternalDomainFederation"
        displayName = $federation.displayName
        issuerUri = $federation.issuerUri
        passiveSignInUri = $federation.passiveSignInUri
        metadataExchangeUri = $federation.metadataExchangeUri
        preferredAuthenticationProtocol = $federation.preferredAuthenticationProtocol
        signingCertificate = $federation.signingCertificate
        domains = @(
            @{
                "@odata.type" = "microsoft.graph.externalDomainName"
                id = "*"
            }
        )
    } | ConvertTo-Json -Depth 10

    $body
    ```

1. Delete the existing configuration, and then create the replacement. These commands interrupt federation until the replacement is created. If creation fails after deletion, use the saved settings to recreate the original domain-based configuration.

    ```powershell
    $deleteUri = "https://graph.microsoft.com/v1.0/directory/federationConfigurations/$federationId"
    Invoke-MgGraphRequest -Method DELETE -Uri $deleteUri -ErrorAction Stop

    $result = Invoke-MgGraphRequest `
        -Method POST `
        -Uri "https://graph.microsoft.com/v1.0/directory/federationConfigurations/microsoft.graph.samlOrWsFedExternalDomainFederation" `
        -Body $body `
        -ContentType "application/json" `
        -ErrorAction Stop

    $result | Format-List *
    ```

1. Retrieve the replacement by its new ID and confirm that its domain entry is `*`:

    ```powershell
    $newFederationId = $result.id
    $uri = "https://graph.microsoft.com/v1.0/directory/federationConfigurations/graph.samlOrWsFedExternalDomainFederation/$newFederationId"
    Invoke-MgGraphRequest -Method GET -Uri $uri -ErrorAction Stop | Format-List *
    ```

1. [Update the associated user flows](#known-issues) and [test sign-in](#user-flow-for-domainless-saml-idp-federation).

### User flow for domainless SAML IdP federation
After configuring domainless federation, you can invite guest users from the partner organization by following these steps:

1. In the Microsoft Entra admin center, navigate to **Identity** > **Users** > **All users**.
1. Select **+ New user** and choose **Invite external user**.
1. Enter the guest user's email address. The email domain doesn't need to match a verified domain in your tenant.
1. In the invitation redirect URL, include a **domain_hint** parameter to ensure the user is routed to the appropriate IdP based on the configured Issuer URI. The **domain_hint** value must match the **Issuer URI** defined in the SAML IdP configuration.
1. Complete and send the invitation.
1. When the invited user redeems the invitation, Microsoft Entra ID routes the authentication request to the configured SAML IdP using the Issuer URI in the `domain_hint` parameter. 
1. The user authenticates with the external SAML IdP. The user's email address domain isn't matched against the domain configured for the IdP, and the user can access the resource tenant.
1. For subsequent sign-ins, the user can directly access the resource tenant application by authenticating with the external SAML IdP because the user object is updated with the external IdP association.

### Known issues

Consider the following known issues when you configure domainless SAML IdP federation:

- The IdP configuration gets deleted if an invalid domain name is entered even when the IdP config is not saved.
- Whenever you convert a SAML IdP from domain-based to domainless, update the associated user flows. If you delete and recreate the IdP, first add the replacement IdP to each user flow. Then disable the IdP in the user flow, save, re-enable the IdP, and save again. For the user flow refresh procedure, see [Known limitations](customers/how-to-custom-oidc-federation-customers.md#known-limitations).

## How to update the certificate or configuration details

On the **All identity providers** page, you can view the list of SAML/WS-Fed identity providers configured and their certificate expiration dates. From this list, you can renew certificates and modify other configuration details.

<!--TODO:::image type="content" source="media/direct-federation/new-saml-wsfed-idp-list-multi.png" alt-text="Screenshot showing an identity provider in the SAML WS-Fed list.":::-->

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Microsoft Entra ID** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab.
1. Scroll to an identity provider in the list or use the search box.
1. To update the certificate or modify configuration details:
   - In the **Configuration** column for the identity provider, select the **Edit** link.
   - On the configuration page, modify any of the following details:
     - **Display name** - Display name for the partner's organization.
     - **Identity provider protocol** - Select **SAML** or **WS-Fed**.
     - **Passive authentication endpoint** - The partner IdP's passive requestor endpoint.
     - **Certificate** - The Base64-encoded public portion of the IdP's token-signing certificate. To renew it, enter the new signing certificate.
     - **Metadata URL** - The URL containing the partner's metadata, used for automatic renewal of the signing certificate.
   - Select **Save**.

   :::image type="content" source="media/direct-federation/modify-configuration.png" alt-text="Screenshot of the IDP configuration details.":::

1. To edit the domains associated with the partner, select the link in the **Domains** column. In the domain details pane:

   - To add a domain, type the domain name next to **Domain name of federating IdP**, and then select **Add**. Repeat for each domain you want to add.
   - To delete a domain, select the delete icon next to the domain.
   - When you're finished, select **Done**.

   :::image type="content" source="media/direct-federation/edit-domains.png" alt-text="Screenshot of the domain configuration page.":::

To switch to domainless federation, follow [Convert an existing SAML IdP in the Microsoft Entra admin center](#convert-an-existing-saml-idp-in-the-microsoft-entra-admin-center).

> [!NOTE]
> To remove federation with a partner, first delete all domains except one, and then follow the steps in [How to remove federation](#how-to-remove-federation).

## How to remove federation

You can remove your federation configuration. If you do, federation guest users who already redeemed their invitations can no longer sign in. However, you can give them access to your resources again by [resetting their redemption status](reset-redemption-status.md).
To remove a configuration for an IdP in the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Microsoft Entra ID** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab, and then scroll to the identity provider in the list or use the search box.
1. Select the link in the **Domains** column to view the IdP's domain details.
1. Delete all but one of the domains in the **Domain name** list.
1. Select **Delete Configuration**, and then select **Done**.

   :::image type="content" source="media/direct-federation/delete-configuration.png" alt-text="Screenshot of deleting a configuration.":::

1. Select **OK** to confirm deletion.

You can also remove federation using the Microsoft Graph API [samlOrWsFedExternalDomainFederation](/graph/api/resources/samlorwsfedexternaldomainfederation?view=graph-rest-beta&preserve-view=true) resource type.

## Next steps

- **External tenants:** [Add the SAML/WS-Fed identity provider to a user flow](customers/how-to-add-identity-provider-to-user-flow-customers.md).
- **Workforce tenants:** Learn more about the [invitation redemption experience](redemption-experience.md) when external users sign in with various identity providers.

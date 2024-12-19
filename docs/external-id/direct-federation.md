---
title: SAML/WS-Fed Federation
description: Set up direct federation with SAML 2.0 or WS-Fed identity providers (IdP) so guests can sign in with their own work accounts. Understand attributes and claims required for federation.

 
ms.service: entra-external-id
ms.topic: how-to
ms.date: 06/05/2024

ms.author: mimart
author: msmimart
manager: celestedg
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done, seo-july-2024
ms.collection: M365-identity-device-management
#customer intent: As an IT admin setting up federation with SAML/WS-Fed identity providers, I want to configure the required attributes and claims for the SAML 2.0 or WS-Fed protocol, so that guest users can sign in to my Microsoft Entra tenant using their own organizational account.
---

# Federation with SAML/WS-Fed identity providers

[!INCLUDE [applies-to-workforce-external](./includes/applies-to-workforce-external.md)]

Your Microsoft Entra tenant can be directly federated with external organizations that use a SAML or WS-Fed identity provider (IdP). Users from the external organization can then use their IdP-managed account to sign in to your tenant, without having to create a separate Microsoft Entra account. For newly invited users, SAML/WS-Fed IdP federation takes precedence as the primary sign-in method. The user is redirected to their IdP when signing up or signing in to your app, and then returned to Microsoft Entra once they successfully sign in.

You can associate multiple domains with a single federation configuration. The partner's domain can be either Microsoft Entra verified or non-verified.

Setting up direct federation requires configuration both in your tenant and in the external organization's IdP. In some cases, the partner will need to update their DNS text records. They'll also need to update their IdP with the required claims and relying party trusts.

## When is a user authenticated with SAML/WS-Fed IdP federation?

After setting up federation, the sign-in experience for the external user depends on your sign-in settings and whether the partner's domain is Microsoft Entra verified.

### Federation with verified and non-verified domains

You can set up SAML/WS-Fed IdP federation with:

- **Microsoft Entra ID verified domains**: These are domains that have been verified within Microsoft Entra ID, including those where the tenant has undergone an [admin takeover](~/identity/users/domains-admin-takeover.md).
- **Non-verified domains**: These are domains that aren’t DNS-verified in Microsoft Entra ID.

For verified domains, Microsoft Entra ID is the primary identity provider used during invitation redemption. In the case of B2B collaboration in a workforce tenant, you can [change the redemption order](cross-tenant-access-overview.md#configurable-redemption) to make the federated IdP the primary method. Currently, redemption order settings aren’t supported in external tenants or across clouds.

For non-verified domains, users from the external organization are authenticated using the federated SAML/WS-Fed IdP.

### Federation with unmanaged (email-verified) tenants

You can set up SAML/WS-Fed IdP federation with domains that aren't DNS-verified in Microsoft Entra ID, including unmanaged (email-verified or "viral") Microsoft Entra tenants. Such tenants are created when a user redeems a B2B invitation or performs self-service sign-up for Microsoft Entra ID using a domain that doesn’t currently exist.

### How federation affects current external users

Setting up federation doesn't change the authentication method for users who have already redeemed an invitation. For example:

- Users who redeemed invitations before federation setup will continue using their original authentication method. For example, users who redeemed invitations with one-time passcode authentication before you set up federation will continue using one-time passcodes.
- If the external organization moves to Microsoft Entra ID after federation setup, users who redeemed invitations will continue using the federated SAML/WS-Fed IdP.
- If you set up federation with an external organization that subsequently moves to Microsoft Entra ID, users will continue using the federated IdP.
- Deleting federation will prevent users currently using the SAML/WS-Fed IdP from signing in.

You don't need to send new invitations to existing users because they'll continue using their current sign-in method. But in the case of B2B collaboration in a workforce tenant, you can [reset a user's redemption status](reset-redemption-status.md) so they repeat the redemption steps and switch to federation the next time they access your app. Currently, redemption order settings aren't supported in external tenants or across clouds.

### Sign-in endpoints in workforce tenants

When federation is set up in your workforce tenant, users from the federated organization can sign in to your multitenant or Microsoft first-party apps by using a [common endpoint](redemption-experience.md#redemption-process-and-sign-in-through-a-common-endpoint) (in other words, a general app URL that doesn't include your tenant context). During the sign-in process, the user chooses **Sign-in options**, and then selects **Sign in to an organization**. They type the name of your organization and continue signing in using their own credentials.

SAML/WS-Fed IdP federation users can also use application endpoints that include your tenant information, for example:

- `https://myapps.microsoft.com/?tenantid=<your tenant ID>`
- `https://myapps.microsoft.com/<your verified domain>.onmicrosoft.com`
- `https://portal.azure.com/<your tenant ID>`

You can also give users a direct link to an application or resource by including your tenant information, for example `https://myapps.microsoft.com/signin/X/<application ID?tenantId=<your tenant ID>`.

## Considerations for setting up federation

Setting up federation involves configuring both your Microsoft Entra tenant and the external organization's IdP. 

### Partner IdP requirements

Depending on the partner's IdP, the partner might need to update their DNS records to enable federation with you. See [Step 1: Determine if the partner needs to update their DNS text records](#step-1-determine-if-the-partner-needs-to-update-their-dns-text-records).

> [!NOTE]
> We no longer support an allowlist of IdPs for new SAML/WS-Fed IdP federations.

The Issuer URL in the SAML request sent by Microsoft Entra ID for external federations is now a tenanted endpoint, whereas previously it was a global endpoint. Existing federations with the global endpoint will continue to work. But for new federations, set the audience of the external SAML or WS-Fed IdP to a tenanted endpoint. See the [SAML 2.0 section](#required-saml-20-attributes-and-claims) and the [WS-Fed section](#required-ws-fed-attributes-and-claims) for required attributes and claims.

### Signing certificate expiration

If you specify the metadata URL in the IdP settings, Microsoft Entra ID automatically renews the signing certificate when it expires. However, if the certificate is rotated for any reason before the expiration time, or if you don't provide a metadata URL, Microsoft Entra ID is unable to renew it. In this case, you need to update the signing certificate manually.

### Session expiration

If the Microsoft Entra session expires or becomes invalid, and the federated IdP has SSO enabled, the user experiences SSO. If the federated user's session is valid, the user isn't prompted to sign in again. Otherwise, the user is redirected to their IdP for sign-in.

### Other considerations

The following are other considerations when federating with a SAML/WS-Fed identity provider.

- Federation doesn't resolve sign-in issues caused by a partially synced tenancy, where a partner’s on-premises user identities aren't fully synced to Microsoft Entra in the cloud. These users can’t sign in with a B2B invitation, so they need to use the [email one-time passcode](one-time-passcode.md) feature instead. The SAML/WS-Fed IdP federation feature is for partners with their own IdP-managed organizational accounts but no Microsoft Entra presence.

- Federation doesn't replace the need for B2B guest accounts in your directory. With B2B collaboration, a guest account is created for the user in your workforce tenant directory regardless of the authentication or federation method used. This user object allows you to grant access to applications, assign roles, and define membership in security groups.  

- Currently, the Microsoft Entra SAML/WS-Fed federation feature doesn't support sending a signed authentication token to the SAML identity provider.  

## Step 1: Determine if the partner needs to update their DNS text records

Use the following steps to determine if the partner needs to update their DNS records to enable federation with you. 

1. Check the partner's IdP passive authentication URL to see if the domain matches the target domain or a host within the target domain. In other words, when setting up federation for `fabrikam.com`:

   - If the passive authentication endpoint is `https://fabrikam.com` or `https://sts.fabrikam.com/adfs` (a host in the same domain), no DNS changes are needed.
   - If the passive authentication endpoint is `https://fabrikamconglomerate.com/adfs` or `https://fabrikam.com.uk/adfs`, the domain doesn't match the fabrikam.com domain, so the partner needs to add a text record for the authentication URL to their DNS configuration.

1. If DNS changes are needed based on the previous step, ask the partner to add a TXT record to their domain's DNS records, like the following example:

   `fabrikam.com.  IN   TXT   DirectFedAuthUrl=https://fabrikamconglomerate.com/adfs`

## Step 2: Configure the partner organization’s IdP

Next, your partner organization needs to configure their IdP with the required claims and relying party trusts.

> [!NOTE]
> To illustrate how to configure a SAML/WS-Fed IdP for federation, we’ll use Active Directory Federation Services (AD FS) as an example. See the article [Configure SAML/WS-Fed IdP federation with AD FS](direct-federation-adfs.md), which gives examples of how to configure AD FS as a SAML 2.0 or WS-Fed IdP in preparation for federation.

### SAML 2.0 configuration

Microsoft Entra B2B can be configured to federate with IdPs that use the SAML protocol with specific requirements listed in this section. For more information about setting up a trust between your SAML IdP and Microsoft Entra ID, see  [Use a SAML 2.0 Identity Provider (IdP) for SSO](~/identity/hybrid/connect/how-to-connect-fed-saml-idp.md).  

> [!NOTE]
> You can now set up SAML/WS-Fed IdP federation with other Microsoft Entra ID verified domains. [Learn more](#federation-with-verified-and-non-verified-domains)

#### Required SAML 2.0 attributes and claims
The following tables show requirements for specific attributes and claims that must be configured at the third-party IdP. To set up federation, the following attributes must be received in the SAML 2.0 response from the IdP. These attributes can be configured by linking to the online security token service XML file or by entering them manually.

> [!NOTE]
> Ensure the value matches the cloud for which you're setting up external federation.

Required attributes for the SAML 2.0 response from the IdP:

|Attribute  |Value  |
|---------|---------|
|AssertionConsumerService     |`https://login.microsoftonline.com/login.srf`         |
|Audience     |`https://login.microsoftonline.com/<tenant ID>/` (Recommended) Replace `<tenant ID>` with the tenant ID of the Microsoft Entra tenant you're setting up federation with.<br></br> In the SAML request sent by Microsoft Entra ID for external federations, the Issuer URL is a tenanted endpoint (for example, `https://login.microsoftonline.com/<tenant ID>/`). For any new federations, we recommend that all our partners set the audience of the SAML or WS-Fed based IdP to a tenanted endpoint. Any existing federations configured with the global endpoint (for example, `urn:federation:MicrosoftOnline`) will continue to work, but new federations will stop working if your external IdP is expecting a global issuer URL in the SAML request sent by Microsoft Entra ID.|
|Issuer     |The issuer URI of the partner's IdP, for example `http://www.example.com/exk10l6w90DHM0yi...`         |


Required claims for the SAML 2.0 token issued by the IdP:

|Attribute Name |Value  |
|---------|---------|
|NameID Format     |`urn:oasis:names:tc:SAML:2.0:nameid-format:persistent`         |
|`http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`      | emailaddress |

### WS-Fed configuration

Microsoft Entra B2B can be configured to federate with IdPs that use the WS-Fed protocol. This section discusses the requirements. Currently, the two WS-Fed providers have been tested for compatibility with Microsoft Entra ID include AD FS and Shibboleth. For more information about establishing a relying party trust between a WS-Fed compliant provider with Microsoft Entra ID, see the "STS Integration Paper using WS Protocols" available in the [Microsoft Entra identity Provider Compatibility Docs](https://www.microsoft.com/download/details.aspx?id=56843).

> [!NOTE]
> You can now set up SAML/WS-Fed IdP federation with other Microsoft Entra ID verified domains. [Learn more](#federation-with-verified-and-non-verified-domains)

#### Required WS-Fed attributes and claims

The following tables show requirements for specific attributes and claims that must be configured at the third-party WS-Fed IdP. To set up federation, the following attributes must be received in the WS-Fed message from the IdP. These attributes can be configured by linking to the online security token service XML file or by entering them manually.

> [!NOTE]
> Ensure the value matches the cloud for which you're setting up external federation.

Required attributes in the WS-Fed message from the IdP:
 
|Attribute  |Value  |
|---------|---------|
|PassiveRequestorEndpoint     |`https://login.microsoftonline.com/login.srf`         |
|Audience     |`https://login.microsoftonline.com/<tenant ID>/` (Recommended) Replace `<tenant ID>` with the tenant ID of the Microsoft Entra tenant you're setting up federation with.<br></br> In the SAML request sent by Microsoft Entra ID for external federations, the Issuer URL is a tenanted endpoint (for example, `https://login.microsoftonline.com/<tenant ID>/`). For any new federations, we recommend that all our partners set the audience of the SAML or WS-Fed based IdP to a tenanted endpoint. Any existing federations configured with the global endpoint (for example, `urn:federation:MicrosoftOnline`) will continue to work, but new federations will stop working if your external IdP is expecting a global issuer URL in the SAML request sent by Microsoft Entra ID.          |
|Issuer     |The issuer URI of the partner's IdP, for example `http://www.example.com/exk10l6w90DHM0yi...`         |

Required claims for the WS-Fed token issued by the IdP:

|Attribute  |Value  |
|---------|---------|
|ImmutableID     |`http://schemas.microsoft.com/LiveID/Federation/2008/05/ImmutableID`         |
|emailaddress     |`http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`         |

<a name='step-3-configure-samlws-fed-idp-federation-in-azure-ad'></a>

## Step 3: Configure SAML/WS-Fed IdP federation in Microsoft Entra ID

Next, configure federation with the IdP configured in step 1 in Microsoft Entra ID. You can use either the Microsoft Entra admin center or the [Microsoft Graph API](/graph/api/resources/samlorwsfedexternaldomainfederation?view=graph-rest-beta&preserve-view=true). It might take 5-10 minutes before the federation policy takes effect. During this time, don't attempt to redeem an invitation for the federation domain. The following attributes are required:

- Issuer URI of the partner's IdP
- Passive authentication endpoint of partner IdP (only https is supported)
- Certificate

### To configure federation in the Microsoft Entra admin center


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Identity** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab, and then select **Add new** > **SAML/WS-Fed**.

   :::image type="content" source="media/direct-federation/new-saml-wsfed-idp.png" alt-text="Screenshot showing button for adding a new SAML or WS-Fed IdP." lightbox="media/direct-federation/new-saml-wsfed-idp.png":::

1. On the **New SAML/WS-Fed IdP** page, enter the following:
   - **Display name** - Enter a name to help you identify the partner's IdP.
   - **Identity provider protocol** - Select **SAML** or **WS-Fed**.
   - **Domain name of federating IdP** - Enter your partner’s IdP target domain name for federation. During this initial configuration, enter just one domain name. You can add more domains later.

    :::image type="content" source="media/direct-federation/new-saml-wsfed-idp-parse.png" alt-text="Screenshot showing the new SAML or WS-Fed IdP page.":::

1. Select a method for populating metadata. If you have a file that contains the metadata, you can automatically populate the fields by selecting **Parse metadata file** and browsing for the file. Or, you can select **Input metadata manually** and enter the following information:
   - The **Issuer URI** of the partner's SAML IdP, or the **Entity ID** of the partner's WS-Fed IdP.
   - The **Passive authentication endpoint** of the partner's SAML IdP, or the **Passive requestor endpoint** of the partner's WS-Fed IdP.
   - **Certificate** - The signing certificate ID.
   - **Metadata URL** - The location of the IdP's metadata for automatic renewal of the signing certificate.

   :::image type="content" source="media/direct-federation/new-saml-wsfed-idp-input.png" alt-text="Screenshot showing metadata fields.":::

   > [!NOTE]
   > Metadata URL is optional, however we strongly recommend it. If you provide the metadata URL, Microsoft Entra ID can automatically renew the signing certificate when it expires. If the certificate is rotated for any reason before the expiration time or if you do not provide a metadata URL, Microsoft Entra ID will be unable to renew it. In this case, you'll need to update the signing certificate manually.

1. Select **Save**. The identity provider is added to the **SAML/WS-Fed identity providers** list.

      :::image type="content" source="media/direct-federation/new-saml-wsfed-idp-list.png" alt-text="Screenshot showing the SAML/WS-Fed identity provider list with the new entry." lightbox="media/direct-federation/new-saml-wsfed-idp-list.png":::

1. (Optional) To add more domain names to this federating identity provider:
   
   1. Select the link in the **Domains** column.

      :::image type="content" source="media/direct-federation/new-saml-wsfed-idp-add-domain.png" alt-text="Screenshot showing the link for adding domains to the SAML/WS-Fed identity provider." lightbox="media/direct-federation/new-saml-wsfed-idp-add-domain.png":::

   1. Next to **Domain name of federating IdP**, type the domain name, and then select **Add**. Repeat for each domain you want to add. When you're finished, select **Done**.

      :::image type="content" source="media/direct-federation/add-domain.png" alt-text="Screenshot showing the Add button in the domain details pane.":::
   
### To configure federation using the Microsoft Graph API

You can use the Microsoft Graph API [samlOrWsFedExternalDomainFederation](/graph/api/resources/samlorwsfedexternaldomainfederation?view=graph-rest-beta&preserve-view=true) resource type to set up federation with an identity provider that supports either the SAML or WS-Fed protocol.

<a name='step-4-test-samlws-fed-idp-federation-in-azure-ad'></a>

## Step 4: Configure the redemption order for Microsoft Entra ID verified domains

If the domain is Microsoft Entra ID verified, [configure the **Redemption order** settings](cross-tenant-access-settings-b2b-collaboration.yml) in your cross-tenant access settings for inbound B2B collaboration. Move **SAML/WS-Fed identity providers** to the top of the **Primary identity providers** list to prioritize redemption with the federated IdP.

> [!NOTE]
> The Microsoft Entra admin center settings for the configurable redemption feature are currently rolling out to customers. Until the settings are available in the admin center, you can configure the invitation redemption order using the Microsoft Graph REST API (beta version). See [Example 2: Update default invitation redemption configuration](/graph/api/crosstenantaccesspolicyconfigurationdefault-update?view=graph-rest-beta&tabs=http#example-2-update-default-invitation-redemption-configuration&preserve-view=true) in the Microsoft Graph reference documentation.

## Step 5: Test SAML/WS-Fed IdP federation in Microsoft Entra ID

Now test your federation setup by inviting a new B2B guest user. For details, see [Add Microsoft Entra B2B collaboration users in the Microsoft Entra admin center](add-users-administrator.yml).
 
## How do I update the certificate or configuration details?

On the **All identity providers** page, you can view the list of SAML/WS-Fed identity providers you've configured and their certificate expiration dates. From this list, you can renew certificates and modify other configuration details.

<!--TODO:::image type="content" source="media/direct-federation/new-saml-wsfed-idp-list-multi.png" alt-text="Screenshot showing an identity provider in the SAML WS-Fed list.":::-->

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Identity** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab.
1. Scroll to an identity provider in the list or use the search box.
1. To update the certificate or modify configuration details:
   - In the **Configuration** column for the identity provider, select the **Edit** link.
   - On the configuration page, modify any of the following details:
     - **Display name** - Display name for the partner's organization.
     - **Identity provider protocol** - Select **SAML** or **WS-Fed**.
     - **Passive authentication endpoint** - The partner IdP's passive requestor endpoint.
     - **Certificate** - The ID of the signing certificate. To renew it, enter a new certificate ID.
     - **Metadata URL** - The URL containing the partner's metadata, used for automatic renewal of the signing certificate.
   - Select **Save**.

   :::image type="content" source="media/direct-federation/modify-configuration.png" alt-text="Screenshot of the IDP configuration details.":::

1. To edit the domains associated with the partner, select the link in the **Domains** column. In the domain details pane:

   - To add a domain, type the domain name next to **Domain name of federating IdP**, and then select **Add**. Repeat for each domain you want to add.
   - To delete a domain, select the delete icon next to the domain.
   - When you're finished, select **Done**.

   :::image type="content" source="media/direct-federation/edit-domains.png" alt-text="Screenshot of the domain configuration page.":::

   > [!NOTE]
   > To remove federation with the partner, delete all but one of the domains and follow the steps in the [next section](#how-do-i-remove-federation).

## How do I remove federation?

You can remove your federation configuration. If you do, federation guest users who have already redeemed their invitations can no longer sign in. But you can give them access to your resources again by [resetting their redemption status](reset-redemption-status.md).
To remove a configuration for an IdP in the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Identity** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab, and then scroll to the identity provider in the list or use the search box.
1. Select the link in the **Domains** column to view the IdP's domain details.
1. Delete all but one of the domains in the **Domain name** list.
1. Select **Delete Configuration**, and then select **Done**.

   :::image type="content" source="media/direct-federation/delete-configuration.png" alt-text="Screenshot of deleting a configuration.":::

1. Select **OK** to confirm deletion.

You can also remove federation using the Microsoft Graph API [samlOrWsFedExternalDomainFederation](/graph/api/resources/samlorwsfedexternaldomainfederation?view=graph-rest-beta&preserve-view=true) resource type.

## Next steps

Learn more about the [invitation redemption experience](redemption-experience.md) when external users sign in with various identity providers.

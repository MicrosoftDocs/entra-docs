---

title: Microsoft Entra External ID Overview
description: Compare solutions for using Microsoft Entra External ID to work with people outside your organization, including Microsoft Entra B2B collaboration and Azure AD B2C.
ms.topic: overview
ms.date: 01/30/2026

ms.collection: M365-identity-device-management
#customer intent: As a developer who creates apps for consumers and business customers, I want to understand the capabilities of Microsoft Entra External ID so that I can manage my customers' identity experiences and allow them to use their own credentials to sign in.
---

# Introduction to Microsoft Entra External ID

Microsoft Entra External ID combines powerful solutions for working with people outside your organization. With External ID capabilities, you can allow external identities to securely access your apps and resources.

Whether you're working with external partners, consumers, or business customers, users can bring their own identities. These identities can include corporate or government-issued accounts and social identity providers like Google or Facebook.

:::image type="content" source="media/external-identities-overview/external-identities-overview.png" alt-text="Diagram that shows an overview of External ID." border="true":::

These scenarios fall within the scope of External ID:

- If you're an organization or a developer who creates consumer apps, use External ID to quickly add authentication and customer identity and access management (CIAM) to your application. Register your app, create customized sign-in experiences, and manage your app users in a Microsoft Entra tenant in an *external* configuration. This tenant is separate from your employees and organizational resources.

- If you want to enable your employees to collaborate with business partners and guests, use External ID for B2B collaboration. Allow secure access to your enterprise apps through invitation or self-service sign-up. Determine the level of access that guests have to the Microsoft Entra tenant that contains your employees and organizational resources, which is a tenant in a *workforce* configuration.

External ID is a flexible solution for both:

- Consumer-oriented app developers who need authentication and CIAM.
- Businesses that seek secure B2B collaboration.

## App access for consumers and business customers

Organizations and developers can use [External ID in an external tenant](customers/overview-customers-ciam.md) as their CIAM solution when publishing their apps to consumers and business customers.

You can create a separate Microsoft Entra tenant in an external configuration to manage your apps and user accounts separately from your workforce. Within this tenant, you can configure custom-branded sign-up experiences and user management features:

- Set up self-service registration flows that define the sign-up steps that customers follow and the sign-in methods that they can use. These methods include email and password, one-time passcodes, or social accounts from Google or Facebook.

- Create a custom experience for users who sign in to your apps by configuring branding settings for your tenant. With these settings, you can add your own background images, colors, company logos, and text for sign-ins across your apps.

- Collect information from customers during sign-up by selecting from built-in user attributes or adding your own custom attributes.

- Analyze user activity and engagement data to uncover valuable insights that can aid strategic decisions and drive business growth.

With External ID, customers can sign in by using an identity that they already have. You can customize and control how customers sign up and sign in when they use your applications. Because these CIAM capabilities are built into External ID, you also benefit from Microsoft Entra platform features like enhanced security, compliance, and scalability.

For details, see the [overview of Microsoft Entra External ID in external tenants](customers/overview-customers-ciam.md).

## Collaboration with business guests

[External ID B2B collaboration](what-is-b2b.md) allows your workforce to collaborate with external business partners. You can invite anyone to sign in to your Microsoft Entra organization by using their own credentials so they can access the apps and resources that you want to share with them. 

Use B2B collaboration when you need to let business guests access your Office 365 apps, software-as-a-service (SaaS) apps, and line-of-business apps. There are no credentials associated with business guests. Instead, they authenticate with their home organization or identity provider, and then your organization checks their eligibility for guest collaboration.

There are various ways to add business guests to your organization for collaboration:

- Invite users to collaborate by using their Microsoft Entra accounts, Microsoft accounts, or social identities that you enable, such as Google. An admin can use the Microsoft Entra admin center or PowerShell to invite users to collaborate. Users sign in to the shared resources by using a simple redemption process with their work, school, or other email account.

- Use self-service sign-up user flows to let guests sign up for applications themselves. The experience can be customized to allow sign-up with a work, school, or social identity (like Google or Facebook). You can also collect information about users during the sign-up process.

- Use [Microsoft Entra entitlement management](~/id-governance/entitlement-management-overview.md), a feature for managing [identity and access for external users at scale](~/id-governance/entitlement-management-external-users.md#how-access-works-for-external-users). You can use this feature to automate access request workflows, access assignments, reviews, and expiration.

A user object is created for business guests in the same directory that you use for your employees. You can manage this user object like other user objects in your directory. For example, you can add it to groups. You can assign permissions to the user object for authorization while letting users use their existing credentials for authentication.

You can use [cross-tenant access settings](cross-tenant-access-overview.md) to manage collaboration with other Microsoft Entra organizations and across Microsoft Azure clouds. For collaboration with non-Microsoft Entra external users and organizations, use [external collaboration settings](external-collaboration-settings-configure.md).

## Workforce vs. external tenants

A *tenant* is a dedicated and trusted instance of Microsoft Entra ID. It contains an organization's resources, including registered apps and a directory of users. There are two ways to configure a tenant, depending on how the organization intends to use the tenant and the resources that you want to manage:

- A *workforce* tenant configuration is a standard Microsoft Entra tenant that contains your employees, internal business apps, and other organizational resources. In a workforce tenant, your internal users can collaborate with external business partners and guests by using B2B collaboration.
- An *external* tenant configuration is exclusively for apps that you want to publish to consumers or business customers. This distinct tenant follows the standard Microsoft Entra tenant model but is configured for consumer scenarios. It contains your app registrations and a directory of consumer or customer accounts.

For details, see [Workforce and external tenant configurations in Microsoft Entra External ID](tenant-configurations.md).

<a name='comparing-external-identities-feature-sets'></a>

## Comparison of External ID feature sets

The following table compares the scenarios that you can enable with External ID.

| | External ID in workforce tenants | External ID in external tenants |
| ---- | --- | --- |
| **Primary scenario** | Allow your workforce to collaborate with business guests. Let guests use their preferred identities to sign in to resources in your Microsoft Entra organization. External ID provides access to Microsoft applications or your own applications, including SaaS apps or custom-developed apps. <br><br> *Example:* Invite a guest to sign in to your Microsoft apps or become a guest member in Teams. | Publish apps to external consumers and business customers by using External ID for identity experiences. External ID provides identity and access management for modern SaaS or custom-developed apps (not Microsoft apps). <br><br> *Example:* Create a customized sign-in experience for users of your consumer mobile app and monitor app usage. |
| **Intended for** | Collaborating with business partners from external organizations like suppliers, partners, and vendors. These users might or might not have Microsoft Entra ID or managed IT. | Consumers and business customers of your app. These users are managed in a Microsoft Entra tenant that's configured for external apps and users. |
| **User management** | You manage B2B collaboration users in the same workforce tenant as employees but typically annotate them as guest users. You can manage guest users the same way as employees and add them to the same groups. You can use [cross-tenant access settings](cross-tenant-access-overview.md) to determine which users have access to B2B collaboration. | You manage app users in an external tenant that you create for consumers of your application. Users in an external tenant have different [default permissions](customers/reference-user-permissions.md) than users in a workforce tenant. The external tenant is separate from the organization's employee directory. |
| **Single sign-on (SSO)** | SSO to all Microsoft Entra-connected apps is supported. For example, you can provide access to Microsoft 365 or on-premises apps, and to other SaaS apps such as Salesforce or Workday. | SSO to apps registered in the external tenant is supported. SSO to Microsoft 365 or to other Microsoft SaaS apps isn't supported. |
| **Company branding** | The default state for the authentication experience is a Microsoft design. Administrators can customize the guest sign-in experience with their company branding. | The default branding for the external tenant is neutral and doesn't include any existing Microsoft branding. Administrators can customize the branding for the organization or per application.  [Learn more](customers/concept-branding-customers.md). |  
| **Microsoft cloud settings** | [Supported.](cross-cloud-settings.md)  |  Not applicable. |
| **Entitlement management** | [Supported.](~/id-governance/entitlement-management-overview.md) | Not applicable. |

<a name='related-azure-ad-technologies'></a>

## Related technologies

Several Microsoft Entra technologies are related to collaboration with external users and organizations. As you design your External ID collaboration model, consider these other features.

### B2B direct connect

You can use B2B direct connect to create two-way trust relationships with other Microsoft Entra organizations to enable the Teams Connect shared channels feature. This feature allows users to seamlessly sign in to Teams shared channels for chat, calls, file sharing, and app sharing.

When two organizations mutually enable B2B direct connect, users authenticate in their home organization and receive a token from the resource organization for access. Unlike B2B collaboration, B2B direct connect users aren't added as guests to your workforce directory. [Learn more about B2B direct connect in Microsoft Entra External ID](b2b-direct-connect-overview.md).

After you set up B2B direct connect with an external organization, the following Teams shared channels capabilities become available:

- A shared channel owner can search within Teams for allowed users from the external organization and add them to the shared channel.

- External users can access the Teams shared channel without having to switch organizations or sign in by using a different account. From within Teams, an external user can access files and apps through the **Files** tab. The shared channel's policies determine the user's access.

You use [cross-tenant access settings](cross-tenant-access-settings-b2b-collaboration.yml) to manage trust relationships with other Microsoft Entra organizations and to define inbound and outbound policies for B2B direct connect.

For details about the resources, files, and applications that are available to users of B2B direct connect via the Teams shared channel, refer to [Chat, teams, channels, and apps in Microsoft Teams](/microsoftteams/deploy-chat-teams-channels-microsoft-teams-landing-page).

Licensing and billing are based on monthly active users. [Learn more about the billing model for Microsoft Entra External ID](external-identities-pricing.md).  

### Azure Active Directory B2C

Azure Active Directory B2C (Azure AD B2C) is a legacy solution for customer identity and access management. Azure AD B2C includes a separate consumer-based directory that you manage in the Azure portal through the Azure AD B2C service. Each Azure AD B2C tenant is separate and distinct from other Microsoft Entra ID and Azure AD B2C tenants.

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](~/includes/active-directory-b2c-end-of-sale-notice.md)]

The Azure AD B2C portal experience is similar to Microsoft Entra ID, but there are key differences. For example, you can customize your user journeys by using the Identity Experience Framework.

For more information about how an Azure AD B2C tenant differs from a Microsoft Entra tenant, see [Supported Microsoft Entra features in Azure AD B2C](/azure/active-directory-b2c/supported-azure-ad-features). For details about configuring and managing Azure AD B2C, see the [Azure AD B2C documentation](/azure/active-directory-b2c/).

<a name='azure-ad-entitlement-management-for-b2b-guest-user-sign-up'></a>

### Microsoft Entra entitlement management for business guest sign-up

You might not know ahead of time which individual external collaborators need access to your resources. You need a way for users from partner companies to sign themselves up with policies that you control.

To enable users from other organizations to request access, you can use [Microsoft Entra entitlement management](~/id-governance/entitlement-management-overview.md) to configure policies that [manage access for external users](~/id-governance/entitlement-management-external-users.md#how-access-works-for-external-users). Upon approval, these users are provisioned with guest accounts and assigned to groups, apps, and SharePoint Online sites.

### Conditional Access

Organizations can use Microsoft Entra Conditional Access policies to enhance their security by applying the appropriate access controls to external users. These controls include multifactor authentication (MFA).

#### Conditional Access and MFA in external tenants

In external tenants, organizations can enforce MFA for customers by creating a Conditional Access policy and adding MFA to sign-up and sign-in user flows. External tenants support two methods for authentication as a second factor:

- **Email one-time passcode**: After users sign in with their email and password, they're prompted for a passcode that's sent to their email.
- **SMS-based authentication**: SMS is available as a second-factor authentication method for MFA for users in external tenants. Users who sign in with email and password, email and one-time passcode, or social identities like Google or Facebook are prompted for second verification through SMS.

[Learn more about authentication methods in external tenants](customers/concept-multifactor-authentication-customers.md).

#### Conditional Access for B2B collaboration and B2B direct connect

In a workforce tenant, organizations can enforce Conditional Access policies for external B2B collaboration and B2B direct connect users in the same way that they're enabled for full-time employees and members of the organization. For Microsoft Entra cross-tenant scenarios, if your Conditional Access policies require MFA or device compliance, you can now trust MFA and device compliance claims from an external user's home organization.

When trust settings are enabled, during authentication, Microsoft Entra ID checks a user's credentials for an MFA claim or a device ID to determine if the policies were already met. If so, the external user is granted seamless sign-on to your shared resource. Otherwise, an MFA or device challenge is initiated in the user's home tenant. [Learn more about the authentication flow and Conditional Access for external users in workforce tenants](authentication-conditional-access.md).

### Multitenant applications

If you offer a SaaS application to many organizations, you can configure your application to accept sign-ins from any Microsoft Entra tenant. This configuration is called making your application multitenant. Users in any Microsoft Entra tenant can sign in to your application after they consent to use their account with your application. [Learn how to enable multitenant sign-ins](~/identity-platform/howto-convert-app-to-be-multi-tenant.md).

### Multitenant organizations

A [multitenant organization](../identity/multi-tenant-organizations/multi-tenant-organization-overview.md) is an organization that has more than one instance of Microsoft Entra ID. There are various reasons for using multiple tenants. For example, your organization might span multiple clouds or geographical boundaries.

The capability of multitenant organizations enables seamless collaboration across Microsoft 365. It also improves employee collaboration experiences across your organization of multiple tenants in applications such as Microsoft Teams and Microsoft Viva Engage.

The [cross-tenant synchronization](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md) capability is a one-way synchronization service that enables users to access resources without receiving an invitation email and having to accept a consent prompt in each tenant.

To learn more about multitenant organizations and cross-tenant synchronization, see the [documentation for multitenant organizations](../identity/multi-tenant-organizations/index.yml) and the [feature comparison](../identity/multi-tenant-organizations/overview.md#compare-multitenant-capabilities).

## Microsoft Graph APIs

All External ID features are also supported for automation through Microsoft Graph APIs, except the feature that the following table describes. For more information, see [Manage Microsoft Entra identity and network access by using Microsoft Graph](/graph/api/resources/identity-network-access-overview).

| External ID feature | Supported in | Automation workarounds |
| ---- | --- | --- |
| [Identify organizations that you belong to](leave-the-organization.md#what-organizations-do-i-belong-to) | Workforce tenants | See [Tenants - List](/rest/api/resources/tenants/list)  in the Azure Resource Manager API. For Teams shared channels and B2B direct connect, use [Get `tenantReferences`](/graph/api/outboundshareduserprofile-list-tenants) in the Microsoft Graph API. |

<a name='azure-ad-microsoft-graph-api-for-b2b-collaboration'></a>

These Microsoft Graph APIs are available for Microsoft Entra B2B collaboration:

- [Cross-tenant access APIs](/graph/api/resources/crosstenantaccesspolicy-overview?view=graph-rest-beta&preserve-view=true). Programmatically create the same B2B collaboration and B2B direct connect policies that are configurable in the Azure portal.

  By using these APIs, you can set up policies for inbound and outbound collaboration. For example, you can allow or block features for everyone by default and limit access to specific organizations, groups, users, and applications.
  
  You can also use these APIs to accept MFA and device claims (compliant claims and Microsoft Entra hybrid-joined claims) from other Microsoft Entra organizations.

- [Resource type for invitation management](/graph/api/resources/invitation). Build your own onboarding experiences for business guests. For example, you can use the [Create Invitation API](/graph/api/invitation-post) to automatically send a customized invitation email directly to the B2B user. Or you can use the `inviteRedeemUrl` value returned in the creation response to craft your own invitation (through your communication mechanism of choice) to the invited user.

## Related content

- [What is Microsoft Entra B2B collaboration?](what-is-b2b.md)
- [What is Microsoft Entra B2B direct connect?](b2b-direct-connect-overview.md)
- [About Microsoft Entra multitenant organizations](../identity/multi-tenant-organizations/overview.md)

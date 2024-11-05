---

title: Microsoft Entra External ID overview
description: Microsoft Entra External ID allows you to collaborate with or publish apps to people outside your organization. Compare solutions for External ID, including Microsoft Entra B2B collaboration, Microsoft Entra B2B collaboration, and Azure AD B2C.

 
ms.service: entra-external-id
ms.topic: overview
ms.date: 09/06/2024
ms.author: mimart
author: msmimart
manager: celestedg

ms.collection: M365-identity-device-management
#customer intent: As a developer creating apps for consumers and business customers, I want to understand the capabilities of Microsoft Entra External ID, so that I can securely manage my customers' identity experiences and allow them to use their own credentials to sign in.
---

# Introduction to Microsoft Entra External ID

Microsoft Entra External ID combines powerful solutions for working with people outside of your organization. With External ID capabilities, you can allow external identities to securely access your apps and resources. Whether you’re working with external partners, consumers, or business customers, users can bring their own identities. These identities can range from corporate or government-issued accounts to social identity providers like Google or Facebook.

:::image type="content" source="media/external-identities-overview/external-identities-overview.png" alt-text="Diagram showing an overview of External ID." border="true":::

These scenarios fall within the scope of Microsoft Entra External ID:

- If you’re an organization or a developer creating consumer apps, use External ID to quickly add authentication and customer identity and access management (CIAM) to your application. Register your app, create customized sign-in experiences, and manage your app users in a Microsoft Entra tenant in an *external* configuration. This tenant is separate from your employees and organizational resources.

- If you want to enable your employees to collaborate with business partners and guests, use External ID for B2B collaboration. Allow secure access to your enterprise apps through invitation or self-service sign-up. Determine the level of access guests have to the Microsoft Entra tenant that contains your employees and organizational resources, which is a tenant in a *workforce* configuration.

Microsoft Entra External ID is a flexible solution for both consumer-oriented app developers needing authentication and CIAM, and businesses seeking secure B2B collaboration.

## Secure your apps for consumers and business customers

Organizations and developers can use [External ID in an external tenant](customers/overview-customers-ciam.md) as their CIAM solution when publishing their apps to consumers and business customers. You can create a separate Microsoft Entra tenant in an *external* configuration, which allows you to manage your apps and user accounts separately from your workforce. Within this tenant, you can easily configure custom-branded sign-up experiences and user management features:

- Set up self-service registration flows that define the series of sign-up steps customers follow and the sign-in methods they can use, such as email and password, one-time passcodes, or social accounts from Google or Facebook.

- Create a custom look and feel for users signing in to your apps by configuring Company branding settings for your tenant. With these settings, you can add your own background images, colors, company logos, and text to customize the sign-in experiences across your apps.

- Collect information from customers during sign-up by selecting from a series of built-in user attributes or adding your own custom attributes.

- Analyze user activity and engagement data to uncover valuable insights that can aid strategic decisions and drive business growth.

With External ID, customers can sign in with an identity they already have. You can customize and control how customers sign up and sign in when using your applications. Because these CIAM capabilities are built into External ID, you also benefit from Microsoft Entra platform features like enhanced security, compliance, and scalability.

For details, see [Overview of Microsoft Entra External ID in external tenants](customers/overview-customers-ciam.md).

## Collaborate with business guests

[External ID B2B collaboration](what-is-b2b.md) allows your workforce to collaborate with external business partners. You can invite anyone to sign in to your Microsoft Entra organization using their own credentials so they can access the apps and resources you want to share with them. Use B2B collaboration when you need to let business guests access your Office 365 apps, software-as-a-service (SaaS) apps, and line-of-business applications. There are no credentials associated with business guests. Instead, they authenticate with their home organization or identity provider, and then your organization checks the user’s eligibility for guest collaboration.

There are various ways to add business guests to your organization for collaboration:

- Invite users to collaborate using their Microsoft Entra accounts, Microsoft accounts, or social identities that you enable, such as Google. An admin can use the Microsoft Entra admin center or PowerShell to invite users to collaborate. The user signs into the shared resources using a simple redemption process with their work, school, or other email account.

- Use self-service sign-up user flows to let guests sign up for applications themselves. The experience can be customized to allow sign-up with a work, school, or social identity (like Google or Facebook). You can also collect information about the user during the sign-up process.

- Use [Microsoft Entra entitlement management](~/id-governance/entitlement-management-overview.md), an identity governance feature that lets you manage [identity and access for external users at scale](~/id-governance/entitlement-management-external-users.md#how-access-works-for-external-users) by automating access request workflows, access assignments, reviews, and expiration.

A user object is created for the business guest in the same directory as your employees. This user object can be managed like other user objects in your directory, added to groups, and so on. You can assign permissions to the user object (for authorization) while letting them use their existing credentials (for authentication).

You can use [cross-tenant access settings](cross-tenant-access-overview.md) to manage collaboration with other Microsoft Entra organizations and across Microsoft Azure clouds. For collaboration with non-Azure AD external users and organizations, use [external collaboration settings](external-collaboration-settings-configure.md).

## What are "workforce" and "external" tenants?

A *tenant* is a dedicated and trusted instance of Microsoft Entra ID that contains an organization's resources, including registered apps and a directory of users. There are two ways to configure a tenant, depending on how the organization intends to use the tenant and the resources they want to manage:

- A **workforce** tenant configuration is a standard Microsoft Entra tenant that contains your employees, internal business apps, and other organizational resources. In a workforce tenant, your internal users can collaborate with external business partners and guests using B2B collaboration.
- An **external** tenant configuration is used exclusively for apps you want to publish to consumers or business customers. This distinct tenant follows the standard Microsoft Entra tenant model, but is configured for consumer scenarios. It contains your app registrations and a directory of consumer or customer accounts.

For details, see [Workforce and external tenant configurations in Microsoft Entra External ID](tenant-configurations.md).

<a name='comparing-external-identities-feature-sets'></a>

## Comparing External ID feature sets

The following table compares the scenarios you can enable with External ID.

|   | External ID in workforce tenants |  External ID in external tenants  |
| ---- | --- |   --- |
| **Primary scenario**  | Allow your workforce to collaborate with business guests. Let guests use their preferred identities to sign in to resources in your Microsoft Entra organization. Provides access to Microsoft applications or your own applications (SaaS apps, custom-developed apps, and so on). <br><br> *Example:* Invite a guest to sign in to your Microsoft apps or become a guest member in Teams. |  Publish apps to external consumers and business customers using External ID for identity experiences. Provides identity and access management for modern SaaS or custom-developed applications (not first-party Microsoft apps). <br><br> *Example:* Create a customized sign-in experience for users of your consumer mobile app and monitor app usage. |
| **Intended for**  | Collaborating with business partners from external organizations like suppliers, partners, vendors. These users might or might not have Microsoft Entra ID or managed IT.   |   Consumers and business customers of your app. These users are managed in a Microsoft Entra tenant that is configured for external apps and users. |
| **User management**  | B2B collaboration users are managed in the same workforce tenant as employees but are typically annotated as guest users. Guest users can be managed the same way as employees, added to the same groups, and so on. [Cross-tenant access settings](cross-tenant-access-overview.md) can be used to determine which users have access to B2B collaboration.   |   App users are managed in an external tenant that you create for consumers of your application. Users in an external tenant have different [default permissions](customers/reference-user-permissions.md) than users in a workforce tenant. They're managed in the external tenant, separate from the organization's employee directory. |
| **Single sign-on (SSO)**  | SSO to all Microsoft Entra connected apps is supported. For example, you can provide access to Microsoft 365 or on-premises apps, and to other SaaS apps such as Salesforce or Workday.  | SSO to apps registered in the external tenant is supported. SSO to Microsoft 365 or to other Microsoft SaaS apps isn't supported. |
|   **Company branding**    |  The default state for the authentication experience is a Microsoft look and feel. Administrators can customize the guest sign-in experience with their company branding.    |  The default branding for the external tenant is neutral and doesn't include any existing Microsoft branding. Administrators can customize the branding for the organization or per application.  [Learn more](customers/concept-branding-customers.md).    |  
| **Microsoft cloud settings**  | [Supported.](cross-cloud-settings.md)  |  Not applicable.  |
| **Entitlement management**  | [Supported.](~/id-governance/entitlement-management-overview.md)  | Not applicable. |

<a name='related-azure-ad-technologies'></a>

## Related technologies

There are several Microsoft Entra technologies that are related to collaboration with external users and organizations. As you design your External ID collaboration model, consider these other features.

### B2B direct connect

B2B direct connect lets you create two-way trust relationships with other Microsoft Entra organizations to enable the Teams Connect shared channels feature. This feature allows users to seamlessly sign in to Teams shared channels for chat, calls, file-sharing, and app-sharing. When two organizations mutually enable B2B direct connect, users authenticate in their home organization and receive a token from the resource organization for access. Unlike B2B collaboration, B2B direct connect users aren't added as guests to your workforce directory. Learn more about [B2B direct connect in Microsoft Entra External ID](b2b-direct-connect-overview.md).

Once you set up B2B direct connect with an external organization, the following Teams shared channels capabilities become available:

- A shared channel owner can search within Teams for allowed users from the external organization and add them to the shared channel.

- External users can access the Teams shared channel without having to switch organizations or sign in with a different account. From within Teams, the external user can access files and apps through the Files tab. The shared channel’s policies determine the user’s access.

You use [cross-tenant access settings](cross-tenant-access-settings-b2b-collaboration.yml) to manage trust relationships with other Microsoft Entra organizations and define inbound and outbound policies for B2B direct connect.

For details about the resources, files, and applications that are available to the B2B direct connect user via the Teams shared channel refer to [Chat, teams, channels, & apps in Microsoft Teams](/microsoftteams/deploy-chat-teams-channels-microsoft-teams-landing-page).

Licensing and billing are based on monthly active users (MAU). Learn more about the [billing model for Microsoft Entra External ID](external-identities-pricing.md).  

### Azure Active Directory B2C

Azure Active Directory B2C (Azure AD B2C) is Microsoft's legacy solution for customer identity and access management. Azure AD B2C includes a separate consumer-based directory that you manage in the Azure portal through the Azure AD B2C service. Each Azure AD B2C tenant is separate and distinct from other Microsoft Entra ID and Azure AD B2C tenants. The Azure AD B2C portal experience is similar to Microsoft Entra ID, but there are key differences, such as the ability to customize your user journeys using the Identity Experience Framework.

For more information about how an Azure AD B2C tenant differs from a Microsoft Entra tenant, see [Supported Microsoft Entra features in Azure AD B2C](/azure/active-directory-b2c/supported-azure-ad-features). For details about configuring and managing Azure AD B2C, see the [Azure AD B2C documentation](/azure/active-directory-b2c/).

<a name='azure-ad-entitlement-management-for-b2b-guest-user-sign-up'></a>

### Microsoft Entra entitlement management for business guest sign-up

As an inviting organization, you might not know ahead of time who the individual external collaborators are who need access to your resources. You need a way for users from partner companies to sign themselves up with policies that you control. To enable users from other organizations to request access, you can use [Microsoft Entra entitlement management](~/id-governance/entitlement-management-overview.md) to configure policies that [manage access for external users](~/id-governance/entitlement-management-external-users.md#how-access-works-for-external-users). Upon approval, these users will be provisioned with guest accounts and assigned to groups, apps, and SharePoint Online sites.

### Conditional Access

Organizations can use Conditional Access policies to enhance their security by applying the appropriate access controls, such as MFA, to external users.

#### Conditional access and MFA in external tenants

In external tenants, organizations can enforce MFA for customers by creating a Microsoft Entra Conditional Access policy and adding MFA to sign-up and sign-in user flows. External tenants support two methods for authentication as a second factor:

- **Email one-time passcode**: After the user signs in with their email and password, they are prompted for a passcode that is sent to their email. 
- **SMS-based authentication**: SMS is available as a second factor authentication method for MFA for users in external tenants. Users who sign in with email and password, email and one-time passcode, or social identities like Google or Facebook, are prompted for second verification using SMS.

Learn more about [authentication methods in external tenants](customers/concept-multifactor-authentication-customers.md).

#### Conditional Access for B2B collaboration and B2B direct connect

In a workforce tenant, organizations can enforce Conditional Access policies for external B2B collaboration and B2B direct connect users in the same way that they're enabled for full-time employees and members of the organization. For Microsoft Entra cross-tenant scenarios, if your Conditional Access policies require MFA or device compliance, you can now trust MFA and device compliance claims from an external user's home organization. When trust settings are enabled, during authentication, Microsoft Entra ID checks a user's credentials for an MFA claim or a device ID to determine if the policies were already met. If so, the external user is granted seamless sign-on to your shared resource. Otherwise, an MFA or device challenge is initiated in the user's home tenant. Learn more about the [authentication flow and Conditional Access for external users in workforce tenants](authentication-conditional-access.md).

### Multitenant applications

If you offer a Software as a Service (SaaS) application to many organizations, you can configure your application to accept sign-ins from any Microsoft Entra tenant. This configuration is called making your application multitenant. Users in any Microsoft Entra tenant will be able to sign in to your application after consenting to use their account with your application. See how to [enable multitenant sign-ins](~/identity-platform/howto-convert-app-to-be-multi-tenant.md).

### Multitenant organizations

A multitenant organization is an organization that has more than one instance of Microsoft Entra ID. There are various reasons for [multi-tenancy](../identity/multi-tenant-organizations/overview.md). For example, your organization might span multiple clouds or geographical boundaries.

The [multitenant organization](../identity/multi-tenant-organizations/multi-tenant-organization-overview.md) capability enables seamless collaboration across Microsoft 365. It improves employee collaboration experiences across your organization of multiple tenants in applications such as Microsoft Teams and Microsoft Viva Engage.

The [cross-tenant synchronization](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md) capability is a one-way synchronization service that ensures users can access resources, without receiving an invitation email and having to accept a consent prompt in each tenant.

To learn more about multitenant organizations and cross-tenant synchronization, see the [multitenant organizations documentation](../identity/multi-tenant-organizations/index.yml) and the [feature comparison](../identity/multi-tenant-organizations/overview.md#compare-multitenant-capabilities).

## Microsoft Graph APIs

All External ID features are also supported for automation through Microsoft Graph APIs except those listed in the next section. For more information, see [Manage Microsoft Entra identity and network access by using Microsoft Graph](/graph/api/resources/identity-network-access-overview).

### Capabilities not supported in Microsoft Graph

|  External ID feature |  Supported in  |  Automation workarounds  |
| ---- | --- | --- |
| [Identify organizations that you belong to](leave-the-organization.md#what-organizations-do-i-belong-to) | Workforce tenants | [Tenants - List Azure Resource Manager API](/rest/api/resources/tenants/list). For Teams shared channels and B2B direct connect, use [Get tenantReferences](/graph/api/outboundshareduserprofile-list-tenants) Microsoft Graph API. |

<a name='azure-ad-microsoft-graph-api-for-b2b-collaboration'></a>

### Microsoft Entra Microsoft Graph API for B2B collaboration

- **Cross-tenant access settings APIs**: The [cross-tenant access APIs in Microsoft Graph](/graph/api/resources/crosstenantaccesspolicy-overview?view=graph-rest-beta&preserve-view=true) let you programmatically create the same B2B collaboration and B2B direct connect policies that are configurable in the Azure portal. Using these APIs, you can set up policies for inbound and outbound collaboration. For example, you can allow or block features for everyone by default and limit access to specific organizations, groups, users, and applications. The APIs also allow you to accept multifactor authentication (MFA) and device claims (compliant claims and Microsoft Entra hybrid joined claims) from other Microsoft Entra organizations.

- **B2B collaboration invitation manager**: The [invitation manager API in Microsoft Graph](/graph/api/resources/invitation) is available for building your own onboarding experiences for business guests. You can use the [create invitation API](/graph/api/invitation-post) to automatically send a customized invitation email directly to the B2B user, for example. Or your app can use the inviteRedeemUrl returned in the creation response to craft your own invitation (through your communication mechanism of choice) to the invited user.

## Next steps

- [What is Microsoft Entra B2B collaboration?](what-is-b2b.md)
- [What is Microsoft Entra B2B direct connect?](b2b-direct-connect-overview.md)
- [About Azure AD B2C](/azure/active-directory-b2c/overview)
- [About Microsoft Entra multitenant organizations](../identity/multi-tenant-organizations/overview.md)

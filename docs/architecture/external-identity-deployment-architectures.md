---
title: Microsoft Entra ID and external identity deployment architectures
description: Learn to securely deploy and operate Microsoft Entra ID and External Identity deployment architectures with Microsoft Entra. 
author: gargi-sinha
manager: martinco
ms.author: gasinh
ms.service: entra
ms.subservice: architecture
ms.topic: concept-article
ms.date: 10/24/2024

#CustomerIntent: As a Microsoft Entra ID administrator, I want securely deploy and operate Microsoft Entra ID and external identity deployment architectures with Microsoft Entra to enable use cases for workforces, partners, and consumers.
---
# Microsoft Entra ID external identity deployment architectures with Microsoft Entra

Enterprises can use Microsoft Entra to enable multiple use cases for workforces, partners, and consumers, potentially in combination. In this article, we recommend best practices based on patterns to securely deploy and use Microsoft Entra ID and the following external identity deployment architectures with Microsoft Entra. We include information about each architecture and links to resources.

- Workforce- and collaboration-oriented architecture
- Workforce-oriented architecture
- Consumer-oriented architecture
- Architecture combinations

This article addresses the following considerations for each architecture.

- **Account lifecycle.** Ability to define business rules to onboard and offboard user accounts in the environment.
- **External identity providers.** Ability to handle external users from organizations with their own identity provider (for example, another Microsoft Entra tenant, SAML federation provider), or social identity providers. The capability to create accounts in your tenant for users who don't have any identity provider.
- **Credential management.** Options to manage credentials for users, such as passwords for users who don't have identity providers, or additional factors of authentication.
- **Ad-hoc collaboration.** Controls to allow or deny with users in the environment (either workforce users or other external users) with external users on documents, reports, and similar user-created content.
- **Role-based resource assignment.** Ability to grant external users access to resources such as application assignments, memberships, or SharePoint site memberships based on predefined sets of role-encapsulated permissions.
- **Risk management.** Assess and manage security, operational, and compliance risks when you enable access to external users.

We define the following personae based on their relationship with your organization.

- **Workforce.** Your full-time employees, part-time employees, or contractors for your organization.
- **Business partners.** Organizations that have a business relationship with your enterprise. These organizations can include suppliers, vendors, consultants, and strategic alliances who collaborate with your enterprise to achieve mutual goals.
- **Consumers.** Individuals such as customers with whom you have a business relationship and who access your applications to purchase or consume your products and services.
- **External user.** Users that are external to your organization such as business partners and consumers.

## Workforce- and collaboration-oriented architecture

Workforce- and collaboration-oriented architecture enables your workforce to collaborate with business partners from external organizations. It includes controls to protect against unauthorized access to applications.

Typical scenarios include when employees invite collaboration ad-hoc to share content in productivity tools such as SharePoint, Power BI, Microsoft Teams, or your line of business applications. Guest users can come from external organizations that have their own identity provider. For example, another Microsoft Entra ID tenant or a Security Assertion Markup Language (SAML) federated identity provider.

:::image type="content" source="media/external-identity-deployment-architectures/workforce-collaboration-architecture.png" alt-text="Diagram illustrates example of workforce- and collaboration-oriented architecture.":::

In workforce- and collaboration-oriented architecture, the Microsoft Entra ID workforce configuration tenant uses [Microsoft Entra Identity Governance](../id-governance/identity-governance-overview.md) and [Microsoft Entra External ID](../external-id/external-identities-overview.md) to define policies to grant access to enterprise applications and resources. These policies include account and access lifecycle and security controls.

### Workforce- and collaboration-oriented architecture implementation resources

- [Plan a Microsoft Entra B2B collaboration deployment](secure-external-access-resources.md) describes governance practices to reduce security risks, meet compliance goals, and ensure right access.
- [Govern the employee lifecycle with Microsoft Entra ID Governance](../id-governance/scenarios/govern-the-employee-lifecycle.md) explains how Identity Governance can help organizations balance productivity and security.
- [Govern access for external users in entitlement management](../id-governance/entitlement-management-external-users.md#enable-catalog-for-external-users) describes settings to govern external user access.

### Workforce- and collaboration-oriented architecture considerations

#### Account lifecycle

Users can invite business partners to the tenant in ad-hoc collaboration scenarios. Define custom processes to track and offboard invited external users. [Manage guest access with access reviews](../id-governance/manage-guest-access-with-access-reviews.md) describes how to ensure that guest users have right access.

Onboard business partners with Entitlement Management access packages that have built-in controls such as approval workflows and a tracking and offboarding lifecycle after they lose access to access packages. Administrators can enable self-service sign-in and sign-up flows for specific applications. Define custom processes to track and offboard invited external users with features such as access reviews.

#### External identity providers

Workforce- and collaboration-oriented architecture supports business partners from organizations that have Microsoft Entra or an SAML / WS-Federation identity provider.

Business partners that have organizational email addresses but don't have identity providers can access your tenant with an email one-time passcode.

If necessary, you can configure your tenant to onboard business partners with Microsoft accounts, Google, or Facebook social identity providers.

Administrators have granular controls over identity providers.

#### Credential management

If you require business partner users to perform MFA, you can choose to trust the MFA authentication method claim from the specific business partner organization. Otherwise, enforce these user accounts to register for additional authentication methods for MFA in Microsoft Entra ID.

Microsoft recommends enforcing multifactor authentication for external users. [Authentication and Conditional Access for B2B users](../external-id/authentication-conditional-access.md) describes how to create conditional access policies that target guests.

#### Ad-hoc collaboration

Optimize workforce- and collaboration-oriented architecture for workforce users to interact with business partners with Microsoft collaboration services like Microsoft 365, Microsoft Teams, and Power BI.

#### Role-based resource assignment

Grant access to business partners with Entitlement Management access packages that have built-in controls such as time-limited application role assignment and separation of duties for specific external organizations.

#### Risk management

Determine if business partners in your organizational tenant affect compliance scope with applicable regulations. Implement appropriate preventative and detective technical controls.

After they're onboarded, business partners might be able to access application and resources in environments that have broad sets of permissions. To mitigate unintended exposure, implement preventative and detective controls. Consistently apply proper permissions to all environment resources and applications.

You can help mitigate risk, depending on the risk analysis outcome, with the following methods:

- To prevent malicious or accidental attempts of enumeration and similar reconnaissance techniques, [restrict guest access](../identity/users/users-restrict-guest-permissions.md) to properties and memberships of their own directory objects.
- [Limit who can invite guests](/microsoft-365/solutions/limit-who-can-invite-guests) in the tenant. At a minimum, don't allow guests to invite other guests.
- Apply application-specific controls to restrict collaboration such [as Microsoft Purview Information Barriers](/purview/information-barriers).
- Implement an allowlist approach to scope allowed organizations for external collaboration with capabilities such as cross-tenant access settings and domain allow-listing. [Transition to governed collaboration with Microsoft Entra B2B collaboration](5-secure-access-b2b.md) describes how to secure external access to your resources.

#### Other

Capabilities that external identities use could add to your monthly charges depending on their activity. The [billing model for Microsoft Entra External ID](../external-id/external-identities-pricing.md) based on monthly active users might affect your decision to implement external identity features.

## Workforce-oriented architecture

You can extend workforce-oriented architecture when you need to isolate external users such as business partner access. This approach ensures that there's a clear boundary between internal and external resources in terms of access and visibility. You can selectively onboard employee accounts from your workforce tenant to coexist with external users if they need to manage or access external-facing applications.

In workforce-oriented architecture, you create an additional Microsoft Entra ID workforce-configured tenant as a [boundary](secure-multiple-tenants.md). It hosts applications and resources, isolated from your organizational tenant, available to external users to meet security, compliance, and similar requirements. You can configure structured access assignment based on predefined business roles. You can use cross-tenant synchronization to onboard the workforce users from the corporate tenant to the additional tenant.

The following diagram illustrates an example of workforce-oriented architecture. Contoso starts a new joint venture where external users and a reduced subset of Contoso users access joint venture applications.

:::image type="content" source="media/external-identity-deployment-architectures/workforce-architecture.png" alt-text="Diagram illustrates example of workforce-oriented architecture.":::

Supply chain management is an example of workforce-oriented architecture in which you grant access to external users from different vendors and a subset of selectively onboarded workforce users to supply chain application and resources.

In both examples, the additional tenant for partner access provides resource isolation, security policies, and management roles.

Configure [Microsoft Entra Identity Governance](../id-governance/identity-governance-overview.md) and [Microsoft Entra External ID](../external-id/external-identities-overview.md) in the additional tenant with stricter controls such as:

- restrict guest user profiles
- allowlist organizations and apps for collaboration
- define guest account lifecycle, time-limit resource assignment, schedule periodic access reviews
- apply stricter sets of attestations as part of external user onboarding

You can expand workforce-oriented architecture with collaboration tenants to create multiple isolation boundaries based on business requirements (for example, isolate per region, per partner, per compliance jurisdiction).

### Workforce-oriented architecture implementation resources

- [Plan a Microsoft Entra B2B collaboration deployment](secure-external-access-resources.md) describes governance practices to reduce security risks, meet compliance goals, and ensure right access.
- [What is a cross-tenant synchronization in Microsoft Entra ID](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md) describes how to automatically create, update, and delete [Microsoft Entra B2B collaboration](../external-id/what-is-b2b.md) users across tenants.
- [Govern the employee lifecycle with Microsoft Entra ID Governance](../id-governance/scenarios/govern-the-employee-lifecycle.md) explains how Identity Governance can help organizations balance productivity and security.
- [Govern access for external users in entitlement management](../id-governance/entitlement-management-external-users.md#enable-catalog-for-external-users) describes settings to govern external user access.

### Workforce-oriented architecture considerations

#### Account lifecycle

Scope workforce user onboarding to other tenants with cross-tenant synchronization. Synchronize them to have a [member user type](../external-id/user-properties.md#user-type) with [attribute mappings](../identity/multi-tenant-organizations/cross-tenant-synchronization-configure.md#step-9-review-attribute-mappings) consistent with their user type in the corporate tenant.

Onboard business partners with Entitlement Management access packages that have built-in controls such as approval workflows and a tracking and offboarding lifecycle after they lose access to resources per access package policies.

Although workforce-oriented architecture isn't optimized for workforce user ad-hoc collaboration in the additional tenant, members can invite business partners. Administrators can enable self-service sign-in and sign-up flows for specific applications. Define custom processes to track and offboard invited external users with features such as access reviews or calls to Microsoft Graph.

#### External identity providers

Workforce-oriented architecture supports business partners from organizations that have Microsoft Entra or an SAML/WS-Federation identity provider.

Business partners who have organizational email addresses but don't have identity providers can access your tenant with an email one-time passcode.

Business partners can onboard with Microsoft Accounts, Google, or Facebook social identity providers.

#### Credential management

If you require users to perform MFA, you can choose to trust business partners. For users that you don't configure as trusted accounts or don't have an identity provider, they can register other authentication methods for multifactor authentication (MFA).

Administrators can choose to trust MFA authentication methods and device states for workforce users coming from the corporate tenant.

Administrators can choose to trust business partner MFA authentication methods from specific organizations.

Create conditional access policies that target guests to enforce multifactor authentication for external users. [Authentication and Conditional Access for B2B users](../external-id/authentication-conditional-access.md) describes the authentication flow for external users who access resources in your organization.

#### Ad-hoc collaboration

Ad-hoc collaboration that workforce users initiate is possible in workforce-oriented architecture. However, it isn't optimized due to user experience friction when switching tenants. Instead, use role-based resource assignment to grant access to user-created content repositories (such as SharePoint sites) based on business roles.

#### Role-based resource assignment

Grant access to business partners with Entitlement Management access packages that have built-in controls. Example controls include time-limited resource role assignment and separation of duties for specific external organizations.

#### Risk management

Workforce-oriented architecture mitigates the risk of business partners gaining unauthorized access (intentionally or maliciously) to resources in the corporate tenant because of the separate security boundary provided by additional tenants. Have a separate tenant to help contain applicable regulation scope in the corporate tenant.

Implement an allowlist approach to scope allowed organizations for external collaboration with capabilities such as cross-tenant access settings and domain allow-listing. [Transition to governed collaboration with Microsoft Entra B2B collaboration](5-secure-access-b2b.md) describes how to secure external access to your resources.

To prevent malicious or accidental attempts of enumeration and similar reconnaissance techniques, [restrict guest access](../identity/users/users-restrict-guest-permissions.md) to properties and memberships of their own directory objects.

After they're onboarded, business partners might be able to access application and resources in the environment that have broad set of permissions. To mitigate unintended exposure, implement preventative and detective controls. Consistently apply proper permissions to all environment resources and applications.

#### Other

Additional tenants in your environment increase operational overhead and overall complexity. Strive to create as few tenants as possible to meet your business needs. [Plan for multitenant organizations in Microsoft 365](/microsoft-365/enterprise/plan-multi-tenant-org-overview#license-requirements) if you have users represented as guests in additional tenants which are separate from the organizational tenant. [Limitations in multitenant organizations](../identity/multi-tenant-organizations/multi-tenant-organization-known-issues.md) describes limitations to be aware of when you work with multitenant organization functionality across Microsoft Entra ID and Microsoft 365.

Capabilities that external identities use could add to your monthly charges depending on their activity. The [billing model for Microsoft Entra External ID](../external-id/external-identities-pricing.md) provides details.

## Consumer-oriented architecture

Consumer-oriented architecture is best suited to serve applications to individual consumers where you might need the following components:
- Highly customized branding on authentication pages including API-based authentication for native apps and custom Domain Name System (DNS) domains.
- User bases that are vast in size (potentially more than a million users).
- Support for self-service sign-up with local email and password or federation with social identity providers such as Microsoft Account, Facebook, and Google.

In consumer-oriented architecture, an external configured tenant provides identity services to applications and resources that the applications' consumers use.

The following diagram illustrates a consumer-oriented architecture example.

:::image type="content" source="media/external-identity-deployment-architectures/consumer-architecture.png" alt-text="Diagram illustrates example of consumer-oriented architecture.":::

### Consumer-oriented architecture implementation resources
- [Secure your apps using External ID in an external tenant](../external-id/customers/overview-customers-ciam.md) describes how Microsoft's customer identity and access management (CIAM) solution helps to make apps available to consumers and business customers. Platform feature benefits include enhanced security, compliance, and scalability.
- In this [Guided project -- Build a sample app to evaluate Microsoft Entra External ID for seamless and secure sign-up and sign-in for consumers](/training/entra-external-identities/), discover how Microsoft Entra External ID can provide secure, seamless sign-in experiences for your consumers and business customers. Explore tenant creation, app registration, flow customization, and account security.

### Consumer-oriented architecture considerations

#### Account lifecycle

Support deep customization of consumer sign-up and sign-in experiences such as [custom URL domains](../external-id/customers/concept-custom-url-domain.md), [native authentication](../external-id/customers/concept-native-authentication.md) for mobile apps, and [custom logic for attribute collection](../identity-platform/custom-extension-attribute-collection.md).

Use invitations to onboard consumer accounts.

Offboarding experiences need custom application development.

#### External identity providers

Consumers self-service sign-up a local account with local email and password.

Consumers who have a valid email address can use email one-time passcode.

Consumers authenticate with Google and Facebook logins.

#### Credential management

Consumers with local accounts can use passwords.

All consumer accounts can register additional authentication methods for multifactor authentication.

#### Ad-hoc collaboration

Consumer-oriented architecture isn't optimized for ad-hoc collaboration. It doesn't support Microsoft 365.

Applications need customized logic to offer collaboration capabilities such as user finding/picking and content-centric workflows to share/manage access.

#### Role-based resource assignment

Applications can support app roles or groups. [Using role-based access control for apps](../external-id/customers/how-to-use-app-roles-customers.md) describes how Microsoft Entra External ID allows you to define application roles for your application and assign those roles to users and groups.

Use custom logic or workflows to assign users to roles or groups.

#### Risk management

Users can only view and manage their own user profiles.

Applications need to develop custom logic to allow users to interact with each other.

#### Other

For Azure Resources that support your application infrastructure, such as Azure Web Apps, host in an Azure Subscription that you link to a workforce tenant.

## Architecture combinations

Your organization's aggregated set of requirements might not fit only one architecture. You might need to use multiple architectures or deploy multiple instances of the architectures described in this article.

For example, a large consulting company might deploy the following architectures:

- **Workforce and collaboration-oriented architecture** for workforce and external collaborators such as marketing agencies, and consultants.
- **Workforce-oriented architecture** for projects such as joint ventures that require need-to-know access and isolation where each joint venture needs to have a separate boundary.

In another example, a large retailer might deploy the following architectures:

- **Workforce and collaboration-oriented architecture** for workforce and external collaborators such as marketing agencies and consultants.
- **Consumer-oriented architecture** to enable loyalty programs, ecommerce, and similar consumer-focused capabilities. Retailers that have multiple brands or work in various regions might need separate architecture instances.

## Next steps

For additional guidance, review the [Microsoft Entra deployment plans](deployment-plans.md).

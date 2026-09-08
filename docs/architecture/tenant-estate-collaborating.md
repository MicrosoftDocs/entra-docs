---
title: Microsoft Entra collaborating production tenants guidance
description: Learn about Microsoft Entra tenant architecture for collaborating production tenants so that you can identify your needs and compare architectural options. 
author: bathawes
ms.author: beathawe
ms.reviewer: ramical
ms.subservice: architecture
ms.topic: concept-article
ms.date: 06/22/2026
ai-usage: ai-assisted

#CustomerIntent: As an IT admin, I want to learn about Microsoft Entra tenant architecture for collaborating production tenants so that I can identify my needs and compare architectural options.
---
# Microsoft Entra tenant estate guidance for collaborating production tenants

Designing your Microsoft Entra **tenant estate** — the set of tenants your organization operates — means balancing security, compliance, administrative complexity, and user experience. While a single production tenant is ideal for simplicity and user experience, your specific business and technical requirements might necessitate multiple production tenants.

This article series describes the following common tenant architecture patterns that Microsoft has observed across real-world deployments.

- [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md)
- [Primary production tenant](tenant-estate-primary.md)
- [Nonproduction environments](tenant-estate-nonproduction.md)
- [Isolated tenants for critical production systems](tenant-estate-critical-production.md)
- [Isolated tenants for business partner access](tenant-estate-business-partner.md)
- [Hybrid identity and isolation](tenant-estate-hybrid-identity.md)

Collaborating production tenants are two or more production tenants that an organization operates but needs to work together as a unified enterprise. This pattern commonly arises from corporate structure — mergers and acquisitions, subsidiaries, regulated business units, or regional operations — where consolidating into a single tenant isn't practical.

Operating more than one Microsoft Entra tenant is common; Microsoft refers to this broadly as the [multitenant organization scenario](../identity/multi-tenant-organizations/overview.md). Organizations typically operate additional tenants to isolate — separating workloads, environments, or external access. For example, a separate tenant might be required when external users must access environments that stay isolated from internal resources. Other articles in this series cover these isolation-driven patterns (nonproduction, critical-production, and business-partner tenants); this article covers the case where separate production tenants must still collaborate as a unified enterprise.

This pattern builds on the [Primary production tenant](tenant-estate-primary.md) baseline, which covers the seven architecture evaluation areas in detail. This article describes only the incremental considerations for collaborating production tenants, in the context of those same evaluation areas. For the full series, see [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md).

## Example scenario

Contoso has multiple production tenants that need to work together as a unified enterprise due to corporate structure (merger, subsidiaries, regulated business units, regional units). They focus on more seamless collaboration and access across tenants for internal users. The [cross-tenant synchronization](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md) and [multitenant organization (MTO)](../identity/multi-tenant-organizations/multi-tenant-organization-overview.md) features in Microsoft Entra ID and Microsoft 365 can help enable this collaboration and access.

Microsoft Entra supports several [topologies for cross-tenant synchronization](../identity/multi-tenant-organizations/cross-tenant-synchronization-topology.md): a hub-and-spoke topology (one tenant serves as a central hub for either applications or users), a mesh topology (peer tenants that synchronize directly with each other), and just-in-time collaboration (connected organizations and entitlement management, for scenarios such as joint ventures). For example, following an acquisition, Contoso can provision the acquired company's users into Contoso's tenant as an application hub, giving them access to shared applications and resources from day one while their accounts stay managed in their original tenant.

No single topology is universally best, and these aren't a ranked list of recommendations — choose based on where your identities and applications live and how your tenants relate. Hub-and-spoke suits a central tenant that owns shared identities (user hub) or shared applications (app hub); a mesh suits peer tenants that synchronize directly without a central hub. A full mesh synchronizes every tenant with every other tenant, so the number of relationships and operational overhead grow quickly, making it practical only for a [limited number of tenants](../identity/users/directory-service-limits-restrictions.md). Many organizations combine these patterns. For the full set of topologies, with worked scenarios and diagrams, see [Topologies for cross-tenant synchronization](../identity/multi-tenant-organizations/cross-tenant-synchronization-topology.md).

The following diagram shows the acquisition example — a hub-and-spoke topology with an application hub, where users from recently acquired tenants are provisioned into Contoso's tenant so they can access shared applications and resources.

:::image type="content" source="media/multi-tenant-architecture-guide/hub-and-spoke-app-hub-multitenant-architecture.png" alt-text="Example scenario diagram shows hub-and-spoke multitenant architecture for application hub.":::
 
## Administration

In a multitenant topology, a user has a home tenant and one or more resource tenants. The home tenant administrators manage the user account lifecycle, credentials, authentication methods, and device requirements. The resource tenant administrators manage access to applications and resources. Administrators within the MTO enable identity synchronization to improve communications and collaboration.

Each tenant is a separate boundary with an independent set of administrators who coordinate and align on common security requirements. They implement and manage these common requirements separately on each tenant. Controls to detect and correct configuration drift become a core requirement for multitenant architecture.

[Secure tenant creation](../id-governance/tenant-governance/how-to-create-tenant.md) in Microsoft Entra Tenant Governance allows you to control which users can create tenants, automatically establish governance relationships with new tenants, and recover administrative access when necessary. [Related tenants](../id-governance/tenant-governance/related-tenants.md) help you discover tenants across your organization through signals such as B2B access, multitenant application permissions, and shared billing accounts.

Evaluate [multitenant administration patterns](tenant-estate-guide.md#multitenant-administration-patterns) to determine how administrators gain and exercise administrative access across the tenants. Cross-tenant delegated administration through governance relationships can simplify coordinated administrative access across multiple tenants within the organization. Some organizations centralize privileged identities and administrative workstations in a dedicated, isolated administration tenant, while others manage administrative access from within the tenants that host their users and workloads. Both approaches can be valid depending on your isolation, regulatory, and operational requirements.

Administrators design new IT processes to migrate users between tenants as part of the employee lifecycle. For example, if a user in the United States relocates to Europe, their user account migrates from the United States tenant to the Europe tenant.

License management becomes more complex as they split and distribute between tenants. Some services might need duplicate licensing. For example, non-Microsoft tools that integrate with Microsoft 365 might require a separate instance per tenant.

## Change control

Carefully plan, validate, and roll out configuration changes that affect multiple tenants within the multitenant organization. In every tenant, implement and track any changes such as new security policies, data loss prevention (DLP) rules, or configurations. Reduce the risk of inconsistency and policy drift due to changes applied at various times or in slightly different ways. Tenants can pilot or enable features in one tenant independent of the other. For example, United States could be an early adopter of a preview feature while other regions can choose to wait.

## Account lifecycle

Integrated multitenant organizations automate user provisioning across tenants. The cornerstone is [cross-tenant synchronization](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md), a capability in Microsoft Entra ID that allows you to configure synchronization rules between tenants. You can take workforce users that you provision in one of the tenants and maintain copies of those users in other tenants as B2B collaboration users on a continuous basis. When user attributes change in source tenants, target tenants update to keep attribute data in sync. Similarly, you can automatically remove B2B accounts when a user leaves and deprovisions from their home organization. You can bypass B2B invitation redemption for multitenant organization users with automatic redemption in [cross-tenant access settings](../external-id/cross-tenant-access-overview.md). This approach streamlines user access and requires no emails or user action join each tenant.

The net result of cross-tenant synchronization is user representation across the tenants within the multitenant organization and allows them to access resources in those tenants. Similarly, users can discover each other to collaborate, even when they belong to different tenants.

Multitenant organizations can [configure lifecycle workflows](../identity/multi-tenant-organizations/cross-tenant-synchronization-governance.md#manage-employee-lifecycles-across-tenants) to automate other tasks such as grant access to resources or add them to groups.

## Credential management

Users have a single set of credentials in their home tenant to access resources in other tenants and collaborate with users from other tenants. You can configure [cross-tenant access settings](../external-id/cross-tenant-access-settings-b2b-collaboration.yml) to accept the MFA and device state from the user's home tenant. With this approach, an employee meets MFA or device state requirements once in their primary tenant. That state can satisfy Conditional Access MFA and device compliance requirements in other tenants of the multitenant organization.

Administrators of tenants within the multitenant organization agree on policies so that home-tenant accounts meet common organization-wide authentication strength and device posture requirements. This agreement ensures that other tenants can trust multifactor authentication, compliant device, and Microsoft Entra hybrid joined device claims. When each tenant has its own Conditional Access policies, you can enforce more controls as needed. Certain Conditional Access functionality has limitation for B2B collaboration users, such as [Microsoft Entra ID Protection for B2B Users](../id-protection/concept-identity-protection-b2b.md).

B2B user account type is another important consideration. By default, cross-tenant sync creates accounts for members in the source tenant with the *external member* `UserType` in target tenants. The *external member* `UserType` enables differentiation of B2B users that originate from within a multitenant organization, compared to guest users that come from an external tenant. For example, B2B users elevated to the *member* `UserType` are available in [multitenant people search](../identity/multi-tenant-organizations/overview.md) in most Microsoft 365 applications and benefit from [Teams multitenant experiences](/microsoft-365/enterprise/plan-multi-tenant-org-overview). External members have extra directory permissions and member-level rights to certain Microsoft 365 resources and permission scopes (such as *People in Fabrikam*) in SharePoint Online. Evaluate these collaborative benefits and security considerations alongside [multitenant organization functionality limitations](../identity/multi-tenant-organizations/multi-tenant-organization-known-issues.md) across Microsoft Entra ID and Microsoft 365 specific to the *external member* `UserType`.

B2B collaboration users, both guest and member, aren't equivalent to users that [authenticate internally](../external-id/user-properties.md). Evaluate the [B2B limitations across Microsoft Services](tenant-estate-guide.md#b2b-limitations-across-microsoft-services) based on your cross-tenant resource access use cases.

## Collaboration

Although not as seamless as a single-tenant architecture, multitenant organization architecture facilitates cross-tenant collaboration experiences to workforce users for certain Microsoft 365 workloads. 

Unified [cross-tenant people search](/microsoft-365/enterprise/multi-tenant-people-search) allows for a global address book. Users can start a call, chat, or schedule a meeting with users across the multitenant organization without switching tenants or using external email addresses. You can configure settings so that users see rich presence and profile information for colleagues in other tenants. In Outlook and Teams, the experience approaches that of a single tenant environment, although users might notice some context switching (such as accessing a team or channel in another tenant) or related limitations (such as free/busy calendar lookup).

Multitenant organizations introduce branding limitations. For example, you can't share an email domain across tenants. To have consistent branding, you can create subdomains such as us.contoso.com and emea.contoso.com. 

[B2B limitations](tenant-estate-guide.md#b2b-limitations-across-microsoft-services) in Microsoft Entra and other Microsoft Services such as Stream and Planner affect users who access resources in other tenants within the multitenant organization.

## Role-based resource assignment

In a multitenant organization, role assignment management can be complex because an employee might appear in multiple directories and assignments require separate configuration on each tenant. Use [entitlement management](../identity/multi-tenant-organizations/cross-tenant-synchronization-governance.md#govern-synchronized-user-access-with-access-packages) to assign access to resources across tenants.

## Risk management

### Blast radius

Review the blast radius mitigations in [Risk management for a primary production tenant](tenant-estate-primary.md#risk-management). Any B2B collaboration relationship — whether you invite users individually or provision them at scale through cross-tenant synchronization — creates a path for lateral movement, so a compromised account in one tenant can become a foothold in others. Broad, automated provisioning widens this exposure.

- Follow the Zero Trust principle of least privilege.
- Periodically [review access](../identity/multi-tenant-organizations/cross-tenant-synchronization-governance.md#review-synchronized-user-access). 
- Use [entitlement management](../identity/multi-tenant-organizations/cross-tenant-synchronization-governance.md#govern-synchronized-user-access-with-access-packages) access lifecycle controls to remove access to applications, data, and resources when you no longer need users from other tenants within the multitenant organization.

### Regulatory requirements

Review the data residency features in [Microsoft 365 Multi-Geo](/microsoft-365/enterprise/microsoft-365-multi-geo). In addition, separate tenants can provide more flexibility on [data residency of Microsoft Entra directory data](../fundamentals/data-residency.md) when you choose geographic location at tenant creation time. Some regulations might bring a tenant into audit scope based on user presence in a tenant. 

If you need to strictly isolate something for regulatory reasons, you can limit cross-tenant user flow. For example, a highly regulated subsidiary might deliberately not join the multitenant organization. Instead, it can use one-way invites so that compliance audits see it separately. You can configure the integrated model. You can go full mesh (all tenants recognize each other's users freely) or more controlled (only synchronize a subset of users). Each sync relationship can filter which users sync (such as only certain departments synchronize, not everyone synchronize).

### Security operations

To help you investigate incidents and hunt across multiple tenants, [Microsoft Defender multitenant management](/unified-secops/mto-overview) provides a unified view across all tenants.

## Other considerations

MTO users can [access on-premises apps](../external-id/hybrid-cloud-to-on-premises.md) that use SAML-based authentication or integrated Windows authentication (IWA) with Kerberos-constrained delegation (KCD). The latter category of applications requires a user object in Active Directory.

## Related content

- [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md)
- [Microsoft Entra tenant estate guidance: Primary production tenant](tenant-estate-primary.md)
- [Microsoft Entra tenant estate guidance: Nonproduction environments](tenant-estate-nonproduction.md)
- [Microsoft Entra tenant estate guidance: Isolated tenants for critical production systems](tenant-estate-critical-production.md)
- [Microsoft Entra tenant estate guidance: Isolated tenants for business partner access](tenant-estate-business-partner.md)
- [Microsoft Entra tenant estate guidance: Hybrid identity and isolation](tenant-estate-hybrid-identity.md)

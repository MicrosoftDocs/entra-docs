---
title: Microsoft Entra tenants for business partner access guidance
description: Learn about Microsoft Entra tenant architecture for business partner access so that you can identify your needs and compare architectural options.
author: bathawes
ms.author: beathawe
ms.reviewer: ramical
ms.subservice: architecture
ms.topic: concept-article
ms.date: 06/22/2026
ai-usage: ai-assisted

#CustomerIntent: As an IT admin, I want to learn about Microsoft Entra tenant architecture for business partner access so that I can identify my needs and compare architectural options.
---
# Microsoft Entra tenant estate guidance for business partner access

Designing your Microsoft Entra **tenant estate** — the set of tenants your organization operates — means balancing security, compliance, administrative complexity, and user experience. While a single production tenant is ideal for simplicity and user experience, your specific business and technical requirements might necessitate multiple production tenants.

This article series describes the following common tenant architecture patterns that Microsoft has observed across real-world deployments.

- [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md)
- [Primary production tenant](tenant-estate-primary.md)
- [Collaborating production tenants](tenant-estate-collaborating.md)
- [Nonproduction environments](tenant-estate-nonproduction.md)
- [Isolated tenants for critical production systems](tenant-estate-critical-production.md)
- [Hybrid identity and isolation](tenant-estate-hybrid-identity.md)

This article describes separate tenants for business partner access. Separate tenants, sometimes called extranet tenants or partner tenants, act as isolated collaboration spaces with clearly defined boundaries between internal and external access.

This pattern builds on the [Primary production tenant](tenant-estate-primary.md) baseline, which covers the seven architecture evaluation areas in detail. This article describes only the incremental considerations for business partner access, in the context of those same evaluation areas. For the full series, see [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md).


## Example scenario

Contoso creates a separate tenant that it dedicates to external users while they keep the internal workforce primarily in the main tenant. For example, Contoso might set up a tenant specifically for a joint venture project or for all supplier interactions. They invite both Contoso users and partner users to collaborate within that separate boundary.

The following example scenario diagram shows Contoso's separate tenant architecture for business partner access.

:::image type="content" source="media/multi-tenant-architecture-guide/separate-tenant-business-partner-architecture.png" alt-text="Example scenario diagram shows separate tenant architecture for business partner access.":::
 
## Administration

Separate tenant architecture for business partner access allows a separate set of administrators from the main workforce tenant. This solution can potentially align with collaboration use cases (such as joint ventures or supply chain). It provides flexibility to configure tenant-wide settings that can accommodate resources and trust applications that have requirements for configurations that differ from main workforce tenants. Separate tenant architecture for business partner access allows you to isolate instances of Microsoft services (for example, Exchange, SharePoint Online, Teams, Intune) from the main workforce tenant.

## Change control

Separate tenant architecture for business partner access decouples collaboration workloads from changes in the main workforce tenant. Admins in dedicated tenants can independently plan changes. Apply the same considerations on change control within a tenant as described in previous **Change control** sections.

## Account lifecycle
In the partner tenant, account management includes employees that need access and external partner users. For employees, you can use cross-tenant sync to automate onboarding into the partner tenant. This approach is like integrated multitenant architecture but targets a subset of users that need to collaborate with external users. In the example scenario, Contoso could synchronize only the sales team into a partner collaboration tenant to appear as members without manual invites. These synced Contoso users could be external (B2B) members in the partner tenant. 

External user onboarding methods include the following options.

- If partners have their own Microsoft Entra ID, you can use [entitlement management access packages](../id-governance/entitlement-management-external-users.md) to onboard partner users into the dedicated tenant with appropriate access. Entitlement management is desirable for large or ongoing partner onboarding because it provides workflow approval, expiration, and tracking.
- If partners don't have their own Microsoft Entra ID or are individuals (such as consultants), they can use [self-service sign-up](../external-id/self-service-sign-up-overview.md). They can receive email invitation with one-time passcodes or social identities (if enabled). In all cases, define partner tenant account lifecycles. For example, access might expire after the project, require access review enforcement, or have time-limited access packages. Ensure that the partner tenant admins periodically audit user lists and removes or disables accounts when no longer needed (especially external accounts). Configure Microsoft Entra ID Governance features such as access reviews to include guest users for periodic access re-certification.
- Separate tenant architecture for business partner access doesn't optimize for large-scale ad-hoc self-service invites by every employee. Typically, only certain internal users or admins can invite partners into the partner tenant in exceptional cases. The account lifecycle is more structured. You can bulk-provisioned internal users or invite them by procedure. You can onboard external users through a governed process.

## Credential management

In the example scenario, the separate tenant architecture for business partner access example scenario takes into consideration that Contoso employees have a home tenant. In the partner tenant, Contoso employees sign in to B2B with their Contoso credentials. 

Typically, you configure the partner tenant's cross-tenant access settings to trust the organization's MFA and device state for those user accounts. That way, internal users don't get more authentication prompts when they access the extranet tenant and their corporate sign-in satisfies the required controls. For the partner users, if they come from their own Microsoft Entra tenants (such as a supplier with their own Microsoft Entra tenant), you can require them to register MFA in your tenant. Then use Conditional Access to enforce it for all guest users on the partner tenant. 

The partner access tenant can accept several identity provider types for external users (such as other Microsoft Entra IDs, SAML/WS-Federation, Microsoft Accounts). You can allow Google or Facebook, although many enterprises restrict to business identity providers. If a partner user has no existing identity, you can allow [one-time passcode (OTP) authentication](../external-id/one-time-passcode.md). They receive an email with a passcode at each sign-in. In that case, the partner tenant creates a user account for them behind the scenes (as an email one-time passcode user) that has no password. It uses an email address as the username and emailed OTP as the credential. This approach is simpler for external users because they have no accounts to manage. You can require MFA or ensure that their email is secure.

## Collaboration

External collaboration in separate tenant architecture for business partner access doesn't optimize to provide a frictionless experience to internal users. Workforce users can collaborate, but they must consciously operate in the partner access tenant for that work. This approach requires separate Teams channels and SharePoint sites dedicated to external collaboration. 

Truly ad-hoc sharing and invitations are undesirable. Instead, you can encourage a structured approach. For example, communicate to users that, if they need to share a file with a supplier, use a Supplier SharePoint Site (extranet SharePoint site) rather than internal OneDrive. That way, partner collaboration happens in the segregated tenant. Collaboration is deliberate in this model. Internal users invite partners into the partner tenant and collaborate there rather than on an ad-hoc basis in the main tenant. This controlled approach can use Teams (with shared channels or separate teams) and SharePoint sites under the partner tenant's governance.

In the example scenario, Contoso employees and external users that access the partner tenant might encounter [B2B limitations](tenant-estate-guide.md#b2b-limitations-across-microsoft-services) in Microsoft Entra and other Microsoft Services such as Stream and Planner.

## Role-based resource assignment

The extranet tenant contains resources (such as applications, SharePoint sites, Teams) that your employees and partner users need to access. Use roles and groups to manage access and maintain order and consistency. Use [entitlement management access packages](../id-governance/entitlement-management-external-users.md) in the partner access tenant.

In the example scenario, Contoso's partner access tenant can have an approved access package named *Supplier Portal Access*. This access package can automatically grant internal or external user access with the necessary roles in SharePoint and Teams for the supplier portal. 

Access packages can add users to security groups to grant access to applications. The package can enforce time limits and approvals. Internally, you can create a rule that requires partners to come through such a package.

## Risk management

### Blast radius

Separate tenant architecture for business partner access mitigates the risk of business partners gaining unauthorized access (intentionally or maliciously) to resources in the corporate tenant. This mitigation is possible because of the separate security boundary that the other tenant provides. It can be critical that users in main corporate tenants don't have visibility or accidental access to joint ventures or supply chain applications.

- Implement an allow list approach to scope allowed organizations for external collaboration with capabilities such as cross-tenant access settings and domain allow-listing. The [Transition to governed collaboration with Microsoft Entra B2B collaboration](5-secure-access-b2b.md) article describes how to secure external access to your resources.
- To prevent malicious or accidental attempts of enumeration and similar reconnaissance techniques, [restrict guest access](../identity/users/users-restrict-guest-permissions.md) to properties and memberships of their own directory objects.
- After business partners onboard, they have access to environment applications and resources that have broad sets of permissions. To mitigate unintended exposure to oversharing risks, implement preventative and detective controls. Consistently apply proper permissions to all environment resources and applications.

### Regulatory requirements

Separate tenant architecture for business partner access can help contain applicable regulation scope in the corporate tenant.

## Other considerations

Operational overhead is a factor when you maintain an extranet tenant. Consider overhead for separate Conditional Access, separate compliance configurations, and separate DLP policies for content. Consider user management overhead for external tenant account processes (request, approval, and periodic cleanup). Because these tenants are defined by cross-tenant B2B access, you can use [related tenants](../id-governance/tenant-governance/related-tenants.md) in Microsoft Entra Tenant Governance to discover and measure those B2B relationships and surface unsanctioned or "shadow IT" partner tenants.

Factor in [Microsoft Entra ID Governance licensing for guest users](../id-governance/microsoft-entra-id-governance-licensing-for-guest-users.md). The [Monthly Active User (MAU) billing model for external identities](../external-id/external-identities-pricing.md) covers basic collaboration with guests.

## Related content

- [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md)
- [Microsoft Entra tenant estate guidance: Primary production tenant](tenant-estate-primary.md)
- [Microsoft Entra tenant estate guidance: Collaborating production tenants](tenant-estate-collaborating.md)
- [Microsoft Entra tenant estate guidance: Nonproduction environments](tenant-estate-nonproduction.md)
- [Microsoft Entra tenant estate guidance: Isolated tenants for critical production systems](tenant-estate-critical-production.md)
- [Microsoft Entra tenant estate guidance: Hybrid identity and isolation](tenant-estate-hybrid-identity.md)

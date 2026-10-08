---
title: Microsoft Entra nonproduction environments multitenant guidance
description: Learn about Microsoft Entra tenant architecture for nonproduction environments so that you can identify your needs and compare architectural options.
author: bathawes
ms.author: beathawe
ms.reviewer: ramical
ms.subservice: architecture
ms.topic: concept-article
ms.date: 06/22/2026
ai-usage: ai-assisted

#CustomerIntent: As an IT admin, I want to learn about Microsoft Entra tenant architecture for nonproduction environments so that I can identify my needs and compare architectural options.
---
# Microsoft Entra tenant estate guidance for nonproduction environments

Designing your Microsoft Entra **tenant estate** — the set of tenants your organization operates — means balancing security, compliance, administrative complexity, and user experience. While a single production tenant is ideal for simplicity and user experience, your specific business and technical requirements might necessitate multiple production tenants.

This article series describes the following common tenant architecture patterns that Microsoft has observed across real-world deployments.

- [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md)
- [Primary production tenant](tenant-estate-primary.md)
- [Collaborating production tenants](tenant-estate-collaborating.md)
- [Isolated tenants for critical production systems](tenant-estate-critical-production.md)
- [Isolated tenants for business partner access](tenant-estate-business-partner.md)
- [Hybrid identity and isolation](tenant-estate-hybrid-identity.md)

This article describes nonproduction environments. Use cases for nonproduction tenants include the following.

- Plan, design, document, and test tenant-wide configuration changes as part of change control procedures for production environments for the following scenarios.

  -	You can't use security groups or similar pilot techniques to perform gradual rollout in the production tenant. 
  -	Gradual rollout carries excessive risk of disruption of operations should mistakes occur.

- Plan, document, and validate Business Continuity and Disaster Recovery (BCDR) exercises.
- Development environments for applications or tools that have broad tenant-wide permissions (for example, scripts that update directory objects at scale with `Directory.Read.All` permissions).

Nonproduction tenants can have a short lifecycle in use cases such as proof-of-concepts and hackathons. Preproduction tenants for change control might be persistent and closely mirror their corresponding production environments, including dependencies. For example, Microsoft Entra Connect for preproduction synchronizes identities from the preproduction Active Directory, which then provisions from the preproduction HR system.

This pattern builds on the [Primary production tenant](tenant-estate-primary.md) baseline, which covers the seven architecture evaluation areas in detail. A nonproduction tenant mainly supports that baseline — most notably as a change-control validation environment for your production tenant — so this article describes the considerations for operating one in the context of those same evaluation areas. For the full series, see [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md).


## Example scenario

Contoso has a secondary tenant, `ContosoSandbox.onmicrosoft.com` for change control, development, and testing. They isolate the secondary tenant from production tenants.

The following example scenario diagram shows Contoso's tenant architecture that includes both production and nonproduction environments.

:::image type="content" source="media/multi-tenant-architecture-guide/nonproduction-environment-architecture.png" alt-text="Example scenario diagram shows tenant architecture that includes both production and nonproduction environments.":::

## Administration

Ensure that administrators of preproduction tenants for change control maintain consistency with corresponding production environments with clear account ownership traceability. Whenever feasible, maintain consistent security controls for privileged accounts.

When you use nonproduction tenants for proof of concepts, experimentation, and similar stand-alone use cases, define centralized administrative processes. Consistently create and decommission tenants, assign administrators with traceability back to owners, and inventory tenants for communications. Ensure that security teams maintain privileged access to tenants for visibility, audit risk assessment, and monitor and execute mitigations as needed.

Evaluate [multitenant administration patterns](tenant-estate-guide.md#multitenant-administration-patterns) to determine how administrators access nonproduction tenants. Cross-tenant delegated administration through governance relationships can reduce account sprawl in volatile nonproduction tenants while maintaining administrative oversight from the production tenant.

Consider nonproduction tenants as volatile and unsuitable as dependencies for production environments. For example, don't use a multitenant application defined on a nonproduction tenant in a production tenant.

## Change control

Nonproduction tenant architecture helps administrators to address challenges described in [Change control for a Primary production tenant](#change-control). Organizations can plan, design and implement tenant-wide changes in nonproduction tenants first. Roll back for documentation and contingency purposes. Document and roll out to the production environment after meeting success criteria. You can use [configuration management](../id-governance/tenant-governance/configuration-management.md) in Microsoft Entra Tenant Governance to snapshot a known-good configuration, use it to author a baseline, and monitor for drift as you validate tenant-wide changes before production rollout.

Not all change control cases require a separate tenant. For example, Azure can provide robust dev-test-staging production [environments](/azure/cloud-adoption-framework/ready/considerations/environments) within a single tenant using separate management groups, resource groups, and subscriptions.

## Account lifecycle

In a sandbox tenant, provision accounts for users who need access (such as developers, testers, admins). Manage these accounts as either local to the sandbox (users access with separate credentials from main tenant) or Microsoft Entra B2B collaboration accounts (users access with main tenant credentials). Which method you choose depends on the use case. For example, some Microsoft cloud services might have differences in experience or [limitations on B2B user accounts](tenant-estate-guide.md#b2b-limitations-across-microsoft-services).

You might need custom orchestration logic to create local accounts in the sandbox tenant. Ensure proper traceability mechanisms back to the employees who own those accounts. 

If you choose B2B, you can use cross-tenant synchronization to seamlessly provision and deprovision the accounts in the sandbox and maintain attributes in sync. Alternatively, you can onboard corporate users to the sandbox through [entitlement management access packages](../id-governance/entitlement-management-external-users.md) that provide an integrated account lifecycle alongside access.

Accounts with access might not necessarily equate to all accounts in a nonproduction tenant. For example, a dev-test tenant might have more user and group objects in the tenant to maintain a volume of directory data that represents the production environment.

## Credential management

When you use B2B, users authenticate with their primary tenant credentials from the production tenant. The sandbox tenant trusts the home tenant for authentication. When you enable [cross-tenant access settings](../external-id/cross-tenant-access-settings-b2b-collaboration.yml) to trust multifactor authentication and device state from the home tenant, users don't need to register or respond to multiple prompts. Independently manage local account credentials in the sandbox tenant. Separately enforce password policies, MFA registration, and credential lifecycle controls. When the sandbox requires device‑based access controls, also provision, enroll, and manage devices within the sandbox tenant. Don't rely on device state from the production environment.

## Collaboration

While B2B accounts can access nonproduction tenants for convenience, this architecture isn't ideal for external collaboration. The sandbox tenant's resources (apps, resources, and data) aren't visible to regular users in the primary tenant unless explicitly invited and granted access. Tight controls limit sharing from production to sandbox. Avoid ad-hoc sharing of content between sandbox and production. In Contoso's case, only certain developers and admins have accounts in the sandbox. Day-to-day collaboration like Teams chats or SharePoint sharing doesn't broadly occur in this model.

## Role-based resource assignment
Manage sandbox resource access with the same Microsoft Entra ID constructs (groups, application roles, entitlement management access package assignments) but scoped to that tenant's applications, resources, and data.

## Risk management

### Blast radius

This tenant composition pattern limits blast radius. If issues occur in a nonproduction tenant (such as misconfiguration), it shouldn't directly affect production resources. The sandbox tenant forms a separate security boundary with separate audit logs and admin control. You can test risky changes (such as a new Conditional Access policy or bulk import) without disrupting real users. Identity isn't isolated when you use guest invitations from production to sandbox. A compromised user in the primary tenant could potentially wreak havoc in the sandbox, too. Similarly, an operational mistake (such as deleting a user or revoking credentials) in the primary tenant might unexpectedly cut off that user's sandbox access. To mitigate this scenario, opt for full identity isolation (such as requiring a local account with separate credentials for the sandbox).

Even though sandbox and preproduction tenants are nonproduction systems, threat actors might gain valuable insights into your production environments if they gain access to those tenants. Properly configure and monitor nonproduction tenants.

### Regulatory requirements

Nonproduction tenants can help customers provide evidence of change management processes as regulators require.

## Other considerations

When you operate extra tenants, you require more overhead because administrators monitor and secure another directory. They might need to ensure the sandbox meets organizational security policy and apply necessary Conditional Access or identity protection policies. The sandbox tenant might need other licenses. For example, if testing Microsoft Intune or Purview features or for guest users to convert to *member* `UserType` for broader access. Establish governance so that the sandbox doesn't introduce risk.

## Related content

- [Microsoft Entra tenant estate guidance introduction](tenant-estate-guide.md)
- [Microsoft Entra tenant estate guidance: Primary production tenant](tenant-estate-primary.md)
- [Microsoft Entra tenant estate guidance: Collaborating production tenants](tenant-estate-collaborating.md)
- [Microsoft Entra tenant estate guidance: Isolated tenants for critical production systems](tenant-estate-critical-production.md)
- [Microsoft Entra tenant estate guidance: Isolated tenants for business partner access](tenant-estate-business-partner.md)
- [Microsoft Entra tenant estate guidance: Hybrid identity and isolation](tenant-estate-hybrid-identity.md)


---
title: Microsoft Entra tenant estate guidance introduction
description: Learn how to compose your Microsoft Entra tenant estate from common tenant architecture patterns so that you can meet your requirements with as few tenants as possible.
author: bathawes
ms.author: beathawe
ms.reviewer: ramical
ms.subservice: architecture
ms.topic: concept-article
ms.date: 06/22/2026
ai-usage: ai-assisted

#CustomerIntent: As an IT admin, I want to learn how to compose my Microsoft Entra tenant estate so that I can identify my needs and meet them with as few tenants as possible.
---
# Microsoft Entra tenant estate guidance introduction

Designing your Microsoft Entra **tenant estate** — the set of tenants your organization operates — means balancing security, compliance, administrative complexity, and user experience. While a single production tenant is ideal for simplicity and user experience, your specific business and technical requirements might necessitate multiple production tenants.

This guidance helps organizations decide how many Microsoft Entra tenants to operate and how to distribute workloads, identities, and external collaboration across them. It describes common tenant architecture patterns that Microsoft has observed across real-world deployments and evaluates each against the same [seven architecture evaluation areas](#tenant-architecture-evaluation-areas), so you can compare your options and meet your security, compliance, risk, and operational requirements with as few tenants as possible. It's intended for identity and security architects and IT administrators — and the business and security sponsors they advise — planning or reviewing their tenant architecture.

> [!NOTE]
> This guidance covers Microsoft Entra **workforce tenants** — the tenants that hold your employees, internal apps, and organizational resources, including any external business partners and guests you invite into them. It doesn't cover **external tenants**, the separate configuration used with Microsoft Entra External ID for customer identity and access management (CIAM). For the distinction between the two, see [Tenant configurations](/entra/external-id/tenant-configurations).

## Tenant architecture patterns

These patterns represent **logical tenant roles** — the role a tenant plays in your architecture and why it exists. The roles are a way to reason about how to design and govern each tenant in your estate.

At the center of the model is the **primary production tenant**: a production tenant that hosts workforce identities and production workloads, and optionally external collaboration. Most organizations begin with a single such tenant. Requirements can grow from there — a large organization might operate multiple production tenants, along with numerous tenants aligned to the other roles described here. The [Primary production tenant](tenant-estate-primary.md) article covers this role in full.

Your organization's tenant estate is composed of the primary production tenant plus any additional tenants, whether you create them to meet a specific requirement or inherit them through mergers, acquisitions, or other organizational change. Each additional tenant adds administrative overhead, cost, and coordination, so operate as few tenants as your security, compliance, and operational requirements allow.

When you inherit multiple HR systems, Active Directory forests, or Microsoft Entra tenants — most commonly through M&A — [Parallel and combined identity infrastructure options](parallel-identity-options.md) provides a decision tree and technical options for consolidating them into fewer instances or running them in parallel. This series helps you decide the target tenant architecture; that article helps you choose the integration technology to reach it. Options that keep the acquired tenant rather than consolidating rely on B2B collaboration, so the [B2B limitations](#b2b-limitations-across-microsoft-services) described here apply.


| Logical tenant role | Pattern |
|---|---|
| Primary production tenant — hosts workforce identities, production workloads, and optionally external collaboration | [Primary production tenant](tenant-estate-primary.md) |
| Additional production tenants that collaborate — such as tenants acquired during M&A activity or operated by independent business units | [Collaborating production tenants](tenant-estate-collaborating.md) |
| Isolated tenant for critical production systems | [Isolated tenants for critical production systems](tenant-estate-critical-production.md) |
| Isolated tenant for business partner access | [Isolated tenants for business partner access](tenant-estate-business-partner.md) |
| Nonproduction tenant for development, testing, and validating tenant-wide changes | [Nonproduction environments](tenant-estate-nonproduction.md) |

The [Primary production tenant](tenant-estate-primary.md) article is the baseline for the series: it covers the seven architecture evaluation areas in detail. Each other pattern article describes only the incremental considerations for its logical tenant role.

[Hybrid identity and isolation](tenant-estate-hybrid-identity.md) is a cross-cutting consideration rather than a tenant role, and can apply to any tenant in your estate.

**Example.** An organization with one primary production tenant and a separate tenant for its critical systems combines two patterns: the [Primary production tenant](tenant-estate-primary.md) baseline for the workforce tenant, and [Isolated tenants for critical production systems](tenant-estate-critical-production.md) for the isolated tenant.

## Tenant architecture evaluation areas

The following architecture evaluation areas provide a consistent framework to identify your requirements and compare tenant composition options.

- **Administration.** Delegate and govern privileged roles, tenant-wide settings, and service-specific controls across administrative boundaries. Additional tenants increase coordination overhead and configuration drift risk, while enabling independent tenant-wide configurations for workloads that require them.
- **Change control.** Plan, validate, and roll out configuration changes to maintain stability, compliance, and security. You can use additional tenants as validation environments for tenant-scoped settings that lack gradual rollout mechanisms, though coordination is required to prevent policy drift.
- **Account lifecycle.** Define business rules for provisioning, moving, and deprovisioning user accounts across their lifecycle. Cross-tenant scenarios require explicit lifecycle automation to prevent orphaned access.
- **Credential management.** Manage authentication methods, credential policies, and multifactor authentication enforcement for workforce and external users. Additional tenants require you to decide whether to trust MFA and device claims from other tenants or require separate credentials. User friction increases as isolation increases.
- **Collaboration.** Enable workforce and external users to communicate, share content, and work together across Microsoft 365 services. Collaboration experience degrades as tenant isolation increases, so consider the tradeoff between isolation requirements and productivity impact.
- **Role-based resource assignment.** Assign and govern workforce and external user access to resources such as applications, groups, and sites. Additional tenants require independent assignment configuration and governance in each tenant rather than unified management across a single directory.
- **Risk management.** Assess and mitigate blast radius, regulatory compliance scope, and lateral movement risks across tenant boundaries. Additional tenants can contain the impact of security incidents and reduce compliance scope, while expanding overall attack surface and operational complexity.

## When to integrate an app or workload with an existing tenant

When you introduce a new app or workload, or reassess an existing one, decide whether to integrate it with an existing tenant — typically your primary production tenant — for single sign-on and user provisioning, or to place it in a separate tenant. Co-locating an app or workload with the users and resources it works with in a single tenant provides the most seamless user experience and functional fidelity. Adding a tenant instead involves two kinds of tradeoff. **Every** additional tenant adds overhead:

- **Administration and governance.** Roles, policies, and governance are configured and audited independently in each tenant, increasing coordination overhead and configuration-drift risk.
- **Account lifecycle.** Each tenant needs its own provisioning and deprovisioning.
- **Attack surface.** Each additional tenant is another directory to secure and monitor, expanding your overall attack surface.

**Additional** tradeoffs apply when workloads or identities that still need to work together are split across tenants, because they then depend on cross-tenant access through B2B collaboration. (Patterns such as [Isolated tenants for critical production systems](tenant-estate-critical-production.md) deliberately avoid this connectivity — there, the reduced interoperability is the goal, not an architectural drawback.)

- **Collaboration.** Users homed in different tenants get a more limited Microsoft 365 experience — some Teams, SharePoint, co-authoring, search, and presence scenarios that are seamless within one directory are reduced or require tenant switching. If you must operate multiple production tenants, [Collaborating production tenants](tenant-estate-collaborating.md) describes how to recover some of this experience.
- **Feature support.** B2B collaboration users aren't equivalent to [users that authenticate internally](../external-id/user-properties.md); specific features are limited or unsupported for external (B2B) users (see [B2B limitations across Microsoft Services](#b2b-limitations-across-microsoft-services)).
- **User friction.** Users may need to register MFA and authenticate separately per tenant unless you configure cross-tenant trust, and some admin experiences don't support B2B or delegated cross-tenant administration.

Weigh these tradeoffs against your reasons to separate, and integrate an app or workload with an existing tenant unless a specific requirement outweighs them. Each pattern in this series represents such a requirement — for example, keeping a critical workload's administration and compliance scope separate from the main tenant ([Isolated tenants for critical production systems](tenant-estate-critical-production.md)), isolating business-partner access from your workforce tenant ([Isolated tenants for business partner access](tenant-estate-business-partner.md)), or operating separate production tenants that must still collaborate ([Collaborating production tenants](tenant-estate-collaborating.md)). Connecting a workload to an existing tenant for single sign-on or user provisioning also lets that tenant's administrators and identity changes affect it — a consideration when administrative separation is a requirement.

## Tenant lifecycle governance

As the number of tenants grows, so does the attack surface. Plan tenant lifecycle governance from the start, including classification, creation controls, and decommissioning processes. Use [Microsoft Entra Tenant Governance](../id-governance/tenant-governance/overview.md) to operationalize this across your estate — discovering related and "shadow IT" tenants, controlling tenant creation, monitoring configuration drift, and administering governed tenants from one place. The [Remove legacy systems that risk security](/security/zero-trust/sfi/remove-legacy-systems-that-risk-security) article provides guidance to reduce tenant sprawl and eliminate legacy environments based on Microsoft learnings from operating a large multitenant estate.

## Multitenant administration patterns

When you operate multiple tenants, determine how administrators gain and exercise administrative access. The following table compares three approaches.

| Pattern | Description | Considerations |
|---|---|---|
| Cross-tenant delegated administration (GDAP) | Establish [governance relationships](../id-governance/tenant-governance/governance-relationships.md) between a governing tenant and governed tenants. Administrators sign in to governed tenants with governing tenant credentials and exercise [cross-tenant delegated administration](../id-governance/tenant-governance/cross-tenant-delegated-administration.md) based on least-privilege role assignments. | Scalable across many tenants with consistent policy enforcement using security groups and governance policy templates. No B2B or local accounts required in governed tenants. Some admin experiences don't support GDAP. Tenant Governance relationships can't coexist with GDAP relationships that you configure through Partner Center between the same two tenants. The [Tenant Governance FAQ](../id-governance/tenant-governance/faq.yml) provides detailed guidance. |
| B2B admin accounts | Invite administrators as B2B collaboration users and assign directory roles in each tenant. Administrators sign in using their home Microsoft Entra tenant. | Single credential for administrators reduces sign-in friction. Some admin experiences don't support B2B users. Role assignments require separate management per tenant. Account lifecycle depends on B2B invitation and redemption processes. A single user can belong to a [limited number of Microsoft Entra tenants](../identity/users/directory-service-limits-restrictions.md) as a member or a guest. |
| Local accounts | Create and manage separate administrator accounts in each tenant. | Maximum isolation and independence per tenant. Highest credential management overhead. No single-identity traceability. Increased risk of orphaned accounts. |

Regardless of which pattern you choose, target tenant security and compliance controls apply to administrator sessions in that tenant. For example, Conditional Access policies govern access and audit logs capture administrative activity.

Cross-tenant delegated administration uses the same granular delegated admin privileges (GDAP) technology that Partner Center uses to enable partners to administer customer tenants. When you establish a governance relationship with delegated administration configured, the system creates GDAP role assignments in the governed tenant that allow designated security groups from the governing tenant to perform administrative tasks. Governed tenant stakeholders can independently monitor, review, and audit all actions that delegated administrators perform through their own sign-in and audit logs.

Choose the cross-tenant administration pattern based on your isolation requirements, operational scale, and governance maturity. You might use different patterns for different tenant relationships within the same organization. For example, you might use cross-tenant delegated administration for nonproduction and subsidiary tenants while choosing local accounts for tenants that require maximum isolation from all other environments.

## People whose needs shape tenant architecture

Throughout this article series, we refer to the following people whose access and collaboration needs a tenant architecture must accommodate.

- **Workforce.** Full-time employees, part-time employees, and contractors who require secure access and collaboration within your organization.
- **External users.** Organizations or individuals outside your organization who collaborate with your enterprise to achieve mutual goals. For example, suppliers, vendors, consultants, and strategic alliances might require access to specific resources or applications.

## B2B limitations across Microsoft Services

Microsoft Entra B2B collaboration enables users to use a single set of credentials from their home tenant to access resources in other tenants and collaborate with users from other tenants. However, B2B collaboration users aren't equivalent to [users that authenticate internally](../external-id/user-properties.md). Evaluate the following external (B2B) user considerations and limitations based on your cross-tenant resource access use cases.

- [Limitations of B2B collaboration - Microsoft Entra External ID](../external-id/current-limitations.md)
- [Limitations in multitenant organizations - Microsoft Entra ID](../identity/multi-tenant-organizations/multi-tenant-organization-known-issues.md)
- [Microsoft Entra ID Protection for B2B Users - Microsoft Entra ID Protection](../id-protection/concept-identity-protection-b2b.md)
- [How Token Protection Enhances Conditional Access Policies - Microsoft Entra ID](../identity/conditional-access/concept-token-protection.md)
- [Authentication and Conditional Access for B2B users - Microsoft Entra External ID](../external-id/authentication-conditional-access.md)

## Related content

- [Microsoft Entra tenant estate guidance: Primary production tenant](tenant-estate-primary.md)
- [Microsoft Entra tenant estate guidance: Collaborating production tenants](tenant-estate-collaborating.md)
- [Microsoft Entra tenant estate guidance: Nonproduction environments](tenant-estate-nonproduction.md)
- [Microsoft Entra tenant estate guidance: Isolated tenants for critical production systems](tenant-estate-critical-production.md)
- [Microsoft Entra tenant estate guidance: Isolated tenants for business partner access](tenant-estate-business-partner.md)
- [Microsoft Entra tenant estate guidance: Hybrid identity and isolation](tenant-estate-hybrid-identity.md)
- [Parallel and combined identity infrastructure options](parallel-identity-options.md)
- [Governance relationships in Microsoft Entra Tenant Governance](../id-governance/tenant-governance/governance-relationships.md)
- [Cross-tenant delegated administration](../id-governance/tenant-governance/cross-tenant-delegated-administration.md)
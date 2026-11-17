---
title: Governance relationships in Tenant Governance
titleSuffix: Microsoft Entra ID Governance
description: Learn about governance relationships and how they enable centralized management of tenants in Microsoft Entra Tenant Governance
ms.topic: concept-article
ms.date: 11/11/2026
ai-usage: ai-assisted
---

<!-- source: Governance relationships.docx -->

# Governance relationships

A governance relationship establishes a directional connection between two Microsoft Entra tenants. One tenant (the *governing* tenant) governs another tenant (the *governed* tenant). These relationships enable organizations to securely manage multiple tenants at scale from a central location.

Governance relationships enable four key scenarios:

| Scenario | Description |
| --- | --- |
| Cross-tenant delegated administration | Use governance relationships to centralize **least-privileged administrative access** across multiple Microsoft Entra tenants. Administrators sign in using accounts from the governing tenant. This approach eliminates the need to create and manage local or B2B administrator accounts in every governed tenant. |
| Multitenant application management | Manage custom, multitenant applications from the governing tenant. Administrators can monitor and maintain least-privileged application access across governed tenants without signing into each tenant individually. This approach reduces operational overhead and configuration drift. |
| Tenant configuration management | If you configured cross-tenant delegated administration in your governance relationship, use this administrative access to ensure that the tenant meets your organization's security and compliance objectives on an ongoing basis. |
| Secure tenant creation | When you create a new add-on tenant from an existing tenant, Tenant Governance automatically establishes a governance relationship between the parent tenant and the new tenant by using a default governance policy template. This step immediately brings newly created tenants under centralized administration and governance controls, reducing the risk of unmanaged or misconfigured tenants. |

## Relationship handshake

Any two Microsoft Entra tenants can create a new governance relationship through the three-step handshake. To create a new governance relationship, or update an existing one, administrators from both tenants must configure and agree on the roles and permissions that the governing tenant has over the governed tenant.

1. The future governed tenant sends the future governing tenant a governance invitation.

1. Upon receiving a governance invitation, the future governing tenant sends the future governed tenant a governance request (with a selected governance policy template).

1. After the future governed tenant reviews and accepts the request, the tenants establish a governance relationship.

Tenants that meet these criteria can skip the invitation step:

- The future governing tenant identifies the future governed tenant as a related tenant through tenant discovery with a shared billing account.

- Tenants in an active governance relationship can skip the invitation step to update their relationship or create a new one.

## Relationship lifecycle

A governance relationship moves through several states from creation to termination. The following sections describe the states for both requests and established relationships.

### Request states

Governance requests progress through these states:

| State | Description |
| --- | --- |
| Pending | The governing tenant sent the request and awaits a response from the governed tenant. |
| Accepted | The governed tenant accepted the request, creating a governance relationship. |
| Rejected | The governed tenant rejected the request. |

### Relationship states

Governance relationships progress through these states:

| State | Description |
| --- | --- |
| Active | The relationship is established and operational. |
| Termination requested | The governing tenant has requested to terminate the relationship. |
| Terminated | The relationship ended through termination or expiration. Tenant Governance removes access granted only through that relationship and preserves resources required by surviving relationships or unrelated grants. |

### Expiration and renewal (Preview)

You can optionally configure a relationship lifetime from 1 to 730 days in a governance policy template. The governed tenant reviews and approves that lifetime when accepting the governance request. Without a configured lifetime, the relationship doesn't expire automatically.

The governing tenant can request renewal before expiration, and the governed tenant must approve it. Renewal preserves the relationship ID, permissions, and existing policy snapshot. The new expiration is the renewal acceptance time plus the lifetime stored in the active relationship.

A pending renewal doesn't pause expiration. If renewal isn't approved before the deadline, Tenant Governance terminates the relationship and removes its exclusive access. An expiration warning isn't a separate relationship status.

For setup, notifications, cleanup behavior, and the add-on tenant exception, see [Manage relationship expiration and renewal](how-to-manage-relationship-expiration.md).

## Governance models

When you set up governance relationships between a pair of tenants, note these supported models.

| Supported? | Model type | Description |
| --- | --- | --- |
| ✅ | One to many | A tenant can govern multiple tenants. |
| ✅ | Many to one | Multiple tenants can govern a tenant. |
| ✅ (Preview) | Multi-tier | A tenant can be governed by another tenant while governing downstream tenants. Each direct relationship requires independent approval and defines its own permissions. Access isn't inherited down the chain. |

For example, if A governs B and B governs C, A doesn't automatically gain access to C. To administer C, A needs its own direct relationship with C, approved by C. Each relationship has an independent policy snapshot and lifecycle.

For a walkthrough, see [Set up multi-tier governance relationships](how-to-set-up-multi-tier-governance.md).

## Switch between governed tenants (Preview)

The **Governed tenants** view under **Entra ID** > **Overview** > **Manage tenants** helps users find and switch to tenants available through active relationships and qualifying delegated-role group membership. Switching uses existing access; it doesn't grant new permissions or create B2B guest accounts.

For prerequisites and instructions, see [Switch between governed tenants](how-to-switch-governed-tenants.md).

## Related content

- [Set up a governance relationship](how-to-set-up-governance-relationship.md)
- [Governance policy templates](governance-policy-templates.md)
- [Cross-tenant delegated administration](cross-tenant-delegated-administration.md)

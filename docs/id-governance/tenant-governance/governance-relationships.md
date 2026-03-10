---
title: Governance relationships in tenant governance
titleSuffix: Microsoft Entra ID Governance
description: Learn about governance relationships and how they enable centralized management of tenants in Microsoft Entra tenant governance
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/10/2026
---

<!-- source: Governance relationships.docx -->

# Governance relationships

A governance relationship establishes a directional connection between two Microsoft Entra tenants. One tenant (the *governing* tenant) governs another tenant (the *governed* tenant). These relationships enable organizations to securely manage multiple tenants at scale from a central location.

Governance relationships enable four key scenarios:

| Scenario | Description |
|---|---|
| Cross-tenant delegated administration | Use governance relationships to centralize **least-privileged administrative access** across multiple Microsoft Entra tenants. Administrators sign in using accounts from the governing tenant, eliminating the need to create and manage local or B2B administrator accounts in every governed tenant. This model is designed for organizations that operate multiple tenants but want a single administrative control plane. |
| Multi-tenant application management | Manage custom, multi-tenant applications from the governing tenant. Governance relationships allow administrators to monitor and maintain least-privileged application access across governed tenants without signing into each tenant individually, reducing operational overhead and configuration drift. |
| Tenant configuration management | If you've configured cross-tenant delegated administration in your governance relationship, you can use this administrative access to ensure that the tenant meets your organization's security and compliance objectives on an ongoing basis. |
| Secure tenant creation | When you create a new add-on tenant from an existing tenant, the system automatically establishes a governance relationship between the parent tenant and the new tenant by using a default governance policy template. This step immediately brings newly created tenants under centralized administration and governance controls, reducing the risk of unmanaged or misconfigured tenants. |

## Relationship handshake

To create a new governance relationship, or update an existing one, administrators from both tenants must configure and agree on the set of roles and permissions that the governing tenant has over the governed tenant. Any two Microsoft Entra tenants can create a new governance relationship through the three-step handshake:

1. The future governed tenant sends the future governing tenant a governance invitation.

1. Upon receiving a governance invitation, the future governing tenant sends the future governed tenant a governance request (with a selected governance policy template).

1. After the future governed tenant reviews and accepts the request, the tenants establish a governance relationship.

Tenants that meet the following criteria can skip the invitation step:

- The future governing tenant identifies the future governed tenant as a related tenant through Tenant discovery with a Shared billing account.

- Tenants in an active governance relationship can skip the invitation step to update their relationship or create a new one.

## Relationship lifecycle

### Request states

Governance requests progress through the following states:

| State | Description |
|---|---|
| Pending | The governing tenant sent the request and awaits a response from the governed tenant. |
| Accepted | The governed tenant accepted the request, resulting in the creation of a governance relationship. |
| Rejected | The governed tenant rejected the request. |

### Relationship states

Governance relationships progress through the following states:

| State | Description |
|---|---|
| Active | The relationship is established and operational. |
| Termination requested | The governing tenant has requested to terminate the relationship. |
| Terminated | Both tenants terminated the relationship, and the system deleted all related resources. |

## Governance models

When you set up governance relationships between a pair of tenants, note the following supported models.

| Supported? | Model type | Description |
|---|---|---|
| ✅ | One to many | A tenant can govern multiple tenants. |
| ✅ | Many to one | Multiple tenants can govern a tenant. |
| ❌ | Multi-tier | A tenant can't be both a governing and governed tenant. For example, if Contoso governs Fabrikam, Fabrikam can't request to govern another tenant. |

## Related content

- [Set up a governance relationship](how-to-setup-governance-relationship.md)
- [Governance policy templates](governance-policy-templates.md)
- [Cross-tenant delegated administration](cross-tenant-delegated-administration.md)

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

A governance relationship is a directional connection established between two Microsoft Entra tenants, where one tenant (the *governing* tenant) governs another tenant (the *governed* tenant). These relationships enable organizations to securely manage multiple tenants at scale from a central location.

Governance relationships enable four key scenarios:

| Scenario | Description |
|---|---|
| Cross tenant delegated administration | Use governance relationships to centralize **least-privileged administrative access** across multiple Microsoft Entra tenants. Administrators sign in using accounts from the governing tenant, eliminating the need to create and manage local or B2B administrator accounts in every governed tenant. This model is designed for organizations that operate multiple tenants but want a single administrative control plane. |
| Multi-tenant application management | Manage custom, multi-tenant applications from the governing tenant. Governance relationships allow administrators to monitor and maintain least-privileged application access across governed tenants without signing into each tenant individually, reducing operational overhead and configuration drift. |
| Tenant configuration management | If you've configured cross-tenant delegated administration in your governance relationship, you can leverage this administrative access to ensure that the tenant is configured to meet your organization's security and compliance objectives on an ongoing basis. |
| Secure tenant creation | When a new add-on tenant is created from an existing tenant, a governance relationship is automatically established between the parent tenant and the new tenant using a default governance policy template. This ensures that newly created tenants are immediately brought under centralized administration and governance controls, reducing the risk of unmanaged or misconfigured tenants. |

## Relationship handshake

To create a new governance relationship, or update an existing one, administrators from both tenants must configure and agree on the set of roles and permissions that the governing tenant will have over the governed tenant. Any two Microsoft Entra tenants may create a new governance relationship via the three step handshake:

1. The future governed tenant sends the future governing tenant a governance invitation.

1. Upon receiving a governance invitation, the future governing tenant sends the future governed tenant a governance request (with a selected governance policy template)

1. After the future governed tenant reviews and accepts the request, a governance relationship is created.

Tenants that meet the below criteria may forego the invitation step:

- The future governed tenant is identified as a related tenant to the future governing tenant through Tenant discovery with a Shared billing account

- Tenants that are in an active governance relationship may forego the invitation step to update their relationship, or create a new one

## Relationship lifecycle

### Request states

Governance requests progress through the following states:

| State | Description |
|---|---|
| Pending | The request has been sent and is awaiting a response from the governed tenant. |
| Accepted | The governed tenant accepted the request, resulting in the creation of a governance relationship. |
| Rejected | The governed tenant rejected the request. |

### Relationship states

Governance relationships progress through the following states:

| State | Description |
|---|---|
| Active | The relationship is established and operational. |
| Termination requested | The governing tenant has requested to terminate the relationship. |
| Terminated | The relationship has been terminated and all related resources are deleted. |

## Governance models

When setting up governance relationships between a pair of tenants, note the following models that are supported

| Supported? | Model type | Description |
|---|---|---|
| ✅ | One to many | A tenant may govern multiple tenants. |
| ✅ | Many to one | Multiple tenants may govern a tenant. |
| ❌ | Multi-tier | A tenant can't be both a governing and governed tenant. For example, if Contoso governs Fabrikam, Fabrikam can't request to govern another tenant. |

## Related content

- [Set up a governance relationship](how-to-setup-governance-relationship.md)
- [Governance policy templates](governance-policy-templates.md)
- [Cross-tenant delegated administration](cross-tenant-delegated-administration.md)

---
title: Terminate a governance relationship (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn how to terminate a governance relationship between tenants in Microsoft Entra Tenant Governance and understand what resources are removed
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: How to terminate a governance relationship.docx -->

# Terminate a governance relationship (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

This article describes how to terminate a governance relationship between a governing tenant and a governed tenant. When you terminate a governance relationship, Tenant Governance deletes all relationship-related resources from the governed tenant, including granular delegated admin privileges (GDAP) role assignments, service principals, and their permissions.

Terminate a governance relationship in two ways, depending on whether the governing tenant or the governed tenant initiates the termination.

| Initiated by | Process |
|---|---|
| Governing tenant | Sends a termination request to the governed tenant. The governed tenant must confirm to complete termination. |
| Governed tenant | Directly terminates the relationship. The governing tenant doesn't need to take any action. |

## Prerequisites
- You must have an active governance relationship between two tenants.

- You need the **Tenant Governance Administrator** role.

## Terminate a relationship: Governing tenant initiation
The governing tenant can request to terminate a governance relationship. This process requires confirmation from the governed tenant before Tenant Governance removes the relationship and its resources.

### Initiate termination as the governing tenant
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a **Tenant Governance Administrator** in the governing tenant.

1. Browse to **Tenant governance** > **Governed tenants**.

1. Select the active governance relationship you want to terminate.

1. Select **Terminate governance**.

   The relationship status changes to **Termination requested**. Tenant Governance sends an email notification to the governed tenant about the termination request.

1. Wait for the governed tenant to confirm the termination.

   When the governed tenant confirms, Tenant Governance deletes all relationship-related resources from the governed tenant, and the relationship status changes to **Terminated**.

### Confirm termination as the governed tenant
When the governing tenant initiates termination, the governed tenant must confirm the request to complete the process.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a **Tenant Governance Administrator** in the governed tenant.

1. Browse to **Tenant governance** > **Governing tenants**.

1. Change the **Relationship status** filter to **Termination requested**.

1. Select the tenant that requested termination.

1. Select **Confirm termination**.

   Tenant Governance deletes all relationship-related resources from the governed tenant, and the relationship status changes to **Terminated**. Tenant Governance sends an email notification to the governing tenant that termination is complete.

## Directly terminate a relationship: Governed tenant
As the governed tenant, directly terminate a governance relationship without requiring approval from the governing tenant.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a **Tenant Governance Administrator** in the governed tenant.

1. Browse to **Tenant governance** > **Governing tenants**.

1. Select the tenant whose governance relationship you want to terminate.

1. Select **Terminate governance**.

1. Review the details of the relationship, then confirm termination.

   Tenant Governance deletes all relationship-related resources from the governed tenant, and the relationship status changes to **Terminated**. Tenant Governance sends an email notification to the governing tenant that the relationship is terminated.

## What happens when you terminate a governance relationship
When you terminate a governance relationship, Tenant Governance updates or deletes these resources from the governed tenant:

- **Cross-tenant access policy**: Tenant Governance removes the governing tenant as a partner from the partner-specific cross-tenant access configuration in the governed tenant.

- **GDAP role assignments**: Tenant Governance removes cross-tenant role assignments that allowed users from the governing tenant to sign in to and manage the governed tenant.

- **Service principals**: If an admin configured multi-tenant application management, Tenant Governance removes the corresponding service principal and its permissions from the governed tenant.

After termination, users from the governing tenant can no longer sign in to the governed tenant with their governing tenant credentials through the governance relationship.

## Related content
- [Set up a governance relationship](how-to-setup-governance-relationship.md)

- [Update a governance relationship](how-to-update-governance-relationship.md)

---
title: Terminate a governance relationship
description: Learn how to terminate a governance relationship between tenants in Microsoft Entra tenant governance.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: How to terminate a governance relationship.docx -->

# Terminate a governance relationship

This article describes how to terminate a governance relationship between a governing tenant and a governed tenant. When a governance relationship is terminated, all relationship-related resources, including GDAP role assignments, service principals, and their permissions, are deleted from the governed tenant.

There are two ways to terminate a governance relationship, depending on whether termination is initiated by the governing tenant or the governed tenant.

| Initiated by | Process |
|---|---|
| Governing tenant | Sends a termination request to the governed tenant. Termination is completed when the governed tenant confirms. |
| Governed tenant | Directly terminates the relationship. No action from the governing tenant is required. |

## Prerequisites
- You must have an active governance relationship between two tenants.

- Review role requirements in [Tenant governance roles](https://aka.ms/TenantGovernance/Roles).

## Terminate a relationship - Governing tenant initiation
The governing tenant can request to terminate a governance relationship. This process requires confirmation from the governed tenant before the relationship and its resources are removed.

### Initiate termination as the governing tenant
1. Sign in to the admin portal as an admin of the governing tenant.

1. Navigate to Tenant governance > Governed tenants.

1. Select the active governance relationship you want to terminate.

1. Select **Terminate governance**.

   The relationship status changes to **Termination requested**. An email notification is sent to the governed tenant informing them of the termination request.

1. Wait for the governed tenant to confirm the termination.

   When the governed tenant confirms, all relationship-related resources are deleted from the governed tenant, and the relationship status changes to **Terminated**.

### Confirm termination as the governed tenant
When the governing tenant initiates termination, the governed tenant must confirm the request to complete the process.

1. Sign in to the admin portal as an admin of the governed tenant.

1. Navigate to Tenant governance > **Governing tenants**.

1. Change the **Relationship status** filter to **Termination requested**.

1. Select the tenant that requested termination.

1. Select **Confirm termination**.

   All relationship-related resources are deleted from the governed tenant, and the relationship status changes to **Terminated**. An email notification is sent to the governing tenant informing them that the termination has been completed.

## Directly terminate a relationship as the governed tenant
As the governed tenant, you can directly terminate a governance relationship without requiring approval from the governing tenant.

1. Sign in to the admin portal as an admin of the governed tenant.

1. Navigate to Tenant governance > **Governing tenants**.

1. Select the tenant whose governance relationship you want to terminate.

1. Select **Terminate governance**.

1. Review the details of the relationship being terminated, then confirm termination.

   All relationship-related resources are deleted from the governed tenant, and the relationship status changes to **Terminated**. An email notification is sent to the governing tenant informing them that the relationship has been terminated.

## What happens when a governance relationship is terminated
When a governance relationship is terminated, the following resources are updated/deleted from the governed tenant:

- **Cross-tenant access policy**: The governing tenant is removed as a partner from the partner-specific cross-tenant access configuration in the governed tenant.

- **GDAP role assignments**: Cross-tenant role assignments that allowed users from the governing tenant to sign in and manage the governed tenant are removed.

- **Service principals**: If multi-tenant app management was configured, the corresponding service principal and its permissions are removed from the governed tenant.

After governed tenant termination, users from the governing tenant can no longer sign in to the governed tenant using their governing tenant credentials through the governance relationship.

## Related content
- [Set up a governance relationship](how-to-setup-governance-relationship.md)

- [Update a governance relationship](how-to-update-governance-relationship.md)

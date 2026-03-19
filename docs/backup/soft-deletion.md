---
title: Soft deletion in Microsoft Entra Backup and Recovery
description: Learn what soft deletion is, how it relates to Microsoft Entra Backup and Recovery, and what recovery can and can't do
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: concept-article
ai-usage: ai-assisted
---

# Soft deletion in Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Soft deletion is a foundational data protection capability in Microsoft Entra that helps organizations recover from accidental or malicious deletions. Instead of immediately and permanently removing an object, soft deletion places the object into a recoverable state for a limited retention period. During this time, the object can be restored with its properties and relationships intact.

Soft deletion is a core building block of Microsoft Entra Backup and Recovery, enabling reliable recovery without recreating objects or reconfiguring access models. For an overview of deletion and recovery concepts, see [Recover from deletions](/entra/architecture/recover-from-deletions).

This article explains what soft deletion is, how it relates to Backup and Recovery, and what recovery can, and can't, do.

## What is soft deletion?

When an object that supports soft deletion is deleted, Microsoft Entra doesn't immediately remove it from the directory. Instead, it transitions into a soft-deleted state:

- The object is no longer active and can't be used for authentication or authorization.
- Microsoft Entra retains the object's data for a 30-day period.
- You can restore the object during the retention window, returning it to its previous active state.

## Soft deletion and Backup and Recovery

Microsoft Entra Backup and Recovery builds on soft deletion to provide a comprehensive recovery experience.

### How backup works

Microsoft Entra continuously records changes to supported directory objects. If an object is soft deleted, the backup captures the change and restores the object when you use that backup for recovery. To learn which objects support soft deletion, see [Recover from deletions in Microsoft Entra ID](/entra/architecture/recover-from-deletions#properties-maintained-with-soft-delete).

These backups are Microsoft-managed and don't require you to export or manage your own copies. Backups capture object state over time, enabling recovery to a known-good point.

### How recovery works

During a recovery operation:

- Microsoft Entra uses **backups** to determine the correct object state.
- Backup and Recovery **restores soft-deleted objects** rather than recreating them.
- Backup and Recovery **soft deletes** objects added after the backup was taken.
- Object identifiers, properties, and supported relationships are preserved.

> [!IMPORTANT]
> Microsoft never hard deletes customer objects as part of the recovery process. Recovery operations always rely on restoring soft-deleted objects or rolling objects back to a previous state.
> During recovery, Backup and Recovery soft deletes new objects added after the selected backup. This approach helps reduce the risk of accidental and malicious misconfigurations following recovery. For scenarios where you shouldn't soft delete one or more objects, apply filters to control which objects are in scope of recovery.

This approach avoids the risks and operational burden of object re-creation, such as:

- Loss of object IDs
- Broken dependencies
- Manual reconfiguration of access or policies by administrators

### Soft delete versus hard delete

Understanding the difference between soft deletion and hard deletion is critical for recovery planning.

| Deletion type | What happens | Can it be recovered? |
|---|---|---|
| **Soft delete** | Object is retained in a deleted state for a limited time | Yes, within the retention window |
| **Hard delete** | Object is permanently removed from the directory | No |

If an object is **hard deleted**, it's permanently removed and **can't be recovered**. The only option is to create a new object, which results in a new object ID and loss of prior configuration and relationships.

Microsoft Entra Backup and Recovery **doesn't support recovery of hard-deleted objects**. Organizations can use capabilities such as Microsoft Entra Conditional Access to add a layer of protection for sensitive permissions, including hard deletion of directory objects. For more information, see [What are protected actions in Microsoft Entra ID?](/entra/identity/role-based-access-control/protected-actions-overview).

### Why soft deletion matters

Soft deletion is essential to building a resilient identity system because it:

- Enables fast recovery from mistakes and attacks
- Preserves object integrity and relationships
- Reduces downtime and operational risk
- Forms the foundation for reliable Backup and Recovery

When combined with soft deletion, Microsoft Entra Backup and Recovery enables organizations to recover from unintended or malicious attribute changes and deletions. Recovery never permanently deletes customer data.

## Next steps

- Learn how to recover deleted objects or restore modified objects to a previous state using Microsoft Entra Backup and Recovery: [Recover objects](recover-objects.md)
- Understand how to reduce the risk of permanent data loss: [What are protected actions in Microsoft Entra ID?](/entra/identity/role-based-access-control/protected-actions-overview)

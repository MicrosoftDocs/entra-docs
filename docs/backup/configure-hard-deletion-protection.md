---
title: Configure Hard Deletion Protection in Microsoft Entra (preview)
description: Learn how to protect supported Microsoft Entra objects from permanent deletion during the first seven days after they're soft deleted.
author: tazkiaafra
ms.author: tazkiaafra
ms.date: 10/12/2026
ms.service: entra-id
ms.topic: how-to
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated

#customer intent: As an identity administrator, I want to protect critical directory objects from immediate permanent deletion so that I have time to restore them after an accidental or unwanted deletion.
---

# Configure Hard Deletion Protection in Microsoft Entra (preview)

Hard Deletion Protection helps protect critical Microsoft Entra objects from immediate permanent deletion. When you enable protection for an object, the object can still be soft deleted and restored. However, it can't be permanently deleted during the first seven days after it's soft deleted.

Identity administrators can use this article to enable Hard Deletion Protection and view protected objects. To complete the task, you need the **Microsoft Entra Backup Administrator** role and an existing supported object.

> [!IMPORTANT]
> Hard Deletion Protection is in preview.
>
> Protection is permanent. After you enable Hard Deletion Protection for an object, you can't remove or undo the protection.
>
> If you enable protection unintentionally, soft delete the object and wait seven days before you permanently delete it.

## Prerequisites

- An active Microsoft Entra user with the **Microsoft Entra Backup Administrator** role.
- No additional license is required for the currently supported object types.

Hard Deletion Protection supports:

- Users (on-premises synchronized users aren't supported).
- Cloud-only groups.
- Applications.
- Service principals.

> [!NOTE]
> Microsoft Entra Agent ID objects are supported through their underlying user, application, and service principal object types.

## Understand deletion and restoration behavior

Hard Deletion Protection doesn't prevent soft deletion. It gives you time to investigate and restore an object before permanent deletion is allowed.

- The seven-day protection window starts at the time the object is soft deleted.
- Attempts to permanently delete the object during the seven-day window are blocked.
- After the seven-day window ends, the object can be permanently deleted.
- If you restore the object, Hard Deletion Protection remains enabled.
- If the restored object is soft deleted again, a new seven-day protection window starts.
- Enabling Hard Deletion Protection is recorded in the Microsoft Entra audit logs.

When a selected set includes a protected object, the permanent-deletion action is blocked.

<!-- TODO: Replace this paragraph with the final customer-facing blocked-deletion message and add a screenshot when the UX text is finalized. -->

## Enable Hard Deletion Protection

In the Microsoft Entra admin center, you can protect up to 20 objects of one object type in each operation. Objects that already have protection enabled aren't available for selection.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a **Microsoft Entra Backup Administrator**.

1. Browse to **Backup and recovery** > **Hard deletion protection**.

   :::image type="content" source="media/configure-hard-deletion-protection/hard-deletion-protection-page.png#lightbox" alt-text="Screenshot of the Hard deletion protection page with the Add protection button and permanent-protection warning.":::

1. Select **Add protection**.

1. Select one supported object type.

1. Search for and select up to 20 objects of that type.

   :::image type="content" source="media/configure-hard-deletion-protection/select-hard-deletion-protection-objects.png#lightbox" alt-text="Screenshot of the Select objects pane with Users selected, an Add control for object IDs, and the permanent-protection warning.":::

1. Review the permanent-protection warning, and then select **Save**.

1. Review the protected-object counts on the **Hard deletion protection** page. To view protected objects of a specific type, select the corresponding link.

## Related content

- [Soft deletion in Microsoft Entra Backup and Recovery](soft-deletion.md)
- [Recover objects using Microsoft Entra Backup and Recovery](recover-objects.md)
- [Supported objects and recoverable properties in Microsoft Entra Backup and Recovery](scope-supported-objects-limitations.md)

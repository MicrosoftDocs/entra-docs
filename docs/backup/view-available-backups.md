---
title: View available backups in Microsoft Entra Backup and Recovery
description: Learn how to view available backups for your tenant in Microsoft Entra Backup and Recovery, including backup frequency, retention, and next steps
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: how-to
ai-usage: ai-assisted
---

# View available backups in Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

This article describes how to view available backups for your tenant in Microsoft Entra Backup and Recovery.

Microsoft Entra backups provide a point-in-time view of supported tenant objects and their attributes. Backups help administrators review changes and recover from accidental or unwanted modifications.

Key characteristics of Backup and Recovery:

- **One backup per day**: Microsoft Entra automatically creates one backup each day for your tenant.
- **Retained for five days**: Each backup is available for up to five days from its timestamp.
- **Non-editable**: Backups can't be modified or deleted.

## Prerequisites

To view available backups in your tenant, you must have the **Microsoft Entra Backup Reader** role or a higher-privileged role.

## View backups

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a **Microsoft Entra Backup Reader**.

1. Browse to **Backup and recovery**. The **Overview** page shows feature highlights, alerts, and recent activity.

   :::image type="content" source="media/view-available-backups/backup-recovery-overview.png#lightbox" alt-text="Screenshot of the Backup and recovery Overview page in the Microsoft Entra admin center, showing feature highlights and alerts.":::

1. Select **Backups** to view the list of available backups for your tenant. Each backup shows its timestamp and backup ID.

   :::image type="content" source="media/view-available-backups/backups-list.png#lightbox" alt-text="Screenshot of the Backups page showing a list of five available backups with their timestamps and backup IDs.":::

From the **Backups** page, select a backup to [create a difference report](create-review-difference-reports.md) or [start a recovery](recover-objects.md).

## Related content

- [Create and review difference reports](create-review-difference-reports.md)
- [Recover objects](recover-objects.md)

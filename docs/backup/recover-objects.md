---
title: Recover objects using Microsoft Entra Backup and Recovery
description: Learn how to recover objects to a previous state using Microsoft Entra Backup and Recovery, including recovery from difference reports and directly from backups.
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: how-to
ai-usage: ai-assisted
---

# Recover objects using Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in public preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Recovery restores supported objects to a previously known‑good state using Microsoft Entra Backup and Recovery. It includes restoring, soft‑deleting, and updating supported objects and attributes.

Key details:

- A recovery ID identifies the recovery job.
- Only one recovery runs at a time. If another job (recovery job or difference report) is already running, you must wait for it to complete or cancel it before starting a new one.
- Recovery details are retained in **Recovery History** for the duration of the backup.
- Recovery actions are recorded and can be reviewed in audit logs.

## Prerequisites

To perform recovery, you must have the **Entra Backup Administrator** role assigned.

## Recover from a difference report

Use this method when you already created a difference report and reviewed the changes.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Go to **Backup and recovery** > **Difference reports**. Select a completed difference report.

   :::image type="content" source="media/recover-objects/difference-reports-select.png" alt-text="Screenshot of the Difference Reports page showing three completed reports with available backups.":::

1. After inspecting the objects listed in the difference report, select **Recover** to start recovery.

   :::image type="content" source="media/recover-objects/recover-from-difference-report.png" alt-text="Screenshot of the Recover from difference report dialog showing the list of objects that will be recovered, with the Recover button at the bottom.":::

> [!NOTE]
> If you recover from a difference report that was created with scoping filters, recovery is automatically limited to the same scope and doesn't allow additional filtering. To recover a different set of objects, start from the backups page and run difference report to review changes.

1. (Optional) To recover a single high-priority object without initiating a full recovery job, open the object's changed attributes panel and select **Recover this object**.

   :::image type="content" source="media/recover-objects/recover-single-object.png" alt-text="Screenshot of the View changed attributes panel for a user object, with a confirmation dialog asking to recover the specific object.":::

> [!NOTE]
> Difference reports are a point-in-time comparison. If objects are modified in the tenant after the report is created, those changes aren't reflected in the report. When you recover from a difference report, recovery is applied to the tenant's most current state, which may result in a different set of changes than the difference report.

## Recover directly from a backup

While creating a difference report is recommended to preview changes, you can also recover directly from a backup without first creating a difference report.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Go to **Backup and recovery** > **Backups**. Select a backup and select **Recover backup**.

   :::image type="content" source="media/recover-objects/recover-backup-select.png" alt-text="Screenshot of the Backups page with a backup selected and the Recover backup button visible in the toolbar.":::

1. (Optional) Apply scoping filters to limit the objects included in recovery. Choose one of these options:

   - **Recover all objects in their previous state**: Recovers all supported objects in the tenant.

     :::image type="content" source="media/recover-objects/recover-backup-all-objects.png" alt-text="Screenshot of the Recover backup dialog with the Recover all objects in their previous state option selected and the cursor on the Recover button.":::

   - **Recover only certain types of objects**: Limits recovery to selected object types, such as Users or Conditional Access Policies.

     :::image type="content" source="media/recover-objects/recover-backup-object-types.png" alt-text="Screenshot of the Recover backup dialog with the Recover only certain types of objects option selected, showing Users and Conditional Access Policies in the object type dropdown.":::

   - **Recover only specific objects by their ID**: Limits recovery to specific objects by their object IDs. You can enter up to 100 object IDs across different object types.

     :::image type="content" source="media/recover-objects/recover-backup-object-ids.png" alt-text="Screenshot of the Recover backup dialog with the Recover only specific objects by their ID option selected, showing a list with User and Group object IDs.":::

1. Select **Recover** to start the recovery job.

> [!WARNING]
> Recovery actions are applied directly to your tenant and can't be automatically undone. Review changes in a difference report before starting recovery. Changes done by the recovery job are all audited in audit logs.

## Cancel a recovery

Cancel a recovery job while it's running. Any recovery actions taken before cancelation remain applied.

1. Go to **Backup and recovery** > **Recovery History**.

1. Select the in-progress recovery job, and then select **Cancel**.

   :::image type="content" source="media/recover-objects/cancel-recovery-job.png" alt-text="Screenshot of the Recovery History page showing completed and in-progress recovery jobs, with the Cancel button visible in the toolbar.":::

> [!NOTE]
> - Hard-deleted objects can't be recovered. Use Protected Actions to prevent unwanted hard deletions in your tenant.

## Related content

- [Create and review difference reports](create-review-difference-reports.md)
- [View available backups](view-available-backups.md)

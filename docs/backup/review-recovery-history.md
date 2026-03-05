---
title: Review recovery history
description: Learn how to review recovery operations performed in your tenant using the Recovery History page in Microsoft Entra Backup and Recovery.
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: how-to
ai-usage: ai-assisted
---

# Review recovery history in Microsoft Entra Backup and Recovery (Preview)

The Recovery History page in Microsoft Entra Backup and Recovery provides visibility into recovery operations performed in your tenant. This page helps administrators understand what was recovered, when the recovery occurred, and whether the operation completed successfully or failed.

Recovery history includes:

- The final status of the recovery
- The backup point used for each recovery
- The start and completion time of the recovery
- The number of objects and links modified

Recovery history is intended for recent operational review and troubleshooting. Recovery history data is retained for up to 5 days after the recovery completion time.

## Prerequisites

To view available recovery history in your tenant, you must be assigned at least the **Entra Backup Reader** role.

## Review recovery history

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least **Entra Backup Reader**.

1. In the left navigation pane, select **Recovery History (Preview)** under **Backup and recovery**.

   :::image type="content" source="media/review-recovery-history/recovery-history-page.png" alt-text="Screenshot of the Backup and recovery Recovery History (Preview) page showing two recovery operations with columns for Recovery ID, Status, Backup timestamp, Backup ID, Recovery started, Recovery completed, Modified objects, Modified links, Filtered by, and Backup.":::

   The Recovery History page displays all recent recovery operations for your tenant. You can:

   - View the **Recovery ID** for each operation.
   - Check the **Status**.
   - See the **Backup timestamp** and **Backup ID** used.
   - Review when the recovery started and completed.
   - See how many objects and links were modified.
   - Filter or search recovery records to narrow results.

   :::image type="content" source="media/review-recovery-history/recovery-history-details.png" alt-text="Screenshot of the Recovery History page showing three recovery operations with Status, Backup timestamp, Backup ID, Recovery started, Recovery completed, Modified objects, Modified links, and Filtered by columns.":::

> [!NOTE]
> Recovery history is automatically cleaned up 5 days after recovery completion time.

### Recovery statuses

Recovery operations move through the following statuses as changes are applied to the tenant. These statuses indicate the progress and outcome of the recovery job.

- **Loading data**: The system is loading data from the selected backup to prepare for recovery. If the backup has already been used to create a difference report or a prior recovery, this step might complete quickly.
- **In progress**: The system is applying recovery actions to restore objects from the backup state. The duration of this step depends on the number and type of changes being applied.
- **Completed**: The recovery completed successfully, and all supported changes were applied.
- **Completed with warnings**: The recovery completed, but some changes couldn't be applied. You can review the failed changes to understand which items weren't fully restored and why.
- **Failed**: The recovery couldn't be completed due to an error. Some changes might not have been applied.
- **Canceled**: The recovery was canceled before completion.

## Review failed changes

If a recovery operation partially succeeds, the **Status** column indicates "Completed with Warnings," allowing you to quickly identify objects that weren't recovered.

:::image type="content" source="media/review-recovery-history/recovery-completed-with-warnings.png" alt-text="Screenshot of the Failed recovery changes page showing recovery job details including Recovery job ID, Status Completed, Backup timestamp, Recovery started and completed times, and a table listing the Adele Vance user object with a Restore recovery action, one changed attribute, and Error Code 400.":::

:::image type="content" source="media/review-recovery-history/recovery-warning-details.png" alt-text="Screenshot of the View failed changed attributes flyout for a user object showing Error code 400 with conflict details, and a table comparing the current value and backup value of the deletedDateTime attribute.":::

Use failed recovery entries to:

- Identify which recovery operation and object didn't complete successfully.
- Confirm the backup point that was used.
- View failure details that explain why the recovery didn't succeed.

:::image type="content" source="media/review-recovery-history/failed-recovery-entry.png" alt-text="Screenshot of the Recovery History page with the Filtered By flyout open, showing the Difference Report ID and a filtered Object ID of type User.":::

:::image type="content" source="media/review-recovery-history/failed-recovery-details.png" alt-text="Screenshot of the Recovery History page showing a recovery operation with Completed with Warnings status indicated by a warning triangle icon, alongside other completed recovery operations.":::

> [!NOTE]
> Failed recovery records remain available within the recovery history retention window and are cleaned up 5 days after the recovery completion time.

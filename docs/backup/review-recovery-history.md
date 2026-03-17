---
title: Review recovery history in Microsoft Entra Backup and Recovery
description: Learn how to review recovery operations performed in your tenant using the Recovery History page in Microsoft Entra Backup and Recovery
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: how-to
ai-usage: ai-assisted
---

# Review recovery history in Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in public preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Learn how to review past recovery operations in your tenant by using the Recovery History page in Microsoft Entra Backup and Recovery.

Recovery history includes:

- The final status of the recovery.
- The backup point used for each recovery.
- The start and completion time of the recovery.
- The number of objects and links modified.

Use recovery history for recent operational review and troubleshooting. Recovery history data is retained for up to 5 days after the recovery completion time.

## Prerequisites

To view available recovery history in your tenant, you must sign in with at least the **Microsoft Entra Backup Reader** role.

## Review recovery history

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a **Microsoft Entra Backup Reader**.

1. In the left navigation pane, select **Recovery History (Preview)** under **Backup and recovery**.

   :::image type="content" source="media/review-recovery-history/recovery-history-page.png" alt-text="Screenshot of the Backup and recovery Recovery History (Preview) page showing two recovery operations with columns for Recovery ID, Status, Backup timestamp, Backup ID, Recovery started, Recovery completed, Modified objects, Modified links, Filtered by, and Backup.":::

   The Recovery History page displays all recent recovery operations in your tenant. From this page:

   - View the **Recovery ID** for each operation.
   - Check the **Status**.
   - See the **Backup timestamp** and **Backup ID** used.
   - Review when the recovery started and completed.
   - See how many objects and links the recovery modified.
   - Filter or search recovery records to narrow results.

   :::image type="content" source="media/review-recovery-history/recovery-history-details.png" alt-text="Screenshot of the Recovery History page showing three recovery operations with Status, Backup timestamp, Backup ID, Recovery started, Recovery completed, Modified objects, Modified links, and Filtered by columns.":::

> [!NOTE]
> The system automatically removes recovery history 5 days after recovery completes.

### Recovery statuses

Recovery operations move through these statuses as the system applies changes to the tenant. These statuses indicate the progress and outcome of the recovery job.

- **Loading data**: The system is loading data from the selected backup to prepare for recovery. If you already used the backup to create a difference report or a prior recovery, this step might complete fast.
- **In progress**: The system is applying recovery actions to restore objects to the backup state. The duration of this step depends on the number and type of changes being applied.
- **Completed**: The recovery completed successfully, and the system applied all supported changes.
- **Completed with warnings**: The recovery completed, but some changes couldn't be applied. Review the failed changes to understand which objects weren't restored and why.
- **Failed**: The recovery couldn't be completed due to an error. The system might not have applied some changes.
- **Canceled**: The recovery was canceled before completion.

## Review failed changes

If a recovery operation partially succeeds, the **Status** column shows **Completed with warnings**, allowing you to identify objects that weren't recovered.

:::image type="content" source="media/review-recovery-history/recovery-completed-with-warnings.png" alt-text="Screenshot of the Failed recovery changes page showing recovery job details including Recovery job ID, Status Completed, Backup timestamp, Recovery started and completed times, and a table listing the Adele Vance user object with a Restore recovery action, one changed attribute, and Error Code 400.":::

Select a failed recovery entry to view the details of the failure, including the error code and the changed attributes.

:::image type="content" source="media/review-recovery-history/recovery-warning-details.png" alt-text="Screenshot of the View failed changed attributes flyout for a user object showing Error code 400 with conflict details, and a table comparing the current value and backup value of the deletedDateTime attribute.":::

Use failed recovery entries to:

- Identify which recovery operation and object didn't complete successfully.
- Confirm the backup point that was used.
- View failure details that explain why the recovery didn't succeed.

:::image type="content" source="media/review-recovery-history/failed-recovery-entry.png" alt-text="Screenshot of the Recovery History page with the Filtered By flyout open, showing the Difference Report ID and a filtered Object ID of type User.":::

Select a recovery entry to view the details, including the associated difference report and recovery status.

:::image type="content" source="media/review-recovery-history/failed-recovery-details.png" alt-text="Screenshot of the Recovery History page showing a recovery operation with Completed with Warnings status indicated by a warning triangle icon, alongside other completed recovery operations.":::

> [!NOTE]
> Failed recovery records remain available within the recovery history as long as the backup is available.

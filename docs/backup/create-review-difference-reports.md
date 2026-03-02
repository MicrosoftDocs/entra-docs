---
title: Create and review difference reports in Microsoft Entra Backup
description: Learn how to create and review difference reports to compare the current state of your tenant with a selected backup in Microsoft Entra.
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: how-to
ai-usage: ai-assisted
---

# Create and review difference reports in Microsoft Entra Backup (Preview)

A difference report compares the current state of your tenant with a selected backup and highlights what changed.

Difference reports show objects that were **created, modified, or soft-deleted** after the selected backup was taken, along with details about:

- Changed attributes—properties of the object whose values differ between the backup and the current tenant state.
- Changed links—changes to the object's relationships with other objects, such as group membership.

Key details:

- A difference report ID identifies the comparison/preview job.
- You can create multiple difference reports from the same backup, but only one report can run at a time.
- Difference reports are retained for up to five days after completion.

Create a difference report before starting recovery so you can review and understand the changes in your tenant.

## Prerequisites

To create or review difference reports, you must have the **Entra Backup Reader** role or higher assigned.

## Scope a difference report

When you create a difference report, you can scope it to control which objects are included in the comparison:

- **All supported objects**—Includes all supported object types in the tenant.
- **By object type**—Includes only selected object types.
- **By object ID**—Includes only specific objects by their object IDs. You can specify up to 100 object IDs across supported object types.

Scoping is applied at report creation time and can't be changed after the report is created.

## Create a difference report

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Go to **Backup and recovery** > **Backups**. Select the desired backup from the list and select **Create difference report**.

   :::image type="content" source="media/create-review-difference-reports/create-difference-report-backups-page.png" alt-text="Screenshot of the Backups page in the Microsoft Entra admin center showing a list of available backups with a Create difference report button in the toolbar.":::

1. (Optional) Apply filters to limit the scope of objects included in the report. Choose one of the following options:

   - **Include all objects in their previous state**—compares all supported objects in the tenant.

     :::image type="content" source="media/create-review-difference-reports/create-difference-report-all-objects.png" alt-text="Screenshot of the Create difference report dialog with the Include all objects in their previous state option selected.":::

   - **Include only certain types of objects**—limits the report to selected object types, such as Users and Groups.

     :::image type="content" source="media/create-review-difference-reports/create-difference-report-object-types.png" alt-text="Screenshot of the Create difference report dialog with the Include only certain types of objects option selected and Users, Groups chosen in the object type dropdown.":::

   - **Include only specific objects by their ID**—limits the report to specific objects by their object IDs. You can enter up to 100 object IDs across different object types.

     :::image type="content" source="media/create-review-difference-reports/create-difference-report-object-ids.png" alt-text="Screenshot of the Create difference report dialog with the Include only specific objects by their ID option selected, showing a list of object IDs including Users, Groups, and Named Location Policies.":::

1. Select **Create difference report** to start the report.

   :::image type="content" source="media/create-review-difference-reports/create-difference-report-submit.png" alt-text="Screenshot of the Create difference report dialog with the cursor hovering over the Create difference report button, ready to submit the report.":::

## Cancel a difference report

You can cancel a difference report while it's in progress. Canceled reports don't display partial results. Canceling is useful if the report was initiated by mistake.

1. Go to **Backup and recovery** > **Difference reports**.

1. Select the in-progress report, and then select **Cancel** in the toolbar.

   :::image type="content" source="media/create-review-difference-reports/cancel-difference-report.png" alt-text="Screenshot of the Difference Reports page showing one report in progress and two completed reports, with the Cancel button visible in the toolbar.":::

## Review a difference report

1. Go to **Backup and recovery** > **Difference reports**. The list shows each report's status, the backup used for comparison (including its ID, timestamp, and availability), the scoping criteria, creation and completion times, and the number of objects and links included in the report.

   :::image type="content" source="media/create-review-difference-reports/difference-reports-list.png" alt-text="Screenshot of the Difference Reports list page showing report statuses, backup timestamps, and filtering details for three difference reports.":::

1. Select a completed difference report to open its details.

   :::image type="content" source="media/create-review-difference-reports/difference-reports-completed.png" alt-text="Screenshot of the Difference Reports list page showing three completed reports with available backups, including details on calculated objects and links.":::

1. Review the difference report content. The report lists each object that changed, along with the recovery action that would be applied.

   :::image type="content" source="media/create-review-difference-reports/difference-report-detail-objects.png" alt-text="Screenshot of a completed difference report detail page showing a list of user objects with their recovery actions, changed attributes, and changed links.":::

   The report includes the following information for each object:

   - **Changed attributes**—Select the count in the **Changed Attributes** column to view the attribute differences. The **Report value** column shows the value captured when the difference report was created. The **Backup value** column shows the value as captured in the selected backup.

     :::image type="content" source="media/create-review-difference-reports/difference-report-changed-attributes.png" alt-text="Screenshot of the View changed attributes panel for a user object, showing attribute differences between the current state and backup for accountEnabled, city, and department.":::

   - **Changed links**—Select the count in the **Changed Links** column to view the relationship differences. The **Report state** column shows the relationship as captured when the difference report was created. The **Backup state** column shows the relationship as captured in the selected backup. The **Recovery action** column indicates the action taken to restore the backup state.

     :::image type="content" source="media/create-review-difference-reports/difference-report-changed-links.png" alt-text="Screenshot of the View changed links panel for a group object, showing group membership changes that would be reverted by recovery.":::

   - **Recovery action**—The action that would be applied if the object is recovered. Possible values include **Update** (revert changed attributes on an existing object), **Restore** (restore a soft-deleted object), and **Soft delete** (soft-delete an object that was created after the backup).

     :::image type="content" source="media/create-review-difference-reports/difference-report-recovery-action.png" alt-text="Screenshot of the difference report detail page with the Recovery Action column highlighted, showing Update and Restore actions for each object.":::

> [!NOTE]
> Hard-deleted objects and read-only properties don't appear in difference reports. Objects synced from on-premises can appear in difference reports but aren't recoverable.

## Related content

- [View available backups](view-available-backups.md)
- [Recover objects](recover-objects.md)

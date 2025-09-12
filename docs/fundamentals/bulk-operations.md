---
title: Bulk operations in Microsoft Entra ID (Preview)
description: Learn about the new Microsoft Entra bulk operations experience for managing users, groups, and devices.
author: barclayn
manager: pmwongera
ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 08/18/2025
ms.author: barclayn
ms.custom: it-pro
---

# Bulk operations in Microsoft Entra ID (Preview)

The new bulk operations experience in Microsoft Entra ID provides enhanced capabilities for managing **Groups** and **Devices**. This service enables bulk actions including create, update, and delete operations. The improved service delivers better performance, reduces timeouts, and removes scaling limitations for large tenants.

> [!NOTE] 
> The new bulk operations service currently only supports **Groups**, **Devices**, and **Users** export. Support for additional entities like **Enterprise applications** will be added in a future update. Localization for templates is not supported.

For information about limitations and to learn more about the previous Bulk Operations experience, see [Bulk operations service limitations](bulk-operations-service-limitations.md).

## Bulk download groups

To download all groups in your organization:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab and then **All groups**.

    :::image type="content" source="Media/bulk-operations/groups-management-page.png" alt-text="Screenshot of the Microsoft Entra admin center Groups blade showing the All groups list with column headers and actions.":::

2. Select **Download groups**.

    :::image type="content" source="Media/bulk-operations/download-groups-button.png" alt-text="Screenshot of the Groups page with the Download groups button highlighted in the toolbar.":::

3. Enter a filename and select **Start bulk operation**.

    :::image type="content" source="Media/bulk-operations/download-filename-dialog.png" alt-text="Screenshot of the Download groups dialog prompting for a filename before starting the bulk operation.":::

4. Select the **Click here to view the status of each operation** link to navigate to the **Bulk operations** blade. 

    :::image type="content" source="Media/bulk-operations/success-notification.png" alt-text="Screenshot of a success notification confirming the bulk groups download was submitted with a link to view status.":::

5. Select the filename to download the CSV file containing all groups with the specified columns.

## Download filtered groups

To download a filtered subset of groups:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

2. Select **Manage filters** to edit the column filters.

    :::image type="content" source="Media/bulk-operations/filters-download-groups.png" alt-text="Screenshot of the Manage filters panel on the Groups page with filters applied and the Download groups action available.":::

3. Select **Download groups**.

4. Follow steps 3-5 from [Bulk download groups](#bulk-download-groups).

## Bulk download group members

To download all members of a specific group:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

2. Select a group from the list and navigate to the **Members** tab.

    :::image type="content" source="Media/bulk-operations/group-members-tab.png" alt-text="Screenshot of a selected group’s Members tab listing users and service principals.":::

3. Select **Bulk operations** > **Download members**.

    :::image type="content" source="Media/bulk-operations/bulk-operations-download-members.png" alt-text="Screenshot of the Bulk operations menu on the Members tab with Download members selected.":::

4. Enter a filename and select **Start download**.

5. Follow the download process as described in [Bulk download groups](#bulk-download-groups).

## Bulk import group members in Microsoft Entra ID

To add multiple members to a group:


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

2. Select a group from the list and navigate to the **Members** tab.

3. Select **Bulk operations** > **Import members**.

    :::image type="content" source="Media/bulk-operations/members-bulk-operations-import.png" alt-text="Screenshot of the Bulk operations menu on the Members tab with Import members selected.":::

4. Download the csv template (optional). Rename the ID column name to **ObjectId** and delete the remainder of columns. Add Object IDs for the members you want to import. Upload your csv file with only the **ObjectId** column. Note: You can add valid or invalid Object IDs. 

    :::image type="content" source="Media/bulk-operations/template-download-object-ids.png" alt-text="Screenshot of the CSV template for importing members showing the ObjectId column for pasting member IDs.":::

5. Upload the completed CSV file and select **Submit**.

6. Monitor the notification for job completion. Select the **Success!** link to view the operation status. 

>[!IMPORTANT]
> If you add invalid Object IDs in the uploaded csv file, the bulk operation status shows **Failed** with reason **NotAllRowsSuccessfullyProcessed**. You can select on the filename to download a detailed report showing the status of each object ID.


## Bulk remove group members 

To remove multiple members from a group:

1. Follow steps 1-2 from [Bulk download group members](#bulk-download-group-members).

2. Select **Bulk operations** > **Remove members**.

    :::image type="content" source="Media/bulk-operations/members-bulk-operations-remove.png" alt-text="Screenshot of the Bulk operations menu on the Members tab with Remove members selected.":::

3. Download the csv template (optional). Rename the ID column name to **ObjectId** and delete the remainder of columns. Add Object IDs for the members you want to import. Upload your csv file with only the **ObjectId** column. Note: You can add valid or invalid Object IDs. 



4. Upload the completed CSV file and select **Submit**.

    :::image type="content" source="Media/bulk-operations/bulk-remove-group-csv.png" alt-text="Screenshot of the sample CSV for removing members containing ObjectId values to be processed.":::

5. Monitor the notification for job completion. Select the **Success!** link to view the operation status.

6. If the operation shows **Failed** status with reason **NotAllRowsSuccessfullyProcessed**, select the filename to download a detailed report showing the status of each object ID.

7. Verify that the specified members were removed from the group.

## Delete bulk jobs

To delete completed or failed bulk operations:

1. Navigate to the [Bulk Operations (Preview)](https://entra.microsoft.com/?feature.tokencaching=true&feature.internalgraphapiversion=true&enableNewBulkJobsExport=true&enableNewBulkJobsList=true#view/Microsoft_AAD_IAM/BulkJobsList.ReactView) page.

   :::image type="content" source="Media/bulk-operations/bulk-jobs.png" alt-text="Screenshot of the Bulk operations page listing recent bulk jobs with status, type, and timestamp columns.":::

2. Select the bulk job you want to delete.

3. Select **Delete**.

    :::image type="content" source="Media/bulk-operations/delete-bulk-job.png" alt-text="Screenshot of a selected bulk job on the Bulk operations page with the Delete button visible.":::

4. Confirm the deletion. The deleted job is removed from the list.

    :::image type="content" source="Media/bulk-operations/delete-bulk-job-notification.png" alt-text="Screenshot of a confirmation notification indicating the bulk job was deleted successfully.":::     


## Devices scenario steps

1. Go to the **All devices** blade.

    :::image type="content" source="Media/bulk-operations/all-devices.png" alt-text="Screenshot of the All devices blade in Microsoft Entra admin center showing the devices list.":::

2. Select **Download devices**.

    :::image type="content" source="Media/bulk-operations/all-devices-bulk-operations.png" alt-text="Screenshot of the All devices page with Bulk operations open and the Download devices option selected.":::

3. Enter a filename that matches your naming convention and select **Start download**.
    :::image type="content" source="Media/bulk-operations/all-devices-success.png" alt-text="Screenshot of a success notification after starting the Download devices job.":::

4. Verify the notification message and, if the job was submitted successfully, select the **Success!** or **File is ready! Click here to download** link.

    :::image type="content" source="Media/bulk-operations/all-devices-bulk-operations-result.png" alt-text="Screenshot of the Bulk operations page showing a completed Download devices job with a File is ready link to download the CSV.":::

5. Select the filename for the bulk job you created to download the CSV file. Verify the CSV contains all devices with the columns you selected when the bulk job was created.

You can bulk export users following the steps in [Download a list of users in Microsoft Entra admin center](~/identity/users/users-bulk-download.md).


## Related content

- [Bulk operations service limitations](bulk-operations-service-limitations.md)
- [Add or remove group members using Microsoft Entra ID](how-to-manage-groups.yml)
- [Bulk create users in Microsoft Entra ID](../identity/users/users-bulk-add.md)

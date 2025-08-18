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
> The new bulk operations service currently only supports **Groups**, **Devices**, and **Users** export. Support for additional entities like **Enterprise applications** will be added in a future update.

For information about limitations and to learn more about the previous Bulk Operations experience, see [Bulk operations service limitations](bulk-operations-service-limitations.md).

## Bulk download groups

To download all groups in your organization:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

    :::image type="content" source="Media/bulk-operations/groups-management-page.png" alt-text="Screenshot of the Microsoft Entra ID Groups management page showing the all groups view.":::

2. Select **Download groups**.

    :::image type="content" source="Media/bulk-operations/download-groups-button.png" alt-text="Screenshot of the Download groups button in the Microsoft Entra ID Groups interface.":::

3. Enter a filename and select **Start bulk operation**.

    :::image type="content" source="Media/bulk-operations/download-filename-dialog.png" alt-text="Screenshot of the download filename dialog box for bulk groups download.":::

4. Select the **Click here to view the status of each operation** link to navigate to the **Bulk operations** blade. 

    :::image type="content" source="Media/bulk-operations/success-notification.png" alt-text="Screenshot of the success notification message for bulk groups download operation.":::

5. Select the filename to download the CSV file containing all groups with the specified columns.

## Download filtered groups

To download a filtered subset of groups:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

2. Select **Manage filters** to edit the column filters.

    :::image type="content" source="Media/bulk-operations/filters-download-groups.png" alt-text="Screenshot of the filters interface with download groups option in Microsoft Entra ID.":::

3. Select **Download groups**.

4. Follow steps 3-5 from [Bulk download groups](#bulk-download-groups).

## Bulk download group members

To download all members of a specific group:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

2. Select a group from the list and navigate to the **Members** tab.

    :::image type="content" source="Media/bulk-operations/group-members-tab.png" alt-text="Screenshot of the group members tab in Microsoft Entra ID group management.":::

3. Select **Bulk operations** > **Download members**.

    :::image type="content" source="Media/bulk-operations/bulk-operations-download-members.png" alt-text="Screenshot of the bulk operations menu with download members option selected.":::

4. Enter a filename and select **Start download**.

5. Follow the download process as described in [Bulk download groups](#bulk-download-groups).

## Bulk import group members in Microsoft Entra ID

To add multiple members to a group:


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

2. Select a group from the list and navigate to the **Members** tab.

3. Select **Bulk operations** > **Import members**.

    :::image type="content" source="Media/bulk-operations/bulk-operations.png" alt-text="Screenshot of the import members option in bulk operations interface.":::

4. Download the csv template (optional). Rename the ID column name to **ObjectId** and delete the remainder of columns. Add Object IDs for the members you want to import. Upload your csv file with only the **ObjectId** column. Note: You can add valid or invalid Object IDs. 

    :::image type="content" source="Media/bulk-operations/template-download-object-ids.png" alt-text="Screenshot of the template download interface with object IDs input fields.":::

5. Upload the completed CSV file and select **Submit**.

6. Monitor the notification for job completion. Select the **Success!** link to view the operation status. 

>[!IMPORTANT]
> If you add invalid Object IDs in the uploaded csv file, the bulk operation status shows **Failed** with reason **NotAllRowsSuccessfullyProcessed**. You can select on the filename to download a detailed report showing the status of each object ID.


## Bulk remove group members 

To remove multiple members from a group:

1. Follow steps 1-2 from [Bulk download group members](#bulk-download-group-members).

2. Select **Bulk operations** > **Remove members**.

    :::image type="content" source="Media/bulk-operations/bulk-operations.png" alt-text="Screenshot of the bulk operations menu with remove members option selected.":::

3. Download the csv template (optional). Rename the ID column name to **ObjectId** and delete the remainder of columns. Add Object IDs for the members you want to import. Upload your csv file with only the **ObjectId** column. Note: You can add valid or invalid Object IDs. 



4. Upload the completed CSV file and select **Submit**.

    :::image type="content" source="Media/bulk-operations/bulk-remove-group-csv.png" alt-text="Screenshot of the template with object IDs for member removal operation.":::

5. Monitor the notification for job completion. Select the **Success!** link to view the operation status.

6. If the operation shows **Failed** status with reason **NotAllRowsSuccessfullyProcessed**, select the filename to download a detailed report showing the status of each object ID.

7. Verify that the specified members have been removed from the group.

## Delete bulk jobs

To delete completed or failed bulk operations:

1. Navigate to the [Bulk Operations (Preview)](https://entra.microsoft.com/?feature.tokencaching=true&feature.internalgraphapiversion=true&enableNewBulkJobsExport=true&enableNewBulkJobsList=true#view/Microsoft_AAD_IAM/BulkJobsList.ReactView) page.

   :::image type="content" source="Media/bulk-operations/bulk-jobs.png" alt-text="Screenshot of the bulk operations result page.":::

2. Select the bulk job you want to delete.

3. Select **Delete**.

    :::image type="content" source="Media/bulk-operations/delete-bulk-job.png" alt-text="Screenshot of the bulk operations result page with delete button for removing bulk jobs.":::

4. Confirm the deletion. The deleted job is removed from the list.

    :::image type="content" source="Media/bulk-operations/delete-bulk-job-notification.png" alt-text="Screenshot of the bulk operations list with notification of the successful deletion.":::     


## User Scenario Steps (Devices)

1. Go to the **All devices** blade.

    :::image type="content" source="Media/bulk-operations/all-devices.png" alt-text="Screenshot of the bulk operations list with notification of the successful deletion.":::

2. Select **Download devices**.

    :::image type="content" source="Media/bulk-operations/all-devices-bulk-operations.png" alt-text="Screenshot of the all devices export page.":::

3. Enter a filename that matches your naming convention and select **Start download**.
    :::image type="content" source="Media/bulk-operations/all-devices-success.png" alt-text="Screenshot of the bulk operations list with notification of the successful job completion.":::

4. Verify the notification message and, if the job was submitted successfully, select the **Success!** or **File is ready! Click here to download** link.

    :::image type="content" source="Media/bulk-operations/all-devices-bulk-operations-result.png" alt-text="Screenshot of the bulk operations list with notification of the successful job completion.":::

5. Select the filename for the bulk job you created to download the CSV file. Verify the CSV contains all devices with the columns you selected when the bulk job was created.

You can bulk export users following the steps in [Download a list of users in Microsoft Entra admin center](users-bulk-download.md).

[**Download a list of users in the Microsoft Entra admin center - Microsoft Entra ID \| Microsoft Learn**](https://review.learn.microsoft.com/en-us/entra/identity/users/users-bulk-download?branch=pr-en-us-9303)
       
    
## Related content

- [Bulk operations service limitations](bulk-operations-service-limitations.md)
- [Add or remove group members using Microsoft Entra ID](how-to-manage-groups.yml)
- [Bulk create users in Microsoft Entra ID](../identity/users/users-bulk-add.md)
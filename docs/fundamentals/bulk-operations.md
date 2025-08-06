---
title: Bulk operations in Microsoft Entra ID (Preview)
description: Learn about the new Microsoft Entra bulk operations experience  related to users, groups
author: barclayn
manager: pmwongera
ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 08/05/2025
ms.author: barclayn
ms.custom: it-pro
---


# Bulk operations in Microsoft Entra ID (Preview)

The new Bulk Operations in Microsoft Entra ID offer an enhanced experience for managing **Groups** and **Devices**, enabling bulk actions such as create, update, and delete. This streamlined service improves performance, reduces timeouts, and removes scaling limitations—especially for large tenants.

>[!NOTE] 
> Currently, the new Bulk Operations service supports **Groups** and **Devices** only. Support for additional entities such as **Users**,
**Applications**, and more is coming soon.

[Previous Bulk Operations experience](bulk-operations-service-limitations.md)


## Bulk download a list of groups in Microsoft Entra ID

- Go to [GroupsManagementMenuBlade](https://entra.microsoft.com/?feature.tokencaching=true&feature.internalgraphapiversion=true&enableNewBulkJobsExport=true&enableNewBulkJobsList=true#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups/menuId/AllGroups)

    :::image type="content" source="Media/bulk-operations/groups-management-page.png" alt-text="Screenshot of the Microsoft Entra ID Groups management page showing the all groups view":::

- Click on Download groups

    :::image type="content" source="Media/bulk-operations/download-groups-button.png" alt-text="Screenshot of the Download groups button in the Microsoft Entra ID Groups interface":::

- Change filename as per your liking (please include your alias to uniquely identify) and click on start download.

    :::image type="content" source="Media/bulk-operations/download-filename-dialog.png" alt-text="Screenshot of the download filename dialog box for bulk groups download":::

- Verify notification message and if the job gets submitted successfully. Click on the "Success!" or "File is ready! Click here to download" link as shown above to get the file.

    :::image type="content" source="Media/bulk-operations/success-notification.png" alt-text="Screenshot of the success notification message for bulk groups download operation":::

- Click on File name for the bulk job you created. It will download a csv file with all groups. Verify the csv contains all groups with desired columns included when bulk job was created.

## Add filters and then download groups

Follow first 2 steps from "[Bulk download group members](#bulk-download-group-members)"

-   Select appropriate filters and click on download groups.

    :::image type="content" source="Media/bulk-operations/filters-download-groups.png" alt-text="Screenshot of the filters interface with download groups option in Microsoft Entra ID":::

-   Rest of the steps same as "Download Group members in Entra ID".

## Bulk download group members


-   Go to [GroupsManagementMenuBlade](https://entra.microsoft.com/?feature.tokencaching=true&feature.internalgraphapiversion=true&enableNewBulkJobsExport=true&enableNewBulkJobsList=true#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups/menuId/AllGroups)

-   Click on any group from the list and go to the **members** tab.

    :::image type="content" source="Media/bulk-operations/group-members-tab.png" alt-text="Screenshot of the group members tab in Microsoft Entra ID group management":::

-   Click on Bulk operations -\> Download members

    :::image type="content" source="Media/bulk-operations/bulk-operations-download-members.png" alt-text="Screenshot of the bulk operations menu with download members option selected":::

-   Type appropriate name and click on Start download.

-   Rest of the steps same as "Download Group members in Entra ID".

## Bulk add group members in Entra ID

Follow first 2 steps from "[Bulk download group members](#bulk-download-group-members)"

-   Click on Import members from bulk operations

    :::image type="content" source="Media/bulk-operations/import-members-bulk-operations.png" alt-text="Screenshot of the import members option in bulk operations interface":::

-   Download the template and add Object ids to the template. You can add valid as well as invalid Object ids.

-   :::image type="content" source="Media/bulk-operations/template-download-object-ids.png" alt-text="Screenshot of the template download interface with object IDs input fields":::

    Here's the sample input file used: [test-groups-successful-case.xlsx](https://microsoft-my.sharepoint-df.com/:x:/p/nukulkarni/Ebp7Lo309FtNkufNGOFiBB0B2skDAbzxhmGakitazYl2AA?e=2mKEbE&nav=MTVfezY2MTNENzNDLUNBMTEtNENBRi04MzlDLUFBNUVCRTlEOENCNH0)

-   Please verify notification message and if the job gets submitted successfully. Click on the "Success!" link from notification and wait until the bulk job is completed successfully.

-   Note that if you have added invalid Object ids in the input the bulk operation status will be "Failed" with reason "NotAllRowsSuccessfullyProcessed". You can click on File name and check status of individual object id from downloaded csv.

    :::image type="content" source="Media/bulk-operations/bulk-operation-failed-status.png" alt-text="Screenshot of the bulk operation failed status with NotAllRowsSuccessfullyProcessed message":::

## Bulk remove group members in Microsoft Entra ID

Follow first 2 steps from "[Bulk download group members](#bulk-download-group-members)"

-   Click on Bulk operations -\> Remove members

    :::image type="content" source="Media/bulk-operations/remove-members-bulk-operations.png" alt-text="Screenshot of the bulk operations menu with remove members option selected":::

-   Download the template and add Object ids to the template. You can add valid as well as invalid Object ids. :::image type="content" source="Media/bulk-operations/template-object-ids-removal.png" alt-text="Screenshot of the template with object IDs for member removal operation":::

-   Please verify notification message and if the job gets submitted successfully. Click on the "Success!" link from notification and wait until the bulk job is completed successfully.

-   Note that if you have added invalid Object ids in the input the bulk operation status will be "Failed" with reason "NotAllRowsSuccessfullyProcessed". You can click on File name and check status of individual object id from downloaded csv.

    :::image type="content" source="Media/bulk-operations/failed-status-remove-operation.png" alt-text="Screenshot of the failed status for bulk remove operation with error details":::

-   Please verify if the correct object ids are removed from the group successfully.

## Delete bulk job in Microsoft Entra ID

    Steps:

-   Go to the [Bulk Operations(Preview)](https://entra.microsoft.com/?feature.tokencaching=true&feature.internalgraphapiversion=true&enableNewBulkJobsExport=true&enableNewBulkJobsList=true#view/Microsoft_AAD_IAM/BulkJobsList.ReactView) blade.

-   Select bulk job you wish to delete and click on Delete button.

    :::image type="content" source="Media/bulk-operations/delete-bulk-job.png" alt-text="Screenshot of the bulk operations list with delete button for removing bulk jobs":::

-   Confirm the deletion and verify if the selected bulk job is deleted and should be removed from the list of existing bulk jobs.

## Related articles

- [Bulk operations service limitations](bulk-operations-service-limitations.md)
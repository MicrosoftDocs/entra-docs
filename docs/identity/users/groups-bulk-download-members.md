---
title: Bulk download group membership list - Azure portal
description: Download group members in bulk in the Microsoft Entra admin center.
ms.date: 12/05/2025
ms.topic: how-to
ms.custom: it-pro
ms.reviewer: yuan.karppanen
---

# Bulk download group members in Microsoft Entra ID


## Overview

You can bulk download the members of a group in your organization to a comma-separated values (CSV) file from the Microsoft Entra admin center. All admins and nonadmin users can download group membership lists.

## Bulk download group members

To download all members of a specific group:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

1. Select a group from the list and navigate to the **Members** tab.

    :::image type="content" source="media/bulk-operations/group-members-tab.png" alt-text="Screenshot of a selected group's Members tab listing users and service principals.":::

1. On the **Members** page command bar, select **Download members**.
    If you see a **Bulk operations** menu instead, select **Bulk operations** > **Download members**.

    :::image type="content" source="media/bulk-operations/bulk-operations-download-members.png" alt-text="Screenshot of the Bulk operations menu on the Members tab with Download members selected.":::

1. Enter a filename and select **Start bulk operation**.

1. A **Success!** notification appears when the job is submitted. The notification says "Bulk operation download group members submission successful. Click on the title for more information."

1. Select the **Success!** notification title to open the job details. Select the filename to start downloading the CSV file.

1. A **Download successful** notification confirms when the file has been downloaded. You can also select **More activity in the audit log** at the top of the Notifications panel to view all bulk operation activity.

> [!TIP]
> You can also select **Click here to view the status of each operation** in the download dialog to navigate directly to the **Bulk operation results** page, where you can monitor all pending and completed bulk operations.

### Downloaded CSV file format

The downloaded CSV file contains the following information for each group member:

| Column | Description |
|--------|-------------|
| Object ID | The unique identifier (GUID) of the member |
| User principal name | The UPN (for example, `user@contoso.com`) for user members |
| Display name | The display name of the member |
| Member type | Whether the member is a User, Group, or Service Principal |

> [!TIP]
> You can use the downloaded CSV file as a starting point when you need to remove members from a group. Simply edit the file to include only the members you want to remove, then upload it using the **Remove members** bulk operation.

If you experience errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error.

## Check download status

[!INCLUDE [bulk-operations-check-status](~/includes/bulk-operations-check-status.md)]

1. Navigate to **Identity** > **Users** > **Bulk operation results**.
1. Find your download operation in the list.
1. When **Status** shows **Completed**, select the filename to download the CSV file.

    :::image type="content" source="./media/groups-bulk-download-members/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page." lightbox="./media/groups-bulk-download-members/bulk-center.png":::

## Bulk download service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk import group members](groups-bulk-import-members.md)
- [Bulk remove group members](groups-bulk-remove-members.md)

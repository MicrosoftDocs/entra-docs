---
title: Bulk download group membership list
description: Download all members of a group to a CSV file from the Microsoft Entra admin center.

author: barclayn
ms.author: barclayn
manager: pmwongera
ms.date: 12/05/2025
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.custom: it-pro
ms.reviewer: yuan.karppanen
---

# Bulk download group members in Microsoft Entra ID

You can bulk download the members of a group in your organization to a comma-separated values (CSV) file from the Microsoft Entra admin center. All admins and nonadmin users can download group membership lists.

## Bulk download group members

To download all members of a specific group:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.

2. Select a group from the list and navigate to the **Members** tab.

    :::image type="content" source="media/bulk-operations/group-members-tab.png" alt-text="Screenshot of a selected group's Members tab listing users and service principals.":::

3. Select **Bulk operations** > **Download members**.

    :::image type="content" source="media/bulk-operations/bulk-operations-download-members.png" alt-text="Screenshot of the Bulk operations menu on the Members tab with Download members selected.":::

4. Enter a filename and select **Start bulk operation**.

5. A notification appears when the job is submitted. You can select **Click here to view the status of each operation** to navigate to the **Bulk operation results** page, or wait for the success notification.

6. When the notification shows **Success!**, select the notification title to view details and download your CSV file. Alternatively, check the **Bulk operation results** page for completed downloads.

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

You can see the status of all of your pending bulk requests on the **Bulk operation results** page.

1. Navigate to **Identity** > **Users** > **Bulk operation results**.
2. Find your download operation in the list.
3. When **Status** shows **Completed**, select the filename to download the CSV file.

:::image type="content" source="./media/groups-bulk-download-members/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page." lightbox="./media/groups-bulk-download-members/bulk-center.png":::

## Bulk download service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk import group members](groups-bulk-import-members.md)
- [Bulk remove group members](groups-bulk-remove-members.md)

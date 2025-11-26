---
title: Bulk download group membership list - Azure portal
description: Add users in bulk in the Azure admin center.

author: barclayn
ms.author: barclayn
manager: pmwongera
ms.date: 12/19/2024
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

4. Enter a filename and select **Start download**.

5. Follow the download process as described in [Bulk download groups](groups-bulk-download.md#bulk-download-groups).

If you experience errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error. The file submission must match the provided template and include the exact column names. For more information about bulk operations limitations, see [Bulk download service limits](#bulk-download-service-limits).

## Check download status

You can see the status of all of your pending bulk requests on the **Bulk operation results** page.

:::image type="content" source="./media/groups-bulk-download-members/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page." lightbox="./media/groups-bulk-download-members/bulk-center.png":::

## Bulk download service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk import group members](groups-bulk-import-members.md)
- [Bulk remove group members](groups-bulk-remove-members.md)

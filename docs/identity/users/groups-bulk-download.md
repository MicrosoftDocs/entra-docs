---
title: Download a list of groups in the Azure portal
description: Download group properties in bulk in the Azure admin center in Microsoft Entra ID.
author: barclayn
ms.author: barclayn
manager: pmwongera
ms.date: 12/19/2024
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.custom: it-pro, sfi-image-nochange
ms.reviewer: jeffsta
---

# Bulk download groups in Microsoft Entra ID

You can download a list of all the groups in your organization to a comma-separated values (CSV) file in the portal for Microsoft Entra ID. All admins and nonadmin users can download group lists.

## Bulk download groups

To download all groups in your organization:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab and then **All groups**.

    :::image type="content" source="media/bulk-operations/groups-management-page.png" alt-text="Screenshot of the Microsoft Entra admin center Groups blade showing the All groups list with column headers and actions.":::

2. Select **Download groups**.

    :::image type="content" source="media/bulk-operations/download-groups-button.png" alt-text="Screenshot of the Groups page with the Download groups button highlighted in the toolbar.":::

3. Enter a filename and select **Start bulk operation**.

    :::image type="content" source="media/bulk-operations/download-filename-dialog.png" alt-text="Screenshot of the Download groups dialog prompting for a filename before starting the bulk operation.":::

4. Select the **Click here to view the status of each operation** link to navigate to the **Bulk operations** blade.

    :::image type="content" source="media/bulk-operations/success-notification.png" alt-text="Screenshot of a success notification confirming the bulk groups download was submitted with a link to view status.":::

5. Select the filename to download the CSV file containing all groups with the specified columns.

## Download filtered groups

To download a filtered subset of groups:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and in the left-hand navigation pane, select the **Groups** tab.
2. Select **Manage filters** to edit the column filters.
3. Select **Download groups**.
4. Follow steps 3-5 from [Bulk download groups](#bulk-download-groups).

> [!NOTE]
> When filtering groups, only the selected columns appear in the CSV file after editing filters.

If you experience errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error. The file submission must match the provided template and include the exact column names. For more information about bulk operations limitations, see [Bulk download service limits](#bulk-download-service-limits).

## Check download status

You can see the status of all your pending bulk requests on the **Bulk operation results** page.

:::image type="content" source="./media/groups-bulk-download/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page." lightbox="./media/groups-bulk-download/bulk-center.png":::

## Bulk download service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk remove group members](groups-bulk-remove-members.md)
- [Download members of a group](groups-bulk-download-members.md)

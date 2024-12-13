---
title: Bulk download group membership list - Azure portal
description: Add users in bulk in the Azure admin center.

author: barclayn
ms.author: barclayn
manager: amycolannino
ms.date: 07/01/2024
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.custom: it-pro
ms.reviewer: yuan.karppanen
---

# Bulk download members of a group in Microsoft Entra ID

You can bulk download the members of a group in your organization to a comma-separated values (CSV) file from the Microsoft Entra admin center. All admins and nonadmin users can download group membership lists.

## Bulk download group membership

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups**.
1. Open the group whose membership you want to download, and then select **Members**.
1. On the **Members** page, select **Bulk operations** and choose **Download members** to download a CSV file that lists the group members.

   :::image type="content" source="./media/groups-bulk-download-members/download-panel.png" alt-text="Screenshot that shows the Download Members command is on the profile page for the group.":::

If you experience errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error. The file submission must match the provided template and include the exact column names. For more information about bulk operations limitations, see [Bulk download service limits](#bulk-download-service-limits).

## Check download status

You can see the status of all of your pending bulk requests on the **Bulk operation results** page.

:::image type="content" source="./media/groups-bulk-download-members/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page." lightbox="./media/groups-bulk-download-members/bulk-center.png":::

## Bulk download service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk import group members](groups-bulk-import-members.md)
- [Bulk remove group members](groups-bulk-download-members.md)

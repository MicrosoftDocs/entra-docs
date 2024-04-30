---
title: Bulk download group membership list - Azure portal
description: Add users in bulk in the Azure admin center.

author: barclayn
ms.author: barclayn
manager: amycolannino
ms.date: 09/06/2023
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.custom: it-pro
ms.reviewer: yuan.karppanen
---

# Bulk download members of a group in Microsoft Entra ID

You can bulk download the members of a group in your organization to a comma-separated values (CSV) file from the Microsoft Entra admin center. All admins and nonadmin users can download group membership lists.

## Bulk download group membership

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups**.
1. Open the group whose membership you want to download, and then select **Members**.
1. On the **Members** page, select **Bulk operations** and choose **Download members** to download a CSV file that lists the group members.

   :::image type="content" source="./media/groups-bulk-download-members/download-panel.png" alt-text="Screenshot that shows the Download Members command is on the profile page for the group.":::

[!INCLUDE [Bulk update warning](~/includes/bulk-export.md)]

## Check download status

You can see the status of all of your pending bulk requests on the **Bulk operation results** page.

:::image type="content" source="./media/groups-bulk-download-members/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page." lightbox="./media/groups-bulk-download-members/bulk-center.png":::

## Bulk download service limits

Each bulk activity to download a list of group members can run for up to one hour. This time frame enables you to download a list of at least 500,000 members.

## Next steps

- [Bulk import group members](groups-bulk-import-members.md)
- [Bulk remove group members](groups-bulk-download-members.md)

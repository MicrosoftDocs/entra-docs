---
title: Download a list of groups in the Azure portal
description: Download group properties in bulk in the Azure admin center in Microsoft Entra ID.
author: barclayn
ms.author: barclayn
manager: femila
ms.date: 12/19/2024
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.custom: it-pro, sfi-image-nochange
ms.reviewer: jeffsta
---

# Bulk download a list of groups in Microsoft Entra ID

You can download a list of all the groups in your organization to a comma-separated values (CSV) file in the portal for Microsoft Entra ID. All admins and nonadmin users can download group lists.

## Download a list of groups


The columns downloaded are predefined.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups** > **Download groups**.

      :::image type="content" source="./media/groups-bulk-download/download-groups.png" alt-text="Screenshot of the All groups page with Download groups selected.":::

1. On the **Groups download** page, select **Start** to receive a CSV file that lists your groups.

   :::image type="content" source="./media/groups-bulk-download/bulk-download.png" alt-text="Screenshot that shows the Download groups command is on the All groups page.":::

If you experience errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error. The file submission must match the provided template and include the exact column names. For more information about bulk operations limitations, see [Bulk download service limits](#bulk-download-service-limits).

## Check download status

You can see the status of all your pending bulk requests on the **Bulk operation results** page.

:::image type="content" source="./media/groups-bulk-download/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page." lightbox="./media/groups-bulk-download/bulk-center.png":::

## Bulk download service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk remove group members](groups-bulk-remove-members.md)
- [Download members of a group](groups-bulk-download-members.md)

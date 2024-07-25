---
title: Bulk upload to add or create members of a group
description: Add group members in bulk by using a comma-separated values (CSV) file.

author: barclayn
ms.author: barclayn
manager: amycolannino
ms.date: 07/01/2024
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.custom: it-pro
ms.reviewer: jeffsta
---

# Bulk add group members in Microsoft Entra ID

You can add multiple members to a group by using a comma-separated values (CSV) file to bulk import group members in the portal for Microsoft Entra ID.

## Understand the CSV template

Download and fill in the bulk upload CSV template to successfully add Microsoft Entra group members in bulk. Your CSV template might look like this example:

:::image type="content" source="./media/groups-bulk-import-members/template-with-callouts.png" alt-text="Screenshot that shows the spreadsheet for upload and call-outs explaining the purpose and values for each row and column.":::

### CSV template structure

The rows in a downloaded CSV template are:

- **Version number**: The first row that contains the version number must be included in the upload CSV.
- **Column headings**: The format of the column headings is &lt;*Item name*&gt; [PropertyName] &lt;*Required or blank*&gt;. An example is `Member object ID or user principal name [memberObjectIdOrUpn] Required`. Some older versions of the template might have slight variations. For group membership changes, you can choose the member object ID or the user principal name.
- **Examples row**: The template includes a row of examples of acceptable values for each column. You must remove the examples row and replace it with your own entries.

### More guidance

- The first two rows of the upload template must not be removed or modified or the upload can't be processed.
- The required columns are listed first.
- We don't recommend adding new columns to the template. Any other columns you add are ignored and not processed.
- We recommend that you download the latest version of the CSV template as often as possible.
- Add at least two users' UPNs or object IDs to successfully upload the file.

## Bulk import group members

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.
   >[!NOTE]
   >Group owners can also bulk import members of groups they own.
1. Select **Groups** > **All groups**.
1. Open the group to which you're adding members and then select **Members**.
1. On the **Members** page, select **bulk operations** and then choose **Import members**.
1. On the **Bulk import group members** page, select **Download** to get the CSV file template with required group member properties.

    :::image type="content" source="./media/groups-bulk-import-members/import-panel.png" alt-text="Screenshot that shows the Import Members command is on the profile page for the group.":::

1. Open the CSV file and add a line for each group member you want to import into the group. Required values are either **Member object ID** or **User principal name**. Then save the file.

    :::image type="content" source="./media/groups-bulk-import-members/csv-file.png" alt-text="Screenshot that shows the CSV file contains names and IDs of the members to import.":::

1. On the **Bulk import group members** page, under **Upload your csv file**, browse to the file. When you select the file, validation of the CSV file starts.
1. When the file contents are validated, the bulk import page displays **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that imports the group members to the group.
1. When the import operation finishes, a notification states that the bulk operation succeeded.

If you experience errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error. The file submission must match the provided template and include the exact column names. For more information about bulk operations limitations, see [Bulk import service limits](#bulk-import-service-limits).

## Check import status

You can see the status of all your pending bulk requests on the **Bulk operation results** page.

:::image type="content" source="./media/groups-bulk-import-members/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page.":::

For details about each line item within the bulk operation, select the values under the **# Success**, **# Failure**, or **Total Requests** columns. If failures occurred, the reasons for failure are listed.

## Bulk import service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk remove group members](groups-bulk-remove-members.md)
- [Download members of a group](groups-bulk-download-members.md)
- [Download a list of all groups](groups-bulk-download.md)

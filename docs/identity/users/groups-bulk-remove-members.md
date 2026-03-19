---
title: Bulk remove group members by uploading a CSV file
description: Remove group members in bulk operations by using a comma-separated values (CSV) file.
ms.date: 12/05/2025
ms.topic: how-to
ms.custom: it-pro, sfi-image-nochange
ms.reviewer: jeffsta
---

# Bulk remove group members in Microsoft Entra ID

You can remove a large number of members from a group by using a comma-separated values (CSV) file in the portal for Microsoft Entra ID.

## Understand the CSV template

Download and fill in the bulk upload CSV template to successfully remove Microsoft Entra group members in bulk. Your CSV template might look like this example:

:::image type="content" source="./media/groups-bulk-remove-members/template-example.png" alt-text="Screenshot that shows the spreadsheet for upload and call-outs explaining the purpose and values for each row and column.":::

### CSV template structure

The rows in a downloaded CSV template are:

- **Column headings**: The format of the column headings is &lt;*Item name*&gt; [PropertyName] &lt;*Required or blank*&gt;. An example is `Member object ID or user principal name [memberObjectIdOrUpn] Required`. Some older versions of the template might have slight variations. For group membership changes, you can use either the member object ID or the user principal name (UPN).
- **Examples row**: The template includes a row of example values (for example, `Example: 9832aad8-e4fe-496b-a604-95c6eF01ae75`). You must remove the examples row and replace it with your own entries.

[!INCLUDE [bulk-operations-csv-template-note](~/includes/bulk-operations-csv-template-note.md)]

### More guidance

[!INCLUDE [bulk-operations-csv-guidance](~/includes/bulk-operations-csv-guidance.md)]

- Enter one member per row. Don't use semicolons or other delimiters to separate multiple members in a single row.

### Example CSV file

Here's an example of a completed CSV file ready for upload:

```csv
Member object ID or user principal name [memberObjectIdOrUpn] Required
alain@contoso.com
isabella@contoso.com
joseph@contoso.com
```

> [!TIP]
> To get a list of current group members that you can edit, use the **Download members** bulk operation first. This gives you a CSV file with all current members that you can modify to include only the members you want to remove.

## Bulk remove group members


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Browse to **Entra ID** > **Groups** > **All groups**.
1. Open the group from which you're removing members and then select **Members**.
1. On the **Members** page, select **Remove members**.
1. On the **Bulk remove group members** page, select **Download** to get the CSV file template with required group member properties.

    :::image type="content" source="./media/groups-bulk-remove-members/remove-panel.png" alt-text="Screenshot that shows the Remove Members command is on the profile page for the group.":::

1. Open the CSV file and add a line for each group member you want to remove from the group. For each member, enter either their **User principal name** (UPN, such as `user@contoso.com`) or their **Object ID** (a GUID like `00aa00aa-bb11-cc22-dd33-44ee44ee44ee`). Enter one member per row. Then save the file.

    :::image type="content" source="./media/groups-bulk-remove-members/csv-file.png" alt-text="Screenshot that shows the CSV file contains names and IDs of the group members to remove.":::

1. On the **Bulk remove group members** page, under **Upload your csv file**, browse to the file. When you select the file, validation of the CSV file starts.
1. When the file contents are validated, the bulk import page displays **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that removes the group members from the group.
1. When the removal operation finishes, a notification states that the bulk operation succeeded.

[!INCLUDE [bulk-operations-error-results](~/includes/bulk-operations-error-results.md)]

For more information about bulk operations limitations, see [Bulk removal service limits](#bulk-removal-service-limits).

## Check removal status

[!INCLUDE [bulk-operations-check-status](~/includes/bulk-operations-check-status.md)]

:::image type="content" source="./media/groups-bulk-remove-members/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page.":::

For details about each line item within the bulk operation, select the values under the **# Success**, **# Failure**, or **Total Requests** columns. If failures occurred, the reasons for failure are listed.

## Bulk removal service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk import group members](groups-bulk-import-members.md)
- [Download members of a group](groups-bulk-download-members.md)
- [Download a list of all groups](groups-bulk-download.md)

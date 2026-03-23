---
title: Bulk upload to add or create members of a group
description: Add group members in bulk by using a comma-separated values (CSV) file.
ms.date: 12/05/2025
ms.topic: how-to
ms.custom: it-pro, sfi-image-nochange
ms.reviewer: jeffsta
---

# Bulk add group members in Microsoft Entra ID

You can add multiple members to a group by using a comma-separated values (CSV) file to bulk import group members in the portal for Microsoft Entra ID.

## Understand the CSV template

Download and fill in the bulk upload CSV template to successfully add Microsoft Entra group members in bulk. Your CSV template might look like this example:

:::image type="content" source="./media/groups-bulk-import-members/template-with-callouts.png" alt-text="Screenshot that shows the spreadsheet for upload and call-outs explaining the purpose and values for each row and column.":::

### CSV template structure

The rows in a downloaded CSV template are:

- **Column headings**: The format of the column headings is &lt;*Item name*&gt; [PropertyName] &lt;*Required or blank*&gt;. An example is `Member object ID or user principal name [memberObjectIdOrUpn] Required`. Some older versions of the template might have slight variations. For group membership changes, you can use either the member object ID or the user principal name (UPN).
- **Examples row**: The template includes a row of example values (for example, `Example: 9832aad8-e4fe-496b-a604-95c6eF01ae75`). You must remove the examples row and replace it with your own entries.

[!INCLUDE [bulk-operations-csv-template-note](~/includes/bulk-operations-csv-template-note.md)]

### More guidance

[!INCLUDE [bulk-operations-csv-guidance](~/includes/bulk-operations-csv-guidance.md)]

- Add at least two users' UPNs or object IDs to successfully upload the file.
- Enter one member per row. Don't use semicolons or other delimiters to separate multiple members in a single row.

### Example CSV file

Here's an example of a completed CSV file ready for upload, matching the current template format. This example uses user principal names (UPNs):

```csv
Member object ID or user principal name [memberObjectIdOrUpn] Required
alain@contoso.com
isabella@contoso.com
joseph@contoso.com
chaya@contoso.com
```

Alternatively, you can use object IDs instead of UPNs:

```csv
Member object ID or user principal name [memberObjectIdOrUpn] Required
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

> [!TIP]
> To find a user's object ID, go to **Identity** > **Users** > **All users**, select the user, and copy the **Object ID** from the user's profile page.

## Bulk import group members


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Navigate to **Identity**.
    > [!NOTE]
    > Group owners can also bulk import members of groups they own.
1. Select **Groups** > **All groups**.
1. Open the group to which you're adding members and then select **Members**.
1. On the **Members** page, select **Bulk operations** and then choose **Import members**.
1. On the **Bulk import group members** page, select **Download** to get the CSV file template with required group member properties.

    :::image type="content" source="./media/groups-bulk-import-members/import-panel.png" alt-text="Screenshot that shows the Import Members command is on the profile page for the group.":::

1. Open the CSV file and add a line for each group member you want to import into the group. For each member, enter either their **User principal name** (UPN, such as `user@contoso.com`) or their **Object ID** (a GUID like `00aa00aa-bb11-cc22-dd33-44ee44ee44ee`). Enter one member per row. Then save the file.

    :::image type="content" source="./media/groups-bulk-import-members/csv-file.png" alt-text="Screenshot that shows the CSV file contains names and IDs of the members to import.":::

1. On the **Bulk import group members** page, under **Upload your csv file**, browse to the file. When you select the file, validation of the CSV file starts.
1. When the file contents are validated, the bulk import page displays **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that imports the group members to the group.
1. When the import operation finishes, a notification states that the bulk operation succeeded.

[!INCLUDE [bulk-operations-error-results](~/includes/bulk-operations-error-results.md)]

For more information about bulk operations limitations, see [Bulk import service limits](#bulk-import-service-limits).

## Check import status

[!INCLUDE [bulk-operations-check-status](~/includes/bulk-operations-check-status.md)]

1. Navigate to **Identity** > **Users** > **Bulk operation results**.
1. Find your bulk operation in the list. The **Status** column shows whether the operation is **In Progress**, **Succeeded**, or **Failed**.

    :::image type="content" source="./media/groups-bulk-import-members/bulk-center.png" alt-text="Screenshot that shows the Check status option on the Bulk operation results page.":::

For details about each line item within the bulk operation, select the values under the **# Success**, **# Failure**, or **Total Requests** columns. If failures occurred, the reasons for failure are listed.

### Download the results file

To download detailed results:

1. On the **Bulk operation results** page, select the operation you want to review.
1. Select **Download** to get a CSV file containing the status of each row from your original upload.
1. Open the CSV file to see which members were added successfully and which failed, along with specific error messages.

Common errors include:
- **Member not found**: The UPN or object ID doesn't exist in your directory.
- **Member already exists**: The user is already a member of the group.
- **Invalid format**: The UPN or object ID format is incorrect.

## Bulk import service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk remove group members](groups-bulk-remove-members.md)
- [Download members of a group](groups-bulk-download-members.md)
- [Download a list of all groups](groups-bulk-download.md)

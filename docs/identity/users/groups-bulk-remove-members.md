---
title: Bulk remove group members by uploading a CSV file
description: Remove group members in bulk operations by using a comma-separated values (CSV) file.
ms.date: 06/18/2026
ms.topic: how-to
ai-usage: ai-assisted
ms.custom: it-pro, sfi-image-nochange
ms.reviewer: jeffsta
---

# Bulk remove group members in Microsoft Entra ID


## Overview

You can remove a large number of members from a group by using a comma-separated values (CSV) file in the portal for Microsoft Entra ID.

## Understand the CSV template

Download and fill in the bulk upload CSV template to successfully remove Microsoft Entra group members in bulk. Use the template that you download for the group member removal operation. The current group member template starts with the column header, not a `version:v1.0` row.

### CSV template structure

The rows in a downloaded CSV template are:

- **Column headings**: Preserve the full downloaded column header exactly as-is. The property name in brackets is only one part of the header, so don't replace the full header with only `memberObjectIdOrUpn`. The current group member removal header is `Member object ID or user principal name [memberObjectIdOrUpn] Required`. For group membership changes, you can use either the member object ID or the user principal name (UPN) in the rows under this header.
- **Examples row**: If the template includes a row of example values, such as `Example: 9832aad8-e4fe-496b-a604-95c6eF01ae75`, remove the examples row and replace it with your own entries.

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

1. Open the CSV file and add a line for each group member you want to remove from the group. For each member, enter either their **User principal name** (UPN, such as `user@contoso.com`) or their **Object ID** (a GUID like `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`). Enter one member per row. Then save the file.

1. On the **Bulk remove group members** page, under **Upload your csv file**, browse to the file. When you select the file, validation of the CSV file starts.
1. When the file contents are validated, the bulk remove page displays **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
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

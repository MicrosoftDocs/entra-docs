---
title: Bulk delete users in Microsoft Entra ID
description: Delete users in bulk in Microsoft Entra ID
author: tafra00
ms.author: tazkiaafra
ms.service: entra-id
ms.date: 09/25/2026
ms.topic: how-to
ai-usage: ai-assisted
ms.custom: it-pro, sfi-image-nochange, msecd-doc-authoring-1026

#customer intent: As a user administrator, I want to delete users in bulk so that I can remove multiple users from Microsoft Entra ID at once.
---

# Bulk delete users in Microsoft Entra ID

Using the admin center in Microsoft Entra ID, part of Microsoft Entra, you can remove a large number of users by using a comma-separated values (CSV) file to bulk delete users.

## Prerequisites

To bulk delete users in the Microsoft Entra admin center, sign in as at least a User Administrator.

## Bulk delete users

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Users** > **All users** > **Bulk operations** > **Bulk delete**.

    :::image type="content" source="./media/users-bulk-delete/users-bulk-delete.png" alt-text="Screenshot of the Users page with the Bulk delete option selected.":::

1. On the **Bulk delete user** page, select **Download** to download the latest version of the CSV template.
1. Open the CSV file, preserve the column header exactly as downloaded, and add a line for each user you want to delete. For each user, enter either the **User principal name** or **Object ID**. Save the file.
1. On the **Bulk delete user** page, under **Upload your csv file**, browse to the file. When you select the file and select **Submit**, validation of the CSV file starts.
1. When the file contents are validated, you’ll see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that deletes the users.
1. When the deletion operation completes, you see a notification that the bulk operation succeeded.

[!INCLUDE [bulk-operations-error-results](~/includes/bulk-operations-error-results.md)]

For more information about bulk operations limitations, see [Bulk delete service limits](#bulk-delete-service-limits).

## CSV template structure

The rows in the example downloaded CSV template below are as follows:

- **Column headings**: Preserve `UserPrincipalName or Object ID [UPN or objectId] Required` exactly as downloaded.
- **Examples row**: You can keep the examples row in the CSV file. Add the users that you want to delete on the following rows. For each user, enter a user principal name (UPN) or object ID.

:::image type="content" source="./media/users-bulk-delete/delete-csv-file.png" alt-text="Screenshot of a bulk delete CSV template with the required UserPrincipalName or Object ID column.":::

### Example CSV file

Here's an example of a completed CSV file ready for upload:

```csv
UserPrincipalName or Object ID [UPN or objectId] Required
chris@contoso.com
alain@contoso.com
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
```

### Additional guidance for the CSV template

[!INCLUDE [bulk-operations-csv-guidance](~/includes/bulk-operations-csv-guidance.md)]

- Enter one user per row.

## Check status

[!INCLUDE [bulk-operations-check-status](~/includes/bulk-operations-check-status.md)]

:::image type="content" source="./media/users-bulk-delete/bulk-center.png" alt-text="Screenshot of checking delete status in the Bulk Operations Results page." lightbox="./media/users-bulk-delete/bulk-center.png":::

Next, you can check to see that the users you deleted exist in the Microsoft Entra organization either in the portal or by using PowerShell.

## Verify deleted users

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select **Microsoft Entra ID**.
1. Select **All users** only and verify that the users you deleted are no longer listed.

### Verify deleted users with PowerShell

Run the following command:

``` PowerShell
Get-MgUser -Filter "UserType eq 'Member'"
```

Verify that the users that you deleted are no longer listed.

## Bulk delete service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Related content

- [Bulk add users](users-bulk-add.md)
- [Download list of users](users-bulk-download.md)
- [Bulk restore users](users-bulk-restore.md)

---
title: Bulk delete users in Microsoft Entra ID
description: Delete users in bulk in Microsoft Entra ID
ms.date: 03/05/2026
ms.topic: how-to
ms.custom: it-pro, sfi-image-nochange
ms.reviewer: jeffsta
---

# Bulk delete users in Microsoft Entra ID

Using the admin center in Microsoft Entra ID, part of Microsoft Entra, you can remove a large number of users by using a comma-separated values (CSV) file to bulk delete users.

## To bulk delete users

> [!IMPORTANT]
> Updates are being made to bulk operations. While this issue is being addressed, you might experience problems deleting users assigned to privileged roles. This problem is temporary and is being resolved as soon as possible.


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Users** > **All users** > **Bulk operations** > **Bulk delete**.

    :::image type="content" source="./media/users-bulk-delete/users-bulk-delete.png" alt-text="Screenshot of the Users page with the Bulk delete option selected.":::

1. On the **Bulk delete user** page, select **Download** to download the latest version of the CSV template.
1. Open the CSV file and add a line for each user you want to delete. The only required value is **User principal name**. Save the file.
1. On the **Bulk delete user** page, under **Upload your csv file**, browse to the file. When you select the file and select **Submit**, validation of the CSV file starts.
1. When the file contents are validated, you’ll see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that deletes the users.
1. When the deletion operation completes, you see a notification that the bulk operation succeeded.

[!INCLUDE [bulk-operations-error-results](~/includes/bulk-operations-error-results.md)]

For more information about bulk operations limitations, see [Bulk delete service limits](#bulk-delete-service-limits).

## CSV template structure

The rows in the example downloaded CSV template below are as follows:

- **Version number**: The first row containing the version number (for example, `version:v1.0`) must be included in the upload CSV. If your downloaded template includes this row, don't remove or modify it.
- **Column headings**: `User name [userPrincipalName] Required`. Older versions of the template might vary.
- **Examples row**: The template might include a row of example values. `Example: chris@contoso.com` You must remove the example row and replace it with your own entries.

:::image type="content" source="./media/users-bulk-delete/delete-csv-file.png" alt-text="Screenshot of the CSV file contains names and IDs of the users to delete.":::

[!INCLUDE [bulk-operations-csv-template-note](~/includes/bulk-operations-csv-template-note.md)]

### Example CSV file

Here's an example of a completed CSV file ready for upload:

```csv
version:v1.0
User name [userPrincipalName] Required
alain@contoso.com
isabella@contoso.com
joseph@contoso.com
chaya@contoso.com
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

## Next steps

- [Bulk add users](users-bulk-add.md)
- [Download list of users](users-bulk-download.md)
- [Bulk restore users](users-bulk-restore.md)

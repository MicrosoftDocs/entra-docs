---
title: Bulk delete users in Microsoft Entra ID
description: Delete users in bulk in Microsoft Entra ID
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

# Bulk delete users in Microsoft Entra ID

Using the admin center in Microsoft Entra ID, part of Microsoft Entra, you can remove a large number of members to a group by using a comma-separated values (CSV) file to bulk delete users.

## To bulk delete users


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select Microsoft Entra ID.
1. Select **Users** > **All users** > **Bulk operations** > **Bulk delete**.

   :::image type="content" source="./media/users-bulk-delete/users-bulk-delete.png" alt-text="Screenshot of the Users page with the Bulk delete option selected.":::

1. On the **Bulk delete user** page, select **Download** to download the latest version of the CSV template.
1. Open the CSV file and add a line for each user you want to delete. The only required value is **User principal name**. Save the file.
1. On the **Bulk delete user** page, under **Upload your csv file**, browse to the file. When you select the file and select submit, validation of the CSV file starts.
1. When the file contents are validated, you’ll see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that deletes the users.
1. When the deletion operation completes, you see a notification that the bulk operation succeeded.

If you experience errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error. The file submission must match the provided template and include the exact column names. For more information about bulk operations limitations, see [Bulk delete service limits](#bulk-delete-service-limits).

## CSV template structure

The rows in the example downloaded CSV template below are as follows:

- **Version number**: The first row containing the version number must be included in the upload CSV.
- **Column headings**: `User name [userPrincipalName] Required`. Older versions of the template might vary.
- **Examples row**: We have included in the template an example of an acceptable value. `Example: chris@contoso.com` You must remove the example row and replace it with your own entries.

:::image type="content" source="./media/users-bulk-delete/delete-csv-file.png" alt-text="Screenshot of the CSV file contains names and IDs of the users to delete.":::

### Additional guidance for the CSV template

- The first two rows of the template must not be removed or modified, or the template can't be processed.
- The required columns are listed first.
- Don't add new columns to the template. Any other columns you add are ignored and not processed.
- Download the latest version of the CSV template before making new changes.

## Check status

You can see the status of all of your pending bulk requests in the **Bulk operation results** page.

   :::image type="content" source="./media/users-bulk-delete/bulk-center.png" alt-text="Screenshot of checking delete status in the Bulk Operations Results page." lightbox="./media/users-bulk-delete/bulk-center.png":::

Next, you can check to see that the users you deleted exist in the Microsoft Entra organization either in the  portal or by using PowerShell.

## Verify deleted users

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select Microsoft Entra ID.
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

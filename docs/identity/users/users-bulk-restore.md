---
title: Bulk restore deleted users in the Azure portal
description: Restore deleted users in bulk in the Azure portal in Microsoft Entra ID

author: barclayn
ms.author: barclayn
manager: amycolannino
ms.date: 11/21/2022
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.custom: it-pro, has-azure-ad-ps-ref
ms.reviewer: jeffsta
---

# Bulk restore deleted users in Microsoft Entra ID

Microsoft Entra ID, part of Microsoft Entra, supports bulk user restore operations and supports downloading lists of users, groups, and group members.

## Understand the CSV template

Download and fill in the CSV template to help you successfully restore Microsoft Entra users in bulk. The CSV template you download might look like this example:

:::image type="content" source="./media/users-bulk-restore/understand-template.png" alt-text="Screenshot of spreadsheet for uploading and call-outs explaining the purpose and values for each row and column.":::

### CSV template structure

The rows in a downloaded CSV template are as follows:

- **Version number**: The first row containing the version number must be included in the upload CSV.
- **Column headings**: The format of the column headings is &lt;*Item name*&gt; [PropertyName] &lt;*Required or blank*&gt;. For example, `Object ID [objectId] Required`. Some older versions of the template might have slight variations.
- **Examples row**: We have included in the template a row of examples of acceptable values for each column. You must remove the examples row and replace it with your own entries.

### Additional guidance

- The first two rows of the upload template must not be removed or modified, or the upload can't be processed.
- The required columns are listed first.
- We don't recommend adding new columns to the template. Any additional columns you add are ignored and not processed.
- We recommend that you download the latest version of the CSV template as often as possible.

## To bulk restore users

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select Microsoft Entra ID.
1. Select **All users**  > **Users** > **Deleted**.
1. On the **Deleted users** page, select **Bulk restore** to upload a valid CSV file of properties of the users to restore.

   :::image type="content" source="./media/users-bulk-restore/bulk-restore.png" alt-text="Screenshot of selecting the bulk restore command on the Deleted users page.":::

1. Open the CSV template and add a line for each user you want to restore. The only required value is **ObjectID**. Then save the file.

    :::image type="content" source="./media/users-bulk-restore/upload-button.png" alt-text="Screenshot of selecting a local CSV file in which you list the users you want to add":::

1. On the **Bulk restore** page, under **Upload your csv file**, browse to the file. When you select the file and click **Submit**, validation of the CSV file starts.
1. When the file contents are validated, you’ll see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that restores the users.
1. When the restore operation completes, you'll see a notification that the bulk operation succeeded.

If there are errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error.

[!INCLUDE [Bulk update warning](~/includes/bulk-export.md)]

## Check status

You can see the status of all of your pending bulk requests in the **Bulk operation results** page.

:::image type="content" source="./media/users-bulk-restore/bulk-center.png" alt-text="Screenshot of checking the status in the Bulk Operations Results page.." lightbox="./media/users-bulk-restore/bulk-center.png":::

Next, you can check to see that the users you restored exist in the Microsoft Entra organization via either Microsoft Entra ID or PowerShell.

## View restored users in the Azure portal

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select Microsoft Entra ID.
1. Select **All users** Under **Manage**, select **Users**.
1. Under **Show**, select **All users** and verify that the users you restored are listed.

### View users with PowerShell

Run the following command:

``` PowerShell
Get-MgUser -Filter "UserType eq 'Member'"
```

You should see that the users that you restored are listed.

[!INCLUDE [Azure AD PowerShell migration](../../includes/aad-powershell-migration-include.md)]

## Next steps

- [Bulk import users](users-bulk-add.md)
- [Bulk delete users](users-bulk-delete.md)
- [Download list of users](users-bulk-download.md)

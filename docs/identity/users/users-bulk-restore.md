---
title: Bulk restore deleted users in the Azure portal
description: Restore deleted users in bulk in the Azure portal in Microsoft Entra ID
author: tafra00
ms.author: tazkiaafra
ms.service: entra-id
ms.date: 09/25/2026
ms.topic: how-to
ai-usage: ai-assisted
ms.custom: it-pro, has-azure-ad-ps-ref, sfi-image-nochange, msecd-doc-authoring-1026

#customer intent: As a user administrator, I want to restore users in bulk so that I can recover multiple deleted users in Microsoft Entra ID at once.
---

# Bulk restore deleted users in Microsoft Entra ID

Microsoft Entra ID supports bulk user restore operations and downloading lists of users, groups, and group members.

## Prerequisites

To bulk restore users in the Microsoft Entra admin center, sign in as at least a User Administrator.

## Understand the CSV template

Download and fill in the CSV template to help you successfully restore Microsoft Entra users in bulk. The CSV template you download might look like this example:

:::image type="content" source="./media/users-bulk-restore/understand-template.png" alt-text="Screenshot of a bulk restore CSV template with the required Object ID column.":::

### CSV template structure

The rows in a downloaded CSV template are as follows:

- **Column headings**: Preserve `Object ID [objectId] Required` exactly as downloaded.
- **Examples row**: You can keep the examples row in the CSV file. Add the object IDs for the users that you want to restore on the following rows.

### Example CSV file

Here's an example of a completed CSV file ready for upload:

```csv
Object ID [objectId] Required
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

### Additional guidance

[!INCLUDE [bulk-operations-csv-guidance](~/includes/bulk-operations-csv-guidance.md)]

## Bulk restore users

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select Microsoft Entra ID.
1. Select **Users** > **All users** > **Deleted**.
1. On the **Deleted users** page, select **Bulk restore** to upload a valid CSV file of properties of the users to restore.

    :::image type="content" source="./media/users-bulk-restore/bulk-restore.png" alt-text="Screenshot of selecting the bulk restore command on the Deleted users page.":::

1. Open the CSV template, preserve the column header exactly as downloaded, and add a line for each user you want to restore. The only required value is **Object ID**. Then save the file.

1. On the **Bulk restore** page, under **Upload your csv file**, browse to the file. When you select the file and select **Submit**, validation of the CSV file starts.
1. When the file contents are validated, you see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that restores the users.
1. When the restore operation completes, you see a notification that the bulk operation succeeded.

[!INCLUDE [bulk-operations-error-results](~/includes/bulk-operations-error-results.md)]

For more information about bulk operations limitations, see [Bulk restore service limits](#bulk-restore-service-limits).

## Check status

[!INCLUDE [bulk-operations-check-status](~/includes/bulk-operations-check-status.md)]

:::image type="content" source="./media/users-bulk-restore/bulk-center.png" alt-text="Screenshot of checking the status in the Bulk Operations Results page." lightbox="./media/users-bulk-restore/bulk-center.png":::

Next, you can check to see that the users you restored exist in the Microsoft Entra organization via either Microsoft Entra ID or PowerShell.

## View restored users in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select Microsoft Entra ID.
1. Under **Manage**, select **Users** > **All users**.
1. Under **Show**, select **All users** and verify that the users you restored are listed.

### View users with PowerShell

Run the following command:

``` PowerShell
Get-MgUser -Filter "UserType eq 'Member'"
```

You should see that the users that you restored are listed.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../docs/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

## Bulk restore service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Related content

- [Bulk import users](users-bulk-add.md)
- [Bulk delete users](users-bulk-delete.md)
- [Download list of users](users-bulk-download.md)

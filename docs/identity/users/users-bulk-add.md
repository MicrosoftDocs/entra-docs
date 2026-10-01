---
title: Bulk create users in the Azure portal
description: Add users in bulk in Microsoft Entra ID
author: tafra00
ms.author: tazkiaafra
ms.service: entra-id
ms.date: 09/25/2026
ms.topic: how-to
ai-usage: ai-assisted
ms.custom: it-pro, sfi-image-nochange, msecd-doc-authoring-1026

#customer intent: As a user administrator, I want to create users in bulk so that I can add multiple users to Microsoft Entra ID at once.
---

# Bulk create users in Microsoft Entra ID

Microsoft Entra ID, part of Microsoft Entra, supports bulk user create and delete operations and supports downloading lists of users. Just fill out the comma-separated values (CSV) template you can download from Microsoft Entra ID.

## Prerequisites

To bulk create users in the Microsoft Entra admin center, sign in as at least a User Administrator.

## Understand the CSV template

Download and fill in the bulk upload CSV template to help you successfully create Microsoft Entra users in bulk. The CSV template you download might look like this example:

:::image type="content" source="./media/users-bulk-add/create-template-example.png" alt-text="Screenshot of a bulk create CSV template with the required Name, User name, and Initial password columns.":::

> [!WARNING]
> Ensure that you add the `.csv` file extension and remove any leading spaces before `userPrincipalName` and `passwordProfile`.

### CSV template structure

The rows in a downloaded CSV template are as follows:

- **Column headings**: Preserve the column headings exactly as downloaded. The required columns are `Name [displayName] Required`, `User name [userPrincipalName] Required`, and `Initial password [passwordProfile] Required`.
- **Examples row**: You can keep the examples row in the CSV file. Add the users that you want to create on the following rows.

### Additional guidance

[!INCLUDE [bulk-operations-csv-guidance](~/includes/bulk-operations-csv-guidance.md)]

- Make sure to check there is no unintended whitespace before/after any field. For **User principal name**, having such whitespace would cause import failure.
- Ensure that values in **Initial password** comply with the currently active [password policy](~/identity/authentication/concept-sspr-policy.md#username-policies).
- Enter one user per row.

### Example CSV file

Here's an example of a completed CSV file ready for upload:

```csv
Name [displayName] Required,User name [userPrincipalName] Required,Initial password [passwordProfile] Required
Chris Green,chris@contoso.com,Example-Password-Only!1
Alain Charon,alain@contoso.com,Example-Password-Only!1
Isabella Simonsen,isabella@contoso.com,Example-Password-Only!1
Joseph Price,joseph@contoso.com,Example-Password-Only!1
```

> [!IMPORTANT]
> Only **Name**, **User name**, and **Initial password** are required. All other columns are optional and can be left empty.

## Create users in bulk

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users** > **Bulk create**.
1. On the **Bulk create user** page, select **Download** to receive a valid comma-separated values (CSV) file of user properties, and then add users you want to create.

    :::image type="content" source="./media/users-bulk-add/upload-button.png" alt-text="Screenshot showing how to select a local CSV file in which you list the users you want to add.":::

1. Open the CSV file, preserve the column headers exactly as downloaded, and add a line for each user you want to create. The only required values are **Name**, **User name**, and **Initial password**. Then save the file.

1. On the **Bulk create user** page, under Upload your CSV file, browse to the file. When you select the file and select **Submit**, validation of the CSV file starts.
1. After the file contents are validated, you’ll see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that imports the new users.
1. When the import operation completes, you see a notification of the bulk operation job status.

> [!NOTE]
> The bulk create operation creates internal member accounts with the passwords specified in the CSV file. No invitation emails are sent to the new users. You must communicate the sign-in credentials to the users through your own process. To bulk invite external guest users and send invitation emails, see [Bulk invite B2B users](~/external-id/tutorial-bulk-invite.md).

[!INCLUDE [bulk-operations-error-results](~/includes/bulk-operations-error-results.md)]

For more information about bulk operations limitations, see [Bulk import service limits](#bulk-import-service-limits).

## Check status

[!INCLUDE [bulk-operations-check-status](~/includes/bulk-operations-check-status.md)]

:::image type="content" source="./media/users-bulk-add/bulk-center.png" alt-text="Screenshot showing how to check the status of the operation in the bulk operations results page.":::

Next, you can check to see that the users you created exist in the Microsoft Entra organization either in the Microsoft Entra admin center or by using PowerShell.

## Verify users

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select Microsoft Entra ID.
1. Select **Users** > **All users**.
1. Under **Show**, select **All users** and verify that the users you created are listed.

### Verify users with PowerShell

Run the following command:

``` PowerShell
Get-MgUser -Filter "UserType eq 'Member'"
```

You should see that the users that you created are listed.

## Bulk import service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Related content

- [Bulk delete users](users-bulk-delete.md)
- [Download list of users](users-bulk-download.md)
- [Bulk restore users](users-bulk-restore.md)

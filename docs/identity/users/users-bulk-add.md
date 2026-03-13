---
title: Bulk create users in the Azure portal
description: Add users in bulk in Microsoft Entra ID
ms.date: 12/05/2025
ms.topic: how-to
ms.custom: it-pro, sfi-image-nochange
ms.reviewer: jeffsta
---

# Bulk create users in Microsoft Entra ID

Microsoft Entra ID, part of Microsoft Entra, supports bulk user create and delete operations and supports downloading lists of users. Just fill out comma-separated values (CSV) template you can download from Microsoft Entra ID.

## Required permissions

In order to bulk create users in the administration portal, you must be signed in as at least a User Administrator.

## Understand the CSV template

Download and fill in the bulk upload CSV template to help you successfully create Microsoft Entra users in bulk. The CSV template you download might look like this example:

:::image type="content" source="./media/users-bulk-add/create-template-example.png" alt-text="Screenshot of spreadsheet for upload and call-outs explaining the purpose and values for each row and column.":::

> [!WARNING]
> If you are adding only one entry using the CSV template, you must preserve row 3 and add your new entry to row 4.
>
> Ensure that you add the `.csv` file extension and remove any leading spaces before `userPrincipalName`, `passwordProfile`, and `accountEnabled`.

### CSV template structure

The rows in a downloaded CSV template are as follows:

- **Version number**: The first row containing the version number (for example, `version:v1.0`) must be included in the upload CSV. If your downloaded template includes this row, don't remove or modify it.
- **Column headings**: The format of the column headings is &lt;*Item name*&gt; [PropertyName] &lt;*Required or blank*&gt;. For example, `Name [displayName] Required`. Some older versions of the template might have slight variations.
- **Examples row**: The template might include a row of example values for each column. You must remove the examples row and replace it with your own entries.

[!INCLUDE [bulk-operations-csv-template-note](~/includes/bulk-operations-csv-template-note.md)]

### Additional guidance

[!INCLUDE [bulk-operations-csv-guidance](~/includes/bulk-operations-csv-guidance.md)]

- Make sure to check there is no unintended whitespace before/after any field. For **User principal name**, having such whitespace would cause import failure.
- Ensure that values in **Initial password** comply with the currently active [password policy](~/identity/authentication/concept-sspr-policy.md#username-policies).
- Enter one user per row.

### Example CSV file

Here's an example of a completed CSV file ready for upload:

```csv
version:v1.0
Name [displayName] Required,User name [userPrincipalName] Required,Initial password [passwordProfile] Required,Block sign in (Yes/No) [accountEnabled] Required,First name [givenName],Last name [surname],Job title [jobTitle],Department [department],Usage location [usageLocation],Street address [streetAddress],State or province [state],Country or region [country],Office [physicalDeliveryOfficeName],City [city],ZIP or postal code [postalCode],Office phone [telephoneNumber],Mobile phone [mobile]
Alain Charon,alain@contoso.com,Password1!,No,Alain,Charon,Software Engineer,Engineering,US,,,,,,,
Isabella Simonsen,isabella@contoso.com,Password1!,No,Isabella,Simonsen,Product Manager,Product,US,,,,,,,
Joseph Price,joseph@contoso.com,Password1!,No,Joseph,Price,Sales Representative,Sales,US,,,,,,,
```

> [!IMPORTANT]
> Only the first four columns are required: **Name**, **User name**, **Initial password**, and **Block sign in**. All other columns are optional and can be left empty.

## To create users in bulk


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users** > **Bulk create**.
1. On the **Bulk create user** page, select **Download** to receive a valid comma-separated values (CSV) file of user properties, and then add users you want to create.

   :::image type="content" source="./media/users-bulk-add/upload-button.png" alt-text="Screenshot showing how to select a local CSV file in which you list the users you want to add.":::

1. Open the CSV file and add a line for each user you want to create. The only required values are **Name**, **User principal name**, **Initial password**, and **Block sign in (Yes/No)**. Then save the file.

   :::image type="content" source="./media/users-bulk-add/add-csv-file.png" alt-text="Screenshot showing an example of the CSV file containing the names and IDs of the users to create.":::

1. On the **Bulk create user** page, under Upload your CSV file, browse to the file. When you select the file and select **Submit**, validation of the CSV file starts.
1. After the file contents are validated, you’ll see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
1. When your file passes validation, select **Submit** to start the bulk operation that imports the new users.
1. When the import operation completes, you see a notification of the bulk operation job status.

[!INCLUDE [bulk-operations-error-results](~/includes/bulk-operations-error-results.md)]

For more information about bulk operations limitations, see [Bulk import service limits](#bulk-import-service-limits).

## Check status

[!INCLUDE [bulk-operations-check-status](~/includes/bulk-operations-check-status.md)]

   :::image type="content" source="./media/users-bulk-add/bulk-center.png" alt-text="Screenshot showing how to check the status of the operation in the bulk operations results page.":::

Next, you can check to see that the users you created exist in the Microsoft Entra organization either in the Azure portal or by using PowerShell.

## Verify users

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Select Microsoft Entra ID.
1. Select **All users** > **Users**.
1. Under **Show**, select **All users** and verify that the users you created are listed.

### Verify users with PowerShell

Run the following command:

``` PowerShell
Get-MgUser -Filter "UserType eq 'Member'"
```

You should see that the users that you created are listed.

## Bulk import service limits

[!INCLUDE [Bulk operations limitations](~/includes/bulk-operations-limitations.md)]

## Next steps

- [Bulk delete users](users-bulk-delete.md)
- [Download list of users](users-bulk-download.md)
- [Bulk restore users](users-bulk-restore.md)

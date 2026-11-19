---
title: Manage separation of duties for dynamic permissions
description: Learn how to import, update, enable, disable, and delete separation of duties rules for dynamic permissions in Microsoft Entra ID Governance.
ms.topic: how-to
ms.date: 11/14/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-generated
#customer intent: As an administrator, I want to manage separation of duties rules for dynamic permissions so that I can define incompatible roles and conflicts.
---

# Manage separation of duties for dynamic permissions

As an Identity Governance Administrator, you can manage separation of duties rules for dynamic permissions in Microsoft Entra ID Governance.

> [!NOTE]
> With separation of duties in the dynamic permissions preview, organizations can define rules using the authorization models and constructs of their applications and resources. These preview capabilities are separate from the generally available [separation of duties capabilities for access packages](entitlement-management-access-package-incompatible.md) in entitlement management.

This article explains how to import, update, enable, disable, and delete rules, and where to view the impacted agent non-human identities.

## Prerequisites

[!INCLUDE [Dynamic permissions licensing](~/includes/licensing-dynamic-permissions.md)]

Have a resource already set up that supports separation of duties. If you're getting started, see [Tutorial: Mitigate permission risk of agents in Snowflake with Microsoft Entra dynamic permissions](tutorial-dynamic-permissions-prevent-excessive-permissions.md).

## View separation of duties rule details

To view the details of a separation of duties rule, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
1. Browse to **ID Governance** > **Dynamic permissions (preview)** > **Separation of duties**.

    :::image type="content" source="media/dynamic-permissions-manage-separation-duties/view-separation-of-duties-rules.png" alt-text="Screenshot of two separation of duties rules for a catalog, showing their descriptions, resources, and enabled status." lightbox="media/dynamic-permissions-manage-separation-duties/view-separation-of-duties-rules.png" border="true":::

1. Select the name of the rule.

    :::image type="content" source="media/dynamic-permissions-manage-separation-duties/view-separation-of-duties-rule-details.png" alt-text="Screenshot of a separation of duties rule showing its Object ID and the two sets of conflicting Snowflake account roles." lightbox="media/dynamic-permissions-manage-separation-duties/view-separation-of-duties-rule-details.png" border="true":::

## Import separation of duties rules

To import separation of duties rules from a CSV file, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
1. Browse to **ID Governance** > **Dynamic permissions (preview)** > **Separation of duties**.
1. Select **Import rules**.

    :::image type="content" source="media/dynamic-permissions-manage-separation-duties/import-separation-of-duties-rules.png" alt-text="Screenshot of the Separation of duties page with Import rules highlighted to add rules to the selected catalog." lightbox="media/dynamic-permissions-manage-separation-duties/import-separation-of-duties-rules.png" border="true":::

1. Select **Download template** to get the CSV template.
1. Update the CSV template with your separation of duties rules. For Snowflake examples, see [CSV examples for Snowflake](#csv-examples-for-snowflake).
1. Select **Choose file**, and then select the CSV file to upload it.
1. Confirm the import message, which summarizes how many rules will be created or updated. If validation reports errors, correct the CSV file and upload it again.
1. Select **Review and import**.
1. Confirm the list of rules to be imported.
1. Select **Import**.
1. Review the import results. If all rules were imported successfully, select **Return to rules**.

### CSV examples for Snowflake

The examples define two rules for illustrative custom Snowflake account roles. Replace the resource identifier and role names with values from your environment.

- `PermissionSet1` and `PermissionSet2`: Use the exact names of the Snowflake account roles that an identity must not hold together.
- `ResourceOriginId`: Use the resource's `originId` returned by the Microsoft Graph [List resources API](/graph/api/accesspackagecatalog-list-resources?tabs=http), not its `id`. Alternatively, use the exact display name of the resource in the catalog.
- `Status`: Use `active` to enable the rule or `inactive` to disable it.
- `incompatiblePermissionSetId`: Leave this value empty to create a rule. To update an existing rule, use its **Object ID**. To find this value, select the rule name on the **Separation of duties** page to open the rule details.

The following CSV uses a resource origin ID to create an enabled finance rule and a disabled masking rule:

```csv
Name,Description,ResourceOriginId,PermissionSet1,PermissionSet2,Status,incompatiblePermissionSetId
"Separate finance data changes and auditing","Prevent the same identity from modifying finance data and independently auditing that data.","a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1","FINANCE_DATA_WRITER","FINANCE_AUDITOR","active",""
"Separate masking administration and sensitive data access","Prevent the same identity from managing masking policies and reading the sensitive data those policies protect.","a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1","MASKING_POLICY_ADMIN","SENSITIVE_DATA_READER","inactive",""
```

Alternatively, the following CSV defines the same rules using the resource's exact display name in the catalog:

```csv
Name,Description,ResourceOriginId,PermissionSet1,PermissionSet2,Status,incompatiblePermissionSetId
"Separate finance data changes and auditing","Prevent the same identity from modifying finance data and independently auditing that data.","Snowflake for Microsoft Entra ID","FINANCE_DATA_WRITER","FINANCE_AUDITOR","active",""
"Separate masking administration and sensitive data access","Prevent the same identity from managing masking policies and reading the sensitive data those policies protect.","Snowflake for Microsoft Entra ID","MASKING_POLICY_ADMIN","SENSITIVE_DATA_READER","inactive",""
```

## Update separation of duties rules

To change which roles a separation of duties rule declares incompatible, use [Import separation of duties rules](#import-separation-of-duties-rules). Set `incompatiblePermissionSetId` in the CSV file to the rule's **Object ID**, shown when you select the rule name to view its details.

To update a rule's name, description, or enabled status, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
1. Browse to **ID Governance** > **Dynamic permissions (preview)** > **Separation of duties**.
1. Select the name of the rule you want to update.
1. Select **Edit**.
1. Update the name, description, or enabled status.
1. Select **Next**.
1. Select **Review and save**.
1. Select **Save changes**.

## Enable, disable, or delete separation of duties rules

To enable, disable, or delete separation of duties rules, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
1. Browse to **ID Governance** > **Dynamic permissions (preview)** > **Separation of duties**.
1. Select the checkbox for the rule you want to enable, disable, or delete.
1. Select **Enable selected**, **Disable selected**, or **Delete selected**.

## View separation of duties conflicts

When identities hold permissions that conflict with enabled separation of duties rules, the conflicts appear in **Detections**. For more information, see [view detections and remediations (Preview)](dynamic-permissions-review-detections-remediations.md).

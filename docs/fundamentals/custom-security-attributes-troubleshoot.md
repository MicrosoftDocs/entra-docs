---
title: Troubleshoot custom security attributes in Microsoft Entra ID
description: Learn how to troubleshoot custom security attributes in Microsoft Entra ID.
author: rolyon
manager: femila
ms.author: rolyon
ms.service: entra
ms.subservice: fundamentals
ms.topic: troubleshooting
ms.date: 11/27/2024
ms.collection: M365-identity-device-management
ms.custom: sfi-image-nochange
---

# Troubleshoot custom security attributes in Microsoft Entra ID

## Symptom - Add attribute set is disabled

When signed in to the [Microsoft Entra admin center](https://entra.microsoft.com) and you try to select the **Custom security attributes** > **Add attribute set** option, it's disabled.

:::image type="content" source="./media/custom-security-attributes-troubleshoot/attribute-set-add-disabled.png" alt-text="Screenshot of Add attribute set option disabled in Microsoft Entra admin center." lightbox="./media/custom-security-attributes-troubleshoot/attribute-set-add-disabled.png":::

**Cause**

You don't have permissions to add an attribute set. To add an attribute set and custom security attributes, you must be assigned the [Attribute Definition Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-definition-administrator) role. 

[!INCLUDE [security-attributes-roles](../includes/security-attributes-roles.md)]

**Solution**

Make sure that you're assigned the [Attribute Definition Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-definition-administrator) role at either the tenant scope or attribute set scope. For more information, see [Manage access to custom security attributes in Microsoft Entra ID](custom-security-attributes-manage.md).

## Symptom - Error when you try to assign a custom security attribute

When you try to save a custom security attribute assignment, you get the message:

```
Insufficient privileges to save custom security attributes
This account does not have the necessary admin privileges to change custom security attributes
```

**Cause**

You don't have permissions to assign custom security attributes. To assign custom security attributes, you must be assigned the [Attribute Assignment Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator) role.

[!INCLUDE [security-attributes-roles](../includes/security-attributes-roles.md)]

**Solution**

Make sure that you're assigned the [Attribute Assignment Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator) role at either the tenant scope or attribute set scope. For more information, see [Manage access to custom security attributes in Microsoft Entra ID](custom-security-attributes-manage.md).

## Symptom - Can't filter custom security attributes for users or applications

**Cause 1**

You don't have permissions to filter custom security attributes. To read and filter custom security attributes for users or enterprise applications, you must be assigned the [Attribute Assignment Reader](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-reader) or [Attribute Assignment Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator) role. 

[!INCLUDE [security-attributes-roles](../includes/security-attributes-roles.md)]

**Solution 1**

Make sure that you're assigned one of the following Microsoft Entra built-in roles at either the tenant scope or attribute set scope. For more information, see [Manage access to custom security attributes in Microsoft Entra ID](custom-security-attributes-manage.md).

- [Attribute Assignment Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator)
- [Attribute Assignment Reader](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-reader)

**Cause 2**

You're assigned the Attribute Assignment Reader or Attribute Assignment Administrator role, but you haven't been assigned access to an attribute set.

**Solution 2**

You can delegate the management of custom security attributes at the tenant scope or at the attribute set scope. Make sure you have been assigned access to an attribute set at either the tenant scope or attribute set scope. For more information, see [Manage access to custom security attributes in Microsoft Entra ID](custom-security-attributes-manage.md).

**Cause 3**

There are no custom security attributes defined and assigned yet for your tenant.

**Solution 3**

Add and assign custom security attributes to users or enterprise applications. For more information, see [Add or deactivate custom security attribute definitions in Microsoft Entra ID](custom-security-attributes-add.md), [Assign, update, list, or remove custom security attributes for a user](~/identity/users/users-custom-security-attributes.md), or [Assign, update, list, or remove custom security attributes for an application](~/identity/enterprise-apps/custom-security-attributes-apps.md).

## Symptom - Custom security attributes can't be deleted

**Cause**

You can only activate and deactivate custom security attribute definitions. Deletion of custom security attributes isn't supported. Deactivated definitions don't count toward the tenant wide 500 definition limit.

**Solution**

Deactivate the custom security attributes you no longer need. For more information, see [Add or deactivate custom security attribute definitions in Microsoft Entra ID](custom-security-attributes-add.md).

## Symptom - Can't add a role assignment at an attribute set scope using PIM

When you try to add an eligible Microsoft Entra role assignment using [Microsoft Entra Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-configure.md), you can't set the scope to an attribute set.

**Cause**

PIM currently doesn't support adding an eligible Microsoft Entra role assignment at an attribute set scope.

## Symptom - Insufficient privileges to complete the operation

When you try to use [Graph Explorer](/graph/graph-explorer/graph-explorer-overview) to call Microsoft Graph API for custom security attributes, you see a message similar to the following:

```
Forbidden - 403. You need to consent to the permissions on the Modify permissions (Preview) tab
Authorization_RequestDenied
Insufficient privileges to complete the operation.
```

:::image type="content" source="./media/custom-security-attributes-troubleshoot/graph-explorer-insufficient-privileges.png" alt-text="Screenshot of Graph Explorer displaying an insufficient privileges error message." lightbox="./media/custom-security-attributes-troubleshoot/graph-explorer-insufficient-privileges.png":::

Or when you try to use a PowerShell command, you see a message similar to the following:

```
Insufficient privileges to complete the operation.
Status: 403 (Forbidden)
ErrorCode: Authorization_RequestDenied
```

**Cause 1**

You're using Graph Explorer and you haven't consented to the required custom security attribute permissions to make the API call.

**Solution 1**

Open the Permissions panel, select the appropriate custom security attribute permission, and select **Consent**. In the Permissions requested window that appears, review the requested permissions.

:::image type="content" source="./media/custom-security-attributes-troubleshoot/graph-explorer-permissions-consent.png" alt-text="Screenshot of Graph Explorer Permissions panel with CustomSecAttributeDefinition selected." lightbox="./media/custom-security-attributes-troubleshoot/graph-explorer-permissions-consent.png":::

**Cause 2**

You aren't assigned the required custom security attribute role to make the API call. 

[!INCLUDE [security-attributes-roles](../includes/security-attributes-roles.md)]

**Solution 2**

Make sure that you're assigned the required custom security attribute role. For more information, see [Manage access to custom security attributes in Microsoft Entra ID](custom-security-attributes-manage.md).

**Cause 3**

You're trying to remove a single-valued custom security attribute assignment by setting it to `null` using the [Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser) or [Update-MgServicePrincipal](/powershell/module/microsoft.graph.applications/update-mgserviceprincipal) command.

**Solution 3**

Use the [Invoke-MgGraphRequest](/powershell/microsoftgraph/authentication-commands#using-invoke-mggraphrequest) command instead. For more information, see [Remove a single-valued custom security attribute assignment from a user](../identity/users/users-custom-security-attributes.md#remove-a-single-valued-custom-security-attribute-assignment-from-a-user) or [Remove custom security attribute assignments from applications](../identity/enterprise-apps/custom-security-attributes-apps.md#remove-custom-security-attribute-assignments-from-applications-using-microsoft-graph-powershell).

## Symptom - Request_UnsupportedQuery error

When you try to call Microsoft Graph API for custom security attributes, you see a message similar to the following:

```
Bad Request - 400
Request_UnsupportedQuery
Unsupported or invalid query filter clause specified for property '<AttributeSet>_<Attribute>' of resource 'CustomSecurityAttributeValue'.
```

**Cause**

The request isn't formatted correctly.

**Solution**

If required, add `ConsistencyLevel=eventual` in the request or the header. You might also need to include `$count=true` to ensure the request is routed correctly. For more information, see [Examples: Assign, update, list, or remove custom security attribute assignments using the Microsoft Graph API](/graph/custom-security-attributes-examples).

:::image type="content" source="./media/custom-security-attributes-troubleshoot/graph-explorer-consistency-level-header.png" alt-text="Screenshot of Graph Explorer with ConsistencyLevel header added." lightbox="./media/custom-security-attributes-troubleshoot/graph-explorer-consistency-level-header.png":::

## Next steps

- [Manage access to custom security attributes in Microsoft Entra ID](custom-security-attributes-manage.md)
- [Troubleshoot Azure role assignment conditions](/azure/role-based-access-control/conditions-troubleshoot)

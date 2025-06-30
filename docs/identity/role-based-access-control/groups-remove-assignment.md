---
title: Remove Microsoft Entra role assignments
description: Remove role assignments in Microsoft Entra ID using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API.

author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.date: 05/25/2025
ms.author: barclayn
ms.reviewer: vincesm
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done


---

# Remove Microsoft Entra role assignments

This article describes how to remove Microsoft Entra role assignments using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API.

You can remove both direct and indirect role assignments for a user. If a user is assigned a role by a group membership, remove the user from the group to remove the role assignment. For more information, see [Use Microsoft Entra groups to manage role assignments](groups-concept.md).

## Microsoft Entra roles in PIM

If you have a Microsoft Entra ID P2 license and [Privileged Identity Management (PIM)](../../id-governance/privileged-identity-management/pim-configure.md), you have additional capabilities for role assignments. For information about removing Microsoft Entra role assignments in PIM, see these articles:

| Method | Information |
| --- | --- |
| Microsoft Entra admin center | [Update or remove an existing role assignment in PIM](../../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md#update-or-remove-an-existing-role-assignment) |
| Microsoft Graph PowerShell | [Remove an eligible assignment](/powershell/microsoftgraph/tutorial-pim#step-6-admin-removes-an-eligible-assignment) |
| Microsoft Graph API | [Manage Microsoft Entra role assignments using PIM APIs](/graph/api/resources/privilegedidentitymanagementv3-overview)<br/>[Remove eligible assignment via Microsoft Graph API](../../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md#remove-eligible-assignment-via-microsoft-graph-api) |

## Prerequisites

- Microsoft Entra ID P1 or P2 license
- Privileged Role Administrator
- [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) module when using PowerShell
- Admin consent when using Graph explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## Remove Microsoft Entra role assignments

# [Admin center](#tab/admin-center)


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Roles & admins**.

1. Select a role name to open the role. 

1. Add a check mark next to the users or groups from which you want to remove the role assignment.

1. Select **Remove assignment**.

    If your experience is different than the following screenshot, you might have Microsoft Entra ID P2 and PIM. For more information, see [Update or remove an existing role assignment in PIM](../../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md#update-or-remove-an-existing-role-assignment).

    :::image type="content" source="./media/groups-remove-assignment/remove-assignment.png" alt-text="Screenshot of Assignments page to remove a role assignment." lightbox="./media/groups-remove-assignment/remove-assignment.png":::

1. When asked to confirm your action, select **Yes**.

# [PowerShell](#tab/ms-powershell)

Use the [Get-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroleassignment) command to list the role assignment ID you want to remove. For examples, see [List Microsoft Entra role assignments](view-assignments.md?tabs=ms-powershell).

With the role assignment ID, use the [Remove-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/remove-mgrolemanagementdirectoryroleassignment) command to remove the role assignment.

```powershell
Remove-MgRoleManagementDirectoryRoleAssignment -UnifiedRoleAssignmentId $roleAssignment.Id
```

# [Graph API](#tab/ms-graph)

Use the [List unifiedRoleAssignments](/graph/api/rbacapplication-list-roleassignments) API to list the role assignment ID you want to remove. For examples, see [List Microsoft Entra role assignments](view-assignments.md?tabs=ms-graph).

With the role assignment ID, use the [Delete unifiedRoleAssignment](/graph/api/unifiedroleassignment-delete) API to remove the role assignment.

### Remove a role assignment for a user

```http
DELETE https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments/lAPpYvVpN0KRkAEhdxReEJC2sEqbR_9Hr48lds9SGHI-1
```

Response

```http
HTTP/1.1 204 No Content
```

### Remove a role assignment that no longer exists

```http
DELETE https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments/lAPpYvVpN0KRkAEhdxReEJC2sEqbR_9Hr48lds9SGHI-1
```

Response

```http
HTTP/1.1 404 Not Found
```

### Remove a Global Administrator role assignment for the current user

```http
DELETE https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments/lAPpYvVpN0KRkAEhdxReEJC2sEqbR_9Hr48lds9SGHI-1
```

Response

```http
HTTP/1.1 400 Bad Request
{
    "odata.error":
    {
        "code":"Request_BadRequest",
        "message":
        {
            "lang":"en",
            "value":"Removing self from Global Administrator built-in role is not allowed"},
            "values":null
        }
    }
}
```

You are prevented from removing your own Global Administrator role assignment to avoid a scenario where a tenant has zero Global Administrators. Removing other roles assigned to yourself is allowed.

---

## Next steps

- [Update or remove an existing role assignment in PIM](../../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md#update-or-remove-an-existing-role-assignment)
- [Troubleshoot Microsoft Entra roles assigned to groups](groups-faq-troubleshooting.yml)

---
title: List Microsoft Entra role assignments
description: You can now see and manage members of a Microsoft Entra administrator role in the Microsoft Entra admin center.

author: rolyon
manager: amycolannino
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.date: 04/15/2022
ms.author: rolyon
ms.reviewer: vincesm
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done

---
# List Microsoft Entra role assignments

This article describes how to list roles you have assigned in Microsoft Entra ID. In Microsoft Entra ID, roles can be assigned at an organization-wide scope or with a single-application scope.

- Role assignments at the organization-wide scope are added to and can be seen in the list of single application role assignments.
- Role assignments at the single application scope aren't added to and can't be seen in the list of organization-wide scoped assignments.

## Prerequisites

- Microsoft Graph PowerShell module when using PowerShell
- Admin consent when using Graph explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## Microsoft Entra admin center

[!INCLUDE [portal updates](~/includes/portal-update.md)]

This procedure describes how to list role assignments with organization-wide scope.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity** > **Roles & admins** > **Roles & admins**.

1. Select a role to open it and view its properties.

1. Select **Assignments** to list the role assignments.

    ![List role assignments and permissions when you open a role from the list](./media/view-assignments/role-assignments.png)

### List my role assignments

It's easy to list your own permissions as well. Select **Your Role** on the **Roles and administrators** page to see the roles that are currently assigned to you.

   ![List my role assignments](./media/view-assignments/list-my-role-assignments.png)

### Download role assignments

To download all active role assignments across all roles, including built-in and custom roles, follow these steps (currently in Preview).

1. On the **Roles and administrators** page, select **All roles**.

1. Select **Download assignments**.

    A CSV file that lists assignments at all scopes for all roles is downloaded.

    :::image type="content" source="./media/view-assignments/download-role-assignments-all.png" alt-text="Screenshot showing download all role assignments." lightbox="./media/view-assignments/download-role-assignments-all.png":::

To download all assignments for a specific role, follow these steps.

1. On the **Roles and administrators** page, select a role.

1. Select **Download assignments**.

    A CSV file that lists assignments at all scopes for that role is downloaded.

    :::image type="content" source="./media/view-assignments/download-role-assignments.png" alt-text="Screenshot showing download all assignments for a specific role." lightbox="./media/view-assignments/download-role-assignments.png":::

### List role assignments with single-application scope

This section describes how to list role assignments with single-application scope. This feature is currently in public preview.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity** > **Applications** > **App registrations**.

1. Select the app registration to view its properties. You might have to select **All applications** to see the complete list of app registrations in your Microsoft Entra organization.

    ![Create or edit app registrations from the App registrations page](./media/view-assignments/app-reg-all-apps.png)

1. In the app registration, select **Roles and administrators**, and then select a role to view its properties.

    ![List app registration role assignments from the App registrations page](./media/view-assignments/app-reg-assignments.png)

1. Select **Assignments** to list the role assignments. Opening the assignments page from within the app registration shows you the role assignments that are scoped to this Microsoft Entra resource.

    ![List app registration role assignments from the properties of an app registration](./media/view-assignments/app-reg-assignments-2.png)


## PowerShell

This section describes viewing assignments of a role with organization-wide scope. This article uses the [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) module. To view single-application scope assignments using PowerShell, you can use the cmdlets in [Assign custom roles with PowerShell](custom-assign-powershell.md).

Use the [Get-MgRoleManagementDirectoryRoleDefinition](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroledefinition) and [Get-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroleassignment) commands to list role assignments.

The following example shows how to list the role assignments for the [Groups Administrator](permissions-reference.md#groups-administrator) role.

```powershell
# Fetch list of all directory roles with template ID
Get-MgRoleManagementDirectoryRoleDefinition

# Fetch a specific directory role by ID
$role = Get-MgRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId fdd7a751-b60b-444a-984c-02652fe8fa1c

# Fetch membership for a role
Get-MgRoleManagementDirectoryRoleAssignment -Filter "roleDefinitionId eq '$($role.Id)'"
```

```Example
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScop
                                                                                                                                         eId
--                                            -----------                          ----------------                     ---------------- -------
lAPpYvVpN0KRkAEhdxReEH2Fs3EjKm1BvSKkcYVN2to-1 aaaaaaaa-bbbb-cccc-1111-222222222222 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEMdXLf2tIs1ClhpzQPsutrQ-1 bbbbbbbb-cccc-dddd-2222-333333333333 62e90394-69f5-4237-9190-012177145e10 /
```

The following example shows how to list all active role assignments across all roles, including built-in and custom roles (currently in Preview).

```powershell
$roles = Get-MgRoleManagementDirectoryRoleDefinition
foreach ($role in $roles)
{
  Get-MgRoleManagementDirectoryRoleAssignment -Filter "roleDefinitionId eq '$($role.Id)'"
}
```

```Example
Id                                            PrincipalId                          RoleDefinitionId                     DirectoryScopeId AppScop
                                                                                                                                         eId
--                                            -----------                          ----------------                     ---------------- -------
lAPpYvVpN0KRkAEhdxReEH2Fs3EjKm1BvSKkcYVN2to-1 aaaaaaaa-bbbb-cccc-1111-222222222222 62e90394-69f5-4237-9190-012177145e10 /
lAPpYvVpN0KRkAEhdxReEMdXLf2tIs1ClhpzQPsutrQ-1 bbbbbbbb-cccc-dddd-2222-333333333333 62e90394-69f5-4237-9190-012177145e10 /
4-PYiFWPHkqVOpuYmLiHa3ibEcXLJYtFq5x3Kkj2TkA-1 cccccccc-dddd-eeee-3333-444444444444 88d8e3e3-8f55-4a1e-953a-9b9898b8876b /
4-PYiFWPHkqVOpuYmLiHa2hXf3b8iY5KsVFjHNXFN4c-1 dddddddd-eeee-ffff-4444-555555555555 88d8e3e3-8f55-4a1e-953a-9b9898b8876b /
BSub0kaAukSHWB4mGC_PModww03rMgNOkpK77ePhDnI-1 eeeeeeee-ffff-aaaa-5555-666666666666 d29b2b05-8046-44ba-8758-1e26182fcf32 /
BSub0kaAukSHWB4mGC_PMgzOWSgXj8FHusA4iaaTyaI-1 ffffffff-aaaa-bbbb-6666-777777777777 d29b2b05-8046-44ba-8758-1e26182fcf32 /
```

## Microsoft Graph API

This section describes how to list role assignments with organization-wide scope. To list single-application scope role assignments using Graph API, you can use the operations in [Assign custom roles with Graph API](custom-assign-graph.md).

Use the [List unifiedRoleAssignments](/graph/api/rbacapplication-list-roleassignments) API to get the role assignments for a specific role definition. The following example shows how to list the role assignments for a specific role definition with the ID `00000000-0000-0000-0000-000000000000`.

```http
GET https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments?$filter=roleDefinitionId eq ‘<template-id-of-role-definition>’
```

Response

```http
HTTP/1.1 200 OK
{
    "id": "C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1wIiSDKQoTVJrLE9etXyrY0-1",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "roleDefinitionId": "00000000-0000-0000-0000-000000000000",
    "directoryScopeId": "/"
}
```

## Next steps

* Feel free to share with us on the [Microsoft Entra administrative roles forum](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789).
* For more about role permissions, see [Microsoft Entra built-in roles](permissions-reference.md).
* For default user permissions, see a [comparison of default guest and member user permissions](~/fundamentals/users-default-permissions.md).

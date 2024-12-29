---
title: Assign Microsoft Entra roles
description: Learn how to grant access to users and groups in Microsoft Entra ID by assigning Microsoft Entra roles using the Microsoft Entra admin center, Microsoft Graph PowerShell, Microsoft Graph API.
author: rolyon
ms.author: rolyon
manager: amycolannino
ms.reviewer: vincesm
ms.date: 03/04/2024
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Assign Microsoft Entra roles

This article describes how to grant access to users and groups in Microsoft Entra ID by assigning Microsoft Entra roles using the Microsoft Entra admin center, Microsoft Graph PowerShell, Microsoft Graph API.

To grant access to users in Microsoft Entra ID, you assign Microsoft Entra roles. To simplify role management, you can also assign Microsoft Entra roles to [role-assignable groups](groups-concept.md) instead of individuals. A role is a collection of permissions.

## Prerequisites

- Privileged Role Administrator. To know who your Privileged Role Administrator is, see [List Microsoft Entra role assignments](view-assignments.md)
- Microsoft Entra ID P2 license when using Privileged Identity Management (PIM)
- [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) module when using PowerShell
- Admin consent when using Graph explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## Assign Microsoft Entra roles

# [Admin center](#tab/admin-center)

Follow these steps to assign Microsoft Entra roles using the Microsoft Entra admin center. Your experience will be different depending on whether you have [Microsoft Entra Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-configure.md) enabled.

[!INCLUDE [portal updates](~/includes/portal-update.md)]

### Assign a role to a user

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity** > **Roles & admins** > **Roles & admins**.

    ![Screenshot of Roles and administrators page in Microsoft Entra ID.](./media/common/roles-and-administrators.png)

1. Find the role you need. You can use the search box or **Add filters** to filter the roles.

1. Select the role name to open the role. Don't add a check mark next to the role.

    ![Screenshot that shows selecting a role.](./media/common/role-select-mouse.png)

1. Select **Add assignments** and then select the users you want to assign to this role.

    If you see something different from the following picture, you might have PIM enabled. See the next section.

    ![Screenshot of Add assignments pane for selected role.](./media/manage-roles-portal/add-assignments.png)

    [!INCLUDE [rbac-assign-roles-guest-user-note](../../includes/rbac-assign-roles-guest-user-note.md)]

1. Select **Add** to assign the role.

### Assign a role to a group

Assigning a Microsoft Entra role to a group is similar to assigning users and service principals except that only groups that are role-assignable can be used.

> [!TIP]
> These steps apply to customers that have a Microsoft Entra ID P1 license. If you have a Microsoft Entra ID P2 license in your tenant, you should instead follow steps in [Assign Microsoft Entra roles in Privileged Identity Management](~/id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity** > **Roles & admins** > **Roles & admins**.

    :::image type="content" source="media/common/roles-and-administrators.png" alt-text="Screenshot of Roles and administrators page in Microsoft Entra ID." lightbox="media/common/roles-and-administrators.png":::

1. Select the role name to open the role. Don't add a check mark next to the role.

    :::image type="content" source="media/common/role-select-mouse.png" alt-text="Screenshot that shows selecting a role." lightbox="media/common/role-select-mouse.png":::

1. Select **Add assignments**.

    If you see something different from the following screenshot, you might have Microsoft Entra ID P2. For more information, see [Assign Microsoft Entra roles in Privileged Identity Management](~/id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md).

    :::image type="content" source="media/manage-roles-portal/add-assignments-pim-groups.png" alt-text="Screenshot of Add assignments pane to assign role to users or groups." lightbox="media/manage-roles-portal/add-assignments-pim-groups.png":::

1. Select the group you want to assign to this role. Only role-assignable groups are displayed.

    If group isn't listed, you will need to create a role-assignable group. For more information, see [Create a role-assignable group in Microsoft Entra ID](groups-create-eligible.md).

1. Select **Add** to assign the role to the group.

### Assign a role using PIM

If you have [Microsoft Entra Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-configure.md) enabled, you have additional role assignment capabilities. For example, you can make a user eligible for a role or set the duration. When PIM is enabled, there are two ways that you can assign roles using the Microsoft Entra admin center. You can use the Roles and administrators page or the PIM experience. Either way uses the same PIM service.

Follow these steps to assign roles using the **Roles and administrators** page. If you want to assign roles using Privileged Identity Management, see [Assign Microsoft Entra roles in Privileged Identity Management](~/id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity** > **Roles & admins** > **Roles & admins**.

    ![Screenshot of Roles and administrators page in Microsoft Entra ID when PIM enabled.](./media/common/roles-and-administrators.png)

1. Find the role you need. You can use the search box or **Add filters** to filter the roles.

1. Select the role name to open the role and see its eligible, active, and expired role assignments. Don't add a check mark next to the role.

    ![Screenshot that shows selecting a role.](./media/common/role-select-mouse.png)

1. Select **Add assignments**.

1. Select **No member selected** and then select the users you want to assign to this role.

    ![Screenshot of Add assignments page and Select a member pane with PIM enabled.](./media/manage-roles-portal/add-assignments-pim.png)

1. Select **Next**.

1. On the **Setting** tab, select whether you want to make this role assignment **Eligible** or **Active**.

    An eligible role assignment means that the user must perform one or more actions to use the role. An active role assignment means that the user doesn't have to perform any action to use the role. For more information about what these settings mean, see [PIM terminology](~/id-governance/privileged-identity-management/pim-configure.md#terminology).

    ![Screenshot of Add assignments page and Setting tab with PIM enabled.](./media/manage-roles-portal/add-assignments-pim-setting.png)

1. Use the remaining options to set the duration for the assignment.

1. Select **Assign** to assign the role.

# [PowerShell](#tab/ms-powershell)

Follow these steps to assign Microsoft Entra roles using PowerShell.

### Setup

1. Open a PowerShell window and use [Import-Module](/powershell/module/microsoft.powershell.core/import-module) to import the Microsoft Graph PowerShell module. For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

    ```powershell
    Import-Module -Name Microsoft.Graph.Identity.Governance -Force
    ```

1. In a PowerShell window, use [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands) to sign in to your tenant.

    ```powershell
    Connect-MgGraph -Scopes "RoleManagement.ReadWrite.Directory"
    ```

1. Use [Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser) to get the user you want to assign a role to.

    ```powershell
    $user = Get-MgUser -Filter "userPrincipalName eq 'johndoe@contoso.com'"
    ```

### Assign a role to a user

1. Use [Get-MgRoleManagementDirectoryRoleDefinition](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroledefinition) to get the role you want to assign.

    ```powershell
    $roledefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq 'Billing Administrator'"
    ```

1. Use [New-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/new-mgrolemanagementdirectoryroleassignment) to assign the role.

    ```powershell
    $roleassignment = New-MgRoleManagementDirectoryRoleAssignment -DirectoryScopeId '/' -RoleDefinitionId $roledefinition.Id -PrincipalId $user.Id
    ```

### Assign a role to a group

Use the [New-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/new-mgrolemanagementdirectoryroleassignment) command to assign the role.

```powershell
$roleAssignment = New-MgRoleManagementDirectoryRoleAssignment -DirectoryScopeId '/' -RoleDefinitionId $roleDefinition.Id -PrincipalId $group.Id
```

Here is another way that you can assign a role to a group.

```powershell
$params = @{
   "directoryScopeId" = "/" 
   "principalId" = $group.Id
   "roleDefinitionId" = $roleDefinition.Id
}
$roleAssignment = New-MgRoleManagementDirectoryRoleAssignment -BodyParameter $params
```

### Assign a role as eligible using PIM

If PIM is enabled, you have additional capabilities, such as making a user eligible for a role assignment or defining the start and end time for a role assignment. These capabilities use a different set of PowerShell commands. For more information about using PowerShell and PIM, see [PowerShell for Microsoft Entra roles in Privileged Identity Management](/powershell/microsoftgraph/tutorial-pim).

1. Use [Get-MgRoleManagementDirectoryRoleDefinition](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroledefinition) to get the role you want to assign.

    ```powershell
    $roledefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq 'Billing Administrator'"
    ```

1. Use the following command to create a hash table to store all the necessary attributes required to assign the role to the user. The Principal ID will be the user ID to which you want to assign the role. In this example, the assignment will be valid only for **10 hours**.

    ```powershell
    $params = @{
      "PrincipalId" = "aaaaaaaa-bbbb-cccc-1111-222222222222"
      "RoleDefinitionId" = "b0f54661-2d74-4c50-afa3-1ec803f12efe"
      "Justification" = "Add eligible assignment"
      "DirectoryScopeId" = "/"
      "Action" = "AdminAssign"
      "ScheduleInfo" = @{
        "StartDateTime" = Get-Date
        "Expiration" = @{
          "Type" = "AfterDuration"
          "Duration" = "PT10H"
          }
        }
      }
    ```

1. Use [New-MgRoleManagementDirectoryRoleEligibilityScheduleRequest](/powershell/module/microsoft.graph.identity.governance/new-mgrolemanagementdirectoryroleeligibilityschedulerequest) to assign the role as eligible. Once the role has been assigned, it will reflect in the Microsoft Entra admin center under **Identity governance** > **Privileged Identity Management** > **Microsoft Entra roles** > **Assignments** > **Eligible Assignments** section.

    ```powershell
    New-MgRoleManagementDirectoryRoleEligibilityScheduleRequest -BodyParameter $params | Format-List Id, Status, Action, AppScopeId, DirectoryScopeId, RoleDefinitionId, IsValidationOnly, Justification, PrincipalId, CompletedDateTime, CreatedDateTime
    ```

# [Graph API](#tab/ms-graph)

Use the [Create unifiedRoleAssignment](/graph/api/rbacapplication-post-roleassignments) API to assign a role.

### Assign a role to a user

In this example, a security principal with objectID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` is assigned the Billing Administrator role (role definition ID `b0f54661-2d74-4c50-afa3-1ec803f12efe`) at tenant scope. To see the list of immutable role template IDs of all built-in roles, see [Microsoft Entra built-in roles](permissions-reference.md).

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments
Content-type: application/json

{ 
    "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
    "roleDefinitionId": "b0f54661-2d74-4c50-afa3-1ec803f12efe",
    "principalId": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
    "directoryScopeId": "/"
}
```

Response

```http
HTTP/1.1 201 Created
Content-type: application/json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleAssignments/$entity",
    "id": "<Role assignment ID>",
    "roleDefinitionId": "b0f54661-2d74-4c50-afa3-1ec803f12efe",
    "principalId": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
    "directoryScopeId": "/"
}
```

If the principal or role definition does not exist, the response is not found.

Response

```http
HTTP/1.1 404 Not Found
```

### Assign a role to a group

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments

{
    "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
    "principalId": "<Object ID of Group>",
    "roleDefinitionId": "<ID of role definition>",
    "directoryScopeId": "/"
}
```

Response

```json
HTTP/1.1 201 Created
Content-type: application/json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleAssignments/$entity",
    "id": "<Role assignment ID>",
    "roleDefinitionId": "<ID of role definition>",
    "principalId": "<Object ID of Group>",
    "directoryScopeId": "/"
}
```

### Assign a role using PIM

#### Assign a time-bound eligible role assignment

In this example, a security principal with objectID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` is assigned a time-bound eligible role assignment to Billing Administrator (role definition ID `b0f54661-2d74-4c50-afa3-1ec803f12efe`) for 180 days.

```http
POST https://graph.microsoft.com/v1.0/rolemanagement/directory/roleEligibilityScheduleRequests
Content-type: application/json

{
    "action": "adminAssign",
    "justification": "for managing admin tasks",
    "directoryScopeId": "/",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "roleDefinitionId": "b0f54661-2d74-4c50-afa3-1ec803f12efe",
    "scheduleInfo": {
        "startDateTime": "2021-07-15T19:15:08.941Z",
        "expiration": {
            "type": "afterDuration",
            "duration": "PT180D"
        }
    }
}
```

#### Assign a permanent eligible role assignment

In the following example, a security principal is assigned a permanent eligible role assignment to Billing Administrator.

```http
POST https://graph.microsoft.com/v1.0/rolemanagement/directory/roleEligibilityScheduleRequests
Content-type: application/json

{
    "action": "adminAssign",
    "justification": "for managing admin tasks",
    "directoryScopeId": "/",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "roleDefinitionId": "b0f54661-2d74-4c50-afa3-1ec803f12efe",
    "scheduleInfo": {
        "startDateTime": "2021-07-15T19:15:08.941Z",
        "expiration": {
            "type": "noExpiration"
        }
    }
}
```

#### Activate a role assignment

To activate the role assignment, use the [Create roleAssignmentScheduleRequests](/graph/api/rbacapplication-post-roleeligibilityschedulerequests) API.

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignmentScheduleRequests
Content-type: application/json

{
    "action": "selfActivate",
    "justification": "activating role assignment for admin privileges",
    "roleDefinitionId": "b0f54661-2d74-4c50-afa3-1ec803f12efe",
    "directoryScopeId": "/",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222"
}
```

For more information about managing Microsoft Entra roles through the PIM API in Microsoft Graph, see [Overview of role management through the privileged identity management (PIM) API](/graph/api/resources/privilegedidentitymanagementv3-overview).

---

## Related content

- [List Microsoft Entra role assignments](view-assignments.md)
- [Assign custom roles with resource scope using PowerShell](custom-assign-powershell.md)
- [Microsoft Entra built-in roles](permissions-reference.md)

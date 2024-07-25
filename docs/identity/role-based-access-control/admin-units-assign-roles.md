---
title: Assign or list Microsoft Entra roles with administrative unit scope
description: Use administrative units to restrict the scope of role assignments in Microsoft Entra ID.

author: rolyon
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: role-based-access-control
ms.date: 03/13/2024
ms.author: rolyon
ms.reviewer: anandy
ms.custom: oldportal, it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Assign Microsoft Entra roles with administrative unit scope

In Microsoft Entra ID, for more granular administrative control, you can assign a Microsoft Entra role with a scope that's limited to one or more administrative units. When a Microsoft Entra role is assigned at the scope of an administrative unit, role permissions apply only when managing members of the administrative unit itself, and don't apply to tenant-wide settings or configurations.

For example, an administrator who is assigned the Groups Administrator role at the scope of an administrative unit can manage groups that are members of the administrative unit, but they can't manage other groups in the tenant. They also can't manage tenant-level settings related to groups, such as expiration or group naming policies.

This article describes how to assign Microsoft Entra roles with administrative unit scope.

## Prerequisites

- Microsoft Entra ID P1 or P2 license for each administrative unit administrator
- Microsoft Entra ID Free licenses for administrative unit members
- Privileged Role Administrator
- Microsoft Graph PowerShell module when using PowerShell
- Admin consent when using Graph Explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## Roles that can be assigned with administrative unit scope

The following Microsoft Entra roles can be assigned with administrative unit scope. Additionally, any [custom role](custom-create.yml) can be assigned with administrative unit scope as long as the custom role's permissions include at least one permission relevant to users, groups, or devices.

| Role | Description |
| -----| ----------- |
| [Authentication Administrator](permissions-reference.md#authentication-administrator) | Has access to view, set, and reset authentication method information for any non-admin user in the assigned administrative unit only. |
| [Cloud Device Administrator](permissions-reference.md#cloud-device-administrator) | Limited access to manage devices in Microsoft Entra ID. |
| [Groups Administrator](permissions-reference.md#groups-administrator) | Can manage all aspects of groups in the assigned administrative unit only. |
| [Helpdesk Administrator](permissions-reference.md#helpdesk-administrator) | Can reset passwords for non-administrators in the assigned administrative unit only. |
| [License Administrator](permissions-reference.md#license-administrator) | Can assign, remove, and update license assignments within the administrative unit only. |
| [Password Administrator](permissions-reference.md#password-administrator) | Can reset passwords for non-administrators within the assigned administrative unit only. |
| [Printer Administrator](permissions-reference.md#printer-administrator) | Can manage printers and printer connectors. For more information, see [Delegate administration of printers in Universal Print](/universal-print/portal/delegated-admin#scoped-admin-vs-tenant-printer-admin). |
| [Privileged Authentication Administrator](permissions-reference.md#privileged-authentication-administrator) | Can access to view, set and reset authentication method information for any user (admin or non-admin). |
| [SharePoint Administrator](permissions-reference.md#sharepoint-administrator) | Can manage Microsoft 365 groups in the assigned administrative unit only. For SharePoint sites associated with Microsoft 365 groups in an administrative unit, can also update site properties (site name, URL, and external sharing policy) using the Microsoft 365 admin center. Cannot use the SharePoint admin center or SharePoint APIs to manage sites. |
| [Teams Administrator](permissions-reference.md#teams-administrator) | Can manage Microsoft 365 groups in the assigned administrative unit only. Can manage team members in the Microsoft 365 admin center for teams associated with groups in the assigned administrative unit only. Cannot use the Teams admin center. |
| [Teams Devices Administrator](permissions-reference.md#teams-devices-administrator) | Can perform management related tasks on Teams certified devices. |
| [User Administrator](permissions-reference.md#user-administrator) | Can manage all aspects of users and groups, including resetting passwords for limited admins within the assigned administrative unit only. Cannot currently manage users' profile photographs. |
| [&lt;Custom role&gt;](custom-create.yml) | Can perform actions that apply to users, groups, or devices, according to the definition of the custom role. |

Certain role permissions apply only to non-administrator users when assigned with the scope of an administrative unit. In other words, administrative unit scoped [Helpdesk Administrators](permissions-reference.md#helpdesk-administrator) can reset passwords for users in the administrative unit only if those users don't have administrator roles. The following list of permissions are restricted when the target of an action is another administrator:

-	Read and modify user authentication methods, or reset user passwords
-	Modify sensitive user properties such as telephone numbers, alternate email addresses, or Open Authorization (OAuth) secret keys
- Delete or restore user accounts

## Security principals that can be assigned with administrative unit scope

The following security principals can be assigned to a role with an administrative unit scope:

- Users
- Microsoft Entra role-assignable groups
- Service principals

## Service principals and guest users

Service principals and guest users won't be able to use a role assignment scoped to an administrative unit unless they're also assigned corresponding permissions to read the objects. This is because service principals and guest users don't receive directory read permissions by default, which are required to perform administrative actions. To enable a service principal or guest user to use a role assignment scoped to an administrative unit, you must assign the [Directory Readers](permissions-reference.md#directory-readers) role (or another role that includes read permissions) at a tenant scope.

It isn't currently possible to assign directory read permissions scoped to an administrative unit. For more information about default permissions for users, see [default user permissions](~/fundamentals/users-default-permissions.md). 

## Assign a role with an administrative unit scope

You can assign a Microsoft Entra role with an administrative unit scope by using the Microsoft Entra admin center, PowerShell, or Microsoft Graph.

### Microsoft Entra admin center

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity** > **Roles & admins** > **Admin units**.

1. Select the administrative unit that you want to assign a user role scope to.

1. On the left pane, select **Roles and administrators** to list all the available roles.

   ![Screenshot of the "Role and administrators" pane for selecting an administrative unit whose role scope you want to assign.](./media/admin-units-assign-roles/select-role-to-scope.png)

1. Select the role to be assigned, and then select **Add assignments**.

1. On the **Add assignments** pane, select one or more users to be assigned to the role.

   ![Select the role to scope and then select Add assignments](./media/admin-units-assign-roles/select-add-assignment.png)

> [!NOTE]
> To assign a role on an administrative unit by using Microsoft Entra Privileged Identity Management (PIM), see [Assign Microsoft Entra roles in PIM](~/id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md?tabs=new#assign-a-role-with-restricted-scope).

### PowerShell

Use the [New-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/new-mgrolemanagementdirectoryroleassignment) command and the `DirectoryScopeId` parameter to assign a role with administrative unit scope.

```powershell
$user = Get-MgUser -Filter "userPrincipalName eq 'Example_UPN'"
$roleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Example_role_name'"
$adminUnit = Get-MgDirectoryAdministrativeUnit -Filter "displayName eq 'Example_admin_unit_name'"
$directoryScope = '/administrativeUnits/' + $adminUnit.Id
$roleAssignment = New-MgRoleManagementDirectoryRoleAssignment -DirectoryScopeId $directoryScope `
   -PrincipalId $user.Id -RoleDefinitionId $roleDefinition.Id
```

### Microsoft Graph API

Use the [Add a scopedRoleMember](/graph/api/administrativeunit-post-scopedrolemembers) API to assign a role with administrative unit scope.

Request

```http
POST /directory/administrativeUnits/{admin-unit-id}/scopedRoleMembers
```

Body

```http
{
  "roleId": "roleId-value",
  "roleMemberInfo": {
    "id": "id-value"
  }
}
```

## List role assignments with administrative unit scope

You can view a list of Microsoft Entra role assignments with administrative unit scope by using the Microsoft Entra admin center, PowerShell, or Microsoft Graph.

### Microsoft Entra admin center

You can view all the role assignments created with an administrative unit scope in the **Admin units** section of the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity** > **Roles & admins** > **Admin units**.

1. Select the administrative unit for the list of role assignments you want to view.

1. Select **Roles and administrators**, and then open a role to view the assignments in the administrative unit.

### PowerShell

Use the [Get-MgDirectoryAdministrativeUnitScopedRoleMember](/powershell/module/microsoft.graph.identity.directorymanagement/get-mgdirectoryadministrativeunitscopedrolemember) command to list role assignments with administrative unit scope.

```powershell
$adminUnit = Get-MgDirectoryAdministrativeUnit -Filter "displayname eq 'Example_admin_unit_name'"
Get-MgDirectoryAdministrativeUnitScopedRoleMember -AdministrativeUnitId $adminUnit.Id | FL *
```

### Microsoft Graph API

Use the [List scopedRoleMembers](/graph/api/administrativeunit-list-scopedrolemembers) API to list role assignments with administrative unit scope.

Request

```http
GET /directory/administrativeUnits/{admin-unit-id}/scopedRoleMembers
```

Body

```http
{}
```

## Next steps

- [Use Microsoft Entra groups to manage role assignments](groups-concept.md)
- [Troubleshoot Microsoft Entra roles assigned to groups](groups-faq-troubleshooting.yml)

---
title: Assign Microsoft Entra roles
description: Learn how to assign Microsoft Entra roles to users and groups at tenant, application registration, administrative unit scopes using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API. 

author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.date: 01/03/2025
ms.author: barclayn
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Assign Microsoft Entra roles

This article describes how to assign Microsoft Entra roles to users and groups using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API. It also describes how to assign roles at different scopes, such as tenant, application registration, and administrative unit scopes.

You can assign both direct and indirect role assignments to a user. If a user is assigned a role by a group membership, add the user to the group to add the role assignment. For more information, see [Use Microsoft Entra groups to manage role assignments](groups-concept.md).

In Microsoft Entra ID, roles are typically assigned to apply to the entire tenant. However, you can also assign Microsoft Entra roles for different resources, such as application registrations or administrative units. For example, you could assign the Helpdesk Administrator role so that it just applies to a particular administrative unit and not the entire tenant. The resources that a role assignment applies to is also called the scope. Restricting the scope of a role assignment is supported for built-in and custom roles. For more information about scope, see [Overview of role-based access control (RBAC) in Microsoft Entra ID](custom-overview.md#scope).

## Microsoft Entra roles in PIM

If you have a Microsoft Entra ID P2 license and [Privileged Identity Management (PIM)](../../id-governance/privileged-identity-management/pim-configure.md), you have additional capabilities when assigning roles, such as making a user eligible for a role assignment or defining the start and end time for a role assignment. For information about assigning Microsoft Entra roles in PIM, see these articles:

| Method | Information |
| --- | --- |
| Microsoft Entra admin center | [Assign Microsoft Entra roles in Privileged Identity Management](../../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md) |
| Microsoft Graph PowerShell | [Tutorial: Assign Microsoft Entra roles in Privileged Identity Management using Microsoft Graph PowerShell](/powershell/microsoftgraph/tutorial-pim) |
| Microsoft Graph API | [Manage Microsoft Entra role assignments using PIM APIs](/graph/api/resources/privilegedidentitymanagementv3-overview)<br/>[Assign Microsoft Entra roles in Privileged Identity Management](../../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md#assign-a-role-using-microsoft-graph-api) |

## Prerequisites

- Privileged Role Administrator
- [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) module when using PowerShell
- Admin consent when using Graph Explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## Assign roles with tenant scope

This section describes how to assign roles at tenant scope.

# [Admin center](#tab/admin-center)


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](./permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Roles & admins**.

    :::image type="content" source="../../media/common/entra-roles-admins.png" alt-text="Screenshot of Roles and administrators page in Microsoft Entra admin center." lightbox="../../media/common/entra-roles-admins.png":::

1. Select a role name to open the role. Don't add a check mark next to the role.

    :::image type="content" source="../../media/common/entra-roles-admins-mouse.png" alt-text="Screenshot of Roles and administrators page with mouse over role name.":::

1. Select **Add assignments** and then select the users or groups you want to assign to this role.

    Only role-assignable groups are displayed. If a group isn't listed, you'll need to create a role-assignable group. For more information, see [Create a role-assignable group in Microsoft Entra ID](groups-create-eligible.md).

    If your experience is different than the following screenshot, you might have Microsoft Entra ID P2 and PIM. For more information, see [Assign Microsoft Entra roles in Privileged Identity Management](../../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md).

    :::image type="content" source="./media/manage-roles-portal/add-assignments.png" alt-text="Screenshot of Add assignments pane for selected role." lightbox="./media/manage-roles-portal/add-assignments.png":::

1. Select **Add** to assign the role.

# [PowerShell](#tab/ms-powershell)

Follow these steps to assign Microsoft Entra roles using PowerShell.

1. Open a PowerShell window. If necessary, use [Install-Module](/powershell/module/powershellget/install-module) to install Microsoft Graph PowerShell. For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser
    ```

1. In a PowerShell window, use [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) to sign in to your tenant.

    ```powershell
    Connect-MgGraph -Scopes "RoleManagement.ReadWrite.Directory"
    ```

1. Use [Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser) to get the user.

    ```powershell
    $user = Get-MgUser -Filter "userPrincipalName eq 'alice@contoso.com'"
    ```

    Use [Get-MgGroup](/powershell/module/microsoft.graph.groups/get-mggroup) to get the role-assignable group.

    ```powershell
    $group = Get-MgGroup -Filter "DisplayName eq 'Contoso Helpdesk'"
    ```

1. Use [Get-MgRoleManagementDirectoryRoleDefinition](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroledefinition) to get the role you want to assign.

    To see the list of role definition IDs for all built-in roles, see [Microsoft Entra built-in roles](./permissions-reference.md).

    ```powershell
    $roleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Billing Administrator'"
    ```

1. Set tenant as scope of role assignment.

    ```powershell
    $directoryScope = '/'
    ```

1. Use [New-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/new-mgrolemanagementdirectoryroleassignment) to assign the role.

    ```powershell
    $roleAssignment = New-MgRoleManagementDirectoryRoleAssignment `
       -DirectoryScopeId $directoryScope -PrincipalId $user.Id `
       -RoleDefinitionId $roleDefinition.Id
    ```

    ```powershell
    $roleAssignment = New-MgRoleManagementDirectoryRoleAssignment `
        -DirectoryScopeId $directoryScope -PrincipalId $group.Id `
        -RoleDefinitionId $roleDefinition.Id
    ```

    Here's another way that you can assign a role.

    ```powershell
    $params = @{
       "directoryScopeId" = "/" 
       "principalId" = $group.Id
       "roleDefinitionId" = $roleDefinition.Id
    }
    $roleAssignment = New-MgRoleManagementDirectoryRoleAssignment -BodyParameter $params
    ```

# [Graph API](#tab/ms-graph)

Follow these instructions to assign a role using the Microsoft Graph API in [Graph Explorer](https://aka.ms/ge).

1. Sign in to the [Graph Explorer](https://aka.ms/ge).

1. Use [List users](/graph/api/user-list) API to get the user.

    ```http
    GET https://graph.microsoft.com/v1.0/users?$filter=userPrincipalName eq 'alice@contoso.com'
    ```

    Use [List groups](/graph/api/group-list) API to get the role-assignable group.

    ```http
    GET https://graph.microsoft.com/v1.0/groups?$filter=displayName eq 'Contoso Helpdesk'
    ```

1. Use the [List unifiedRoleDefinitions](/graph/api/rbacapplication-list-roledefinitions) API to get the role you want to assign.

    To see the list of role definition IDs for all built-in roles, see [Microsoft Entra built-in roles](./permissions-reference.md).

    ```http
    GET https://graph.microsoft.com/v1.0/rolemanagement/directory/roleDefinitions?$filter=displayName eq 'Billing Administrator'
    ```

1. Use the [Create unifiedRoleAssignment](/graph/api/rbacapplication-post-roleassignments) API to assign the role.

    ```http
    POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments
    {
        "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
        "principalId": "<Object ID of user or group>",
        "roleDefinitionId": "<ID of role definition>",
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
        "roleDefinitionId": "<ID of role definition>",
        "principalId": "<Object ID of user or group>",
        "directoryScopeId": "/"
    }
    ```
    
    If the principal or role definition doesn't exist, the response is not found.
    
    Response
    
    ```http
    HTTP/1.1 404 Not Found
    ```

---

## Assign roles with app registration scope

Built-in roles and custom roles are assigned by default at tenant scope to grant access permissions over all app registrations in your organization. Additionally, custom roles and some relevant built-in roles (depending on the type of Microsoft Entra resource) can also be assigned at the scope of a single Microsoft Entra resource. This allows you to give the user the permission to update credentials and basic properties of a single app without having to create a second custom role.

This section describes how to assign roles at an application registration scope.

# [Admin center](#tab/admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Application Developer](./permissions-reference.md#application-developer).

1. Browse to **Entra ID** > **App registrations**.

1. Select an application. You can use search box to find the desired app.

    You might have to select **All applications** to see the complete list of app registrations in your tenant.

    :::image type="content" source="./media/manage-roles-portal/app-reg.png" alt-text="Screenshot of App registrations in Microsoft Entra ID." lightbox="./media/manage-roles-portal/app-reg.png":::

1. Select **Roles and administrators** from the left navigation menu to see the list of all roles available to be assigned over the app registration.
    
    :::image type="content" source="./media/manage-roles-portal/app-reg-roles.png" alt-text="Screenshot of Roles for an app registration in Microsoft Entra ID." lightbox="./media/manage-roles-portal/app-reg-roles.png":::

1. Select the desired role.

    > [!TIP]
    > You won't see the entire list of Microsoft Entra built-in or custom roles here. This is expected. We show the roles which have permissions related to managing app registrations only.

1. Select **Add assignments** and then select the users or groups you want to assign this role to.

    :::image type="content" source="./media/manage-roles-portal/app-reg-add-assignment.png" alt-text="Screenshot of Add role assignment scoped to an app registration in Microsoft Entra ID." lightbox="./media/manage-roles-portal/app-reg-add-assignment.png":::

1. Select **Add** to assign the role scoped over the app registration.

# [PowerShell](#tab/ms-powershell)

Follow these steps to assign Microsoft Entra roles at application scope using PowerShell.

1. Open a PowerShell window. If necessary, use [Install-Module](/powershell/module/powershellget/install-module) to install Microsoft Graph PowerShell. For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser
    ```

1. In a PowerShell window, use [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) to sign in to your tenant.

    ```powershell
    Connect-MgGraph -Scopes "Application.Read.All","RoleManagement.Read.Directory","User.Read.All","RoleManagement.ReadWrite.Directory"
    ```

1. Use [Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser) to get the user.

    ```powershell
    $user = Get-MgUser -Filter "userPrincipalName eq 'alice@contoso.com'"
    ```

    To assign the role to a service principal instead of a user, use the [Get-MgServicePrincipal](/powershell/module/Microsoft.Graph.Applications/Get-MgServicePrincipal) command.

1. Use [Get-MgRoleManagementDirectoryRoleDefinition](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroledefinition) to get the role you want to assign.

    ```powershell
    $roleDefinition = Get-MgRoleManagementDirectoryRoleDefinition `
       -Filter "displayName eq 'Application Administrator'"
    ```

1. Use [Get-MgApplication](/powershell/module/microsoft.graph.applications/get-mgapplication) to get the app registration you want the role assignment to be scoped to.

    ```powershell
    $appRegistration = Get-MgApplication -Filter "displayName eq 'f/128 Filter Photos'"
    $directoryScope = '/' + $appRegistration.Id
    ```

1. Use [New-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/new-mgrolemanagementdirectoryroleassignment) to assign the role.

    ```powershell
    $roleAssignment = New-MgRoleManagementDirectoryRoleAssignment `
       -DirectoryScopeId $directoryScope -PrincipalId $user.Id `
       -RoleDefinitionId $roleDefinition.Id 
    ```

# [Graph API](#tab/ms-graph)

Follow these instructions to assign a role at application scope using the Microsoft Graph API in [Graph Explorer](https://aka.ms/ge).

1. Sign in to the [Graph Explorer](https://aka.ms/ge).

1. Use [List users](/graph/api/user-list) API to get the user.

    ```http
    GET https://graph.microsoft.com/v1.0/users?$filter=userPrincipalName eq 'alice@contoso.com'
    ```

1. Use the [List unifiedRoleDefinitions](/graph/api/rbacapplication-list-roledefinitions) API to get the role you want to assign.

    ```http
    GET https://graph.microsoft.com/v1.0/rolemanagement/directory/roleDefinitions?$filter=displayName eq 'Application Administrator'
    ```

1. Use the [List applications](/graph/api/application-list) API to get the application you want the role assignment to be scoped to.

    ```http
    GET https://graph.microsoft.com/v1.0/applications?$filter=displayName eq 'f/128 Filter Photos'
    ```

1. Use the [Create unifiedRoleAssignment](/graph/api/rbacapplication-post-roleassignments) API to assign the role.

    ```http
    POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments

    {
        "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
        "principalId": "<Object ID of user>",
        "roleDefinitionId": "<ID of role definition>",
        "directoryScopeId": "/<Object ID of app registration>"
    }
    ```

    Response
    
    ```http
    HTTP/1.1 201 Created
    ```

    > [!NOTE]
    > In this example, `directoryScopeId` is specified as `/<ID>`, unlike the administrative unit section. It is by design. The scope of `/<ID>` means the principal can manage that Microsoft Entra object. The scope `/administrativeUnits/<ID>` means the principal can manage the members of the administrative unit (based on the role the principal is assigned), not the administrative unit itself.

---

## Assign roles with administrative unit scope

In Microsoft Entra ID, for more granular administrative control, you can assign a Microsoft Entra role with a scope that's limited to one or more [administrative units](./administrative-units.md). When a Microsoft Entra role is assigned at the scope of an administrative unit, role permissions apply only when managing members of the administrative unit itself, and don't apply to tenant-wide settings or configurations.

For example, an administrator who is assigned the Groups Administrator role at the scope of an administrative unit can manage groups that are members of the administrative unit, but they can't manage other groups in the tenant. They also can't manage tenant-level settings related to groups, such as expiration or group naming policies.

This section describes how to assign Microsoft Entra roles with administrative unit scope.

### Prerequisites

- Microsoft Entra ID P1 or P2 license for each administrative unit administrator
- Microsoft Entra ID Free licenses for administrative unit members
- Privileged Role Administrator
- Microsoft Graph PowerShell module when using PowerShell
- Admin consent when using Graph Explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

### Roles that can be assigned with administrative unit scope

The following Microsoft Entra roles can be assigned with administrative unit scope. Additionally, any [custom role](custom-create.md) can be assigned with administrative unit scope as long as the custom role's permissions include at least one permission relevant to users, groups, or devices.

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
| [&lt;Custom role&gt;](custom-create.md) | Can perform actions that apply to users, groups, or devices, according to the definition of the custom role. |

Certain role permissions apply only to nonadministrator users when assigned with the scope of an administrative unit. In other words, administrative unit scoped [Helpdesk Administrators](permissions-reference.md#helpdesk-administrator) can reset passwords for users in the administrative unit only if those users don't have administrator roles. The following list of permissions are restricted when the target of an action is another administrator:

- Read and modify user authentication methods, or reset user passwords
- Modify sensitive user properties such as telephone numbers, alternate email addresses, or Open Authorization (OAuth) secret keys
- Delete or restore user accounts

### Security principals that can be assigned with administrative unit scope

The following security principals can be assigned to a role with an administrative unit scope:

- Users
- Microsoft Entra role-assignable groups
- Service principals

### Service principals and guest users

Service principals and guest users won't be able to use a role assignment scoped to an administrative unit unless they're also assigned corresponding permissions to read the objects. This is because service principals and guest users don't receive directory read permissions by default, which are required to perform administrative actions. To enable a service principal or guest user to use a role assignment scoped to an administrative unit, you must assign the [Directory Readers](permissions-reference.md#directory-readers) role (or another role that includes read permissions) at a tenant scope.

It isn't currently possible to assign directory read permissions scoped to an administrative unit. For more information about default permissions for users, see [default user permissions](../../fundamentals/users-default-permissions.md). 

### Assign roles with administrative unit scope

This section describes how to assign roles at administrative unit scope.

# [Admin center](#tab/admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](./permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Roles & admins** > **Admin units**.

1. Select an administrative unit.

    :::image type="content" source="./media/manage-roles-portal/admin-units.png" alt-text="Screenshot of administrative units in Microsoft Entra ID." lightbox="./media/manage-roles-portal/admin-units.png":::

1. Select **Roles and administrators** from the left navigation menu to see the list of all roles available to be assigned over an administrative unit.
    
    :::image type="content" source="./media/manage-roles-portal/admin-units-roles.png" alt-text="Screenshot of Roles and administrators menu under administrative units in Microsoft Entra ID." lightbox="./media/manage-roles-portal/admin-units-roles.png":::

1. Select the desired role.

    > [!TIP]
    > You won't see the entire list of Microsoft Entra built-in or custom roles here. This is expected. We show the roles which have permissions related to the objects that are supported within the administrative unit. To see the list of objects supported within an administrative unit, see [Administrative units in Microsoft Entra ID](administrative-units.md).

1. Select **Add assignments** and then select the users or groups you want to assign this role to.

1. Select **Add** to assign the role scoped over the administrative unit.

# [PowerShell](#tab/ms-powershell)

Follow these steps to assign Microsoft Entra roles at administrative unit scope using PowerShell.

1. Open a PowerShell window. If necessary, use [Install-Module](/powershell/module/powershellget/install-module) to install Microsoft Graph PowerShell. For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser
    ```

1. In a PowerShell window, use [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) to sign in to your tenant.

    ```powershell
    Connect-MgGraph -Scopes "Directory.Read.All","RoleManagement.Read.Directory","User.Read.All","RoleManagement.ReadWrite.Directory"
    ```

1. Use [Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser) to get the user.

    ```powershell
    $user = Get-MgUser -Filter "userPrincipalName eq 'alice@contoso.com'"
    ```

1. Use [Get-MgRoleManagementDirectoryRoleDefinition](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroledefinition) to get the role you want to assign.

    ```powershell
    $roleDefinition = Get-MgRoleManagementDirectoryRoleDefinition `
       -Filter "displayName eq 'User Administrator'"
    ```

1. Use [Get-MgDirectoryAdministrativeUnit](/powershell/module/microsoft.graph.identity.directorymanagement/get-mgdirectoryadministrativeunit) to get the administrative unit you want the role assignment to be scoped to.

    ```powershell
    $adminUnit = Get-MgDirectoryAdministrativeUnit -Filter "displayName eq 'Seattle Admin Unit'"
    $directoryScope = '/administrativeUnits/' + $adminUnit.Id
    ```

1. Use [New-MgRoleManagementDirectoryRoleAssignment](/powershell/module/microsoft.graph.identity.governance/new-mgrolemanagementdirectoryroleassignment) to assign the role.

    ```powershell
    $roleAssignment = New-MgRoleManagementDirectoryRoleAssignment `
       -DirectoryScopeId $directoryScope -PrincipalId $user.Id `
       -RoleDefinitionId $roleDefinition.Id
    ```

# [Graph API](#tab/ms-graph)

Follow these instructions to assign a role at administrative unit scope using the Microsoft Graph API in [Graph Explorer](https://aka.ms/ge).

#### Assign role using Create unifiedRoleAssignment API

1. Sign in to the [Graph Explorer](https://aka.ms/ge).

1. Use [List users](/graph/api/user-list) API to get the user.

    ```http
    GET https://graph.microsoft.com/v1.0/users?$filter=userPrincipalName eq 'alice@contoso.com'
    ```

1. Use the [List unifiedRoleDefinitions](/graph/api/rbacapplication-list-roledefinitions) API to get the role you want to assign.

    ```http
    GET https://graph.microsoft.com/v1.0/rolemanagement/directory/roleDefinitions?$filter=displayName eq 'User Administrator'
    ```

1. Use the [List administrativeUnits](/graph/api/directory-list-administrativeunits) API to get the administrative unit you want the role assignment to be scoped to.

    ```http
    GET https://graph.microsoft.com/v1.0/directory/administrativeUnits?$filter=displayName eq 'Seattle Admin Unit'
    ```

1. Use the [Create unifiedRoleAssignment](/graph/api/rbacapplication-post-roleassignments) API to assign the role.

    ```http
    POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments
    {
        "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
        "principalId": "<Object ID of user>",
        "roleDefinitionId": "<ID of role definition>",
        "directoryScopeId": "/administrativeUnits/<Object ID of administrative unit>"
    }
    ```

    Response
    
    ```http
    HTTP/1.1 201 Created
    ```

    If the role isn't supported, the response is bad request.

    ```http
    HTTP/1.1 400 Bad Request
    {
        "odata.error":
        {
            "code":"Request_BadRequest",
            "message":
            {
                "message":"The given built-in role is not supported to be assigned to a single resource scope."
            }
        }
    }
    ```

    > [!NOTE]
    > In this example, `directoryScopeId` is specified as `/administrativeUnits/<ID>`, instead of `/<ID>`. It is by design. The scope `/administrativeUnits/<ID>` means the principal can manage the members of the administrative unit (based on the role that the principal is assigned), not the administrative unit itself. The scope of `/<ID>` means the principal can manage that Microsoft Entra object itself. In the app registration section, you see that the scope is `/<ID>` because a role scoped over an app registration grants the privilege to manage the object itself.

#### Assign role using Add a scopedRoleMember API

Alternatively, you can use the [Add a scopedRoleMember](/graph/api/administrativeunit-post-scopedrolemembers) API to assign a role with administrative unit scope.

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

---

## Next steps

- [List Microsoft Entra role assignments](view-assignments.md)
- [Assign Microsoft Entra roles in Privileged Identity Management](../../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md)
- [Use Microsoft Entra groups to manage role assignments](groups-concept.md)
- [Troubleshoot Microsoft Entra roles assigned to groups](groups-faq-troubleshooting.yml)

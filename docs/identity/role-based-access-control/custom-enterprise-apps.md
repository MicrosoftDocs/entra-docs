---
title: Create custom roles to manage enterprise apps in Microsoft Entra ID
description: Create and assign custom Microsoft Entra roles for enterprise apps access in Microsoft Entra ID

author: rolyon
manager: amycolannino
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.date: 02/04/2022
ms.author: rolyon
ms.reviewer: vincesm
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done

---

# Create custom roles to manage enterprise apps in Microsoft Entra ID

This article explains how to create a custom role with permissions to manage enterprise app assignments for users and groups in Microsoft Entra ID. For the elements of roles assignments and the meaning of terms such as subtype, permission, and property set, see the [custom roles overview](custom-overview.md).

## Prerequisites

- Microsoft Entra ID P1 or P2 license
- Privileged Role Administrator
- Microsoft Graph PowerShell SDK installed when using PowerShell
- Admin consent when using Graph explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## Enterprise app role permissions

There are two enterprise app permissions discussed in this article. All examples use the update permission.

* To read the user and group assignments at scope, grant the `microsoft.directory/servicePrincipals/appRoleAssignedTo/read` permission
* To manage the user and group assignments at scope, grant the `microsoft.directory/servicePrincipals/appRoleAssignedTo/update` permission

Granting the update permission results in the assignee being able to manage assignments of users and groups to enterprise apps. The scope of user and/or group assignments can be granted for a single application or granted for all applications. If granted at an organization-wide level, the assignee can manage assignments for all applications. If made at an application level, the assignee can manage assignments for only the specified application.

Granting the update permission is done in two steps:

1. Create a custom role with permission `microsoft.directory/servicePrincipals/appRoleAssignedTo/update`
1. Grant users or groups permissions to manage user and group assignments to enterprise apps. This is when you can set the scope to the organization-wide level or to a single application.

## Microsoft Entra admin center

### Create a new custom role

[!INCLUDE [portal updates](~/includes/portal-update.md)]

In the Microsoft Entra Admin Center, you can create and manage custom roles to control access and permissions for enterprise apps.

>[!NOTE]
> Custom roles are created and managed at an organization-wide level and are available only from the organization's Overview page.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity** > **Roles & admins** > **Roles & admins**.

1. Select **New custom role**.

    ![Add a new custom role from the roles list in Microsoft Entra ID](./media/custom-enterprise-apps/new-custom-role.png)

1. On the **Basics** tab, provide "Manage user and group assignments" for the name of the role and "Grant permissions to manage user and group assignments" for the role description, then select **Next**.

    ![Provide a name and description for the custom role](./media/custom-enterprise-apps/role-name-and-description.png)

1. On the **Permissions** tab, enter "microsoft.directory/servicePrincipals/appRoleAssignedTo/update" in the search box, select the checkboxes next to the desired permissions, then select **Next**.

    ![Add the permissions to the custom role](./media/custom-enterprise-apps/role-custom-permissions.png)

1. On the **Review + create** tab, review the permissions and select **Create**.

    ![Now you can create the custom role](./media/custom-enterprise-apps/role-custom-create.png)

### Assign the role to a user using the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity** > **Roles & admins** > **Roles & admins**.

1. Select the **Manage user and group assignments** role.

    ![Open Roles and Administrators and search for the custom role](./media/custom-enterprise-apps/select-custom-role.png)

1. Select **Add assignment**, select the desired user, and then click **Select** to add role assignment to the user.

    ![Add an assignment for the custom role to the user](./media/custom-enterprise-apps/assign-user-to-role.png)

#### Assignment tips

* To grant permissions to assignees to manage users and group access for all enterprise apps organization-wide, start from the organization-wide **Roles and Administrators** list on the Microsoft Entra ID **Overview** page for your organization.
* To grant permissions to assignees to manage users and group access for a specific enterprise app, go to that app in Microsoft Entra ID and open in the **Roles and Administrators** list for that app. Select the new custom role and complete the user or group assignment. The assignees can manage users and group access only for the specific app.
* To test your custom role assignment, sign in as the assignee and open an application’s **Users and groups** page to verify that the **Add user** option is enabled.

    ![Verify the user permissions](./media/custom-enterprise-apps/verify-user-permissions.png)

## PowerShell

For more detail, see [Create and assign a custom role in Microsoft Entra ID](custom-create.yml) and [Assign custom roles with resource scope using PowerShell](custom-assign-powershell.md).

### Create a custom role

Create a new role using the following PowerShell script:

```PowerShell
# Basic role information
$description = "Can manage user and group assignments for Applications"
$displayName = "Manage user and group assignments"
$templateId = (New-Guid).Guid

# Set of permissions to grant
$allowedResourceAction = @("microsoft.directory/servicePrincipals/appRoleAssignedTo/update")
$rolePermission = @{'allowedResourceActions'= $allowedResourceAction}
$rolePermissions = $rolePermission

# Create new custom admin role
$customRole = New-MgRoleManagementDirectoryRoleDefinition -Description $description `
   -DisplayName $displayName -RolePermissions $rolePermissions -TemplateId $templateId -IsEnabled
```

### Assign the custom role

Assign the role using this PowerShell script.

```powershell
# Get the user and role definition you want to link
$user =  Get-MgUser -Filter "userPrincipalName eq 'chandra@example.com'"
$roleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Manage user and group assignments'"

# Get app registration and construct scope for assignment.
$appRegistration = Get-MgApplication -Filter "displayName eq 'My Filter Photos'"
$directoryScope = '/' + $appRegistration.Id

# Create a scoped role assignment
$roleAssignment = New-MgRoleManagementDirectoryRoleAssignment -DirectoryScopeId $directoryScope `
   -PrincipalId $user.Id -RoleDefinitionId $roleDefinition.Id
```

## Microsoft Graph API

Use the [Create unifiedRoleDefinition](/graph/api/rbacapplication-post-roledefinitions) API to create a custom role. For more information, see [Create and assign a custom role in Microsoft Entra ID](custom-create.yml) and [Assign custom admin roles using the Microsoft Graph API](custom-assign-graph.md).

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions

{
    "description": "Can manage user and group assignments for Applications.",
    "displayName": "Manage user and group assignments",
    "isEnabled": true,
    "rolePermissions":
    [
        {
            "allowedResourceActions":
            [
                "microsoft.directory/servicePrincipals/appRoleAssignedTo/update"
            ]
        }
    ],
    "templateId": "<PROVIDE NEW GUID HERE>",
    "version": "1"
}
```

### Assign the custom role using the Microsoft Graph API

Use the [Create unifiedRoleAssignment](/graph/api/rbacapplication-post-roleassignments) API to assign the custom role. The role assignment combines a security principal ID (which can be a user or service principal), a role definition ID, and a Microsoft Entra resource scope. For more information on the elements of a role assignment, see the [custom roles overview](custom-overview.md)

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments

{
    "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
    "principalId": "<PROVIDE OBJECTID OF USER TO ASSIGN HERE>",
    "roleDefinitionId": "<PROVIDE OBJECTID OF ROLE DEFINITION HERE>",
    "directoryScopeId": "/"
}
```

## Next steps

* [Explore the available custom role permissions for enterprise apps](custom-enterprise-app-permissions.md)

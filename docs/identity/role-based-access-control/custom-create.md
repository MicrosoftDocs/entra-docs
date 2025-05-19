---
title: Create a custom role in Microsoft Entra ID
description: Learn how to create a custom role to manage access to Microsoft Entra resources using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API
author: rolyon
ms.author: rolyon
manager: femila
ms.reviewer: vincesm
ms.date: 05/19/2025
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Create a custom role in Microsoft Entra ID

This article describes how to create a custom role to manage access to Microsoft Entra resources using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API. If you want to instead create a custom role to manage access to Azure resources, see [Create or update Azure custom roles using the Azure portal](/azure/role-based-access-control/custom-roles-portal).

For the basics of custom roles, see the [custom roles overview](custom-overview.md). The role can be assigned either at the directory-level scope or an app registration resource scope only. For information about the maximum number of custom roles that can be created in a Microsoft Entra organization, see [Microsoft Entra service limits and restrictions](~/identity/users/directory-service-limits-restrictions.md).

## Prerequisites

- Microsoft Entra ID P1 or P2 license
- Privileged Role Administrator
- [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) module when using PowerShell
- Admin consent when using Graph explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

# [Admin center](#tab/admin-center)

### Create a custom role

These steps describe how to create a custom role in the Microsoft Entra admin center to manage app registrations.


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Roles & admins**.

1. Select **New custom role**.

    :::image type="content" source="../../media/common/entra-roles-admins.png" alt-text="Screenshot of Roles and administrators page in Microsoft Entra admin center." lightbox="../../media/common/entra-roles-admins.png":::

1. On the **Basics** tab, provide a name and description for the role.

    You can clone the baseline permissions from a custom role but you can't clone a built-in role.

    :::image type="content" source="./media/custom-create/basics-tab.png" alt-text="Screenshot of Basics tab to provide a name and description for a custom role." lightbox="./media/custom-create/basics-tab.png":::

1. On the **Permissions** tab, select the permissions necessary to manage basic properties and credential properties of app registrations. For a detailed description of each permission, see [Application registration subtypes and permissions in Microsoft Entra ID](custom-available-permissions.md).

    1. First, enter "credentials" in the search bar and select the `microsoft.directory/applications/credentials/update` permission.

        :::image type="content" source="./media/custom-create/permissions-tab.png" alt-text="Screenshot of Permissions tab to select the permissions for a custom role." lightbox="./media/custom-create/permissions-tab.png":::

    1. Next, enter "basic" in the search bar, select the `microsoft.directory/applications/basic/update` permission, and then click **Next**.

1. On the **Review + create** tab, review the permissions and select **Create**.

    Your custom role will show up in the list of available roles to assign.

# [PowerShell](#tab/ms-powershell)

### Sign in

Use the [Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph) command to sign in to your tenant.

``` PowerShell
Connect-MgGraph -Scopes "RoleManagement.ReadWrite.Directory"
```

### Create a custom role

Create a new role using the following PowerShell script:

``` PowerShell
# Basic role information
$displayName = "Application Support Administrator"
$description = "Can manage basic aspects of application registrations."
$templateId = (New-Guid).Guid
      
# Set of permissions to grant
$rolePermissions = @{
    "allowedResourceActions" = @(
        "microsoft.directory/applications/basic/update",
        "microsoft.directory/applications/credentials/update"
    )
}
      
# Create new custom admin role
$customAdmin = New-MgRoleManagementDirectoryRoleDefinition -RolePermissions $rolePermissions `
    -DisplayName $displayName -Description $description -TemplateId $templateId -IsEnabled:$true
```

### Update a custom role

```powershell
# Update role definition
# This works for any writable property on role definition. You can replace display name with other
# valid properties.
Update-MgRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId c4e39bd9-1100-46d3-8c65-fb160da0071f `
   -DisplayName "Updated DisplayName"
```

### Delete a custom role

```powershell
# Delete role definition
Remove-MgRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId c4e39bd9-1100-46d3-8c65-fb160da0071f
```

# [Graph API](#tab/ms-graph)

### Create a custom role

Follow these steps:

1. Use the [Create unifiedRoleDefinition](/graph/api/rbacapplication-post-roledefinitions) API to create a custom role.

    ``` HTTP
    POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions
    ```
    
    Body
    
    ``` HTTP
    {
        "description": "Can manage basic aspects of application registrations.",
        "displayName": "Application Support Administrator",
        "isEnabled": true,
        "templateId": "<GUID>",
        "rolePermissions": [
            {
                "allowedResourceActions": [
                    "microsoft.directory/applications/basic/update",
                    "microsoft.directory/applications/credentials/update"
                ]
            }
        ]
    }
    ```
    
    > [!Note]
    > The `"templateId": "GUID"` is an optional parameter that's sent in the body depending on the requirement. If you have a requirement to create multiple different custom roles with common parameters, it's best to create a template and define a `templateId` value. You can generate a `templateId` value beforehand by using the PowerShell cmdlet `(New-Guid).Guid`. 


1. Use the [Create unifiedRoleAssignment](/graph/api/rbacapplication-post-roleassignments) API to assign the custom role.

    ```http
    POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments
    ```
    
    Body
    
    ```http
    {
    "principalId":"<GUID OF USER>",
    "roleDefinitionId":"<GUID OF ROLE DEFINITION>",
    "directoryScopeId":"/<GUID OF APPLICATION REGISTRATION>"
    }
    ```

---

## Related content

- [Assign Microsoft Entra roles](manage-roles-portal.md)
- [Microsoft Entra built-in roles](permissions-reference.md)
- [Comparison of default guest and member user permissions](~/fundamentals/users-default-permissions.md?context=azure/active-directory/roles/context/ugr-context)

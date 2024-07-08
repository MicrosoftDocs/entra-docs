---
title: Assign custom roles using PowerShell in Microsoft Entra ID
description: Manage members of a Microsoft Entra administrator custom role with Microsoft Entra ID PowerShell.

author: rolyon
manager: amycolannino
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.date: 05/10/2022
ms.author: rolyon
ms.reviewer: vincesm
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Assign custom roles with resource scope using PowerShell in Microsoft Entra ID

This article describes how to create a role assignment at organization-wide scope in Microsoft Entra ID. Assigning a role at organization-wide scope grants access across the Microsoft Entra organization. To create a role assignment with a scope of a single Microsoft Entra resource, see [Create and assign a custom role in Microsoft Entra ID](custom-create.yml). This article uses the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation) module.

For more information about Microsoft Entra roles, see [Microsoft Entra built-in roles](permissions-reference.md).

## Prerequisites

- Microsoft Entra ID P1 or P2 license
- Privileged Role Administrator
- Microsoft Graph PowerShell module when using PowerShell

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## Assign a directory role to a user or service principal with resource scope

1. Load the [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) module.
1. Sign in by executing the command `Connect-MgGraph`.
1. Create a new role using the following PowerShell script.

   ```powershell
   ## Assign a role to a user or service principal with resource scope
   # Get the user and role definition you want to link
   $user = Get-MgUser -Filter "UserPrincipalName eq 'cburl@f128.info'"
   $roleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq 'Application Support Administrator'"

   # Get app registration and construct resource scope for assignment.
   $appRegistration = Get-MgApplication -Filter "displayName eq 'f/128 Filter Photos'"
   $directoryScope = '/' + $appRegistration.Id

   # Create a scoped role assignment
   $roleAssignment = New-MgRoleManagementDirectoryRoleAssignment -DirectoryScopeId $directoryScope `
      -RoleDefinitionId $roleDefinition.Id -PrincipalId $user.Id
   ```

To assign the role to a service principal instead of a user, use the [Get-MgServicePrincipal](/powershell/module/Microsoft.Graph.Applications/Get-MgServicePrincipal) cmdlet.

## Role definitions

Role definition objects contain the definition of the built-in or custom role, along with the permissions that are granted by that role assignment. This resource displays both custom role definitions and built-in directory roles (which are displayed in roleDefinition equivalent form). For information about the maximum number of custom roles that can be created in a Microsoft Entra organization, see [Microsoft Entra service limits and restrictions](~/identity/users/directory-service-limits-restrictions.md).

### Create a role definition

```powershell
# Basic information
$description = "Can manage credentials of application registrations"
$displayName = "Application Registration Credential Administrator"
$templateId = (New-Guid).Guid

# Set of actions to include
$rolePermissions = @{
    "allowedResourceActions" = @(
        "microsoft.directory/applications/standard/read",
        "microsoft.directory/applications/credentials/update"
    )
}

# Create new custom directory role
$customAdmin = New-MgRoleManagementDirectoryRoleDefinition -RolePermissions $rolePermissions `
   -DisplayName $displayName -Description $description -TemplateId $templateId -IsEnabled:$true
```

### Read and list role definitions

```powershell
# Get all role definitions
Get-MgRoleManagementDirectoryRoleDefinition

# Get single role definition by ID
Get-MgRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId 00000000-0000-0000-0000-000000000000

# Get single role definition by templateId
Get-MgRoleManagementDirectoryRoleDefinition -Filter "TemplateId eq 'c4e39bd9-1100-46d3-8c65-fb160da0071f'"
```

### Update a role definition

```powershell
# Update role definition
# This works for any writable property on role definition. You can replace display name with other
# valid properties.
Update-MgRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId c4e39bd9-1100-46d3-8c65-fb160da0071f `
   -DisplayName "Updated DisplayName"
```

### Delete a role definition

```powershell
# Delete role definition
Remove-MgRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId c4e39bd9-1100-46d3-8c65-fb160da0071f
```

## Role assignments

Role assignments contain information linking a given security principal (a user or application service principal) to a role definition. If required, you can add a scope of a single Microsoft Entra resource for the assigned permissions.  Restricting the scope of a role assignment is supported for built-in and custom roles.

### Create a role assignment

```powershell
# Get the user and role definition you want to link
$user = Get-MgUser -Filter "userPrincipalName eq 'cburl@f128.info'"
$roleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq 'Application Support Administrator'"

# Get app registration and construct resource scope for assignment.
$appRegistration = Get-MgApplication -Filter "displayName eq 'f/128 Filter Photos'"
$directoryScope = '/' + $appRegistration.Id

# Create a scoped role assignment
$roleAssignment = New-MgRoleManagementDirectoryRoleAssignment -DirectoryScopeId $directoryScope `
   -RoleDefinitionId $roleDefinition.Id -PrincipalId $user.Id
```

### Read and list role assignments

```powershell
# Get role assignments for a given principal
Get-MgRoleManagementDirectoryRoleAssignment -Filter "PrincipalId eq 'aaaaaaaa-bbbb-cccc-1111-222222222222'"

# Get role assignments for a given role definition 
Get-MgRoleManagementDirectoryRoleAssignment -Filter "RoleDefinitionId eq '00000000-0000-0000-0000-000000000000'"
```

### Remove a role assignment

```powershell
# Remove role assignment
Remove-MgRoleManagementDirectoryRoleAssignment -UnifiedRoleAssignmentId 'aB1cD2eF3gH4iJ5kL6-mN7oP8qR-1'
```

## Next steps

- Share with us on the [Microsoft Entra administrative roles forum](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789)
- For more about roles and Microsoft Entra administrator role assignments, see [Assign administrator roles](permissions-reference.md)
- For default user permissions, see a [comparison of default guest and member user permissions](~/fundamentals/users-default-permissions.md)

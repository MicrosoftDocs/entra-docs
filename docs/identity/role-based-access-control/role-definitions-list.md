---
title: List Microsoft Entra role definitions
description: Learn how to list Microsoft Entra built-in and custom role definitions and their permissions using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API.
author: rolyon
manager: femila
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.date: 01/03/2025
ms.author: rolyon
ms.reviewer: absinh
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sfi-image-nochange
---
# List Microsoft Entra role definitions

This article describes how to list the Microsoft Entra built-in and custom role definitions and their permissions using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API.

A role definition is a collection of permissions that can be performed, such as read, write, and delete. It's typically referred to as a role. Microsoft Entra ID has over 100 built-in roles or you can create your own custom roles. If you ever wondered "What do these roles really do?", you can access a detailed list of permissions for each of the roles.

## Prerequisites

- [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) module when using PowerShell
- Admin consent when using Graph explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## List Microsoft Entra role definitions

# [Admin center](#tab/admin-center)


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Entra ID** > **Roles & admins**.

    :::image type="content" source="../../media/common/entra-roles-admins.png" alt-text="Screenshot of Roles and administrators page in Microsoft Entra admin center." lightbox="../../media/common/entra-roles-admins.png":::

1. Select a role name to open the role. Don't add a check mark next to the role.

    :::image type="content" source="../../media/common/entra-roles-admins-mouse.png" alt-text="Screenshot of Roles and administrators page with mouse over role name.":::

1. Select **Description** to see the summary and list of permissions for the role.

    The page includes links to relevant documentation to help guide you through managing roles.

    :::image type="content" source="./media/role-definitions-list/roles-admins-description.png" alt-text="Screenshot of Roles and administrators page that shows role description." lightbox="./media/role-definitions-list/roles-admins-description.png":::

# [PowerShell](#tab/ms-powershell)

Follow these steps to list Microsoft Entra roles with PowerShell.

1. Open a PowerShell window. If necessary, use [Install-Module](/powershell/module/powershellget/install-module) to install Microsoft Graph PowerShell. For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser
    ```

2. In a PowerShell window, use [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) to sign in to your tenant.

    ```powershell
    Connect-MgGraph -Scopes "RoleManagement.Read.All"
    ```

3. Use [Get-MgRoleManagementDirectoryRoleDefinition](/powershell/module/microsoft.graph.identity.governance/get-mgrolemanagementdirectoryroledefinition) to get roles.

    ```powershell
    # Get all role definitions
    Get-MgRoleManagementDirectoryRoleDefinition
    
    # Get single role definition by ID
    Get-MgRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId 00000000-0000-0000-0000-000000000000
    
    # Get single role definition by templateId
    Get-MgRoleManagementDirectoryRoleDefinition -Filter "TemplateId eq 'c4e39bd9-1100-46d3-8c65-fb160da0071f'"

    # Get role definition by displayName
    Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Helpdesk Administrator'"
    ```

4. To view the list of permissions of a role, use the following cmdlet.

    ```powershell
    # Do this avoid truncation of the list of permissions
    $FormatEnumerationLimit = -1
    
    (Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Conditional Access Administrator'").RolePermissions | Format-list
    ```

# [Graph API](#tab/ms-graph)

Follow these instructions to list Microsoft Entra roles using the Microsoft Graph API in [Graph Explorer](https://aka.ms/ge).

1. Sign in to the [Graph Explorer](https://aka.ms/ge).

1. Select **GET** as the HTTP method from the dropdown. 

1. Select the API version to **v1.0**.

1. Use the [List unifiedRoleDefinitions](/graph/api/rbacapplication-list-roledefinitions) API to list all role definitions.

    ```http
    GET https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions
    ```

    To list a specific role by displayName, use this format.

    ```http
    GET https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions?$filter = displayName eq 'Helpdesk Administrator'
    ```

1. Select **Run query** to list the roles.

    Here's an example of the response.

    ```http
    {
        "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleDefinitions",
        "value": [
            {
                "id": "729827e3-9c14-49f7-bb1b-9608f156bbb8",
                "description": "Can reset passwords for non-administrators and Helpdesk Administrators.",
                "displayName": "Helpdesk Administrator",
                "isBuiltIn": true,
                "isEnabled": true,
                "resourceScopes": [
                    "/"
                ],
    
        ...
    
    ```
    
1. To view permissions of a role, use the following API.

   ```http
   GET https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions?$filter=DisplayName eq 'Conditional Access Administrator'&$select=rolePermissions
   ```

---

## Next steps

* [List Microsoft Entra role assignments](view-assignments.md)
* [Assign Microsoft Entra roles](manage-roles-portal.md)
* [Microsoft Entra built-in roles](permissions-reference.md)

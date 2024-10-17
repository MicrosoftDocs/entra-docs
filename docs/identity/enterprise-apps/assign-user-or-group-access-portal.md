---
title: Manage users and groups assignment to an application
description: Learn how to assign and unassign users, and groups, for an app using Microsoft Entra ID for identity management.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 10/17/2024
ms.author: jomondi
ms.reviewer: ergreenl
ms.custom: enterprise-apps, has-azure-ad-ps-ref
zone_pivot_groups: enterprise-apps-all

#customer intent: As an IT admin managing user access to enterprise applications, I want to assign users and groups to an application, so that I can control access and provide easy access to applications for users.
---

# Manage users and groups assignment to an application

This article shows you how to assign users and groups to an enterprise application in Microsoft Entra ID using PowerShell. When you assign a user to an application, the application appears in the user's [My Apps](https://myapps.microsoft.com/) portal for easy access. If the application exposes app roles, you can also assign a specific app role to the user.

When you assign a group to an application, only users in the group have access. The assignment doesn't cascade to nested groups.

Group-based assignment requires Microsoft Entra ID P1 or P2 edition. Group-based assignment is supported for Security groups, Microsoft 365 groups, and Distribution groups whose `SecurityEnabled` setting is set to `True` only. Nested group memberships aren't currently supported. For more licensing requirements for the features discussed in this article, see the [Microsoft Entra pricing page](https://azure.microsoft.com/pricing/details/active-directory).

For greater control, certain types of enterprise applications can be configured to require user assignment. For more information on requiring user assignment for an app, see [Manage access to an application](what-is-access-management.md#requiring-user-assignment-for-an-app).

> [!NOTE]
> Applications that requires users to be assigned to the application must have their permissions consented by an administrator, even if the user consent policies for your directory would otherwise allow a user to consent on behalf of themselves.

## Prerequisites

To assign users to an enterprise application, you need:

- A Microsoft Entra account with an active subscription. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, Application Administrator, or owner of the service principal.
- Microsoft Entra ID P1 or P2 for group-based assignment. For more licensing requirements for the features discussed in this article, see the [Microsoft Entra pricing page](https://azure.microsoft.com/pricing/details/active-directory).

:::zone pivot="portal"

[!INCLUDE [portal updates](~/includes/portal-update.md)]

## Assign users and groups to an application using the Microsoft Entra admin center

To assign a user or group account to an enterprise application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. Select **Users and groups**, and then select **Add user/group**.

    :::image type="content" source="media/add-application-portal-assign-users/assign-user.png" alt-text="Assign user account to an application in your Microsoft Entra tenant.":::

1. On the **Add Assignment** pane, select **None Selected** under **Users and groups**.
1. Search for and select the user or group that you want to assign to the application. For example, `contosouser1@contoso.com` or `contosoteam1@contoso.com`.
1. Select **Select**.
1. Under **Select a role**, select the role that you want to assign to the user or group. If you haven't defined any roles yet, the default role is **Default Access**.
1. On the **Add Assignment** pane, select **Assign** to assign the user or group to the application.

## Unassign users, and groups, from an application

1. Follow the steps on the [Assign users, and groups, to an application](#assign-users-and-groups-to-an-application-using-the-microsoft-entra-admin-center) section to navigate to the **Users and groups** pane.
1. Search for and select the user or group that you want to unassign from the application.
1. Select **Remove** to unassign the user or group from the application.

:::zone-end

:::zone pivot="aad-powershell"

## Assign users and groups to an application using Azure AD PowerShell

1. Open an elevated Windows PowerShell command prompt.
1. Run `Connect-AzureAD` and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Use the following script to assign a user to an application:

    ```powershell
    # Assign the values to the variables
    $username = "<Your user's UPN>"
    $app_name = "<Your App's display name>"
    $app_role_name = "<App role display name>"

    # Get the user to assign, and the service principal for the app to assign to
    $user = Get-AzureADUser -ObjectId "$username"
    $sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
    $appRole = $sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }

    # Assign the user to the app role
    New-AzureADUserAppRoleAssignment -ObjectId $user.ObjectId -PrincipalId $user.ObjectId -ResourceId $sp.ObjectId -Id $appRole.Id
    ```

### Example

This example assigns the user Britta Simon to the Microsoft Workplace Analytics application using PowerShell.

1. In PowerShell, assign the corresponding values to the variables `$username`, `$app_name` and `$app_role_name`.

    ```powershell
    $username = "britta.simon@contoso.com"
    $app_name = "Workplace Analytics"
    ```

1. In this example, we don't know what is the exact name of the application role we want to assign to Britta Simon. Run the following commands to get the user (`$user`) and the service principal (`$sp`) using the user UPN and the service principal display names.

    ```powershell
    $user = Get-AzureADUser -ObjectId "$username"
    $sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
    ```

1. Run the following command to find the app roles exposed by the service principal

    ```powershell
    $appRoles = $sp.AppRoles
    # Display the app roles
    $appRoles | ForEach-Object {
        Write-Output "AppRole: $($_.DisplayName) - ID: $($_.Id)"
    ```

    > [!NOTE]
    >The default AppRole ID is `00000000-0000-0000-0000-000000000000`. This role is assigned when no specific AppRole is defined for a service principal.
 
1. Assign the AppRole name to the `$app_role_name` variable. In this example, we want to assign Britta Simon the Analyst (Limited access) Role.

    ```powershell
    $app_role_name = "Analyst (Limited access)"
    $appRole = $sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }
    ```

1. Run the following command to assign the user to the app role.

    ```powershell
    New-AzureADUserAppRoleAssignment -ObjectId $user.ObjectId -PrincipalId $user.ObjectId -ResourceId $sp.ObjectId -Id $appRole.Id
    ```

To assign a group to an enterprise app, replace `Get-AzureADUser` with `Get-AzureADGroup` and replace `New-AzureADUserAppRoleAssignment` with `New-AzureADGroupAppRoleAssignment`.

For more information on how to assign a group to an application role, see the documentation for [New-AzureADGroupAppRoleAssignment](/powershell/module/azuread/new-azureadgroupapproleassignment).

## Unassign users and groups from an application using Azure AD PowerShell

1. Open an elevated Windows PowerShell command prompt.
1. Run `Connect-AzureAD` and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Use the following script to remove a user and role from an application.

    ```powershell
    # Store the proper parameters
    $user = get-azureaduser -ObjectId <objectId>
    $spo = Get-AzureADServicePrincipal -ObjectId <objectId>

    #Get the ID of role assignment 
    $assignments = Get-AzureADServiceAppRoleAssignment -ObjectId $spo.ObjectId | Where {$_.PrincipalDisplayName -eq $user.DisplayName}

    #if you run the following, it will show you what is assigned what
    $assignments | Select *

    #To remove the App role assignment run the following command.
    Remove-AzureADServiceAppRoleAssignment -ObjectId $spo.ObjectId -AppRoleAssignmentId $assignments[assignment number].ObjectId
    ```

## Remove all users who are assigned to the application using Azure AD PowerShell

1. Open an elevated Windows PowerShell command prompt.

Use the following script to remove all users and groups assigned to the application.

```powershell
#Retrieve the service principal object ID.
$app_name = "<Your App's display name>"
$sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
$sp.ObjectId

# Get Service Principal using objectId
$sp = Get-AzureADServicePrincipal -ObjectId "<ServicePrincipal objectID>"

# Get Azure AD App role assignments using objectId of the Service Principal
$assignments = Get-AzureADServiceAppRoleAssignment -ObjectId $sp.ObjectId -All $true

# Remove all users and groups assigned to the application
$assignments | ForEach-Object {
    if ($_.PrincipalType -eq "User") {
        Remove-AzureADUserAppRoleAssignment -ObjectId $_.PrincipalId -AppRoleAssignmentId $_.ObjectId
    } elseif ($_.PrincipalType -eq "Group") {
        Remove-AzureADGroupAppRoleAssignment -ObjectId $_.PrincipalId -AppRoleAssignmentId $_.ObjectId
    }
}
```

:::zone-end

:::zone pivot="ms-powershell"

## Assign users and groups to an application using Microsoft Graph PowerShell

1. Open an elevated Windows PowerShell command prompt.
1. Run `Connect-MgGraph -Scopes "Application.ReadWrite.All", "Directory.ReadWrite.All", "AppRoleAssignment.ReadWrite.All"` and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Use the following script to assign a user to an application:

    ```powershell
    #Assign the values to the variables
    $userId = "<Your user's ID>"
    $app_name = "<Your App's display name>"
    $app_role_name = "<App role display name>"
    $sp = Get-MgServicePrincipal -Filter "displayName eq '$app_name'"

    #Get the user, the service principal and appRole.
    $params = @{
    "PrincipalId" =$userId
    "ResourceId" =$sp.Id
    "AppRoleId" =($sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }).Id
    }
    #Assign the user to the AppRole
    New-MgUserAppRoleAssignment -UserId $userId -BodyParameter $params |
        Format-List Id, AppRoleId, CreationTime, PrincipalDisplayName,
        PrincipalId, PrincipalType, ResourceDisplayName, ResourceId
    ```

### Example

This example assigns the user Britta Simon to the Microsoft Workplace Analytics application using Microsoft Graph PowerShell. 
  
1. In PowerShell, assign the corresponding values to the variables `$userId`, `$app_name`, and `$app_role_name`.
  
    ```powershell  
    # Assign the values to the variables  
    $userId = "<Britta Simon's user ID>"  
    $app_name = "Workplace Analytics"  
    ```  
   
1. In this example, we don't know the exact name of the application role we want to assign to Britta Simon. Run the following command to get the service principal ($sp) using the service principal display name.  
  
    ```powershell  
    # Get the service principal for the app  
    $sp = Get-MgServicePrincipal -Filter "displayName eq '$app_name'"  
    ```  
   
1. Run the following command to find the app roles exposed by the service principal.  
  
    ```powershell  
    # Get the app roles exposed by the service principal  
    $appRoles = $sp.AppRoles  
    # Display the app roles  
    $appRoles | ForEach-Object {  
        Write-Output "AppRole: $($_.DisplayName) - ID: $($_.Id)"  
    }  
    ```  
  
    > [!NOTE]  
    > The default AppRole ID is `00000000-0000-0000-0000-000000000000`. This role is assigned when no specific AppRole is defined for a service principal.  
   
1. Assign the role name to the `$app_role_name` variable. In this example, we want to assign Britta Simon the Analyst (Limited access) Role.  
  
    ```powershell  
    # Assign the values to the variables  
    $app_role_name = "Analyst (Limited access)"  
    $appRoleId = ($sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }).Id  
    ```  
   
1. Prepare the parameters and run the following command to assign the user to the app role.  
  
    ```powershell  
    # Prepare parameters for the role assignment  
    $params = @{  
        "PrincipalId" = $userId  
        "ResourceId" = $sp.Id  
        "AppRoleId" = $appRoleId  
    }  
  
    # Assign the user to the app role  
    New-MgUserAppRoleAssignment -UserId $userId -BodyParameter $params |   
        Format-List Id, AppRoleId, CreationTime, PrincipalDisplayName,   
        PrincipalId, PrincipalType, ResourceDisplayName, ResourceId  
    ```

To assign a group to an enterprise app, replace `Get-MgUser` with `Get-MgGroup` and replace `New-MgUserAppRoleAssignment` with `New-MgGroupAppRoleAssignment`.
    
For more information on how to assign a group to an application role, see the documentation for [New-MgGroupAppRoleAssignment](https://learn.microsoft.com/powershell/module/microsoft.graph.applications/new-mggroupapproleassignment).

## Unassign users and groups from an application using Microsoft Graph PowerShell

1. Open an elevated Windows PowerShell command prompt.

1. Run `Connect-MgGraph -Scopes "Application.ReadWrite.All", "Directory.ReadWrite.All", "AppRoleAssignment.ReadWrite.All"` and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Get the user and the service principal

    ```powershell
    $user = Get-MgUser -UserId <userid>
    $sp = Get-MgServicePrincipal -ServicePrincipalId <ServicePrincipalId>
    ```
1. Get the ID of the role assignment

    ```powershell
    $assignments = Get-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $sp.Id | Where {$_.PrincipalDisplayName -eq $user.DisplayName}
    ```
1. Run the following command to show the list of users assigned to the application

    ```powershell   
    $assignments | Select *
    ```

1. Run the following command to remove the Approle assignment.

    ```powershell   
    Remove-MgServicePrincipalAppRoleAssignedTo -AppRoleAssignmentId  '<AppRoleAssignment-id>' -ServicePrincipalId $sp.Id
    ```

## Remove all users and groups assigned to the application using Microsoft Graph PowerShell

Run the following command to remove all users and groups assigned to the application.

```powershell
$assignments | ForEach-Object {
    if ($_.PrincipalType -in ("user", "Group")) {
        Remove-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $sp.Id -AppRoleAssignmentId $_.Id  }
}
```

:::zone-end

:::zone pivot="ms-graph"

## Assign users and groups to an application using Microsoft Graph API

1. To assign users and groups to an application, sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer)as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

    You need to consent to the following permissions:

    `Application.ReadWrite.All`, `Directory.ReadWrite.All`, and `AppRoleAssignment.ReadWrite.All`.

    To grant an app role assignment, you need three identifiers:

    - `principalId`: The ID of the user or group to which you're assigning the app role.
    - `resourceId`: The ID of the resource servicePrincipal that defines the app role.
    - `appRoleId`: The ID of the appRole (defined on the resource service principal) to assign to a user or group.

1. Get the enterprise application. Filter by `DisplayName`.

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=displayName eq '{appDisplayName}'
    ```

    Record the following values from the response body:

    - Object ID of the enterprise application
    - AppRole ID that you assign to the user. If the application doesn't expose any roles, the user is assigned the default access role.

    > [!NOTE]
    >The default AppRole ID is `00000000-0000-0000-0000-000000000000`. This role is assigned when no specific AppRole is defined for a service principal.

1. Get the user by filtering by the user's principal name. Record the object ID of the user.

    ```http
    GET https://graph.microsoft.com/v1.0/users/{userPrincipalName}
    ```

1. Assign the user to the application. 
   
    ```http
    POST https://graph.microsoft.com/v1.0/servicePrincipals/{resource-servicePrincipal-id}/appRoleAssignedTo

    {
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "resourceId": "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1",
    "appRoleId": "00000000-0000-0000-0000-000000000000"
    }
    ```

    In the example, both the `resource-servicePrincipal-id` and `resourceId` represent the enterprise application.

## Unassign users and groups from an application using Microsoft Graph API

To unassign all users and groups from the application, run the following query.

1. Get the enterprise application. Filter by `displayName`.

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=displayName eq '{appDisplayName}'
    ```

1. Get the list of `appRoleAssignments` for the application.

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals/{id}/appRoleAssignedTo
    ```

1. Remove the `appRoleAssignments` by specifying the `appRoleAssignment` ID.

    ```http
    DELETE https://graph.microsoft.com/v1.0/servicePrincipals/{resource-servicePrincipal-id}/appRoleAssignedTo/{appRoleAssignment-id}
    ```
Microsoft Graph Explorer doesn't support batch deletion of app role assignments directly. You need to delete each assignment individually. However, you can automate this process using [Microsoft Graph PowerShell](#unassign-users-and-groups-from-an-application-using-microsoft-graph-powershell) to iterate through and remove each assignment

:::zone-end

## Next steps

- [Assign custom security attributes](custom-security-attributes-apps.md)
- [Disable user sign-in](disable-user-sign-in-portal.md).

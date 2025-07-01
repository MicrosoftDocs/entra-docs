---
title: Review permissions granted to enterprise applications
description: Learn how to review and revoke permissions, and invalidate refresh tokens for an application in Microsoft Entra ID.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 03/03/2025
ms.author: jomondi
ms.reviewer: phsignor
zone_pivot_groups: enterprise-apps-all
ms.collection: M365-identity-device-management
ms.custom: enterprise-apps, no-azure-ad-ps-ref

#customer intent: As an IT admin, I want to review and revoke permissions granted to applications in my Microsoft Entra tenant, so that I can ensure that only necessary permissions are granted and prevent malicious applications from accessing sensitive data.
---

# Review permissions granted to enterprise applications

In this article, you learn how to review permissions granted to applications in your Microsoft Entra tenant. You might need to review permissions when you detect a malicious application, or one that has more permissions than is necessary. You learn how to revoke permissions granted to the application using Microsoft Graph API and existing versions of PowerShell.

The steps in this article apply to all applications that were added to your Microsoft Entra tenant via user or admin consent. For more information on consenting to applications, see [User and admin consent](user-admin-consent-overview.md).

## Prerequisites

To review permissions granted to applications, you need:

- A Microsoft Entra account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles:
  - Cloud Application Administrator
  - Application Administrator.
  - A Service principal owner who isn't an administrator is able to invalidate refresh tokens.

:::zone pivot="portal"

## Review and revoke permissions in the Microsoft Entra admin center


You can access the Microsoft Entra admin center to view the permissions granted to an app. You can revoke permissions granted by admins for your entire organization, and you can get contextual PowerShell scripts to perform other actions.

For information on how to restore revoked or deleted permissions, see [Restore permissions granted to applications](restore-permissions.md).

To review an application's permissions granted for the entire organization or to a specific user or group:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Select the application that you want to restrict access to.
1. Select **Permissions**. 
1. To view permissions that apply to your entire organization, select the **Admin consent** tab. To view permissions granted to a specific user or group, select the **User consent** tab.
1. To view the details of a given permission, select the permission from the list. The **Permission Details** pane opens.
   After reviewing the permissions granted to an application, you can revoke permissions granted by admins for your entire organization. 
   > [!NOTE]
   > You can't revoke permissions in the **User consent** tab using the portal. You can revoke these permissions using Microsoft Graph API calls or PowerShell cmdlets. Go to the PowerShell and Microsoft Graph tabs of this article for more information.

To revoke permissions in the **Admin consent** tab:

1. View the list of permissions in the **Admin consent** tab.
1. Choose the permission you would like to revoke, then select the **...** control for that permission.
   :::image type="content" source="media/manage-application-permissions/revoke-permissions.png" alt-text="Screenshot shows how to revoke admin consent.":::
1.  Select **Revoke permission**.

:::zone-end

:::zone pivot="entra-powershell"

## Review and revoke permissions using Microsoft Entra PowerShell

Use the following Microsoft Entra PowerShell script to revoke all permissions granted to an application. You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

```powershell
Connect-Entra -scopes "Application.ReadWrite.All", "DelegatedPermissionGrant.ReadWrite.All", "AppRoleAssignment.ReadWrite.All" 

# Get Service Principal using objectId
$app_name = "<app-displayName>"
$sp = Get-EntraServicePrincipal -Filter "displayName eq '$app_name'"

# Get all delegated permissions for the service principal
$spOAuth2PermissionsGrants = Get-EntraOAuth2PermissionGrant -All | Where-Object { $_.clientId -eq $sp.ObjectId }

# Remove all delegated permissions granted to the service principal
$spOAuth2PermissionsGrants | ForEach-Object {
    Remove-EntraOAuth2PermissionGrant -ObjectId $_.ObjectId
}

# Get all application permissions for the service principal
$spApplicationPermissions = Get-EntraServicePrincipalAppRoleAssignment -ObjectId $sp.ObjectId -All | Where-Object { $_.PrincipalType -eq "ServicePrincipal" }

# Remove all application permissions
$spApplicationPermissions | ForEach-Object {
    Remove-EntraServicePrincipalAppRoleAssignment -ObjectId $_.PrincipalId -AppRoleAssignmentId $_.objectId
}
```

## Remove all user and group assignments using Microsoft Entra PowerShell

Remove appRoleAssignments for users or groups to the application using the following scripts. 

```powershell
connect-entra -scopes "Application.ReadWrite.All", "AppRoleAssignment.ReadWrite.All"
#Retrieve the service principal object ID.
$app_name = "<Your App's display name>"
$sp = Get-EntraServicePrincipal -Filter "displayName eq '$app_name'"
$sp.ObjectId

# Get Microsoft Entra App role assignments using objectId of the Service Principal
$assignments = Get-EntraServicePrincipalAppRoleAssignedTo -ObjectId $sp.ObjectId -All $true

# Remove all users and groups assigned to the application
$assignments | ForEach-Object {
    if ($_.PrincipalType -eq "User") {
        Remove-EntraUserAppRoleAssignment -ObjectId $_.PrincipalId -AppRoleAssignmentId $_.ObjectId
    } elseif ($_.PrincipalType -eq "Group") {
        Remove-EntraGroupAppRoleAssignment -ObjectId $_.PrincipalId -AppRoleAssignmentId $_.ObjectId
    }
}
```
:::zone-end

:::zone pivot="ms-powershell"

## Review and revoke permissions using Microsoft Graph PowerShell

Use the following Microsoft Graph PowerShell script to revoke all permissions granted to an application. You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

```powershell
Connect-MgGraph -Scopes "Application.ReadWrite.All", "Directory.ReadWrite.All", "DelegatedPermissionGrant.ReadWrite.All", "AppRoleAssignment.ReadWrite.All"

# Get Service Principal using objectId
$sp = Get-MgServicePrincipal -ServicePrincipalID "<ServicePrincipal objectID>"

Example: Get-MgServicePrincipal -ServicePrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222'

# Get all delegated permissions for the service principal
$spOAuth2PermissionsGrants= Get-MgOauth2PermissionGrant -All| Where-Object { $_.clientId -eq $sp.Id }

# Remove all delegated permissions
$spOauth2PermissionsGrants |ForEach-Object {
  Remove-MgOauth2PermissionGrant -OAuth2PermissionGrantId $_.Id
}

# Get all application permissions for the service principal
$spApplicationPermissions = Get-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $Sp.Id -All | Where-Object { $_.PrincipalType -eq "ServicePrincipal" }

# Remove all application permissions
$spApplicationPermissions | ForEach-Object {
Remove-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $Sp.Id  -AppRoleAssignmentId $_.Id
}
``` 

## Remove all user and group assignments using Microsoft Graph PowerShell

Remove appRoleAssignments for users or groups to the application using the following scripts.

```powershell
Connect-MgGraph -Scopes "Application.ReadWrite.All", "Directory.ReadWrite.All", "AppRoleAssignment.ReadWrite.All"

# Get Service Principal using objectId
$sp = Get-MgServicePrincipal -ServicePrincipalID "<ServicePrincipal objectID>"

Example: Get-MgServicePrincipal -ServicePrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222'

# Get Microsoft Entra App role assignments using objectID of the Service Principal
$spApplicationPermissions = Get-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalID $sp.Id -All | Where-Object { $_.PrincipalType -eq "ServicePrincipal" }
  
# Revoke refresh token for all users assigned to the application
  $spApplicationPermissions | ForEach-Object {
  Remove-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $_.PrincipalId -AppRoleAssignmentId $_.Id
}
```

:::zone-end

:::zone pivot = "ms-graph"

## Review and revoke permissions using Microsoft Graph

To review permissions, Sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

You need to consent to the following permissions: 

`Application.ReadWrite.All`, `Directory.ReadWrite.All`, `DelegatedPermissionGrant.ReadWrite.All`, `AppRoleAssignment.ReadWrite.All`.

### Delegated permissions

Run the following queries to review delegated permissions granted to an application.

1. Get service principal using the object ID.

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals/{id}
    ```
 
   Example:

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals/00001111-aaaa-2222-bbbb-3333cccc4444
    ```

1. Get all delegated permissions for the service principal

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals/{id}/oauth2PermissionGrants
    ```
1. Remove delegated permissions using oAuth2PermissionGrants ID.

    ```http
    DELETE https://graph.microsoft.com/v1.0/oAuth2PermissionGrants/{id}
    ```

### Application permissions

Run the following queries to review application permissions granted to an application.

1. Get all application permissions for the service principal

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals/{servicePrincipal-id}/appRoleAssignments
    ```
1. Remove application permissions using appRoleAssignment ID

    ```http
    DELETE https://graph.microsoft.com/v1.0/servicePrincipals/{resource-servicePrincipal-id}/appRoleAssignedTo/{appRoleAssignment-id}
    ```

## Remove all user and group assignments using Microsoft Graph

Run the following queries to remove appRoleAssignments of users or groups to the application.

1. Get Service Principal using objectID.

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals/{id}
    ```
   Example:

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals/aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
    ```
1. Get Microsoft Entra App role assignments using objectID of the Service Principal.

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals/{servicePrincipal-id}/appRoleAssignedTo
    ```
1. Revoke refresh token for users and groups assigned to the application using appRoleAssignment ID.

    ```http
    DELETE https://graph.microsoft.com/v1.0/servicePrincipals/{servicePrincipal-id}/appRoleAssignedTo/{appRoleAssignment-id}
    ```
:::zone-end

> [!NOTE]
> Revoking the current granted permission doesn't stop users from re-consenting to the application's requested permissions. You need to [stop the application from requesting the permissions through dynamic consent](~/identity-platform/howto-update-permissions.md). If you want to block users from consenting altogether, read [Configure how users consent to applications](configure-user-consent.md).

## Other authorization to consider

Delegated and application permissions aren't the only ways to grant applications and users access to protected resources. Admins should be aware of other authorization systems that might grant access to sensitive information. Examples of various authorization systems at Microsoft include [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference), [Exchange RBAC](/exchange/permissions-exo/application-rbac), and [Teams resource-specific consent](/microsoftteams/platform/graph-api/rsc/resource-specific-consent).

## Related content

- [Configure user consent setting](configure-user-consent.md)
- [Configure admin consent workflow](configure-admin-consent-workflow.md)
- [Restore revoked permissions](restore-permissions.md)

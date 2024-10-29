---
title: Grant tenant-wide admin consent to an application 
description: Learn how to grant tenant-wide consent to an application so that end-users aren't prompted for consent when signing in to an application.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 12/20/2023
ms.author: jomondi
ms.reviewer: ergreenl
ms.collection: M365-identity-device-management
ms.custom:  enterprise-apps
zone_pivot_groups: enterprise-apps-minus-former-powershell

#customer intent: As an administrator, I want to grant tenant-wide admin consent to an application, so that the application can access the permissions requested on behalf of the whole organization.
---

# Grant tenant-wide admin consent to an application

In this article, you learn how to grant tenant-wide admin consent to an application in Microsoft Entra ID. To understand how to configure individual user consent settings, see [Configure how end-users consent to applications](configure-user-consent.md).

When you grant tenant-wide admin consent to an application, you give the application access to the permissions requested on behalf of the whole organization. Granting admin consent on behalf of an organization is a sensitive operation, potentially allowing the application's publisher access to significant portions of your organization's data, or the permission to do highly privileged operations. Examples of such operations might be role management, full access to all mailboxes or all sites, and full user impersonation. Therefore you need to carefully review the permissions that the application is requesting before you grant consent.

By default, granting tenant-wide admin consent to an application allows all users to access the application unless otherwise restricted. To restrict which users can sign-in to an application, configure the app to [require user assignment](application-properties.md#assignment-required) and then [assign users or groups to the application](assign-user-or-group-access-portal.md).

> [!IMPORTANT]
> Granting tenant-wide admin consent may revoke permissions that have already been granted tenant-wide for that application. Permissions that users have already granted on their own behalf aren't affected.

## Prerequisites

Granting tenant-wide admin consent requires you to sign in as a user that is authorized to consent on behalf of the organization.

To grant tenant-wide admin consent, you need:

- A Microsoft Entra user account with one of the following roles:

  - Privileged Role Administrator, for granting consent for apps requesting any permission, for any API.
  - Cloud Application Administrator or Application Administrator, for granting consent for apps requesting any permission for any API, *except* Microsoft Graph app roles (application permissions).
  - A custom directory role that includes the [permission to grant permissions to applications](~/identity/role-based-access-control/custom-consent-permissions.md), for the permissions required by the application.

:::zone pivot="portal"

## Grant tenant-wide admin consent in Enterprise apps pane

You can grant tenant-wide admin consent through the **Enterprise applications** pane if the application has already been provisioned in your tenant. For example, an app could be provisioned in your tenant if at least one user has already consented to the application. For more information, see [How and why applications are added to Microsoft Entra ID](~/identity-platform/how-applications-are-added.md).

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To grant tenant-wide admin consent to an app listed in **Enterprise applications** pane:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. Select **Permissions** under **Security**.
   :::image type="content" source="media/grant-tenant-wide-admin-consent/grant-tenant-wide-admin-consent.png" alt-text="Screenshot shows how to grant tenant-wide admin consent.":::
1. Carefully review the permissions that the application requires. If you agree with the permissions the application requires, select **Grant admin consent**.

## Grant admin consent in App registrations pane

You can grant tenant-wide admin consent from **App registrations** in the Microsoft Entra admin center for applications your organization has developed and registered directly in your Microsoft Entra tenant.

To grant tenant-wide admin consent from **App registrations**:

1. On the Microsoft Entra admin center, browse to **Identity** > **Applications** > **App registrations** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. Select **API permissions** under **Manage**.
1. Carefully review the permissions that the application requires. If you agree, select **Grant admin consent**.

## Construct the URL for granting tenant-wide admin consent

When you grant tenant-wide admin consent using either method described in the previous section, a window opens from the Microsoft Entra admin center to prompt for tenant-wide admin consent. If you know the client ID (also known as the application ID) of the application, you can build the same URL to grant tenant-wide admin consent.

The tenant-wide admin consent URL follows the following format:

```http
https://login.microsoftonline.com/{organization}/adminconsent?client_id={client-id}
```

where:

- `{client-id}` is the application's client ID (also known as app ID).
- `{organization}` is the tenant ID or any verified domain name of the tenant you want to consent the application in. You can use the value `organizations`that causes the consent to happen in the home tenant of the user you sign in with.

As always, carefully review the permissions an application requests before granting consent.

For more information on constructing the tenant-wide admin consent URL, see [Admin consent on the Microsoft identity platform](~/identity-platform/v2-admin-consent.md).

:::zone-end

:::zone pivot="ms-powershell"

## Grant admin consent for delegated permissions using Microsoft Graph PowerShell

In this section, you grant delegated permissions to your application. Delegated permissions are permissions your application needs to access an API on behalf of a signed-in user. The permissions are defined by a resource API and granted to your enterprise application, which is the client application. This consent is granted on behalf of all users.

In the following example, the resource API is Microsoft Graph of object ID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`. The Microsoft Graph API defines the delegated permissions, `User.Read.All` and `Group.Read.All`. The consentType is `AllPrincipals`, indicating that you're consenting on behalf of all users in the tenant. The object ID of the client enterprise application is `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

> [!CAUTION]
> Be careful! Permissions granted programmatically aren't subject to review or confirmation. They take effect immediately.

1. Connect to Microsoft Graph PowerShell and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

   ```powershell
   Connect-MgGraph -Scopes "Application.ReadWrite.All", "DelegatedPermissionGrant.ReadWrite.All"
   ```

1. Retrieve all the delegated permissions defined by Microsoft graph (the resource application) in your tenant application. Identify the delegated permissions that you need to grant the client application. In this example, the delegation permissions are `User.Read.All` and `Group.Read.All`

   ```powershell
   Get-MgServicePrincipal -Filter "displayName eq 'Microsoft Graph'" -Property Oauth2PermissionScopes | Select -ExpandProperty Oauth2PermissionScopes | fl
   ```

1. Grant the delegated permissions to the client enterprise application by running the following request.

   ```powershell
   $params = @{
   
   "ClientId" = "00001111-aaaa-2222-bbbb-3333cccc4444"
   "ConsentType" = "AllPrincipals"
   "ResourceId" = "ffffffff-eeee-dddd-cccc-bbbbbbbbbbb0"
   "Scope" = "User.Read.All Group.Read.All"
   }

   New-MgOauth2PermissionGrant -BodyParameter $params | 
   Format-List Id, ClientId, ConsentType, ResourceId, Scope
   ```

1. Confirm that you've granted tenant wide admin consent by running the following request.

  ```powershell
   Get-MgOauth2PermissionGrant -Filter "clientId eq '00001111-aaaa-2222-bbbb-3333cccc4444' and consentType eq 'AllPrincipals'" 
  ```

## Grant admin consent for application permissions using Microsoft Graph PowerShell

In this section, you grant application permissions to your enterprise application. Application permissions are permissions your application needs to access a resource API. The permissions are defined by the resource API and granted to your enterprise application, which is the principal application. After you've granted your application access to the resource API, it runs as a background service or daemon without a signed-in user. Application permissions are also known as app roles.

In the following example, you grant the Microsoft Graph application (the principal of ID `aaaaaaaa-bbbb-cccc-1111-222222222222`) an app role (application permission) of ID `df021288-bdef-4463-88db-98f22de89214` that's exposed by a resource API of ID `11112222-bbbb-3333-cccc-4444dddd5555`.

1. Connect to Microsoft Graph PowerShell and sign in as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

   ```powershell
   Connect-MgGraph -Scopes "Application.ReadWrite.All", "AppRoleAssignment.ReadWrite.All"
   ```

1. Retrieve the app roles defined by Microsoft graph in your tenant. Identify the app role that you need to grant the client enterprise application. In this example, the app role ID is `df021288-bdef-4463-88db-98f22de89214`.

   ```powershell
   Get-MgServicePrincipal -Filter "displayName eq 'Microsoft Graph'" -Property AppRoles | Select -ExpandProperty appRoles |fl
   ```
  
1. Grant the application permission (app role) to the principal application by running the following request.

```powershell
 $params = @{
  "PrincipalId" ="aaaaaaaa-bbbb-cccc-1111-222222222222"
  "ResourceId" = "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
  "AppRoleId" = "df021288-bdef-4463-88db-98f22de89214"
}

New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -BodyParameter $params | 
  Format-List Id, AppRoleId, CreatedDateTime, PrincipalDisplayName, PrincipalId, PrincipalType, ResourceDisplayName
```

:::zone-end

:::zone pivot="ms-graph"

Use [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to grant both delegated and application permissions.

## Grant admin consent for delegated permissions using Microsoft Graph API

In this section, you grant delegated permissions to your application. Delegated permissions are permissions your application needs to access an API on behalf of a signed-in user. The permissions are defined by a resource API and granted to your enterprise application, which is the client application. This consent is granted on behalf of all users.

You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

In the following example, the resource API is Microsoft Graph of object ID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`. The Microsoft Graph API defines the delegated permissions, `User.Read.All` and `Group.Read.All`. The consentType is `AllPrincipals`, indicating that you're consenting on behalf of all users in the tenant. The object ID of the client enterprise application is `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

> [!CAUTION]
> Be careful! Permissions granted programmatically are not subject to review or confirmation. They take effect immediately.

1. Retrieve all the delegated permissions defined by Microsoft graph (the resource application) in your tenant application. Identify the delegated permissions that you need to grant the client application. In this example, the delegation permissions are `User.Read.All` and `Group.Read.All`

   ```http
   GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=displayName eq 'Microsoft Graph'&$select=id,displayName,appId,oauth2PermissionScopes
   ```

1. Grant the delegated permissions to the client enterprise application by running the following request.

   ```http
   POST https://graph.microsoft.com/v1.0/oauth2PermissionGrants
   
   Request body
   {
      "clientId": "00001111-aaaa-2222-bbbb-3333cccc4444",
      "consentType": "AllPrincipals",
      "resourceId": "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1",
      "scope": "User.Read.All Group.Read.All"
   }
   ```

1. Confirm that you've granted tenant wide admin consent by running the following request.

   ```http
   GET https://graph.microsoft.com/v1.0/oauth2PermissionGrants?$filter=clientId eq '00001111-aaaa-2222-bbbb-3333cccc4444' and consentType eq 'AllPrincipals'
   ```

## Grant admin consent for application permissions using Microsoft Graph API

In this section, you grant application permissions to your enterprise application. Application permissions are permissions your application needs to access a resource API. The permissions are defined by the resource API and granted to your enterprise application, which is the principal application. After you've granted your application access to the resource API, it runs as a background service or daemon without a signed-in user. Application permissions are also known as app roles.

In the following example, you grant the application, Microsoft Graph (the principal of ID `00001111-aaaa-2222-bbbb-3333cccc4444`) an app role (application permission) of ID `df021288-bdef-4463-88db-98f22de89214` that's exposed by a resource enterprise application of ID `11112222-bbbb-3333-cccc-4444dddd5555`.

You need to sign as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Retrieve the app roles defined by Microsoft graph in your tenant. Identify the app role that you need to grant the client enterprise application. In this example, the app role ID is `df021288-bdef-4463-88db-98f22de89214`

   ```http
   GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=displayName eq 'Microsoft Graph'&$select=id,displayName,appId,appRoles
   ```

1. Grant the application permission (app role) to the principal application by running the following request.

   ```http
   POST https://graph.microsoft.com/v1.0/servicePrincipals/11112222-bbbb-3333-cccc-4444dddd5555/appRoleAssignedTo
   
   Request body

   {
      "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
      "resourceId": "ffffffff-eeee-dddd-cccc-bbbbbbbbbbb0",
      "appRoleId": "df021288-bdef-4463-88db-98f22de89214"
   }
   ```

:::zone-end

## Next steps

- [Configure how end-users consent to applications](configure-user-consent.md).
- [Configure the admin consent workflow](configure-admin-consent-workflow.md).

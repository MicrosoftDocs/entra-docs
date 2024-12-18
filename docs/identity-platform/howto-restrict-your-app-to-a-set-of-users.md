---
title: Restrict a Microsoft Entra app to a set of users
description: Learn how to restrict access to your apps registered in Microsoft Entra ID to a selected set of users.

author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 07/19/2024
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: how-to
#Customer intent: As a tenant administrator, I want to know how to restrict a Microsoft Entra application to a select set of users available in my Microsoft Entra tenant
---

# Restrict a Microsoft Entra app to a set of users

Applications registered in a Microsoft Entra tenant are, by default, available to all users of the tenant who authenticate successfully. To restrict your application to a set of users, you can configure your application to require user assignment. Users and services attempting to access the application or services need to be assigned to the application, or they won't be able to sign-in or obtain an access token.

Similarly, in a [multitenant](howto-convert-app-to-be-multi-tenant.md) application, all users in the Microsoft Entra tenant where the application is provisioned can access the application once they successfully authenticate in their respective tenant.

Tenant administrators and developers often have requirements where an application must be restricted to a certain set of users or apps (services). There are two ways to restrict an application to a certain set of users, apps or security groups:

- Developers can use popular authorization patterns like [Azure role-based access control (Azure RBAC)](howto-implement-rbac-for-apps.md).
- Tenant administrators and developers can use built-in feature of Microsoft Entra ID.

## Prerequisites

- A Microsoft Entra user account. If you don't already have one, [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- An [application registered in your Microsoft Entra tenant](quickstart-register-app.md)
- You must be the application owner or be at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) in your tenant.

## Supported app configurations

The option to restrict an app to a specific set of users, apps or security groups in a tenant works with the following types of applications:

- Applications configured for federated single sign-on with SAML-based authentication.
- Application proxy applications that use Microsoft Entra preauthentication.
- Applications built directly on the Microsoft Entra application platform that use OAuth 2.0/OpenID Connect authentication after a user or admin has consented to that application.

## Update the app to require user assignment

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To update an application to require user assignment, you must be owner of the application under Enterprise apps, or be at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="./media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant containing the app registration from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **Enterprise applications**, then select **All applications**.
1. Select the application you want to configure to require assignment. Use the filters at the top of the window to search for a specific application.
1. On the application's **Overview** page, under **Manage**, select **Properties**.
1. Locate the setting **Assignment required?** and set it to **Yes**.
1. Select **Save** on the top bar.

When an application requires assignment, user consent for that application isn't allowed. This is true even if users consent for that app would have otherwise been allowed. Be sure to [grant tenant-wide admin consent](~/identity/enterprise-apps/grant-admin-consent.md) to apps that require assignment.

## Assign the app to users and groups to restrict access

Once you've configured your app to enable user assignment, you can go ahead and assign the app to users and groups.

1. Under **Manage**, select the **Users and groups** then select **Add user/group**.
1. Under **Users**, select **None Selected**, and the **Users** selector pane opens, where you can select multiple users and groups.
1. Once you're done adding the users and groups, select **Select**.
    1. (Optional) If you have defined app roles in your application, you can use the **Select role** option to assign the app role to the selected users and groups.
1. Select **Assign** to complete the assignments of the app to the users and groups.
1. On return to the **Users and groups** page, the newly added users and groups appear in the updated list.

## Restrict access to an app (resource) by assigning other services (client apps)

Follow the steps in this section to secure app-to-app authentication access for your tenant.

1. Navigate to Service Principal sign-in logs in your tenant to find services authenticating to access resources in your tenant.
1. Check using app ID if a Service Principal exists for both resource and client apps in your tenant that you wish to manage access.

    ```powershell
    Get-MgServicePrincipal `
    -Filter "AppId eq '$appId'"
    ```

1. Create a Service Principal using app ID, if it doesn't exist:

    ```powershell
    New-MgServicePrincipal `
    -AppId $appId
    ```

1. Explicitly assign client apps to resource apps (this functionality is available only in API and not in the Microsoft Entra admin center):

    ```powershell
    $clientAppId = “[guid]”
                   $clientId = (Get-MgServicePrincipal -Filter "AppId eq '$clientAppId'").Id
    New-MgServicePrincipalAppRoleAssignment `
    -ServicePrincipalId $clientId `
    -PrincipalId $clientId `
    -ResourceId (Get-MgServicePrincipal -Filter "AppId eq '$appId'").Id `
    -AppRoleId "00000000-0000-0000-0000-000000000000"
    ```

1. Require assignment for the resource application to restrict access only to the explicitly assigned users or services.
      
      ```powershell
      Update-MgServicePrincipal -ServicePrincipalId (Get-MgServicePrincipal -Filter "AppId eq '$appId'").Id -AppRoleAssignmentRequired:$true
      ```

> [!NOTE]
> If you don't want tokens to be issued for an application or if you want to block an application from being accessed by users or services in your tenant, create a service principal for the application and [disable user sign-in](~/identity/enterprise-apps/disable-user-sign-in-portal.md) for it.

## See also

For more information about roles and security groups, see:

- [How to: Add app roles in your application](./howto-add-app-roles-in-apps.md)
- [Using Security Groups and Application Roles in your apps (Video)](https://www.youtube.com/watch?v=LRoc-na27l0)
- [Microsoft Entra app manifest](./reference-app-manifest.md)

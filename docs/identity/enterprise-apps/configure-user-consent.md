---
title: Configure how users consent to applications
description: Learn how to manage how and when users can consent to applications that request access to your organization's data.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 10/31/2023
ms.author: jomondi
ms.reviewer: phsignor, yuhko
ms.custom: enterprise-apps
zone_pivot_groups: enterprise-apps-minus-former-powershell


#customer intent: As an IT admin, I want to configure user consent settings for applications, so that I can control the level of access users have to my organization's data and reduce the risk of malicious applications.
---

# Configure how users consent to applications

In this article, you'll learn how to configure the way users consent to applications and how to disable all future user consent operations to applications.

Before an application can access your organization's data, a user must grant the application permissions to do so. Different permissions allow different levels of access. By default, all users are allowed to consent to applications for permissions that don't require administrator consent. For example, by default, a user can consent to allow an app to access their mailbox but can't consent to allow an app unfettered access to read and write to all files in your organization.

To reduce the risk of malicious applications attempting to trick users into granting them access to your organization's data, we recommend that you allow user consent only for applications that have been published by a [verified publisher](~/identity-platform/publisher-verification-overview.md).

## Prerequisites

To configure user consent, you need:

- A user account. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- A [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) role.

## Configure user consent settings

:::zone pivot="portal"

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To configure user consent settings through the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Consent and permissions** > **User consent settings**.

1. Under **User consent for applications**, select which consent setting you want to configure for all users.

1. Select **Save** to save your settings.

:::image type="content" source="media/configure-user-consent/setting-for-all-users.png" alt-text="Screenshot of the 'User consent settings' pane.":::

:::zone-end

:::zone pivot="ms-powershell"

To choose which app consent policy governs user consent for applications, you can use the [Microsoft Graph PowerShell](/powershell/microsoftgraph/get-started?view=graph-powershell-1.0&preserve-view=true) module. The cmdlets used here are included in the [Microsoft.Graph.Identity.SignIns](https://www.powershellgallery.com/packages/Microsoft.Graph.Identity.SignIns) module.

### Connect to Microsoft Graph PowerShell

Connect to Microsoft Graph PowerShell using the least-privilege permission needed. For reading the current user consent settings, use *Policy.Read.All*. For reading and changing the user consent settings, use *Policy.ReadWrite.Authorization*. You need to sign in as a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

```powershell
Connect-MgGraph -Scopes "Policy.ReadWrite.Authorization"
```

### Disable user consent

To disable user consent, ensure that the consent policies (`PermissionGrantPoliciesAssigned`) include other current `ManagePermissionGrantsForOwnedResource.*` policies if any while updating the collection. This way, you can maintain your current configuration for user consent settings and other resource consent settings.

```powershell
# only exclude user consent policy
$body = @{
    "permissionGrantPolicyIdsAssignedToDefaultUserRole" = @(
        "managePermissionGrantsForOwnedResource.{other-current-policies}" 
    )
}
Update-MgPolicyAuthorizationPolicy -AuthorizationPolicyId authorizationPolicy -BodyParameter $body

```

### Allow user consent subject to an app consent policy using PowerShell

To allow user consent, choose which app consent policy should govern users' authorization to grant consent to apps. Ensure that the consent policies (`PermissionGrantPoliciesAssigned`) include other current `ManagePermissionGrantsForOwnedResource.*` policies if any while updating the collection. This way, you can maintain your current configuration for user consent settings and other resource consent settings.

```powershell
$body = @{
    "permissionGrantPolicyIdsAssignedToDefaultUserRole" = @(
        "managePermissionGrantsForSelf.{consent-policy-id}",
        "managePermissionGrantsForOwnedResource.{other-current-policies}"
    )
}
Update-MgPolicyAuthorizationPolicy -AuthorizationPolicyId authorizationPolicy -BodyParameter $body
```

Replace `{consent-policy-id}` with the ID of the policy you want to apply. You can choose a [custom app consent policy](manage-app-consent-policies.md#create-a-custom-app-consent-policy-using-powershell) that you've created, or you can choose from the following built-in policies:

| ID | Description |
|:---|:------------|
| microsoft-user-default-low | **Allow user consent for apps from verified publishers, for selected permissions** <br> Allow limited user consent only for apps from verified publishers and apps that are registered in your tenant, and only for permissions that you classify as *low impact*. (Remember to [classify permissions](configure-permission-classifications.md) to select which permissions users are allowed to consent to.) |
| microsoft-user-default-legacy | **Allow user consent for apps** <br> This option allows all users to consent to any permission that doesn't require admin consent, for any application |

For example, to enable user consent subject to the built-in policy `microsoft-user-default-low`, run the following commands:

```powershell
$body = @{
    "permissionGrantPolicyIdsAssignedToDefaultUserRole" = @(
        "managePermissionGrantsForSelf.managePermissionGrantsForSelf.microsoft-user-default-low",
        "managePermissionGrantsForOwnedResource.{other-current-policies}"
    )
}
```

:::zone-end

:::zone pivot="ms-graph"

Use the [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to choose which app consent policy governs user consent for applications. You need to sign in as a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

To disable user consent, ensure that the consent policies (`PermissionGrantPoliciesAssigned`) include other current `ManagePermissionGrantsForOwnedResource.*` policies if any while updating the collection. This way, you can maintain your current configuration for user consent settings and other resource consent settings.

```http
PATCH https://graph.microsoft.com/v1.0/policies/authorizationPolicy
{
   "defaultUserRolePermissions": {
       "permissionGrantPoliciesAssigned": [
           "managePermissionGrantsForOwnedResource.{other-current-policies}"
        ]
    }
}
```

### Allow user consent subject to an app consent policy using Microsoft Graph

To allow user consent, choose which app consent policy should govern users' authorization to grant consent to apps. Ensure that the consent policies (`PermissionGrantPoliciesAssigned`) include other current `ManagePermissionGrantsForOwnedResource.*` policies if any while updating the collection. This way, you can maintain your current configuration for user consent settings and other resource consent settings.

```http
PATCH https://graph.microsoft.com/v1.0/policies/authorizationPolicy

{
    "defaultUserRolePermissions": {
        "managePermissionGrantsForSelf.{consent-policy-id}",
        "managePermissionGrantsForOwnedResource.{other-current-policies}"
   }
}
```

Replace `{consent-policy-id}` with the ID of the policy you want to apply. You can choose a [custom app consent policy](manage-app-consent-policies.md#create-a-custom-app-consent-policy-using-microsoft-graph) that you've created, or you can choose from the following built-in policies:

| ID | Description |
|:---|:------------|
| microsoft-user-default-low | **Allow user consent for apps from verified publishers, for selected permissions** <br> Allow limited user consent only for apps from verified publishers and apps that are registered in your tenant, and only for permissions that you classify as *low impact*. (Remember to [classify permissions](configure-permission-classifications.md) to select which permissions users are allowed to consent to.) |
| microsoft-user-default-legacy | **Allow user consent for apps** <br> This option allows all users to consent to any permission that doesn't require admin consent, for any application |

For example, to enable user consent subject to the built-in policy `microsoft-user-default-low`, use the following PATCH command:

```http
PATCH https://graph.microsoft.com/v1.0/policies/authorizationPolicy

{
    "defaultUserRolePermissions": {
        "permissionGrantPoliciesAssigned": [
            "managePermissionGrantsForSelf.microsoft-user-default-low",
            "managePermissionGrantsForOwnedResource.{other-current-policies}"
        ]
    }
}
```

:::zone-end

> [!TIP]
> To allow users to request an administrator's review and approval of an application that the user isn't allowed to consent to, [enable the admin consent workflow](configure-admin-consent-workflow.md). For example, you might do this when user consent has been disabled or when an application is requesting permissions that the user isn't allowed to grant.

## Next steps

- [Manage app consent policies](manage-app-consent-policies.md)
- [Configure the admin consent workflow](configure-admin-consent-workflow.md)

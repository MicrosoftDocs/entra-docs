---
title: Configure how users consent to applications

description: Configure user consent settings in Microsoft Entra ID to control when and how users grant permissions to your organization's data. Secure your environment with step‑by‑step guidance.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 06/15/2025
ms.author: jomondi
ms.reviewer: phsignor, ergreenl
ms.custom: enterprise-apps
zone_pivot_groups: enterprise-apps-minus-legacy-powershell


#customer intent: As an IT admin, I want to configure user consent settings for applications, so that I can control the level of access users have to my organization's data and reduce the risk of malicious applications.
---

# Configure how users consent to applications

In this article, you learn how to configure user consent settings in Microsoft Entra ID to control when and how users grant permissions to applications. This guidance helps IT admins reduce security risks by restricting or disabling user consent.

Before an application can access your organization's data, a user must grant the application permissions to do so. Different permissions allow different levels of access. By default, all users are allowed to consent to applications for permissions that don't require administrator consent. For example, by default, a user can consent to allow an app to access their mailbox but can't consent to allow an app unfettered access to read and write to all files in your organization.

To reduce the risk of malicious applications attempting to trick users into granting them access to your organization's data, we recommend that you allow user consent only for applications that have been published by a [verified publisher](~/identity-platform/publisher-verification-overview.md).

> [!NOTE]
> Applications that require users to be assigned to the application must have their permissions consented by an administrator, even if the user consent policies for your directory would otherwise allow a user to consent on behalf of themselves.

## Prerequisites

To configure user consent, you need:

- A user account. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- A [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) role.
- A [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) role is only required when using the Microsoft Entra admin center.

## Configure user consent settings

You can configure user consent settings in Microsoft Entra ID using either the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API. The settings you configure apply to all users in your organization.

:::zone pivot="portal"

### Configure user consent in Microsoft Entra admin center

To configure user consent settings through the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).

1. Browse to **Entra ID** > **Enterprise apps** > **Consent and permissions** > **User consent settings**.

1. Under **User consent for applications**, select which consent setting you want to configure for all users.

1. Select **Save** to save your settings.

:::image type="content" source="media/configure-user-consent/setting-for-all-users.png" alt-text="Screenshot of the 'User consent settings' pane.":::

:::zone-end

:::zone pivot="ms-powershell"

## Understand authorization and permission grant policies in Microsoft Graph PowerShell

To configure user consent settings programmatically using Microsoft Graph PowerShell, it's important to understand the distinction between the tenant-wide **authorization policy** and individual **permission grant policies**. The `authorizationPolicy`, retrieved using [Update-MgPolicyAuthorizationPolicy](/powershell/module/microsoft.graph.identity.signins/update-mgpolicyauthorizationpolicy) governs global settings such as whether users can consent to apps and which permission grant policies are assigned to the default user role. For example, you can disable user consent while still allowing developers to manage permissions for the apps they own by assigning only `ManagePermissionGrantsForOwnedResource.DeveloperConsent` in the `permissionGrantPoliciesAssigned` collection.

On the other hand, the [permissionGrantPolicies](/powershell/module/microsoft.graph.identity.signins/get-mgpolicypermissiongrantpolicy) endpoint, lists all defined consent policies in the tenant. These policies determine the specific types of app permissions that users are allowed to grant—such as low-risk delegated permissions. For instance, a policy like `UserConsentLowRisk` might allow users to consent only to apps that request basic profile information, while a custom policy could restrict consent even further or broaden it for specific user groups.

> [!NOTE]
> Before updating consent settings with a `Update-MgPolicyPermissionGrantPolicy` command, always retrieve the current `authorizationPolicy` to identify which permission grant policies are already assigned. This ensures you preserve necessary permissions—such as those enabling developers to manage consent for apps they own—and avoid unintentionally removing existing functionality.

To choose which app consent policy governs user consent for applications, use the [Microsoft Graph PowerShell](/powershell/microsoftgraph/get-started?view=graph-powershell-1.0&preserve-view=true) module. The cmdlets used here are included in the [Microsoft.Graph.Identity.SignIns](https://www.powershellgallery.com/packages/Microsoft.Graph.Identity.SignIns) module.

Connect to Microsoft Graph PowerShell using the least-privilege permission needed. For reading the current user consent settings, use *Policy.Read.All*. For reading and changing the user consent settings, use *Policy.ReadWrite.Authorization*. You need to sign in as a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

```powershell
Connect-MgGraph -Scopes "Policy.ReadWrite.Authorization"
```

### Disable user consent using Microsoft Graph PowerShell

To disable user consent, ensure that the consent policies (`PermissionGrantPoliciesAssigned`) include other current `ManagePermissionGrantsForOwnedResource.*` policies if any while updating the collection. This way, you can maintain your current configuration for user consent settings and other resource consent settings.

```powershell
# only exclude user consent policy
$body = @{
    "permissionGrantPolicyIdsAssignedToDefaultUserRole" = @(
        "managePermissionGrantsForOwnedResource.{other-current-policies}" 
    )
}
Update-MgPolicyAuthorizationPolicy -BodyParameter $body

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
Update-MgPolicyAuthorizationPolicy -BodyParameter $body
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

## Understand authorization and permission grant policies in Microsoft Graph

To configure user consent settings programmatically using Microsoft Graph, it's important to understand the distinction between the tenant-wide **authorization policy** and individual **permission grant policies**. The `authorizationPolicy` (retrieved using `GET https://graph.microsoft.com/v1.0/policies/authorizationPolicy/authorizationPolicy`) governs global settings such as whether users can consent to apps and which permission grant policies are assigned to the default user role. For example, you can disable user consent while still allowing developers to manage permissions for the apps they own by assigning only `ManagePermissionGrantsForOwnedResource.DeveloperConsent` in the `permissionGrantPoliciesAssigned` collection.

On the other hand, the `permissionGrantPolicies` endpoint (`GET https://graph.microsoft.com/v1.0/policies/permissionGrantPolicies`) lists all defined consent policies in the tenant. These policies determine the specific types of app permissions that users are allowed to grant—such as low-risk delegated permissions. For instance, a policy like `UserConsentLowRisk` might allow users to consent only to apps that request basic profile information, while a custom policy could restrict consent even further or broaden it for specific user groups.

> [!NOTE]
> Before updating consent settings with a `PATCH` request, always retrieve the current `authorizationPolicy` to identify which permission grant policies are already assigned. This ensures you preserve necessary permissions—such as those enabling developers to manage consent for apps they own—and avoid unintentionally removing existing functionality.

Use the [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to choose which app consent policy governs user consent for applications. You need to sign in as a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

### Disable user consent using Microsoft Graph

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

Any changes made to user consent settings only affect future consent operations for applications. Existing consents remain unchanged, and users continue to have access based on the permissions previously granted.

> [!TIP]
> To allow users to request an administrator's review and approval of an application that the user isn't allowed to consent to, [enable the admin consent workflow](configure-admin-consent-workflow.md). For example, you might do this when user consent has been disabled or when an application is requesting permissions that the user isn't allowed to grant.

## Next steps

- [Manage app consent policies](manage-app-consent-policies.md)
- [Configure the admin consent workflow](configure-admin-consent-workflow.md)

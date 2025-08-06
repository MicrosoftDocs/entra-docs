---
title: Manage app consent policies
description: Learn how to manage built-in and custom app consent policies to control when consent can be granted.

manager: mwongerapk
author: omondiatieno
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 08/05/2025
ms.author: jomondi
ms.reviewer: ergreenl, phsignor
ms.custom: enterprise-apps
zone_pivot_groups: enterprise-apps-minus-portal-aad

#customer intent: As an IT admin managing app consent policies, I want to view and manage existing app consent policies using Microsoft Graph PowerShell and Microsoft Graph API calls, so that I can control the permissions that apps have to access data in my organization and ensure they meet certain criteria.
---

# Manage app consent policies

App consent policies are a way to manage the permissions that apps have to access data in your organization. They're used to control what apps users can consent to and to ensure that apps meet certain criteria before they can access data. These policies help organizations maintain control over their data and ensure they only grant access to trusted apps. With [Microsoft Graph](/graph/overview) and [Microsoft Graph PowerShell](/powershell/microsoftgraph/get-started?view=graph-powershell-1.0&preserve-view=true), you can view and manage app consent policies.

In this article, you learn how to manage built-in and custom app consent policies to control when consent can be granted. App consent policies can be assigned to specific users or groups by leveraging a custom role, or you can set a default app consent policy for end-users in your organization.


# App consent policy segments
An app consent policy consists of one or more "include" condition sets and zero or more "exclude" condition sets. For an event to be considered in an app consent policy, it must match *at least* one "include" condition set, and must not match *any* "exclude" condition set. These exclusion and inclusions are used to determine whether the actor affected by the given policy can grant consent or not.

There are three main parts of app consent policies: 
- **Metadata:** This will hold the information such as the id, the description, and the display name of the consent policy.
- **Included condition sets:** A collection of condition sets that a given app consent request must match *at least one of* for the policy to pass. This collection must have at least *one* Each condition set contains rules that describes characteristics of an app consent request, such as verified publisher status, permissions requested, and more. 
- **Excluded condition sets:** A collection of condition sets that a given app consent request should not match *any* of to pass. This collection can be empty (it can contain zero excluded condition sets). Each condition set contains rules that describes characteristics of an app consent request, such as verified publisher status, permissions requested, and more.


Each condition set consists of several conditions. For an event to match a condition set, *all* conditions in the condition set must be met. 

# Built-in consent policies

Every tenant comes with a set of app consent policies that are the same across all tenants.  Some of these built-in policies are used in existing built-in directory roles. For example, the `microsoft-application-admin` app consent policy describes the conditions under which the Application Administrator and Cloud Application Administrator roles are allowed to grant tenant-wide admin consent. Built-in policies can be used in custom directory roles or to configure an organization's default consent policy. These policies cannot be edited. A list of the built-in policies are:
- **microsoft-user-default-low:** All low risk permissions are consentable by member type users by default.
- **microsoft-user-default-recommended:** Permissions consentable based on Microsoft's current recommendations.
- **microsoft-all-application-permissions:** Includes all application permissions (app roles), for all APIs, for any client application.
- **microsoft-dynamically-managed-permissions-for-chat:** Includes dynamically managed permissions allowed for chat resource-specific consent.
- **microsoft-all-application-permissions-for-chat:** Includes all chat resoruce-specific application permissions, for all APIs, for any client application.
- **microsoft-dynamically-managed-permissions-for-team:** Includes dynamically managed permissions allowed for team resource-specific consent.
- **microsoft-pre-approval-apps-for-chat:** Includes apps that have been pre-approved by permission grant pre-approval policy for chat resource specific consent.
- **microsoft-pre-approval-apps-for-team:** Includes apps that have been pre-approved by permission grant pre-approval policy for team resource specific consent.
- **microsoft-all-application-permissions-verified:** Includes all application permissions (app roles), for all APIs, for client applications from verified publishers or which were registered in this organization.
- **microsoft-application-admin:** Permissions consentable by Application Administrators.
- **microsoft-company-admin:** Permissions consentable by Company Administrators.

> [!WARNING]
> Microsoft-user-default-recommended is a Microsoft managed policy. The conditions included in the policy will be automatically updated based on Microsoft's latest security recommendations for end-user consent.


## Prerequisites

- A user or service with one of the following roles:
  - Privileged Role Administrator directory role
  - A custom directory role with the necessary [permissions to manage app consent policies](~/identity/role-based-access-control/custom-consent-permissions.md#managing-app-consent-policies)
  - The Microsoft Graph app role (application permission) `Policy.ReadWrite.PermissionGrant` when connecting as an app or a service
- Familiarize yourself with (Permission grant condition sets)[/graph/api/resources/permissiongrantconditionset?view=graph-rest-1.0]
:::zone pivot="ms-powershell"

To manage app consent policies for applications with Microsoft Graph PowerShell, connect to [Microsoft Graph PowerShell](/powershell/microsoftgraph/get-started?view=graph-powershell-1.0&preserve-view=true).

   ```powershell
   Connect-MgGraph -Scopes "Policy.ReadWrite.PermissionGrant"
   ```

## List existing app consent policies

It's a good idea to start by getting familiar with the existing app consent policies in your organization:

1. List all app consent policies. This will show all built-in policies and any custom policies your organization has created:

   ```powershell
   Get-MgPolicyPermissionGrantPolicy | ft Id, DisplayName, Description
   ```

1. View the "include" condition sets of a policy:

    ```powershell
    Get-MgPolicyPermissionGrantPolicyInclude -PermissionGrantPolicyId "microsoft-application-admin" | fl
    ```

1. View the "exclude" condition sets:

    ```powershell
    Get-MgPolicyPermissionGrantPolicyExclude -PermissionGrantPolicyId "microsoft-application-admin" | fl
    ```

## Create a custom app consent policy using PowerShell

Follow these steps to create a custom app consent policy:

1. Create a new empty app consent policy.

   ```powershell
   New-MgPolicyPermissionGrantPolicy `
       -Id "my-custom-policy" `
       -DisplayName "My first custom consent policy" `
       -Description "This is a sample custom app consent policy."
   ```

1. Add "include" condition sets.

   ```powershell
   # Include delegated permissions classified "low", for apps from verified publishers
   New-MgPolicyPermissionGrantPolicyInclude `
       -PermissionGrantPolicyId "my-custom-policy" `
       -PermissionType "delegated" `
       -PermissionClassification "low" `
       -ClientApplicationsFromVerifiedPublisherOnly
   ```

   Repeat this step to add more "include" condition sets.

1. Optionally, add "exclude" condition sets.

   ```powershell
   # Retrieve the service principal for the Azure Management API
   $azureApi = Get-MgServicePrincipal -Filter "servicePrincipalNames/any(n:n eq 'https://management.azure.com/')"

   # Exclude delegated permissions for the Azure Management API
   New-MgPolicyPermissionGrantPolicyExclude `
       -PermissionGrantPolicyId "my-custom-policy" `
       -PermissionType "delegated" `
       -ResourceApplication $azureApi.AppId
   ```

   Repeat this step to add more "exclude" condition sets.

After creating the app consent policy, you need to assign it to a custom role in Microsoft Entra ID. You then need to assign users to that custom role, which is attached to the app consent policy you created. For more information on how to assign the app consent policy to a custom role, see [App consent permissions for custom roles](~/identity/role-based-access-control/custom-consent-permissions.md).

## Delete a custom app consent policy using PowerShell

The following cmdlet shows how you can delete a custom app consent policy.

```powershell
   Remove-MgPolicyPermissionGrantPolicy -PermissionGrantPolicyId "my-custom-policy"
```

:::zone-end

:::zone pivot="ms-graph"

To manage app consent policies, sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) with one of the roles listed in the prerequisite section.

You need to consent to the `Policy.ReadWrite.PermissionGrant` permission.

## List existing app consent policies using Microsoft Graph

It's a good idea to start by getting familiar with the existing app consent policies in your organization:

1. List all app consent policies. This will show all built-in policies and any custom policies your organization has created:

   ```http
   GET /policies/permissionGrantPolicies?$select=id,displayName,description
   ```

1. View the "include" condition sets of a policy:

   ```http
   GET /policies/permissionGrantPolicies/{ microsoft-application-admin }/includes
   ```

1. View the "exclude" condition sets:

   ```http
   GET /policies/permissionGrantPolicies/{ microsoft-application-admin }/excludes
   ```

## Create a custom app consent policy using Microsoft Graph

Follow these steps to create a custom app consent policy:

1. Create a new empty app consent policy.

   ```http
   POST https://graph.microsoft.com/v1.0/policies/permissionGrantPolicies
   Content-Type: application/json

   {
     "id": "my-custom-policy",
     "displayName": "My first custom consent policy",
     "description": "This is a sample custom app consent policy"
   }
   ```

1. Add "include" condition sets.

    Include delegated permissions classified "low" for apps from verified publishers

   ```http
   POST https://graph.microsoft.com/v1.0/policies/permissionGrantPolicies/{ my-custom-policy }/includes
   Content-Type: application/json
   
   {
     "permissionType": "delegated",
     "PermissionClassification": "low",
     "clientApplicationsFromVerifiedPublisherOnly": true
   }
   ```

   Repeat this step to add more "include" condition sets.

1. Optionally, add "exclude" condition sets.
     Exclude delegated permissions for the Azure Management API (appId 00001111-aaaa-2222-bbbb-3333cccc4444)

   ```http
   POST https://graph.microsoft.com/v1.0/policies/permissionGrantPolicies/my-custom-policy /excludes
   Content-Type: application/json
   
   {
     "permissionType": "delegated",
     "resourceApplication": "00001111-aaaa-2222-bbbb-3333cccc4444 "
   }
   ```

   Repeat this step to add more "exclude" condition sets.

After creating the app consent policy, you need to assign it to a custom role in Microsoft Entra ID. You then need to assign users to that custom role, which is attached to the app consent policy you created. For more information on how to assign the app consent policy to a custom role, see [App consent permissions for custom roles](~/identity/role-based-access-control/custom-consent-permissions.md).

## Delete a custom app consent policy Microsoft Graph

1. The following shows how you can delete a custom app consent policy.

   ```http
   DELETE https://graph.microsoft.com/v1.0/policies/permissionGrantPolicies/ my-custom-policy
   ```

:::zone-end

> [!WARNING]
> Deleted app consent policies can't be restored. If you accidentally delete a custom app consent policy, you need to re-create the policy.

### Supported conditions

The following table provides the list of supported conditions for app consent policies.

| Condition | Description|
|:---------------|:----------|
| PermissionClassification | The [permission classification](configure-permission-classifications.md) for the permission being granted, or "all" to match with any permission classification (including permissions that aren't classified). Default is "all." |
| PermissionType | The permission type of the permission being granted. Use "application" for application permissions (for example, app roles) or "delegated" for delegated permissions. <br><br> **Note**: The value "delegatedUserConsentable" indicates delegated permissions that aren't configured by the API publisher to require admin consent. This value can be used in built-in permission grant policies, but can't be used in custom permission grant policies. Required. |
| ResourceApplication | The **AppId** of the resource application (for example, the API) for which a permission is being granted, or "any" to match with any resource application or API. Default is "any." |
| Permissions | The list of permission IDs for the specific permissions to match with, or a list with the single value "all" to match with any permission. Default is the single value "all." <br> - Delegated permission IDs can be found in the **OAuth2Permissions** property of the API's ServicePrincipal object. <br> - Application permission IDs can be found in the **AppRoles** property of the API's ServicePrincipal object. |
| ClientApplicationIds | A list of **AppId** values for the client applications to match with, or a list with the single value "all" to match any client application. Default is the single value "all." |
| ClientApplicationTenantIds | A list of Microsoft Entra tenant IDs in which the client application is registered, or a list with the single value "all" to match with client apps registered in any tenant. Default is the single value "all." |
| ClientApplicationPublisherIds | A list of Microsoft Partner Network (MPN) IDs for [verified publishers](~/identity-platform/publisher-verification-overview.md) of the client application, or a list with the single value "all" to match with client apps from any publisher. Default is the single value "all." |
| ClientApplicationsFromVerifiedPublisherOnly | Set this switch to only match on client applications with a [verified publishers](~/identity-platform/publisher-verification-overview.md). Disable this switch (`-ClientApplicationsFromVerifiedPublisherOnly:$false`) to match on any client app, even if it doesn't have a verified publisher. Default is `$false`. |
|scopeType| The resource scope type the preapproval applies to. Possible values: `group` for [groups](/graph/api/resources/group) and [teams](/graph/api/resources/team), `chat` for [chats](/graph/api/resources/chat?view=graph-rest-1.0&preserve-view=true),  or `tenant` for tenant-wide access. Required.|
| sensitivityLabels| The sensitivity labels that are applicable to the scope type and aren't preapproved. It allows you to protect sensitive organizational data. Learn about [sensitivity labels](/purview/sensitivity-labels). **Note:** Chat resource **does not** support sensitivityLabels yet.|

## Next steps

- [Manage group owner consent policies](manage-group-owner-consent-policies.md)

To get help or find answers to your questions:

- [Microsoft Entra ID on Microsoft Q&A](/answers/)

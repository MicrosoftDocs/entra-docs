---
title: Configure an automatic assignment policy for an access package in entitlement management - Microsoft Entra
description: Learn how to configure automatic assignments based on rules for an access package in entitlement management.
author: markwahl-msft
manager: dougeby
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 06/26/2024
ms.author: owinfrey
ms.reviewer: mwahl
#Customer intent: As an administrator, I want detailed information about how I can edit an access package to include a policy for users to get and lose access package assignments automatically, without them or an administrator needing to request access.
---
# Configure an automatic assignment policy for an access package in entitlement management

You can use rules to determine access package assignment based on user properties in Microsoft Entra ID, part of Microsoft Entra. In Entitlement Management, an access package can have multiple policies, and each policy establishes how users get an assignment to the access package, and for how long. As an administrator, you can establish a policy for automatic assignments by supplying a membership rule, that Entitlement Management follows to create and remove assignments automatically. Similar to a [dynamic group](../identity/users/groups-create-rule.md), when an automatic assignment policy is created, user attributes are evaluated for matches with the policy's membership rule. When an attribute changes for a user, these automatic assignment policy rules in the access packages are processed for membership changes. Assignments to users are then added or removed depending on whether they meet the rule criteria.

   > [!NOTE]
   > Only one automatic assignment policy is allowed per access package. Configuring more than one will lead to processing issues and subsequent problems with the access of assigned individuals. 

This article describes how to create an access package automatic assignment policy for an existing access package.

## Before you begin

You need to have attributes populated on the users who will be in scope for being assigned access. The attributes you can use in the rules criteria of an access package assignment policy are those attributes listed in [supported properties](../identity/users/groups-dynamic-membership.md#supported-properties), along with [extension attributes and custom extension properties](../identity/users/groups-dynamic-membership.md#extension-attributes-and-custom-extension-properties). These attributes can be brought into Microsoft Entra ID by [patching](../identity/app-provisioning/user-provisioning-sync-attributes-for-mapping.md#create-an-extension-attribute-for-cloud-only-users-using-microsoft-graph) the [user](/graph/api/resources/user), an HR system such as [SuccessFactors](../identity/app-provisioning/sap-successfactors-integration-reference.md), [Microsoft Entra Connect cloud sync](../identity/hybrid/cloud-sync/how-to-attribute-mapping.md) or [Microsoft Entra Connect Sync](../identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md). The rules can include up to 15,000 users per policy.

## License requirements

[!INCLUDE [active-directory-entra-governance-license.md](../includes/entra-entra-governance-license.md)]

## Create an automatic assignment policy


To create a policy for an access package, you need to start from the access package's policy tab. Follow these steps to create a new automatic assignment policy for an access package.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    > [!NOTE]
    > Catalog owners and access package managers can't create automatic assignment policies.
    
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. On the **Access packages** page, open an access package.

1. Select **Policies** and then **Add auto-assignment policy** to create a new policy.

1. In the first tab, you specify the rule. Select **Edit**.

1. Provide a rule for dynamic membership groups using the [membership rule builder](../identity/users/groups-dynamic-membership.md) or by clicking **Edit** on the rule syntax text box.

   > [!NOTE]
   > The rule builder might not be able to display some rules constructed in the text box, and validating a rule currently requires that you to be in the Groups Administrator role. For more information, see [rule builder in the Microsoft Entra admin center](../identity/users/groups-create-rule.md#rule-builder-in-the-azure-portal).

    ![Screenshot of an access package automatic assignment policy rule configuration.](./media/entitlement-management-access-package-auto-assignment-policy/auto-assignment-rule-configuration.png)

1. Select **Save** to close the rule editor for dynamic membership groups.
1. By default, the checkboxes to automatically create and remove assignments should remain checked.
1. If you wish users to retain access for a limited time after they go out of scope, you can specify a duration in hours or days. For example, when an employee leaves the sales department, you could wish to allow them to continue to retain access for seven days to allow them to use sales apps and transfer ownership of their resources in those apps to another employee.
1. Select **Next** to open the **Custom Extensions** tab.

1. If you have [custom extensions](entitlement-management-logic-apps-integration.md) in your catalog you wish to have run when the policy assigns or removes access, you can add them to this policy.  Then select next to open the **Review** tab.

1. Type a name and a description for the policy.

    ![Screenshot of an access package automatic assignment policy review tab.](./media/entitlement-management-access-package-auto-assignment-policy/auto-assignment-review.png)

1. Select **Create** to save the policy.

   > [!NOTE]
   > At this time, Entitlement management will automatically create a dynamic security group corresponding to each policy, in order to evaluate the users in scope. This group should not be modified except by Entitlement Management itself.  This group can also be modified or deleted automatically by Entitlement Management, so don't use this group for other applications or scenarios.

1. Microsoft Entra ID evaluates the users in the organization that are in scope of this rule, and create assignments for those users who don't already have assignments to the access package. A policy can include at most 15,000 users in its rule. It can take several minutes for the evaluation to occur, or for subsequent updates to user's attributes to be reflected in the access package assignments.

## Create an automatic assignment policy programmatically

There are two ways to create an access package assignment policy for automatic assignment programmatically, through Microsoft Graph and through the PowerShell cmdlets for Microsoft Graph.

### Create an access package assignment policy through Graph

You can create a policy using Microsoft Graph. A user in an appropriate role with an application that has the delegated `EntitlementManagement.ReadWrite.All` permission, or an application in a catalog role or with the `EntitlementManagement.ReadWrite.All` permission, can call the [create an assignmentPolicy](/graph/api/entitlementmanagement-post-assignmentpolicies?tabs=http&view=graph-rest-1.0&preserve-view=true) API. In your [request payload](/graph/api/resources/accesspackageassignmentpolicy?view=graph-rest-1.0&preserve-view=true), include the `displayName`, `description`, `specificAllowedTargets`, [`automaticRequestSettings`](/graph/api/resources/accesspackageautomaticrequestsettings?view=graph-rest-1.0&preserve-view=true) and `accessPackage` properties of the policy.

### Create an access package assignment policy through PowerShell

You can also create a policy in PowerShell with the cmdlets from the [Microsoft Graph PowerShell cmdlets for Identity Governance](https://www.powershellgallery.com/packages/Microsoft.Graph.Identity.Governance/) module version 1.16.0 or later.

This following script illustrates using the `v1.0` profile, to create a policy for automatic assignment to an access package. See [create an assignmentPolicy](/graph/api/entitlementmanagement-post-assignmentpolicies?tabs=http&view=graph-rest-1.0&preserve-view=true) and [Create an access package in entitlement management for an application with a single role using PowerShell](entitlement-management-access-package-create-app.md) for more examples.


```powershell
Connect-MgGraph -Scopes "EntitlementManagement.ReadWrite.All"

$apid = "00001111-aaaa-2222-bbbb-3333cccc4444"

$pparams = @{
  DisplayName = "Sales department users"
  Description = "All users from sales department"
  AllowedTargetScope = "specificDirectoryUsers"
  SpecificAllowedTargets = @( @{
        "@odata.type" = "#microsoft.graph.attributeRuleMembers"
        description = "All users from sales department"
        membershipRule = '(user.department -eq "Sales")'
  } )
  AutomaticRequestSettings = @{
        RequestAccessForAllowedTargets = $true
  }
    AccessPackage = @{
      Id = $apid
    }
}
New-MgEntitlementManagementAssignmentPolicy -BodyParameter $pparams
```

## Next steps

- [View assignments for an access package](entitlement-management-access-package-assignments.md)

---
title: Change Static Groups to Dynamic Membership Groups
description: Learn how to convert existing membership groups from static to dynamic by using either the Azure portal or PowerShell cmdlets.
author: barclayn
manager: femila
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 01/14/2025
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sfi-image-nochange
---

# Change static groups to dynamic membership groups in Microsoft Entra ID

You can change a group's membership from static to dynamic (or vice versa) in Microsoft Entra ID. Microsoft Entra ID keeps the same group name and ID in the system, so all existing references to the group are still valid. If you create a new group instead, you need to update those references.

Creating dynamic membership groups eliminates the management overhead of adding and removing users. This article shows you how to convert existing membership groups from static to dynamic, by using either the Azure portal or PowerShell cmdlets. In Microsoft Entra, a single tenant can have a maximum of 15,000 dynamic membership groups.

> [!WARNING]
> When you change an existing static group to a dynamic group, all existing members are removed from the group. The membership rule is then processed to add new members. If the group is used to control access to apps or resources, the original members might lose access until the membership rule is fully processed.
>
> We recommend that you test the new membership rule beforehand to make sure that the new membership in the group is as expected. If you encounter errors during your test, see [Resolve group license problems](/entra/fundamentals/licensing-groups-resolve-problems).

## Prerequisites

- To change the membership type by using the portal, you need an account that has at least the [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator) role.

- To change dynamic group properties by using PowerShell, you need to use cmdlets from the Microsoft Graph PowerShell module. For more information, see [Install the Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation).

## Change the membership type for a group (portal)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Groups Administrator.

1. Select **Microsoft Entra ID**.

1. Select **Groups**.

1. In the **All groups** list, open the group that you want to change.

1. Select **Properties**.

1. On the **Properties** page for the group, select a **Membership type** value of **Assigned (static)**, **Dynamic User**, or **Dynamic Device**, depending on your desired membership type. For dynamic membership groups, you can use the rule builder to select options for a simple rule or write a membership rule yourself.

   The following steps are an example of changing a group of users from static to dynamic membership groups:

   1. For **Membership type**, select **Dynamic User**. In the dialog that explains the changes to the dynamic membership groups, select **Yes** to continue.

      :::image type="content" source="./media/groups-change-type/select-group-to-convert.png" alt-text="Screenshot of selecting a membership type of dynamic user.":::
  
   1. Select **Add dynamic query**, and then provide the rule.
  
      :::image type="content" source="./media/groups-change-type/enter-rule.png" alt-text="Screenshot of entering a rule for a dynamic group.":::
  
1. After you create the rule, select **Add query**.

1. On the **Properties** page for the group, select **Save** to save your changes. The **Membership type** of the group is immediately updated in the group list.

> [!TIP]
> Group conversion might fail if the membership rule that you entered was incorrect. In the upper-right corner of the portal, a notification explains why the rule can't be accepted. Read it carefully to understand how you can adjust the rule to make it valid. For examples of rule syntax and a complete list of the supported properties, operators, and values for a membership rule, see [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md).

## Change the membership type for a group (PowerShell)

Here's an example of functions that switch membership management on an existing group. This example correctly manipulates the `GroupTypes` property to preserve any values that are unrelated to dynamic membership groups.

```powershell
#The moniker for dynamic membership groups, as used in the GroupTypes property of a group object
$dynamicGroupTypeString = "DynamicMembership"

function ConvertDynamicGroupToStatic
{
    Param([string]$groupId)

    #Existing group types
    [System.Collections.ArrayList]$groupTypes = (Get-MgGroup -GroupId $groupId).GroupTypes

    if($groupTypes -eq $null -or !$groupTypes.Contains($dynamicGroupTypeString))
    {
        throw "This group is already a static group. Aborting conversion.";
    }


    #Remove the type for dynamic membership groups, but keep the other type values
    $groupTypes.Remove($dynamicGroupTypeString)

    #Modify the group properties to make it a static group: change GroupTypes to remove the dynamic type, and then pause execution of the current rule
    Update-MgGroup -GroupId $groupId -GroupTypes $groupTypes.ToArray() -MembershipRuleProcessingState "Paused"
}

function ConvertStaticGroupToDynamic
{
    Param([string]$groupId, [string]$dynamicMembershipRule)

    #Existing group types
    [System.Collections.ArrayList]$groupTypes = (Get-MgGroup -GroupId $groupId).GroupTypes

    if($groupTypes -ne $null -and $groupTypes.Contains($dynamicGroupTypeString))
    {
        throw "This group is already a dynamic group. Aborting conversion.";
    }
    #Add the dynamic group type to existing types
    $groupTypes.Add($dynamicGroupTypeString)

    #Modify the group properties to make it a static group: change GroupTypes to add the dynamic type, start execution of the rule, and then set the rule
    Update-MgGroup -GroupId $groupId -GroupTypes $groupTypes.ToArray() -MembershipRuleProcessingState "On" -MembershipRule $dynamicMembershipRule
}
```

To make a group static, use this command:

```powershell
ConvertDynamicGroupToStatic "a58913b2-eee4-44f9-beb2-e381c375058f"
```

To make a group dynamic, use this command:

```powershell
ConvertStaticGroupToDynamic "a58913b2-eee4-44f9-beb2-e381c375058f" "user.displayName -startsWith ""Peter"""
```

## Related content

- [Create a group with members and view all groups and members](~/fundamentals/groups-view-azure-portal.md)
- [Manage Microsoft Entra groups and group membership](/entra/fundamentals/how-to-manage-groups)
- [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md)

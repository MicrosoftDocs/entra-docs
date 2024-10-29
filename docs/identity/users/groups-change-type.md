---
title: Change static groups to dynamic membership groups
description: Learn how to convert existing groups from static to dynamic membership groups using either the portal or PowerShell cmdlets.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 08/23/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Change static groups to dynamic membership groups in Microsoft Entra ID

You can change a group's membership from static to dynamic (or vice-versa) In Microsoft Entra ID, part of Microsoft Entra. Microsoft Entra ID keeps the same group name and ID in the system, so all existing references to the group are still valid. If you create a new group instead, you would need to update those references. Creating dynamic membership groups eliminates management overhead adding and removing users. This article tells you how to convert existing groups from static to dynamic membership groups using either the portal or PowerShell cmdlets. In Microsoft Entra, a single tenant can have a maximum of 15,000 dynamic membership groups.

> [!WARNING]
> When changing an existing static group to a dynamic group, all existing members are removed from the group, and then the membership rule is processed to add new members. If the group is used to control access to apps or resources, be aware that the original members might lose access until the membership rule is fully processed.
>
> We recommend that you test the new membership rule beforehand to make sure that the new membership in the group is as expected. If you encounter errors during your test, see [Resolve group license problems](licensing-groups-resolve-problems.md).

## Change the membership type for a group

The following steps can be performed using an account that has at least the Groups Administrator role assigned. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select Microsoft Entra ID.
1.  **Groups**.
1. From the **All groups** list, open the group that you want to change.
1. Select **Properties**.
1. On the **Properties** page for the group, select a **Membership type** of either Assigned (static), Dynamic User, or Dynamic Device, depending on your desired membership type. For dynamic membership groups, you can use the rule builder to select options for a simple rule or write a membership rule yourself. 

The following steps are an example of changing a group from static to dynamic membership groups for a group of users.

1. On the **Properties** page for your selected group, select a **Membership type** of **Dynamic User**, then select Yes on the dialog explaining the changes to the dynamic membership groups to continue. 

   :::image type="content" source="./media/groups-change-type/select-group-to-convert.png" alt-text="Screenshot of selecting membership type of dynamic user.":::
  
2. Select **Add dynamic query**, and then provide the rule.
  
   :::image type="content" source="./media/groups-change-type/enter-rule.png" alt-text="Screenshot of entering the rule for the dynamic group.":::
  
3. After creating the rule, select **Add query** at the bottom of the page.
4. Select **Save** on the **Properties** page for the group to save your changes. The **Membership type** of the group is immediately updated in the group list.

> [!TIP]
> Group conversion might fail if the membership rule you entered was incorrect. A notification is displayed in the upper-right hand corner of the portal that it contains an explanation of why the rule can't be accepted by the system. Read it carefully to understand how you can adjust the rule to make it valid. For examples of rule syntax and a complete list of the supported properties, operators, and values for a membership rule, see [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md).

## Change membership type for a group (PowerShell)

> [!NOTE]
> To change dynamic group properties you will need to use cmdlets from the Microsoft Graph PowerShell module. for more information, see [Install the Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation).

Here is an example of functions that switch membership management on an existing group. In this example, care is taken to correctly manipulate the GroupTypes property and preserve any values that are unrelated to dynamic membership groups.

```powershell
#The moniker for dynamic membership groups as used in the GroupTypes property of a group object
$dynamicGroupTypeString = "DynamicMembership"

function ConvertDynamicGroupToStatic
{
    Param([string]$groupId)

    #existing group types
    [System.Collections.ArrayList]$groupTypes = (Get-MgGroup -GroupId $groupId).GroupTypes

    if($groupTypes -eq $null -or !$groupTypes.Contains($dynamicGroupTypeString))
    {
        throw "This group is already a static group. Aborting conversion.";
    }


    #remove the type for dynamic membership groups, but keep the other type values
    $groupTypes.Remove($dynamicGroupTypeString)

    #modify the group properties to make it a static group: i) change GroupTypes to remove the dynamic type, ii) pause execution of the current rule
    Update-MgGroup -GroupId $groupId -GroupTypes $groupTypes.ToArray() -MembershipRuleProcessingState "Paused"
}

function ConvertStaticGroupToDynamic
{
    Param([string]$groupId, [string]$dynamicMembershipRule)

    #existing group types
    [System.Collections.ArrayList]$groupTypes = (Get-MgGroup -GroupId $groupId).GroupTypes

    if($groupTypes -ne $null -and $groupTypes.Contains($dynamicGroupTypeString))
    {
        throw "This group is already a dynamic group. Aborting conversion.";
    }
    #add the dynamic group type to existing types
    $groupTypes.Add($dynamicGroupTypeString)

    #modify the group properties to make it a static group: i) change GroupTypes to add the dynamic type, ii) start execution of the rule, iii) set the rule
    Update-MgGroup -GroupId $groupId -GroupTypes $groupTypes.ToArray() -MembershipRuleProcessingState "On" -MembershipRule $dynamicMembershipRule
}
```

To make a group static:

```powershell
ConvertDynamicGroupToStatic "a58913b2-eee4-44f9-beb2-e381c375058f"
```

To make a group dynamic:

```powershell
ConvertStaticGroupToDynamic "a58913b2-eee4-44f9-beb2-e381c375058f" "user.displayName -startsWith ""Peter"""
```

## Next steps

These articles provide additional information on groups in Microsoft Entra ID.

* [See existing groups](~/fundamentals/groups-view-azure-portal.md)
* [Create a new group and adding members](~/fundamentals/how-to-manage-groups.yml)
* [Manage settings of a group](~/fundamentals/how-to-manage-groups.yml)
* [Manage memberships of a group](~/fundamentals/how-to-manage-groups.yml)
* [Manage rules for dynamic membership groups](groups-dynamic-membership.md)

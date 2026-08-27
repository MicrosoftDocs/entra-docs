---
title: Configure dynamic membership groups with the memberOf operator in the Entra Admin Center (preview)
description: Learn how to create a dynamic membership group that can contain members of other groups in Microsoft Entra ID.
ms.topic: how-to
ms.date: 08/04/2026
ms.reviewer: mbhargav
ms.custom: it-pro
---

# Configure dynamic membership groups with the memberOf operator in the Entra Admin Center (preview)


## Overview

This feature preview in Microsoft Entra ID enables admins to create dynamic membership groups and administrative units that populate by adding members of other groups using the `memberOf` attribute. Apps that couldn't read group-based membership previously in Microsoft Entra ID can now read the entire membership of these new `memberOf` groups. Not only can these groups be used for apps but they can also be used for licensing assignments.

> [!IMPORTANT]
> The public preview of the `memberOf` rule operator is ending. After **November 3, 2026**, dynamic membership groups, dynamic administrative units, and entitlement management auto-assignment policies that use the `memberOf` operator stop updating and remain in their last known state. This can lead to stale access and enforcement gaps, including outdated Teams and SharePoint access, Conditional Access targeting, group-based licensing, and access package assignments.
>
> Before November 3, 2026, review all uses of the `memberOf` operator and remove or replace those configurations. See [Migrate before the preview ends](#migrate-before-the-preview-ends). This is a preview feature that isn't intended for production use; review the [Preview limitations](#preview-limitations). 


The following diagram illustrates how you could create Dynamic-Group-A with members of Security-Group-X and Security-Group-Y. Members of the groups inside Security-Group-X and Security-Group-Y don't become members of Dynamic-Group-A.

:::image type="content" source="./media/groups-dynamic-rule-member-of/member-of-diagram.png" alt-text="Diagram that shows how the memberOf attribute works.":::

With this preview, admins can configure dynamic membership groups with the `memberOf` attribute in the Azure portal, Microsoft Graph, and PowerShell. Security groups, Microsoft 365 groups, and groups that are synced from on-premises Active Directory can all be added as members of these dynamic membership groups. They can also all be added to a single group. For example, the dynamic group could be a security group, but you can use Microsoft 365 groups, security groups, and groups that are synced from on-premises to define its membership.

## Prerequisites

You must be at least a [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator) to use the `memberOf` attribute to create a Microsoft Entra dynamic group. You must have a Microsoft Entra ID P1 or P2 license for the Microsoft Entra tenant.

## Preview limitations


- This preview should only be used in test environments as it can affect dynamic group processing in the tenant. These limitations are being addressed, and updates will be provided when they're available.
- Each Microsoft Entra tenant is limited to 500 dynamic groups using the `memberOf` attribute. The `memberOf` groups count toward the total dynamic group quota of 15,000.
- Each dynamic group can have up to 50 member groups.
- When you add members of security groups to `memberOf` dynamic membership groups, only direct members of the security group become members of the dynamic group.
- You can't use one `memberOf` dynamic group to define the membership of another `memberOf` dynamic group. For example, Dynamic Group A, with members of group B and C in it, can't be a member of Dynamic Group D.
- The `memberOf` attribute can't be used with other rules. For example, a rule that states dynamic group A should contain members of group B and also should contain only users located in Redmond will fail.
- The dynamic group rule builder and validate feature can't be used for `memberOf` at this time.
- The `memberOf` attribute can't be used with other operators. For example, you can't create a rule that states "Members Of group A can't be in Dynamic group B."
- Users included in `memberOf` dynamic membership groups might cause a slower processing time for your tenant, if the tenant has a large number of groups or frequent dynamic membership groups updates.
- Membership of a memberOf dynamic group doesn't automatically update when a child group is deleted or when members are removed from a child group. The affected users or devices remain members of the memberOf dynamic group until the rule is modified.


- Only available in public cloud. 

## Get started

This feature is available in the Azure portal, Microsoft Graph, and PowerShell. However, the `memberOf` attribute isn’t currently supported in the rule builder UI. To use `memberOf` in the Azure portal, you must define the rule by using the rule editor (advanced syntax).

### Create a memberOf dynamic group

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Groups** > **All groups**.
1. Select **New group**.
1. Fill in group details. The group type can be **Security** or **Microsoft 365**, and the membership type can be set to **Dynamic User** or **Dynamic Device**.
1. Select **Add dynamic query**.
1. MemberOf isn't yet supported in the rule builder UI. Select **Edit** to write the rule in the **Rule syntax** box.
    1. Example user rule: `user.memberof -any (group.objectId -in ['groupId'])`
    1. Example device rule: `device.memberof -any (group.objectId -in ['groupId'])`  
    
    > [!NOTE]
    > Replace `'groupId'` with the **object ID of the source group** whose members you want to include in the dynamic group.
    >
    > The two examples are alternatives:
    >
    > - Use the **user** rule when creating a **Dynamic user** group.
    > - Use the **device** rule when creating a **Dynamic device** group.
    >
    > To include multiple source groups, specify multiple group object IDs. For example:
    >
    > ```text
    > user.memberof -any (group.objectId -in ['<groupObjectId1>', '<groupObjectId2>'])
    > ```

1. Select **OK**.
1. Select **Create group**.

## Migrate before the preview ends

As Microsoft continues to improve the scale and reliability of dynamic membership processing, the `memberOf` preview is ending. During preview, we observed that using `memberOf` can slow dynamic membership processing for all groups in a tenant. `memberOf` is a preview operator and isn't recommended for production use.

We recognize the importance of the customer scenarios that `memberOf` addresses, and we're continuing to develop an alternative solution that meets these needs with the right level of scalability and reliability.
In the interim, identify and replace every configuration that uses the `memberOf` operator before November 3, 2026. After that date, configurations that still use `memberOf` stop updating and stay in their last known state, which can leave access stale and enforcement gaps in place.

**Dynamic membership groups**

- Export dynamic membership groups from the Microsoft Entra admin center and identify rules that contain `memberOf`.
- Replace `memberOf` with [supported rule operators](~/identity/users/groups-dynamic-rule-more-efficient.md), or convert the group to assigned membership.
- Validate group membership after making changes. If the group is no longer needed, pause or delete it.

**Dynamic administrative units**

- Use Microsoft Graph PowerShell to identify [dynamic administrative units](~/identity/role-based-access-control/admin-units-members-dynamic.md) that use `memberOf` rules.
- Replace `memberOf`-based rules with supported logic, or convert the administrative unit to assigned membership.
- Validate both membership and administrative scope. If the administrative unit is no longer needed, delete it.

**Entitlement management auto-assignment policies**

- Use Microsoft Graph PowerShell to identify [auto-assignment policies](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md) that use `memberOf`.
- Replace `memberOf`-based logic with supported attribute-based operators where possible. If no equivalent rule is available, plan an alternative assignment method before retirement.
- Validate access package assignments after making changes.


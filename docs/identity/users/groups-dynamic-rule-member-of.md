---
title: Configure dynamic membership groups with the memberOf attribute in the Azure portal
description: Learn how to create a dynamic membership group that can contain members of other groups in Microsoft Entra ID.

author: billmath
manager: femila
ms.service: entra-id
ms.subservice: users
ms.topic: conceptual
ms.date: 12/30/2024
ms.author: billmath
ms.reviewer: krbain
ms.custom: it-pro
---

# Configure dynamic membership groups with the memberOf attribute in the Azure portal

This feature preview in Microsoft Entra ID enables admins to create dynamic membership groups and administrative units that populate by adding members of other groups using the `memberOf` attribute. Apps that couldn't read group-based membership previously in Microsoft Entra ID can now read the entire membership of these new `memberOf` groups. Not only can these groups be used for apps but they can also be used for licensing assignments.

The following diagram illustrates how you could create Dynamic-Group-A with members of Security-Group-X and Security-Group-Y. Members of the groups inside Security-Group-X and Security-Group-Y don't become members of Dynamic-Group-A.

:::image type="content" source="./media/groups-dynamic-rule-member-of/member-of-diagram.png" alt-text="Diagram that shows how the memberOf attribute works.":::

With this preview, admins can configure dynamic membership groups with the `memberOf` attribute in the Azure portal, Microsoft Graph, and PowerShell. Security groups, Microsoft 365 groups, and groups that are synced from on-premises Active Directory can all be added as members of these dynamic membership groups. They can also all be added to a single group. For example, the dynamic group could be a security group, but you can use Microsoft 365 groups, security groups, and groups that are synced from on-premises to define its membership.

## Prerequisites

You must be at least a [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator) to use the `memberOf` attribute to create a Microsoft Entra dynamic group. You must have a Microsoft Entra ID P1 or P2 license for the Microsoft Entra tenant.

## Preview limitations


- Each Microsoft Entra tenant is limited to 500 dynamic groups using the `memberOf` attribute. The `memberOf` groups count toward the total dynamic group quota of 15,000.
- Each dynamic group can have up to 50 member groups.
- When you add members of security groups to `memberOf` dynamic membership groups, only direct members of the security group become members of the dynamic group.
- You can't use one `memberOf` dynamic group to define the membership of another `memberOf` dynamic group. For example, Dynamic Group A, with members of group B and C in it, can't be a member of Dynamic Group D.
- The `memberOf` attribute can't be used with other rules. For example, a rule that states dynamic group A should contain members of group B and also should contain only users located in Redmond will fail.
- The dynamic group rule builder and validate feature can't be used for `memberOf` at this time.
- The `memberOf` attribute can't be used with other operators. For example, you can't create a rule that states "Members Of group A can't be in Dynamic group B."
- Users included in `memberOf` dynamic membership groups may cause a slower processing time for your tenant, if the tenant has a large number of groups or frequent dynamic membership groups updates.

## Get started

This feature can be used in the Azure portal, Microsoft Graph, and PowerShell. Because `memberOf` isn't yet supported in the rule builder, you must enter your rule in the rule editor.

### Create a memberOf dynamic group

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Groups** > **All groups**.
1. Select **New group**.
1. Fill in group details. The group type can be **Security** or **Microsoft 365**, and the membership type can be set to **Dynamic User** or **Dynamic Device**.
1. Select **Add dynamic query**.
1. MemberOf isn't yet supported in the rule builder UI. Select **Edit** to write the rule in the **Rule syntax** box.
    1. Example user rule: `user.memberof -any (group.objectId -in ['groupId'])`
    1. Example device rule: `device.memberof -any (group.objectId -in ['groupId'])`
1. Select **OK**.
1. Select **Create group**.

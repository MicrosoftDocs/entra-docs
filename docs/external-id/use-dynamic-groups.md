---
title: Dynamic groups setup
description: Learn how to create and manage dynamic membership groups in Microsoft Entra External ID. Set rules based on user attributes to automate group membership for B2B collaboration.

 
ms.service: entra-external-id
ms.topic: how-to
ms.date: 10/21/2024

ms.author: cmulligan
author: csmulligan
manager: celestedg
ms.custom: it-pro
ms.collection: M365-identity-device-management

# Customer intent: As an administrator managing user access in Microsoft Entra B2B collaboration, I want to create dynamic membership groups based on user attributes, so that I can automatically add or remove members from security groups and provide access to applications or cloud resources.
---

# Create and manage dynamic membership groups for B2B collaboration in Microsoft Entra External ID

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

## What are dynamic membership groups?
A dynamic membership group is a security-based configuration for Microsoft Entra available in the [Microsoft Entra admin center](https://entra.microsoft.com). Administrators can set rules to populate dynamic membership groups that are created in Microsoft Entra ID based on user attributes (such as [userType](user-properties.md), department, or country/region). Members can be automatically added to or removed from a security group based on their attributes. These groups can provide access to applications or cloud resources (SharePoint sites, documents) and to assign licenses to members. Learn more about [dedicated groups in Microsoft Entra ID](/entra/fundamentals/how-to-manage-groups).

## Prerequisites
[Microsoft Entra ID P1 or P2 licensing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing) is required to create and use dynamic membership groups. Learn more in [Create attribute-based rules for dynamic membership groups in Microsoft Entra ID](~/identity/users/groups-dynamic-membership.md).

## Creating an "all users" dynamic group


You can create a group containing all users within a tenant using a membership rule. When users are added or removed from the tenant in the future, the group's membership is adjusted automatically.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Groups** > **All groups**, and then select **New group**.
1. On the **New Group** page, under **Group type**, select **Security**. Enter a **Group name** and **Group description** for the new group. 
2. Under **Membership type**, select **Dynamic User**, and then select **Add dynamic query**. 
4. Above the **Rule syntax** text box, select **Edit**. On the **Edit rule syntax** page, type the following expression in the text box:

   ```
   user.objectId -ne null
   ```
1. Select **OK**. The rule appears in the Rule syntax box:

   :::image type="content" source="media/use-dynamic-groups/all-user-rule-syntax.png" alt-text="Screenshot of rule syntax for all users dynamic group." lightbox="media/use-dynamic-groups/all-user-rule-syntax.png":::

1.  Select **Save**. The new dynamic group will now include B2B guest users and member users.


1. Select **Create** on the **New group** page to create the group.

## Creating a group of members only

If you want your group to exclude guest users and include only members of your tenant, create a dynamic group as described above, but in the **Rule syntax** box, enter the following expression:

```
(user.objectId -ne null) and (user.userType -eq "Member")
```

The following image shows the rule syntax for a dynamic group modified to include members only and exclude guests.

:::image type="content" source="media/use-dynamic-groups/all-member-user-rule-syntax.png" alt-text="Screenshot of rule syntax where user type equals member." lightbox="media/use-dynamic-groups/all-member-user-rule-syntax.png":::

## Creating a group of guests only

You might also find it useful to create a new dynamic group that contains only guest users, so that you can apply policies (such as Microsoft Entra Conditional Access policies) to them. Create a dynamic group as described above, but in the **Rule syntax** box, enter the following expression:

```
(user.objectId -ne null) and (user.userType -eq "Guest")
```

The following image shows the rule syntax for a dynamic group modified to include guests only and exclude member users.

:::image type="content" source="media/use-dynamic-groups/all-guest-user-rule-syntax.png" alt-text="Screenshot of rule syntax where user type equals guest." lightbox="media/use-dynamic-groups/all-guest-user-rule-syntax.png":::

## Next steps

- [B2B collaboration user properties](user-properties.md)
- [Reset redemptions status](reset-redemption-status.md)
- [Conditional Access for B2B collaboration users](authentication-conditional-access.md)

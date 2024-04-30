---
title: Add users to a dynamic group
description: Use groups with user membership rules to add or remove users automatically

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: tutorial
ms.date: 09/08/2023
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro
ms.collection: M365-identity-device-management
#Customer intent: As a new Microsoft Entra identity administrator, I want to automatically add or remove users, so I don't have to manually do it."
---

# Add or remove group members automatically

In Microsoft Entra ID, part of Microsoft Entra, you can automatically add or remove users to security groups or Microsoft 365 groups, so you don't always have to do it manually. Whenever any properties of a user or device change, Microsoft Entra ID evaluates all dynamic group rules in your Microsoft Entra organization to see if the change should add or remove members.

In this tutorial, you learn how to:
> [!div class="checklist"]
> * Create an automatically populated group of guest users from a partner company
> * Assign licenses to the group for the partner-specific features for guest users to access
> * Bonus: secure the **All users** group by removing guest users so that, for example, you can give your member users access to internal-only sites

If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.

## Prerequisites

This feature requires one Microsoft Entra ID P1 or P2 license for you as the global administrator of the organization. If you don't have one, in Microsoft Entra ID, select **Licenses** > **Products** > **Try/Buy**.

You're not required to assign licenses to the users for them to be members in dynamic groups. You only need the minimum number of available Microsoft Entra ID P1 licenses in the organization to cover all such users. 

## To create a group of guest users

[!INCLUDE [portal updates](~/includes/portal-update.md)]

First, you'll create a group for your guest users who all are from a single partner company. They need special licensing, so it's often more efficient to create a group for this purpose.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Select Microsoft Entra ID.
2. Select **Groups** > **All groups** > **New group**.

   :::image type="content" source="./media/groups-dynamic-tutorial/new-group.png" alt-text="Screenshot of using the Select command to start a new group.":::

3. On the **New Group** pane:
  
   * Enter a *Guest users name*, *email address* and *description* for the group.
   * Change **Membership type** to **Dynamic User**.
   
   :::image type="content" source="./media/groups-dynamic-tutorial/new-dynamic-group.png" alt-text="Screenshot of Group page where user enters the dynamic group details.":::

4. Select **No owners selected** and on the **Add Owners** pane, scroll to locate the desired owners. Click on the name(s) to add owners to the group.
5. Click **Select** to save the owners and close the **Add Owners** pane.  
6. Select **Add dynamic query** in the **Dynamic user members** box.
7. On the **Dynamic membership rules** pane:

   * In the **Property** field, click on the existing value and select **userType**. 
   * Verify that the **Operator** field has **Equals** selected.  
   * Select the **Value** field and enter **Guest**. 
   * Click the **Add Expression** hyperlink to add another line.
   * In the **And/Or** field, select **And**.
   * In the **Property** field, select **companyName**.
   * Verify that the **Operator** field has **Equals** selected.
   * In the **Value** field, enter **Contoso**.
   * Click **Get custom extention properties** to enter an application ID to retrieve all available custom extension properties for creating a rule. 
   * When you're done, click **Save** to close **Dynamic membership rules**.
   
8. To finish and create the group, select **Create** on the **Group** pane.

## Assign licenses

Now that you have your new group, you can apply the licenses that these partner users need.

1. In the Microsoft Entra admin center browse to **Identity** > **Billing** > **Licenses** > **All products**, select one or more licenses, and then select **Licensed groups**.

   :::image type="content" source="./media/groups-dynamic-tutorial/add-licensed-group.png" alt-text="Screenshot of Assign licenses to a new group.":::

2. Search for the group name that you want to add, and then select **Assign**.
3. **Assignment options** allow you to turn on or off the service plans included the licenses that you selected. When you make a change, be sure to click **OK** to save your changes.
4. To complete the assignment, on the **Assign license** pane, click **Assign** at the bottom of the pane.

## Remove guests from All users group

Perhaps your ultimate administrative plan is to assign all of your guest users to their own groups by company. You can also now change the **All users** group so that it is reserved for only members users in your organization. Then you can use it to assign apps and licenses that are specific to your home organization.

:::image type="content" source="./media/groups-dynamic-tutorial/all-users-edit.png" alt-text="Screenshot of using the Change all users group to members only.":::

## Clean up resources

### To remove the guest users group

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Browse to **Groups** > **All groups**. 
1. Select the **Guest users** group, select the ellipsis (...), and then select **Delete**. When you delete the group, any assigned licenses are removed.

### To restore the All Users group

1. Select **Identity** > **Groups** > **All groups**. Select the name of the **All users** group to open the group.
1. Select **Dynamic membership rules**, clear all the text in the rule, and select **Save**.

## Next steps

[Group licensing basics](~/fundamentals/concept-group-based-licensing.md)

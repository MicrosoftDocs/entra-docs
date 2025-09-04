---
title: Create or Edit a Dynamic Membership Group and Get Its Processing Status
description: Learn how to create or update rules for dynamic membership groups in the Azure portal and check their processing status.
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 12/19/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro, sfi-image-nochange
---

# Create or update a dynamic membership group in Microsoft Entra ID

You can use rules to determine dynamic membership groups based on user or device properties in Microsoft Entra ID. This article describes how to set up a rule for a dynamic membership groups in the Azure portal.

Group membership based on user or device properties is supported for security groups and Microsoft 365 groups. When you apply a rule for a dynamic membership group, user and device attributes are evaluated for matches with the membership rule. When an attribute changes for a user or device, all rules for dynamic membership groups in the organization are processed for changes. Users and devices are added or removed if they meet the conditions for a dynamic membership group. In Microsoft Entra ID, a single tenant can have a maximum of 15,000 dynamic membership groups.

> [!NOTE]
> Security groups can include either devices or users, but Microsoft 365 groups can include only users.

Using dynamic membership groups requires a Microsoft Entra ID P1 license or an Intune for Education license. For more information, see [Manage rules for dynamic membership groups in Microsoft Entra ID](./groups-dynamic-membership.md).

## Rule builder in the Azure portal

Microsoft Entra ID provides a rule builder to create and update your important rules more quickly. The rule builder supports the construction of up to five expressions.

:::image type="content" source="./media/groups-create-rule/update-dynamic-group-rule.png" alt-text="Screenshot that shows the rule builder, with the action for adding an expression highlighted.":::

The rule builder makes it easier to form a rule with a few simple expressions. However, it can't be used to reproduce every rule. If the rule builder doesn't support the rule that you want to create, you can use the text box.

Here are some examples of advanced rules or syntax for which we recommend that you use the text box:

- Rule with more than five expressions
- Rule for direct reports
- Setting [operator precedence](groups-dynamic-membership.md#operator-precedence)
- [Rule with complex expressions](groups-dynamic-membership.md#rules-with-complex-expressions); for example, `(user.proxyAddresses -any (_ -contains "contoso"))`

> [!NOTE]
> The rule builder might not be able to display some rules constructed in the text box. You might see a message when the rule builder can't display the rule. The rule builder doesn't change the supported syntax, validation, or processing of rules for dynamic membership groups in any way.

For examples of syntax and supported properties, operators, and values for a membership rule, see [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md).

## Create a rule for a dynamic membership group

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID** > **Groups**.
1. Select **All groups**, and then select **New group**.

   :::image type="content" source="./media/groups-create-rule/create-new-group.png" alt-text="Screenshot that shows selections for adding a new group.":::

1. On the **Group** pane, enter a name and description for the new group. Select a **Membership type** value for either users or devices, and then select **Add dynamic query**.

1. In the rule builder, add up to five expressions. To add more than five expressions, you must use the text box.

   :::image type="content" source="./media/groups-create-rule/add-dynamic-group-rule.png" alt-text="Screenshot that shows pane for configuring rules, with the button for adding an expression highlighted.":::

1. To see the custom extension properties that are available for your membership query:
   1. Select **Get custom extension properties**.
   1. Enter the application ID, and then select **Refresh properties**.

1. After you finish creating the rule, select **Save**.

1. On the **New group** page, select **Create** to create the group.

If the rule that you entered isn't valid, the portal displays an explanation of why the rule couldn't be processed. Read it carefully to understand how to fix the rule.

## Update an existing rule

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).

1. Select **Microsoft Entra ID**.

1. Select **Groups** > **All groups**.

1. Select a group to open its profile.

1. On the profile page for the group, select **Dynamic membership rules**. The rule builder supports up to five expressions. To add more than five expressions, you must use the text box.

   :::image type="content" source="./media/groups-create-rule/update-dynamic-group-rule.png" alt-text="Screenshot that shows the rule builder for a dynamic membership group.":::

1. To see the custom extension properties that are available for your membership rule:
   1. Select **Get custom extension properties**.
   1. Enter the application ID, and then select **Refresh properties**.

1. After you finish updating the rule, select **Save**.

## Turn on or off the welcome email

When an admin creates a new Microsoft 365 group, the users who are added to the group receive a welcome email notification. Later, if any attributes of a user or device (only for security groups) change, all rules for dynamic membership groups in the organization are processed for changes. Users who are added then also receive the welcome notification.

You can turn on or turn off this behavior in [Exchange PowerShell](/powershell/module/exchange/set-unifiedgroup).

## Check the processing status for a rule

You can see the rule processing status and the date of the last membership change on the overview page for the dynamic membership group.
  
:::image type="content" source="./media/groups-create-rule/group-status.png" alt-text="Screenshot that shows the status of a dynamic membership group.":::

The following status messages can appear for **Dynamic rule processing status**:

- **Evaluating**: The group change was received and the updates are being evaluated.
- **Processing**: Updates are being processed.
- **Update complete**: Processing finished and all applicable updates were made.
- **Processing error**:  Processing couldn't finish because of an error in evaluating the membership rule.
- **Update paused**: The administrator paused the rule to update dynamic membership groups. `MembershipRuleProcessingState` is set to `Paused`.
- **Not started**: Processing hasn't started.

> [!NOTE]
> This page now has a **Pause processing** option. Previously, this option was available only through the modification of the `membershipRuleProcessingState` property. Someone who has at least the [Groups Administrator](/entra/identity/role-based-access-control/permissions-reference#groups-administrator) role can manage this setting and can pause and resume the processing of dynamic membership groups. Group owners who don't have the correct roles don't have the necessary rights to edit this setting.

The following status messages appear for **Last membership change**:

- **\<Date and time\>**: The membership was last updated at this date and time.
- **In Progress**: Updates are currently in progress.
- **Unknown**: The last update time can't be retrieved. The group might be new.

> [!IMPORTANT]
> After you pause and unpause the processing of dynamic membership groups, the **Last membership change** date shows a placeholder value. This value is updated after the processing finishes.

If an error occurs during processing of the membership rule for a specific group, an alert appears on the top of the overview page for the group. If no pending updates for dynamic membership groups can be processed for all the groups within the organization for more than 24 hours, an alert appears above **All groups**.

:::image type="content" source="./media/groups-create-rule/processing-error.png" alt-text="Screenshot of an alert that says dynamic group memberships have not been updated due to system delays.":::

## Related content


- [Manage Microsoft Entra groups and group membership](/entra/fundamentals/how-to-manage-groups)
- [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md)

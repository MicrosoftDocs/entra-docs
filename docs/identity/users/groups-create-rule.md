---
title: Create or edit a dynamic membership group and get its processing status
description: How to create or update rules for dynamic membership groups in the Azure portal, and check its processing status.

author: barclayn
manager: amycolannino

ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 08/06/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro
---

# Create or update a dynamic membership group in Microsoft Entra ID

You can use rules to determine group membership based on user or device properties In Microsoft Entra ID, part of Microsoft Entra. This article tells how to set up a rule for a dynamic membership group in the Azure portal. 

Group membership based on user or device properties is supported for security groups and Microsoft 365 groups. When a group membership rule is applied, user and device attributes are evaluated for matches with the membership rule. When an attribute changes for a user or device, all group membership rules in the organization are processed for changes. Users and devices are added or removed if they meet the conditions for a dynamic membership group. 

> [!NOTE]
> Security groups can be used for either devices or users, but Microsoft 365 groups can include only users. 

Using dynamic membership groups require Microsoft Entra ID P1 license or Intune for Education license. See [Rules for dynamic membership groups in Microsoft Entra ID](./groups-dynamic-membership.md) for more details. 

## Rule builder in the Azure portal

Microsoft Entra ID provides a rule builder to create and update your important rules more quickly. The rule builder supports the construction up to five expressions. The rule builder makes it easier to form a rule with a few simple expressions, however, it can't be used to reproduce every rule. If the rule builder doesn't support the rule you want to create, you can use the text box.

Here are some examples of advanced rules or syntax for which we recommend that you construct using the text box:

- Rule with more than five expressions
- The Direct reports rule
- Setting [operator precedence](groups-dynamic-membership.md#operator-precedence)
- [Rules with complex expressions](groups-dynamic-membership.md#rules-with-complex-expressions); for example `(user.proxyAddresses -any (_ -contains "contoso"))`

> [!NOTE]
> The rule builder might not be able to display some rules constructed in the text box. You might see a message when the rule builder is not able to display the rule. The rule builder doesn't change the supported syntax, validation, or processing of rules for dynamic membership groups in any way.

:::image type="content" source="./media/groups-create-rule/update-dynamic-group-rule.png" alt-text="Screenshot that shows the rules for dynamic membership groups page with the Add expression action on the Configure rules tab selected.":::

For examples of syntax, supported properties, operators, and values for a membership rule, see [Rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md).

## To create a rule for a dynamic membership group

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select Microsoft Entra ID.> **Groups**.
1. Select **All groups**, and select **New group**.

   :::image type="content" source="./media/groups-create-rule/create-new-group.png" alt-text="Screenshot showing how to select the Add new group action.":::

1. On the **Group** page, enter a name and description for the new group. Select a **Membership type** for either users or devices, and then select **Add dynamic query**. The rule builder supports up to five expressions. To add more than five expressions, you must use the text box.

   :::image type="content" source="./media/groups-create-rule/add-dynamic-group-rule.png" alt-text="Screenshot that shows the All groups page with the New group action selected.":::

1. To see the custom extension properties available for your membership query:
   1. Select **Get custom extension properties**
   1. Enter the application ID, and then select **Refresh properties**.
1. After creating the rule, select **Save**.
1. Select **Create** on the **New group** page to create the group.

If the rule you entered isn't valid, an explanation of why the rule couldn't be processed is displayed in a notification in the portal. Read it carefully to understand how to fix the rule.

## To update an existing rule

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select Microsoft Entra ID.
1. Select **Groups** > **All groups**.
1. Select a group to open its profile.
1. On the profile page for the group, select **Dynamic membership rules**. The rule builder supports up to five expressions. To add more than five expressions, you must use the text box.

   :::image type="content" source="./media/groups-create-rule/update-dynamic-group-rule.png" alt-text="Screenshot showing how to add a rule for a dynamic membership group.":::

1. To see the custom extension properties available for your membership rule:
   1. Select **Get custom extension properties**
   1. Enter the application ID, and then select **Refresh properties**.
1. After updating the rule, select **Save**.

## Turn on or off welcome email

When a new Microsoft 365 group is created, a welcome email notification is sent the users who are added to the group. Later, if any attributes of a user or device(only in case of security groups) change, all rules for dynamic membership groups in the organization are processed for changes. Users who are added then also receive the welcome notification. You can turn off this behavior in [Exchange PowerShell](/powershell/module/exchange/set-unifiedgroup).

## Check processing status for a rule

You can see the rule processing status and the last membership change date on the **Overview** page for the dynamic membership group.
  
  :::image type="content" source="./media/groups-create-rule/group-status.png" alt-text="Screenshot of a diagram of the dynamic membership group status.":::

The following status messages can be shown for **Dynamic rule processing** status:

- **Evaluating**:  The group change has been received and the updates are being evaluated.
- **Processing**: Updates are being processed.
- **Update complete**: Processing has completed and all applicable updates have been made.
- **Processing error**:  Processing couldn't be completed because of an error evaluating the membership rule.
- **Update paused**: Rule for dynamic membership group updates have been paused by the administrator. MembershipRuleProcessingState is set to “Paused”.
- **Not started**: Processing not started yet.

>[!NOTE]
>In this screen you now may also choose to **Pause processing**. Previously, this option was only available through the modification of the membershipRuleProcessingState property. Those assigned at least the [Groups Administrator](/entra/identity/role-based-access-control/permissions-reference#groups-administrator) role can manage this setting and can pause and resume dynamic membership group processing. Group owners without the correct roles do not have the rights needed to edit this setting.

The following status messages can be shown for **Last membership change** status:

- &lt;**Date and time**&gt;: The last time the membership was updated.
- **In Progress**: Updates are currently in progress.
- **Unknown**: The last update time can't be retrieved. The group might be new.

> [!IMPORTANT]
> After pausing and unpausing processing of dynamic membership groups, the "Last membership change" date will show a placeholder value. This value is updated once the processing completes.

If an error occurs while processing the membership rule for a specific group, an alert is shown on the top of the **Overview page** for the group. If no pending dynamic membership group updates can be processed for all the groups within the organization for more than 24 hours, an alert is shown on the top of **All groups**.

:::image type="content" source="./media/groups-create-rule/processing-error.png" alt-text="Screenshot showing how to process error message alerts.":::

## Next steps

The following articles provide additional information on how to use groups in Microsoft Entra ID.

- [See existing groups](~/fundamentals/groups-view-azure-portal.md)
- [Create a new group and adding members](~/fundamentals/how-to-manage-groups.yml)
- [Manage settings of a group](~/fundamentals/how-to-manage-groups.yml)
- [Manage memberships of a group](~/fundamentals/how-to-manage-groups.yml)
- [Manage rules for dynamic membership groups for users](groups-dynamic-membership.md)

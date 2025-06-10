---
title: Validate Rules for Dynamic Membership Groups
description: Learn how to test members against a rule for a dynamic membership groups in Microsoft Entra ID.

author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 12/19/2024
ms.author: barclayn
ms.reviewer: yukarppa
ms.custom: it-pro
---

# Validate rules for dynamic membership groups in Microsoft Entra ID

Microsoft Entra ID provides the means to validate rules for dynamic membership groups. On the **Validate rules** tab, you can validate a rule against sample group members to confirm that the rule is working as expected.

When you create or update rules for dynamic membership groups, you want to know whether a user or a device is a member of the group. This knowledge helps you evaluate whether a user or device meets the rule criteria. It also helps you troubleshoot when membership isn't expected.

## Prerequisites

To evaluate the rule for dynamic membership groups, the administrator must be at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).

> [!TIP]
> Assigning one of the required roles via indirect role assignment is not supported.

## Validate a rule for dynamic membership groups

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Groups Administrator.

2. Browse to **Entra ID** > **Groups** > **All groups**.

3. Select an existing dynamic group or create a new dynamic group, and then select **Dynamic membership rules**.

   :::image type="content" source="./media/groups-dynamic-rule-validation/validate-tab.png" alt-text="Screenshot of selections for viewing details of dynamic membership rules.":::

4. On the **Validate Rules** tab, select users to validate their memberships. You can select 20 users or devices at one time.

   :::image type="content" source="./media/groups-dynamic-rule-validation/validate-tab-add-users.png" alt-text="Screenshot of the button for adding users in the process of validating a rule.":::

5. After you finish selecting users or devices, choose **Select**. Validation automatically starts. The validation results show whether a user is a member of the group or not.

   :::image type="content" source="./media/groups-dynamic-rule-validation/validate-tab-results.png" alt-text="Screenshot that shows the results of rule validation.":::

6. If the rule isn't valid or if there's a network problem, the results show **Unknown**. If the value is **Unknown**, select **View details**. The detailed error message describes the problem and the necessary actions.

   :::image type="content" source="./media/groups-dynamic-rule-validation/validate-tab-view-details.png" alt-text="Screenshot that shows detailed results of rule validation.":::

7. You can modify the rule to trigger a new validation of memberships. To see why a user isn't a member of the group, select **View details**. Verification details show the result of each expression that composes the rule. Select **OK** to close the details.

## Related content

- [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md)

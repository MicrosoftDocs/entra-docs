---
title: Validate rules for dynamic membership groups membership (preview)
description: How to test members against a rule for a dynamic membership groups in Microsoft Entra ID.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 08/25/2024
ms.author: barclayn
ms.reviewer: yukarppa
ms.custom: it-pro
---

# Validate rules for dynamic membership groups in Microsoft Entra ID (preview) 

Microsoft Entra ID provides the means to validate rules for dynamic membership groups (in public preview). On the **Validate rules** tab, you can validate that rule against sample group members to confirm the rule is working as expected. When you create or update rules for dynamic membership groups, you want to know whether a user or a device is a member of the group. This knowledge helps you evaluate whether a user or device meets the rule criteria and help you troubleshoot when membership isn't expected.

## Prerequisites

To evaluate the rule for dynamic membership groups, the administrator must be at least a Groups Administrator.

> [!TIP]
> Assigning one of required roles via indirect dynamic membership groups is not yet supported.

## To validate a rule for dynamic membership groups

To get started, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).

1. Browse to **Identity** > **Groups** > **All groups**. 
2. Select an existing dynamic group or create a new dynamic group and select **Dynamic membership rules**. You can then see the **Validate Rules** tab.

   :::image type="content" source="./media/groups-dynamic-rule-validation/validate-tab.png" alt-text="Screenshot of finding the Validate rules tab and start with an existing rule.":::

3. On the **Validate rules** tab, select users to validate their memberships. 20 users or devices can be selected at one time.

   :::image type="content" source="./media/groups-dynamic-rule-validation/validate-tab-add-users.png" alt-text="Screenshot of adding users to validate the existing rule against.":::

4. After you select users or devices from the picker, and then **Select**, validation automatically starts and validation results appear.

   :::image type="content" source="./media/groups-dynamic-rule-validation/validate-tab-results.png" alt-text="Screenshot of viewing the results of the rule validation.":::

5. The results show whether a user is a member of the group or not. If the rule isn't valid or if there's a network issue, the results show as **Unknown**. If the value is **Unknown**, the detailed error message describes the issue and actions needed.

   :::image type="content" source="./media/groups-dynamic-rule-validation/validate-tab-view-details.png" alt-text="Screenshot of viewing the details of the results of the rule validation.":::

6. You can modify the rule to trigger a new validation of memberships. To see why user isn't a member of the group, select **View details** and verification details show the result of each expression composing the rule. Then select **OK** to exit.

## Next steps

- [Rulues for dynamic membership groups](groups-dynamic-membership.md)

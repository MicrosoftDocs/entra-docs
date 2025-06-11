---
title: Block access for users with elevated insider risk
description: Create Conditional Access policies using signals from Adaptive protection in Microsoft Purview.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: poulomib
---
# Block access for users with insider risk

Most users have a normal behavior that can be tracked, when they fall outside of this norm it could be risky to allow them to just sign in. You might want to block that user or ask them to review a specific [terms of use policy](terms-of-use.md). Microsoft Purview can provide an [insider risk signal](concept-conditional-access-conditions.md#insider-risk) to Conditional Access to refine access control decisions. Insider risk management is part of [Microsoft Purview](/purview/insider-risk-management-adaptive-protection). You must enable it before you can use the signal in Conditional Access.

:::image type="content" source="media/policy-risk-based-insider-block/insider-risk-based-conditional-access-policy.png" alt-text="Screenshot of an example Conditional Access policy using insider risk as a condition." lightbox="media/policy-risk-based-insider-block/insider-risk-based-conditional-access-policy.png":::

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Block access with Conditional Access policy

> [!TIP]
> Configure [adaptive protection](/purview/insider-risk-management-adaptive-protection) before you create the following policy.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**:
      1. Select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
      1. Select **Guest or external users** and choose the following:
         1. **B2B direct connect users**.
         1. **Service provider users**.
         1. **Other external users**.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Insider risk**, set **Configure** to **Yes**. 
   1. Under **Select the risk levels that must be assigned to enforce the policy**. 
      1. Select **Elevated**.
      1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**, then select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

Some administrators might create other Conditional Access policies that use other access controls, like terms of use on lower levels of insider risk.

## Related content

- [Dynamically mitigate risks with adaptive protection](/purview/insider-risk-management-adaptive-protection)
- [Insider risk as a condition](concept-conditional-access-conditions.md#insider-risk)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

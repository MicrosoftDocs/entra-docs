---
title: Insider risk-based multifactor authentication
description: Create Conditional Access policies using signals from Adaptive protection in Microsoft Purview.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 02/14/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: poulomib
---
# Common Conditional Access policy: Insider risk based policy

Most users have a normal behavior that can be tracked, when they fall outside of this norm it could be risky to allow them to just sign in. You may want to block that user or maybe just ask them to perform multifactor authentication to prove that they're really who they say they are. 

[Insider risk as a condition](concept-conditional-access-conditions.md#insider-risk)

INSERT MORE TEXT ABOUT INSIDER RISK POLICY HERE For more information, see the article [Help dynamically mitigate risks with adaptive protection](/purview/insider-risk-management-adaptive-protection).

## Template deployment

Organizations can choose to deploy this policy using the steps outlined below or using the [Conditional Access templates](concept-conditional-access-policy-common.md#conditional-access-templates). 

## Enable with Conditional Access policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **Cloud apps** > **Include**, select **All cloud apps**.
1. Under **Conditions** > **Insider risk**, set **Configure** to **Yes**. Under **Select the sign-in risk level this policy will apply to**. 
   1. Select **High** and **Medium**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**.
   1. Select **Grant access**, **Require multifactor authentication**.
   1. Select **Select**.
1. Under **Session**.
   1. Select **Sign-in frequency**.
   1. Ensure **Every time** is selected.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

## Next steps

- [Dynamically mitigate risks with adaptive protection](/purview/insider-risk-management-adaptive-protection)
- [Require reauthentication every time](~/identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)
- [What is Microsoft Entra ID Protection?](~/id-protection/overview-identity-protection.md)

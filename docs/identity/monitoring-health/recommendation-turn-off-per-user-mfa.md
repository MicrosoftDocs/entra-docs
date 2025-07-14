---
title: Turn off per user MFA in Microsoft Entra ID
description: Learn why you should turn off per user MFA in Microsoft Entra ID with Microsoft Entra recommendations
author: shlipsey3
manager: pmwongera

ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 02/21/2025
ms.author: sarahlipsey
ms.reviewer: deawari

# Customer intent: As an IT admin, I need to know how many users in my tenant are using per-user MFA so I can make a plan to switch to Conditional Access MFA.
---

# Microsoft Entra recommendation: Switch from per-user MFA to Conditional Access MFA

[Microsoft Entra recommendations](overview-recommendations.md) is a feature that provides you with personalized insights and actionable guidance to align your tenant with recommended best practices.

This article covers the recommendation to switch per-user multifactor authentication (MFA) accounts to Conditional Access MFA accounts. This recommendation is called `switchFromPerUserMFA` in the recommendations API in Microsoft Graph.

## Description

As an admin, you want to maintain security for your company’s resources, but you also want your employees to easily access resources as needed. MFA enables you to enhance the security posture of your tenant.

In your tenant, you can enable MFA on a per-user basis. In this scenario, your users perform MFA each time they sign in. There are some exceptions, such as when they sign in from trusted IP addresses or when the "remember MFA on trusted devices" feature is turned on. While enabling MFA is a good practice, switching per-user MFA to MFA based on [Conditional Access](../conditional-access/overview.md) can reduce the number of times your users are prompted for MFA.

This recommendation shows up if:

- You have per-user MFA configured for at least 5% of your users.
- Conditional Access policies are active for more than 1% of your users (indicating familiarity with Conditional Access policies).

## Value 

This recommendation improves your user's productivity and minimizes the sign-in time with fewer MFA prompts. Conditional Access and MFA used together help ensure that your most sensitive resources can have the tightest controls, while your least sensitive resources can be more freely accessible. For an overview of available functionality in Conditional Access, see [Building a Conditional Access policy](../conditional-access/concept-conditional-access-policies.md).

## Action plan

1. Require MFA using a Conditional Access policy.
    - [Enable Microsoft Entra multifactor authentication with Conditional Access](../authentication/tutorial-enable-azure-mfa.md).
    - Ensure that you're covering all resources and users you would like to secure with MFA.
1. Ensure that the per-user MFA configuration is turned off.
    1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
    1. Browse to **Users** > **All users** and select the **Per-user MFA** button.

    :::image type="content" source="media/recommendation-turn-off-per-user-mfa/disable-per-user-mfa.png" alt-text="Screenshot of the per-user MFA button in Microsoft Entra admin center." lightbox="media/recommendation-turn-off-per-user-mfa/disable-per-user-mfa-expanded.png":::

    1. Select **Disable MFA** for all users who had this option enabled.

    :::image type="content" source="media/recommendation-turn-off-per-user-mfa/per-user-mfa-details.png" alt-text="Screenshot of the per-user MFA settings in the admin center.":::
    
After all users are migrated to Conditional Access MFA accounts, the recommendation status automatically updates the next time the service runs. Continue to review your Conditional Access policies.

## Related content

- [How to use Microsoft Entra recommendations](howto-use-recommendations.md)
- [Microsoft Graph API for recommendations](/graph/api/resources/recommendation)
- [MFA and Conditional Access policy](../conditional-access/policy-all-users-mfa-strength.md)
- [MFA and Conditional Access policy tutorial](../authentication/tutorial-enable-azure-mfa.md)

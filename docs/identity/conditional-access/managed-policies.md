---
title: Secure your resources with Microsoft managed Conditional Access policies
description: Microsoft managed policies take action to require multifactor authentication to reduce the risk of compromise.

ms.service: active-directory
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 10/26/2023

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: swethar
---
# Microsoft managed policies

As mentioned in the [Microsoft Digital Defense Report in October 2023](https://www.microsoft.com/security/security-insider/microsoft-digital-defense-report-2023)

> ...threats to digital peace have reduced trust in technology and highlighted the urgent need for improved cyber defenses at all levels...
>
> ...at Microsoft, our more than 10,000 security experts analyze over 65 trillion signals each day... driving some of the most influential insights in
cybersecurity. Together, we can build cyber resilience through innovative action and collective defense.

As part this work we're making Microsoft managed policies available in Microsoft Entra tenants around the world. These [simplified Conditional Access policies](#what-is-conditional-access) take action to require multifactor authentication, which a [recent study](https://arxiv.org/abs/2305.00945) finds can reduce the risk of compromise by 99.22%.

At launch Microsoft is deploying the following three policies where our data tells us they would increase an organization's security posture:

- Multifactor authentication for admins accessing Microsoft Admin Portals
- Multifactor authentication for per-user multifactor authentication users
- Multifactor authentication and reauthentication for risky sign-ins

:::image type="content" source="media/managed-policies/microsoft-managed-policy.png" alt-text="Screenshot showing an example of a Microsoft managed policy in the Microsoft Entra admin center." lightbox="media/managed-policies/microsoft-managed-policy-expanded-full.png":::

Administrators with at least the [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role assigned find these policies in the [Microsoft Entra admin center](https://entra.microsoft.com) under **Protection** > **Conditional Access** > **Policies**.

Administrators have the ability to **Edit** the **State** (On, Off, or Report-only) and the **Excluded identities** (Users, Groups, and Roles) in the policy. Organizations should [exclude their break-glass or emergency access accounts](../role-based-access-control/security-emergency-access.md) from these policies the same as they would in other Conditional Access policies.

Microsoft will enable these policies after no less than 60 days after they're introduced in your tenant if they're left in the **Report-only** state. Administrators might choose to enable these policies sooner if they wish.

## Policies

These Microsoft managed policies allow administrators to make simple modifications like excluding users or turning them from report-only mode to on or off. As Administrators get more comfortable with Conditional Access policy, they might choose to clone the policy and make custom versions.

As threats evolve over time, Microsoft might change these policies in the future to take advantage of new features and functionality to improve their function.

### Multifactor authentication for admins accessing Microsoft Admin Portals

This policy covers 14 admin roles that we consider to be highly privileged, who are accessing the [Microsoft Admin Portals group](how-to-policy-mfa-admin-portals.md), and requires them to perform multifactor authentication.

This policy targets Microsoft Entra ID P1 and P2 tenants where security defaults aren't enabled.

### Multifactor authentication for per-user multifactor authentication users

This policy covers users with [per-user MFA](/azure/active-directory/authentication/howto-mfa-userstates), a configuration that Microsoft no longer recommends. These users are targeted by Conditional Access and required to perform multifactor authentication for all cloud apps.

This policy targets Microsoft Entra ID P1 and P2 tenants where security defaults aren't enabled and there are less than 500 per-user MFA enabled/enforced users.

### Multifactor authentication and reauthentication for risky sign-ins

This policy covers all users and requires MFA and reauthentication when we detect high-risk sign-in. High-risk in this case means something about the way the user signed in is out of the ordinary. These high-risk sign-ins might include: travel that isn't normal, password spray attacks, or issues with a token. For more information about these risk definitions, see the article [What are risk detections](/entra/id-protection/concept-identity-protection-risks#sign-in-risk-detections).

This policy targets Microsoft Entra ID P2 tenants where there are enough licenses for each user.

## How do I see the effects?

Administrators can look at the Policy impact on sign-ins section to see a quick summary of the effect of the policy in their environment.

:::image type="content" source="media/managed-policies/microsoft-managed-policy-impact-on-sign-in.png" alt-text="Screenshot showing the impact of a policy on the organization.":::

Administrators can go deeper and look through the Microsoft Entra sign-in logs to see these policies in action in their organization.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Identity** > **Monitoring & health** > **Sign-in logs**.
1. Find the specific sign-in you want to review. Add or remove filters and columns to filter out unnecessary information.
   1. Add filters to narrow the scope:
      1. **Correlation ID** when you have a specific event to investigate.
      1. **Conditional Access** to see policy failure and success. Scope your filter to show only failures to limit results.
      1. **Username** to see information related to specific users.
      1. **Date** scoped to the time frame in question.
1. Once the sign-in event that corresponds to the user's sign-in is found, select the **Conditional Access** tab. The Conditional Access tab shows the specific policy or policies that resulted in the sign-in interruption.
   1. To investigate further, drill down into the configuration of the policies by clicking on the **Policy Name**. Clicking the **Policy Name** shows the policy configuration user interface for the selected policy for review and editing.
   1. The **client user** and **device details** that were used for the Conditional Access policy assessment are also available in the **Basic Info**, **Location**, **Device Info**, **Authentication Details**, and **Additional Details** tabs of the sign-in event.

## What is Conditional Access?

Conditional Access is a Microsoft Entra feature that allows organizations to enforce security requirements when accessing resources. Commonly it's used to enforce multifactor authentication, device configuration, or network location requirements.

These policies can be thought of as logical if then statements.

**If** the assignments (users, resources, and conditions) are true, **then** apply the access controls (grant and/or session) in the policy.
**If** you're an administrator, who wants to access one of the Microsoft admin portals, **then** you must perform multifactor authentication to prove it's really you.

## What if I want to make more changes?

Administrators might choose to make further changes to these policies by duplicating them using the **Duplicate** button in the policy list view. This new policy can be configured in the same way as any other Conditional Access policy with starting from a Microsoft recommended position.

## Next steps

- [Deploy other commonly used policies from templates](concept-conditional-access-policy-common.md)
- [Configure and use Conditional Access report-only mode](concept-conditional-access-report-only.md)

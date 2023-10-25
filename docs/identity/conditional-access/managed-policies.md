---
title: Secure your resources with Microsoft managed Conditional Access policies
description: Deploy recommended Conditional Access policies from easy to use templates.

services: active-directory
ms.service: active-directory
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 10/25/2023

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: swethar

ms.collection: M365-identity-device-management
---
# Microsoft managed policies

As mentioned in the [Microsoft Digital Defense Report in October 2023](https://www.microsoft.com/security/security-insider/microsoft-digital-defense-report-2023)

> ...threats to digital peace have reduced trust in technology and highlighted the urgent need for improved cyber defenses at all levels...
>
> ...at Microsoft, our more than 10,000 security experts analyze over 65 trillion signals each day... driving some of the most influential insights in
cybersecurity. Together, we can build cyber resilience through innovative action and collective defense.

As part this work we are making Microsoft managed policies available in Microsoft Entra tenants around the world. These [simplified Conditional Access policies](#what-is-conditional-access) take steps to require multifactor authentication, which a [recent study](https://arxiv.org/abs/2305.00945) finds can reduce the risk of compromise by 99.22%.

At launch Microsoft is deploying the following three policies where our data tells us they would increase an organization's security posture:

- Require multifactor authentication for admins accessing Microsoft Admin Portals
- Require multifactor authentication for per-user MFA enforced users
- Require multifactor authentication and reauthentication for risky sign-ins

:::image type="content" source="media/managed-policies/microsoft-managed-policy.png" alt-text="Screenshot showing an example of a Microsoft managed policy in the Microsoft Entra admin center." lightbox="media/managed-policies/microsoft-managed-policy-expanded-full.png":::

Administrators have the ability to **Edit** the **State** (On, Off, or Report-only) and the **Excluded identities** (Users, Groups, and Roles) in the policy. Organizations should [exclude their break-glass or emergency access accounts](../roles/security-emergency-access.md) from these policies the same as they would in other Conditional Access policies.

Microsoft will enable these policies after no less than 60 days after they're introduced in your tenant if they are left in the **Report-only** state. Administrators might choose to enable these policies sooner if they wish.

## What is Conditional Access?

Conditional Access is a Microsoft Entra feature that allows organizations to enforce security requirements when accessing resources. Commonly it is used to enforce multifactor authentication, device configuration, or network location requirements.

These policies can be thought of as logical if then statements. 

**If** the assignments (users, resources, and conditions) are true, **then** apply the access controls (grant and/or session) in the policy.
**If** you are an administrator, who wants to access one of the Microsoft admin portals, **then** you must perform multifactor authentication to prove it is really you.

## Policies

These Microsoft managed polices allow administrators to make simple modifications like excluding users or turning them fron report-only mode to on or off. As Administrators get more comfortable with Conditional Access policy they might choose to clone the policy and make completely custom versions.

As threats evolve over time Microsoft may change these policies in the future to take advantage of new features and functionality to improve their function.

### Require multifactor authentication for admins accessing Microsoft Admin Portals

This policy covers 14 admin roles that we consider to be highly privileged, who are accessing the [Microsoft Admin Portals group](concept-conditional-access-cloud-apps.md#microsoft-admin-portals), and requires them to perform multifactor authentication. This policy targets Microsoft Entra ID P1 and P2 tenants where security defaults aren't enabled.

### Require multifactor authentication for per-user MFA enforced users

This policy covers users with [per-user MFA](/azure/active-directory/authentication/howto-mfa-userstates) and requires them to perform multifactor authentication for all cloud apps. This policy targets Microsoft Entra ID P1 and P2 tenants where security defaults aren't enabled and there are less than 500 per-user MFA enabled/enforced users. **Using per-user MFA is no longer a recommended configuration.** 

### Require multifactor authentication and reauthentication for risky sign-ins

This policy covers all users and requires MFA and reauthentication for high-risk sign-ins. This policy targets Microsoft Entra ID P2 tenants where there are enough licenses for each user.

## See how policies are applied

Administrators can look through their sign-in logs to see these policies in action in their organization.

How to sign in logs see blocked or applied
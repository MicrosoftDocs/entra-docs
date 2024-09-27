---
title: Secure your resources with Microsoft-managed Conditional Access policies
description: Microsoft-managed policies take action to require multifactor authentication to reduce the risk of compromise.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 06/10/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: swethar
---
# Microsoft-managed policies

As mentioned in the [Microsoft Digital Defense Report in October 2023](https://www.microsoft.com/security/security-insider/microsoft-digital-defense-report-2023)

> ...threats to digital peace have reduced trust in technology and highlighted the urgent need for improved cyber defenses at all levels...
>
> ...at Microsoft, our more than 10,000 security experts analyze over 65 trillion signals each day... driving some of the most influential insights in
cybersecurity. Together, we can build cyber resilience through innovative action and collective defense.

As part this work we're making Microsoft-managed policies available in Microsoft Entra tenants around the world. These [simplified Conditional Access policies](#what-is-conditional-access) take action to require multifactor authentication, which a [recent study](https://arxiv.org/abs/2305.00945) finds can reduce the risk of compromise by 99.22%.

At launch Microsoft is deploying the following three policies where our data tells us they would increase an organization's security posture:

- Multifactor authentication for admins accessing Microsoft Admin Portals
- Multifactor authentication for per-user multifactor authentication users
- Multifactor authentication and reauthentication for risky sign-ins

:::image type="content" source="media/managed-policies/microsoft-managed-policy.png" alt-text="Screenshot showing an example of a Microsoft-managed policy in the Microsoft Entra admin center." lightbox="media/managed-policies/microsoft-managed-policy-expanded-full.png":::

Administrators with at least the [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role assigned find these policies in the [Microsoft Entra admin center](https://entra.microsoft.com) under **Protection** > **Conditional Access** > **Policies**.

Administrators have the ability to **Edit** the **State** (On, Off, or Report-only) and the **Excluded identities** (Users, Groups, and Roles) in the policy. Organizations should [exclude their break-glass or emergency access accounts](../role-based-access-control/security-emergency-access.md) from these policies the same as they would in other Conditional Access policies. Organizations can duplicate these policies if they want to make more changes than the basic ones allowed in the Microsoft-managed versions.

Microsoft will enable these policies after no less than 90 days after they're introduced in your tenant if they're left in the **Report-only** state. Administrators might choose to turn these policies **On** sooner, or opt out by setting the policy state to **Off**. Customers are notified via emails and [Message center](/microsoft-365/admin/manage/message-center) posts 28 days before the policies are enabled. 
> [!NOTE]
> In some cases, policies may be enabled faster than 90 days. If this is applicable to your tenant, it will be noted in emails and M365 message center posts you receive about Microsoft Managed Policies. It will also be mentioned in the policy's details in the Microsoft Admin Center.

## Policies

These Microsoft-managed policies allow administrators to make simple modifications like excluding users or turning them from report-only mode to on or off. Organizations can't rename or delete any Microsoft-managed policies. As Administrators get more comfortable with Conditional Access policy, they might choose to duplicate the policy to make custom versions.

As threats evolve over time, Microsoft might change these policies in the future to take advantage of new features, functionality, or to improve their function.

### Multifactor authentication for admins accessing Microsoft Admin Portals

This policy covers [14 admin roles](#what-administrator-roles-are-covered-by-these-policies) that we consider to be highly privileged, who are accessing the [Microsoft Admin Portals group](how-to-policy-mfa-admin-portals.md), and requires them to perform multifactor authentication.

This policy targets Microsoft Entra ID P1 and P2 tenants where security defaults aren't enabled.

### Multifactor authentication for per-user multifactor authentication users

This policy covers users [per-user MFA](../authentication/howto-mfa-userstates.md), a configuration that Microsoft no longer recommends. [Conditional Access](concept-conditional-access-policies.md) offers a better admin experience with many extra features. Consolidating all MFA policies in Conditional Access can help you be more targeted in requiring MFA, lowering end user friction while maintaining security posture. 

This policy only targets licensed users with Microsoft Entra ID P1 and P2, where security defaults policy isn't enabled, and there are less than 500 per-user MFA enabled or enforced users. 

To apply this policy to more users, duplicate it and change the assignments.

> [!TIP]
> Using the **Edit** pencil at the top to modify the Microsoft-managed per-user multifactor authentication policy might result in a **failed to update** error. To work around this issue, select **Edit** under the **Excluded identities** section of the policy.

### Multifactor authentication and reauthentication for risky sign-ins

This policy covers all users and requires MFA and reauthentication when we detect high-risk sign-ins. High-risk in this case means something about the way the user signed in is out of the ordinary. These high-risk sign-ins might include: travel that is highly abnormal, password spray attacks, or token replay attacks. For more information about these risk definitions, see the article [What are risk detections](/entra/id-protection/concept-identity-protection-risks#sign-in-risk-detections).

This policy targets Microsoft Entra ID P2 tenants where security defaults aren't enabled. 
-	If P2 licenses equal or exceed total MFA-registered active users, the policy will cover All Users. 
-	If MFA-registered active users exceed P2 licenses, we will create and assign the policy to a capped security group based on available P2 licenses. You can modify membership of the policy’s security group. 

To prevent attackers from taking over accounts, Microsoft doesn't allow risky users to register for MFA.


## Security defaults policies
The following policies are available for when you upgrade from using security defaults.

### Block legacy authentication

This policy blocks legacy authentication protocols from accessing applications. Legacy authentication refers to an authentication request made by:

- Clients that don't use modern authentication (for example, an office 2010 client)
- Any client that uses older mail protocols such as IMAP, SMTP, or POP3
- Any sign in attempt using legacy authentication is blocked. 
 
Most observed compromising sign-in attempts come from legacy authentication. Since legacy authentication doesn't support multifactor authentication, an attacker can bypass your MFA requirements by using an older protocol.

### Require multifactor authentication for Azure management

This policy covers all users when they're trying to access various Azure services managed through the Azure Resource Manager API including:

- Azure portal
- Microsoft Entra admin center
- Azure PowerShell
- Azure CLI

When trying to access any of these resources, the user is required to complete MFA before they can gain access. 

### Require multifactor authentication for admins

This policy covers any user with one of [14 admin roles](#what-administrator-roles-are-covered-by-these-policies) we consider to be highly privileged. Because of the power these highly privileged accounts have, they're required to MFA whenever they sign into any application. 

### Require multifactor authentication for all users

This policy covers all users in your organization and requires them to MFA whenever they sign in. In most cases, the session persists on the device and users don't have to complete MFA when they interact with another application. 

## How do I see the effects of these policies?

Administrators can look at the Policy impact on sign-ins section to see a quick summary of the effect of the policy in their environment.

:::image type="content" source="media/managed-policies/microsoft-managed-policy-impact-on-sign-in.png" alt-text="Screenshot showing the impact of a policy on the organization.":::

Administrators can go deeper and look through the Microsoft Entra sign-in logs to see these policies in action in their organization.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Identity** > **Monitoring & health** > **Sign-in logs**.
1. Find the specific sign-in you want to review. Add or remove filters and columns to filter out unnecessary information.
   1. To narrow the scope, add filters like:
      1. **Correlation ID** when you have a specific event to investigate.
      1. **Conditional Access** to see policy failure and success. Scope your filter to show only failures to limit results.
      1. **Username** to see information related to specific users.
      1. **Date** scoped to the time frame in question.
1. Once the sign-in event that corresponds to the user's sign-in is found, select the **Conditional Access** tab. The Conditional Access tab shows the specific policy or policies that resulted in the sign-in interruption.
   1. To investigate further, drill down into the configuration of the policies by clicking on the **Policy Name**. Clicking the **Policy Name** shows the policy configuration user interface for the selected policy for review and editing.
   1. The **client user** and **device details** that were used for the Conditional Access policy assessment are also available in the **Basic Info**, **Location**, **Device Info**, **Authentication Details**, and **Additional Details** tabs of the sign-in event.

## What is Conditional Access?

Conditional Access is a Microsoft Entra feature that allows organizations to enforce security requirements when accessing resources. Conditional Access is commonly used to enforce multifactor authentication, device configuration, or network location requirements.

These policies can be thought of as logical if then statements.

**If** the assignments (users, resources, and conditions) are true, **then** apply the access controls (grant and/or session) in the policy.
**If** you're an administrator, who wants to access one of the Microsoft admin portals, **then** you must perform multifactor authentication to prove it's really you.

## What if I want to make more changes?

Administrators might choose to make further changes to these policies by duplicating them using the **Duplicate** button in the policy list view. This new policy can be configured in the same way as any other Conditional Access policy with starting from a Microsoft recommended position.

## What administrator roles are covered by these policies?

[!INCLUDE [conditional-access-admin-roles](../../includes/conditional-access-admin-roles.md)]

## What if I use a different solution for multifactor authentication?

Multifactor authentication completed via federation or the recently announced external authentication methods satisfies the requirements of the managed policy.

## Next steps

- [Deploy other commonly used policies from templates](concept-conditional-access-policy-common.md)
- [Configure and use Conditional Access report-only mode](concept-conditional-access-report-only.md)

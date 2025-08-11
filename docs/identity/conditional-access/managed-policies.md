---
title: Microsoft-Managed Conditional Access Policies for Enhanced Security
description: Secure your resources with Microsoft-managed Conditional Access policies. Require multifactor authentication to reduce compromise risks.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: article
ms.date: 04/21/2025
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: swethar
ms.custom: sfi-image-nochange
---
# Microsoft-managed Conditional Access policies

As mentioned in the [Microsoft Digital Defense Report](https://www.microsoft.com/security/security-insider/microsoft-digital-defense-report-2023) from October 2023,

> ...threats to digital peace have reduced trust in technology and highlighted the urgent need for improved cyber defenses at all levels...
>
> ...at Microsoft, our more than 10,000 security experts analyze over 65 trillion signals each day... driving some of the most influential insights in
cybersecurity. Together, we can build cyber resilience through innovative action and collective defense.

As part of this work, we're making Microsoft-managed policies available in Microsoft Entra tenants around the world. These [simplified Conditional Access policies](#what-is-conditional-access) require multifactor authentication, which a [recent study](https://arxiv.org/abs/2305.00945) finds reduces the risk of compromise by more than 99%.

:::image type="content" source="media/managed-policies/microsoft-managed-policy.png" alt-text="Screenshot of a Microsoft-managed Conditional Access policy in the Microsoft Entra admin center." lightbox="media/managed-policies/microsoft-managed-policy-expanded-full.png":::

## How Microsoft-managed policies work

Administrators with at least the [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role assigned find these policies in the [Microsoft Entra admin center](https://entra.microsoft.com) under **Entra ID** > **Conditional Access** > **Policies**.

You can edit the state of a policy and what identities the policy should exclude. Exclude your [break-glass or emergency access accounts](../role-based-access-control/security-emergency-access.md) from managed policies just like other Conditional Access policies. Consider duplicating these policies if you need to make more changes than what's allowed in the Microsoft-managed policies.

Microsoft enables these policies no less than 45 days after they're introduced in your tenant if they're left in the **Report-only** state. You can turn on these policies sooner, or opt out by setting the policy state to **Off**. Customers are notified through emails and [Message center](/microsoft-365/admin/manage/message-center) posts 28 days before the policies are enabled. 

> [!NOTE]
> In some cases, policies might be enabled faster than 45 days. If this change applies to your tenant:
> 
> - It's mentioned in emails and Microsoft 365 message center posts you receive about Microsoft-managed policies. 
> - It's mentioned in the policy details in the Microsoft Entra admin center.

## Policies

These Microsoft-managed policies allow administrators to make simple modifications like excluding users or turning them from report-only mode to on or off. Organizations can't rename or delete any Microsoft-managed policies. As administrators get more comfortable with Conditional Access policy, they might choose to duplicate the policy to create custom versions.

As threats evolve, Microsoft might update these policies to use new features, functionality, or improve their effectiveness

- [Block legacy authentication](#block-legacy-authentication)
- [Block device code flow](#block-device-code-flow)
- [Multifactor authentication for admins accessing Microsoft Admin portals](#multifactor-authentication-for-admins-accessing-microsoft-admin-portals)
- [Multifactor authentication for all users](#multifactor-authentication-for-all-users)
- [Multifactor authentication for per-user multifactor authentication users](#multifactor-authentication-for-per-user-multifactor-authentication-users)
- [Multifactor authentication and reauthentication for risky sign-ins](#multifactor-authentication-and-reauthentication-for-risky-sign-ins)

### Block legacy authentication

This policy blocks sign-in attempts using legacy authentication and legacy authentication protocols. These authentications might come from older clients like Office 2010, or clients that use protocols like IMAP, SMTP, or POP3. 

Based on Microsoft's analysis, more than 99 percent of password spray attacks use these legacy authentication protocols. These attacks would stop with basic authentication disabled or blocked.

### Block device code flow

This policy blocks device code flow, where a user initiates authentication on one device, completes on another, and their token is sent back to the original device. This type of authentication is common where users can't enter their credentials, like smart TVs, Microsoft Teams Room devices, IoT devices, or printers.

Device code flow is rarely used by customers, but is frequently used by attackers. Enabling this Microsoft-managed policy for your organization helps remove this attack vector.

### Multifactor authentication for admins accessing Microsoft Admin portals

This policy covers [14 admin roles](#what-administrator-roles-are-covered-by-these-policies) that are highly privileged, who access the [Microsoft Admin Portals](policy-old-require-mfa-admin-portals.md), and requires them to perform multifactor authentication.

This policy applies to Microsoft Entra ID P1 and P2 tenants where security defaults aren't enabled.

> [!TIP]
> Microsoft-managed policies requiring multifactor authentication differ from the [announcement of mandatory multifactor authentication for Azure sign-ins made in 2024](https://azure.microsoft.com/blog/announcing-mandatory-multi-factor-authentication-for-azure-sign-in/), which started gradual rollout in October of 2024. For more information, see [Planning for mandatory multifactor authentication for Azure and other admin portals](../authentication/concept-mandatory-multifactor-authentication.md).

### Multifactor authentication for all users

This policy covers all users in your organization and requires them to use multifactor authentication whenever they sign in. In most cases, the session persists on the device, and users don't need to complete multifactor authentication when they interact with another application.

### Multifactor authentication for per-user multifactor authentication users

This policy covers users [per-user MFA](../authentication/howto-mfa-userstates.md), a configuration that Microsoft no longer recommends. [Conditional Access](concept-conditional-access-policies.md) offers a better admin experience with many extra features. Consolidating all multifactor authentication policies to Conditional Access can help you be more targeted in requiring multifactor authentication, lowering end user friction while maintaining security posture. 

This policy targets: 

- Organizations with Microsoft Entra ID P1 and P2 licensed users
- Organizations where security defaults aren't enabled
- Organizations with less than 500 per-user MFA enabled or enforced users

To apply this policy to more users, duplicate it and change the assignments.

> [!TIP]
> Using the **Edit** pencil at the top to modify the Microsoft-managed per-user multifactor authentication policy might result in a **failed to update** error. To work around this issue, select **Edit** under the **Excluded identities** section of the policy.

### Multifactor authentication and reauthentication for risky sign-ins

This policy covers all users and requires multifactor authentication and reauthentication when we detect high-risk sign-ins. High-risk in this case means something about the way the user signed in is out of the ordinary. These high-risk sign-ins might include travel that is highly abnormal, password spray attacks, or token replay attacks. For more information, see [What are risk detections](/entra/id-protection/concept-identity-protection-risks#sign-in-risk-detections).

This policy targets Microsoft Entra ID P2 tenants where security defaults aren't enabled. The policy covers users in two different ways, depending on if you have more P2 licenses than users or if you have more users than P2 licenses. Guest users aren't included in the policy.

- If all your active users have MFA and your P2 licenses equal or exceed the total active users, the policy covers *All Users*.
    - *All Users* could include service accounts or break-glass accounts, so you might want to exclude them.
- If some active users don't have MFA, or if there aren't enough P2 licenses to cover all MFA-registered users, we create and assign the policy to a security group called "Conditional Access: Risky sign-in multifactor authentication" that is capped to your available P2 licenses.
    - The policy applies only to that security group, so you can scope the policy by modifying the group itself.
    - To populate the group, we select users who can satisfy MFA, prioritizing users with a directly assigned P2 license.
    - This setup ensures that the policy doesn't block legitimate users and that you’re getting maximum value on your P2 licenses.

To prevent attackers from taking over accounts, Microsoft blocks risky users from registering for multifactor authentication.

## Security defaults policies

The following policies are available for when you upgrade from using security defaults.

- [Block legacy authentication](#block-legacy-authentication)
- [Require multifactor authentication for Azure management](#require-multifactor-authentication-for-azure-management)
- [Require multifactor authentication for admins](#require-multifactor-authentication-for-admins)
- [Require multifactor authentication for all users](#require-multifactor-authentication-for-all-users)

### Block legacy authentication

This policy blocks legacy authentication protocols from accessing applications. Legacy authentication refers to an authentication request made by:

- Clients that don't use modern authentication (for example, an Office 2010 client)
- Any client that uses older mail protocols such as IMAP, SMTP, or POP3
- Any sign-in attempts to use legacy authentication. 
 
Most observed compromising sign-in attempts come from legacy authentication. Because legacy authentication doesn't support multifactor authentication, attackers can bypass multifactor authentication requirements by using older protocols.

### Require multifactor authentication for Azure management

This policy covers all users when they're trying to access various Azure services managed through the Windows Azure Service Management API including:

- Azure portal
- Microsoft Entra admin center
- Azure PowerShell
- Azure CLI

Users must complete multifactor authentication to access these resources. 

### Require multifactor authentication for admins

This policy applies to users with highly privileged admin roles:

[!INCLUDE [conditional-access-admin-roles](../../includes/conditional-access-admin-roles.md)]

These accounts must use multifactor authentication to sign in to any application. 

### Require multifactor authentication for all users

This policy applies to all users in your organization and requires multifactor authentication for every sign-in. In most cases, sessions persist on devices, so users don't need to complete multifactor authentication when interacting with other applications. 

## Monitor and review

The managed policy and the sign-in logs are the two places where you can see the effect of these policies on your organization.

Review the **Policy impact** tab of the managed policy to see a summary of how the policy affects your environment.

:::image type="content" source="media/managed-policies/microsoft-managed-policy-impact-on-sign-in.png" alt-text="Screenshot showing the effect of a policy on the organization.":::

Analyze the **Microsoft Entra sign-in logs** to see details about how the policies affect sign-in activity.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Use some or all of the following filters:
   - **Correlation ID** when you have a specific event to investigate.
   - **Conditional Access** to see policy failure and success.
   - **Username** to see information related to specific users.
   - **Date** scoped to the time frame in question.
1. Select a specific sign-in event, then select **Conditional Access**.
   - To investigate further, select the **Policy Name** to drill down into the configuration of the policies.
1. Explore the other tabs to see the **client user** and **device details** that were used for the Conditional Access policy assessment.

## Common questions

### What is Conditional Access?

Conditional Access is a Microsoft Entra feature that allows organizations to enforce security requirements when accessing resources. Conditional Access is commonly used to enforce multifactor authentication, device configuration, or network location requirements.

These policies can be thought of as logical if then statements.

**If** the assignments (users, resources, and conditions) are true, **then** apply the access controls (grant and/or session) in the policy.
**If** you're an administrator, who wants to access one of the Microsoft admin portals, **then** you must perform multifactor authentication to prove it's really you.

### What if I want to make more changes?

Administrators might choose to make further changes to these policies by duplicating them using the **Duplicate** button in the policy list view. This new policy can be configured in the same way as any other Conditional Access policy with starting from a Microsoft recommended position. Be careful not to lower your security posture with those changes.

### What administrator roles are covered by these policies?

[!INCLUDE [conditional-access-admin-roles](../../includes/conditional-access-admin-roles.md)]

### What if I use a different solution for multifactor authentication?

Multifactor authentication using [external authentication methods](/entra/identity/authentication/how-to-authentication-external-method-manage) satisfies the MFA requirements of Microsoft-managed policies.

When multifactor authentication is completed via a federated identity provider (IdP), it might satisfy Microsoft Entra ID MFA requirements depending on your configuration. For more information, see [Satisfy Microsoft Entra ID multifactor authentication (MFA) controls with MFA claims from a federated IdP](/entra/identity/authentication/how-to-mfa-expected-inbound-assertions).

### What if I use Certificate-Based Authentication?

Depending on your Certificate-Based Authentication (CBA) configuration, it can function as [single or multifactor authentication](/entra/identity/authentication/concept-certificate-based-authentication-technical-deep-dive#options-to-get-mfa-capability-with-single-factor-certificates).

* If your organization configures CBA as single-factor, users must use a second authentication method to satisfy MFA. For more information on the allowed combinations of authentication methods to MFA with single-factor CBA, see [MFA with single factor certificate-based authentication](/entra/identity/authentication/concept-certificate-based-authentication-technical-deep-dive#mfa-with-single-factor-certificate-based-authentication).
* If your organization configures CBA as multifactor, users can complete MFA with their CBA authentication method.

### What if I use custom controls?

[Custom controls don't satisfy multifactor authentication claim requirements](controls.md#creating-custom-controls). If your organization uses custom controls you should [migrate to external authentication methods](/entra/identity/authentication/how-to-authentication-external-method-manage), the replacement of custom controls. Your external authentication provider must support external authentication methods and provide the necessary configuration guidance for integration.

### How do I monitor when Microsoft makes a change to these policies or adds a new one?

Administrators with **AuditLog.Read.All** and **Directory.Read** permissions can query the audit log for entries initiated by **Microsoft Managed Policy Manager** in the **Policy** category. For example, use [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to find entries with this query string: `https://graph.microsoft.com/v1.0/auditLogs/directoryAudits?$filter=initiatedBy/app/displayName eq 'Microsoft Managed Policy Manager' and category eq 'Policy'`.

## Related content

- [Deploy other commonly used policies from templates](concept-conditional-access-policy-common.md)
- [Configure and use Conditional Access report-only mode](concept-conditional-access-report-only.md)

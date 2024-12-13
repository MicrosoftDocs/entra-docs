---
title: Configure the MFA registration policy
description: Learn how to configure the Microsoft Entra ID Protection multifactor authentication registration policy.

ms.service: entra-id-protection

ms.topic: how-to
ms.date: 05/06/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: etbasser
---
# How To: Configure the multifactor authentication registration policy

Microsoft helps you manage the deployment of multifactor authentication (MFA) by configuring the Microsoft Entra ID Protection policy to require MFA registration no matter what modern authentication app you're signing in to. Multifactor authentication provides a means to verify who you are using more than just a username and password. It provides a second layer of security to user sign-ins. In order for users to be able to respond to MFA prompts, they must first register authentication methods, like the Microsoft Authenticator app.

We recommend that you require multifactor authentication for all user sign-ins. [Based on our studies](https://www.microsoft.com/security/security-insider/microsoft-digital-defense-report-2023), your account is more than 99% less likely to be compromised if you use MFA. Even if you don't require MFA all the time this policy ensures your users are ready when the time comes to do MFA.

For more information, see the article [Common Conditional Access policy: Require MFA for all users](../identity/conditional-access/policy-all-users-mfa-strength.md).

## Policy configuration

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Protection** > **Identity Protection** > **Multifactor authentication registration policy**.
   1. Under **Assignments** > **Users**.
      1. Under **Include**, select **All users** or **Select individuals and groups** if limiting your rollout.
      1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Set **Policy enforcement** to **Enabled**.
1. Select **Save**.

## User experience

Microsoft Entra ID Protection will prompt your users to register the next time they sign in interactively and they'll have 14 days to complete registration. During this 14-day period, they can bypass registration if MFA isn't required as a condition, but at the end of the period they're required to register before they can complete the sign-in process.

For an overview of the related user experience, see:

- [Sign-in experiences with Microsoft Entra ID Protection](concept-identity-protection-user-experience.md).  

## Related content

- [Enable sign-in and user risk policies](howto-identity-protection-configure-risk-policies.md)
- [Enable Microsoft Entra self-service password reset](~/identity/authentication/howto-sspr-deployment.md)
- [Enable Microsoft Entra multifactor authentication](~/identity/authentication/howto-mfa-getstarted.md)

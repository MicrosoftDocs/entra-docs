---
title: Conditional Access - Authentication strength for external users
description: Create a custom Conditional Access policy with authentication strength to require specific multifactor authentication (MFA) methods for external users.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 09/27/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: inbarc
---
# Require multifactor authentication for external users

Authentication strength is a Conditional Access control that lets you define a specific combination of multifactor authentication (MFA) methods that an external user must complete to access your resources. This control is especially useful for restricting external access to sensitive apps in your organization. For example, you can create a Conditional Access policy, require a phishing-resistant authentication strength in the policy, and assign it to guests and external users.

Microsoft Entra ID provides three [built-in authentication strengths](/entra/identity/authentication/concept-authentication-strengths):

- **Multifactor authentication strength** (less restrictive) recommended in this article
- Passwordless MFA strength
- Phishing-resistant MFA strength (most restrictive)

You can use one of the built-in strengths or create a [custom authentication strength](/entra/identity/authentication/concept-authentication-strength-advanced-options) based on the authentication methods you want to require.

In external user scenarios, the MFA authentication methods that a resource tenant can accept vary depending on whether the user is completing MFA in their home tenant or in the resource tenant. For details, see [Authentication strength for external users](/entra/identity/authentication/concept-authentication-strength-external-users).

> [!NOTE]
> Currently, you can only apply authentication strength policies to external users who authenticate with Microsoft Entra ID. For email one-time passcode, SAML/WS-Fed, and Google federation users, use the [MFA grant control](concept-conditional-access-grant.md#require-multifactor-authentication) to require MFA.

## Configure cross-tenant access settings to trust MFA

Authentication strength policies work together with [MFA trust settings](~/external-id/cross-tenant-access-settings-b2b-collaboration.yml#to-change-inbound-trust-settings-for-mfa-and-device-claims) in your cross-tenant access settings to determine where and how the external user must perform MFA. A Microsoft Entra user first authenticates with their own account in their home tenant. Then when this user tries to access your resource, Microsoft Entra ID applies the authentication strength Conditional Access policy and checks to see if you enabled MFA trust.

- **If MFA trust is enabled**, Microsoft Entra ID checks the user's authentication session for a claim indicating that MFA was fulfilled in the user's home tenant.
- **If MFA trust is disabled**, the resource tenant presents the user with a challenge to complete MFA in the resource tenant using an acceptable authentication method.

The authentication methods that external users can use to satisfy MFA requirements are different depending on whether the user is completing MFA in their home tenant or the resource tenant. See the table in [Conditional Access authentication strength](https://aka.ms/b2b-auth-strengths).

> [!IMPORTANT]
> Before you create the Conditional Access policy, check your cross-tenant access settings to make sure your inbound MFA trust settings are configured as intended.

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

## Create a Conditional Access policy

Use the following steps to create a Conditional Access policy that applies an authentication strength to external users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, choose **Select users and groups**, and then select **Guest or external users**.
      1. Select the types of [guest or external users](~/external-id/authentication-conditional-access.md#assigning-conditional-access-policies-to-external-user-types) you want to apply the policy to.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Cloud apps**, under **Include** or **Exclude**, select any applications you want to include in or exclude from the authentication strength requirements.
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select the appropriate built-in or custom authentication strength from the list.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After you confirm your settings using [report-only mode](howto-conditional-access-insights-reporting.md), an administrator can move the **Enable policy** toggle from **Report-only** to **On**.

## Related content

- [Conditional Access templates](concept-conditional-access-policy-common.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

---
title: Require phishing-resistant multifactor authentication for Microsoft Entra administrator roles
description: Create a Conditional Access policy requiring stronger authentication methods for highly privileged roles in your organization.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 09/02/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth
---
# Require phishing-resistant multifactor authentication for administrators

Accounts with privileged administrative roles are frequent targets of attackers. Requiring phishing-resistant multifactor authentication (MFA) for these accounts reduces the risk of compromise.

> [!CAUTION]
> Before creating a policy requiring phishing-resistant multifactor authentication, make sure your administrators register the appropriate methods. Enabling this policy without completing this step risks locking you out of your tenant. Administrators can [configure Temporary Access Pass to register passwordless authentication methods](../authentication/howto-authentication-temporary-access-pass.md) or follow the steps in [register a passkey (FIDO2)](../authentication/how-to-register-passkey-with-security-key.md).

Microsoft recommends requiring phishing-resistant multifactor authentication for at least the following roles:

[!INCLUDE [conditional-access-admin-roles](../../includes/conditional-access-admin-roles.md)]

Organizations can include or exclude roles based on their requirements.

Organizations can use this policy with features like Privileged Identity Management (PIM), which lets you [require MFA for role activation](/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings#on-activation-require-multifactor-authentication).

## Authentication strength

This article helps your organization create an MFA policy for your environment using authentication strengths. Microsoft Entra ID offers three [built-in authentication strengths](/entra/identity/authentication/concept-authentication-strengths):

- Multifactor authentication strength (less restrictive)
- Passwordless MFA strength
- **Phishing-resistant MFA strength** (most restrictive), recommended in this article

Use one of the built-in strengths or create a [custom authentication strength](/entra/identity/authentication/concept-authentication-strength-advanced-options) based on the authentication methods you want to require.

For external user scenarios, the MFA authentication methods that a resource tenant accepts vary depending on whether the user completes MFA in their home tenant or in the resource tenant. For more information, see [Authentication strength for external users](/entra/identity/authentication/concept-authentication-strength-external-users).

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

> [!WARNING]
> If you use [external authentication methods](/entra/identity/authentication/how-to-authentication-external-method-manage), these methods are currently incompatible with authentication strengthd. Use the **[Require multifactor authentication](concept-conditional-access-grant.md#require-multifactor-authentication)** grant control instead.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Name your policy. Create a meaningful naming standard for your organization's policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **Directory roles** and choose at least the previously listed roles.
   
      > [!WARNING]
      > Conditional Access policies support built-in roles. Conditional Access policies aren't enforced for other role types including [administrative unit-scoped](../role-based-access-control/manage-roles-portal.md) or [custom roles](../role-based-access-control/custom-create.md).

   1. Under **Exclude**, select **Users and groups**, and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select **Phishing-resistant MFA strength** from the list.
   1. Select **Select**.
1. Confirm your settings, and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related content

- [Microsoft Entra built-in roles](../role-based-access-control/permissions-reference.md)
- [Conditional Access templates](concept-conditional-access-policy-common.md)
- Learn how to [configure Microsoft Entra role settings in Privileged Identity Management](../../id-governance/privileged-identity-management/pim-how-to-change-default-settings.md).

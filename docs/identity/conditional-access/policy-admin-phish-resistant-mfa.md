---
title: Require phishing-resistant multifactor authentication for Microsoft Entra administrator roles
description: Create a Conditional Access policy requiring stronger authentication methods for highly privileged roles in your organization.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 09/30/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: lhuangnorth
---
# Require phishing-resistant multifactor authentication for administrators

Accounts that are assigned privileged administrative roles are frequent targets of attackers. Requiring phishing-resistant multifactor authentication (MFA) on those accounts is an easy way to reduce the risk of those accounts being compromised.

> [!CAUTION]
> Before creating a policy requiring phishing-resistant multifactor authentication, ensure your administrators have the appropriate methods registered. If you enable this policy without completing this step you risk locking yourself out of your tenant. Administrators can [Configure Temporary Access Pass to register passwordless authentication methods](../authentication/howto-authentication-temporary-access-pass.md) or follow the steps in [Register a passkey (FIDO2)](../authentication/how-to-register-passkey-with-security-key.md).

Microsoft recommends you require phishing-resistant multifactor authentication on the following roles at a minimum:

[!INCLUDE [conditional-access-admin-roles](../../includes/conditional-access-admin-roles.md)]

Organizations might choose to include or exclude roles based on their own requirements.

Organizations can use this policy in conjunction with features like Privileged Identity Management (PIM) and its ability to [require MFA for role activation](/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings#on-activation-require-multifactor-authentication).

## Authentication strength

The guidance in this article helps your organization create an MFA policy for your environment using authentication strengths. Microsoft Entra ID provides three [built-in authentication strengths](/entra/identity/authentication/concept-authentication-strengths):

- Multifactor authentication strength (less restrictive)
- Passwordless MFA strength
- **Phishing-resistant MFA strength** (most restrictive) recommended in this article

You can use one of the built-in strengths or create a [custom authentication strength](/entra/identity/authentication/concept-authentication-strength-advanced-options) based on the authentication methods you want to require.

For external user scenarios, the MFA authentication methods that a resource tenant can accept vary depending on whether the user is completing MFA in their home tenant or in the resource tenant. For more information, see [Authentication strength for external users](/entra/identity/authentication/concept-authentication-strength-external-users).

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

> [!WARNING]
> If you use [external authentication methods](/entra/identity/authentication/how-to-authentication-external-method-manage), these are currently incompatible with authentication strength and you should use the **[Require multifactor authentication](concept-conditional-access-grant.md#require-multifactor-authentication)** grant control.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **Directory roles** and choose at least the previously listed roles.
   
      > [!WARNING]
      > Conditional Access policies support built-in roles. Conditional Access policies are not enforced for other role types including [administrative unit-scoped](../role-based-access-control/manage-roles-portal.md) or [custom roles](../role-based-access-control/custom-create.md).

   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select **Phishing-resistant MFA strength** from the list.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related content

- [Microsoft Entra built-in roles](../role-based-access-control/permissions-reference.md)
- [Conditional Access templates](concept-conditional-access-policy-common.md)
- [Configure Microsoft Entra role settings in Privileged Identity Management](../../id-governance/privileged-identity-management/pim-how-to-change-default-settings.md)

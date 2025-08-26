---
title: Require MFA for all users with Conditional Access
description: Create a custom Conditional Access policy to require all users do multifactor authentication.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth
---
# Require multifactor authentication for all users

As Alex Weinert, the Director of Identity Security at Microsoft, mentions in his blog post [Your Pa$$word doesn't matter](https://techcommunity.microsoft.com/t5/Azure-Active-Directory-Identity/Your-Pa-word-doesn-t-matter/ba-p/731984):

> Your password doesn't matter, but MFA does! Based on our studies, your account is more than 99.9% less likely to be compromised if you use MFA.

## Authentication strength

The guidance in this article helps your organization create an MFA policy for your environment using authentication strengths. Microsoft Entra ID provides three [built-in authentication strengths](/entra/identity/authentication/concept-authentication-strengths):

- **Multifactor authentication strength** (less restrictive) recommended in this article
- Passwordless MFA strength
- Phishing-resistant MFA strength (most restrictive)

You can use one of the built-in strengths or create a [custom authentication strength](/entra/identity/authentication/concept-authentication-strength-advanced-options) based on the authentication methods you want to require.

For external user scenarios, the MFA authentication methods that a resource tenant can accept vary depending on whether the user is completing MFA in their home tenant or in the resource tenant. For more information, see [Authentication strength for external users](/entra/identity/authentication/concept-authentication-strength-external-users).

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

The following steps help create a Conditional Access policy to require all users do multifactor authentication, using the authentication strength policy, [without any app exclusions](concept-conditional-access-cloud-apps.md#conditional-access-behavior-when-an-all-resources-policy-has-an-app-exclusion).

> [!WARNING]
> [External authentication methods](/entra/identity/authentication/how-to-authentication-external-method-manage) are currently incompatible with authentication strength. You should use the **[Require multifactor authentication](concept-conditional-access-grant.md#require-multifactor-authentication)** grant control.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**
   1. Under **Exclude**: 
      1. Select **Users and groups** 
         1. Choose your organization's emergency access or break-glass accounts.
         1. If you use hybrid identity solutions like Microsoft Entra Connect or Microsoft Entra Connect Cloud Sync, select **Directory roles**, then select **Directory Synchronization Accounts**
      1. You might choose to exclude your guest users if you're targeting them with a [guest user specific policy](policy-guests-mfa-strength.md). 
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.

   > [!TIP]
   > Microsoft recommends all organizations create a baseline Conditional Access policy that targets: All users, all resources without any app exclusions, and requires multifactor authentication.

1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select the built-in **Multifactor authentication strength** from the list.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

### Named locations

Organizations might choose to incorporate known network locations known as **Named locations** in their Conditional Access policies. These named locations might include trusted IP networks like those for a main office location. For more information about configuring named locations, see the article [What is the location condition in Microsoft Entra Conditional Access?](concept-assignment-network.md#ipv4-and-ipv6-address-ranges)

In the previous example policy, an organization might choose to not require multifactor authentication if accessing a cloud app from their corporate network. In this case they could add the following configuration to the policy:

1. Under **Assignments**, select **Network**.
   1. Configure **Yes**.
   1. Include **Any network or location**.
   1. Exclude **All trusted networks and locations**.
1. **Save** your policy changes.

## Related content

- [Conditional Access templates](concept-conditional-access-policy-common.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)
- [Windows subscription activation](/windows/deployment/windows-subscription-activation#adding-conditional-access-policy)

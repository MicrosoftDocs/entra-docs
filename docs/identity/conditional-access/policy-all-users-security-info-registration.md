---
title: Control security information registration with Conditional Access
description: Create a custom Conditional Access policy for security info registration.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth
---
# Protect security info registration with Conditional Access policy

Securing when and how users register for Microsoft Entra multifactor authentication and self-service password reset is possible with user actions in a Conditional Access policy. This feature is available to organizations who enable [combined registration](~/identity/authentication/concept-registration-mfa-sspr-combined.md). This functionality allows organizations to treat the registration process like any application in a Conditional Access policy and use the full power of Conditional Access to secure the experience. Users signing in to the Microsoft Authenticator app or enabling passwordless phone sign-in are subject to this policy.

Some organizations in the past might have used trusted network location or device compliance as a means to secure the registration experience. With the addition of [Temporary Access Pass](~/identity/authentication/howto-authentication-temporary-access-pass.md) in Microsoft Entra ID, administrators can provide time-limited credentials to their users that allow them to register from any device or location. Temporary Access Pass credentials satisfy Conditional Access requirements for multifactor authentication.

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a policy to secure registration

The following policy applies to the selected users, who attempt to register using the combined registration experience. The policy requires users who are not on a trusted network to do multifactor authentication. Users from trusted networks are excluded from this policy.

> [!WARNING]
> If you use [external authentication methods](/entra/identity/authentication/how-to-authentication-external-method-manage), these are currently incompatible with authentication strength and you should use the **[Require multifactor authentication](concept-conditional-access-grant.md#require-multifactor-authentication)** grant control.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. In Name, Enter a Name for this policy. For example, **Combined Security Info Registration with TAP**.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.

      > [!WARNING]
      > Users must be enabled for the [combined registration](~/identity/authentication/howto-registration-mfa-sspr-combined.md).

   1. Under **Exclude**.
      1. Select **All guest and external users**.
      
         > [!NOTE]
         > Temporary Access Pass does not work for guest users.

      1. Select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **User actions**, check **Register security information**.
1. Under **Conditions** > **Locations**. 
   1. Set **Configure** to **Yes**. 
      1. Include **Any location**.
      1. Exclude **All trusted locations**.
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select the appropriate built-in or custom authentication strength from the list.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

Administrators have to issue Temporary Access Pass credentials to new users so they can satisfy the requirements for multifactor authentication to register. Steps to accomplish this task, are found in the section [Create a Temporary Access Pass in the Microsoft Entra admin center](~/identity/authentication/howto-authentication-temporary-access-pass.md#create-a-temporary-access-pass).

Organizations might choose to require other grant controls with or in place of **Require multifactor authentication** at step 8a. When selecting multiple controls, be sure to select the appropriate radio button toggle to require **all** or **one** of the selected controls when making this change.

### Guest user registration

For [guest users](~/external-id/what-is-b2b.md) who need to register for multifactor authentication in your directory you might choose to block registration from outside of [trusted network locations](concept-conditional-access-conditions.md#locations) using the following guide.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. In Name, Enter a Name for this policy. For example, **Combined Security Info Registration on Trusted Networks**.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All guest and external users**.
1. Under **Target resources** > **User actions**, check **Register security information**.
1. Under **Conditions** > **Locations**.
   1. Configure **Yes**.
   1. Include **Any location**.
   1. Exclude **All trusted locations**.
1. Under **Access controls** > **Grant**.
   1. Select **Block access**.
   1. Then choose **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related content

- [Microsoft Entra built-in roles](../role-based-access-control/permissions-reference.md)
- [Conditional Access templates](concept-conditional-access-policy-common.md)
- [Require users to reconfirm authentication information](~/identity/authentication/concept-sspr-howitworks.md#reconfirm-authentication-information)

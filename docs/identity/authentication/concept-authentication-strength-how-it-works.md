---
title: How Authentication Strengths Work in a Conditional Access Policy
description: Learn how admins can use a Conditional Access policy to require specific authentication combinations to access a resource.
ms.topic: concept-article
ms.date: 03/17/2025
ms.reviewer: inbarc
ms.custom: sfi-image-nochange
---

# How Conditional Access authentication strengths work

This article explains how authentication strengths in Microsoft Entra Conditional Access can restrict which authentication method combinations can be used to sign in and access a resource.

## How authentication strengths work with the policies for authentication methods

Two policies determine which authentication methods can be used to access resources. A user who's enabled for an authentication method in either policy can sign in by using that method.

- **Security** > **Authentication methods** > **Policies** is a more modern way to manage authentication methods for specific users and groups. You can specify users and groups for methods. You can also configure parameters to control how a method can be used.

  :::image type="content" border="true" source="./media/concept-authentication-strengths/authentication-methods-policy.png" alt-text="Screenshot of the Policies page for authentication methods.":::

- **Security** > **Multifactor authentication** > **Additional cloud-based multifactor authentication settings** is a legacy way to control multifactor authentication (MFA) methods for all of the users in a tenant.

  :::image type="content" border="true" source="./media/concept-authentication-strengths/service-settings.png" alt-text="Screenshot of service settings for multifactor authentication.":::

Users can register for authentication methods that they're enabled for. An administrator can also configure a user's device by using a method like certificate-based authentication.

## How an authentication strength policy is evaluated during sign-in

A Conditional Access authentication strength policy defines which authentication methods a user can use. Microsoft Entra ID checks the policy during sign-in to determine the user's access to the resource.

For example, an administrator configures a Conditional Access policy with a custom authentication strength that requires a passkey (FIDO2 security key) or a combination of password and text message. The user accesses a resource that this policy helps protect.

During sign-in, Microsoft Entra ID checks all settings to determine which methods are allowed, which methods are registered, and which methods the Conditional Access policy requires. For a successful sign-in, the method must be allowed, be registered by the user (either before or as part of the access request), and satisfy the authentication strength.

## How multiple authentication strength policies are evaluated

In general, when multiple Conditional Access policies apply for a sign-in, the user must meet all conditions from all policies. In the same vein, when multiple Conditional Access authentication strength policies apply to the sign-in, the user must satisfy all of the authentication strength conditions.

For example, if two authentication strength policies both require a passkey (FIDO2), the user can use a FIDO2 security key to satisfy both policies. If the two authentication strength policies have different sets of methods, the user must use multiple methods to satisfy both policies.

### How multiple authentication strength policies are evaluated for registering security info

For [Interrupt mode](/entra/identity/authentication/concept-registration-mfa-sspr-combined#interrupt-mode) in security info registration, the evaluation of authentication is treated differently. Authentication strengths that target the user action of **Registering security info** are preferred over other authentication strength policies that target **All resources** (formerly **All cloud apps**). All other grant controls (such as **Require device to be marked as compliant**) from other Conditional Access policies that are in scope for the sign-in apply as usual.

For example, assume that an organization wants to require its users to always sign in with an MFA method and from a compliant device. The organization also wants to allow new employees to register these MFA methods by using a Temporary Access Pass (TAP). Users can't use a TAP on any other resource. To achieve this goal, the admin can take the following steps:

1. Create a custom authentication strength named **Bootstrap and recovery** that includes the TAP authentication combination. It can also include any of the MFA methods.
1. Create a custom authentication strength named **MFA for sign-in** that includes all allowed MFA methods, without a TAP.
1. Create a Conditional Access policy that targets **All resources** (formerly **All cloud apps**) and requires both **MFA for sign-in** authentication strength and **Require compliant device** grant controls.
1. Create a Conditional Access policy that targets the **Register security information** user action and requires the **Bootstrap and recovery** authentication strength.

As a result, users on a compliant device can use a TAP to register any MFA method. They can then use the newly registered method to authenticate to other resources like Outlook.

> [!NOTE]
>
>- If multiple Conditional Access policies target the **Register security information** user action, and they each apply an authentication strength, the user must satisfy all such authentication strengths to sign in.
>
>- Some passwordless and phishing-resistant methods can't be registered from Interrupt mode. For more information, see [Registration of passwordless authentication methods](#registration-of-passwordless-authentication-methods) later in this article.

## User experience

The following factors determine if the user gains access to the resource:

- Which authentication method did the user previously use?
- Which methods are available for the authentication strength?
- Which methods are allowed for user sign-in in the policy for authentication methods?
- Is the user registered for any available method?

When a user accesses a resource protected by a Conditional Access authentication strength policy, Microsoft Entra ID evaluates if the methods that the user previously used satisfy the authentication strength. If the user used a satisfactory method, Microsoft Entra ID grants access to the resource.

For example, assume that a user signs in by using a combination of password and text message. The user accesses a resource protected by an MFA authentication strength. In this case, the user can access the resource without another authentication prompt.

Suppose that the same user next accesses a resource protected by a phishing-resistant MFA authentication strength. At this point, the user is prompted to provide a phishing-resistant authentication method, such as Windows Hello for Business.

If the user didn't register for any methods that satisfy the authentication strength, they're redirected to [combined registration](concept-registration-mfa-sspr-combined.md#interrupt-mode).

Users are required to register only one authentication method that satisfies the authentication strength requirement. If the authentication strength doesn't include a method that the user can register and use, Microsoft Entra ID blocks the user from signing in to the resource.

### Registration of passwordless authentication methods

The following authentication methods can't be registered as part of Interrupt mode in combined registration. Make sure users are registered for these methods before you apply a Conditional Access policy that can require them to be used for sign-in. A user who isn't registered for these methods can't access the resource until the required method is registered.

| Method | Registration requirements |
|--------|---------------------------|
|[Microsoft Authenticator (phone sign-in)](https://support.microsoft.com/account-billing/add-your-work-or-school-account-to-the-microsoft-authenticator-app-43a73ab5-b4e8-446d-9e54-2a4cb8e4e93c) | Can be registered from the Authenticator app.|
|[Passkey (FIDO2)](howto-authentication-passwordless-security-key.md) | Can be registered via [Managed mode in combined registration](/entra/identity/authentication/concept-registration-mfa-sspr-combined#manage-mode) and enforced by an authentication strength via [Interrupt mode in combined registration](/entra/identity/authentication/concept-registration-mfa-sspr-combined#interrupt-mode). |
|[Certificate-based authentication](concept-certificate-based-authentication.md) | Requires administrator setup. The user can't register it. |
|[Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-prepare-people-to-use) | Can be registered in the Windows Out of Box Experience (OOBE) or the Windows **Settings** menu.|

### Federated user experience

For federated domains, an admin can enforce MFA by using Microsoft Entra Conditional Access or by setting `federatedIdpMfaBehavior` for the on-premises federation provider. If `federatedIdpMfaBehavior` is set to `enforceMfaByFederatedIdp`, the user must authenticate on the federated identity provider and can satisfy only the *federated multifactor* combination of the authentication strength requirement. For more information about the federation settings, see [Migrate from federation to cloud authentication](../hybrid/connect/migrate-from-federation-to-cloud-authentication.md).

If a user from a federated domain has MFA settings in scope for staged rollout, the user can complete multifactor authentication in the cloud and satisfy any of the *federated single-factor plus something the user has* combinations. For more information about staged rollout, see [Enable staged rollout](how-to-mfa-server-migration-utility.md#enable-staged-rollout).

## Related content

- [Built-in authentication strengths](concept-authentication-strengths.md)
- [Custom authentication strengths](concept-authentication-strength-advanced-options.md)
- [How authentication strengths work for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md)

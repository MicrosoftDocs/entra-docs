---
title: Overview of how Microsoft Entra authentication strength works in a Conditional Access policy
description: Learn how admins can use a Conditional Access Policy to require specific authentication combinations to access a resource.


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 05/13/2024

ms.author: justinha
author: inbarckms
manager: amycolannino
ms.reviewer: inbarc
---
#  How Conditional Access authentication strength works 

This topic explains how Conditional Access authentication strength can restrict which authentication methods are allowed to access a resource.
<!-- ### Place holder:How to create Conditional Access policy that uses authentication strength
-	Add a note that you can use either require mfa or require auth strengths
- (JF) Possibly add a reference doc that lists all the definitions of the things you can configure?
-->

## How authentication strength works with the Authentication methods policy
There are two policies that determine which authentication methods can be used to access resources. If a user is enabled for an authentication method in either policy, they can sign in with that method. 

- **Security** > **Authentication methods** > **Policies** is a more modern way to manage authentication methods for specific users and groups. You can specify users and groups for different methods. You can also configure parameters to control how a method can be used.  

  :::image type="content" border="true" source="./media/concept-authentication-strengths/authentication-methods-policy.png" alt-text="Screenshot of Authentication methods policy.":::

- **Security** > **Multifactor authentication** > **Additional cloud-based multifactor authentication settings** is a legacy way to control multifactor authentication methods for all of the users in the tenant. 

  :::image type="content" border="true" source="./media/concept-authentication-strengths/service-settings.png" alt-text="Screenshot of MFA service settings.":::

Users may register for authentication methods they're enabled for. An administrator can also configure a user's device with a method, such as certificate-based authentication.

## How an authentication strength policy is evaluated during sign-in 

The authentication strength Conditional Access policy defines which methods can be used. Microsoft Entra ID checks the policy during sign-in to determine the user’s access to the resource. For example, an administrator configures a Conditional Access policy with a custom authentication strength that requires a passkey (FIDO2 security key) or Password + text message. The user accesses a resource protected by this policy. 

During sign-in, all settings are checked to determine which methods are allowed, which methods are registered, and which methods are required by the Conditional Access policy. To sign in, the method must be allowed, registered by the user (either before or as part of the access request), and satisfy the authentication strength. 

## How multiple Conditional Access authentication strength policies are evaluated 

In general, when multiple Conditional Access policies apply for a sign-in, all conditions from all policies must be met. In the same vein, when multiple Conditional Access authentication strength policies apply to the sign-in, the user must satisfy all of the authentication strength conditions. For example, if two different authentication strength policies both require passkey (FIDO2), the user can use a FIDO2 security key to satisfy both policies. If the two authentication strength policies have different sets of methods, the user must use multiple methods to satisfy both policies. 

### How multiple Conditional Access authentication strength policies are evaluated for registering security info 

For security info registration [Interrupt mode](/entra/identity/authentication/concept-registration-mfa-sspr-combined#interrupt-mode), the authentication strength evaluation is treated differently – authentication strengths that target the user action of **Registering security info** are preferred over other authentication strength policies that target **All resources (formerly 'All cloud apps')**. All other grant controls (such as **Require device to be marked as compliant**) from other Conditional Access policies in scope for the sign-in will apply as usual.  

For example, let’s assume Contoso would like to require their users to always sign in with a multifactor authentication method and from a compliant device. Contoso also wants to allow new employees to register these MFA methods using a Temporary Access Pass (TAP). TAP can’t be used on any other resource. To achieve this goal, the admin can take the following steps: 

1. Create a custom authentication strength named **Bootstrap and recovery** that includes the Temporary Access Pass authentication combination, it can also include any of the MFA methods.  
1. Create a custom authentication strength named **MFA for sign-in** that includes all allowed MFA methods, without Temporary Access Pass.
1. Create a Conditional Access policy that targets **All resources (formerly 'All cloud apps')** and requires **MFA for sign-in** authentication strength AND **Require compliant device** grant controls. 
1. Create a Conditional Access policy that targets the **Register security information** user action and requires the **Bootstrap and recovery** authentication strength. 

As a result, users on a compliant device would be able to use a Temporary Access Pass to register any MFA method, and then use the newly registered method to authenticate to other resources like Outlook. 

>[!NOTE] 
>- If multiple Conditional Access policies target the **Register security information** user action, and they each apply an authentication strength, the user must satisfy all such authentication strengths to sign in. 
>
>- Some passwordless and phishing-resistant methods can't be registered from the Interrupt mode. For more information, see [Register passwordless authentication methods](/entra/identity/authentication/concept-authentication-strength-how-it-works#register-passwordless-authentication-methods).

## User experience

The following factors determine if the user gains access to the resource: 

- Which authentication method was previously used?
- Which methods are available for the authentication strength? 
- Which methods are allowed for user sign-in in the Authentication methods policy?
- Is the user registered for any available method?

When a user accesses a resource protected by an authentication strength Conditional Access policy, Microsoft Entra ID evaluates if the methods they have previously used satisfy the authentication strength. If a satisfactory method was used, Microsoft Entra ID grants access to the resource. For example, let's say a user signs in with password + text message. They access a resource protected by MFA authentication strength. In this case, the user can access the resource without another authentication prompt.

Let's suppose they next access a resource protected by Phishing-resistant MFA authentication strength. At this point, they'll be prompted to provide a phishing-resistant authentication method, such as Windows Hello for Business. 

If the user hasn't registered for any methods that satisfy the authentication strength, they're redirected to [combined registration](concept-registration-mfa-sspr-combined.md#interrupt-mode). <!-- making this a comment for now because we have a limitation. Once it is fixed we can remove the comment::: Only users who satisfy MFA are redirected to register another strong authentication method.-->

Users are required to register only one authentication method that satisfies the authentication strength requirement. 

If the authentication strength doesn't include a method that the user can register and use, the user is blocked from sign-in to the resource. 

### Register passwordless authentication methods

The following authentication methods can't be registered as part of combined registration interrupt mode. Make sure users are registered for these methods before you apply a Conditional Access policy that can require them to be used for sign-in. If a user isn't registered for these methods, they can't access the resource until the required method is registered. 

| Method | Registration requirements |
|--------|---------------------------|
|[Microsoft Authenticator (phone sign-in)](https://support.microsoft.com/account-billing/add-your-work-or-school-account-to-the-microsoft-authenticator-app-43a73ab5-b4e8-446d-9e54-2a4cb8e4e93c) | Can be registered from the Authenticator app.|
|[Passkey(FIDO2)](howto-authentication-passwordless-security-key.md) | Can be registered using [combined registration managed mode](/entra/identity/authentication/concept-registration-mfa-sspr-combined#manage-mode) and enforced by Authentication strengths using [combined registration wizard mode](/entra/identity/authentication/concept-registration-mfa-sspr-combined#interrupt-mode) |
|[Certificate-based authentication](concept-certificate-based-authentication.md) | Requires administrator setup; can't be registered by the user. |
|[Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-prepare-people-to-use) | Can be registered in the Windows Out of Box Experience (OOBE) or the Windows Settings menu.|


### Federated user experience  
For federated domains, MFA may be enforced by Microsoft Entra Conditional Access or by the on-premises federation provider by setting the federatedIdpMfaBehavior. If the federatedIdpMfaBehavior setting is set to enforceMfaByFederatedIdp, the user must authenticate on their federated IdP and can only satisfy the **Federated Multi-Factor** combination of the authentication strength requirement. For more information about the federation settings, see [Plan support for MFA](../hybrid/connect/migrate-from-federation-to-cloud-authentication.md).

If a user from a federated domain has multifactor authentication settings in scope for Staged Rollout, the user can complete multifactor authentication in the cloud and satisfy any of the **Federated single-factor + something you have** combinations. For more information about staged rollout, see [Enable Staged Rollout](how-to-mfa-server-migration-utility.md#enable-staged-rollout).

## Next steps

- [Built-in authentication strengths](concept-authentication-strengths.md)
- [Custom authentication strengths](concept-authentication-strength-advanced-options.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 

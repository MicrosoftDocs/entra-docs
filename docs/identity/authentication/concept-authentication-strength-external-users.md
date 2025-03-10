---
title: How Conditional Access authentication strength works for external users in Microsoft Entra ID
description: Learn how admins can use authentication strength requirements for external users in Microsoft Entra ID.


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 03/04/2025

ms.author: justinha
author: inbarckms
manager: femila
ms.reviewer: namkedia
---
# How Conditional Access authentication strength works for external users

The Authentication methods policy is especially useful for restricting external access to sensitive apps in your organization because you can enforce specific authentication methods, such as phishing-resistant methods, for external users.

When you apply an authentication strength Conditional Access policy to external Microsoft Entra users, the policy works together with MFA trust settings in your cross-tenant access settings to determine where and how the external user must perform MFA. A Microsoft Entra user authenticates in their home Microsoft Entra tenant. Then when they access your resource, Microsoft Entra ID applies the policy and checks to see if you've enabled MFA trust. Note that enabling MFA trust is optional for B2B collaboration but is *required* for [B2B direct connect](~/external-id/b2b-direct-connect-overview.md#multifactor-authentication-mfa).

In external user scenarios, the authentication methods that can satisfy authentication strength vary, depending on whether the user is completing MFA in their home tenant or the resource tenant. The following table indicates the allowed methods in each tenant. If a resource tenant has opted to trust claims from external Microsoft Entra organizations, only those claims listed in the “Home tenant” column below will be accepted by the resource tenant for MFA. If the resource tenant has disabled MFA trust, the external user must complete MFA in the resource tenant using one of the methods listed in the “Resource tenant” column.

|Authentication method  |Home tenant  | Resource tenant  |
|---------|---------|---------|
|Text message as second factor                         | &#x2705;        | &#x2705; |
|Voice call                                   | &#x2705;        | &#x2705; |
|Microsoft Authenticator push notification    | &#x2705;        | &#x2705; |
|Microsoft Authenticator phone sign-in        | &#x2705;        |          |
|OATH software token                          | &#x2705;        | &#x2705; |
|OATH hardware token                          | &#x2705;        |          |
|FIDO2 security key                           | &#x2705;        |          |
|Windows Hello for Business                   | &#x2705;        |          |
|Certificate-based Authentication             | &#x2705;        |          |

For more information about how to set authentication strengths for external users, see [Conditional Access: Require an authentication strength for external users](~/identity/conditional-access/policy-guests-mfa-strength.md).

## User experience for external users

An authentication strength Conditional Access policy works together with [MFA trust settings](../../external-id/cross-tenant-access-settings-b2b-collaboration.yml) in your cross-tenant access settings. First, a Microsoft Entra user authenticates with their own account in their home tenant. Then when this user tries to access your resource, Microsoft Entra ID applies the authentication strength Conditional Access policy and checks to see if you've enabled MFA trust.

- **If MFA trust is enabled**, Microsoft Entra ID checks the user's authentication session for a claim that indicates MFA was fulfilled in the user's home tenant. See the preceding table for authentication methods that are acceptable for MFA when completed in an external user's home tenant. If the session contains a claim that indicates the MFA policies are already met in the user's home tenant, and the methods satisfy the authentication strength requirements, the user is allowed access. Otherwise, Microsoft Entra ID presents the user with a challenge to complete MFA in the home tenant using an acceptable authentication method.
- **If MFA trust is disabled**, Microsoft Entra ID presents the user with a challenge to complete MFA in the resource tenant using an acceptable authentication method. See preceding table for authentication methods that are acceptable for MFA by an external user.

## Next steps

- [Conditional Access authentication strength](concept-authentication-strengths.md)
- [How authentication strength works](concept-authentication-strength-how-it-works.md)
- [Built-in Conditional Access authentication strengths](concept-authentication-strengths.md)
- [Custom Conditional Access authentication strengths](concept-authentication-strength-advanced-options.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 

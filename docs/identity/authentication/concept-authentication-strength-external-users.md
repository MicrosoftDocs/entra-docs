---
title: How Conditional Access Authentication Strengths Work for External Users
description: Learn how admins can use authentication strength requirements for external users in Microsoft Entra ID.
ms.topic: concept-article
ms.date: 03/04/2025
author: inbarckms
ms.reviewer: namkedia
---
# How Conditional Access authentication strengths work for external users

Authentication strengths are especially useful for restricting external access to sensitive apps in your organization. They can enforce specific authentication methods, such as phishing-resistant methods, for external users.

When you apply a Conditional Access authentication strength policy to external Microsoft Entra users, the policy works together with multifactor authentication (MFA) trust settings in your cross-tenant access settings to determine where and how the external user must perform MFA. A Microsoft Entra user authenticates in their home Microsoft Entra tenant. When the user accesses your resource, Microsoft Entra ID applies the policy and checks if you enabled MFA trust.

> [!NOTE]
> Enabling MFA trust is optional for business-to-business (B2B) collaboration but is *required* for [B2B direct connect](~/external-id/b2b-direct-connect-overview.md#multifactor-authentication-mfa).

In external user scenarios, the authentication methods that can satisfy authentication strengths vary, depending on whether the user is completing MFA in the home tenant or the resource tenant. The following table indicates the allowed methods in each tenant. If a resource tenant opts to trust claims from external Microsoft Entra organizations, the resource tenant for MFA accepts only the claims listed in the table's "Home tenant" column. If the resource tenant disables MFA trust, the external user must complete MFA in the resource tenant by using one of the methods listed in the "Resource tenant" column.

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
|Certificate-based authentication             | &#x2705;        |          |

For more information about how to set authentication strengths for external users, see [Require multifactor authentication strengths for external users](~/identity/conditional-access/policy-guests-mfa-strength.md).

## User experience for external users

A Conditional Access authentication strength policy works together with [MFA trust settings](../../external-id/cross-tenant-access-settings-b2b-collaboration.yml) in your cross-tenant access settings. First, a Microsoft Entra user authenticates with their own account in the home tenant. When the user tries to access your resource, Microsoft Entra ID applies the Conditional Access authentication strength policy and checks if you enabled MFA trust:

- **If MFA trust is enabled**: Microsoft Entra ID checks the user's authentication session for a claim that indicates MFA was fulfilled in the user's home tenant. See the preceding table for authentication methods that are acceptable for MFA when they're completed in an external user's home tenant.

  If the session contains a claim that indicates the MFA policies are already met in the user's home tenant, and the methods satisfy the authentication strength requirements, the user is allowed access. Otherwise, Microsoft Entra ID presents the user with a challenge to complete MFA in the home tenant by using an acceptable authentication method.
- **If MFA trust is disabled**: Microsoft Entra ID presents the user with a challenge to complete MFA in the resource tenant by using an acceptable authentication method. See the preceding table for authentication methods that are acceptable for MFA by an external user.

## Related content

- [How authentication strengths work](concept-authentication-strength-how-it-works.md)
- [Built-in Conditional Access authentication strengths](concept-authentication-strengths.md)
- [Custom Conditional Access authentication strengths](concept-authentication-strength-advanced-options.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md)

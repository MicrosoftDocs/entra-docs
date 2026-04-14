---
title: FAQ - Improved enforcement for Conditional Access policies with resource exclusions
description: Frequently asked questions about the improved Conditional Access enforcement behavior for policies that target All resources with resource exclusions.
ms.topic: faq
ms.date: 04/14/2026
ms.reviewer: kvenkit
ai-usage: ai-assisted
---

# FAQ: Improved enforcement for policies with resource exclusions

This article answers frequently asked questions about the improved Conditional Access enforcement for policies that target **All resources** with resource exclusions.

For technical details about this behavior change, see [New Conditional Access behavior when an ALL resources policy has a resource exclusion](concept-conditional-access-cloud-apps.md#new-conditional-access-behavior-when-an-all-resources-policy-has-a-resource-exclusion).

## Enforcement change

### What are baseline scopes?

Baseline scopes is an umbrella term for the following set of scopes:

- **OpenID Connect (OIDC) scopes**: `email`, `offline_access`, `openid`, `profile`
- **Baseline directory scopes**: `User.Read`, `User.Read.All`, `User.ReadBasic.All`, `People.Read`, `People.Read.All`, `GroupMember.Read.All`, `Member.Read.Hidden`

### What is the upcoming Conditional Access behavior change for baseline scopes?

Today, Conditional Access policies that target All resources aren't enforced if the policy has one or more resource exclusions when:

1. A user signs in through a **public client application** (for example, desktop apps such as Microsoft Teams desktop client) that requests only the baseline scopes (OIDC or directory). Examples:
   - A user signs into Visual Studio Code desktop client, which requests `openid` and `profile` scopes.
   - A user signs in using Azure CLI, which requests only `User.Read`.

1. A user signs in through a **confidential client application** (for example, web apps) that is excluded from an All resources policy and requests only the baseline directory scopes. Examples:
   - A user signs in through a web application (excluded from the policy) that requests only `User.Read` and `People.Read`.

For more information, see [Legacy Conditional Access behavior when an ALL resources policy has a resource exclusion](concept-conditional-access-cloud-apps.md#legacy-conditional-access-behavior-when-an-all-resources-policy-has-a-resource-exclusion).

**After this change**, in both of the above scenarios, users might now receive Conditional Access challenges (such as MFA or device compliance) where previously they were allowed access without enforcement. The exact challenges depend on the access controls configured in your policies that target All resources or explicitly target Windows Azure Active Directory (Microsoft Entra ID directory) as the resource.

In summary, sign-ins that use only these scopes now receive the same Conditional Access protections applied to access your Microsoft Entra ID directory data.

### What isn't changing?

- When an application (public or confidential) requests any scope beyond the baseline scopes (for example, `Mail.Read`), it's already subject to Conditional Access enforcement. For example, when a client requests `Mail.Read`, it's subject to Conditional Access policies that include Office 365 Exchange Online as a target resource.
- For confidential client applications that are excluded from All resources policies and request only OIDC scopes, no change is expected.

### What action is required?

**For public clients requesting baseline scopes:**

- Review whether these applications should remain exempt from Conditional Access enforcement.
- If there are valid business reasons to maintain an exemption for specific public clients, see [Baseline scope settings](#baseline-scope-settings).

**For confidential client applications (owned by your tenant) requesting baseline directory scopes and currently excluded from All resources policies:**

- Review these applications and determine whether the exclusion is still necessary.
- If the exclusion is required:
  - Work with your application developers to assess whether the app can be updated to request OIDC scopes (for example, `openid`, `profile`) instead of directory scopes like `User.Read` for basic user information.
  - If updates can't be completed before rollout, see [Baseline scope settings](#baseline-scope-settings).

**For confidential client applications (owned by an ISV) requesting baseline directory scopes and currently excluded from All resources policies:**

- Review these applications and determine whether the exclusion is still necessary.
- If the exclusion is required:
  - Engage with your ISV to evaluate whether the application can be updated to use OIDC scopes instead of directory scopes like `User.Read`.
  - In most cases, OIDC scopes provide the least-privilege access required for these scenarios.
  - If the ISV can't make updates in time, see [Baseline scope settings](#baseline-scope-settings).

> [!IMPORTANT]
> For both public and confidential client applications owned by your tenant, ensure the application can handle Conditional Access challenges (for example, MFA or device compliance). If not, application updates might be required. Refer to the [Conditional Access developer guidance](../../identity-platform/v2-conditional-access-dev-guide.md) on how to update your application appropriately.

### How can I retain the legacy behavior?

This enforcement update aligns with Microsoft's Secure Future Initiative and defense-in-depth investments and is being made to improve your security posture. Microsoft recommends aligning with the new enforcement model. If you still wish to retain the legacy behavior, see [Baseline scope settings](#baseline-scope-settings).

## Baseline scope settings

### What is this setting?

Baseline scope settings is a tenant-level setting that allows you to use a custom tenant-owned application as the target resource for baseline scopes. By excluding this custom application from specific All resources policies, you can retain the legacy behavior.

### Who should use this setting?

Use this setting if you:

1. Want to preview the Conditional Access enforcement change ahead of the rollout starting May 13, 2026.
1. Have specific scenarios that require you to retain the legacy behavior. Example scenarios:
   - **All resources policies with require a compliant device grant control**: Applications that are excluded from this policy because they must be accessible from unmanaged devices.
   - **All resources policies with require an app protection policy grant control**: Client applications that aren't integrated with the Intune SDK and can't satisfy the app protection policy.
   - **All resources policies with block control**: Client applications that must be excluded from the block policy.
   - **Public clients that must be exempt from compliant device requirements**: Due to specific security and compliance reasons.

### How can I preview the Conditional Access enforcement change?

1. Go to <https://aka.ms/BaselineScopesSettings>.
1. Choose **default target resource** (Windows Azure Active Directory).
1. Select **Save**.

> [!NOTE]
> This results in immediate enforcement of the improved Conditional Access enforcement behavior for All resources policies with resource exclusions. Users that were not previously subject to Conditional Access enforcement might now be subject to enforcement with Windows Azure Active Directory as the evaluation resource.
>
> To revert to the legacy behavior, select **reset**.
>
> If a custom target resource isn't selected, the rollout based on Windows Azure Active Directory as the default target resource for baseline scopes is enforced in phases starting May 13, 2026.

### How can I use baseline scope settings to identify applications that might be affected?

1. Go to <https://aka.ms/BaselineScopesSettings>.
1. Choose a **custom target resource**. This should be a single-tenant application registered in the tenant.
1. Select **Save**.

> [!NOTE]
> - This results in the custom application being evaluated as the target resource when client requests exclusively request baseline scopes.
> - Exclude the custom application from your All resources policies so that you can retain the legacy behavior while evaluating the impact to applications in your tenant.

Once enabled, sign-in events where the applications request baseline scopes list the custom application as a Conditional Access audience in sign-in logs. For more information, see [Troubleshoot sign-in problems with Conditional Access](troubleshoot-conditional-access.md).

Use the following Microsoft Graph query to list applications that request only the baseline scopes:

```http
https://graph.microsoft.com/beta/auditLogs/signIns?$filter=conditionalAccessAudiences/any(a:a eq '<your-custom-app-id>')&$select=appId,appDisplayName
```

Replace `<your-custom-app-id>` with your custom application's app ID.

Over a multiday period, the result of this query provides a list of client applications that request only baseline scopes.

## Related content

- [Conditional Access: Target resources](concept-conditional-access-cloud-apps.md)
- [Conditional Access developer guidance](../../identity-platform/v2-conditional-access-dev-guide.md)
- [Troubleshoot sign-in problems with Conditional Access](troubleshoot-conditional-access.md)

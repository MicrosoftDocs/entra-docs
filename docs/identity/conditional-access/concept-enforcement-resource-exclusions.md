---
title: Improved enforcement for Conditional Access policies with resource exclusions
description: Learn about the improved Conditional Access enforcement behavior for policies that target All resources with resource exclusions, including how to assess impact and retain legacy behavior.
ms.topic: concept-article
ms.date: 04/14/2026
ms.reviewer: kvenkit
ai-usage: ai-assisted
---

# Improved enforcement for policies with resource exclusions

## Overview

Microsoft Entra ID is rolling out an improved enforcement model for Conditional Access policies that target **All resources** and include one or more **resource exclusions**. This change ensures that sign-ins requesting only baseline scopes receive the same Conditional Access protections as other resource access.

Previously, certain low-privilege scopes were automatically excluded from policy enforcement when a resource exclusion existed. With this change, those scopes are now evaluated as directory access and are subject to your Conditional Access policies.

For detailed technical background, see [New Conditional Access behavior when an ALL resources policy has a resource exclusion](concept-conditional-access-cloud-apps.md#new-conditional-access-behavior-when-an-all-resources-policy-has-a-resource-exclusion).

> [!IMPORTANT]
> This enforcement update aligns with Microsoft's Secure Future Initiative and defense-in-depth investments. Microsoft recommends adopting the new enforcement model to improve your security posture.

## Who is affected

This change affects your tenant if all of the following conditions are true:

- You have one or more Conditional Access policies that target **All resources**.
- Those policies have one or more **resource exclusions**.
- Users in your tenant sign in through applications that request **only baseline scopes**.

If your policies target All resources without any resource exclusions, this change doesn't affect you.

## What are baseline scopes

Baseline scopes is an umbrella term for the following set of scopes:

- **OpenID Connect (OIDC) scopes**: `email`, `offline_access`, `openid`, `profile`
- **Baseline directory scopes**: `User.Read`, `User.Read.All`, `User.ReadBasic.All`, `People.Read`, `People.Read.All`, `GroupMember.Read.All`, `Member.Read.Hidden`

## What is changing

After the rollout, the following scenarios might now trigger Conditional Access challenges (such as MFA or device compliance) where access was previously granted without enforcement:

- **Public client applications** (like desktop apps) that request only baseline scopes. For example, a user signs into Visual Studio Code desktop client, which requests `openid` and `profile` scopes, or Azure CLI, which requests only `User.Read`.
- **Confidential client applications** (like web apps) that are excluded from an All resources policy and request only baseline directory scopes. For example, a web application excluded from the policy that requests only `User.Read` and `People.Read`.

The exact challenges depend on the access controls configured in your policies that target All resources or explicitly target Windows Azure Active Directory (Microsoft Entra ID directory) as the resource.

## What isn't changing

- When an application (public or confidential) requests any scope beyond the baseline scopes (for example, `Mail.Read`), the application is already subject to Conditional Access enforcement. This behavior doesn't change.
- For confidential client applications that are excluded from All resources policies and request only OIDC scopes, no change is expected.

## What you need to do

Use the following table to determine the required actions for your applications:

| Application type | Ownership | Action required |
|---|---|---|
| Public client requesting only baseline scopes | Any | Review whether these applications should remain exempt from Conditional Access enforcement. If there are valid business reasons to maintain an exemption, see [Retain legacy behavior with baseline scope settings](#retain-legacy-behavior-with-baseline-scope-settings). |
| Confidential client requesting only baseline directory scopes, excluded from All resources policy | Tenant-owned | Review whether the exclusion is still necessary. Work with your application developers to assess whether the app can request OIDC scopes (like `openid`, `profile`) instead of directory scopes like `User.Read` for basic user information. If updates can't be completed before rollout, see [Retain legacy behavior with baseline scope settings](#retain-legacy-behavior-with-baseline-scope-settings). |
| Confidential client requesting only baseline directory scopes, excluded from All resources policy | ISV-owned | Review whether the exclusion is still necessary. Engage with your ISV to evaluate whether the application can request OIDC scopes instead of directory scopes. In most cases, OIDC scopes provide the least-privilege access required for these scenarios. If the ISV can't make updates in time, see [Retain legacy behavior with baseline scope settings](#retain-legacy-behavior-with-baseline-scope-settings). |

> [!IMPORTANT]
> For both public and confidential client applications owned by your tenant, ensure the application can handle Conditional Access challenges (for example, MFA or device compliance). If not, application updates might be required. Refer to the [Conditional Access developer guidance](../../identity-platform/v2-conditional-access-dev-guide.md) on how to update your application appropriately.

## How to assess impact

### Preview the enforcement change

You can preview the improved enforcement behavior before the rollout begins:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Conditional Access administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Access the [Baseline scopes settings](https://aka.ms/BaselineScopesSettingsUX) in Conditional Access. This direct link is required to view the preview settings.
1. Choose **default target resource** (Windows Azure Active Directory).
1. Select **Save**.

> [!NOTE]
> This setting immediately enables the updated Conditional Access behavior for **All resources** policies with exclusions.
>
> As a result, some user sign-ins that were not previously subject to CA enforcement may now be evaluated and enforced under Conditional Access using Windows Azure Active Directory as the target resource.

To revert to the legacy behavior, select **reset** from the **Baseline scope settings**.

If a custom target resource isn't selected, the rollout based on Windows Azure Active Directory as the default target resource for baseline scopes is enforced in phases.

### Identify affected applications with a custom target resource

You can use baseline scope settings to identify which applications in your tenant are affected. Once the preview setting is enabled, sign-in events where the applications request baseline scopes list the custom application as a Conditional Access audience in sign-in logs. For more information, see [Troubleshoot sign-in problems with Conditional Access](troubleshoot-conditional-access.md).

### Query for affected applications

Use the following Microsoft Graph query to list applications that request only the baseline scopes:

```http
https://graph.microsoft.com/beta/auditLogs/signIns?$filter=conditionalAccessAudiences/any(a:a eq '<your-custom-app-id>')&$select=appId,appDisplayName
```

Replace `<your-custom-app-id>` with your custom application's app ID.

Over a multiday period, the result of this query provides a list of client applications that request only baseline scopes.

## Retain legacy behavior with baseline scope settings

> [!NOTE]
> Microsoft recommends aligning with the new enforcement model. Use baseline scope settings only if you have specific scenarios that require the legacy behavior.

Baseline scope settings is a tenant-level configuration that allows you to use a custom tenant-owned application as the target resource for baseline scopes. By excluding this custom application from specific All resources policies, you can retain the legacy behavior.

### Who should use this setting

Use this setting if you have specific scenarios that require you to retain the legacy behavior. Example scenarios include:

- **All resources policies with require a compliant device grant control**: Applications that are excluded from this policy because they must be accessible from unmanaged devices.
- **All resources policies with require an app protection policy grant control**: Client applications that aren't integrated with the Intune SDK and can't satisfy the app protection policy.
- **All resources policies with block control**: Client applications that must be excluded from the block policy.
- **Public clients that must be exempt from compliant device requirements**: Due to specific security and compliance reasons.

## FAQ

### How can I preview the enforcement change ahead of the rollout?

Go to <https://aka.ms/BaselineScopesSettingsUX>, choose the **default target resource** (Windows Azure Active Directory), and select **Save**. This setting immediately enforces the improved behavior. To revert back, select **reset**. For more information, see [Preview the enforcement change](#preview-the-enforcement-change).

### How can I retain the legacy behavior after the rollout?

Use baseline scope settings to assign a custom tenant-owned application as the target resource for baseline scopes, then exclude that application from your All resources policies. For more information, see [Retain legacy behavior with baseline scope settings](#retain-legacy-behavior-with-baseline-scope-settings).

### Do I need to update all applications?

No. Only applications that request exclusively baseline scopes and are affected by your All resources policies with resource exclusions need attention. Applications that request scopes beyond the baseline (for example, `Mail.Read`) are already subject to Conditional Access enforcement and aren't affected by this change.

## Related content

- [Conditional Access: Target resources](concept-conditional-access-cloud-apps.md)
- [Conditional Access developer guidance](../../identity-platform/v2-conditional-access-dev-guide.md)
- [Troubleshoot sign-in problems with Conditional Access](troubleshoot-conditional-access.md)

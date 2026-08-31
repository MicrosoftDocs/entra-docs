---
title: Global Secure Access and Universal Tenant Restrictions
description: Learn about how Global Secure Access helps secure access to your corporate network by restricting access to external tenants.
ms.topic: how-to
ms.date: 07/29/2026
ms.author: alexpav
ms.reviewer: dhruvinrshah
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Turn on Universal Tenant Restrictions

## Overview

Universal Tenant Restrictions (UTR) enhance the functionality of [tenant restrictions v2 (TRv2)](https://aka.ms/tenant-restrictions-enforcement). UTR applies tenant restrictions policies to any devices with the GSA client or on the GSA Remote Network, without having to steer network traffic through company-managed proxy service.

When you enable UTR, Microsoft Entra ID tenant restrictions policy is applied to all applications protected by Entra ID. Users on your devices with GSA or GSA Remote Networks can only sign in to tenants and applications authorized in your TRv2 policy.

## Prerequisites

- Administrators who interact with Global Secure Access features must have the [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) to manage those features.
- Global Secure Access requires a license. For details, see [Licensing overview](overview-what-is-global-secure-access.md#licensing-overview).
- You must enable a [Microsoft traffic profile](concept-microsoft-traffic-profile.md). Fully qualified domain names (FQDNs) and IP addresses of Entra ID services must be configured to 'Tunnel'.
- You must deploy [Global Secure Access clients](concept-clients.md) or configure [remote network connectivity](concept-remote-network-connectivity.md).

## Configure the TRv2 policy

Before you can use UTR, you must configure both the default tenant restrictions and tenant restrictions for any specific partners.

For more information about configuring these policies, see [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2).

## Enable Universal Tenant Restrictions

After you create the TRv2 policies, you can use Global Secure Access to apply tagging for TRv2. An administrator who has both the [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference) and [Security Administrator](/azure/active-directory/roles/permissions-reference#security-administrator) roles must take the following steps to enable enforcement with Global Secure Access:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).

1. Go to **Global Secure Access** > **Settings** > **Session Management**.

1. On the **Universal Tenant Restrictions** tab, turn on the **Enable Tenant Restrictions for Microsoft Entra ID and Microsoft Graph** toggle.

## Try universal tenant restrictions

Tenant restrictions aren't enforced when a user (or a guest user) tries to access resources in the tenant where the policies are configured. Tenant restrictions v2 policies are processed only when an identity from a different tenant attempts to sign in or accesses resources.

For example, if you configure a tenant restrictions v2 policy in the tenant contoso.com to block all organizations except fabrikam.com, the policy applies according to this table:

| User | Type | Tenant | Tenant restrictions v2 policy processed? |Authenticated access allowed? |
| ---------- | ----------- | ------------ | ----------- | --------------- |
|`alice@contoso.com`| Member | contoso.com | No (same tenant) | Yes |
|`alice@fabrikam.com`|Member|fabrikam.com|Yes|Yes (tenant allowed by policy)|
|`bob@northwindtraders.com`|Member|northwindtraders.com|Yes|No (tenant not allowed by policy)|
|`bob_northwindtraders.com#EXT#@contoso.com`|Guest|contoso.com|No (guest user)|Yes|


## Known limitations

If you enabled universal tenant restrictions and you access the Microsoft Entra admin center for a tenant on the tenant restrictions v2 allow list, you might get an "Access denied" error. To correct this error, add the following feature flag to the Microsoft Entra admin center: `?feature.msaljs=true&exp.msaljsexp=true`.

For example, assume that you work for Contoso. Fabrikam, a partner tenant, is on the allow list. You might get the error message for the Fabrikam tenant's Microsoft Entra admin center.

If you received the "Access denied" error message for the URL `https://entra.microsoft.com/`, add the feature flag as follows: `https://entra.microsoft.com/?feature.msaljs%253Dtrue%2526exp.msaljsexp%253Dtrue#home`.

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Related content

- [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2)
- [Enable source IP restoration](how-to-source-ip-restoration.md)
- [Enable compliant network check with Conditional Access](how-to-compliant-network.md)

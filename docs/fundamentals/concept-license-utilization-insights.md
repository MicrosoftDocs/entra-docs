---
title: Microsoft Entra license utilization insights
description: Learn how to use the license utilization insights page in the Microsoft Entra admin center to monitor license usage and entitlements.
ms.topic: concept-article
ms.date: 03/11/2026
ms.reviewer: jadedsouza
ai-usage: ai-assisted
---

# Microsoft Entra license utilization insights

The license utilization insights page in the Microsoft Entra admin center helps you optimize your Microsoft Entra licenses by providing visibility into feature usage across your tenant. The page shows how many Microsoft Entra ID P1, P2, and Suite licenses you own, along with usage of key features mapped to each license type. You can also review usage trends over the past six months.

This view gives you a clearer understanding of your license count, the value you're getting from your Microsoft Entra license, and potential over-usage within your tenant.

## Prerequisites

[!INCLUDE [entra-p1-license.md](../includes/entra-p1-license.md)]

- The tenant must have a Microsoft Entra ID P1 or P2 license.
- This feature is only available in public clouds.
- The least privileged role is [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader).
    - The following roles can also access this page: [Application Administrator](../identity/role-based-access-control/permissions-reference.md#application-administrator), [Cloud Application Administrator](../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator), [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader), [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator), [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader), and [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator).

## Access the license utilization insights page

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Billing** > **Licenses**.

You can also navigate directly to the [License utilization](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/LicensesMenuBlade/~/LicenseUtilization) page.

:::image type="content" source="media/concept-license-utilization-insights/license-utilization-overview.png" alt-text="Screenshot of the License usage page in the Microsoft Entra admin center showing license entitlements and product usage insights." lightbox="media/concept-license-utilization-insights/license-utilization-overview.png":::

## License entitlements

The license entitlements section shows how many licenses you've purchased for the current month. Entitlements are calculated by looking at all Microsoft Entra products you've purchased, including:

- Microsoft Entra ID P1
- Microsoft Entra ID P2
- Microsoft Entra Suite
- Microsoft Entra ID Governance
- Microsoft Entra Verified ID
- Microsoft Entra Private Access
- Microsoft Entra Internet Access

The entitlement count reflects the total number of licenses across all products that include each tier of Microsoft Entra ID functionality.


## Feature usage metrics

The license utilization insights page uses a single representative metric (hero metric) for each license tier to measure usage. This approach simplifies the view by focusing on the most meaningful indicator of paid feature adoption.

### Microsoft Entra ID P1 usage

For P1 licenses, the hero metric is **Conditional Access users** — the number of unique users with at least one configured Conditional Access policy during the measurement period.


### Microsoft Entra ID P2 usage

For P2 licenses, the hero metric is **Risk-based Conditional Access users** — the number of unique users with at least one configured risk-based Conditional Access policy during the measurement period.


### Active and guest user differentiation

The usage metrics differentiate between active users and guest users. This distinction helps you understand which portion of your license consumption comes from internal users versus external collaborators.

## Understand the usage visualization

The license utilization insights page displays a usage bar that compares your current usage against your entitlements:

- **Within entitlement** — The bar shows your usage in one color, indicating you're using fewer licenses than you've purchased.
- **Over entitlement** — If usage exceeds your entitlement, the bar extends beyond the entitlement boundary, providing a visual indicator that you might need more licenses.


## Usage trends

You can review usage trends over the past six months to understand how your license consumption changes over time. This historical view helps you:

- Identify growth patterns in feature adoption.
- Plan for future license purchases.
- Spot seasonal or project-driven usage spikes.


## Related content

- [Microsoft Entra licensing](licensing.md)
- [Group-based licensing in Microsoft Entra](concept-group-based-licensing.md)
- [Sign up for Microsoft Entra ID P1 or P2](get-started-premium.md)

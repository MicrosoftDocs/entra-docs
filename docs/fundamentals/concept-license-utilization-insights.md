---
title: Microsoft Entra license utilization insights
description: Learn how to use the license utilization insights page in the Microsoft Entra admin center to monitor license usage and entitlements.
ms.topic: concept-article
ms.date: 03/07/2026
ms.reviewer: jadedsouza
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Microsoft Entra license utilization insights

The license utilization insights page in the Microsoft Entra admin center helps you optimize your Microsoft Entra licenses by providing visibility into feature usage across your tenant. The page shows how many Entra ID P1, P2, and Suite licenses you own, along with usage of key features mapped to each license type. You can also review usage trends over the past six months.

This view gives you a clearer understanding of your license footprint, the value you're getting from Microsoft Entra, and potential over-usage risks within your tenant.

## Prerequisites

[!INCLUDE [entra-license-utilization-roles](~/../docs/includes/entra-license-utilization-roles.md)]

<!-- TODO: Confirm the least privileged role required with PM (Jade DSouza).
     Sarah Lipsey tested with License Administrator and couldn't access the page.
     Replace the include above with the confirmed role, or use inline text:

     To access the license utilization insights page, you need one of the following roles:
     - [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator)
     - [TBD - least privileged role]
-->

## Access the license utilization insights page

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Billing** > **Licenses**.

<!-- TODO: Confirm navigation path with PM. The public preview blog post showed this under
     "Usage & Insights" blade, but the March 2026 demo showed it under "Billing > Licenses". -->

## License entitlements

The license entitlements section shows how many licenses you've purchased for the current month. Entitlements are calculated by looking at all Microsoft Entra products you've purchased, including:

- Microsoft Entra ID P1
- Microsoft Entra ID P2
- Microsoft Entra Suite
- Microsoft Entra ID Governance
- Microsoft Entra Verified ID
- Microsoft Entra Private Access
- Microsoft Entra Internet Access

The entitlement count reflects the total number of licenses across all products that include each tier of Entra ID functionality.

## Feature usage metrics

The license utilization insights page uses a single representative metric (hero metric) for each license tier to measure usage. This approach simplifies the view by focusing on the most meaningful indicator of paid feature adoption.

### Entra ID P1 usage

For P1 licenses, the hero metric is **Conditional Access users** — the number of unique users who signed in through at least one Conditional Access policy during the measurement period.

### Entra ID P2 usage

For P2 licenses, the hero metric is **Risk-based Conditional Access users** — the number of unique users who signed in through at least one risk-based Conditional Access policy during the measurement period.

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

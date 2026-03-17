---
title: Private Access segmentation strategies for Global Secure Access
description: Learn best practices for transitioning from VPN replacement with Quick Access to per-application segmentation using Microsoft Entra Private Access.
ms.topic: how-to
ms.date: 03/17/2026
ms.author: jfields
author: jenniferf-skc
ms.reviewer: katabish
ms.service: global-secure-access
ai-usage: ai-assisted

#Customer intent: As an IT administrator, I want to understand how to transition from broad VPN replacement with Quick Access to granular per-application segmentation so I can enforce least privilege access for my users.

---

# Private Access segmentation strategies for Global Secure Access

Microsoft Entra Private Access provides a path from traditional VPN solutions to granular, per-application access. Many organizations begin by replacing their VPN with [Quick Access](how-to-configure-quick-access.md), which provides broad connectivity to corporate resources. The next step is to segment that broad access into individual applications so that each user only reaches the resources they need.

This article walks through the recommended strategy for transitioning from Quick Access to per-application segmentation, using [Application Discovery](how-to-application-discovery.md) to inform your segmentation decisions.

## Prerequisites

- A Microsoft Entra tenant onboarded to [Microsoft Entra Private Access](concept-private-access.md).
- A Microsoft Entra tenant configured with [Quick Access](how-to-configure-quick-access.md).
- Users actively accessing resources through Quick Access so that Application Discovery has traffic data to analyze.
- One of the following roles: [Global Secure Access Administrator](reference-role-based-permissions.md#global-secure-access-administrator) or [Application Administrator](reference-role-based-permissions.md#application-administrator).

## Understand the segmentation journey

The transition from VPN to per-application segmentation follows a phased approach:

| Phase | Description |
|---|---|
| **Phase 1: VPN replacement** | Deploy Quick Access with broad IP ranges and wildcard FQDNs to replicate VPN-level connectivity. Users can access the same resources they reached through the VPN, and you can decommission the VPN. |
| **Phase 2: Discovery** | Use Application Discovery to analyze traffic patterns and understand which applications users are accessing through Quick Access. Identify the most-used application segments and the users who access them. |
| **Phase 3: Segmentation** | Create individual [per-app access](how-to-configure-per-app-access.md) enterprise applications for high-value or sensitive resources. Assign only the users and groups that require access to each application. |
| **Phase 4: Governance** | Apply [Conditional Access](how-to-target-resource-private-access-apps.md) policies to individual applications, enforce multifactor authentication (MFA) for sensitive resources, and continue to monitor access patterns. |

> [!TIP]
> Don't attempt to segment all applications at once. Start with the most critical or most-used applications identified through Application Discovery, then expand your segmentation over time.

## Phase 1: Replace your VPN with Quick Access

If you haven't already, [configure Quick Access](how-to-configure-quick-access.md) with the IP ranges and FQDNs that your VPN currently provides access to. Quick Access gives users broad connectivity similar to a VPN but through Microsoft Entra Private Access.

At this stage, all users who are assigned to Quick Access can reach any resource within the defined ranges. This broad access is intentional — it ensures a smooth transition from VPN without disrupting user productivity.

## Phase 2: Discover application access patterns

After users have been accessing resources through Quick Access, use Application Discovery to understand traffic patterns.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Secure Access Administrator](reference-role-based-permissions.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Applications** > **Application Discovery**.
1. Review the discovered application segments, sorted by the number of users.

Focus on identifying:

- **High-traffic applications** — Application segments with the most users and transactions. These are strong candidates for early segmentation because they have the highest impact.
- **Sensitive applications** — Resources such as financial systems, HR platforms, or administrative tools that should be restricted to specific teams. For example, only the finance team should access SAP, and only HR staff should reach the HR management system.
- **Application groupings** — Multiple application segments that belong to the same application. A single application might span several FQDNs, IP addresses, or ports. For example, Active Directory Domain Services (AD DS) for a specific site might include multiple domain controllers across several TCP and UDP ports.

For detailed guidance on interpreting Application Discovery data, see [Application Discovery for Global Secure Access](how-to-application-discovery.md).

## Phase 3: Segment access by application

After you identify the applications to segment, create individual enterprise applications for each one.

### Create per-app applications from discovered segments

1. In the **Application Discovery** table, select one or more application segments that correspond to the application you want to segment.
1. Select **Add to new application**.
1. Enter a descriptive **Name** for the application and select the appropriate **Connector Group**.
1. Review the application segments and add or remove segments as needed.
1. Select **Save**.

For complete steps, see [Create a new application](how-to-application-discovery.md#create-a-new-application) in the Application Discovery article.

### Assign users and groups with least privilege

After you create the application, restrict access to only the users who need it:

1. Browse to **Global Secure Access** > **Applications** > **Enterprise applications**.
1. Select the application you created.
1. Under **Users and groups**, remove broad assignments inherited from Quick Access.
1. Add only the specific users or groups that need access to this application.

For example:

| Application | Assigned groups |
|---|---|
| SAP Finance Portal | Finance team, Accounting team |
| HR Management System | HR team, People managers |
| Engineering wiki | Engineering team |
| AD DS — Contoso HQ | All domain-joined users at HQ |

> [!IMPORTANT]
> When you move an application segment from Quick Access to a specific enterprise application, all traffic to that segment follows the new application's configuration. No traffic to the segmented application goes through Quick Access, even if the segment remains within the ranges defined by Quick Access. Verify that the correct users are assigned before you segment to avoid access disruptions.

### Prioritize which applications to segment first

Consider this order when deciding which applications to segment first:

1. **High-sensitivity, low-user-count applications** — These are the easiest to segment because they have a small, well-defined audience and the highest security benefit. Examples: administrative tools, financial systems.
1. **High-traffic, well-defined applications** — Applications with many users but a clear audience. Examples: department-specific portals.
1. **Infrastructure services** — Services like AD DS or DNS that many users depend on. These require careful planning because they often span multiple segments and protocols.

## Phase 4: Apply governance and Conditional Access

After you create segmented applications, apply security policies to each one individually — something that isn't possible with broad VPN or Quick Access connectivity.

- **Require MFA** for sensitive applications such as financial or HR systems.
- **Require compliant devices** for applications that handle confidential data.
- **Block access from risky sign-ins** using Microsoft Entra ID Protection signals.

For guidance on applying Conditional Access to Private Access applications, see [Apply Conditional Access to Private Access apps](how-to-target-resource-private-access-apps.md).

### Continue monitoring

Segmentation isn't a one-time activity. Regularly review Application Discovery to:

- Identify new applications that users are accessing through Quick Access.
- Detect changes in usage patterns that suggest new segmentation opportunities.
- Verify that segmented applications have the correct user assignments.

Over time, reduce the scope of Quick Access as you move more application segments to individually managed enterprise applications.

## Related content

- [What is Microsoft Entra Private Access?](concept-private-access.md)
- [Configure Quick Access for Global Secure Access](how-to-configure-quick-access.md)
- [Configure per-app access to private resources](how-to-configure-per-app-access.md)
- [Application Discovery for Global Secure Access](how-to-application-discovery.md)
- [Apply Conditional Access to Private Access apps](how-to-target-resource-private-access-apps.md)

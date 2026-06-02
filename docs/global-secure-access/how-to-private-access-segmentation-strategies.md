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

Per-application segmentation aligns with the broader Zero Trust principle of network segmentation and software-defined perimeters. For wider context and planning guidance, see:

- [Secure networks with Zero Trust: Network segmentation and software-defined perimeters](/security/zero-trust/deploy/networks#1-network-segmentation-and-software-defined-perimeters)
- [Microsoft Zero Trust](https://zerotrust.microsoft.com/)
- [Zero Trust Workshop: Network segmentation guidance (NET_012)](https://microsoft.github.io/zerotrustassessment/docs/workshop-guidance/network/NET_012)

## Prerequisites

- A Microsoft Entra tenant onboarded to [Microsoft Entra Private Access](concept-private-access.md).
- A Microsoft Entra tenant configured with [Quick Access](how-to-configure-quick-access.md).
- Users actively accessing resources through Quick Access so that Application Discovery has traffic data to analyze.
- One of the following roles: [Global Secure Access Administrator](reference-role-based-permissions.md#global-secure-access-administrator) or [Application Administrator](reference-role-based-permissions.md#application-administrator).

## Understand the segmentation journey

The transition from VPN to per-application segmentation follows a phased approach:

| Phase | Description |
|---|---|
| **Phase 1: VPN modernization** | Deploy Quick Access with broad IP ranges and wildcard FQDNs to replicate VPN-level connectivity. Users can access the same resources they reached through the VPN, and you can decommission the VPN. |
| **Phase 2: Discovery** | Use Application Discovery to analyze traffic patterns and understand which applications users are accessing through Quick Access. Identify the most-used application segments and the users who access them. |
| **Phase 3: Segmentation** | Create individual [per-app access](how-to-configure-per-app-access.md) enterprise applications for high-value or sensitive resources. Assign only the users and groups that require access to each application. |
| **Phase 4: Governance** | Apply [Conditional Access](how-to-target-resource-private-access-apps.md) to your segmented applications, manage access with [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview), and continue to monitor access patterns. |

> [!TIP]
> Don't attempt to segment all applications at once. Start with the most critical or most-used applications identified through Application Discovery, then expand your segmentation over time.

## Phase 1: Modernize your VPN with Quick Access

If you haven't already, [configure Quick Access](how-to-configure-quick-access.md) with the IP ranges and FQDNs that your VPN currently provides access to. Quick Access gives users broad connectivity similar to a VPN but through Microsoft Entra Private Access.

Most customers also configure [Private DNS](concept-private-name-resolution.md) at this stage so users can reach internal resources by name. Configure your private DNS suffixes alongside Quick Access to replicate the name resolution behavior that users expect from a VPN.

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

### Move both FQDNs and the IP addresses they resolve to

If you use Private DNS, be aware of how FQDN-based and IP-based segments interact during segmentation:

- When you move an FQDN to an enterprise application, only traffic that's addressed to that FQDN (and resolved through Private DNS) follows the new application's configuration.
- Traffic that the client sends directly to the IP address — for example, traffic generated after a local DNS resolution, or traffic from a process that uses cached IPs — continues to match Quick Access if that IP is still within a Quick Access range.

To ensure all traffic to a segmented application follows its enterprise application configuration:

1. Add the FQDNs *and* the IP addresses or ranges that the application resolves to into the new enterprise application.
1. Remove those same IP addresses or ranges from Quick Access so the application's configuration is the only match for that traffic.

### Prioritize which applications to segment first

Consider this order when deciding which applications to segment first:

1. **High-sensitivity, low-user-count applications** — These are the easiest to segment because they have a small, well-defined audience and the highest security benefit. Examples: administrative tools, financial systems.
1. **High-traffic, well-defined applications** — Applications with many users but a clear audience. Examples: department-specific portals.
1. **Infrastructure services** — Services like AD DS or DNS that many users depend on. These require careful planning because they often span multiple segments and protocols.

## Phase 4: Apply Conditional Access

After you create segmented applications, apply Conditional Access policies to each one individually — something that isn't possible with broad VPN or Quick Access connectivity. Common policies include:

- **Require MFA** for sensitive applications such as financial or HR systems.
- **Require compliant devices** for applications that handle confidential data.
- **Block access from risky sign-ins** using Microsoft Entra ID Protection signals.

For most environments, the recommended baseline is to apply the Conditional Access guidance in [Apply Conditional Access to Private Access apps](how-to-target-resource-private-access-apps.md) consistently across your segmented applications. Avoid creating many individual, app-specific policies unless a specific use case requires it — broad, well-tested policies are easier to operate and audit than dozens of one-off configurations. Reserve app-specific policies for cases where the data sensitivity, regulatory requirements, or user population of an application genuinely differs from the rest of your environment.

## Govern access and continue monitoring

Segmentation isn't a one-time activity. After you segment applications, use governance and ongoing monitoring to keep access aligned with business need.

### Govern access with Microsoft Entra ID Governance

Manage who has access to your segmented enterprise applications by using [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview):

- Use [access packages](/entra/id-governance/entitlement-management-overview) to bundle related Private Access enterprise applications and grant access through self-service requests with approval workflows.
- Configure [access reviews](/entra/id-governance/access-reviews-overview) so application owners regularly recertify who needs access.
- Use [lifecycle workflows](/entra/id-governance/what-are-lifecycle-workflows) to automatically remove access when users change roles or leave the organization.

This approach scales segmentation: instead of manually managing user and group assignments on each enterprise application, owners request access through packages and reviews keep assignments accurate over time.

### Continue monitoring

Regularly review Application Discovery to:

- Identify new applications that users are accessing through Quick Access.
- Detect changes in usage patterns that suggest new segmentation opportunities.
- Verify that segmented applications have the correct user assignments.

Over time, move more application segments out of Quick Access and into individually managed enterprise applications.

## Should you remove Quick Access entirely?

Quick Access isn't designed to be removed entirely after segmentation is complete. It's expected to remain in place even in mature deployments, for the following reasons:

- **Catch-all for unsegmented traffic** — Quick Access continues to serve traffic for resources you haven't segmented yet, including newly discovered applications surfaced by Application Discovery.
- **Private DNS host** — Private DNS suffixes are typically configured on Quick Access. Keeping Quick Access in place preserves consistent name resolution for users, even as individual applications are pulled into their own enterprise applications.
- **Recommended fallback segments** — Some application segments — for example, broad infrastructure ranges or services that aren't well-suited to per-app segmentation — are intentionally left in Quick Access.

When segmentation is mature, Quick Access typically retains:

- Private DNS configuration.
- Recommended infrastructure or fallback application segments.
- A user assignment that matches the population that still needs broad access (often a subset of the original VPN-replacement assignment, not all users).

Treat the goal as *minimizing* the scope of Quick Access — narrowing its assignments and segments — rather than removing it entirely.

## Related content

- [What is Microsoft Entra Private Access?](concept-private-access.md)
- [Configure Quick Access for Global Secure Access](how-to-configure-quick-access.md)
- [Configure per-app access to private resources](how-to-configure-per-app-access.md)
- [Application Discovery for Global Secure Access](how-to-application-discovery.md)
- [Private DNS for Global Secure Access](concept-private-name-resolution.md)
- [Apply Conditional Access to Private Access apps](how-to-target-resource-private-access-apps.md)
- [What is Microsoft Entra ID Governance?](/entra/id-governance/identity-governance-overview)

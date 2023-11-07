---
title: Learn about Microsoft Entra ID Health
description: Monitor the health of your tenant through several identity scenarios and authentication availability rates with Microsoft Entra ID Health
author: shlipsey3
manager: amycolannino
ms.service: active-directory
ms.topic: conceptual
ms.workload: identity
ms.subservice: report-monitor
ms.date: 11/07/2023
ms.author: sarahlipsey
ms.reviewer: sarbar

---

# Microsoft Entra ID Health

Microsoft Entra ID Health (preview) provides you with the ability to monitor and diagnose the health of your Microsoft Entra tenant through the following capabilities:

**Service level agreement (SLA) attainment**:

- Tenant-level monitoring and diagnostics for key Microsoft Entra ID scenarios.

**Scenario monitoring (preview)**:

- Proactive alerts when a potential issue or failure condition is detected.
- Reduce time to detection and support issue resolution.
- Actionable and prescriptive guidance for every alert.

Microsoft Entra ID Health consists of multiple layers, which allows you to navigate from a high-level overview to a deep dive into specific health data. This article describes how Microsoft ID Health works, along with details about each scenario.

## How to view Microsoft Entra ID Health

The SLA Attainment report is available for all Microsoft Entra ID tenants.

1. Sign into the [Microsoft Entra ID admin center] using the **Reports Reader** role.
1. Go to **Identity** > **Monitoring** > **Health (preview)**.

If you'd like to view the **Scenario monitoring (preview)**:

1. Select **Preview features**.
1. Set the **Scenario Monitoring** toggle to **On** and select **Apply**.

Enabling preview feature might take up to 24 hours to populate. Enabling the preview only changes your view, not the entire tenant. You can disable the preview at any time.

The Health landing page displays the Service Level Agreement (SLA) attainment, which is the user authentication availability for Microsoft Entra ID. The target SLA threshold is 99.99%.

## How it works

Many IT administrators spend a considerable amount of time investigating the following key scenarios:

- Interactive user sign-in requests that require Microsoft Entra multifactor authentication.
- User sign-in requests that require a managed or compliant device through a Conditional Access policy.
- User sign-in requests to applications using SAML authentication.

The data associated with each of these scenarios is aggregated into a view that's specific to that scenario. If you're only interested in sing-ins from compliant devices, you can dive into that scenario without noise from other sign-in activities.

At this time, data is aggregated every 15 minutes, so you're getting near real-time insights into your tenant's health. If there's an anomaly detected, an alert is generated. The alert provides you with diagnostic information and action steps to resolve the issue.

The scenarios available in Microsoft Entra ID Health are always available, even if there are no alerts.

## Tenant-level SLA (preview)

In addition to providing global SLA performance, Microsoft Entra ID now provides tenant-level SLA performance. This feature is currently in preview.

To access your tenant-level SLA performance:

1. Navigate to the [Microsoft Entra admin center](https://entra.microsoft.com) using the Reports Reader role (or higher).
1. Browse to **Identity** > **Monitoring & health** > **Scenario Health** from the side menu.
1. Select the **SLA Monitoring** tab.
1. Hover over the graph to see the SLA performance for that month.

The landing page displays the overall health of the available scenarios for your tenant. When all monitored scenarios are in a healthy state, a green checkmark appears at the top of the page with a "No alerts" message. Otherwise any alerts appear for you to investigate.

![Screenshot of the Health landing page with an alert highlighted.](media/concept-tenant-health/landing-page-alert.png)

You can navigate to scenario-specific pages to view additional information about current health signal data and trends over 30 days. All scenarios - with or without an alert - appear in the bottom half of the page. Select a link for a scenario to view the details and diagnostic guidance for troubleshooting and resolving the issue.

## Scenario details

Each scenario detail page provides trends and totals for that scenario for the last 30 days. Each scenario varies slightly in the information provided. Details are provided in the following sections.

### Sign-ins requiring multifactor authentication

This scenario provides two aggregated data graphs. The first displays the amount of users who successfully completed an interactive multifactor sign-in using an Microsoft Entra ID cloud multifactor service. The metric excludes any time a users freshes the session without completing the interactive multifactor authentication or using passwordless sign-in methods.

This scenario also provides an aggregated look at failures of interactive multifactor sign-in attempts. The same type of refreshed sessions and passwordless methods are excluded from this metric.

### Sign-ins requiring a managed device

This scenario captures each user authentication that satisfies a Conditional Access policy requiring sign-in from a managed device. The graph aggregates data every 15 minutes. You can set the date range to 24 hours, 7 days, or 1 month.

### Sign-ins requiring a compliant device

This scenario captures each user authentication that satisfies a Conditional Access policy requiring sign-in from a compliant device. The graph aggregates data every 15 minutes. You can set the date range to 24 hours, 7 days, or 1 month.


### Sign-ins to applications using SAML authentication

This scenario looks at SAML 2.0 authentication attempts that were successfully processed by the Microsoft Entra ID cloud service for your tenant. This metric currently excludes WS-FED/SAML 1.1 apps integrated with Microsoft Entra ID.

## Next steps
- [Learn about Microsoft Entra ID recommendations](overview-recommendations.md)
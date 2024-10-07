---
title: Learn about Microsoft Entra Health
description: Monitor the health of your tenant through several identity scenarios and authentication availability rates with Microsoft Entra Health
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: conceptual
ms.subservice: monitoring-health
ms.date: 10/07/2024
ms.author: sarahlipsey
ms.reviewer: sarbar

---

# What is Microsoft Entra Health?

Microsoft Entra Health (preview) provides you with observability of your Microsoft Entra tenant through continuous low-latency health monitoring and look-back reporting. The low-latency health monitoring solution includes a set of health metric data streams (signals) with built-in alerts designed to help IT operations teams maintain high levels of uptime and service on common Microsoft Entra scenarios. The monthly look-back solution shows the core authentication availability of Microsoft Entra ID each month.

## How Microsoft Entra health monitoring (preview) works

1. Metrics and data are gathered, processed, and converted into meaningful signals displayed in Microsoft Entra Health monitoring.

1. These signals are fed into our anomaly detection service.

1. When the anomaly detection service identifies a significant change to a pattern in the signal, it triggers an alert. 

1. When the alert is triggered, an email notification is sent to a set of users, preselected by the tenant admin. This email notification prompts recipients to investigate and determine if there's a problem.

1. After you see an alert, you need to research possible root causes, determine the next steps, and take action to mitigate the root cause. Each health alert contains an impact assessment and links to resources to help you through the process.

## Microsoft Entra Health monitoring signals

Many IT administrators spend a considerable amount of time investigating several key scenarios, such as sign-ins requiring multifactor authentication (MFA) or sign-ins requiring a compliant or managed device. Microsoft Entra Health provides a visualization of the data associated with these metrics, so you can quickly identify trends and potential issues.

The following key scenarios can be monitored in Microsoft Entra Health:

- Interactive user sign-in requests that require Microsoft Entra multifactor authentication (MFA).
- User sign-in requests that require a managed device through a Conditional Access policy.
- User sign-in requests that require a compliant device through a Conditional Access policy.
- User sign-in requests to applications using SAML authentication.

The data associated with each of these scenarios is aggregated into a view that's specific to that scenario. If you're only interested in sign-ins from compliant devices, you can dive into that scenario without noise from other sign-in activities. 

Each scenario detail page provides trends and totals for that scenario for the last 30 days. This data is aggregated every 15 minutes, for low latency insights into your tenant's health.

## Microsoft Entra Health monitoring alerts

In addition to providing health signals, Microsoft Entra Health monitoring also has an anomaly detection service that looks at the data and develops dynamic alerting thresholds based on the pattern specific to your tenant. When the service identifies a significant change to that pattern at the tenant level, it triggers an alert. By monitoring these scenarios and reviewing the alerts, you can more effectively monitor and improve the health of your tenant.

Alerts are specific to your tenant and to the scenario being monitored. Machine learning requires at least four weeks of data to establish a pattern for your tenant. The more data we collect on the signal, the more accurate the anomaly detection service becomes. The service looks back 25-30 minutes on the timeline and triggers an alert if the signal deviates from the pattern.

The service provides alerts for the following scenarios:

- [Sign-ins requiring a Conditional Access compliant device](scenario-health-sign-ins-compliant-managed-device.md)
- [Sign-ins requiring a Conditional Access managed device](scenario-health-sign-ins-compliant-managed-device.md)
- [Sign-ins requiring multifactor authentication (MFA)](scenario-health-sign-ins-mfa.md)

At this time, alerts are only available through the Microsoft Graph API. With the Microsoft Graph health monitoring alerts APIs, you can view the alerts, configure email notifications, and update the state of the alert. You can run the API calls on a recurring cadence (for example, daily or hourly) or configure email notifications. For more information, see [How to use Microsoft Entra scenario health alerts](howto-use-health-scenario-alerts.md) and the [Microsoft Graph health monitoring alerts API documentation](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).

## SLA attainment

In addition to publicly reporting global SLA performance, Microsoft Entra ID provides tenant-level SLA performance for organizations with at least 5000 monthly active users. The Service Level Agreement (SLA) attainment is the user authentication availability for Microsoft Entra ID. For the current availability target and details on how SLA is calculated, see [SLA for Microsoft Entra ID](https://azure.microsoft.com/support/legal/sla/active-directory/v1_1/).

Hover your mouse over the bar for a month to view the percentage for that month. A table with the same details appears below the graph.

You can also view SLA attainment using [Microsoft Graph](/graph/api/resources/serviceactivity?view=graph-rest-beta&preserve-view=true).

![Screenshot of the SLA attainment report.](media/concept-microsoft-entra-health/sla-attainment.png)
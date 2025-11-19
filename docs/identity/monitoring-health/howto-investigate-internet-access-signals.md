---
title: How to investigate the internet applications blocked by Entra Internet Access policy
description: Learn how to monitor and investigate scenarios where internet applications are blocked by Microsoft Entra Internet Access policies, using Microsoft Entra Health monitoring tools.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 11/18/2025
ms.author: jfields
ms.reviewer: gauthamca

# Customer intent: As an IT admin, I want to learn how to monitor and investigate scenarios where internet applications are blocked by Microsoft Entra Internet Access policies, using Microsoft Entra Health monitoring tools.
---

# Investigate the internet applications blocked by Entra Internet Access policy

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor and alerts when a potential issue or failure condition is detected. There are multiple health scenarios that can be monitored, including internet applications blocked by Microsoft Entra Internet Access policy.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](/entra/identity/monitoring-health/concept-microsoft-entra-health)

- [How to use Microsoft Entra health monitoring signals and alerts](/entra/identity/monitoring-health/howto-use-health-scenario-alerts)

This article describes the health metrics related to internet applications blocked by Microsoft Entra Internet Access policies and how to troubleshoot a potential issue when you receive an alert.

This scenario:

- Aggregates the number of unique users accessing internet applications successfully

- Aggregates the number of unique users who failed to access internet applications.

- Aggregates the number of unique internet applications accessed successfully

- Aggregates the number of failed accesses to unique internet applications.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](/entra/fundamentals/get-started-premium) is required to *view* the Microsoft Entra health scenario monitoring signals.

- A tenant with Microsoft Entra Internet Access license is required. For details, see the licensing section of [What is Global Secure Access?](/entra/global-secure-access/overview-what-is-global-secure-access)

- The [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) role is the least privileged role required to *view scenario monitoring signals.*

- The HealthMonitoringAlert.Read.All permission is required to *view the alerts using the Microsoft Graph API*.

- For a full list of roles, see [Least privileged role by task](/entra/identity/role-based-access-control/delegate-by-task#monitoring-and-health---audit-and-sign-in-logs).

- The [Global Secure Access Log Reader](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-log-reader) role of viewing the traffic logs in Microsoft Entra Internet Access and Microsoft Entra Private Access.

## Investigate the signal

To investigate a signal, gather the following data:

1.  View the details of the alert.

    - In the Microsoft Entra admin center, review the metrics and details of the affected entities. For more information, see [Investigate the alert and signals](/entra/identity/monitoring-health/howto-use-health-scenario-alerts#investigate-the-alert-and-signals).

    <!-- -->

    - For Microsoft Graph guidance, see [Microsoft Graph health monitoring overview](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).

2.  Sign into the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Reports Reader](https://github.com/MicrosoftDocs/entra-docs/blob/c5d27bbda734933549480ccf46deffbeeed01bc7/docs/identity/role-based-access-control/permissions-reference.md#reports-reader).

    - Browse to **Entra ID** \> **Monitoring & health** \> **Health**. The page opens to the Service Level Agreement (SLA) Attainment page.

    - Select the **Health Monitoring** tab.

    - Select the **Internet applications blocked by Entra Internet Access Policy** scenario.

        :::image type="content" source="media/howto-investigate-internet-access-signals/internet-access-blocked.png" alt-text="Screenshot showing the Internet applications blocked by Entra Internet Access Policy scenario in the health monitoring dashboard." lightbox="media/howto-investigate-internet-access-signals/internet-access-blocked.png":::

3.  Review your Microsoft Entra Internet Access content filtering policies. For more information, see [How to configure Global Secure Access web content filtering - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/how-to-configure-web-content-filtering).

4.  Review Microsoft Entra Internet Access forwarding profile for access policies and user assignments. For more information, see [How to manage the Internet Access profile - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/how-to-manage-internet-access-profile).

5.  Review sign-in logs. For more information, see [Learn about the sign-in log activity details](/entra/identity/monitoring-health/concept-sign-in-log-activity-details). Look for users being blocked from signing in and have a Use Global Secure Access security profile.

6.  Review traffic logs. For more information, see [Global Secure Access network traffic logs - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/how-to-view-traffic-logs).

7.  Review audit logs. For more information, see [How to access Global Secure Access audit logs (preview) - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/how-to-access-audit-logs).

## Related content

- [Troubleshoot application access - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/troubleshoot-app-access)

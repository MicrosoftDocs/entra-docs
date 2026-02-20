---
title: How to investigate private application access requiring Microsoft Entra Private Access connector
description: Learn how to monitor and troubleshoot private application access scenarios that require the Microsoft Entra Private Access connector, using Microsoft Entra Health monitoring tools.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 11/18/2025
ms.author: jfields
ms.reviewer: gauthamca

# Customer intent: As an IT admin, I want to learn how to monitor and troubleshoot private application access scenarios that require the Microsoft Entra Private Access connector, using Microsoft Entra Health monitoring tools.
---

# Investigate private application access requiring Microsoft Entra Private Access connector

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor and alerts when a potential issue or failure condition is detected. There are multiple health scenarios that can be monitored, including private application access requiring availability of a Microsoft Entra Private Access connector.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](/entra/identity/monitoring-health/concept-microsoft-entra-health)

- [How to use Microsoft Entra health monitoring signals and alerts](/entra/identity/monitoring-health/howto-use-health-scenario-alerts)

This article describes the health metrics related to private application access requiring Microsoft Entra Private Access connector and how to troubleshoot a potential issue when you receive an alert.

This scenario:

- Aggregates the number of unique users accessing private applications successfully.

- Aggregates the number of unique users who failed to access private applications due to connector availability.

- Aggregates the number of unique private applications accessed successfully.

- Aggregates the number of failed accesses to unique private applications due to connector availability.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](/entra/fundamentals/get-started-premium) is required to *view* the Microsoft Entra health scenario monitoring signals.

- A tenant with Microsoft Entra Internet Access license is required. For details, see the licensing section of [What is Global Secure Access?](/entra/global-secure-access/overview-what-is-global-secure-access).

- The [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) role is the least privileged role required to *view scenario monitoring signals.*

- The HealthMonitoringAlert.Read.All permission is required to *view the alerts using the Microsoft Graph API*.

- For a full list of roles, see [Least privileged role by task](/entra/identity/role-based-access-control/delegate-by-task#monitoring-and-health---audit-and-sign-in-logs).

- The [Global Secure Access Log Reader](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-log-reader) role of viewing the traffic logs in Microsoft Entra Internet Access and Microsoft Entra Private Access.

## Investigate the signals

To investigate a signal, gather the following data:

1.  View the details of the alert.

    - In the Microsoft Entra admin center, review the metrics and details of the affected entities. For more information, see [Investigate the alert and signals](/entra/identity/monitoring-health/howto-use-health-scenario-alerts#investigate-the-alert-and-signals).

    <!-- -->

    - For Microsoft Graph guidance, see [Microsoft Graph health monitoring overview](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).

2.  Sign into the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Reports Reader](https://github.com/MicrosoftDocs/entra-docs/blob/c5d27bbda734933549480ccf46deffbeeed01bc7/docs/identity/role-based-access-control/permissions-reference.md#reports-reader).

    - Browse to **Entra ID** \> **Monitoring & health** \> **Health**. The page opens to the Service Level Agreement (SLA) Attainment page.

    - Select the **Health Monitoring** tab.

    - Select the **Private application access requiring Microsoft Entra Private Access connector** scenario.

3.  Review your Microsoft Entra Private Access connector status.
    - See [Microsoft Entra private network connectors maintenance](/entra/global-secure-access/concept-connectors#maintenance)

4.  Review Microsoft Entra Private Access connector groups and its assignments to the applications.

    - [Microsoft Entra Private Network Connector Groups - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/concept-connector-groups)

5.  Review sign-in logs.

    - [Learn about the sign-in log activity details](/entra/identity/monitoring-health/concept-sign-in-log-activity-details)

    - Look for users being blocked from signing in to the application.

6.  Review traffic logs.

    - [Global Secure Access network traffic logs - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/how-to-view-traffic-logs)

    - Look for private application traffic transaction failures.

7.  Review audit logs.

    - [How to access Global Secure Access audit logs (preview) - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/how-to-access-audit-logs)

Related content

- [Troubleshoot problems installing the Microsoft Entra private network connector - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/troubleshoot-connectors)

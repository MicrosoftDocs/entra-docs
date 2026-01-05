---
title: How to investigate the Global Secure Access remote network connectivity
description: Learn how to monitor and troubleshoot remote network connectivity using Microsoft Entra Health monitoring.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 11/18/2025
ms.author: jfields
ms.reviewer: gauthamca

# Customer intent: As an IT admin, I want to learn how to monitor and troubleshoot remote network connectivity using Microsoft Entra Health monitoring.
---

# Investigate the Global Secure Access remote network connectivity

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor and alerts when a potential issue or failure condition is detected. There are multiple health scenarios that can be monitored, including Global Secure Access remote network connectivity.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](/entra/identity/monitoring-health/concept-microsoft-entra-health)

- [How to use Microsoft Entra health monitoring signals and alerts](/entra/identity/monitoring-health/howto-use-health-scenario-alerts)

This article describes the health metrics related to remote network connectivity and provides steps to troubleshoot potential problems.
 
This article covers two scenarios:

- Global Secure Access requiring remote network tunnel connectivity
    - Presents data showing the number of remote network tunnels that are connected.
    - Presents data showing the number of remote network tunnels that are disconnected.
- Global Secure Access requiring remote network BGP connectivity
    - Presents data showing the number of remote networks with BGP connected.
    - Presents data showing the number of remote networks with BGP disconnected.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and to configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](/entra/fundamentals/get-started-premium) is required to *view* the Microsoft Entra health scenario monitoring signals

- A tenant with Microsoft Entra Global Secure Access license is required. For details, see the licensing section of [What is Global Secure Access?](/entra/global-secure-access/overview-what-is-global-secure-access)
    
- The [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) role is the least privileged role required to *view scenario monitoring signals.*

- The HealthMonitoringAlert.Read.All permission is required to *view the alerts using the Microsoft Graph API*.

- For a full list of roles, see [Least privileged role by task](/entra/identity/role-based-access-control/delegate-by-task#monitoring-and-health---audit-and-sign-in-logs).

- You must be assigned the [Global Secure Access Administrator](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-administrator), or [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator) role to access remote network logs.

## Investigate the signals

To investigate a signal, gather the following data:

1.  View the details of the alert.

    - In the [Microsoft Entra admin center](https://entra.microsoft.com/), review the metrics and details of the affected entities. For more information, see [Investigate the alert and signals](/entra/identity/monitoring-health/howto-use-health-scenario-alerts#investigate-the-alert-and-signals).

    <!-- -->

    - For Microsoft Graph guidance, see [Microsoft Graph health monitoring overview](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).

<!-- -->

2.  Sign into the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Reports Reader](https://github.com/MicrosoftDocs/entra-docs/blob/c5d27bbda734933549480ccf46deffbeeed01bc7/docs/identity/role-based-access-control/permissions-reference.md#reports-reader).

    - Browse to **Entra ID** \> **Monitoring & health** \> **Health**. The page opens to the Service Level Agreement (SLA) Attainment page.

    - Select the **Health Monitoring** tab.

    - Select the **Global Secure Access remote network connectivity** scenario.

3.  Review your Remote network health logs.

    - [How to use the remote network health logs - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/how-to-remote-network-health-logs?tabs=microsoft-entra-admin-center)

4.  Configure diagnostic settings to export logs.

    - [What are remote network health logs](/entra/global-secure-access/how-to-remote-network-health-logs?#configure-diagnostic-settings-to-export-logs)

5.  Analyze logs with a workbook.

    - [What are remote network health logs?](/entra/global-secure-access/how-to-remote-network-health-logs#analyze-logs-with-a-workbook)

6.  Review audit logs.

    - [How to access Global Secure Access audit logs (preview) - Global Secure Access \| Microsoft Learn](/entra/global-secure-access/how-to-access-audit-logs)

Related content

- [Understand remote network connectivity](/entra/global-secure-access/concept-remote-network-connectivity)

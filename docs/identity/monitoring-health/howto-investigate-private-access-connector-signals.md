---
title: How to investigate private application access requiring Microsoft Entra Private Access connector
description: Learn how to monitor and troubleshoot private application access scenarios that require the Microsoft Entra Private Access connector, using Microsoft Entra Health monitoring tools.
ms.topic: how-to
ms.date: 09/14/2026
ms.reviewer: gauthamca
ai-usage: ai-assisted

# Customer intent: As an IT admin, I want to learn how to monitor and troubleshoot private application access scenarios that require the Microsoft Entra Private Access connector, using Microsoft Entra Health monitoring tools.
---

# Investigate private application access requiring Microsoft Entra Private Access connector

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor and alerts when a potential issue or failure condition is detected. There are multiple health scenarios that can be monitored, including private application access requiring availability of a Microsoft Entra Private Access connector.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](/entra/identity/monitoring-health/concept-microsoft-entra-health)

- [How to investigate Microsoft Entra health monitoring signals and alerts](/entra/identity/monitoring-health/howto-investigate-health-scenario-alerts)

This article describes the health metrics related to private application access requiring Microsoft Entra Private Access connector and how to troubleshoot a potential issue when you receive an alert.

This scenario:

- Aggregates the number of unique users accessing private applications successfully.

- Aggregates the number of unique users who failed to access private applications due to connector availability.

- Aggregates the number of unique private applications accessed successfully.

- Aggregates the number of failed accesses to unique private applications due to connector availability.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](/entra/fundamentals/get-started-premium) is required to *view* the Microsoft Entra health scenario monitoring signals.
- A tenant with both a non-trial [Microsoft Entra P1 or P2 license](/entra/fundamentals/get-started-premium) *and* at least 100 monthly active users is required to *view alerts* and *receive alert notifications*.

- A tenant with a Microsoft Entra Private Access license is required. For details, see the licensing section of [What is Global Secure Access?](/entra/global-secure-access/overview-what-is-global-secure-access).

- The [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) role is the least privileged role required to *view scenario monitoring signals, alerts, and alert configurations*.

- The [Helpdesk Administrator](/entra/identity/role-based-access-control/permissions-reference#helpdesk-administrator) is the least privileged role required to *update alerts* and *update alert notification configurations*.

- The `HealthMonitoringAlert.Read.All` permission is required to *view the alerts using the Microsoft Graph API*.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to *view and modify the alerts using the Microsoft Graph API*.

- For a full list of roles, see [Least privileged role by task](/entra/identity/role-based-access-control/delegate-by-task#microsoft-entra-health-least-privileged-roles).

- The [Global Secure Access Log Reader](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-log-reader) role is required to view Microsoft Entra Private Access traffic logs.

## Investigate the signal and alert

Start your investigation by comparing the alert timeframe, signal trend, and affected entities. Then correlate the affected users and applications with connector status and logs.

1. View the details of the alert.

    - In the Microsoft Entra admin center, review the signal graph, alert timeframe, and affected entities. For more information, see [Investigate the signals and alerts](howto-investigate-health-scenario-alerts.md#investigate-the-signals-and-alerts).
    - For Microsoft Graph guidance, see [Microsoft Graph health monitoring overview](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader).

1. Browse to **Entra ID** > **Monitoring & health** > **Health**. The page opens to the Service Level Agreement (SLA) Attainment page.

1. Select the **Health Monitoring** tab.

1. Select the **Private application access requiring Microsoft Entra Private Access connector** scenario, and then select an active alert.

    :::image type="content" source="media/howto-investigate-private-access-connector-signals/private-access-alert.png" alt-text="Screenshot of the Private application access requiring Microsoft Entra Private Access connector scenario with one active alert." lightbox="media/howto-investigate-private-access-connector-signals/private-access-alert.png":::

1. Review your Microsoft Entra Private Access connector status. Confirm that the connector and updater services are running. For more information, see [Microsoft Entra private network connector maintenance](/entra/global-secure-access/concept-connectors#maintenance).

1. Review the connector groups and their application assignments. Confirm that each affected application is assigned to a group with healthy connectors. For more information, see [Microsoft Entra private network connector groups](/entra/global-secure-access/concept-connector-groups).

1. Review the [sign-in logs](/entra/identity/monitoring-health/concept-sign-in-log-activity-details). Look for affected users who are blocked from signing in to the application.

1. Review the [Global Secure Access traffic logs](/entra/global-secure-access/how-to-view-traffic-logs). Filter the logs to the alert timeframe and affected user or application, and look for private application transaction failures.

1. Review the [Global Secure Access audit logs](/entra/global-secure-access/how-to-access-audit-logs) for recent connector group or application assignment changes.

    :::image type="content" source="media/howto-investigate-private-access-connector-signals/global-secure-access-audit-logs.png" alt-text="Screenshot of audit logs filtered to the Global Secure Access service." lightbox="media/howto-investigate-private-access-connector-signals/global-secure-access-audit-logs.png":::

## Understand the signal

An alert can indicate a change in the number of users or private applications that fail to connect because a connector isn't available.

- A spike can indicate that one or more connectors became unavailable, a connector group lost capacity, or an application was assigned to the wrong connector group.
- A dip can indicate that connector availability recovered. It can also indicate that traffic or application assignments changed.

Compare the alert start time with connector status, connector event logs, audit logs, and planned maintenance before you change the configuration.

## Mitigate common issues

The following common issues can cause this alert. This list isn't exhaustive, but it provides a starting point for your investigation.

### A connector is inactive or unavailable

A connector service might be stopped, its trust certificate might be expired, or the connector host might be unable to reach the Microsoft Entra service.

To investigate and mitigate the issue:

1. In the alert, identify the affected users and private applications and note the alert start time.
1. Browse to **Global Secure Access** > **Connect** > **Connectors**, and identify inactive connectors in the connector group that serves the affected applications.
1. On each affected connector server, confirm that the connector and updater services are running.
1. Run the Connector Diagnostics tool to check certificate validity, ports 80 and 443, outbound proxy configuration, certificate revocation list access, service state, and back-end endpoint access.
1. Review the connector **Admin** event log for service, trust certificate, registration, or connectivity errors.
1. Restore the connector service or connectivity. If the trust certificate expired, reregister or reinstall the connector by following [Troubleshoot private network connectors](/entra/global-secure-access/troubleshoot-connectors).
1. Confirm that the connector becomes active and that new traffic log entries no longer show connector-related transaction failures.

### An application is assigned to the wrong connector group

The assigned connector group might not contain a healthy connector that can reach the affected application's network.

To investigate and mitigate the issue:

1. In the alert, identify whether failures are concentrated on one or more applications.
1. Review each affected application's connector group assignment.
1. Confirm that the assigned group contains active connectors in a network that can reach the application's destination.
1. Review the audit logs for a connector group or application assignment change near the alert start time.
1. Restore the intended assignment, or add healthy connectors that can reach the application to the assigned group.
1. Test access and confirm recovery in the traffic logs and health signal.

### A connector group has insufficient capacity or resilience

A connector group with a single connector, sustained high utilization, or poor connectivity to the service or back-end applications can cause intermittent failures.

To investigate and mitigate the issue:

1. Check whether the connector group has at least two active connectors for high availability.
1. Review connector host CPU and network utilization. Keep sustained CPU and memory utilization below the documented thresholds.
1. From each connector server, test connectivity to the affected back-end application.
1. If a connector host is unavailable, remove it from active service and add a healthy or backup connector to the group.
1. If utilization is sustained, add connectors or increase host capacity. For sizing and performance guidance, see [Microsoft Entra private network connectors](/entra/global-secure-access/concept-connectors#performance-and-scalability).
1. Confirm that failures stop and the signal returns to its expected range.

## Related content

- [Troubleshoot private network connectors](/entra/global-secure-access/troubleshoot-connectors)
- [Microsoft Entra private network connectors](/entra/global-secure-access/concept-connectors)
- [Microsoft Entra private network connector groups](/entra/global-secure-access/concept-connector-groups)

# How to investigate the remote networks requiring branch connectivity

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor and alerts when a potential issue or failure condition is detected. There are multiple health scenarios that can be monitored, including remote networks requiring branch connectivity.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](https://review.learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-microsoft-entra-health)

- [How to use Microsoft Entra health monitoring signals and alerts](https://review.learn.microsoft.com/en-us/entra/identity/monitoring-health/howto-use-health-scenario-alerts)

This article describes the health metrics related to remote networks requiring branch connectivity and how to troubleshoot a potential issue when you receive an alert.

This scenario:

- Aggregates the number of remote network branches that are connected

- Aggregates the number of remote network branches that are BGP connected

- Aggregates the number of branches disconnected due to tunnel being down

- Aggregates the number of branches disconnected due to BGP being down

## 

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](https://review.learn.microsoft.com/en-us/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](https://learn.microsoft.com/en-us/entra/fundamentals/get-started-premium) is required to *view* the Microsoft Entra health scenario monitoring signals.

- A tenant with both a [Microsoft Entra P1 or P2 license](https://learn.microsoft.com/en-us/entra/fundamentals/get-started-premium) *and* at least 100 monthly active users is required to *view alerts* and *receive alert notifications*.

- A tenant with Microsoft Entra Global Secure Access license is required. For details, see the licensing section of [What is Global Secure Access?](https://learn.microsoft.com/en-us/entra/global-secure-access/overview-what-is-global-secure-access).

- The [Reports Reader](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#reports-reader) role is the least privileged role required to *view scenario monitoring signals, alerts, and alert configurations*.

- The [Helpdesk Administrator](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#helpdesk-administrator) is the least privileged role required to *update alerts* and *update alert notification configurations*.

- The HealthMonitoringAlert.Read.All permission is required to *view the alerts using the Microsoft Graph API*.

- The HealthMonitoringAlert.ReadWrite.All permission is required to *view and modify the alerts using the Microsoft Graph API*.

- For a full list of roles, see [Least privileged role by task](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/delegate-by-task#monitoring-and-health---audit-and-sign-in-logs).

- Administrators who interact with **Global Secure Access** features must have following role assignments,

  - The [Global Secure Access Administrator role](https://learn.microsoft.com/en-us/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.

  - The [Conditional Access Administrator](https://learn.microsoft.com/en-us/azure/active-directory/roles/permissions-reference#conditional-access-administrator) to create and interact with Conditional Access policies.

## Investigate the alert and signal

Investigating an alert starts with gathering data.

1.  View the details of the alert.

    - In the Microsoft Entra admin center, review the metrics and details of the affected entities. For more information, see [Investigate the alert and signals](https://review.learn.microsoft.com/en-us/entra/identity/monitoring-health/howto-use-health-scenario-alerts#investigate-the-alert-and-signals).

    <!-- -->

    - For Microsoft Graph guidance, see [Microsoft Graph health monitoring overview](https://review.learn.microsoft.com/en-us/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).

2.  Review your Remote network health logs

    - [How to use the remote network health logs - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-remote-network-health-logs?tabs=microsoft-entra-admin-center)

3.  Configure diagnostic settings to expport logs

    - <https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-remote-network-health-logs?tabs=microsoft-entra-admin-center#configure-diagnostic-settings-to-export-logs>

4.  Analyze logs with a workbook

    - https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-remote-network-health-logs?tabs=microsoft-entra-admin-center#analyze-logs-with-a-workbook

5.  Review audit logs.

    - [How to access Global Secure Access audit logs (preview) - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-access-audit-logs)

## Mitigate common issues

The following common issues could cause remote networks requiring branch connectivity issues.

This list isn't exhaustive, but provides a starting point for your investigation.

### Remote network branch is down

If a large group of users are blocked from accessing applications over remote networks, a spike could indicate that these users are blocked due to the branch connectivity. This could be due to the tunnel being down or the BGP is down.

To investigate:

- Check your status of the branches

  - https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-remote-network-health-logs?tabs=microsoft-entra-admin-center#view-the-logs

Related content

- ?

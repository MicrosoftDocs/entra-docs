# How to investigate the Internet Applications Blocked by Entra Internet Access Policy

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor and alerts when a potential issue or failure condition is detected. There are multiple health scenarios that can be monitored, including internet applications blocked by Microsoft Entra Internet Access policy.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](https://review.learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-microsoft-entra-health)

- [How to use Microsoft Entra health monitoring signals and alerts](https://review.learn.microsoft.com/en-us/entra/identity/monitoring-health/howto-use-health-scenario-alerts)

This article describes the health metrics related to internet applications blocked by Microsoft Entra Internet Access policies and how to troubleshoot a potential issue when you receive an alert.

This scenario:

- Aggregates the number of users accessing internet applications successfully

- Aggregates the number of users who failied to access internet applications.

- Aggregates the number of internet applications accessed successfully

- Aggregates the number of failied accesses to internet applications.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](https://review.learn.microsoft.com/en-us/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](https://learn.microsoft.com/en-us/entra/fundamentals/get-started-premium) is required to *view* the Microsoft Entra health scenario monitoring signals.

- A tenant with both a [Microsoft Entra P1 or P2 license](https://learn.microsoft.com/en-us/entra/fundamentals/get-started-premium) *and* at least 100 monthly active users is required to *view alerts* and *receive alert notifications*.

- A tenant with Microsoft Entra Internet Access license is required. For details, see the licensing section of [What is Global Secure Access?](https://learn.microsoft.com/en-us/entra/global-secure-access/overview-what-is-global-secure-access).

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

2.  Review your Microsoft Entra Internet Access content filtering policies.

    - [How to configure Global Secure Access web content filtering - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-configure-web-content-filtering)

3.  Review Microsoft Entra Internet Access forwarding profile for access policies and user assignments

    - [How to manage the Internet Access profile - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-manage-internet-access-profile)

4.  Review sign-in logs.

    - <https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-in-log-activity-details>

    - Look for users being blocked from signing in *and* have a Use Global Secure Access security profile

5.  Review traffic logs.

    - [Global Secure Access network traffic logs - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-view-traffic-logs)

6.  Review audit logs.

    - [How to access Global Secure Access audit logs (preview) - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-access-audit-logs)

## Mitigate common issues

The following common issues could cause internet applications to be blocked by Microsoft Entra Internet Access policy.

This list isn't exhaustive, but provides a starting point for your investigation.

### Content filtering policy issue

If a large group of users are blocked from accessing an internet application, a spike could indicate that these users are blocked by the content filtering policy.

To investigate:

- Check your current content filtering policy for these users - [How to configure Global Secure Access web content filtering - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-configure-web-content-filtering)

### User assignment issue

If a large group of users are blocked from accessing an internet application and Entra Internet Access is configured to allow access to the application, a spike could indicate user assignment issues in the forwarding profile or the conditional access.

To investigate:

- Check the current user assignments for forwarding profile

  - [How to manage the Internet Access profile - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-manage-internet-access-profile)

## Related content

- [Troubleshoot application access - Global Secure Access \| Microsoft Learn](https://learn.microsoft.com/en-us/entra/global-secure-access/troubleshoot-app-access)

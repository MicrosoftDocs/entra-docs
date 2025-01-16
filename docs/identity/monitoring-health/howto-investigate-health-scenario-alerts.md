---
title: How to investigate Health monitoring alerts (preview)
description: Learn how to investigate Microsoft Entra health monitoring alerts to monitor and improve the health of your tenant.
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 01/16/2025
ms.author: sarahlipsey
ms.reviewer: sarbar

# Customer intent: As an IT admin, I want to learn how to use Microsoft Entra health monitoring to observe and improve the health of my tenant.
---

# How to investigate Microsoft Entra Health monitoring alerts (preview)

Microsoft Entra Health monitoring helps you monitor the health of your Microsoft Entra tenant through a set of health metrics and intelligent alerts. Health metrics are fed into our anomaly detection service, which uses machine learning to understand the patterns for your tenant. When the anomaly detection service identifies a significant change in one of the tenant-level patterns, it triggers an alert.

The signals and alerts provided by Microsoft Entra Health provide you with the starting point for investigating potential issues in your tenant. Because there's a wide range of scenarios and even more data points to consider, it's important to understand how to investigate these alerts effectively. This article provides guidance on how to investigate an alert, but isn't specific to any alert.

> [!IMPORTANT]
> Microsoft Entra Health scenario monitoring and alerts are currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](../../fundamentals/get-started-premium.md) is required to *view* the Microsoft Entra health scenario monitoring signals.
- A tenant with both a [Microsoft Entra P1 or P2 license](../../fundamentals/get-started-premium.md) *and* at least 100 monthly active users is required to *view alerts* and *receive alert notifications*.
- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role required to *view scenario monitoring signals, alerts, and alert configurations*.
- The [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator) is the least privileged role required to *update alerts* and *update alert notification configurations*.
- The `HealthMonitoringAlert.Read.All` permission is required to *view the alerts using the Microsoft Graph API*.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to *view and modify the alerts using the Microsoft Graph API*.
- For a full list of roles, see [Least privileged role by task](../role-based-access-control/delegate-by-task.md#monitoring-and-health---audit-and-sign-in-logs).
- Note: Newly onboarded tenants might not have enough data to generate alerts for about 30 days.

## Investigate the signals and alerts

You can view the Microsoft Entra Health monitoring signals from the Microsoft Entra admin center. You can also view the properties of the signals and the public preview of health monitoring alerts, using [Microsoft Graph APIs](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).

### [Admin center](#tab/admin-center)

The signals and alerts are available in the Microsoft Entra Health area of the Microsoft Entra admin center. Whether you're investigating an alert or just monitoring the health of your tenant, you can view the signals and alerts from the Microsoft Entra admin center.

#### View the signals

1. Sign into the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).

1. Browse to **Identity** > **Monitoring and health** > **Health**. The page opens to the Service Level Agreement (SLA) Attainment page.

1. Select the **Health Monitoring** tab.

    ![Screenshot of the Microsoft Entra Health landing page.](media/howto-investigate-health-scenario-alerts/health-monitoring-landing-page.png)

1. Select a scenario from the list. The page opens to the scenarios with active alerts, but if you want to view the signals for a different scenario, select the **All scenarios** filter button.

1. View the signal in the **View data graph** section. You might need to expand this section if you're viewing a scenario with an active alert.
    - The date range can be changed to view the last 24 hours, seven days, or previous month.
    - Hover your mouse over the graph to see the data points for a particular point in time.
    - The value at the bottom of the graph is the total count for that scenario for the selected time frame.

:::image type="content" source="media/howto-investigate-health-scenario-alerts/scenario-health-mfa-signal.png" alt-text="Screenshot of the sign-ins requiring multifactor authentication (MFA) scenario." lightbox="media/howto-investigate-health-scenario-alerts/scenario-health-mfa-signal-expanded.png":::

#### Investigate the alerts

When you receive an alert, you typically need to investigate the following data sets:

- **Affected entities**: Total number of identities identified by the alert. Include users, groups, service principals, devices, and applications. 
- **Metrics**: The data stream, or health signal, that caused the alert. 
- **Sign-in logs**: A query is provided in the response for further investigation into the sign-in logs where the health signal was generated. The sign-in logs provide detailed event metadata that might be used to identify a problem's root cause.
- **Scenario-specific resources**: Depending on the scenario, you might need to investigate Intune compliance policies or Conditional Access policies. In many cases, a link to related documentation is provided in the response.

To view these details from the **Health monitoring** landing page: 

1. Select the active alert you want to investigate.

    ![Screenshot of the Health monitoring page with active alert scenarios.](media/howto-investigate-health-scenario-alerts/scenario-health-active-alert.png)

1. From the **Affected entities** section of the selected scenario, select **View** for the type of affected entity you want to investigate.
    - Possible entities include users, groups, applications, devices, and service principals.
    
    :::image type="content" source="media/howto-investigate-health-scenario-alerts/scenario-health-active-alert-page.png" alt-text="Screenshot of the active alert page with the affected entities highlighted." lightbox="media/howto-investigate-health-scenario-alerts/scenario-health-active-alert-page-expanded.png":::

1. From the details that appear in the panel that opens, select an entity to explore further.

1. After investigating and potentially resolving the root cause of the issue, you can dismiss the alert. From the active alert page, select the checkbox for that alert then select the **Mark alert as** menu and select **Dismissed**.

    ![Screenshot of the alert page with the Mark alert as menu highlighted.](media/howto-investigate-health-scenario-alerts/mark-alert-as.png)

### [Microsoft Graph API](#tab/microsoft-graph-api)

With the Microsoft Graph APIs, you can view the metrics that make up the health signals and alerts and review the impact summary for a health alert. The `serviceActivity` resource gets the metrics that feed into the Microsoft Entra Health monitoring signals, which are visualized in the Microsoft Entra admin center. For more information, see [serviceActivity resource type](/graph/api/resources/serviceactivity?view=graph-rest-beta&preserve-view=true).

#### View the signals

1. Sign in to [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) as at least a [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator) and consent to the appropriate permissions.
1. Select **GET** as the HTTP method from the dropdown and set the API version to **beta**.
1. Run the following query to retrieve the multifactor authentication (MFA) sign-in success metrics during a specific interval:

  ```http
    GET https://graph.microsoft.com/beta/reports/serviceActivity/getMetricsForMfaSignInFailure(inclusiveIntervalStartDateTime=2023-01-01T00:00:00Z,exclusiveIntervalEndDateTime=2023-01-01T00:20:00Z,aggregationIntervalInMinutes=10)
    ```

<!-- Need to run Graph query to test and provide a sample response with realistic data -->


#### Investigate the alerts

When you receive an alert, or if you see a change to a pattern you suspect might need investigation, you typically need to investigate the following data sets:

- **Alert impact**: The portion of the response after `impacts` quantifies the scope and summarizes impacted resources. These details include the `impactCount` so you can determine how widespread the issue is.  
- **Alert signals**: The data stream, or health signal, that caused the alert. A query is provided in the response for further investigation.
- **Sign-in logs**: A query is provided in the response for further investigation into the sign-in logs where the health signal was generated. The sign-in logs provide detailed event metadata that might be used to identify a problem's root cause.
- **Scenario-specific resources**: Depending on the scenario, you might need to investigate Intune compliance policies or Conditional Access policies. In many cases, a link to related documentation is provided in the response.

1. Run the following query to retrieve all alerts for your tenant.

    ```http
    GET https://graph.microsoft.com/beta/reports/healthMonitoring/alerts
    ```

1. Locate and save the `id` of the alert you want to investigate.

1. Run the following query, using `id` as the `alertId`.

    ```http
    GET https://graph.microsoft.com/beta/reports/healthMonitoring/alerts/{alertId}
    ```
For sample requests and responses, see [Health monitoring List alert objects](/graph/api/healthmonitoring-healthmonitoringroot-list-alerts?view=graph-rest-beta&preserve-view=true).
- The portion of the response after `impacts` make up the impact summary for the alert.
- The `supportingData` portion includes the full query used to generate the alert.
- The results of the query include everything identified by the anomaly detection service, but there might be results that aren't directly related to the alert.

Running these queries provides the number of times that service activity occurred during a specific time frame. For example, to see the number of successful MFA sign-ins, you'd run the following query:

```http
GET https://graph.microsoft.com/beta/reports/serviceActivity/getMetricsForMfaSignInSuccess(inclusiveIntervalStartDateTime=2023-01-01T00:00:00Z,exclusiveIntervalEndDateTime=2023-01-01T00:20:00Z,aggregationIntervalInMinutes=10)
```

The response shows how many successful sign-ins occurred during the specific time frame, aggregated in ten-minute intervals.

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/beta/networkAccess/reports/$metadata#Collection(serviceActivityValueMetric)",
  "value": [
    {
      "intervalStartDateTime": "2023-01-10T00:00:00Z",
      "value": 4
    },
    {
      "intervalStartDateTime": "2023-01-10T00:10:00Z",
      "value": 5
    },
    {
      "intervalStartDateTime": "2023-01-10T00:20:00Z",
      "value": 4
    }
  ]
}
```

<!-- Need to add better examples of an alert and the data needed to actually investigate. -->


---


## Related content

- [Sign-ins requiring a compliant or managed device](scenario-health-sign-ins-compliant-managed-device.md)
- [Sign-ins requiring MFA](scenario-health-sign-ins-mfa.md)
- [Microsoft Graph Health monitoring alerts API documentation](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true)

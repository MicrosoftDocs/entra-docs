---
title: How to use Microsoft Entra scenario health alerts
description: Learn how to use the Microsoft Entra scenario health alerts to monitor and improve the health of your tenant.
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 09/10/2024
ms.author: sarahlipsey
ms.reviewer: sarbar

# Customer intent: As an IT admin, I want to learn how to use Microsoft Entra scenario health to monitor and improve the health of my tenant.
---

# How to use Microsoft Entra scenario health alerts

Microsoft Entra Health (preview) provides the ability to monitor the health of your Microsoft Entra tenant through a set of health metrics that are fed into our anomaly detection service. Machine learning is used understand the patterns for your tenant so when the anomaly detection service identifies a significant change to that pattern it triggers an alert. You can now receive alerts when a potential issue or failure condition is detected within the health scenarios.

## Prerequisites

To enable and receive scenario health alerts, you need:

- A tenant with a [Microsoft Entra P1 or P2 license](~/fundamentals/get-started-premium.md)
- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role needed to view tenant health monitoring.
- The [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role is needed to view and modify Conditional Access policies.
- The [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator) or [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator) role is required to configure Microsoft Graph alert notifications.
- The `HealthMonitoringAlert.Read.All` permission is required to view the alerts using the Microsoft Graph API.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to view and modify the alerts using the Microsoft Graph API.

## How it works

1. Metrics and data are gathered, processed, and converted into meaningful signals displayed in Microsoft Entra Health.

1. These signals are fed into our anomaly detection service.

1. When the anomaly detection service identifies a significant change to that pattern, it triggers an alert. 

1. An alert is sent by email to a pre-determined set of users when the anomaly detection service identifies a significant change to the pattern. 

After receiving an alert, you need to research possible root causes, determine the next steps, and take action to mitigate the root cause.

## Alerts and anomaly detection

With the [Microsoft Graph health monitoring API](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true), you can view the alerts, configure email notifications, and update the state of the alert. You can manually run the API calls daily or you can configure email notifications.

> [!NOTE]
> At this time, alerts are only available through the Microsoft Graph API.

We recommend sending alerts users with these roles:

- [Intune Administrator](../role-based-access-control/permissions-reference.md#intune-administrator)
- [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator)
- [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator)

To configure alert notifications, you need the ID of the group you want to receive the alerts AND the scenario alert ID.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator).
1. Browse to **Groups** > **All groups** > and select the group you want to receive the alerts.
1. Select **Properties** and copy the `Object ID` of the group. 
1. Sign in to [Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) and consent to the appropriate permissions.
1. Select **GET** as the HTTP method from the dropdown and set the API version to **beta**.
1. Use the following guidance to [configure email notifications for alerts](/graph/api/healthmonitoring-alertconfiguration-update?view=graph-rest-beta&preserve-view=true) using the API.
    - Enter the `Object ID` as the `groupId`.

## Gather data

You typically need to investigate the following data sets:

- Signal details from the API
- Impact summary from the alerts API
- Sign-in logs
- Scenario-specific resources

### View the signal and impact summary

In Microsoft Graph, add the following query to retrieve all alerts for your tenant.

```http
GET https://graph.microsoft.com/beta/reports/healthMonitoring/alerts
```

To view the impact summary for a specific alert, you need to save the `id` of the alert you want to investigate. Add the following query, using `id` as the `alertId`.

```http
GET https://graph.microsoft.com/beta/reports/healthMonitoring/alerts/{alertId}
```

- The portion of the response after `impacts` make up the impact summary for the alert.
- The `supportingData` portion includes the full query used to generate the alert.
- The results of the query include everything identified by the detection service, but there might be results that aren't directly related to the alert.
- We recommend pulling the API daily for regular monitoring of the alerts.

### View the sign-in logs

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
    - If you need to modify Conditional Access policies, you need the [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role.
1. Browse to **Monitoring & health** > **Sign-in logs**.
    - Adjust the time range to match the alert time frame.
    - Add a **filter** for Conditional Access.
    - Select a log entry to view the sign-in logs details and select the Conditional Access tab to see the policies that were applied.

## Analyze the possible root causes

Now that you've gathered all the data related to the scenario, you need to consider possible root causes and research potential solutions. Think about the seriousness of the alert. Are only a handful of users affected, or is it a widespread issue? Did a recent policy change have unintended consequences?

Each scenario has a set of root causes and solutions to consider. For details on each scenario, see the following articles:

- [Sign-ins requiring a compliant device](scenario-health-sign-ins-compliant-device.md)
- [Sign-ins requiring a managed device](scenario-health-sign-ins-managed-device.md)
- [Sign-ins requiring multifactor authentication (MFA)](scenario-health-sign-ins-mfa.md)

## Next steps

- [Troubleshoot sign-in problems with Conditional Access](../conditional-access/troubleshoot-conditional-access.md)
- [Use audit logs to troubleshoot Conditional Access policy changes](../conditional-access/troubleshoot-policy-changes-audit-log.md)

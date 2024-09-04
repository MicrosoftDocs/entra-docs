---
title: Scenario monitoring - sign-ins requiring a managed device
description: Learn about the Microsoft Entra Health signals and alerts for sign-ins that require a managed device
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 08/13/2024
ms.author: sarahlipsey
ms.reviewer: sarbar

# Customer intent: As an IT admin, I want to understand the health of my tenant through identity related signals and alerts so I can proactively address issues and maintain a healthy tenant.
---

# Sign-ins requiring a managed device

Microsoft Entra Health (preview) provides a set of health metrics you can monitor and receive alerts when a potential issue or failure condition is detected. Tenant health monitoring aggregates several health signals and alerts across different services and scenarios. This scenario captures each user authentication that satisfies a Conditional Access policy requiring sign-in from a managed device.


This article describes these health metrics and how to troubleshoot the issue when you receive an alert.

## Prerequisites

To view the Scenario monitoring dashboards, you need:

- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role needed to view tenant health monitoring.
- The [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role is needed to view and modify Conditional Access policies.
- A Microsoft Entra tenant with a [Premium P1 license](~/fundamentals/get-started-premium.md)
- The `HealthMonitoringAlert.Read.All` permission is required to view the alerts using the Microsoft Graph API.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to view and modify the alerts using the Microsoft Graph API.

## How it works

1. Metrics and data are gathered, processed, and converted into meaningful signals displayed in Microsoft Entra Tenant health monitoring.
    - This scenario captures each user authentication that satisfies a Conditional Access policy requiring sign-in from a managed device.
    - All the data is provided at the tenant level.

    ![Screenshot of the managed device scenario.](media/scenario-health-sign-ins-managed-device/scenario-monitoring-managed-device.png)

1. These signals are fed into our anomaly detection service, which uses machine learning to understand the patterns for your tenant.

1. When the anomaly detection service identifies a significant change to that pattern, such as a spike in sign-ins requiring a managed device, it triggers an alert. 
    - Anomaly specifics for the scenario
    - Define threshold

1. An alert is sent by email to the [tenant's important role] when the anomaly detection service identifies a significant change to the pattern of sign-ins requiring a compliant device. 

After receiving an alert, you need to research possible root causes, determine the next steps, and take action to mitigate the root cause.

## Gather data

For this scenario, there are three main data sets to investigate:

- The signal details from the API
- The impact summary from the alerts API
- Sign-in logs

Microsoft Entra tenant health monitoring can be viewed and managed using Microsoft Graph on the `/beta` endpoint. For more information, see the [Microsoft Graph documentation for Microsoft Entra health monitoring](/graph/api/resources/healthmonitoring-overview).

To get started, follow these instructions to work with tenant health monitoring using Microsoft Graph in Graph Explorer.

1. Sign in to [Graph Explorer](https://aka.ms/ge).
1. Select **GET** as the HTTP method from the dropdown.
1. Set the API version to **beta**.

### View the signal and impact summary

Add the following query to retrieve all alerts for your tenant, then select the **Run query** button.

```http
GET https://graph.microsoft.com/beta/reports/healthMonitoring/alerts
```

To view the impact summary for a specific alert, you need to save the `id` of the alert you want to investigate. Add the following query, using `id` as the `alertId`, then select the **Run query** button.

```http
GET https://graph.microsoft.com/beta/reports/healthMonitoring/alerts/{alertId}
```

Important details to note:

- The portion of the response after `impacts` make up the impact summary for the alert.
- The `supportingData` portion includes the full query used to generate the alert.
- Think about the seriousness of the alert. Are only a handful of users affected, or is it a widespread issue?
- The results of the query include everything identified by the detection service, but there might be results that aren't directly related to the alert.
- We recommend pulling the API daily for regular monitoring of the alerts.

## Research root causes in your tenant

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
    - If you need to modify Conditional Access policies, you need the [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role.
1. Analyze the sign-in logs.
    - Adjust the time range to match the alert time frame.
    - Add a **filter** for Conditional Access.
    - View the sign-in logs details and select the Conditional Access tab to see the policies that were applied.
1. Follow the guidance in the [Troubleshoot sign-in problems with Conditional Access]() article.
    - This article illustrates how to identify sign-in events related to Conditional Access policies and how to recognize common sign-in error codes.
1. Follow the guidance in the [Troubleshoot Conditional Access policy changes]() article.
    - This article explains how to check audit logs for signs of policy changes and to ensure the policy is working as intended.

## Next steps

- [What is device management](/mem/intune/fundamentals/what-is-device-management)?
- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access).
- [Learn about Microsoft Entra hybrid joined devices](../devices/concept-hybrid-join.md).
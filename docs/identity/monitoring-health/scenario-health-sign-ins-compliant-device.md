---
title: Scenario monitoring - sign-ins requiring a compliant device
description: Learn about the Microsoft Entra Health signals and alerts for sign-ins that require a compliant device
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

# Sign-ins requiring a compliant device

Microsoft Entra Health (preview) provides a set of health metrics you can monitor and receive alerts when a potential issue or failure condition is detected. Tenant health monitoring aggregates several health signals and alerts across different services and scenarios, such as sign-ins that require a compliant device.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](concept-microsoft-entra-health.md)
- [How to use Microsoft Entra scenario health monitoring and alerts](howto-use-health-scenario-alerts.md)

This article describes these health metrics and how to troubleshoot the issue when you receive an alert.

## Prerequisites

To view the Scenario monitoring dashboards and interact with the alerts, you need:

- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role needed to view tenant health monitoring.
- The [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role is needed to view and modify Conditional Access policies.
- A Microsoft Entra tenant with a [Premium P1 license](~/fundamentals/get-started-premium.md)
- The `HealthMonitoringAlert.Read.All` permission is required to view the alerts using the Microsoft Graph API.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to view and modify the alerts using the Microsoft Graph API.

## Scenario monitoring

Microsoft Entra health scenario monitoring provides a visualization of the related sign-in data. This data is aggregated every 15 minutes, for low latency insights into your tenant's health. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Monitoring & health** > **Health** **Scenario monitoring**.
1. Select **View details** on the **Sign-ins requiring a compliant device** tile to view the metrics and alerts for that scenario.
    - You can also view these metric streams using [Microsoft Graph](/graph/api//resources/serviceactivity?view=graph-rest-beta&preserve-view=true). 

Each scenario detail page provides trends and totals for that scenario for the last 30 days. You can set the date range to 24 hours, 7 days, or 1 month.

## Alerts and anomaly detection

When the anomaly detection service identifies a significant change to the sign-ins requiring compliant device pattern it triggers an alert. At this time, alerts are only available through the Microsoft Graph API. With Microsoft Graph you can view the alerts, configure email notifications, and update the state of the alert. For more information, see the following articles:

- [Microsoft Entra health monitoring Overview](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true)
- [Update alertConfiguration](/graph/api/healthmonitoring-alertconfiguration-update?view=graph-rest-beta&preserve-view=true)
    - We recommend sending alerts to users with these roles: [Intune Administrator](../role-based-access-control/permissions-reference.md#intune-administrator), [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator), and [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator), 

## Alert analysis and mitigation

Investigating an alert starts with gathering data.

1. Gather the signal details and impact summary from the [Microsoft Graph API](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).
1. Review your [Intune device compliance policies](/mem/intune/protect/compliance-policy-monitor).
    - If you're not using Intune, review your device management solution's compliance policies.
1. Investigate common issues with [Conditional Access device compliance](/troubleshoot/mem/intune/device-protection/troubleshoot-conditional-access#devices-appear-compliant-but-users-are-still-blocked).
1. Review the sign-in logs for users being blocked from signing in and have a compliant device [Conditional Access policy]((../conditional-access/troubleshoot-conditional-access.md)) applied.
1. Check the [audit logs for Conditional Access policy changes](../conditional-access/troubleshoot-policy-changes-audit-log.md).

## How to mitigate common issues

The following scenarios are common issues that could cause a spike in sign-ins requiring a compliant device. This list is not exhaustive, but provides a starting point for your investigation.

### Users are blocked from signing in from known devices

If your users are attempting to sign in from known devices, a spike in blocked sign-in attempts could indicate that the these devices have fallen out of compliance.

- Check your Intune compliant device policy.
- Check your Conditional Access compliant device policy.

### User is blocked from signing in from an unknown device

If the increase in blocked sign-ins is coming from an unknown device, that spike could indicate that an attacker has acquired a user's credentials and is attempting to sign in from a device used for such attacks.

- Review the sign-in logs for the user.
- [Investigate risk with Microsoft Entra ID Protection](../../id-protection/howto-identity-protection-investigate-risk.md).
    - Requires a Microsoft Entra ID P2 license.

## Next steps

- [Create a compliance policy in Microsoft Intune](/mem/intune/protect/create-compliance-policy).
- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access).
- [Learn about Microsoft Entra joined devices](../devices/concept-directory-join.md).
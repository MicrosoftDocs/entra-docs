---
title: Sign-ins requiring a compliant or managed device
description: Learn about the Microsoft Entra Health signals and alerts for sign-ins that require a compliant or managed device
author: shlipsey3
manager: pmwongera 
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 06/06/2025
ms.author: sarahlipsey
ms.reviewer: sarbar

# Customer intent: As an IT admin, I want to understand the health of my tenant through identity related signals and alerts so I can proactively address issues and maintain a healthy tenant.
---

# How to investigate the sign-ins requiring a compliant or managed device alert

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor and alerts when a potential issue or failure condition is detected. There are multiple health scenarios that can be monitored, including two related to devices:

- Sign-ins requiring a Conditional Access compliant device
- Sign-ins requiring a Conditional Access managed device

This article describes the health metrics related to compliant and managed devices and how to troubleshoot a potential issue when you receive an alert. For details on how to interact with the Health Monitoring scenarios and how to investigate all alerts, see [How to investigate health scenario alerts](../monitoring-health/howto-investigate-health-scenario-alerts.md).

> [!IMPORTANT]
> Microsoft Entra Health scenario monitoring and alerts are currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](../../fundamentals/get-started-premium.md) is required to *view* the Microsoft Entra health scenario monitoring signals.
- A tenant with both a non-trial [Microsoft Entra P1 or P2 license](../../fundamentals/get-started-premium.md) *and* at least 100 monthly active users is required to *view alerts* and *receive alert notifications*.
- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role required to *view scenario monitoring signals, alerts, and alert configurations*.
- The [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator) is the least privileged role required to *update alerts* and *update alert notification configurations*.
- The `HealthMonitoringAlert.Read.All` permission is required to *view the alerts using the Microsoft Graph API*.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to *view and modify the alerts using the Microsoft Graph API*.
- For a full list of roles, see [Least privileged role by task](../role-based-access-control/delegate-by-task.md#microsoft-entra-health-least-privileged-roles).

## Investigate the signals and alerts

Investigating an alert starts with gathering data. With Microsoft Entra Health in the Microsoft Entra admin center, you can view the signal and alert details in one place. You can also view the signals and alerts using the Microsoft Graph API. For more information, see [How to investigate health scenario alerts](../monitoring-health/howto-investigate-health-scenario-alerts.md) for guidance on how to gather data using the Microsoft Graph API. 

1. Sign into the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).

1. Browse to **Entra ID** > **Monitoring & health** > **Health**. The page opens to the Service Level Agreement (SLA) Attainment page.

1. Select the **Health Monitoring** tab.

1. Select the **Sign-ins requiring a compliant device** or **Sign-ins requiring a managed device** scenario and then select an active alert.

    :::image type="content" source="media/scenario-health-sign-ins-compliant-managed-device/health-monitoring-landing-page-compliant-device.png" alt-text="Screenshot of the Microsoft Entra Health landing page." lightbox="media/scenario-health-sign-ins-compliant-managed-device/health-monitoring-landing-page-compliant-device-expanded.png":::

1. View the signal from the **View data graph** section to get familiar with the pattern and identify anomalies.
    
    ![Screenshot of the sign-ins requiring managed device signal.](media/scenario-health-sign-ins-compliant-managed-device/health-monitoring-compliant-device-signal.png)

1. Review your Intune device compliance policies.
    - For more information, see [Intune device compliance overview](/mem/intune/protect/device-compliance-get-started).
    - Learn how to [Monitor device compliance policies](/mem/intune/protect/compliance-policy-monitor).
    - If you're not using Intune, review your device management solution's compliance policies.

1. Investigate common Conditional Access issues.
    - [Troubleshoot Conditional Access device compliance policies](/troubleshoot/mem/intune/device-protection/troubleshoot-conditional-access#devices-appear-compliant-but-users-are-still-blocked).
    - [Troubleshoot Conditional Access sign-in problems](../conditional-access/troubleshoot-conditional-access.md).

1. Review the sign-in logs.
    - [Review the sign-in log details](concept-sign-in-log-activity-details.md).
    - Look for users being blocked from signing in *and* have a compliant device policy applied.

1. Check the audit logs for recent policy changes.
    - [Use the audit logs to troubleshoot Conditional Access policy changes](../conditional-access/troubleshoot-policy-changes-audit-log.md).

## Mitigate common issues

The following common issues could cause a spike in sign-ins requiring a compliant or managed device. This list isn't exhaustive, but provides a starting point for your investigation.

### Many users are blocked from signing in from known devices

If a large group of users are blocked from signing in to known devices, a spike could indicate that these devices have fallen out of compliance. If the number of affected users indicates a high percentage of your organization's users, you might be looking at a widespread issue.
 
To investigate:

1. From the **Affected entities** section of the selected scenario, select **View** for users.
    - A sample of affected users appears in a panel. Select a user to navigate directly to their profile where you can view their sign-in activity and other details.
    - With the Microsoft Graph API, look for the "user" `resourceType` and the `impactedCount` value in the impact summary.

    ![Screenshot of the affected entities.](media/scenario-health-sign-ins-compliant-managed-device/affected-entities-example.png)

1. Check your [Intune device compliance policy](/mem/intune/protect/device-compliance-get-started).

1. Check your [Conditional Access device compliance policies](/troubleshoot/mem/intune/device-protection/troubleshoot-conditional-access#devices-appear-compliant-but-users-are-still-blocked).

### User is blocked from signing in from an unknown device

If the increase in blocked sign-ins is coming from an unknown device, that spike could indicate that an attacker has acquired a user's credentials and is attempting to sign in from a device used for such attacks. If the number of affected users shows a small subset of users, the issue might be user-specific.

To investigate:

1. From the **Affected entities** section of the selected scenario, select **View** for users.
    - A list of affected users appears in a panel. Select a user to navigate directly to their profile where you can view their sign-in activity and other details.
    - With the Microsoft Graph API, look for the "user" `resourceType` and the `impactedCount` value in the impact summary.
1. [Review the sign-in logs](../monitoring-health/concept-sign-in-log-activity-details.md).

1. [Investigate risk with Microsoft Entra ID Protection](../../id-protection/howto-identity-protection-investigate-risk.md).

> [!NOTE]
> Microsoft Entra ID Protection requires a Microsoft Entra P2 license.

### Network issues

There could be a regional system outage that required a large number of users to sign in at the same time.  

To investigate:

1. From the **Affected entities** section of the selected scenario, select **View** for users.
    - A list of affected users appears in a panel. Select a user to navigate directly to their profile where you can view their sign-in activity and other details.
    - With the Microsoft Graph API, look for the "user" `resourceType` and the `impactedCount` value in the impact summary.

1. Check your system and network health to see if an outage or update matches the same timeframe as the anomaly.

1. [Review the sign-in logs](../monitoring-health/concept-sign-in-log-activity-details.md).
    - Adjust your filter to show sign-ins from a region where an affected user is located.

1. If your organization is using Global Secure Access, review the [traffic logs](../../global-secure-access/how-to-view-traffic-logs.md).

## Related content

- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access)
- [Learn about Microsoft Entra hybrid joined devices](../devices/concept-hybrid-join.md)
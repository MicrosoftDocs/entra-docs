---
title: Sign-ins requiring a compliant or managed device
description: Learn about the Microsoft Entra Health signals and alerts for sign-ins that require a compliant or managed device
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

# How to investigate the sign-ins requiring a compliant or managed device alert

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor and alerts when a potential issue or failure condition is detected. There are multiple health scenarios that can be monitored, including two related to devices:

- Sign-ins requiring a Conditional Access compliant device
- Sign-ins requiring a Conditional Access managed device

These scenarios allow you to monitor and receive alerts on user authentication that satisfies a Conditional Access policy requiring signing in from a compliant or managed device. To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](concept-microsoft-entra-health.md)
- [How to use Microsoft Entra health monitoring signals and alerts](howto-use-health-scenario-alerts.md)

This article describes the health metrics related to compliant and managed devices and how to troubleshoot a potential issue when you receive an alert.

## Prerequisites

[!INCLUDE [Microsoft Entra health](../../includes/licensing-health.md)]

## Investigate the alert and signal

Investigating an alert starts with gathering data.

1. Gather the signal details and impact summary.
    - For more information, see [Microsoft Graph health monitoring overview](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).
    - Run the [List alerts](/graph/api/healthmonitoring-healthmonitoringroot-list-alerts?view=graph-rest-beta&preserve-view=true) API to retrieve all alerts for the tenant.
    - Run the [Get alert](/graph/api/healthmonitoring-alert-get?view=graph-rest-beta&preserve-view=true) API to retrieve the details of a specific alert.
1. Review your Intune device compliance policies.
    - For more information, see [Intune device compliance overview](/mem/intune/protect/device-compliance-get-started).
    - Learn how to [Monitor device compliance policies](/mem/intune/protect/compliance-policy-monitor).
    - If you're not using Intune, review your device management solution's compliance policies
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

If a large group of users are blocked from signing in to known devices, a spike could indicate that these devices have fallen out of compliance.

- Check your [Intune device compliance policy](/mem/intune/protect/device-compliance-get-started).
- Check your [Conditional Access device compliance policies](/troubleshoot/mem/intune/device-protection/troubleshoot-conditional-access#devices-appear-compliant-but-users-are-still-blocked).

### User is blocked from signing in from an unknown device

If the increase in blocked sign-ins is coming from an unknown device, that spike could indicate that an attacker has acquired a user's credentials and is attempting to sign in from a device used for such attacks.

- [Review the sign-in logs](../monitoring-health/concept-sign-in-log-activity-details.md).
- [Investigate risk with Microsoft Entra ID Protection](../../id-protection/howto-identity-protection-investigate-risk.md).
    - Note: Microsoft Entra ID Protection requires a Microsoft Entra P2 license.

## Next steps

- [Create a compliance policy in Microsoft Intune](/mem/intune/protect/create-compliance-policy)
- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access)
- [Learn about Microsoft Entra joined devices](../devices/concept-directory-join.md)
- [What is device management](/mem/intune/fundamentals/what-is-device-management)
- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access)
- [Learn about Microsoft Entra hybrid joined devices](../devices/concept-hybrid-join.md)
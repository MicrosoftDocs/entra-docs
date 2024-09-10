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

# How to investigate the sign-ins requiring a compliant device alert

Microsoft Entra Health (preview) provides a set of health metrics you can monitor and receive alerts when a potential issue or failure condition is detected. Tenant health monitoring aggregates several health signals and alerts across different services and scenarios. This scenario captures each user authentication that satisfies a Conditional Access policy requiring sign-in from a compliant device, such as a large increase in users being blocked.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](concept-microsoft-entra-health.md)
- [How to use Microsoft Entra scenario health monitoring and alerts](howto-use-health-scenario-alerts.md)

This article describes these health metrics and how to troubleshoot the issue when you receive an alert.

## Prerequisites

To view the Scenario monitoring dashboards and interact with the alerts, you need:

- A tenant with a [Microsoft Entra P1 or P2 license](~/fundamentals/get-started-premium.md)
- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role needed to view tenant health monitoring.
- The [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role is needed to view and modify Conditional Access policies.
- The `HealthMonitoringAlert.Read.All` permission is required to view the alerts using the Microsoft Graph API.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to view and modify the alerts using the Microsoft Graph API.

## Gather data

Investigating an alert starts with gathering data.

1. Gather the signal details and impact summary from the [Microsoft Graph API](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).
1. Review your [Intune device compliance policies](/mem/intune/protect/compliance-policy-monitor).
    - If you're not using Intune, review your device management solution's compliance policies.
1. Investigate common issues with [Conditional Access device compliance](/troubleshoot/mem/intune/device-protection/troubleshoot-conditional-access#devices-appear-compliant-but-users-are-still-blocked).
1. Review the sign-in logs for users being blocked from signing in and have a compliant device [Conditional Access policy](../conditional-access/troubleshoot-conditional-access.md) applied.
1. Check the [audit logs for Conditional Access policy changes](../conditional-access/troubleshoot-policy-changes-audit-log.md).

## Mitigate common issues

The following scenarios are common issues that could cause a spike in sign-ins requiring a compliant device. This list is not exhaustive, but provides a starting point for your investigation.

### Many users are blocked from signing in from known devices

If a large group of users are blocked from signing in from known devices, a spike could indicate that the these devices have fallen out of compliance.

- Check your Intune compliant device policy.
- Check your Conditional Access compliant device policy.

### User is blocked from signing in from an unknown device

If the increase in blocked sign-ins is coming from an unknown device, that spike could indicate that an attacker has acquired a user's credentials and is attempting to sign in from a device used for such attacks.

- Review the sign-in logs.
- [Investigate risk with Microsoft Entra ID Protection](../../id-protection/howto-identity-protection-investigate-risk.md).
    - Requires a Microsoft Entra ID P2 license.

## Next steps

- [Create a compliance policy in Microsoft Intune](/mem/intune/protect/create-compliance-policy).
- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access).
- [Learn about Microsoft Entra joined devices](../devices/concept-directory-join.md).
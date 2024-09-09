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

Microsoft Entra Health (preview) provides a set of health metrics you can monitor and receive alerts when a potential issue or failure condition is detected. Tenant health monitoring aggregates several health signals and alerts across different services and scenarios, such as sign-ins that require a managed device.

To learn more about how Microsoft Entra Health works, see:

- [What is Microsoft Entra Health?](concept-microsoft-entra-health.md)
- [How to use Microsoft Entra scenario health monitoring and alerts](howto-use-health-scenario-alerts.md)

This article describes these health metrics and how to troubleshoot the issue when you receive an alert.

## Prerequisites

To view the Scenario monitoring dashboards, you need:

- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role needed to view tenant health monitoring.
- The [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role is needed to view and modify Conditional Access policies.
- A Microsoft Entra tenant with a [Premium P1 license](~/fundamentals/get-started-premium.md)
- The `HealthMonitoringAlert.Read.All` permission is required to view the alerts using the Microsoft Graph API.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to view and modify the alerts using the Microsoft Graph API.

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

### User is blocked from signing in from an unknown device

If the increase in blocked sign-ins is coming from an unknown device, that spike could indicate that an attacker has acquired a user's credentials and is attempting to sign in from a device used for such attacks.

- Review the sign-in logs for the user.
- [Investigate risk with Microsoft Entra ID Protection](../../id-protection/howto-identity-protection-investigate-risk.md).
    - Requires a Microsoft Entra ID P2 license.


























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
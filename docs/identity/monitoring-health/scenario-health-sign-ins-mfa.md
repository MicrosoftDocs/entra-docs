---
title: Scenario monitoring - sign-ins requiring MFA
description: Learn about the Microsoft Entra Health signals and alerts for sign-ins that require a multifactor authentication
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

# How to investigate sign-ins requiring multifactor authentication

Microsoft Entra Health (preview) provides a set of health metrics you can monitor and receive alerts when a potential issue or failure condition is detected. Tenant health monitoring aggregates several health signals and alerts across different services and scenarios.

This scenario:

- Aggregates the number of users who successfully completed an MFA sign-in using a Microsoft Entra cloud MFA service.
- Captures interactive sign-ins with MFA, aggregating both successes and failures.
- Excludes when a user refreshes the session without completing the interactive MFA or using passwordless sign-in methods.

This article describes these health metrics and how to troubleshoot the issue when you receive an alert.

## Prerequisites

To view the Scenario monitoring dashboards, you need:

- A tenant with a [Microsoft Entra P1 or P2 license](~/fundamentals/get-started-premium.md)
- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role needed to view tenant health monitoring.
- The [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role is needed to view and modify Conditional Access policies.
- The `HealthMonitoringAlert.Read.All` permission is required to view the alerts using the Microsoft Graph API.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to view and modify the alerts using the Microsoft Graph API.

## Gather data

Investigating an alert starts with gathering data.

1. Gather the signal details and impact summary.
    - [Microsoft Graph health monitoring overview](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true)
1. Review the sign-in logs.
    - [Review the sign-in log details](concept-sign-in-log-activity-details.md)
    - Look for users being blocked from signing in *and* have a Conditional Access policy requiring MFA applied
1. Check the audit logs for recent policy changes.
    - [Use the audit logs to troubleshoot Conditional Access policy changes](../conditional-access/troubleshoot-policy-changes-audit-log.md)

## Mitigate common issues

The following scenarios are common issues that could cause a spike in sign-ins requiring a compliant device. This list is not exhaustive, but provides a starting point for your investigation.

### Increase in sign-ins requiring MFA

An increase in sign-ins requiring MFA could indicate a brute force attack, where multiple unauthorized sign-in attempts are made to a user's account. There could be a regional system outage that required a large number of users to sign in at the same time. A policy change or new feature rollout could also trigger a large number of users to sign in.

To investigate:

- Check the sign-in logs for failed MFA sign-in attempts.
    - Look for patterns like common IP address locations or multiple failed sign-ins from the same user.
- Use the [sign-in diagnostic](howto-use-sign-in-diagnostics.md) from the sign-in logs.
    - Rule out standard user error issues or initial MFA setup
    - 
- Check your system and network health to see if an outage or update matches the time frame as the anomaly.
- Check the audit logs for recent policy changes that could have triggered the spike.

## Next steps

- [Configure Conditional Access for MFA for all users](../conditional-access/howto-conditional-access-policy-all-users-mfa.md).
- [Troubleshoot common sign-in errors](howto-troubleshoot-sign-in-errors.md).
- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access).

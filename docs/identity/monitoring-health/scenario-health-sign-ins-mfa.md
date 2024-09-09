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

- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role needed to view tenant health monitoring.
- The [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role is needed to view and modify Conditional Access policies.
- A Microsoft Entra tenant with a [Premium P1 license](~/fundamentals/get-started-premium.md)
- The `HealthMonitoringAlert.Read.All` permission is required to view the alerts using the Microsoft Graph API.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to view and modify the alerts using the Microsoft Graph API.

## Gather data

Investigating an alert starts with gathering data.

1. Gather the signal details and impact summary from the [Microsoft Graph API](/graph/api/resources/healthmonitoring-overview?view=graph-rest-beta&preserve-view=true).

## Mitigate common issues

The following scenarios are common issues that could cause a spike in sign-ins requiring a compliant device. This list is not exhaustive, but provides a starting point for your investigation.

### Users are blocked from signing in from known devices

If your users are attempting to sign in from known devices, a spike in blocked sign-in attempts could indicate that the these devices have fallen out of compliance.

- Check your Intune compliant device policy.
- Check your Conditional Access compliant device policy.

## Next steps

- [Configure Conditional Access for MFA for all users](../conditional-access/howto-conditional-access-policy-all-users-mfa.md).
- [Troubleshoot common sign-in errors](howto-troubleshoot-sign-in-errors.md).
- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access).

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

# Sign-ins requiring multifactor authentication (MFA)

This scenario provides two aggregated data graphs. The first displays the number of users who successfully completed an interactive MFA sign-in using a Microsoft Entra cloud MFA service. The metric excludes instances when a user refreshes the session without completing the interactive MFA or using passwordless sign-in methods.

This scenario also provides an aggregated look at failures of interactive MFA sign-in attempts. The same type of refreshed sessions and passwordless methods are excluded from this metric.

- [Configure Conditional Access for MFA for all users](../conditional-access/howto-conditional-access-policy-all-users-mfa.md).
- [Troubleshoot common sign-in errors](howto-troubleshoot-sign-in-errors.md).

![Screenshot of the MFA scenario.](media/scenario-health-sign-ins-mfa/scenario-monitoring-MFA.png)
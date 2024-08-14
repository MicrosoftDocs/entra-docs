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

Microsoft Entra Health (preview) provides a set of health metrics you can monitor and receive alerts when a potential issue or failure condition is detected within the health scenarios.

This article describes these health metrics and how to troubleshoot the issue when you receive an alert.

## Prerequisites

To view the Scenario monitoring dashboards, you need:

- A user with the [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role for the tenant.
- A Microsoft Entra tenant with a [Premium P1 license](~/fundamentals/get-started-premium.md)

## How it works

1. Metrics and data are gathered, processed, and converted into meaningful signals displayed in Microsoft Entra Health Scenario Monitoring.
    - This scenario captures each user authentication that satisfies a Conditional Access policy requiring sign-in from a compliant device.
    - All the data is provided at the tenant level.

    ![Screenshot of the compliant device scenario.](media/scenario-health-sign-ins-compliant-device/scenario-monitoring-compliant-device.png)

1. These signals are fed into our anomaly detection service, which uses machine learning to understand the patterns for your tenant.

1. When the anomaly detection service identifies a significant change to that pattern, such as a spike in sign-ins requiring a compliant device, it triggers an alert. 

1. An alert is sent by email to the [tenant's important role] when the anomaly detection service identifies a significant change to the pattern of sign-ins requiring a compliant device. 

After receiving an alert, you need to research possible root causes, determine the next steps, and take action to mitigate the root cause. This article provides guidance on how to troubleshoot the issue.

## Possible root causes

Describe scenarios.

## Research root causes in your tenant

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Steps to find data.

## Mitigate the root cause

1. Steps to mitigate the root cause.

## Next steps

- [Create a compliance policy in Microsoft Intune](/mem/intune/protect/create-compliance-policy).
- [Learn about Conditional Access and Intune](/mem/intune/protect/conditional-access).
- [Learn about Microsoft Entra joined devices](../devices/concept-directory-join.md).
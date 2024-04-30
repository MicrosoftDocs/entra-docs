---
title: Identity protection risk analysis workbook
description: Learn how to use the identity protection risk analysis workbook in Microsoft Entra ID to explore trends and gaps in your risk policies.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 03/05/2024
ms.author: sarahlipsey
ms.reviewer: chuqiaoshi

#Customer intent: As an IT admin, I need to use the identity protection risk analysis workbook to explore trends and gaps in my risk policies so I can better protect my organization from identity compromise.
---
# Identity protection risk analysis workbook

Microsoft Entra ID Protection detects, remediates, and prevents compromised identities. As an IT administrator, you want to understand risk trends in your organizations and opportunities for better policy configuration. With the Identity Protection Risky Analysis Workbook, you can answer common questions about your Identity Protection implementation.

This article provides you with an overview of the **Identity Protection Risk Analysis** workbook.

## Prerequisites

[!INCLUDE [workbook prerequisites](../../includes/workbook-prerequisites.md)]

## Description

![Workbook category](./media/workbook-risk-analysis/workbook-category.png)

As an IT administrator, you need to understand trends in identity risks and gaps in your policy implementations, to ensure you're best protecting your organizations from identity compromise. The identity protection risk analysis workbook helps you analyze the state of risk in your organization.

**This workbook:**

- Provides visualizations of where in the world risk is being detected.
- Allows you to understand the trends in real time vs. Offline risk detections.
- Provides insight into how effective you are at responding to risky users.

## How to access the workbook

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) using the appropriate combination of roles.

1. Browse to **Identity** > **Monitoring & health** > **Workbooks**.

1. Select the **Identity Protection Risk Analysis** workbook from the **Usage** section.

## Workbook sections

This workbook has five sections:

- Heatmap of risk detections
- Offline vs real-time risk detections
- Risk detection trends
- Risky users
- Summary

## Filters

This workbook supports setting a time range filter.

![Set time range filter](./media/workbook-risk-analysis/time-range-filter.png)

There are more filters in the risk detection trends and risky users sections. 

Risk Detection Trends:

- Detection timing type (real-time or offline)
- Risk level (low, medium, high, or none)

Risky Users:

- Risk detail (which indicates what changed a user’s risk level)
- Risk level (low, medium, high, or none)

## Best practices

- **[Enable risky sign-in policies](~/id-protection/concept-identity-protection-policies.md#sign-in-risk-based-conditional-access-policy)** - To prompt for multifactor authentication (MFA) on medium risk or higher. Enabling the policy reduces the proportion of active real-time risk detections by allowing legitimate users to self-remediate the risk detections with MFA.

- **[Enable a risky user policy](~/id-protection/howto-identity-protection-configure-risk-policies.md#user-risk-policy-in-conditional-access)** - To enable users to securely remediate their accounts when they're considered high risk. Enabling the policy reduces the number of active at-risk users in your organization by returning the user’s credentials to a safe state.

- To learn more about identity protection, see [What is identity protection](~/id-protection/overview-identity-protection.md). 

- For more information about Microsoft Entra workbooks, see [How to use Microsoft Entra workbooks](./howto-use-workbooks.md).

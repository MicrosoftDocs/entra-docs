---
title: ID Protection Risk Reports
description: Lean about Microsoft Entra ID Protection risk reports and how they can assist during risk investigations.

ms.service: entra-id-protection

ms.topic: article
ms.date: 09/29/2025

author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera 
ms.reviewer: cokoopma
---
### Risky users report

The risky users report includes all users whose accounts are currently or were considered at risk of compromise. Risky users should be investigated and remediated to prevent unauthorized access to resources. We recommend starting with high risk users due to the high confidence of compromise. [Learn more about what the levels signify](concept-risk-detection-types.md#risk-levels)

#### Why is a user at risk?

A user becomes a risky user when:

- They have one or more risky sign-ins.
- They have one or more [risks](concept-identity-protection-risks.md) detected on their account, like leaked credentials.

## Access the risk reports

The ID Protection Dashboard provides a summary of important insights that you can use to start your investigation and navigate to the corresponding reports from there.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader).
1. Browse to **ID Protection** > **Dashboard**.
1. Select a report from the ID Protection navigation menu.

Each report launches with a list of all detections for the period shown at the top of the report. You can filter and add or remove columns based on your preference. Download the data in .CSV or .JSON format for further processing. To integrate the reports with SEIM tools for further analysis, see [Configure diagnostic settings](../identity/monitoring-health/howto-configure-diagnostic-settings.md).

When you select one or multiple entries, options to confirm or dismiss the risks appear at the top of the report. Selecting an individual risk event opens a pane with more details to assist with investigations.

:::image type="content" source="media/howto-identity-protection-investigate-risk/risky-users-report-heading.png" alt-text="Screenshot of the heading of the Risky users report showing the options available to administrators." lightbox="media/howto-identity-protection-investigate-risk/risky-users-report-heading.png"::: 
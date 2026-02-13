---
title: Risky user report
description: Learn about the risky user report in Microsoft Entra ID Protection
ms.topic: concept-article
ms.date: 11/05/2025
ms.reviewer: chuqiaoshi
---
# Microsoft Entra ID Protection risky user report

Knowing which users are at risk and *why* they're at risk is a key responsibility of security and identity administrators. The Risky user report in Microsoft Entra ID Protection provides the full report, along with a risk data summary, and an activity timeline.

The Risky user report is also integrated with the Identity Risk Management Agent (Preview) for enhanced agent suggestions and insights. If you have the Identity Risk Management Agent enabled, you can switch between the standard view and the agent view of the report.

This article provides an overview of the information and actions available in the Risky user report.

## Prerequisites

To access this report, you need:

- Microsoft Entra ID Free, Microsoft Entra ID P1 for limited data on users.
- Microsoft Entra ID P2 licenses for full access to the risky user data.
- [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader) and [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator) are the least privileged roles required to use the *standard view* of the report.
- [Security Administrator](../identity/role-based-access-control/permissions-reference.md#search-administrator) is required to use the *agent view* of the report and access the Identity Risk Management Agent features.
- [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator) is required to reset passwords.

## Risky user report

The standard view of the Risky user report contains three main sections: The summary chart of risky users at each level, new risky users per day, and the full list of risky users. If you have the [Identity Risk Management Agent](identity-risk-management-agent-risky-user-report.md) turned on, you can use the **Agent view** to see agent suggestions and insights.

The **Percentage of risky users at each risk level** chart shows a visual representation of your user and their risk levels. This visual summary allows you to quickly see the state of things in your organization. Hover over each segment of the chart to see the percentage of users at each risk level.

:::image type="content" source="media/concept-risky-user-report/risky-users-pie-chart.png" alt-text="Screenshot of the Percentage of risky users at each risk level chart." lightbox="media/concept-risky-user-report/risky-users-pie-chart.png":::

The **New risky users per day** chart shows a timeline of when risky users were detected in your organization. The chart also indicates if risk was remediated by the user or an administrator. Hover over any point in the chart to see the breakdown of the risky users and remediation activity.

:::image type="content" source="media/concept-risky-user-report/risky-users-bar-graph.png" alt-text="Screenshot of the New risky users per day chart." lightbox="media/concept-risky-user-report/risky-users-bar-graph.png":::

The lower half of the report contains the full list of risky users.

- Select the name of a risky user to see their risk details.
- Select the checkbox next to one or more users to take action, such as confirm compromise or dismiss the risk.
- If action options are greyed out, you need a higher privileged role. For more information, see [What is Microsoft Entra ID Protection](overview-identity-protection.md#required-roles).

:::image type="content" source="media/concept-risky-user-report/risky-users-list.png" alt-text="Screenshot of the risky users list." lightbox="media/concept-risky-user-report/risky-users-list-expanded.png":::

## Risky user details

From the Risky User Details page, you can take actions such as dismissing the risk or resetting the user's password. 

From the **Risky users report**, select a user to view more details about their risk events and even take action on that user.

The details include basic information about the user and a timeline of recent risk activities. The **Timeline** section provides a chronological view of risk events associated with the user. The timeline shows when the risk was detected, the risk level, and the type of risk detected. 

To see risk sign-in events together with risky user events, select the **Aggregate risk signals by risky sign-ins** checkbox.

## Take action on a risky user

[!INCLUDE [id-protection-admin-action-user](../includes/id-protection-admin-action-user.md)]
---
title: Risk Management Agent and the risky user report
description: Learn about how the Risk Management Agent works with the Risky user report in Microsoft Entra ID Protection
ms.service: entra-id-protection
ms.topic: how-to
ms.date: 10/07/2025
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.reviewer: chuqiaoshi
---
# Risk Management Agent and the risky user report

The Risk Management Agent in Microsoft Entra ID Protection provides proactive risk management capabilities by analyzing user behavior and suggesting actions to mitigate potential identity risks. By using machine learning and behavioral analytics, the agent helps security administrators identify and respond to risky activities before they lead to security incidents.

## Prerequisites

- You must have at least the [Microsoft Entra ID P2](overview-identity-protection.md#license-requirements) license.
- You must have the [Microsoft Entra Agent ID](https://www.microsoft.com/security/business/identity-access/microsoft-entra-agent-id) license to use the Risk Management Agent.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average, each agent run consumes less than one SCU.
- You must have the appropriate Microsoft Entra role.
   - [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) is required to *activate the agent the first time* and *view the agent and take action on the suggestions*.
   - [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader) and [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader) roles can *view the agent and any suggestions, but can't take any actions*.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security).

## How to view the Risk Management Agent in the risky user report

The Risk Management Agent is integrated directly into the risky user report in Microsoft Entra ID Protection. Agent settings and risky activity can be found in the agent library, but the agent suggestions and insights are available directly in the risky user report.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **ID Protection** > **Risky users**.
1. Select the **Agent view** option at the top of the report.

The top half of the agent view of the risky user report contains a summary of recent agent activity. This tile provides quick access to the **Chat with agent** feature, an option to trigger a one-time run, and a link to the agent settings. The lower half of the report contains the full list of risky users. Select a user from the list to view agent insights and suggestions specific to that user.

## Risky user details

The Risky User Details page provides a standard view and agent view. Both views provide useful information, so we recommend using the information provided in both views to investigate and remediate risky users.

The **standard view** provides basic information about the user, their current risk level, and their last sign-in information. The timeline shows recent risk signals associated with the user.

The **agent view** incorporates a detailed summary of the user's risk, drawing from sign-in details and user behavior. A call-to-action button provides a quick way to start remediating the risk. As with all Microsoft Entra ID Protection reports, you can take action directly on the user from the report using the options at the top of the page. Below the risk summary and risk factors, you can also see recent risk and sign-in information.

:::row:::
   :::column span="":::
      **Standard view**
:::image type="content" source="media/risk-management-agent-risky-user-report/risky-user-details-standard-view.png" alt-text="Screenshot of the standard view of the risky user details." lightbox="media/risk-management-agent-risky-user-report/risky-user-details-standard-view-expanded.png":::
   :::column-end:::
   :::column span="":::
      **Agent view**
:::image type="content" source="media/risk-management-agent-risky-user-report/risky-user-details-agent-view.png" alt-text="Screenshot of the agent view of the risky user details." lightbox="media/risk-management-agent-risky-user-report/risky-user-details-agent-view-expanded.png":::
   :::column-end:::
:::row-end:::




If the same action is recommended for multiple users, you can apply them in bulk.
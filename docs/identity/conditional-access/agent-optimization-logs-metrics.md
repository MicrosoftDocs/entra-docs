---
title: Logs and metrics for the Conditional Access optimization agent
description: Learn about the Security Copilot for Microsoft Entra optimization agent metrics and events in audit logs.
ms.author: sarahlipsey
author: shlipsey3
ms.reviewer: lhuangnorth
ms.date: 07/13/2025

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
---
# View logs and metrics for the Conditional Access optimization agent

The Conditional Access optimization agent helps organizations improve their security posture by automatically analyzing sign-in patterns and suggesting policy optimizations. This Microsoft Security Copilot agent identifies unprotected users and applications, recommends policy improvements, and helps consolidate redundant policies.

To ensure transparency and maintain control over automated recommendations, Microsoft Entra ID provides comprehensive logging and metrics for all agent activities. This article explains how to monitor agent performance, review audit logs, and understand the metrics that help you measure the agent's impact on your security environment.

## Prerequisites

- To view the Microsoft Entra audit logs, you need at least the [Reports reader](../../identity/role-based-access-control/permissions-reference.md#reports-reader) role.
- [Global Reader](../../identity/role-based-access-control/permissions-reference.md#global-reader) and [Security Reader](../../identity/role-based-access-control/permissions-reference.md#security-reader) roles can view the agent and any suggestions, but can't take any actions.
- [Global Administrator](../../identity/role-based-access-control/permissions-reference.md#global-administrator), [Security Administrator](../../identity/role-based-access-control/permissions-reference.md#security-administrator), and [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) roles can view the agent and take action on the suggestions.
   - For more information on roles for the Conditional Access optimization agent, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access)
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations

- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- For policy consolidation, each agent run only looks at four similar policy pairs.
- The agent currently runs as the user who enables it.
- We recommend running the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.

## Agent summary

The **Agent summary** at the top of the Conditional Access optimization agent page provides a quick summary of what the agent has discovered in the last 30 days. The total number of [security compute units (SCU)](/copilot/security/manage-usage) consumed by the agent is also provided.

:::image type="content" source="media/agent-optimization-logs-metrics/agent-summary-tile.png" alt-text="Screenshot of the agent summary tile." lightbox="media/agent-optimization-logs-metrics/agent-summary-tile.png":::

- **Unprotected users discovered**: The number of users who were identified by the agent and protected by a policy suggested by the agent.
- **Unprotected apps discovered**: The number of applications that were identified by the agent and protected by a policy suggested by the agent.
- **Sign-ins protected**: The number of sign-ins that were protected by a policy suggested by the agent.
- **Security compute units consumed**: The total number of SCUs consumed by the agent in the last 30 days. 

The values in the agent summary reflect the activity after suggestions are applied. If you run the agent and don't apply any suggestions, the values in the agent summary won't change.

## Audit logs 

Policies created or modified by the agent are tagged with **Conditional Access Optimization Agent** in the Conditional Access policies pane.

:::image type="content" source="media/agent-optimization-logs-metrics/created-by-conditional-access-optimization-agent.png" alt-text="Screenshot of Agent summary tile at the top of the agent page." lightbox="media/agent-optimization-logs-metrics/created-by-conditional-access-optimization-agent-expanded.png":::

In the **Audit logs** the **Initiated by (actor)** field show the name of the user who started the agent. To quickly see agent activity, filter to **Service: Conditional Access**. 

:::image type="content" source="media/agent-optimization-logs-metrics/audit-logs.png" alt-text="Screenshot of audit logs filtered to Conditional Access." lightbox="media/agent-optimization-logs-metrics/audit-logs.png":::

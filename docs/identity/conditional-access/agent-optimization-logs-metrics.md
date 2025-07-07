---
title: Logs and metrics for the Conditional Access optimization agent
description: Learn about the Security Copilot for Microsoft Entra optimization agent metrics and events in audit logs.
ms.author: sarahlipsey
author: shlipsey3

ms.date: 07/03/2025

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
---
# Logs and metrics for the Conditional Access optimization agent

## Prerequisites

- To view the Microsoft Entra audit logs, you need at least the [Reports reader](../../identity/role-based-access-control/permissions-reference.md#reports-reader) role.
- To view the Conditional Access policies, you need at least the [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role.
   - For more information on roles for the Conditional Access optimization agent, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access)
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations

- During the preview, avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- For policy consolidation, each agent run only looks at four similar policy pairs.
- The agent currently runs as the user who enables it.
- In preview, you should only run the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.

## Agent summary

The **Agent summary** at the top of the Conditional Access optimization agent page provides a quick summary of what the agent has discovered in the last 30 days. The total number of [security compute units (SCU)](/copilot/security/manage-usage) consumed by the agent is also provided.

:::image type="content" source="media/agent-optimization-logs-metrics/agent-summary-tile.png" alt-text="Screenshot of the agent summary tile." lightbox="media/agent-optimization/agent-summary-tile.png":::

- **Unprotected users discovered**: The number of users who were identified by the agent and protected by a policy suggested by the agent.
- **Unprotected apps discovered**: The number of applications that were identified by the agent and protected by a policy suggested by the agent.
- **Sign-ins protected**: The number of sign-ins that were protected by a policy suggested by the agent.

## Audit and policy logs 

Policies created or modified by the agent are tagged with **Conditional Access Optimization Agent** in the Conditional Access policies pane.

:::image type="content" source="media/agent-optimization-logs-metrics/created-by-conditional-access-optimization-agent.png" alt-text="Screenshot of the details of a policy suggestion." lightbox="media/agent-optimization-logs-metrics/created-by-conditional-access-optimization-agent-expanded.png":::

In the **Audit logs** the **Initiated by (actor)** field show the name of the user who started the agent.

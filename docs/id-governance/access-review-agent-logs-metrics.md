---
title: Logs and metrics for the Access Review Agent (Preview)
description: Learn about the Security Copilot for Microsoft Entra Access Review agent metrics and events in audit logs.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 07/19/2025

#CustomerIntent: As a governance administrator, I want to view the logs and metrics for access reviews completed with help from the access review agent.
---

# View logs and metrics for the Access Review agent (Preview)

The Access Review Agent helps organizations improve their security posture by automatically analyzing sign-in patterns and suggesting policy optimizations. This Microsoft Security Copilot agent identifies unprotected users and applications, recommends policy improvements, and helps consolidate redundant policies.

To ensure transparency and maintain control over automated recommendations, Microsoft Entra ID provides comprehensive logging and metrics for all agent activities. This article explains how to monitor agent performance, review audit logs, and understand the metrics that help you measure the agent's impact on your security environment.

## Prerequisites

- To view the Microsoft Entra audit logs, you need at least the [Reports reader](../identity/role-based-access-control/permissions-reference.md#reports-reader) role.
- To view the overview, activities, or settings of the Access Review Agent, you need either the [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader) role, a combination of both the [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) role used along with [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) role, or the [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) role.
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)


## Agent Summary

To access Access Review Agent information, open up the Access Review agent, and the Overview tab will open. From the Overview tab, you can find details about the Access Review Agent. The highlight of the overview page is the Agent summary, which provides a quick summary of agent actions over the course of 30 days.


:::image type="content" source="media/access-review-agent-logs-metrics/access-review-agent-overview.png" alt-text="Screenshot of the overview screen in the access review agent overview.":::


The Agent Summary shows:

- **Total access reviews**: The number of access reviews that are reviewed by the agent.
- **Total decisions analyzed**: The number of sign-ins that were protected by a policy suggested by the agent.
- **Total reviewers**: The number of reviewers who used the agent to complete access reviews.
- **Security compute units used**: The total number of [security compute units (SCU)](/copilot/security/manage-usage) consumed by the agent. 


The overview page also includes other general information about the agent such as its latest activity, and whether its currently active.

## Agent Activities

From the overview page you can select the **Activities** tab to view a full list of the activities of the Access Review Agent.

:::image type="content" source="media/access-review-agent-logs-metrics/access-review-agents-activities.png" alt-text="Screenshot of a list of activities in the Access Review Agent.":::

For each activity, you can see:

- The date and time the run started
- The number of SCU used
- The number of reviewers that completed the decision
- The status of the action

### View Agent's Full Activity

To see a detailed summary of the agent's activity, and how it justified the decisions made, select **View agent's full activity**.

The **Summary of agent activity** is a natural language description of the activity illustrated in the **Agent activity map**. These details can help you understand the logic behind the decisions so you can make an informed choice about whether to apply the decision.

:::image type="content" source="media/access-review-agent-logs-metrics/access-agent-review-card-justification.png" alt-text="Screenshot of access review agent justification in activity card.":::


## Audit logs 


In the **Audit logs** the **Initiated by (actor)** field show the name of the user who started the agent. To quickly see agent activity, filter to **Service: Access Reviews**. 


## Related content

- [Access Review Agent with Microsoft Security Copilot](access-review-agent.md)
- [What are access reviews?](access-reviews-overview.md)
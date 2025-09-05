---
title: Logs and metrics for the Access Review Agent (Preview)
description: Learn about the logs and metrics of the Access Review Agent.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 07/19/2025

#CustomerIntent: As a governance administrator, I want to view the logs and metrics for access reviews completed with help from the access review agent.
---

# View logs and metrics for the Access Review Agent (Preview)

The Access Review Agent helps organizations improve their security posture by automatically analyzing sign-in patterns and suggesting policy optimizations. This Microsoft Security Copilot agent identifies unprotected users and applications, recommends policy improvements, and helps consolidate redundant policies.

To ensure transparency and maintain control over automated recommendations, Microsoft Entra ID provides comprehensive logging and metrics for all agent activities. This article explains how to monitor agent performance, review audit logs, and understand the metrics that help you measure the agent's impact on your security environment.

## Prerequisites

- To view the Microsoft Entra audit logs, you need at least the [Reports reader](../identity/role-based-access-control/permissions-reference.md#reports-reader) role.
- To view the overview, activities, or settings of the Access Review Agent you must have at least **all** the following roles:
   - [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator)
   - [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator)
   - [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access)
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security).


## Agent Summary

To view information about the Access Review Agent, open up the Access Review Agent to get to the overview page. The highlight of the overview page is the Agent summary, which provides a quick summary of agent actions over the course of the last 30 days.

:::image type="content" source="media/access-review-agent-logs-metrics/access-review-agent-overview.png" alt-text="Screenshot of the overview screen in the Access Review Agent overview.":::


The **Agent Summary** shows:

- **Total access reviews**: The number of access reviews that are reviewed by the agent.
- **Total decisions analyzed**: The number of decisions made by the agent.
- **Total reviewers**: The number of reviewers who used the agent to complete access reviews.
- **Security compute units used**: The number of [security compute units (SCU)](/copilot/security/manage-usage) consumed by the agent to analyze identified reviews by gathering extra insights and generates recommendations (approve / deny) and justification summaries for each decision. This number does **not** include the SCUs consumed by the natural language conversation between reviewers and the agent. 


The overview page also includes other general information about the agent such as its latest activity, and whether its currently active.

## Agent Activities

From the overview page, you can select the **Activities** tab to view a full list of the activities of the Access Review Agent. A run is generated for each active access review instance the agent analyzes. A run is also generated if the agent hasn't identified any new active access review instances to analyze. Each access review instance is analyzed once and generates a signal run. 

:::image type="content" source="media/access-review-agent-logs-metrics/access-review-agents-activities.png" alt-text="Screenshot of a list of activities in the Access Review Agent.":::

For each activity, you can see:

- The date and time the run started
- The number of SCU used
- The number of reviewers involved in the review to which the run corresponds
- The status of the run

### View Agent's Full Activity

To see a detailed summary of the agent's activity, the recommendations (approve / deny), and the justification summaries it generated, select **View activity** next to the specific activity.

The **Summary of agent activity** is a natural language description of the activity illustrated in the **Agent activity map**. These details help you understand the logic behind the agent and you can view the recommendations and justification summaries on the last card in the activity map.

:::image type="content" source="media/access-review-agent-logs-metrics/access-agent-review-card-justification.png" alt-text="Screenshot of Access Review Agent justification in activity card.":::


## Related content

- [Access Review Agent with Microsoft Security Copilot](access-review-agent.md)
- [What are access reviews?](access-reviews-overview.md)

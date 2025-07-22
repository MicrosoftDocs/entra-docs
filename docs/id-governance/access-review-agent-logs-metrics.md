---
title: Logs and metrics for the Access Review Agent
description: Learn about the Security Copilot for Microsoft Entra Access Review agent metrics and events in audit logs.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 07/19/2025

#CustomerIntent: As a governance administrator, I want to view the logs and metrics for access reviews completed with help from the access review agent.
---

# View logs and metrics for the Access Review agent

The Access Review Agent helps organizations improve their security posture by automatically analyzing sign-in patterns and suggesting policy optimizations. This Microsoft Security Copilot agent identifies unprotected users and applications, recommends policy improvements, and helps consolidate redundant policies.

To ensure transparency and maintain control over automated recommendations, Microsoft Entra ID provides comprehensive logging and metrics for all agent activities. This article explains how to monitor agent performance, review audit logs, and understand the metrics that help you measure the agent's impact on your security environment.

## Prerequisites

- To view the Microsoft Entra audit logs, you need at least the [Reports reader](../identity/role-based-access-control/permissions-reference.md#reports-reader) role.
- [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader) and [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader) roles can view the agent and any suggestions, but can't take any actions.
- [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) and [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) used along with [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) roles can view the agent and take action on the suggestions.
   - For more information on roles for the Access Review Agent, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access)
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations

- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- The agent currently runs as the user who enables it.
- We recommend running the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.


## Agent Summary

The **Agent summary** at the top of the Access Review Agent page provides a quick summary of access reviews completed using the agent in the last 30 days. The total number of [security compute units (SCU)](/copilot/security/manage-usage) consumed by the agent is also provided.

- **Total access reviews**: The number of access reviews reviewed by the agent.
- **Total reviewers engaged**: The number of reviewers who used the agent to complete access reviews.
- **Total decisions analyzed**: The number of sign-ins that were protected by a policy suggested by the agent.
- **Security compute units consumed**: The total number of SCUs consumed by the agent in the last 30 days. 


## Audit logs 

Policies created or modified by the agent are tagged with **Access Review Agent** in the Access Review pane.


In the **Audit logs** the **Initiated by (actor)** field show the name of the user who started the agent. To quickly see agent activity, filter to **Service: Access Reviews**. 


## Related content

- [Access Review Agent with Microsoft Security Copilot](access-review-agent.md)
- [What are access reviews?](access-reviews-overview.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->


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
- To utilize the Access Review agent settings you must have  at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role along with the following:
   - Either the [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator), [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader) role, or a combination of both the [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) used along with [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) roles.
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)


## Agent Summary

The **Agent summary** at the top of the Access Review Agent page provides a quick summary of access reviews completed using the agent in the last 30 days. The total number of [security compute units (SCU)](/copilot/security/manage-usage) consumed by the agent is also provided.

- **Total access reviews**: The number of access reviews reviewed by the agent.
- **Total reviewers**: The number of reviewers who used the agent to complete access reviews.
- **Total decisions analyzed**: The number of sign-ins that were protected by a policy suggested by the agent.
- **Security compute units consumed**: The total number of SCUs consumed by the agent in the last 30 days. 


### View agent's full activity

To see a detailed summary of the agent's activity, and how it justified the decisions made, select **View agent's full activity**.

The **Summary of agent activity** is a natural language description of the activity illustrated in the **Agent activity map**. These details can help you understand the logic behind the decisions so you can make an informed choice about whether to apply the decision.


## Audit logs 


In the **Audit logs** the **Initiated by (actor)** field show the name of the user who started the agent. To quickly see agent activity, filter to **Service: Access Reviews**. 


## Related content

- [Access Review Agent with Microsoft Security Copilot](access-review-agent.md)
- [What are access reviews?](access-reviews-overview.md)
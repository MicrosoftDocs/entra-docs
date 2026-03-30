---
title: Agent Registry convergence with Agent 365
description: Learn how agent registry experiences are converging under Agent 365, what the change means for Microsoft Entra Agent ID, and how to view all agents in your organization.
author: shlipsey3
ms.author: sarahlipsey
ms.service: entra
ms.topic: concept-article
ms.date: 03/30/2026
ms.reviewer: jadedsouza
ms.custom: agent-id-ignite
ai-usage: ai-assisted

#customer-intent: As an IT administrator, I want to understand how the agent registry experiences are converging under Agent 365 so that I can manage agents in one place while continuing to use Microsoft Entra for identity and access control.

---

# Agent Registry convergence with Agent 365

Organizations are rapidly adopting AI agents across Microsoft platforms, partner ecosystems, and custom applications. As agents grow in number and capability, organizations need a centralized way to observe, govern, and secure them.

Agent 365 is Microsoft's control plane for AI agents. It helps organizations:

- Observe agents across the enterprise.
- Govern how agents access systems, data, and tools.
- Secure agents using Microsoft identity and security capabilities.

A key capability within Agent 365 is the agent registry, which provides a unified inventory of all agents operating in the organization, including both Microsoft and non-Microsoft agents.

## Registry convergence

Previously, agent visibility appeared across multiple portals, including Microsoft Entra and the Microsoft 365 admin center. Based on customer feedback, Microsoft is converging these registry experiences under Agent 365 to provide a simpler and more consistent management experience.

With this change:

- **Agent 365** becomes the unified registry and control plane for agents.
- **Microsoft Entra** continues to provide the identity foundation through Agent ID.

This approach gives customers one place to discover and manage agents, while continuing to use Microsoft Entra for agent identity and access control.

## Frequently asked questions

### Which registry should I use today?

Use Agent 365 to discover and manage all agents in your organization and monitor operational activity. Use Microsoft Entra to manage agent identities (Agent ID), apply identity governance and Conditional Access policies, and monitor identity-related security signals.

### What happens to the features announced as part of the Microsoft Entra Agent Registry?

The capabilities introduced with the Microsoft Entra Agent Registry continue to exist. Specifically:

- Agent identity capabilities remain part of Microsoft Entra Agent ID.
- Agent registration APIs remain supported.
- Identity governance and security controls for agents remain unchanged.

The change simplifies where customers see and manage all agents in their organization, while Microsoft Entra continues to provide identity and access management.

### Will I see the same agent inventory in the Microsoft Entra admin center?

The Microsoft Entra admin center focuses on identity and access management for agents. Identity administrators can see agents that have a Microsoft Entra Agent ID for viewing and managing them. The comprehensive agent inventory, including agents without a Microsoft Entra agent identity, is available in Agent 365.

### What can I manage in the Microsoft Entra admin center?

In the Microsoft Entra admin center, administrators can:

- View agents with Microsoft Entra agent identities.
- Manage agent identities, blueprints, and permissions.
- Apply Conditional Access, identity governance, and network security controls.
- Monitor identity-related security signals.

### Why should I go to Agent 365 if I'm an identity administrator?

Identity administrators can optionally use Agent 365, via the Microsoft 365 admin center, to view all agents in the organization, while continuing to use the Microsoft Entra admin center to manage agent identities, access policies, and identity governance controls.

### Do I need a different role to view agents in Agent 365?

To see all agents in Agent 365, users need the [AI Administrator](../../identity/role-based-access-control/permissions-reference.md#ai-administrator) role. To see all agents with a Microsoft Entra Agent ID in the Microsoft Entra admin center, users need the [Agent ID Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) role. Identity administrators can be assigned these roles for complete agent visibility.

### Is a license required?

Viewing all agents in the Microsoft 365 admin center doesn't require a specific license. Administrators only need the appropriate role, such as AI Reader (recommended least-privilege role) or AI Administrator, to access the inventory view.

Applying security and governance controls for agents, such as Conditional Access or identity governance policies, requires the appropriate licensing for [Microsoft Entra Agent ID](../../fundamentals/licensing.md#microsoft-entra-agent-id).

## How to view the complete agent inventory

To view the complete inventory of agents in your organization:

1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com) as at least an [AI Administrator](../../identity/role-based-access-control/permissions-reference.md#ai-administrator).
1. Select **Agents** from the navigation menu.
1. Select **All agents** to view the comprehensive list of agents in your tenant.

## Related content

- [What is Microsoft Entra Agent ID?](../identity-professional/microsoft-entra-agent-identities-for-ai-agents.md)
- [What is the Microsoft Entra Agent Registry?](what-is-agent-registry.md)
- [Agent 365 overview](/microsoft-agent-365/overview)
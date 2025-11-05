---
title: Governing Agent ID (Preview)
description: This article describes governing agent IDs.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.topic: concept-article #Required; leave this attribute/value as-is.
ms.date: 10/25/2025

#CustomerIntent: As an Identity Governance administrator, I want to learn how to use Microsoft Entra to manage lifecycle and access to resources for agent IDs within my organization.
---

# Governing Agent ID (Preview)

Microsoft Entra allows you to ensure that the right people have the right access to the right apps and services at the right time. With the addition of the Agentic Identity platform, managing agents in the same way is just as important in the governance lifecycle of your organization. The Agentic Identity platform introduces the concept of Agent Identities (IDs). Agent IDs are accounts within Microsoft Entra ID that provide unique identification and authentication capabilities for AI agents.

This allows agent IDs to be governed with Microsoft Entra features in the same style as you would govern human users. With agent IDs, you can assign an agent the ability to interact with different Microsoft Entra features so that you can assign access to resources, manage the agent IDs directly, and automate sponsorship notifications of the agent. This article provides an overview of how Microsoft Entra can be utilized to manage agent IDs.

## License requirements

[!INCLUDE [entra-p2-governance-license.md](../includes/entra-p2-governance-license.md)]

## Agent ID basics

[Agent IDs](https://learn.microsoft.com/en-us/entra/agentic-identity-platform/what-is-agent-id) allows AI agents developed in either [Microsoft 365 copilot](https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-overview), or the [AI Foundry](https://learn.microsoft.com/en-us/azure/ai-foundry/what-is-azure-ai-foundry), to take on digital identities within Microsoft Entra. Once a digital identity is established, these agent IDs are able to be governed using lifecycle and access features. Sponsors can be assigned to agent IDs after creation. Sponsors of agent IDs are human users accountable for making decisions about its lifecycle and access. For more information about the role of a sponsor of agent IDs, see: [Administrative relationships for agent IDs](https://microsoft.com/en-us/entra/agentic-identity-platform/agentic-governance-roles).

## Assigning access to agent IDs

Agent IDs can have resources assigned to them directly via access packages. Resource assignments allow agent IDs to request an access package for themselves, or have their owner or sponsor request one on their behalf. With Access packages, you're able to assign agent IDs the following resources:

- Security Groups
- Application roles and API permissions(including Graph permissions)
- Microsoft Entra roles



For a guide on creating an access package, see: [Create an access package in entitlement management](entitlement-management-access-package-create.md). For a guide on assigning users and agent identities to an existing access package, see: [View, add, and remove assignments for an access package in entitlement management](entitlement-management-access-package-assignments.md).


## Administration of agent IDs

When agent IDs are created, its sponsors can manually manage and review parts of its access and lifecycle from the My Access portal. From this portal information about its access, activity, and lifecycle can be found.

For a guide on managing agent identities in the My Access portal, see: [Manage Agent identity Access using the My Access Portal (Preview)](my-access-manage-agents.md).


## Agent ID sponsor administration

One of the most important parts of governing agent IDs is making sure that a delegated human user is always assigned to make sure the agent ID's access to resources are current. If the sponsor is leaving the organization, sponsorship of the agent ID is automatically transferred to their manager. With sponsorship transferred, there's always a human user accountable for managing the access and lifecycle of the agent IDs. Microsoft Entra ID Governance features can help streamline this process within your organization. Lifecycle workflows include multiple tasks around notifying cosponsors, and managers of sponsors, of impending sponsorship changes. For a guide on setting up a workflow for agent ID sponsors, see: [Manage agent ID sponsors (Preview)](manage-agent-sponsors.md).


## Related content

- [What is entitlement management?](entitlement-management-overview.md)
- [What is Microsoft Entra ID Governance?](identity-governance-overview.md)

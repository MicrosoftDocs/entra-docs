---
title: Governing Agent Identities (Preview)
description: This article describes governing agent identities.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.topic: concept-article #Required; leave this attribute/value as-is.
ms.date: 10/25/2025

#CustomerIntent: As an Identity Governance administrator, I want to learn how to use Microsoft Entra to manage lifecycle and access to resources for agent identities within my organization.
---

# Governing Agent Identities (Preview)

Microsoft Entra allows you to ensure that the right people have the right access to the right apps and services at the right time. With the addition of the Microsoft agent identity platform, managing agents in the same way is just as important in the governance lifecycle of your organization. The Microsoft agent identity platform introduces the concept of Agent Identities (IDs). Agent identities are accounts within Microsoft Entra ID that provide unique identification and authentication capabilities for AI agents.

This allows agent identities to be governed with Microsoft Entra features in the same style as you would govern human identities. With Agent identities, you can govern and manage the identity and access lifecycle of agents, ensuring the agents have a responsible person providing oversight throughout the agent lifecycle and agent's access does not persist longer than it is needed. This article provides an overview of how Microsoft Entra can be utilized to govern agent identities.

## License requirements

[!INCLUDE [entra-agent-id-license](../includes/entra-agent-id-license-note.md)]

## Agent identities basics

[Agent identities](../agent-id/identity-platform/what-is-agent-id.md) allows AI agents to take on digital identities within Microsoft Entra. Once a digital identity is established, these agent identities are able to be governed using lifecycle and access features. Sponsors can be assigned to agent identities after creation. Sponsors of agent identities are human users accountable for making decisions about its lifecycle and access. For more information about the role of a sponsor of agent identities, see: [Administrative relationships for agent IDs](../agent-id/identity-platform/agent-owners-sponsors-managers.md).

## Assigning access to agent identities

Agent identities can have resources assigned to them directly via access packages. Resource assignments allow agent identities to request an access package for themselves, or have their owner or sponsor request one on their behalf. With Access packages, you're able to assign agent identities the following resources:

- Security Groups
- Application roles and API permissions (including Graph permissions)
- Microsoft Entra roles



For a guide on creating an access package, see: [Create an access package in entitlement management](entitlement-management-access-package-create.md). For a guide on assigning identities to an existing access package, see: [View, add, and remove assignments for an access package in entitlement management](entitlement-management-access-package-assignments.md).


## Management of agents

When agent identities are created, Owners and sponsors of the agent can manually make decisions for the agent identity via both the My Account portal, and the My Access Portal.

From the [My Account portal](https://myaccount.microsoft.com/), Sponsors and Owners are able to manage the identity lifecycle of agents such as enabling and disabling the agent. You are also able to see information about its access, activity, and lifecycle. For more information about Managing agents, see: [Manage Agents in Microsoft Entra ID (Preview)](../agent-id/identity-platform/manage-agent.md).

From the [My Access portal](https://myaccess.microsoft.com/), Sponsors and Owners of agent identities are able to request access packages on behalf of their agent identities. For a guide on requesting access packages, see: [Request an access package on behalf of an agent identity (Preview)](entitlement-management-request-behalf.md#request-an-access-package-on-behalf-of-an-agent-identity-preview).


## Agent identities sponsor administration

One of the most important parts of governing agent identities is making sure that a delegated human user is always assigned to make sure the agent identity's access to resources are current. If the sponsor is leaving the organization, sponsorship of the agent identities are automatically transferred to their manager. With sponsorship transferred, there's always a human user accountable for managing the access and lifecycle of the agent identities. Microsoft Entra ID Governance features can help streamline this process within your organization. Lifecycle workflows include multiple tasks around notifying cosponsors, and managers of sponsors, of impending sponsorship changes. For a guide on setting up a workflow for agent identities sponsors, see: [Agent identity sponsor tasks in Lifecycle Workflows (Preview)](agent-sponsor-tasks.md).


## Related content

- [What is entitlement management?](entitlement-management-overview.md)
- [What is Microsoft Entra ID Governance?](identity-governance-overview.md)

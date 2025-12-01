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

[Microsoft Entra Agent ID](../agent-id/identity-platform/what-is-agent-id.md) includes four new types of object: agent identity blueprint, agent identity blueprint principal, agent identity, and agent user. These can be created in [Microsoft Foundry](/azure/ai-foundry/agents/concepts/agent-identity), [Microsoft Copilot Studio](/microsoft-copilot-studio/admin-use-entra-agent-identities), or other platforms. The agent identity, and optionally the agent user, allows AI agents to take on digital identities within Microsoft Entra. Once a digital identity is established, these agent identities are able to be governed using lifecycle and access features. Sponsors can be assigned to agent identities after creation. Sponsors of agent identities are human users accountable for making decisions about its lifecycle and access. For more information about the role of a sponsor of agent identities, see: [Administrative relationships for agent IDs](../agent-id/identity-platform/agent-owners-sponsors-managers.md).

## Assigning access to agent identities

When created, agent identities have limited permissions, such as OAuth 2 delegated permission scopes [inherited from their parent agent identity blueprint](../agent-id/identity-professional/configure-inheritable-permissions-blueprints.md). In addition, agent identities can have resources assigned to them directly via access packages. Resource assignments allow agent identities to request an access package for themselves, or have their owner or sponsor request one on their behalf. With access packages, you're able to assign agent identities the following resources:

- Security Groups
- [Application roles and API permissions](../identity/enterprise-apps/assign-agent-identities-to-applications.md), including Graph permissions
- [Microsoft Entra roles](../agent-id/identity-professional/authorization-agent-id.md#role-assignments-for-agent-identities)

To use access packages for agent identities, configure an access package with the required policy settings. When creating an access package assignment policy, in the **Who can get access** section, select **For users, service principals, and agent identities in your directory**, and then select the option of **All agents (preview)**.

> [!NOTE]
> If your agents aren't using Microsoft Entra agent IDs, then also create an access package assignment policy with the option **All Service principals (preview)** to allow service principals in your directory to be able to request this access package.

Agents can then be assigned access packages through three different request pathways.

- The agent identity itself can programmatically request an access package when needed for its operations, by creating an [accessPackageAssignmentRequest](/graph/api/entitlementmanagement-post-assignmentrequests?view=graph-rest-1.0&tabs=http).
- The agent's sponsor can request access on behalf of the agent ID, providing human oversight in the access request process. For more information, see [Request an access package on behalf of an agent identity (Preview)](entitlement-management-request-behalf.md#request-an-access-package-on-behalf-of-an-agent-identity-preview).
- An administrator can [directly assign the agent identity or agent user to the access package](entitlement-management-access-package-assignments.md#directly-assign-an-identity).

After submission, the access request is routed to designated approvers based on the access package configuration.

When the agent identity has received an access package assignment with an expiry date, and if a sponsor is set on the agent identity, as the expiry date approaches, the sponsor receives notifications about the pending expiration. The sponsor then has two options: they can request an extension of the access package (if permitted by policy), or they can allow the access package assignment to expire. If the sponsor requests an extension, this request can trigger a new approval cycle, where approvers again confirm whether continued access is appropriate. If the sponsor takes no action, the access package assignment automatically expires on its end date, and the agent identity loses access to the target resources.

For a guide on creating an access package, see: [Create an access package in entitlement management](entitlement-management-access-package-create.md). For a guide on assigning identities to an existing access package, see: [View, add, and remove assignments for an access package in entitlement management](entitlement-management-access-package-assignments.md).

## Management of agents

When agent identities are created, owners and sponsors of the agent can manually make decisions for the agent identity via both the My Account portal, and the My Access Portal.

From the [My Account portal](https://myaccount.microsoft.com/), Sponsors and Owners are able to manage the identity lifecycle of agents such as enabling and disabling the agent. You are also able to see information about its access, activity, and lifecycle. For more information about Managing agents, see: [Manage Agents in Microsoft Entra ID (Preview)](../agent-id/identity-platform/manage-agent.md).

From the [My Access portal](https://myaccess.microsoft.com/), Sponsors and Owners of agent identities are able to request access packages on behalf of their agent identities. For a guide on requesting access packages, see: [Request an access package on behalf of an agent identity (Preview)](entitlement-management-request-behalf.md#request-an-access-package-on-behalf-of-an-agent-identity-preview).


## Agent identities sponsor administration

One of the most important parts of governing agent identities is making sure that a delegated human user is always assigned to make sure the agent identity's access to resources are current. If the sponsor is leaving the organization, sponsorship of the agent identities are automatically transferred to their manager. With sponsorship transferred, there's always a human user accountable for managing the access and lifecycle of the agent identities. Microsoft Entra ID Governance features can help streamline this process within your organization. Lifecycle workflows include multiple tasks around notifying cosponsors, and managers of sponsors, of impending sponsorship changes. For a guide on setting up a workflow for agent identities sponsors, see: [Agent identity sponsor tasks in Lifecycle Workflows (Preview)](agent-sponsor-tasks.md).


## Related content

- [What is entitlement management?](entitlement-management-overview.md)
- [What is Microsoft Entra ID Governance?](identity-governance-overview.md)

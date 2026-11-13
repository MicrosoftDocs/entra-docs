---
title: Governing Agent Identities
description: This article describes governing agent identities.
ms.topic: concept-article #Required; leave this attribute/value as-is.
ms.date: 11/12/2026
ai-usage: ai-assisted

#Customer Intent: As an Identity Governance administrator, I want to learn how to use Microsoft Entra to manage lifecycle and access to resources for agent identities within my organization.
---

# Governing Agent Identities

Microsoft Entra allows you to ensure that the right people have the right access to the right apps and services at the right time. With the addition of the Microsoft agent identity platform, managing the access rights of agents in the same way is just as important in the governance lifecycle of your organization's identities. The Microsoft agent identity platform introduces the concept of Agent Identities (IDs). Agent identities are accounts within Microsoft Entra ID that provide unique identification, authentication and authorization capabilities for AI agents.

This allows agent identities to be governed with Microsoft Entra features in the same style as you would govern human identities. With Agent identities, you can govern and manage the identity and access lifecycle of agents, ensuring the agents have a responsible person providing oversight throughout the agent lifecycle and agent's access does not persist longer than it is needed. This article provides an overview of how Microsoft Entra can be utilized to govern agent identities and access.

## License requirements

[!INCLUDE [licensing-agent-id-governance](../includes/licensing-agent-id-governance.md)]

## Agent identities basics

Historically, AI agents would rely upon tools to interact with various applications and systems, and each of those tools would have their own identities in those applications and systems. Some of those tools would use service principals to authenticate to Microsoft services via Microsoft Graph or Microsoft Azure APIs. [Microsoft Entra Agent ID](../agent-id/what-are-agent-identities.md) introduces support for identities for the agents themselves, with four new types of object: agent identity blueprint, agent identity blueprint principal, agent identity, and agent user. Through the [agent identity blueprint](../agent-id/agent-blueprint.md), the agent can create one or more agent identities, and optionally an agent user for each agent identity, which it can use for authentication to Microsoft, third party and line of business applications. Each agent identity and agent user can have distinct access rights.

![Diagram of the relationship of Microsoft Entra Agent ID objects in a single tenant.](./media/agent-id-governance-overview/agent-identity-objects-single-tenant.png)

For a multitenant-capable agent, an agent identity blueprint principal can be brought into the tenant with resources so it can create agent identities in that tenant, similar to how a multitenant application can have a service principal in each tenant.

![Diagram of the relationship of Microsoft Entra Agent ID objects in multiple tenants.](./media/agent-id-governance-overview/agent-identity-objects-multiple-tenant.png)

The agent identity and the agent user allow AI agents to take on digital identities within Microsoft Entra. Once agent identities are created, these agent identities are able to be governed using lifecycle and access features. Sponsors can be assigned to agent identities after creation. Sponsors of agent identities are human users accountable for making decisions about its lifecycle and access. For more information about the role of a sponsor of agent identities, see: [Administrative relationships for agent IDs](../agent-id/agent-owners-sponsors-managers.md).

### Agent identities in other Microsoft products and portals

* **Microsoft Foundry** automatically provisions and manages agent identities throughout the agent lifecycle. When the first agent in a Foundry project is created, Microsoft Foundry provisions a default agent identity blueprint and a default agent identity for the project, and agents in the project authenticate by using the shared project's agent identity. Publishing an agent automatically creates a dedicated agent identity blueprint and agent identity, and the agent will authenticate by using the unique agent identity. Foundry supports use of the agent identity for authentication in [Model Context Protocol (MCP)](/azure/foundry/agents/how-to/mcp-authentication) and [Agent-to-Agent (A2A) tools](/azure/foundry/agents/concepts/agent-to-agent-authentication). You can also build an autopilot in Foundry, which augments the agent identity with an agent user account. For more information, see [Agent identity concepts in Microsoft Foundry](/azure/ai-foundry/agents/concepts/agent-identity) and [What is an autopilot in Microsoft Foundry?](/azure/foundry/agents/concepts/autopilot-overview).

* You can configure an **Azure App Service or Azure Functions app** to use the Microsoft Entra agent identity platform to securely connect to resources as an agent. For more information, see [How to use an agent identity in App Service and Azure Functions](/azure/app-service/overview-agent-identity).

* Agents created in **Microsoft Copilot Studio** can be configured to automatically be assigned to an agent identity. When an agent identity is first created in a Power Platform environment after enabling this setting, a Microsoft Copilot Studio agent identity blueprint, and an agent identity blueprint principal, are automatically created. For more information, see [Microsoft Entra Agent IDs for Copilot Studio agents](/microsoft-copilot-studio/admin-use-entra-agent-identities) and [Agent identities and authentication for Copilot Studio](/microsoft-copilot-studio/govern-agents-identities-overview).

* For agents in the **Microsoft Teams** platform, a developer can create and manage agent identity blueprints in the Developer Portal for Teams. For more information, see [Manage your apps in Developer Portal](/microsoftteams/platform/concepts/build-and-test/manage-your-apps-in-developer-portal).

* **Microsoft Agent 365** gives each AI agent its own Microsoft Entra Agent ID, for identity, lifecycle, and access management. For more information, see [Agent identity platform capabilities for Agent 365](/microsoft-agent-365/admin/capabilities-entra).

## Assigning access to agent identities

When created, agent identities have limited permissions, such as OAuth 2 delegated permission scopes [inherited from their parent agent identity blueprint](../agent-id/configure-inheritable-permissions-blueprints.md). In addition, agent identities can have resource access assigned to them directly via access packages. Agents can request an access package for own agent IDs, or have their owner or sponsor request one on their behalf. With access packages, you're able to assign agent identities access to the following resources:

- Security Group memberships
- [OAuth API permissions](../identity/enterprise-apps/assign-agent-identities-to-applications.md), delegated and application permissions for Microsoft Graph and applications
- [Microsoft Entra roles](../agent-id/authorization-agent-id.md#microsoft-entra-role-assignments-for-agent-identities)

To use access packages for agent identities, configure an access package with the required policy settings. When creating an access package assignment policy, in the **Who can get access** section, select **For users, service principals, and agent identities in your directory**, and then select the option of **All agents**.

> [!NOTE]
> If your agents aren't using Microsoft Entra agent IDs, but are using service principals, then also create an access package assignment policy with the option **All Service principals** to allow service principals in your directory to be able to request this access package.

Agents can then be assigned access packages to their agent identities through three different request pathways.

- The agent identity itself can programmatically request an access package when needed for its operations, by creating an [accessPackageAssignmentRequest](/graph/api/entitlementmanagement-post-assignmentrequests?tabs=http).
- The agent's sponsor can request access on behalf of the agent ID, providing human oversight in the access request process. For more information, see [Request an access package on behalf of an agent identity](entitlement-management-request-behalf.md#request-an-access-package-on-behalf-of-an-agent-identity).
- An administrator can [directly assign the agent identity or agent user to the access package](entitlement-management-access-package-assignments.md#directly-assign-an-identity).

After submission, the access request is routed to designated approvers based on the access package configuration.

When the agent identity has received an access package assignment with an expiry date, and a sponsor is set on the agent identity, as the expiry date approaches, the sponsor receives notifications about the pending expiration. The sponsor then has two options: they can request an extension of the access package (if permitted by policy), or they can allow the access package assignment to expire. If the sponsor requests an extension, this request can trigger a new approval cycle, where approvers again confirm whether continued access is appropriate. If the sponsor takes no action, the access package assignment automatically expires on its end date, and the agent identity loses access to the target resources.

For a guide on creating an access package for agents, see: [access packages for agent identities in Microsoft Entra Agent ID](../agent-id/agent-access-packages.md). For a guide on assigning identities to an existing access package, see: [View, add, and remove assignments for an access package in entitlement management](entitlement-management-access-package-assignments.md). For a guide on how access packages can be used with applications such as an Azure database which relies upon security groups, see [Govern agent access to data in Azure Database for PostgreSQL flexible server](../agent-id/govern-agent-access-azure-postgresql.md).

## Conditional Access for agent identities

Entitlement management controls which resources an agent identity can be assigned. To also control the conditions under which an agent identity can access those resources, you can apply Conditional Access to agent identities. Conditional Access policies evaluate agent context and risk—including agent identity risk from Microsoft Entra ID Protection—before granting access. You can apply these policies at the agent identity blueprint level so that all agent identities created from a blueprint inherit them.

For more information, see [Conditional Access for agents](../identity/conditional-access/agent-id.md) and [Identity Protection for agents](../id-protection/concept-risky-agents.md).

## Delegated management of agent identities and access

When agent identities are created, owners and sponsors of the agent can manually make decisions for the agent identity via both the My Account portal, and the My Access Portal.

From the [My Account portal](https://myaccount.microsoft.com/), Sponsors and Owners are able to manage the identity lifecycle of agents such as enabling and disabling the agent. You are also able to see information about its access, activity, and lifecycle. For more information about Managing agents, see: [Manage Agents in Microsoft Entra ID](../agent-id/manage-agent.md).

From the [My Access portal](https://myaccess.microsoft.com/), Sponsors and Owners of agent identities are able to request access packages on behalf of their agent identities. For a guide on requesting access packages, see: [Request an access package on behalf of an agent identity](entitlement-management-request-behalf.md#request-an-access-package-on-behalf-of-an-agent-identity).


## Agent identities sponsor lifecycle

One of the most important parts of governing agent identities is making sure that a designated human user is always assigned as the sponsor, to make sure the agent identity's access to resources are appropriate. When a sponsor moves or leaves the organization, the **Transfer agent identity sponsorships to manager** task in a mover or leaver workflow transfers the sponsorship of their agent identities to their manager, so there's always a human user accountable for managing the access and lifecycle of the agent identities. Without such a workflow, sponsorship isn't transferred: deleting the sponsor's account removes them as a sponsor, and an agent identity they sponsored alone is left without a sponsor. Restoring the account makes them a sponsor again. Microsoft Entra ID Governance features can help streamline this process within your organization. Lifecycle workflows include multiple tasks around notifying cosponsors, and managers of sponsors, of impending sponsorship changes. For a guide on setting up a workflow for agent identities sponsors, see: [Agent identity sponsor tasks in Lifecycle Workflows](agent-sponsor-tasks.md).

## Agent identity lifecycle automation

To ensure the security and manageability of agent identities for Microsoft customers, Microsoft Entra Agent ID provides a default inactivity policy to all tenants. This policy identifies inactive agent identities, notifies relevant users, and then proceeds to disable the identity if no new activity is detected. For more information, see [Microsoft Entra Agent ID default inactivity policy](agent-default-inactivity-policy.md) and [Entra Agent ID lifecycle policies](agent-lifecycle-policies.md).

## Related content

- [Manage agent identities in your organization](/entra/agent-id/manage-agent-identities-organization) - Overview of agent identity management across the full lifecycle.
- [Agent identity sponsor tasks in Lifecycle Workflows](agent-sponsor-tasks.md) - Automate sponsor change notifications using Lifecycle Workflows.
- [Manage agents in end user experience](/entra/agent-id/manage-agent-identities-end-user) - Sponsors can manage their agents from the My Account portal.
- [What is entitlement management?](entitlement-management-overview.md)
- [What is Microsoft Entra ID Governance?](identity-governance-overview.md)
- [Govern agent access to data in Azure Database for PostgreSQL flexible server](../agent-id/govern-agent-access-azure-postgresql.md)

---
title: Use Microsoft Entra Agent ID with Microsoft Foundry
description: Use the built-in Agent ID for a new Microsoft Foundry agent.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 10/28/2026
ms.reviewer: dastrock

#customer-intent: As a Foundry developer, I want my agent to use its built-in Agent ID when it accesses protected resources.
---

# Use Microsoft Entra Agent ID with Microsoft Foundry

Microsoft Foundry has built-in support for Microsoft Entra Agent ID. Foundry creates and manages the agent identity blueprint, Agent ID, and platform credential. You don't add a client secret or implement the Agent ID token exchange.

Use the current Foundry agent object model to opt in to this integration. Agents that use the legacy model continue to use a shared project identity or an Agent Application identity.

## Prerequisites

- A [Microsoft Foundry project](/azure/foundry/how-to/create-projects).
- Permission to create agents in the project.
- Permission to grant the Agent ID access to each downstream resource.

## Create an agent with Agent ID

Create a new agent by using the current Foundry agent model. A new agent receives:

- A unique agent identity blueprint.
- A unique Agent ID for its default instance.
- A stable agent endpoint.
- A platform-managed federated credential that Foundry uses for token exchange.

Follow [Configure and share your Microsoft Foundry agent](/azure/foundry/agents/how-to/configure-agent) to create and configure the agent.

If the project contains a legacy agent, create a new agent from the same definition. Foundry doesn't add a unique Agent ID to a legacy agent in place. For the opt-in and migration steps, see [Migrate from Agent Applications to the new Microsoft Foundry agent model](/azure/foundry/agents/how-to/migrate-agent-applications#migration-paths).

## Verify the agent identity

Retrieve or inspect the agent and confirm that `instance_identity` isn't null. A non-null value identifies an agent created with the current model.

Foundry manages the blueprint credential and runtime token exchange. Don't create another credential for the Foundry-managed blueprint.

For details about the objects that Foundry creates, see [Agent identity concepts in Microsoft Foundry](/azure/foundry/agents/concepts/agent-identity#how-foundry-provisions-identities).

## Grant access to a resource

New Agent IDs start without resource permissions. Grant access to the Agent ID used by the tool call:

- For an Azure resource, assign the least-privileged Azure role at the narrowest practical scope.
- For a custom API, assign the required application permission or app role.
- For delegated access, configure a supported user-delegation connection and obtain consent.

Use the Agent ID's object ID, not its client ID, when an Azure role assignment requires a principal ID.

For supported tools and authorization models, see [Permissions and access boundaries in Microsoft Foundry](/azure/foundry/agents/concepts/agent-identity#permissions-and-access-boundaries).

## Related content

- [Agent identity concepts in Microsoft Foundry](/azure/foundry/agents/concepts/agent-identity)
- [Configure and share a Foundry agent](/azure/foundry/agents/how-to/configure-agent)
- [Migrate to the current Foundry agent model](/azure/foundry/agents/how-to/migrate-agent-applications)
- [Azure role-based access control in Foundry](/azure/foundry/concepts/rbac-foundry)

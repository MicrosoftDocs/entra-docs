---
title: Use Microsoft Entra Agent ID with Copilot Studio
description: Find and manage the Agent ID that Copilot Studio creates for a new agent.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 10/28/2026
ms.reviewer: dastrock

#customer-intent: As a Copilot Studio maker or administrator, I want to find and govern the Agent ID created for my agent.
---

# Use Microsoft Entra Agent ID with Copilot Studio

Microsoft Copilot Studio automatically creates a Microsoft Entra Agent ID for each new agent. Copilot Studio manages the blueprint, Agent ID, and platform credentials. You don't register the identity or implement token acquisition.

Automatic Agent ID creation is built in for new agents and can't be turned off. Agents created before the integration rollout can continue to use legacy app registrations until they migrate.

## Create the agent

Create an agent by following [Create and delete agents in Copilot Studio](/microsoft-copilot-studio/authoring-first-bot). Copilot Studio creates the Agent ID as part of the agent lifecycle.

When the first Agent ID is created, Copilot Studio adds the **Microsoft Copilot Studio agent identity blueprint** to the tenant. Copilot Studio manages this shared blueprint and its credentials.

Don't create a separate blueprint or Agent ID for the Copilot Studio agent.

## Find the Agent ID

1. Open the agent in Copilot Studio.
1. Go to **Settings** > **Advanced**.
1. Expand **Metadata**.
1. Copy the GUID under **Entra Agent ID**.
1. Use the GUID to find the Agent ID in the [Microsoft Entra admin center](https://entra.microsoft.com).

For the current lifecycle, metadata, and deletion behavior, see [Manage Entra Agent IDs in Copilot Studio](/microsoft-copilot-studio/admin-use-entra-agent-identities).

## Review connector permissions

When you publish the agent, Copilot Studio attaches API permissions for its Power Platform connectors to the Agent ID. Review those permissions in Microsoft Entra ID and keep the agent's connectors and data policies aligned with the intended scenario.

Copilot Studio manages the connector runtime and platform credential. Don't add credentials to the Agent ID.

## Handle an existing agent

An older agent might still use an app-registration identity. You can wait for the platform migration or use the self-service migration process.

For current migration options, see [Migrate Copilot Studio agents to Microsoft Entra Agent ID](/microsoft-copilot-studio/govern-migrate-api-entra-agent-identity). For planning guidance in this documentation, see [Recreate Copilot Studio agents with Microsoft Entra Agent ID](migrate-copilot-studio-agents-to-agent-id.md).

## Related content

- [Manage Entra Agent IDs in Copilot Studio](/microsoft-copilot-studio/admin-use-entra-agent-identities)
- [Agent identities and authentication in Copilot Studio](/microsoft-copilot-studio/govern-agents-identities-overview)
- [Migrate Copilot Studio agents to Agent ID](/microsoft-copilot-studio/govern-migrate-api-entra-agent-identity)

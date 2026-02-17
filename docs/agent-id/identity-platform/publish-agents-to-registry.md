---
title: Register Agents to the Agent Registry
description: Learn how to register agents to the Agent Registry in Microsoft Entra Agent ID through automatic registration or manual API calls for agent discovery and management.
author: shlipsey3
ms.service: entra-id
ms.topic: how-to
ms.date: 11/07/2025
ms.author: sarahlipsey
ms.custom: agent-id-ignite
ms.reviewer: jadedsouza

#customer intent: As a developer creating agents on non-Microsoft platforms like OpenAI, Google Vertex, or Amazon Bedrock, I want to understand how to register my agents to Microsoft Entra Agent Registry through API calls, so that my agents can be discovered and managed within the Microsoft Entra ecosystem.
---

# Register agents to the Agent Registry

Registering agents in Microsoft Entra Agent Registry enables centralized visibility and management across your organization. It provides a unified view of all agents, including those from non-Microsoft builder platforms and identity providers. The registration process varies based on how the agent is created.

The registry stores two key types of information for each agent:
- **Agent Instance**: Operational details for execution and management.
- **Agent Card Manifest**: Discovery metadata for collaboration.

Understanding this distinction ensures accurate registration.

## Microsoft product integrations

If your agent was built on one of the following Microsoft products, you don't need to register your agent with Agent Registry. Agents built on these products are automatically integrated for both agent instances and agent card manifests and contain information on the agent ID. Currently, Microsoft products integrated with Microsoft Entra Agent Registry include:

- [Microsoft Copilot Studio](https://aka.ms/CopilotStudio)
- [Microsoft Agent 365](https://aka.ms/Agent365)
- [Azure AI Foundry](/azure/ai-foundry/what-is-azure-ai-foundry)

## Prerequisites

Before registering agents with the registry, ensure you have the following requirements:

- The [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator) role
- A valid Microsoft Entra access token with the https://graph.microsoft.com/.default scope
- Either app-only permissions or delegated permissions
- For non-Microsoft agents, you need your agent's operational endpoint and metadata information

[!INCLUDE [entra-agent-id-license-note](../../includes/entra-agent-id-license-note.md)]

## Agent instance and agent cards

Registering an agent in the registry involves the creation of an agent instance and an agent card.

- The agent instance is the registration of your agent in the registry that contains operational details such as the agent's endpoint URL, agent identity, originating store, and owner information.
- The agent card contains metadata that describes the agent's capabilities, skills, and other discovery-related information. Without the agent card, your agent isn't discoverable.

When creating the agent instance, you don't need to create an agent card at the same time. You can create the agent card later using the agent instance ID. Agent cards can only be created via agent instances. Agent instances can share an agent card.

## Self-serve registration

Agents created on Microsoft platforms not listed above and non-Microsoft platforms require self-serve registration using the Microsoft Graph API. This process involves:

- Registering the agent instance for inventory and operational management.
- Registering the agent card manifest for discovery and collaboration.

### Register an agent instance

The agent instance contains operational information needed for agent execution and management.

1. Ensure you have the necessary permissions:
   - For delegated flows: `AgentInstance.ReadWrite.All`
   - For app-only flows: `AgentInstance.ReadWrite.All`, `AgentInstance.ReadWrite.ManagedBy`

1. Make a POST request to register the agent.

```http
POST /beta/agentRegistry/agentInstances
Authorization: Bearer {token}
Content-Type: application/json

{
    "displayName": "My Agent Instance",
    "ownerIds": [
        "11112222-bbbb-3333-cccc-4444dddd5555"
    ],
    "sourceAgentId": "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1",
    "originatingStore": "Copilot Studio",
    "agentIdentityBlueprintId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
    "agentIdentityId": "aaaabbbb-6666-cccc-7777-dddd8888eeee",
    "agentUserId": "22cc22cc-dd33-ee44-ff55-66aa66aa66aa",
    "url": "https://conditional-access-agent.example.com/a2a/v1",
    "preferredTransport": "JSONRPC",
    "additionalInterfaces": [
        {
            "url": "https://conditional-access-agent.example.com/a2a/v1",
            "transport": "JSONRPC"
        },
        {
            "url": "https://conditional-access-agent.example.com/a2a/grpc",
            "transport": "GRPC"
        },
        {
            "url": "https://conditional-access-agent.example.com/a2a/json",
            "transport": "HTTP+JSON"
        }
    ],
    "signatures": [
        {
            "protected": "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u",
            "signature": "BB88CC99DD00EE11FF22AA33BB44CC55DD66EE77",
            "header": {
                "kidHint": "contoso-key-1",
                "nonce": "mN7oP8qR9sT0uV1wX2-yZ3aB4dE="
            }
        }
    ]
}
```
The response includes the created agent instance with timestamps and confirms successful registration. The `sourceAgentId` links your agent to its original platform identifier, while `originatingStore` indicates the platform where the agent was created.

### Register agent card

The agent card manifest provides discovery metadata that enables other agents and applications to find and interact with your agent. Using the same authentication token, register the agent card using the following API call:

```http
    POST /beta/agentRegistry/agentInstances
    Authorization: Bearer {token}
    Content-Type: application/json
    
    {
      "displayName": "",
      "ownerIds": [],
      "sourceAgentId": "",
      "originatingStore": "",
      "url": "",
      "preferredTransport": "",
      "agentIdentityBlueprintId": "",
      "agentIdentityId": "",
      "agentUserId": "",
      "additionalInterfaces": [],
      "signatures": [],
      "agentCardManifest": {
        "ownerIds": [],
        "originatingStore": "",
        "displayName": "",
        "description": "",
        "iconUrl": "",
        "provider": {},
        "protocolVersion": "",
        "version": "",
        "documentationUrl": "",
        "capabilities": {},
        "securitySchemes": {
          "apiKeyAuth": {},
          "entraAuth": {}
        },
        "security": [],
        "signatures": [],
        "defaultInputModes": ["application/json"],
        "defaultOutputModes": ["application/json", "text/html"],
        "supportsAuthenticatedExtendedCard": true,
        "skills": []
      }
    }
```

The skills array defines specific capabilities your agent provides, enabling precise discovery based on required functionality. The capabilities object specifies technical features your agent supports for integration protocols.

### Handle registration responses

Successful registration returns `HTTP 201`, created with the complete agent information including system-generated timestamps. If registration fails, the response includes error details to help resolve issues:

| Error Code | Description | Resolution |
|------------|-------------|------------|
| `ValidationError` | Required fields missing or invalid | Review request payload against schema requirements |
| `Unauthorized` | Authentication token invalid | Refresh token and retry request |
| `AgentAlreadyExists` | Agent ID already registered | Use different ID or update existing agent |

Common validation errors include missing required fields like `id` and `isBlocked` for agent instances, or `name` and `skills` for agent cards.

## Verify agent registration

After registration, confirm your agent appears correctly in the registry. You can verify registration through the Microsoft Entra Admin Center or using the Microsoft Graph API.

### [Microsoft Entra admin center](#tab/Microsoft-Entra-admin-center)

1. Navigate to **Agent identities**
1. Select **Agent Registry**. Your agent won't have an agent ID but you're able to view its associated metadata if you provided the information during registration.

### [Microsoft Graph API](#tab/Microsoft-Graph-API)

Query the registry to verify your agent registration: Send an API call to retrieve a specific agent instance by its unique identifier.

```http
GET https://graph.microsoft.com/beta/agentRegistry/agentInstances/{agent-instance-id}
Authorization: Bearer {token}
```

## Test agent discovery

The response should return your agent's complete information including creation timestamps and current status. For agent cards, use the corresponding endpoint:

```HTTP
GET /beta/agentRegistry/agentInstances/{id}/agentCardManifest
Verify that other applications can discover your agent by testing discovery queries based on skills or capabilities. Agents with properly configured metadata should appear in relevant search results based on their registered skills and attributes.
```

## Update registered agents

Registered agents can be updated to reflect changes in capabilities, endpoints, or metadata without requiring complete re-registration.

### Update agent instance

Modify operational details using PATCH requests:

```http
PATCH /beta/agentRegistry/agentInstances/693cc239-6811-49ed-8e64-fa8fad5aaa20
Authorization: Bearer {token}
Content-Type: application/json
{
  "displayName": "Updated Agent Display Name",
  "url": "https://new-endpoint.example.com/a2a/v1"
}
```

### Update agent card

Send a PATCH request to update discovery metadata:

```http
PATCH /beta/agentRegistry/agentCardManifests/8d4c5a5c-7c6e-4b1d-8e3b-3f2c1a9d1234
Content-Type: application/json
{
  "securitySchemes": {
    "openIdConnectAuth": {
      "@odata.type": "#microsoft.graph.openIdConnectSecurityScheme",
      "type": "openIdConnect",
      "description": "OIDC identity",
      "openIdConnectUrl": "https://login.microsoftonline.com/{tenantId}/v2.0/.well-known/openid-configuration"
    }
  },
  "security": [
    { "apiKeyAuth": [] },
    { "openIdConnectAuth": [] }
  ]
}
```

## Related content

- [What are agent IDs?](what-is-agent-id.md)
- [Agent Registry collections](agent-registry-collections.md)
---
title: Publish agents to registry
description: Learn how to publish agents to Microsoft Entra Agent Registry through automatic registration or manual API calls for agent discovery and management.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.author: jomondi
ms.reviewer: jadedsouza

#customer intent: As a developer creating agents on third-party platforms like OpenAI, Google Vertex, or Amazon Bedrock, I want to understand how to publish my agents to Microsoft Entra Agent Registry through API calls, so that my agents can be discovered and managed within the Microsoft Entra ecosystem.
---

# Publish agents to registry

Publishing agents to Microsoft Entra agent registry enables agent discovery and centralized management within your organization. It allows you to have a view of all your agents including the ones from third-party agent sources. The registration process differs depending on how you create your agents. Agents created through Microsoft platforms are automatically registered, while agents created on third-party platforms require manual registration through API calls.

The agent registry stores two types of information for each agent: the agent instance (operational details) and the agent card (discovery metadata). Understanding this distinction helps you provide the right information during registration.

## Prerequisites

Before publishing agents to the registry, ensure you have the following requirements:

- Understanding of Microsoft Entra agent registry
- Understanding of Microsoft Graph registry API permissions reference

## Agent instance and agent cards

Publishing an agent to the registry involves the creation of an agent instance and an agent card.

- The agent instance is the registration of your agent in the registry that contains operational details such as the agent's endpoint URL, agent identity ID, originating store, owner information and so on.
- The agent card contains metadata that describes the agent's capabilities, skills, and other discovery-related information. Without the agent card, your agent isn't discoverable.

When creating the agent instance, you don't need to create an agent card at the same time. You can create the agent card later using the agent instance ID. Agent cards can only be created via agent instances. Agent instances can share an agent card.

## Automatic registration for Microsoft agent builder platforms

Agents created on Microsoft platforms such as Microsoft Copilot Studio, Foundry and Agent 365 (A365) receive automatic registration without requiring manual API calls. When you create an agent on this platform, the system automatically provisions an agent identity (agent ID) and registers both the agent instance and agent card in the registry. This process includes assigning the agent to appropriate security collection based on the agent's metadata and intended use.

## Manual registration for third-party agent builder platforms

Agents created on third-party platforms require manual registration through Microsoft Graph API calls. This process involves registering both the agent instance and the agent card to enable full functionality.

### Acquire authentication token

Microsoft Graph agent registry APIs accept Microsoft Entra access tokens. The tokens can be app only tokens or app + user / delegated tokens. This requires you to have the appropriate permissions configured to be authorized for the specific API calls. How these tokens are retrieved from Microsoft Entra depends on the nature of your application.

You require the `https://graph.microsoft.com/.default` scope to call registry APIs.

### Publish agent to registry

Publishing an agent to registry is only supported via an API call. Agent card manifests can only be created through deep insert when creating / updating an agent instance. Direct POST to the agentCardManifests collection isn't supported.

After acquiring your auth token, you have the following options to publish your agent to the registry.

- Create an agent instance with the agent card in a single call
- Create an agent instance first then update it to include the agent card

#### Create an agent instance with an agent card in a single call

1. Ensure you have the necessary permissions. 
    1. For delegated flows, `AgentInstance.ReadWrite.All` and `AgentCardManifest.ReadWrite.All`
    1. For app-only flows, (`AgentInstance.ReadWrite.All` or `AgentInstance.ReadWrite.ManagedBy`) and (`AgentCardManifest.ReadWrite.All` or `AgentCardManifest.ReadWrite.ManagedBy`).

1. Do a POST call to the Microsoft Graph API endpoint *https://graph.microsoft.com/v1.0/agentRegistry/agentInstances*. Attach your access token as a bearer token in the authorization header.

1. Provide the agent instance and agent card details in your payload. You have the option of either creating a new agent card manifest in the process, or using an existing one.

    To create a new agent card manifest in the process, your payload will look something like the below
    
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

    To use an existing agent card manifest, your payload will look something like the below

    ```http
    POST /beta/agentRegistry/agentInstances
    Authorization: Bearer {token}
    Content-Type: application/json
    
    {
      "displayName": "",
      "ownerIds": [],
      "sourceAgentId": "",
      "originatingStore": "",
      "agentIdentityBlueprintId": "",
      "agentIdentityId": "",
      "agentUserId": "",
      "url": "",
      "preferredTransport": "",
      "additionalInterfaces": [],
      "signatures": [],
      "agentCardManifest@odata.bind": ""
    }
    ```
    
1. If successful, you'll get a 201 response from the registry API.

#### Create an agent instance first then update it to include the agent card

1. Ensure you have the necessary permissions. 
    1. For delegated flows, `AgentInstance.ReadWrite.All`
    1. For app-only flows, `AgentInstance.ReadWrite.All` and `AgentInstance.ReadWrite.ManagedBy`.

1. Do a POST call to the Microsoft Graph API endpoint *https://graph.microsoft.com/v1.0/agentRegistry/agentInstances*. Attach your access token as a bearer token in the authorization header.

1. Provide the agent instance and agent card details in your payload.

    ```http
    POST /beta/agentRegistry/agentInstances
    Authorization: Bearer {token}
    Content-Type: application/json
    
    {
      "displayName": "",
      "ownerIds": [],
      "sourceAgentId": "",
      "originatingStore": "",
      "agentIdentityBlueprintId": "",
      "agentIdentityId": "",
      "agentUserId": "",
      "url": "",
      "preferredTransport": "",
      "additionalInterfaces": [],
      "signatures": []
    }
    ```

1. If successful, the API will return http status 201 after creating the agent instance only.

1. Ensure you have the following permissions:

    1. For delegated flows, `AgentInstance.ReadWrite.All` and `AgentCardManifest.Read.All`.
    1. For app-only flows, (`AgentInstance.ReadWrite.All` or `AgentInstance.ReadWrite.ManagedBy`) and `AgentCardManifest.Read.All`.

1. Update the agent instance to include the agent card manifest. Do a PATCH call to the Microsoft Graph API endpoint *https://graph.microsoft.com/v1.0/agentRegistry/agentInstances/{agent-id}*. Attach your access token as a bearer token in the authorization header.

    ```http
    PATCH /beta/agentRegistry/agentInstances/00000000-0000-0000-0000-000000000000
    Authorization: Bearer {token}
    Content-Type: application/json

    {
      "agentCardManifest@odata.bind": "https://canary.graph.microsoft.com/beta/agentRegistry/agentCardManifests('8d4c5a5c-7c6e-4b1d-8e3b-3f2c1a9d1234')"
    }
    ```

1. If successful, the API will return http status 204 after updating the agent instance to include the agent card manifest.    

### Handle registration responses

Successful registration returns HTTP 201 Created with the complete agent information including system-generated timestamps. If registration fails, the response includes error details to help resolve issues:

| Error Code | Description | Resolution |
|------------|-------------|------------|
| `ValidationError` | Required fields missing or invalid | Review request payload against schema requirements |
| `Unauthorized` | Authentication token invalid | Refresh token and retry request |
| `AgentAlreadyExists` | Agent ID already registered | Use different ID or update existing agent |

## Verify agent registration

After registration, confirm your agent appears correctly in the registry.

### Verify in Microsoft Entra admin center

You can verify registration through the Microsoft Entra Admin Center. 

1. Navigate to **Agent identities**
1. Select **Agent Registry**. If your agent was created manually, it won't have an agent ID if you created it manually. If the agent was created via Microsoft platforms, it will have an agent ID.

### Verify using the registry API

Query the registry to verify your agent registration: Send an API call to retrieve a specific agent instance by its unique identifier.

```http
GET https://graph.microsoft.com/v1.0/agentRegistry/agentInstances/{agent-instance-id}
Authorization: Bearer {token}
```

## Update registered agents

Registered agents can be updated to reflect changes in capabilities, endpoints, or metadata without requiring complete re-registration. Updates to agent cards immediately affect discovery results, while agent instance updates impact operational routing and access controls.

### Update agent instance

Modify operational details using PATCH requests:

```http
PATCH https://graph.microsoft.com/v1.0/agentRegistry/agentInstances/{agent-id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "endpointUrl": "https://new-agent-endpoint.com",
  "isBlocked": false
}
```

### Update agent card

Send a PATCH request to update discovery metadata:

```http
PATCH https://graph.microsoft.com/v1.0/agentRegistry/agentCardManifests/{card-id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "description": "Updated AI assistant with enhanced capabilities",
  "version": "2.0.0"
}
```

### Test agent discovery

You can test whether you agent's discovery status.

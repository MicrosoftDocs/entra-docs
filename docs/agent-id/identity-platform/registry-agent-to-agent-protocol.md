---
title: Enable secure agent communication through the Agent Registry API
description: Learn how to enable secure agent communication through the Microsoft Entra Agent Registry API.
author: shlipsey3
ms.service: entra-id
ms.topic: how-to
ms.date: 11/07/2025
ms.author: sarahlipsey
ms.custom: agent-id-ignite
ms.reviewer: jadedsouza
#Customer intent: As a developer building interconnected AI agents, I want to understand the Agent-to-Agent protocol so that I can enable secure communication and collaboration between agents.
---

# Enable secure agent communication with the Agent Registry API

Agent Communication enables secure interactions between AI agents through the Microsoft Entra Agent Registry API. Agent communication through Agent Registry provides a common language and standardized approach for agent communication to boost interoperability and break organizational silos. This capability enables agents from different developers, built on different frameworks, and owned by different owners to work together.

## Understanding agent communication

There are three major components in agent communication:

- **Agent manifest**: The agent manifest is a JSON document that serves as a business card for the agents. Each agent manifest contains essential metadata about an agent's identity, capabilities, endpoint, skills, and authentication requirements. The Registry parses this information to determine if an agent is suitable for a given task, how to structure requests, and how to communicate securely. You can't use agent communication without an agent manifest.
- **Client agent**: The client agent initiates communication and orchestrates interactions with other agents to accomplish tasks. Clients parse the information contained in an agent manifest to determine if an agent is suitable for a given task, how to structure requests, and how to communicate securely.
- **Remote agent**: The remote agent is an autonomous agent or system that exposes an HTTP endpoint, implementing the agent communication. The remote agent receives requests and processes tasks to accomplish the requests. The inner workings of the remote agent aren't exposed to the client agent.

## Test agent communication

To test agent communication using Agent Registry, you need to validate that your client agent has an agent ID.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator).
1. Browse to **Agent ID** > **Agent Registry** and validate that your client agent has an agent ID.
    - Only agents with an agent ID can query the Agent Registry.
    - In the returned payload, check whether the `agentIdentityId` field has a value.
    - You can also use the following API call:

    ```http
    GET https://graph.microsoft.com/beta/agentRegistry/agentInstances/{agentInstance-id}
    ```

1. Validate that your remote (target) agent, exists in the Agent Registry.
    - Agent discovery isn't possible if the agent doesn't exist in the registry. In several scenarios, you might be able to skip to the following step if you're looking for agents with a specific attribute but you need the registry ID.
    - You can also use the following API call:

    ```http
    GET https://graph.microsoft.com/beta/agentRegistry/agentInstances/{agentInstance-id}
    ```

1. Query the Agent Registry using attributes like `skills`, `agentName`, `capabilities`, `collection`, `id`, and so on. This step retrieves all the agent cards for all the agents that match the query.
    - In the following example, we query by the `displayName` property and only retrieve specific agent manifest attributes.
    - The response from this call contains the agent cards and baseUrl for the agent communication endpoint of the matching agents. It's important to retrieve the agent manifest, because it's a JSON document that serves as a digital business card for initial discovery and interaction setup.

    ```http
    GET https://graph.microsoft.com/beta/agentRegistry/agentCardManifests?$filter=displayName eq 'Sample Agent Card'&$select=id,displayName,skills
    Authorization: Bearer {token}
    ```

1. Agent Registry validates discovery policies (secure by default and custom, if applicable) by confirming from the agent manifest JSON document that the remote (target) agent is in the global or custom collection and that communication is allowed based on the set policies. If validation fails, the registry denies the call with one of the following error codes:

    | HTTP Status | Error Code         | Description                 |
    |-------------|--------------------|-----------------------------|
    | 400         | ValidationError    | Request validation failed   |
    | 401         | Unauthorized       | Authentication required     |
    | 403         | Forbidden          | Insufficient permissions    |
    | 404         | AgentNotFound      | Agent not found             |
    | 404         | AgentCardNotFound  | Agent card not found        |
    | 500         | InternalServerError| Server error                |


1. Send the collaboration message to the remote (target) agent using [JSON-RPC specification](https://www.jsonrpc.org/specification) from the client (source) agent to the remote (target) agent. The payload should include the following:

    - `method`: Action to invoke  
    - `params`: Input data  
    - `traceId`: For audit  
    - `caller`: Registry-issued token  
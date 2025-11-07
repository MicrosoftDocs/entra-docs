---
title: Enable secure Agent-to-Agent collaboration through the Microsoft Entra agent registry API
titleSuffix: Microsoft Entra Agent ID
description: Learn how to enable secure Agent-to-Agent (A2A) collaboration through the Microsoft Entra Agent Registry API using the A2A protocol.
author: SHERMANOUKO
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.author: shermanouko
ms.reviewer: jadedsouza
#Customer intent: As a developer building interconnected AI agents, I want to understand the Agent-to-Agent protocol so that I can enable secure communication and collaboration between agents.
---

# Enable secure Agent-to-Agent collaboration through the Microsoft Entra agent registry API

Agent-to-Agent (A2A) collaboration enables secure interactions between AI agents through the Microsoft Entra Agent Registry API. The A2A protocol provides a common language and standardized approach for agent communication to boost interoperability and break organizational silos. This enables agents from different developers, built on different frameworks, and owned by different owners to work together.

## Understanding A2A interactions

There are three major components in agent to agent collaboration:

- The agent card is a JSON document that serves as a business card for the agents. Each Agent Card contains essential metadata about an agent's identity, capabilities, endpoint, skills, and authentication requirements. The Registry parses this information to determine if an agent is suitable for a given task, how to structure requests, and how to communicate securely. You can't do A2A discovery without an Agent Card.
- The A2A client, also referred to as the Client Agent, initiates communication using the A2A protocol and orchestrates interactions with other agents to accomplish tasks. Clients parse the information contained in an Agent Card to determine if an agent is suitable for a given task, how to structure requests, and how to communicate securely.
- The A2A server, also known as the Remote agent, is an AI agent or agentic system that exposes an HTTP endpoint implementing the A2A protocol. It receives requests and processes tasks to accomplish the requests. The inner workings of the remote agent aren't exposed to the client agent.

## Test A2A collaboration

To test A2A discovery or communication using agent registry, follow these steps:  

1. Validate that your client agent has an agent ID. Do this by checking the agents with agent identities tab in the Microsoft Entra admin center. You can also do so by doing an API call.

    ```http
    GET https://graph.microsoft.com/beta/agentRegistry/agentInstances/{agentInstance-id}
    ```

    In the returned payload, check whether the `agentIdentityId` field has a value.

1. Validate that your remote (target) agent, exists in the agent registry. You can do this by checking both the agent with IDs and agents without IDs tabs in the Microsoft Entra admin center. You can also do so by doing an API call.

    ```http
    GET https://graph.microsoft.com/beta/agentRegistry/agentInstances/{agentInstance-id}
    ```

    The A2A communication isn't possible if the agent doesn't exist in the registry. In several scenarios, you might go direct to step 3 since you're looking for agents with a specific attribute and you might not know the agent app registry ID.

1. Query the Agent Registry using attributes like *agentName*, *capabilities*, *collection*, *id, and so on. This retrieves all the agent cards for all the agents that match the query. In the following example, we query by *displayName* property and only retrieves specific agent card attributes.

    ```http
    GET https://graph.microsoft.com/beta/agentRegistry/agentCardManifests?$filter=displayName eq 'Sample Agent Card'&$select=id,displayName,skills
    Authorization: Bearer {token}
    ```

    The response from this call contains the agent cards and baseUrl for the A2A endpoint of the matching agents. It’s important to retrieve the Agent Card as it is a JSON document that serves as a digital business card for initial discovery and interaction setup.

1. Registry validates policies and scopes by confirming from the agent card JSON document that the remote (target) agent is in the approved collection and that communication is allowed based on the set policies. If validation fails, registry denies the call with one of the following error codes

    | HTTP Status | Error Code         | Description                 |
    |-------------|--------------------|-----------------------------|
    | 400         | ValidationError    | Request validation failed   |
    | 401         | Unauthorized       | Authentication required     |
    | 403         | Forbidden          | Insufficient permissions    |
    | 404         | AgentNotFound      | Agent not found             |
    | 404         | AgentCardNotFound  | Agent card not found        |
    | 500         | InternalServerError| Server error                |


1. Send the collaboration message to the remote (target) agent using JSON-RPC specification from client (source) agent to remote (target) agent. The payload should include the following:

    - `method`: Action to invoke  
    - `params`: Input data  
    - `traceId`: For audit  
    - `caller`: Registry-issued token  

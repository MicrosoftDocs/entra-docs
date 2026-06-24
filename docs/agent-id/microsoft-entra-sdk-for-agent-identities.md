---
title: Acquire tokens and call downstream APIs with Microsoft Entra ID Auth SDK (sidecar)
titleSuffix: Microsoft Entra Agent ID
description: Learn how autonomous agents acquire tokens using the Microsoft Entra ID Auth SDK (sidecar) to call downstream APIs independently.
ms.topic: how-to
ms.date: 11/05/2025
ms.reviewer: jmprieur
#Customer intent: As a developer building autonomous agents, I want to acquire tokens using the Microsoft Entra ID Auth SDK (sidecar) so that my agents can independently call downstream APIs with proper authentication.
---

# Acquire tokens and call downstream APIs with Microsoft Entra ID Auth SDK (sidecar)

The Microsoft Entra ID Auth SDK (sidecar) is a containerized web service that handles token acquisition, validation, and downstream API calls for agents. This SDK communicates with your application through HTTP APIs, providing consistent integration patterns regardless of your technology stack. Instead of embedding identity logic directly in your application code, the Microsoft Entra ID Auth SDK (sidecar) manages token acquisition, validation, and API calls through standard HTTP requests.

## Prerequisites

Before you begin, ensure you have:

- [Set up the Microsoft Entra ID Auth SDK (sidecar)](/entra/msidweb/agent-id-sdk/installation)
- [An agent identity](./create-delete-agent-identities.md). Record the agent identity client ID.
- [An agent identity blueprint](./create-blueprint.md). Record the agent identity blueprint client ID.
- Necessary [permissions configured in Microsoft Entra ID](grant-agent-access-microsoft-365.md)

## Deploy your containerized service

Deploy the Microsoft Entra ID Auth SDK (sidecar) as a containerized service in your environment. Follow the instructions in the [Set up the Microsoft Entra ID Auth SDK (sidecar)](/entra/msidweb/agent-id-sdk/installation) guide to configure the service with your agent identity details.

## Configure your Microsoft Entra ID Auth SDK (sidecar) settings

Follow these steps to configure your Microsoft Entra ID Auth SDK (sidecar) settings:

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

1. Set up the necessary components in Microsoft Entra ID. Ensure you register your application in the Microsoft Entra ID tenant.

1. Configure your client credentials. This credential can be a client secret, a certificate, or a managed identity that you're using as a federated identity credential. 

1. If you're calling a downstream API, ensure that the necessary permissions are granted. Calling a custom web API requires you to provide the API registration details in the SDK configuration.

For more information, see [Configure your Microsoft Entra ID Auth SDK (sidecar) settings](/entra/msidweb/agent-id-sdk/configuration).

## Acquire tokens using the Microsoft Entra ID Auth SDK (sidecar)

These are the steps to acquire tokens using the Microsoft Entra ID Auth SDK (sidecar):

1. Acquire token using the Microsoft Entra ID Auth SDK (sidecar). This varies based on whether the agent is operating autonomously or on behalf of a user. There are three scenarios to consider:

    - Autonomous agents: Agents operating on their own behalf using service principals created for agents (autonomous).
    - Autonomous agent's user account: Agents operating on their own behalf using user principals created specifically for agents (for instance agents having their own mailbox).
    - Interactive agents: Agents operating on behalf of human users.

    Specify the downstream API by including its name in the request URL based on your Entra ID Auth SDK (sidecar) configuration. The authorization header endpoint takes the format `/AuthorizationHeader/{serviceName}` where `serviceName` is the name of the downstream API configured in the SDK settings.

1. To acquire an app only token for an autonomous agent, you provide the agent identity client ID in the request.

    ```bash
    GET /AuthorizationHeader/Graph?AgentIdentity=<agent-id-client-ID>
    Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc...
    ```

1. To acquire token for an autonomous agent's user account, provide either the user object ID or User Principal Name but not both. This means providing either `AgentUsername` or `AgentUserId`. Providing both causes a validation error. You must also provide the `AgentIdentity` to specify which agent identity to use for token acquisition. If the agent identity parameter is missing, the request fails with a validation error.

    ```bash
    GET /AuthorizationHeader/Graph?AgentIdentity=<agent-id-client-id>&AgentUserId=<agent-user-object-id>
    Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc...
    ```

    ```bash
    GET /AuthorizationHeader/Graph?AgentIdentity=<agent-id-client-id>&AgentUsername=<agent-user-principal-name>
    Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc...
    ```

1. For interactive agents, use the on-behalf of flow. The agent first validates the user token granted to it before acquiring the resource token to call the downstream API.

    Agent web API receives user token from the calling application and validates the token via the Entra ID Auth SDK (sidecar) `/Validate` endpoint
    Acquire token for downstream APIs by calling `/AuthorizationHeader` with only the `AgentIdentity` and the incoming authorization header
    
    ```bash
    # Step 1: Validate incoming user token
    GET /Validate
    Authorization: Bearer <user-token>
    
    # Step 2: Get authorization header on behalf of the user
    GET /AuthorizationHeader/Graph?AgentIdentity=<agent-client-id>
    Authorization: Bearer <user-token>
    ```

## Call an API

When obtaining the authorization header for calling a downstream API, the Microsoft Entra ID Auth SDK (sidecar) returns the `Authorization` header value that can be used directly in your API calls. 

You can use this header to call the downstream API. The web API should validate the token by calling the `/Validate` endpoint of the Microsoft Entra ID Auth SDK (sidecar). This endpoint returns token claims for further authorization decisions.

## Related content

- [Python implementation of Microsoft Entra ID Auth SDK (sidecar)](/entra/msidweb/agent-id-sdk/scenarios/using-from-python)
- [TypeScript implementation of Microsoft Entra ID Auth SDK (sidecar)](/entra/msidweb/agent-id-sdk/scenarios/using-from-typescript)
- [Call a downstream API - Microsoft Entra ID Auth SDK (sidecar) docs](/entra/msidweb/agent-id-sdk/scenarios/call-downstream-api)

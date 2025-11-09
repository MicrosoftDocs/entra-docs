---
title: Agent autonomous app OAuth flow - App-only protocol
description: Learn how agent IDs operate autonomously without user context using app-only protocol with OAuth 2.0 client credentials flows.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
manager: pmwongera
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.author: shermanouko
ms.reviewer: jmprieur
#Customer intent: As a developer implementing autonomous agent scenarios, I want to understand the app-only protocol so that I can enable agents to act independently using client credentials flows.
---

# Agent autonomous app OAuth flow - App-only protocol

App-only operations enable agent identity (agent ID) to act autonomously without user context, using client credentials flows. The agent ID (actor) is used to obtain a token for itself (subject). To obtain this token, the agent ID blueprint impersonates the agent identity. Subjects use app-only access but are supposed to be only assigned the permissions necessary. Tenant administrators grant all permissions.

Agent ID blueprints can only impersonate their child agent identities. Agent IDs can only be impersonated by a single agent ID blueprint. Agent ID blueprints can impersonate many agent IDs. No agent ID can be owned by multiple agents. Agent identities are always single-tenant regardless of their parent Agent identity blueprint's tenancy model. Each agent ID operates within one tenant's security and policy boundaries.

[!INCLUDE [Use Microsoft SDKs](./includes/use-microsoft-libraries.md)]

[!INCLUDE [Managed identities support](./includes/managed-identities-preferred.md)]

## Protocol steps

The following are the protocol steps.

1. Agent ID blueprint requests an exchange token T1. The agent ID blueprint presents its credentials which could be a secret, a certificate or a federated identity credential. Entra ID returns the T1 to the agent ID blueprint. In this example we use a managed identity as as Federated Identity Credential (FIC).
    
    [!INCLUDE [Dont use secrets](./includes/dont-use-secrets.md)]

    ```
    POST /oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=AgentBlueprint
    &scope=api://AzureADTokenExchange/.default
    &fmi_path=AgentIdentity
    &client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
    &client_assertion=TUAMI
    &grant_type=client_credentials
    ```

    Where TUAMI is the MSI token for user assigned managed identity (UAMI). This step returns T1. Where T1 is the token-exchange token for FIC. 

1. Agent identity sends a token exchange request to Entra ID. The request includes the token T1.

    ```
    POST /oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=AgentIdentity
    &scope=https://resource.example.com/.default
    &client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
    &client_assertion={T1}
    &grant_type=client_credentials
    ```

1. Entra ID issues an app-only resource access token (TR) to the Agent Identity after validating T1. Entra ID validates that T1 (aud) == Agent ID parent app == Agent ID blueprint

## Related content

- [Oauth2.0 flows for agents](./agentic-oauth-protocols.md)
- [On-behalf-of flow in agents](./agent-on-behalf-of-oauth-flow.md)
- [Agent user flow in agents](./agent-user-oauth-flow.md)

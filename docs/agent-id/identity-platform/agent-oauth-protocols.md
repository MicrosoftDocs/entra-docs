---
title: Authentication protocols in agents
description: Learn about OAuth 2.0 protocols and token exchange patterns for agents in Microsoft Entra ID. Key concepts
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.author: shermanouko
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: jmprieur
 
#customer-intent: As a developer or identity architect, I want to understand the OAuth 2.0 authentication protocols and token flows for agents, so that I can implement secure authentication patterns for Agent identity blueprints and Agent Identities in my applications.
---
 
# Authentication protocols in agents
 
Agents use OAuth 2.0 protocols with specialized token exchange patterns enabled by Federated Identity Credentials (FIC). All agent auth flows involve multi-stage token exchanges where the agent identity blueprint impersonates the agent identity to perform operations. This article explains the authentication protocols and token flows used by agents. It covers delegation scenarios, autonomous operations, and federated identity credential patterns. Microsoft recommends that you use our SDKs like [Microsoft Entra SDK for Agent ID](https://aka.ms/entra/sdk/agentid) since implementing these protocol steps isn't easy.
 
All agent entities are confidential clients that can also serve as APIs for On-Behalf-Of scenarios. Interactive flows aren't supported for any agent entity type, ensuring that all authentication occurs through programmatic token exchanges rather than user interaction flows.
 
[!INCLUDE [Use Microsoft SDKs](./includes/use-microsoft-libraries.md)]
 
## Prerequisites
 
If you aren't familiar already, go through the following protocol docs.
 
- [Microsoft identity platform and OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)
- [Microsoft identity platform and the OAuth 2.0 client credentials flow](/entra/identity-platform/v2-oauth2-client-creds-grant-flow)
 
## Supported grant types
 
The following are the supported grant types for agent applications.
 
### Agent identity blueprint
 
Agent identity blueprints support `client_credentials` enabling secure token acquisition for impersonation scenarios. The `jwt-bearer` grant type facilitates token exchanges in [On-Behalf Of scenarios](/entra/identity-platform/v2-oauth2-on-behalf-of-flow), allowing for delegation patterns. `refresh_token` grants enable background operations with user context, supporting long-running processes that maintain user authorization.
 
### Agent identity
 
Agent identities use `client_credentials` for app-only autonomous operations, enabling independent functionality without user context, and impersonation for a user agent identity. The `jwt-bearer` grant type supports both [client credential flow](/entra/identity-platform/v2-oauth2-client-creds-grant-flow) and  [On-Behalf Of (OBO) flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow) providing flexibility in delegation patterns.`refresh_token` grants facilitate background user-delegated operations, allowing agent identities to maintain user context across extended operations.
 
### Unsupported flows

The agent application model explicitly excludes certain authentication patterns to maintain security boundaries. OBO flows using the `/authorize` endpoint aren't supported for any agent entity, ensuring all authentication occurs programmatically.
 
Public client capabilities aren't available, requiring all agents to operate as confidential clients. Redirect URLs aren't supported.

## Core protocol patterns
 
Agents can operate in three primary modes:
 
- Agents operating on behalf of regular users in Microsoft Entra ID (interactive agents). This is a regular on-behalf-of flow.
- Agents operating on their own behalf using service principals created for agents (autonomous).
- Agents operating on their own behalf using user principals created specifically for that agent (for instance agents having their own mailbox).

[!INCLUDE [Managed identities support](./includes/managed-identities-preferred.md)]

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]
 
## Oauth protocols
 
There are three agent oauth flows:
 
:::image type="content" source="media/agent-oauth-protocols/agent-flows.png" alt-text="Diagram showing the illustration of oauth flow for agents." lightbox="media/agent-oauth-protocols/agent-flows.png":::
 
- [Agent on-behalf of flow](./agent-on-behalf-of-oauth-flow.md): Agents operating on behalf of regular users (interactive agents).
- [Autonomous app flow](./agent-autonomous-app-oauth-flow.md): App-only operations enable agent identities to act autonomously without user context.
- [Agent user flow](./agent-user-oauth-flow.md): Agents operating on their own behalf using user principals created specifically for agents.

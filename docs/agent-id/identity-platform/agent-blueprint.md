---
title: Agent identity blueprints in Microsoft Entra agent ID
description: Understand agent identity blueprints, how agents are defined, and how authentication works within the Agent ID platform.
author: SHERMANOUKO
ms.author: shermanouko
manager: pmwongera
ms.date: 11/04/2025
ms.service: entra-id
ms.topic: concept-article

#customer intent: As a developer or IT administrator building AI agents, I want to understand agent identity blueprints so that I can properly create, authenticate, and manage agent identities within my organization's Microsoft Entra environment.
---

# Agent identity blueprints in Microsoft Entra agent ID

An Agent identity blueprint (Agent ID blueprint) is a special application registration in Microsoft Entra agent ID that serves as a template for creating agent identities. It establishes the foundation for how agents are created, authenticated, and managed within an organization.

## Defining an agent

In its most fundamental form, an agent is an application that attempts to achieve a goal by understanding its environment / context, making decisions and acting on them autonomously using available tools. Agents can act with or without human intervention when provided with proper goals or objectives.

Key components of an agent include:

- **Model**: Model based agents have language models that serve as the centralized decision maker for agent processes. Models can be general purpose, multimodal, or fine-tuned based on specific agent architecture needs.

- **Orchestration Layer**: The cyclical process that governs how the agent takes in information, performs internal reasoning, and uses that reasoning to inform its next action. This loop continues until the agent reaches its goal or a stopping point. Complexity varies from simple decision rules to chained logic.

- **Memory**: Memory in agents provides agents with more dynamic and up-to-date information, ensuring responses are accurate and relevant. This memory allows developers to provide more data in its original format to an agent, without requiring data transformations, model retraining, or fine-tuning. It differs from typical large language models (LLMs) that remain static, retaining only the knowledge they were initially trained on.

- **Tools**: Tools enable agents to interact with their environment and extend their capabilities. Tools can include web search, database access, APIs, file systems, or integrations with other software. Each tool requires careful consideration of security, permissions, and error handling. By using tools, agents can perform complex tasks, access information, and control external systems, making them more effective and adaptable.

Agentic workflows are in whole or part planned and driven autonomously and independently of a human user. There are many types of agentic workflows across Microsoft products, from the ones initiated directly by a user, to the ones that operate autonomously. Subcomponents, skills, tools, or APIs used in those workflows might or might not themselves be "agentic."

## Defining an agent identity blueprint

An agent identity blueprint is a special application registration in Microsoft Entra agent ID that has permissions to act on behalf of agent identities or agent users. It's represented by its application ID (Agent identity blueprint Client ID). The agent identity blueprint is configured with credentials (typically FIC+MSI or client certificates) and permissions to acquire tokens for itself to call Microsoft Graph. It's the app that you develop. It's a confidential client application. The only permissions it can have are maintain (create/delete) agent identities using the Microsoft Graph. Agent identity blueprints can be multitenant, allowing a service to provision many agent identities in each of tenants where the agent ID blueprint is added.

An agent ID blueprint serves three primary purposes:

- The blueprint establishes the "type" or "kind" of agent identity, such as "Contoso Sales Agent" or "DataDog Cloud Monitoring Agent." It allows customers to manage many individual AI agents of a common type as a collection. For instance, customers can write security policy that says "block all requests from all Contoso Sales Agent IDs." The blueprint also records attributes, metadata, and settings that are common across all of its agent IDs, such as role definitions.

- The service that creates agent identities in tenants typically uses the blueprint to authenticate. Blueprints have an OAuth client ID and credentials that can include: client secrets, certificates, and various federated identity credentials such as managed identities. Services use these credentials to request access tokens from Microsoft Entra ID, then use those access tokens to authenticate requests to create, update, or delete agent identities. In this sense, the blueprint is the creator of an agent identity.

- The service or platform that hosts an AI agent must use the blueprint during runtime authentication. The service uses a blueprint's OAuth credentials to request an access token, then presents that access token to Microsoft Entra ID to request a token as one of its agent identities.

Agent identity blueprints can be multitenant, allowing a service to provision many agent identities in each of tenants where the agent ID blueprint is added. Agent ID blueprints can't request tokens from Microsoft Entra ID outside of the tokens referenced in the previous section.

## Agent identity blueprint principals

An agent identity blueprint principal is an object in Microsoft Entra agent ID that represents the presence of an agent ID blueprint within a specific tenant. When an agent identity blueprint application is added to a tenant, Microsoft Entra creates a corresponding principal object, which is the agent identity blueprint principal.

This principal serves several important roles:

- **Token Issuance**: When the agent ID blueprint is used to acquire tokens within a tenant, the resulting token's `oid` (object ID) claim references the agent ID blueprint principal. It ensures that any authentication or authorization performed by the agent ID blueprint is traceable to its principal object in the tenant.

- **Audit Logging**: Actions performed by the agent ID blueprint, such as creating agent identities, are recorded in audit logs as being executed by the agent ID blueprint principal. It provides clear accountability and traceability for operations initiated by the agent ID blueprint.

- **Orchestration and Impersonation**: Agent ID blueprint principals act as the orchestrators for agentic workflows. They're responsible for impersonating agent identities and can serve as the token audience in On-Behalf-Of (OBO) authentication scenarios.

Agent identity blueprints are always created in an Entra tenant. A blueprint is often used create agent identities in that same tenant. These blueprints are called "single-tenant". Agent identity blueprints can also be configured as "multi-tenant" and published to potential customers via Microsoft catalogs. Customers can then add these blueprints to their tenant, so that they can be used to create agent identities.

In either case, an agent identity blueprint principal is always created when a blueprint is added to a tenant. The presence of this principal indicates that a blueprint exists in a tenant and can be used to create agent identities. Customers can remove a blueprint from their tenant by deleting the agent identity blueprint principal.

## Create an agent ID blueprint

There are multiple ways to create an agent ID blueprint in Microsoft Entra agent ID.

## Authentication workflows

Agent ID blueprints handle authentication through OAuth 2.0 flows. Agent ID blueprints are configured with credentials for authentication, typically including:

- Federated Identity Credentials (FIC) and Managed Service Identity (MSI)
- Client certificates
- Client secrets

In agentic workflows, the agent ID blueprint acts as the "actor" - the application that performs actions. The subject identity (either a user or autonomous application) determines the permissions available to the agent. Agent ID blueprints facilitate the OAuth 2.0 flow where:

- The agent instance is the client (or actor) for OAuth flows
- The agent ID blueprint serves as the template, providing protocol properties (redirect URLs, App URIs, secrets)

Agent ID blueprints have a parent-child relationship with agent identities, where the blueprint is the parent. It allows the agent ID blueprint to be instantiated multiple times, for example, once per Teams channel.
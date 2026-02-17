---
title: Fundamental concepts in Microsoft agent identity platform
titleSuffix: Microsoft Entra Agent ID
description: Discover the role of agent identities in AI authentication. Understand their unique identifiers, token usage, and how they enable secure access to systems.
author: omondiatieno
ms.author: jomondi
ms.reviewer: dastrock
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.topic: concept-article
ms.service: entra-id

#customer intent: As a developer, I want to understand the core concepts of agent identities and blueprints in Microsoft Entra ID so that I can implement secure authentication patterns for AI agents in my applications.
---
# Agent identity and blueprint concepts in Microsoft Entra ID

The Microsoft agent identity platform provides specialized identity constructs designed specifically for AI agents operating in enterprise environments. These identity constructs enable secure authentication and authorization patterns that differ from traditional user and application identities, addressing the unique requirements of autonomous AI systems.

This article explains the core concepts that form the foundation of agent identity management: agent identities, agent identity blueprints, and their supporting components. Understanding these concepts is essential for developers who need to implement secure, scalable authentication patterns for AI agents.

The agent identity architecture follows a hierarchical model where agent identity blueprints serve as templates for creating multiple agent instances, each with distinct identities and capabilities. This approach enables centralized management while providing the flexibility needed for diverse AI agent deployment scenarios.

## Core identity concepts

The following concepts form the foundation of the agent identity system in Microsoft Entra ID.

### Agent identity

Agent identity is the primary account used by an AI agent to authenticate to various systems. It has unique identifiers - the object ID and the app ID, which always have the same value - which can be reliably used for authentication and authorization decisions. Agent identities don't have a password or any other credential. Instead, agent identities can only authenticate by presenting an access token issued to the service or platform on which the agent runs. For more information, see [what is an agent ID](./what-is-agent-id.md)

### Agent identity blueprint

Agent identity blueprints provide the template and management structure for creating and managing multiple agent identities. Agent identity blueprint serves as the parent of an agent identity.

For more information, see [What is an agent identity blueprint?](agent-blueprint.md)

### Agent identity blueprint principal

When blueprints are added to tenants, they create a corresponding principal object that manages the blueprint's presence within that specific tenant. Agent identity blueprint principal is the Microsoft Entra object is the record of a blueprint's addition to a tenant. For more information, see [agent identity blueprint principals](agent-blueprint.md#agent-identity-blueprint-principals)

### Agent user

For scenarios where agents need to interact with systems that specifically require user objects, the platform provides agent users as an alternative identity type. An agent user is a secondary account that an AI agent uses to authenticate to various systems. These accounts are user objects in a tenant and have most properties of other users, like a manager, UPN, and photo. It makes them compatible with systems that have a hard dependency on user objects, and enable AI agents to connect to these systems. For more information, see [agent users](./agent-users.md)

## Agent registry

The agent registry is a centralized repository that maintains metadata about all registered agents within an organization. It serves as a discovery mechanism, allowing systems and services to locate and interact with agents based on their capabilities, roles, and other attributes. For more information, see [agent registry](what-is-agent-registry.md)

## Agent operation patterns

The agent identity platform supports two primary patterns for how agents operate and authenticate, each serving different use cases and security requirements.

- Interactive agents are agents that sign-in a user and taken action in response to user prompts, often via a chat interface. These agents act on behalf of the signed-in user, utilizing that user's authorization to perform actions in various systems. Interactive agents are granted Microsoft Entra delegated permissions that allow them to act on behalf of users. Tokens issued to interactive agents are often called user tokens.

- Autonomous agents are agents that perform actions using their own identity; not a human user's identity. These agents often run in the background and make autonomous decisions about what actions to take. Tokens issued to autonomous agents are often called agent tokens when an agent identity is authenticated. They can also be called agent user tokens when an agent user is authenticated.

## Agent owners, sponsors, and managers

The agent identity platform introduces an administrative model that separates technical administration from business accountability, ensuring operational control and compliance oversight without excessive permissions. The agent administrative roles include owners, managers, and sponsors.

- Owners serve as technical administrators for agents, handling operational and configuration aspects.
- Sponsors provide business accountability for agents, making lifecycle decisions without technical administrative access.
- A manager is a human user who is designated as the hiring manager or operational owner for an agent user.

For more information, see [Administrative relationships for agent identities (Owners, sponsors, and managers)](agent-owners-sponsors-managers.md)

## Microsoft Entra SDK for agent ID

The Microsoft Entra SDK for AgentID is a containerized web service that handles token acquisition, validation, and secure downstream API calls for agents registered in the Microsoft identity platform. It runs as a companion container alongside your application, allowing you to offload identity logic to a dedicated service. For more information, see [Microsoft Entra SDK for agent ID](/entra/msidweb/agent-id-sdk/overview)

## Related content

- [What is an agent ID?](what-is-agent-id.md)
- [What is the agent identity platform?](what-is-agent-id-platform.md)
- [Microsoft Entra Agent ID oauth protocols](agent-oauth-protocols.md)
- [Create an agent identity blueprint](create-blueprint.md)

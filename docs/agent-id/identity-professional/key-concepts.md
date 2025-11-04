---
title: Fundamental concepts in Microsoft agent identity platform
description: Discover the role of agent identities in AI authentication. Understand their unique identifiers, token usage, and how they enable secure access to systems.
author: omondiatieno
ms.author: jomondi
ms.reviewer: dastrock
ms.date: 11/04/2025
ms.topic: concept-article
ms.service: entra-id

#customer intent: As a developer, I want to understand the core concepts of agent identities and blueprints in Microsoft Entra ID so that I can implement secure authentication patterns for AI agents in my applications.
---
# Fundamental concepts in Microsoft agent identity platform

The Microsoft Entra agent identity platform provides specialized identity constructs designed specifically for AI agents operating in enterprise environments. These identity constructs enable secure authentication and authorization patterns that differ from traditional user and application identities, addressing the unique requirements of autonomous AI systems.

This article explains the core concepts that form the foundation of agent identity management: agent identities, agent identity blueprints, and their supporting components. Understanding these concepts is essential for developers who need to implement secure, scalable authentication patterns for AI agents that can operate independently or on behalf of users.

The agent identity architecture follows a hierarchical model where agent ID blueprints serve as templates for creating multiple agent instances, each with distinct identities and capabilities. This approach enables centralized management while providing the flexibility needed for diverse AI agent deployment scenarios.

## Core identity concepts

The following concepts form the foundation of the agent identity system in Microsoft Entra ID.

### Agent identity

Agent identity is the primary account used by an AI agent to authenticate to various systems. It has unique identifiers - the object ID and the app ID, which always have the same value - which can be reliably used for authentication and authorization decisions. Agent identities can be used to:

- Request agent tokens from Microsoft Entra ID. The subject of the access token is the agent identity.
- Receive incoming access tokens issued by Microsoft Entra ID. The audience of the access token is the agent identity.
- Request user tokens from Microsoft Entra ID for an authenticated user. The subject of the token is a user, while the actor (`azp` or `appId` claim) is the agent identity.

Agent identities don't have a password or any other credential. Instead, agent identities can only authenticate by presenting an access token issued to the service / platform on which the agent runs as shown in the following example. Agent identities can only be issued tokens in the Microsoft Entra tenant where they're created. They can't access resources or APIs in other tenants.

### Agent identity blueprint

Building on the agent identity concept, agent ID blueprints provide the template and management structure for creating and managing multiple agent identities. Agent identity blueprint serves as the parent of an agent identity.

### Agent identity blueprint principal

When blueprints are added to tenants, they create a corresponding principal object that manages the blueprint's presence within that specific tenant. Agent identity blueprint principal is the Microsoft Entra object is the record of a blueprint's addition to a tenant.

- When an agent identity blueprint is issued tokens in a tenant, the resulting token's `oid` claim refers to the object ID of the agent identity blueprint principal.
- When an agent identity blueprint is used to create an agent identity in a tenant, the resulting audit log shows that the agent identity blueprint principal performed the operation.

### Agent user

For scenarios where agents need to interact with systems that specifically require user objects, the platform provides agent users as an alternative identity type. An agent user is a secondary account that an AI agent uses to authenticate to various systems. These accounts are user objects in a tenant and have most properties of other users, like a manager, UPN, and photo. It makes them compatible with systems that have a hard dependency on user objects, and enable AI agents to connect to these systems. Agent users:

- Are also typically created by an agent identity blueprint.
- Are always associated to a specific agent identity, specified upon creation.
- Have distinct unique identifiers, separate from the agent identity.
- Can only authenticate by presenting a token issued to the associated agent identity.

Most AI agent implementations should use the agent identity for authentication and authorization purposes. Only when an agent needs to connect to certain systems is it required to use an agent user. Examples of such systems include Exchange mailboxes, Microsoft 365 Groups / Teams groups, and Intune RBAC. Creating agent users requires extra authorization be granted to the agent ID blueprint or service that creates these identities.

## Agent operation patterns

The agent identity platform supports two primary patterns for how agents operate and authenticate, each serving different use cases and security requirements.

### Interactive agents

Interactive agents are agents that sign-in a user and taken action in response to user prompts, often via a chat interface. These agents act on behalf of the signed-in user, utilizing that user's authorization to perform actions in various systems. Interactive agents are granted Microsoft Entra delegated permissions that allow them to act on behalf of users. Tokens issued to interactive agents are often called user tokens.

Interactive agents might run in the background for long periods of time. They might even make autonomous decisions about what actions to take. But the key feature is that they act on behalf of some human user.

### Autonomous agents

Autonomous agents are agents that perform actions using their own identity; not a human user's identity. These agents often run in the background and make autonomous decisions about what actions to take. Autonomous agents can be given access in many systems, including Azure, Intune, Purview, and many more. When autonomous agents access Microsoft Graph, they're granted Microsoft Entra application permissions. Tokens issued to autonomous agents are often called agent tokens when an agent identity is authenticated. They can also be called agent user tokens when an agent user is authenticated.

Autonomous agents might still be set up and initiated by a human user. But their access isn't bound to the user that set up the agent. Should that user exit the organization, the agent's access remains.

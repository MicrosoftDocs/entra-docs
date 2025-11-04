---
title: Agent Identity Platform Overview
description: Learn about the Microsoft Entra Agent ID Platform, a comprehensive identity, and authorization framework designed specifically for AI agents. Key concepts include agent registry, authentication protocols, tokens, claims, and agent discovery capabilities.
author: SHERMANOUKO
ms.author: shermanouko
manager: pmwongera
ms.date: 10/24/2025
ms.service: entra-id
ms.topic: concept-article
ms.reviewer: dastrock

#customer-intent: As a developer or architect, I want to understand the Agent ID Platform and its core components including identity constructs, authentication mechanisms, and token systems, so that I can build and manage AI agents with enterprise-grade identity and authorization.
---

# What is Microsoft agent identity platform

The Microsoft agent identity platform is an identity and authorization framework built to address the unique authentication, authorization, and governance challenges posed by AI agents operating in enterprise environments.

Unlike nonagentic application identities designed for web services or user identities designed for humans, the agent ID platform is purpose-built for AI agents. The platform provides specialized components that enable AI agents to authenticate securely and access resources appropriately. It also enables agents to discover other agents and operate within enterprise-grade governance frameworks.

This overview introduces the core components of the Microsoft agent ID platform. It focuses on the identity constructs, authentication mechanisms, token systems, and discovery capabilities that form the foundation of agentic identity management in enterprise environments.

## Platform architecture overview

The Microsoft agent identity platform is built on several foundational technical components that work together to provide a complete identity and authorization solution for AI agents:

- **Authentication service**: An OAuth 2.0 and OpenID Connect (OIDC) standard-compliant authentication service that enables secure, standards-based authentication for agents. This service issues tokens that agents use to authenticate to resources and APIs, supporting both application-only and delegated access scenarios.

- **SDKs**: Software development kits that enable developers and builder platforms to integrate with the Microsoft agent identity platform. SDKs abstract the complexity of token acquisition and protocol handling, making it straightforward for agent builders to incorporate agentic identity into their applications.

- **Agent management**: A comprehensive agent metadata store and administrative interface within the Microsoft Entra admin center that enables administrators to discover, view, configure, and manage agents. 

These technical components work together with the identity constructs described in the following section to provide complete platform functionality.

## Core components of the Microsoft agent ID platform

The Microsoft agent ID platform consists of four primary components that work together to provide comprehensive identity management for AI agents. Each component serves a distinct but complementary purpose in the overall system.

### Agent identity blueprint

An agent identity blueprint has a special application registration in Microsoft Entra ID that has permissions to act on behalf of Agent identities or Agent users. The application ID (Agent identity blueprint Client ID) represents the Agent ID Blueprint. The agent identity blueprint is configured with credentials (typically FIC+MSI or client certificates) and permissions to acquire tokens for itself to call graph. It's the app that you develop. It's a confidential client application.

### Agent identity

An agent identity is a special service principal in Microsoft Entra ID. It represents an identity that the agent identity blueprint created and is authorized to impersonate. It doesn't have credentials on its own. The agent identity blueprint can acquire tokens on behalf of the agent identity provided the user or tenant admin consented for the agent identity to the corresponding scopes. Autonomous agents acquire app tokens on behalf of the agent identity. Interactive agents called with a user token acquire user tokens on behalf of the agent identity.

### Agent user

An agent user is an agent identity that can also act as a user. For example, an agent identity that would have its own mailbox, or would report to you in the directory. An agent application can acquire a token on behalf of an agent user. Agent users are optional and created only when an agent requires the ability to function as a user would in organizational systems.

### Agent registry

Agent registry enables organizations to build, manage, and oversee intelligent agents at scale. The registry enables agents to discover each other, administrators to find and manage agents, and security systems to apply policies based on agent metadata and collection membership. Registry enables secure agent discovery, coordinates Agent-to-Agent (A2A) workflows, and provides the metadata layer necessary for implementing AI protocols including Agent-to-Agent Protocol and Model Context Protocol.

Every agent in the registry has an associated agent card—a standardized metadata structure that describes the agent's characteristics, capabilities, and operational parameters. The agent card follows the AgentCard schema, an open standard that promotes interoperability across platforms and ecosystems.

## Authentication and authorization protocols

The Microsoft agent ID platform uses OAuth for authorization and OpenID Connect (OIDC) for authentication.

- **OpenID Connect (OIDC)** enables agents to authenticate and verify the identity of other entities they communicate with, establishing secure trust relationships.

- **OAuth 2.0** allows agents to request access tokens that authorize them to access resources on behalf of themselves or users, supporting both application-only and delegated access scenarios.

### Tokens and token claims

Tokens are the fundamental security mechanism enabling secure communication and authorization in the Microsoft agent ID platform. Agentic tokens contain specialized claims that support the unique requirements of AI agents. The platform supports multiple token flow patterns designed for specific operational scenarios.

### Federated identity credentials (FIC)

FIC is a trust mechanism in Microsoft Entra ID that enables applications to trust each other using OpenID Connect (OIDC) tokens. In the context of agent identities, FICs are used to establish trust between the agent identity blueprints and agent identities, and agent identities and agent users.

## Integration and interoperability

The Microsoft agent ID platform is designed to work seamlessly across the Microsoft ecosystem and beyond. It integrates with:

- **Microsoft Entra ID**: The platform extends Microsoft Entra ID capabilities to support agentic scenarios, using existing identity infrastructure and policies
- **Agent builder platforms**: Platforms that create and manage agents can integrate with the Microsoft agent ID platform to secure agents. This includes both Microsoft-owned platforms like Copilot Studio and third-party agent builders. It enables builders to use the platform for authentication and authorization.
- **Extended Microsoft identity and security products**: Integration with Conditional Access, Identity Protection, identity governance, global secure access, and other security services enables comprehensive agent security

This interoperability ensures that organizations can build, deploy, and manage agent identities consistently regardless of where agents are created or deployed.

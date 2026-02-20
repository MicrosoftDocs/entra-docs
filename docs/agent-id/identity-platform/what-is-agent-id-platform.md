---
title: What is Microsoft agent identity platform
titleSuffix: Microsoft Entra Agent ID
description: Learn about the Microsoft Agent Identity Platform, a comprehensive identity, and authorization framework designed specifically for AI agents. Key concepts include agent registry, authentication protocols, tokens, claims, and agent discovery capabilities.
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 10/24/2025
ms.service: entra-id
ms.topic: concept-article
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer or architect, I want to understand the Microsoft agent identity platform and its core components including identity constructs, authentication mechanisms, and token systems, so that I can build and manage AI agents with enterprise-grade identity and authorization.
---

# What is Microsoft agent identity platform

[!INCLUDE [entra-agent-id-preview-note](../../includes/entra-agent-id-preview-note.md)]

The Microsoft agent identity platform is an identity and authorization framework built to address the unique authentication, authorization, and governance challenges posed by AI agents operating in enterprise environments.

Unlike nonagentic application identities designed for web services or user identities designed for humans, the Microsoft agent identity platform is purpose-built for AI agents. The platform provides specialized components that enable AI agents to authenticate securely and access resources appropriately. It also enables agents to discover other agents and operate within enterprise-grade governance frameworks.

This overview introduces the core components of the Microsoft agent identity platform. It focuses on the identity constructs, authentication mechanisms, token systems, and discovery capabilities that form the foundation of agent identity management in enterprise environments.

## Platform architecture overview

The Microsoft agent identity platform is built on several foundational technical components that work together to provide a complete identity and authorization solution for AI agents:

- **Authentication service**: An OAuth 2.0 and OpenID Connect (OIDC) standard-compliant authentication service that enables secure, standards-based authentication for agents. This service issues tokens that agents use to authenticate to resources and APIs, supporting both application-only and delegated access scenarios. There are three objects that form the core identity constructs in the platform: agent identity blueprint, agent identity, and agent user.

- **SDKs**: Software development kits that enable developers to integrate with the Microsoft agent identity platform. SDKs abstract the complexity of token acquisition and protocol handling, making it straightforward for platforms that build agents to incorporate identity management into their applications. Microsoft agent identity platform includes two SDKs: Microsoft Identity Web (.NET) and the Microsoft Entra SDK for agent ID.

- **Agent management**: A comprehensive agent metadata store and administrative interface within the Microsoft Entra admin center that enables administrators to discover, view, configure, and manage agents. The platform provides the agent registry that is a centralized repository for registering and managing agents across an organization.

These technical components work together with the identity constructs described in the following section to provide complete platform functionality.

## Authentication and authorization

The Microsoft agent identity platform uses OAuth for authorization and OpenID Connect (OIDC) for authentication.

- **OpenID Connect (OIDC)** enables agents to authenticate and verify the identity of other entities they communicate with, establishing secure trust relationships.

- **OAuth 2.0** allows agents to request access tokens that authorize them to access resources on behalf of themselves or users, supporting both application-only and delegated access scenarios.

For more information, see [Oauth protocols](./agent-oauth-protocols.md)

Tokens are the fundamental security mechanism enabling secure communication and authorization in the Microsoft agent identity platform. The platform supports multiple token flow patterns designed for specific operational scenarios. For more information, see [tokens in Microsoft agent identity platform](./agent-tokens.md)

## Integration and interoperability

The Microsoft agent identity platform is designed to work seamlessly across the Microsoft ecosystem and beyond. It integrates with:
- **Microsoft Entra ID**: The platform extends Microsoft Entra ID capabilities to support agent scenarios, using existing identity infrastructure and policies
- **Platforms / services that create agents**: Platforms that create and manage agents can integrate with the Microsoft agent identity platform to secure agents. This includes both Microsoft-owned platforms like Copilot Studio and third-party platforms.
- **Extended Microsoft identity and security products**: Integration with conditional access, identity protection, identity governance, global secure access, and other security services enable comprehensive agent security

This interoperability ensures that organizations can build, deploy, and manage agent identities consistently regardless of where agents are created or deployed.

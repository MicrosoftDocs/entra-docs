---
title: Fundamental concepts in Microsoft Entra Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Discover the role of agent identities in AI authentication. Understand their unique identifiers, token usage, and how they enable secure access to systems.
author: omondiatieno
ms.author: jomondi
ms.reviewer: dastrock
ms.date: 04/03/2026
ms.custom: agent-id-ignite
ms.topic: concept-article
#customer intent: As a developer, I want to understand the core concepts of agent identities and blueprints in Microsoft Entra ID so that I can implement secure authentication patterns for AI agents in my applications.
---
# Microsoft Entra Agent ID key concepts

The Microsoft agent identity platform provides specialized identity constructs designed specifically for AI agents operating in enterprise environments. These identity constructs enable secure authentication and authorization patterns that differ from traditional user and application identities, addressing the unique requirements of autonomous AI systems.

This article explains the core concepts that form the foundation of agent identity management: agent identities, agent identity blueprints, and their supporting components. Understanding these concepts is essential for developers who need to implement secure, scalable authentication patterns for AI agents.

The agent identity architecture follows a hierarchical model where agent identity blueprints serve as templates for creating multiple agent instances, each with distinct identities and capabilities. This approach enables centralized management while providing the flexibility needed for diverse AI agent deployment scenarios.

## Core identity concepts

The following concepts form the foundation of Microsoft Entra Agent ID and the Microsoft agent identity platform.

### Agent identity

An agent identity is the primary identity an AI agent uses to authenticate to systems and access resources. Unlike user accounts, agent identities don't have credentials of their own. They authenticate using tokens issued by their agent identity blueprint. For more information, see [Agent identities](agent-identities.md).

### Agent identity blueprint

An agent identity blueprint is an object in Microsoft Entra ID that serves as the template and authentication foundation for one or more agent identities. The blueprint holds credentials and uses them to acquire tokens on behalf of all agent identities created from it. Policies and settings applied to a blueprint, such as Conditional Access, take effect for all its agent identities. For more information, see [Agent identity blueprints](agent-blueprint.md).

### Agent identity blueprint principal

When a blueprint is added to a tenant, Microsoft Entra creates a corresponding principal object. An agent identity blueprint principal is the Microsoft Entra object that records a blueprint's presence in a tenant and enables it to acquire tokens and appear in audit logs. For more information, see [Agent identity blueprint principals](agent-blueprint.md#agent-identity-blueprint-principals).

### Agent's user account

An agent's user account is an optional account that pairs 1:1 with an agent identity. An agent's user account should only be used when the agent must access systems that require a user object, such as Exchange Online mailboxes or Teams channels. It doesn't replace the agent identity; both must exist. For more information, see [Agent's user accounts](./agent-users.md).

### Service principal (not recommended for AI agents)

Service principals were designed for static, deterministic workloads. Microsoft Entra Agent ID exists because service principals lack the governance infrastructure AI agents need. There's no enforced sponsorship, no agent-aware audit entries, and no blueprint-managed lifecycle. For more information, see [Agent identities, service principals, and applications](./agent-service-principals.md).

### Regular user account (not recommended for AI agents)

Regular Microsoft Entra user accounts are designed for human sign-in patterns. Assigning them to AI agents causes failures across every Zero Trust enforcement layer: Conditional Access policies built for humans don't apply correctly to agents, ID Protection detections are degraded, and identity governance processes can incorrectly remove agent access. For more information, see [Plan your agent identity architecture](../identity-professional/plan-agent-identity-architecture.md).

## Agent operation patterns

The agent identity platform supports two primary patterns for how agents operate and authenticate, each serving different use cases and security requirements.

- **Interactive agents** are agents that sign-in a user and taken action in response to user prompts, often via a chat interface. These agents act *on behalf of* the signed-in user, utilizing that user's authorization to perform actions in various systems. Interactive agents are granted Microsoft Entra delegated permissions that allow them to act on behalf of users. Tokens issued to interactive agents are often called user tokens.

- **Autonomous agents** are agents that perform actions using their own identity; not a human user's identity. These agents often run in the background and make autonomous decisions about what actions to take. Tokens issued to autonomous agents are often called agent tokens when an agent identity is authenticated. They can also be called agent's user account tokens when an agent's user account is authenticated.

## Agent owners, sponsors, and managers

The agent identity platform introduces an administrative model that separates technical administration from business accountability, ensuring operational control and compliance oversight without excessive permissions. The agent administrative roles include owners, managers, and sponsors.

- **Owners** serve as technical administrators for agents, handling operational and configuration aspects.
- **Sponsors** provide business accountability for agents, making lifecycle decisions without technical administrative access.
- **Managers** are human users who are designated as the hiring manager or operational owner for an agent's user account.

For more information, see [Administrative relationships for agent identities (Owners, sponsors, and managers)](agent-owners-sponsors-managers.md)

## Microsoft Entra SDK for agent ID

The Microsoft Entra SDK for AgentID is a containerized web service that handles token acquisition, validation, and secure downstream API calls for agents registered in the Microsoft identity platform. It runs as a companion container alongside your application, allowing you to offload identity logic to a dedicated service. For more information, see [Microsoft Entra SDK for agent ID](/entra/msidweb/agent-id-sdk/overview)

## Related content

- [What is an agent ID?](what-are-agent-identities.md)
- [What is the agent identity platform?](what-is-agent-id-platform.md)
- [Microsoft Entra Agent ID oauth protocols](agent-oauth-protocols.md)
- [Create an agent identity blueprint](create-blueprint.md)

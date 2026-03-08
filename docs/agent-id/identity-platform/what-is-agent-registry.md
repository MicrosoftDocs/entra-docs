---
title: What is the Microsoft Entra Agent Registry?
description: Learn about the Agent Registry, a centralized metadata repository that enables agent discovery, and secure communication in enterprise environments.
author: shlipsey3
ms.author: sarahlipsey
ms.service: entra
ms.topic: concept-article
ms.date: 11/07/2025
ms.reviewer: jadedsouza
ms.custom: agent-id-ignite

#customer-intent: As a developer or IT administrator, I want to understand what the Agent Registry is and how it provides a centralized identity directory that enables secure agent discovery, so that I can build customer trust and drive adoption through effective agent ecosystem management in my organization.
---

# What is the Microsoft Entra Agent Registry?

[!INCLUDE [entra-agent-id-preview-note](../../includes/entra-agent-id-preview-note.md)]

AI agents are rapidly becoming part of enterprise workflows, such as handling data retrieval, orchestration, and autonomous decisions. For this reason, organizations face growing security and compliance risks without centralized visibility and control over these agents. The Agent Registry, as part of the [Microsoft Entra Agent ID](../identity-professional/microsoft-entra-agent-identities-for-ai-agents.md) system, solves this challenge by providing an extensible metadata repository that delivers a unified view of all deployed agents across Microsoft platforms and non-Microsoft ecosystems.

To learn more about Agent Registry, review the following articles:

- [Register agents with the registry](publish-agents-to-registry.md)
- [Agent Registry collections](agent-registry-collections.md)
- [Manage collections](agent-registry-manage-collections.md)
- [Agent Registry metadata and discoverability](agent-metadata-discoverability.md)
- [Agent communication](registry-agent-to-agent-protocol.md)

Agent Registry integrates with Microsoft Entra Agent ID and Core Directory to enforce identity and discovery policies, supports flexible mappings between agent cards and multiple agent instances, and acts as the single source of truth for agent-related data. By combining comprehensive visibility, rich metadata management, and collection-based policies, the registry helps organizations secure agent discovery, apply Zero Trust principles, and maintain governance across diverse environments. The Agent Registry delivers following critical capabilities and benefits to customers: 

- **Comprehensive inventory and visibility**: Maintains an inventory of all deployed agents running in your environment, whether or not they have an agent identity and supporting external agents and providers.
- **Discovery before access and policy enforcement**: Introduces built-in and custom controls with [agent collections](agent-registry-collections.md) and policies to reduce exposure and align with Zero Trust principles.
- **Rich metadata for governance across ecosystems**: Captures detailed [metadata](agent-metadata-discoverability.md) for each agent, using open standards for [collaboration](registry-agent-to-agent-protocol.md) and a flexible schema, enabling customers to apply policies that limit discoverability and enforce security.

## Registry Architecture & Components

The Agent Registry acts as the central store for agent-related data, including [agent identities](agent-identities.md), [agent users](agent-users.md), [agent identity blueprints](agent-blueprint.md), and other identity attributes. Each agent instance from an authoritative agent store, such as Copilot Studio, is registered in the Registry and linked to an agent card manifest, which can represent multiple agents (1:N relationship). These components are the manifests that provide the agent's metadata. 

The registry then connects to the Microsoft Entra Core Directory, which enforces identity and entitlement policies. The agent identity blueprints define reusable identity templates that can map to multiple agent instances, enabling flexible identity governance. Each agent instance also has a direct 1:1 relationship with an agent identity and optionally an agent user, ensuring policy enforcement and lifecycle management. This capability mirrors human identity principles in Microsoft Entra, providing a single source of truth for agent identity, metadata, and governance while supporting one-to-many mappings for scalability.

The registry enables organizations to map diverse agent data sources, identify systems of authority, and route users to the correct endpoints. The following diagram explains the relationship between various key attributes.

:::image type="content" source="media/what-is-agent-registry/agent-registry-diagram.png" alt-text="Diagram depicting the relationship between Agent Registry and Microsoft Entra Agent ID." lightbox="media/what-is-agent-registry/agent-registry-diagram.png":::

The following table summarizes the core components of the Agent Registry:

| Component | Purpose | Key Features | Benefits |
|-----------|---------|--------------|----------|
| **Metadata store** | Centralized agent metadata repository | NoSQL-based, agent card manifest support, real-time updates | Scalable storage for rich agent information and agent communication compliance |
| **Collections** | Secure agent categorization and discovery control enforcement | Baseline discovery controls, custom collections | Secure-by-default discovery boundaries and clearer governance |
| **Discovery service** | Agent and capability discovery APIs | Multi-dimensional search, collection-aware filtering, skill-based discovery | Enables secure, intelligent agent-to-agent coordination |
| **Integration layer** | Coordinates with Microsoft and non-Microsoft ecosystems | Ecosystem-wide security operations and custom workflows | Registry acts as a central store to map your data across different stores |

## How Agent Registry enables security for AI

Security is embedded at every layer of the Agent Registry:

- **Identity Assurance**: Microsoft platforms fully integrated with the Microsoft Entra Agent ID Platform automatically receive an agent identity and are enrolled in the registry.
- **Runtime Enforcement**: Discovery policies are enforced dynamically when agents attempt discovery, preventing unauthorized actions. This enforcement works together with Microsoft Entra Agent ID, which controls authentication as well as discovery of agents within the registry. Only agents with agent identity are allowed to discover other agents in the registry, but they can find other agents without agent ID.

## Related content

- [Publish agents to registry](publish-agents-to-registry.md)
- [Agent Registry metadata and discoverability](agent-metadata-discoverability.md)
- [Agent Registry collections](agent-registry-collections.md)
- [What is an agent ID?](what-is-agent-id.md)

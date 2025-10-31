---
title: What is the Microsoft Entra agent registry?
description: Learn about the agent registry, a centralized metadata repository that enables agent discovery, and secure communication in enterprise environments.
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: concept-article
ms.date: 10/13/2025
ms.reviewer: dastrock

#customer-intent: As a developer or IT administrator, I want to understand what the agent registry is and how it provides a centralized identity directory that enables secure agent discovery, so that I can build customer trust and drive adoption through effective agent ecosystem management in my organization.
---

# What is the Microsoft Entra agent registry?

Microsoft Entra agent registry is a centralized identity directory within Microsoft agent ID platform that provides discovery, and coordination capabilities for AI agent ecosystems. The agent registry is built on an Attribute-Based Access Control (ABAC) framework and an innovative collection-based authorization model. It enforces secure-by-default access controls for enterprise AI deployments that build customer trust and drive adoption.

The agent registry serves as a shared cloud service that empowers organizations to build, manage, and oversee intelligent agents at scale. As the foundational infrastructure for agent ecosystems, the registry enables secure agent discovery, coordinates complex Agent-to-Agent (A2A) workflows, and provides the metadata layer necessary for implementing advanced AI protocols including Google's Agent-to-Agent Protocol and Model Context Protocol (MCP).

The registry system integrates with Microsoft Entra ID and extends across platforms like Copilot Studio. It provides a unified approach to agent metadata management that drives UX innovation across the ecosystem. For third-party agent builders, an open registry API enables integration to maintain consistent metadata and discovery experiences without requiring native platform support.

## How agent registry enables security for AI

The agent registry provides enterprise-grade security for AI through a comprehensive framework that combines secure-by-default policies, and Zero Trust principles embedded across the entire agent ecosystem.

- **ABAC framework with collection-based authorization**: Built on Attribute-Based Access Control (ABAC) with an innovative collection-based security model that automatically categorizes agents into secure collections with predefined policies, ensuring immediate protection from day one.

- **Secure-by-default access controls**: Baseline security access controls are automatically applied to all agents based on their collection assignment. This feature provides visibility into when and how agents access systems, including access controls that block quarantined agents, and discovery restrictions for sensitive agents and high-risk agents.

- **Zero Trust and defense-in-depth**: Embeds Zero Trust principles with continuous monitoring, and risk assessment. At the same time, it integrates with Microsoft's security ecosystem including Conditional Access, Purview DLP, Defender, and Security Copilot.

- **Token revocation and incident response**: Supports instant token revocation and automated security responses across all integrated platforms when threats are detected, enabling rapid containment and remediation.

## Core functions

The following are the core functions of the Microsoft Entra agent registry:

- Stores agent metadata: Includes agent information like skills, version, and the originating publisher. 

- Enables agent discovery and interaction: Supports Agent-to-Agent (A2A) communication and discoverability. 

- Integration with security and compliance tools: Works with Microsoft Entra, Purview, A365, and other platforms for end to end governance and compliance 

- Collections/Groupings of Agents: Enabling admins to organize agents by trust level, function, or policy requirements, making controls over agent discovery easier. Collections also have secure-by-default policies applied to them.

## Registry architecture and components

The agent registry system consists of several integrated components that work together to provide comprehensive metadata management and discovery capabilities.

| Component | Purpose | Key Features | Benefits |
|-----------|---------|--------------|----------|
| **Metadata Store** | Centralized agent metadata repository | NoSQL-based, Agent Card support, real-time updates | Scalable storage for rich agent information and A2A protocol compliance. For more information, see [Agent registry metadata](placeholder-link). |
| **Collection System** | Secure agent categorization and access control enforcement | baseline access controls, custom collections | Secure-by-default organization. For more information, see [Agent registry collections](agent-registry-collections.md). |
| **Discovery Service** | Agent and capability discovery APIs | Multi-dimensional search, collection-aware filtering, skill-based discovery | Enables secure, intelligent agent-to-agent coordination |
| **Integration Layer** | Cross-platform and security system coordination | Microsoft Security Copilot, Defender, Purview integration | Enables ecosystem-wide security operations and custom workflows |

## Registry as a shared cloud service

The agent registry functions as a foundational shared cloud service that enables UX innovation and ecosystem growth by providing common infrastructure that reduces complexity for agent developers and platforms.

### Enabling ecosystem innovation

The agent registry enables innovation by providing shared infrastructure that eliminates the need for teams to build duplicate systems for metadata management and security. It allows developers to focus on creating compelling agent capabilities and user experiences rather than foundational infrastructure.

The registry also supports seamless integration with external platforms through standardized APIs and Model Context Protocol (MCP) Dynamic Client Registration, enabling both Microsoft and third-party agent ecosystems to work together effectively.

### Deployment and service models

The agent registry meets organizational needs across all deployment scenarios. The service provides essential baseline security access controls, default collection structures, and automatic detection of unmanaged agents. This feature establishes the registry as the central hub for agent identity and security at no cost. Advanced capabilities include custom collection creation, custom access control management, and extended security integrations with Microsoft's security ecosystem.

The service supports flexible deployment patterns for single-tenant organizational registries, enabling agent discovery and coordination within organizational boundaries. Organizations can use both manually created agent ID blueprints for specific use cases. They can also use dynamic agent ID blueprint creation through agent builder applications for scalable multi-instance scenarios.

### Coordination protocols

The agent registry enables coordination between agents through the Agent-to-Agent (A2A) protocol, using registry metadata to establish secure, authenticated communication channels that enable direct collaboration while maintaining appropriate security and audit controls.

At run-time, the registry applies operational constraints related to security policies onto agents based on registry metadata and current system state, ensuring optimal collaboration and resource utilization.

## Related content

- Publish agents to registry
- Agent registry schema and metadata
- Collection-based models

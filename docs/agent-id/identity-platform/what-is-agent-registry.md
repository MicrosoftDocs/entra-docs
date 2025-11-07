---
title: What is the Microsoft Entra agent registry?
titleSuffix: Microsoft Entra Agent ID
description: Learn about the agent registry, a centralized metadata repository that enables agent discovery, and secure communication in enterprise environments.
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: jadedsouza

#customer-intent: As a developer or IT administrator, I want to understand what the agent registry is and how it provides a centralized identity directory that enables secure agent discovery, so that I can build customer trust and drive adoption through effective agent ecosystem management in my organization.
---

# What is the Microsoft Entra agent registry?

Microsoft Entra agent registry is a centralized identity directory within Microsoft agent ID platform that provides discovery, and coordination capabilities for AI agent ecosystems. The agent registry is built on an Attribute-Based Access Control (ABAC) framework and a collection-based authorization model. It enforces secure-by-default discovery controls for enterprise AI deployments that build customer trust and drive adoption.

## Core functions

The agent registry serves three main functions:

- **Inventory for all agents**: The registry maintains a comprehensive inventory of all registered agents. This inventory is crucial for effective agent management and orchestration. It provides visibility into the agents deployed within an organization, their capabilities, and their operational status enabling organizations to manage agent sprawl.

- **Metadata(security and partner integrations)**: The registry enables secure agent discovery, coordinates Agent-to-Agent (A2A) workflows, and provides the metadata layer necessary for implementing advanced AI protocols including Agent-to-Agent Protocol and Model Context Protocol (MCP). The registry system integrates with Microsoft Entra ID and extends across platforms like Copilot Studio, Foundry, and Agent 365 (A365). For third-party agent builders, the registry API enables integration to maintain consistent metadata and discovery experiences without requiring native platform support. Agent metadata includes agent information like skills, version, and the originating publisher.

- **Agent collaboration(collections/policies)**: The registry facilitates collaboration between agents by enabling the creation and management of collections and policies that govern agent interactions. This enables admins to organize agents by trust level, function, or policy requirements, making controls over agent discovery easier. Collections also have secure-by-default policies applied to them.

## Registry architecture and components

The agent registry system consists of several integrated components that work together to provide comprehensive metadata management and discovery capabilities.

| Component | Purpose | Key Features | Benefits |
|-----------|---------|--------------|----------|
| **Metadata store** | Centralized agent metadata repository | NoSQL-based, Agent Card support, real-time updates | Scalable storage for rich agent information and A2A protocol compliance. For more information, see [Agent registry metadata](agent-metadata-discoverability.md). |
| **Collection system** | Secure agent categorization and discovery control enforcement | baseline discovery controls, custom collections | Secure-by-default organization. For more information, see [agent registry collections](agent-registry-collections.md). |
| **Discovery service** | Agent and capability discovery APIs | Multi-dimensional search, collection-aware filtering, skill-based discovery | Enables secure, intelligent agent-to-agent coordination |
| **Integration layer** | Cross-platform and security system coordination | Microsoft Security Copilot, Defender, Purview integration | Enables ecosystem-wide security operations and custom workflows |

## How agent registry enables security for AI

The agent registry provides security for AI through secure-by-default discovery controls that follow Zero Trust principles. The two main features that enable security for AI are:

- **ABAC framework with collection-based authorization**: Built on Attribute-Based Access Control (ABAC) with an innovative collection-based security model that automatically categorizes agents into secure collections with predefined policies, ensuring immediate protection from day one.

- **Secure-by-default discovery controls**: Baseline agent discovery controls are automatically applied to all agents based on their collection assignment. This feature provides visibility into how agents discover one another including discovery restrictions for sensitive agents and high-risk agents. At run-time, the registry applies security policies onto agents.

## Agent ID relationship with the agent registry

For agents to be discoverable in the agent registry, they must have an associated agent ID. The agent ID serves as the identity provider for the agent and enables secure authentication and authorization. Agents without an agent ID can still be registered in the registry but they can't discover other agents. Agents need to have an agent ID to query the registry. Publishing an agent to the registry doesn't automatically grant them an agent ID. However, agents created from Microsoft owned platforms like Copilot Studio, foundry, and A365 automatically get an agent ID when they're created.

## Related content

- [Publish agents to registry](publish-agents-to-registry.md)
- [Agent registry schema and metadata](agent-metadata-discoverability.md)
- [Collection-based models](agent-registry-collections.md)
- [What is an agent ID](what-is-agent-id.md)
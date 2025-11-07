---
title: What is the Microsoft Entra Agent Registry?
description: Learn about the Agent Registry, a centralized metadata repository that enables agent discovery, and secure communication in enterprise environments.
author: omondiatieno
ms.author: jomondi
ms.service: entra
ms.topic: concept-article
ms.date: 11/06/2025
ms.reviewer: jadedsouza
ms.custom: agent-id

#customer-intent: As a developer or IT administrator, I want to understand what the Agent Registry is and how it provides a centralized identity directory that enables secure agent discovery, so that I can build customer trust and drive adoption through effective agent ecosystem management in my organization.
---

# What is the Microsoft Entra Agent Registry?

The Microsoft Entra Agent Registry, together with the rest of the [Microsoft Entra Agent ID](../identity-professional/microsoft-entra-agent-identities-for-ai-agents.md) platform, serves as the authoritative identity and metadata layer for AI agents in Microsoft Entra. It provides organizations with a centralized way to manage and secure agent discovery across Microsoft platforms, such as Copilot Studio, Agent 365, and Azure AI Foundry, and non-Microsoft ecosystems.

The Agent Registry functions as a "metaverse" for agents, where all agent inventory resides. With all agent data centralized in the registry, security policies and principles can be consistently applied across the entire agent ecosystem. Discovery before access, for example, means the registry enforces security early, reduces exposure, and aligns with Zero Trust principles. The registry integrates with Microsoft Entra Agent ID and Core Directory to apply identity and entitlement policies, supports complex mappings between agent cards and multiple agent instances, and serves as the single source of truth for agent-related data. Ultimately, the registry helps organizations establish the right system of authority and route users to trusted endpoints for compliance and governance.

Agent Registry provides several key capabilities and benefits:

- **Comprehensive inventory and visibility** of all agents running in your environment, whether or not they have an agent identity.
- **Discovery before access and policy enforcement** to reduce exposure and align with Zero Trust principles.
- **Integration and governance across the Microsoft ecosystem** using identity and entitlement policies and centralized agent data.
- **Trusted routing and compliance** to identify the right system of authority and route users and agents to trusted endpoints.

## Registry’s role in the Agent ID Platform

AI agents are becoming core to enterprise workflows, performing tasks such as data retrieval, orchestration, and autonomous decision-making. Without centralized visibility and control, these agents can introduce security and compliance risks. The Agent Registry addresses these challenges by:

- Providing comprehensive visibility into all agents running in your environment, whether or not they have an agent identity.
- Acting as an authoritative source of critical [metadata](../identity-platform/agent-metadata-discoverability.md) for each agent to enable security controls and collaboration.
- Enforcing [discovery policies](#registry-architecture-and-components) that support Zero Trust principles for agent-to-agent and agent-to-service interactions.

Agent Registry also plays a role with agent identities, storing information such as agent user identities, agent blueprint identities and more. Agent Registry also enables 1:M relationships between agent cards and agents, similar to agent identity blueprints.

## Core functions

The Agent Registry serves several key capabilities:

- **Inventory for all running agents**: The registry maintains a comprehensive inventory of every agent within a Microsoft tenant, whether built on platforms like Copilot Studio or Azure AI Foundry, and supports onboarding of non-Microsoft identity providers and agents (e.g., Google Vertex, OpenAI) via APIs, ensuring interoperability across ecosystems. The registry contains a superset of agents: those with an agent identity and those without. It provides this list independently of usage frequency. Whether an agent runs daily or only once a month, the registry ensures visibility and governance for all registered agents.

- **Metadata management**: Stores rich metadata for each agent, including:
   - Skills and capabilities
   - Version and publisher details
   - Communication endpoints and protocols

- **Agent discovery and interaction**: Enables [agent collaboration](registry-agent-to-agent-protocol.md) and secure interaction through collections, which control discoverability and enforce security policies. These capabilities allow agents to collaborate and complete tasks across workloads.

- **Security & Compliance Integration**: Works seamlessly across Agent 365, Purview, and other Microsoft platforms for end-to-end visibility on your tenant, including limiting discoverability and implementing secure by default design.

## Registry architecture and components

The registry acts as the central store for agent-related data, including agent user identities, agent blueprint identities, and other identity attributes. Each agent instance from an authoritative agent store (e.g., Copilot Studio) is registered in the registry and linked to an agent card manifest, which can represent multiple agents (1:N relationship). These manifests provide rich metadata for governance and discovery.

The registry then connects to the Microsoft Entra Core Directory, which enforces identity and entitlement policies. Here, the agent identity blueprints define reusable identity templates that can map to multiple agent instances, enabling flexible identity governance. Each agent instance also has a direct 1:1 relationship with an agent identity and optionally an agent user, ensuring policy enforcement and lifecycle management. This relationship mirrors human identity principles in Microsoft Entra, providing a single source of truth for agent identity, metadata, and governance while supporting one-to-many mappings for scalability.

The registry enables organizations to map diverse agent data sources, identify systems of authority, and route users to the correct endpoints. The following diagram explains the relationship between various key attributes.

:::image type="content" source="media/what-is-agent-registry/agent-registry-diagram.png" alt-text="Diagram depicting the relationship between Agent Registry and Microsoft Entra Agent ID." lightbox="media/what-is-agent-registry/agent-registry-diagram.png":::

| Component | Purpose | Key Features | Benefits |
|-----------|---------|--------------|----------|
| **Metadata store** | Centralized agent metadata repository | NoSQL-based, Agent Card support, real-time updates | Scalable storage for rich agent information and agent communication compliance |
| **Collection system** | Secure agent categorization and discovery control enforcement | baseline discovery controls, custom collections | Secure-by-default organization |
| **Discovery service** | Agent and capability discovery APIs | Multi-dimensional search, collection-aware filtering, skill-based discovery | Enables secure, intelligent agent-to-agent coordination |
| **Integration layer** | Cross-platform and security system coordination | Microsoft Security ecosystem integrations | Security operations and custom workflows, using the registry as a central store to map your data |

## How Agent Registry enables security for AI

Security is embedded at every layer of the Agent Registry:

- **Identity Assurance**: Microsoft platforms fully integrated with the Microsoft Entra Agent ID Platform automatically receive an agent identity and are enrolled in the registry.
- **Runtime Enforcement**: Discovery policies are enforced dynamically when agents attempt discovery, preventing unauthorized actions. This enforcement works together with Microsoft Entra Agent ID, which controls authentication as well as discovery of agents within the registry. Only agents with agent identity are allowed to discover other agents in the registry, but they can find other agents without agent ID.
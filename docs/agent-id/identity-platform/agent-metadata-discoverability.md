---
title: Agent metadata and discoverability patterns
description: Learn how to structure agent metadata for optimal discoverability in Microsoft Entra Agent Registry and understand how the collections model affects agent visibility.
author: shlipsey3
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/07/2025
ms.author: sarahlipsey
ms.custom: agent-id-ignite

#Customer intent: As a developer creating agents, I want to understand how to structure agent metadata for optimal discoverability and how the collections model affects agent visibility, so that my agents can be found by the right users and applications.
---

# Agent metadata and discoverability patterns

Agent metadata serves as the foundation for agent discoverability within Microsoft Entra Agent Registry. The metadata you provide determines how other agents, applications, and users can find and interact with your agent. Understanding the metadata schema and its relationship to the collections model ensures your agents are discoverable by the intended audience while maintaining appropriate security boundaries.

## Agent metadata schema

The agent metadata schema defines the information structure required for agent discoverability and interaction. This schema allows for agent collaboration through standard protocols while extending it with Microsoft Entra-specific capabilities for enhanced security.

### Basic agent information

The foundational metadata includes essential identification and contact information for your agent.

| Field | Description |
|-------|-------------|
| `id` | Unique identifier for the agent manifest. Required for all agent registrations. |
| `displayName` | Human-readable identifier that appears in discovery results. Should clearly indicate the agent's purpose, such as "Customer Support Assistant" or "Invoice Processing Agent." |
| `description` | Comprehensive details about the agent's purpose and capabilities. Include relevant keywords that your target audience would naturally use when searching for this type of agent, directly impacting discoverability. |
| `iconUrl` | URL to the agent's icon image, providing visual identification in discovery results and user interfaces. |
| `version` | Version of the agent implementation, enabling tracking of agent updates and compatibility considerations for integration scenarios. |
| `documentationUrl` | URL to the agent's documentation. Include links to detailed API documentation, usage examples, and troubleshooting guides to support successful agent adoption. |
| `protocolVersion` | Protocol version supported by the agent, ensuring compatibility with clients and other agents during communication. |
| `provider` | Information about the organization providing the agent, including organization name and contact URL. Helps identify the source of agents during discovery and provides verification points for agent authenticity. |
| `managedBy` | Application identifier managing this manifest, establishing clear ownership and responsibility for the agent's lifecycle and configuration. |
| `originatingStore` | Name of the store or system where the agent originated, helping track agent sources and lineage within the registry. |

### Skills and capabilities metadata

The core functionality and interaction capabilities your agent provides.

| Field | Description |
|-------|-------------|
| `skills` | Core functionality your agent provides. Each skill requires a unique identifier, descriptive name, and detailed description that explains what the skill accomplishes. Directly determines discoverability in capability-based searches. |
| `defaultInputModes` | Default input modes supported by the agent. Use consistent MIME type specifications such as "text/plain," "application/json," or "image/png" to ensure proper matching with client applications. |
| `defaultOutputModes` | Default output modes supported by the agent. Specify the data formats your agent produces, enabling automatic compatibility checking during agent discovery. |
| `capabilities` | Technical features your agent supports for integration protocols. |
| `capabilities.extensions` | Extension capabilities containing properties including URI, description, required status, and parameters. Affects how other agents and applications interact with your agent during federation scenarios. |

### Security and provider information

Security and authentication requirements that affect discoverability, trust, and access policies. Security and provider information directly affect how Microsoft Entra Agent Registry applies collection assignment and discovery policies to your agent, making these fields critical for proper management and compliance.

| Field | Description |
|-------|-------------|
| `securitySchemes` | Dictionary of security scheme definitions keyed by scheme name, specifying the authentication methods your agent supports. Ensures your agent appears in discovery results only for clients that can meet the authentication requirements. |
| `security` | Array of security scheme references that apply to different operations. Defines security requirements that prevent failed integration attempts and improve user experience by filtering incompatible matches during discovery. |
| `signatures` | Digital signatures for the manifest, including protected content, signature values, and header information for verifying manifest integrity and authenticity. |
| `supportsAuthenticatedExtendedCard` | Indicates whether your agent provides more metadata for authenticated callers. Enables progressive disclosure of information, where basic capabilities are publicly discoverable while detailed operational information requires authentication. |
| `ownerIds` | List of owner identifiers who have authority over the agent manifest. |

## Collections and discoverability

Collections determine which agents can discover each other and establish communication channels. Agents must be explicitly assigned to collections by administrators or through defined organizational policies. There are no automatic assignments based on metadata tags or agent characteristics. This explicit assignment model ensures proper governance and security controls over agent discoverability and interaction patterns.

For comprehensive information about collection types, assignment rules, and discovery policies, see [Agent registry collections](agent-registry-collections.md).

## Related content

- [Publish agents to registry](publish-agents-to-registry.md)
- [Agent registry collections](agent-registry-collections.md)
- [What is the agent registry?](what-is-agent-registry.md)
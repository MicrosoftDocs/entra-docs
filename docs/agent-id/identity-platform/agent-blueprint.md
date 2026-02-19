---
title: Agent identity blueprints in Microsoft Entra Agent ID
description: Understand agent identity blueprints, how agents are defined, and how authentication works within the Agent ID platform.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.service: entra-id
ms.topic: concept-article

#customer intent: As a developer or IT administrator building AI agents, I want to understand agent identity blueprints so that I can properly create, authenticate, and manage agent identities within my organization's Microsoft Entra environment.
---

# Agent identity blueprints in Microsoft Entra Agent ID

An agent identity blueprint is an object in Microsoft Entra ID that serves as a template for creating agent identities. It establishes the foundation for how agents are created, authenticated, and managed within an organization.

## Defining an agent identity blueprint

:::image type="content" source="media/agent-blueprint/agent-blueprint.png" alt-text="Diagram showing relationship between agent identity and agent identity blueprint.":::

All agent identities in a Microsoft Entra ID tenant are created from an agent identity blueprint. The agent identity blueprint is a key component of the Microsoft agent identity platform that enables secure development and administration of AI agents at scale. An agent identity blueprint serves four purposes.

- **Blueprints are a template for agent identities.**

    Organizations can deploy many instances of an AI agent. Each instance pursues a different goal and requires a different level of access. Each instance uses a distinct agent identity for authentication and access. However, the many agent identities used share certain characteristics. The agent identity blueprint records these common characteristics, so that all agent identities created using the blueprint have a consistent configuration.

    An agent identity blueprint has the following properties that are shared across all its agent identities:

    - `description`: A brief summary of the agent's purpose and functions.
    - `appRoles`: Define the roles that can be given to users and other principals when using the agent.
    - `verifiedPublisher`: The organization that built the agent.
    - Settings for authentication protocols, such as `optionalClaims`: Configure which information is included in access tokens issued to the agent.

    These settings are configured on a blueprint so that they're consistent across all agent identities created using the blueprint.

    The full schema is available in the Microsoft Graph API reference documentation.

- **Blueprints create agent identities.**

    Blueprints don't just hold information. They're also a special identity type in a Microsoft Entra ID tenant. A blueprint can perform exactly one operation in the tenant: provision or deprovision agent identities. To create an agent identity, a blueprint has:

    - An OAuth client ID: a unique ID used to request access tokens from Microsoft Entra ID.
    - Credentials: used to request access tokens from Microsoft Entra ID.
    - `AgentIdentity.CreateAsManager`: a special Microsoft Graph permission that enables the blueprint to create agent identities in the tenant.

    A service uses the blueprint's client ID, credentials, and permissions to send agent identity creation requests via Microsoft Graph APIs. The agent identities created by a blueprint share common characteristics.

    For more information, see [create agent identities](./create-delete-agent-identities.md).

- **Blueprints hold credentials for agent identities.**

    Each agent identity doesn't have its own credentials. Instead, the credentials used to authenticate an agent identity are configured on the blueprint. When an AI agent wants to perform an operation, the credentials configured on the blueprint are used to request an access token from Microsoft Entra ID.

    For auth protocols, see [Agent ID authentication protocols](./agent-oauth-protocols.md)

- **Blueprints are a container for agent identities.**

    Identity administrators can apply policies and settings to agent identity blueprints that take effect for all agent identities created using the blueprint. Examples include:

    - Conditional access policies applied to a blueprint take effect for all its agent identities.
    - OAuth permissions granted to a blueprint are granted to all its agent identities.
    - Disabling blueprints prevents all its agent identities from authenticating.

    The blueprint provides a logical container for agent identities on which many different identity administration operations can be performed. This helps administrators scale their security efforts to large numbers of AI agents.

## Agent identity blueprint principals

An agent identity blueprint principal is an object in Microsoft Entra Agent ID that represents the presence of an agent identity blueprint within a specific tenant. When an agent identity blueprint application is added to a tenant, Microsoft Entra creates a corresponding principal object, which is the agent identity blueprint principal.

:::image type="content" source="media/agent-blueprint/agent-blueprint-principal.png" alt-text="Diagram showing illustration of an agent blueprint principal.":::

This principal serves several important roles:

- **Token Issuance**: When the agent identity blueprint is used to acquire tokens within a tenant, the resulting token's `oid` (object ID) claim references the agent identity blueprint principal. It ensures that any authentication or authorization performed by the agent identity blueprint is traceable to its principal object in the tenant.

- **Audit Logging**: Actions performed by the agent identity blueprint, such as creating agent identities, are recorded in audit logs as being executed by the agent identity blueprint principal. It provides clear accountability and traceability for operations initiated by the agent identity blueprint.

Agent identity blueprints are always created in a Microsoft Entra tenant. An agent identity blueprint is often used to create agent identities in that same tenant. These agent identity blueprints are called "single-tenant." Agent identity blueprints can also be configured as "multitenant" and published to potential customers via Microsoft catalogs. Customers can then add these blueprints to their tenant, so that they can be used to create agent identities.

In either case, an agent identity blueprint principal is always created when a blueprint is added to a tenant. The presence of this principal indicates that a blueprint exists in a tenant and can be used to create agent identities. Customers can remove a blueprint from their tenant by deleting the agent identity blueprint principal.

## Create an agent identity blueprint

There are multiple ways to create an agent identity blueprint in Microsoft Entra Agent ID. For more information, see [agent identity blueprint](./create-blueprint.md).

## Credentials for agent identities

There are several credentials types that can be used for agent identities. For more information on these, see [credentials for agent identities](./agent-identities.md#credentials-for-agent-identities).

## Related content

- [Agent identity blueprint creation channels](../identity-professional/agent-id-creation-channels.md)
- [Create an agent identity blueprint](./create-blueprint.md)

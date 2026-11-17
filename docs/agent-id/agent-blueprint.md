---
title: Agent identity blueprints in Microsoft Entra Agent ID
description: Understand agent identity blueprints, how agents are defined, and how authentication works within the Agent ID platform.
titleSuffix: Microsoft Entra Agent ID
ms.date: 11/06/2026
ms.topic: concept-article
ai-usage: ai-assisted

#customer-intent: As a developer or IT administrator building AI agents, I want to understand agent identity blueprints so that I can properly create, authenticate, and manage agent identities within my organization's Microsoft Entra environment.
---

# Agent identity blueprints in Microsoft Entra Agent ID

An agent identity blueprint is an object in Microsoft Entra ID that serves as a template for creating agent identities. It establishes the foundation for how agents are created, authenticated, and managed within an organization. The agent identity blueprint is a key component of the Microsoft agent identity platform that enables secure development and administration of AI agents at scale.

:::image type="content" source="media/agent-blueprint/agent-blueprint.png" alt-text="Diagram showing relationship between agent identity and agent identity blueprint.":::

Blueprints hold the configuration used to create and authenticate agent identities. The instance mode determines whether a blueprint represents one agent identity or provides a template for multiple identities.

## Agent identity blueprints

An agent identity blueprint defines authentication settings, permissions, and other properties shared by its agent identities.

A multi-instance blueprint can create multiple Agent IDs of the same type in a tenant. Each identity has its own permissions, while credentials and authentication settings are configured on the blueprint.

An agent identity blueprint has the following properties that are shared across all its agent identities:

- **Description**: A brief summary of the agent's purpose and functions.
- **App roles**: Declare roles for access to the agent API. For single-instance inbound user access, also publish the same user role directly on the Agent ID service principal.
- **Verified publisher**: The organization that built the agent.
- **Settings for authentication protocols**: Configure which information is included in access tokens issued to the agent, such as **OptionalClaims**.

The full schema is available in the [Microsoft Graph API reference documentation](/graph/api/resources/agentidentityblueprint).

## Instance modes (preview)

> [!IMPORTANT]
> Agent identity blueprint instance modes are in preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

An agent identity blueprint has an instance mode that determines how many Agent IDs it can create in each tenant.

| Property | Single-instance | Multi-instance |
| --- | --- | --- |
| Agent identities per blueprint in a tenant | One. | One or more, each with a separate identity. |
| OAuth client ID | The blueprint and Agent ID share the blueprint's `appId`. | Each Agent ID has its own client ID. |
| Blueprint principal | None. | Represents the blueprint in the tenant. |
| Token acquisition | The Agent ID requests a token directly, using the shared client ID. | The blueprint obtains an exchange token to impersonate a child Agent ID. |
| Permissions | Granted directly to the Agent ID. | Granted directly to the Agent ID or inherited from the blueprint principal. |

The blueprint and Agent ID are separate directory objects in both modes. In single-instance mode, they share an OAuth client ID, not an object ID.

Choose the mode when you create the blueprint. In the Microsoft Graph beta API, set `isSingleInstance` to `true` for single-instance mode. If the property is `false` or omitted, the blueprint uses multi-instance mode. The setting can't be changed after creation.

### When to use single-instance mode

Use single-instance mode when one Agent ID represents the agent in a tenant. For example, a local assistant can use that identity across its installations, or a hosted service can use it for background work or requests on behalf of signed-in users.

Public-client agents that run on endpoint devices must use single-instance mode. Every installation uses the same client ID; installing the agent on another device doesn't create another Agent ID. Single-instance mode also supports confidential clients. The mode describes the identity relationship, not whether the agent can protect a credential.

Use multi-instance mode when a blueprint needs to provision identities with separate permissions or lifecycles, such as a fleet of agents. A multi-instance blueprint with only one child identity is still multi-instance; the number of identities currently provisioned doesn't change the mode.

The mode doesn't count running processes, replicas, or user sessions. It also isn't the same as the blueprint's single-tenant or multitenant configuration.

### Authentication and permissions

A single-instance Agent ID uses standard OAuth requests with the blueprint's `appId` as its client ID. It doesn't obtain a blueprint impersonation token first. Confidential clients authenticate with a credential configured on the blueprint. Public clients use authorization code flow with PKCE and don't send a client credential. Both client types can use the same blueprint with redirect URIs registered for their respective platforms.

Permissions are granted to the Agent ID through consent or app role assignments. Single-instance blueprints don't support inheritable permissions because they don't have a blueprint principal. Declaring permissions in `requiredResourceAccess` doesn't grant them.

Inbound authorization is a separate configuration. For a single-instance agent API, declare the user-access role on the blueprint and publish the same role GUID and value on the Agent ID service principal, then assign it to users or groups. This role configuration isn't permission inheritance. See [Control access to agents with app roles](control-user-access-agents.md).

Single-instance provisioning in Microsoft Graph and single-instance authentication must both be enabled for the tenant. They are separate requirements. For the setup procedure, see [Create a single-instance agent identity](create-single-instance-agent.md). For token requests, see [Authenticate a single-instance agent identity](authenticate-single-instance-agent.md).

## Key characteristics of agent identity blueprints

In addition to standard properties, the agent identity blueprint includes key characteristics that are important to understand before creating agent identities from your agent identity blueprint.

### Credentials

For confidential clients, credentials used to authenticate an agent identity are configured on the agent identity blueprint. A multi-instance blueprint uses its credentials to impersonate a child Agent ID. A single-instance Agent ID uses the credential directly with the shared client ID. Public-client Agent IDs don't send a client credential. For more information, see [credentials for agent identities](./agent-identities.md#authorizing-agent-identities) and [Agent ID authentication protocols](./agent-oauth-protocols.md).

### Security

The blueprint provides a logical container for agent identities in which many different identity administration operations can be performed. This capability helps administrators scale their security efforts to large numbers of AI agents.

Identity administrators can apply policies and settings to agent identity blueprints that take effect for all agent identities created from the blueprint. You can apply Conditional Access policies an agent identity blueprint that targets all agent identities created from that blueprint. Disabling an agent identity blueprint prevents all its agent identities from authenticating.

### Used to create agent identities

Blueprints don't just hold information. They're also a special identity type in Microsoft Entra ID. All Agent IDs are created from an agent identity blueprint. In the multi-instance topology, the blueprint principal provisions and deprovisions Agent IDs. To perform this operation, the blueprint has:

- An OAuth client ID: a unique ID used to request access tokens from Microsoft Entra ID.
- Credentials: used to request access tokens from Microsoft Entra ID.
- `AgentIdentity.CreateAsManager`: a special Microsoft Graph permission that enables the blueprint to create agent identities in the tenant.

A service uses the multi-instance blueprint's client ID, credentials, and permissions to send Agent ID creation requests through Microsoft Graph APIs. For a single-instance blueprint, an authorized management client creates the blueprint and then provisions its one Agent ID through Microsoft Graph. This process doesn't create a blueprint principal or require a runtime credential for a public client.

For more information, see [create agent identities](create-delete-agent-identities.md).

## Inheritable permissions and required resource access

Agent identity blueprints include two important permission-related configurations that control how agent identities access resources:

- **Required resource access** declares the APIs and permissions the agent needs to function. This list is visible to administrators during consent review and helps them evaluate whether to approve the agent.
- **Inheritable permissions**, available for multi-instance blueprints, define which resource apps can have their permissions automatically inherited by agent identities created from the blueprint. When an administrator grants permissions on the blueprint principal from an inheritable resource app, all agent identities created from that blueprint in the organization receive those permissions automatically.

These configurations are declarations that don't grant authorization by themselves. Administrators must still consent to permissions on the blueprint principal or individual agent identities.

For more information, see [Inheritable permissions](concept-inheritable-permissions.md).

## Agent identity blueprint principals

An agent identity blueprint principal represents a multi-instance blueprint within a specific tenant. Managed creation experiences can create both objects. If you create the blueprint through Microsoft Graph, [create an agent blueprint principal](create-blueprint.md#create-an-agent-blueprint-principal) before creating child identities. A single-instance blueprint doesn't have this principal.

:::image type="content" source="media/agent-blueprint/agent-blueprint-principal.png" alt-text="Diagram showing illustration of an agent blueprint principal.":::

This principal serves several important roles:

- **Token Issuance**: When the agent identity blueprint is used to acquire tokens within a tenant, the resulting token's `oid` (object ID) claim references the agent identity blueprint principal. It ensures that any authentication or authorization performed by the agent identity blueprint is traceable to its principal object in the tenant.

- **Audit Logging**: Actions performed by the agent identity blueprint, such as creating agent identities, are recorded in audit logs as being executed by the agent identity blueprint principal. It provides clear accountability and traceability for operations initiated by the agent identity blueprint.

Agent identity blueprints are always created in a Microsoft Entra tenant. An agent identity blueprint is often used to create agent identities in that same tenant. These agent identity blueprints are called "single-tenant." Agent identity blueprints can also be configured as "multitenant" and published to potential customers via Microsoft catalogs. Customers can then add these blueprints to their tenant, so that they can be used to create agent identities.

The presence of this principal indicates that the multi-instance blueprint exists in the tenant and can be used to create Agent IDs. A single-instance blueprint doesn't create this intermediate principal. For more information, see [Instance modes](#instance-modes-preview).

## Related content

- [Agent identity blueprint creation channels](agent-id-creation-channels.md)
- [Create an agent identity blueprint](create-blueprint.md)
- [Credentials for agent identities](agent-identities.md#authorizing-agent-identities).

## Next steps

- [Create a single-instance agent identity](create-single-instance-agent.md).
- [Authenticate a single-instance agent identity](authenticate-single-instance-agent.md).
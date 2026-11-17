---
title: Fundamental concepts in Microsoft Entra Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Discover the role of agent identities in AI authentication. Understand their unique identifiers, token usage, and how they enable secure access to systems.
ms.reviewer: dastrock
ms.date: 11/06/2026
ms.topic: concept-article
ai-usage: ai-assisted
#customer-intent: As a developer, I want to understand the core concepts of agent identities and blueprints in Microsoft Entra ID so that I can implement secure authentication patterns for AI agents in my applications.
---
# Microsoft Entra Agent ID key concepts

An agent identity lets an AI agent authenticate to APIs and other resources. Its agent identity blueprint holds authentication settings and credentials, while the agent identity receives access to resources. For example, an agent that reads a protected API needs a blueprint, an agent identity, and permission to call that API.

This article explains those objects, the people who manage them, and the identifiers you record during setup. You don't need to create every object described here: follow [Choose an agent integration path](choose-agent-integration-path.md) for your scenario.

An agent identity blueprint defines the configuration for one or more agent identities. In multi-instance mode, it provides a template for separate child identities. In single-instance mode, the blueprint and its one Agent ID share an OAuth client ID, with no blueprint principal.

## Core identity concepts

The following concepts form the foundation of Microsoft Entra Agent ID and the Microsoft agent identity platform.

### Agent identity

An agent identity is the primary identity an AI agent uses to authenticate to systems and access resources. Credentials, when needed, are configured on its blueprint rather than on the identity. Multi-instance Agent IDs authenticate through blueprint impersonation. Single-instance Agent IDs request tokens directly with the shared client ID; public clients don't send a client credential. For more information, see [Agent identities](agent-identities.md).

### Agent identity blueprint

An agent identity blueprint is an object in Microsoft Entra ID that defines authentication settings and other configuration for one or more agent identities. Its [instance mode](agent-blueprint.md#instance-modes-preview) determines the identity relationship and token acquisition pattern. Policies and settings applied to a blueprint, such as Conditional Access, take effect for its agent identities. For more information, see [Agent identity blueprints](agent-blueprint.md).

### Agent identity blueprint principal

A multi-instance blueprint needs a corresponding blueprint principal in the tenant. Managed creation experiences can create both objects, but creating the blueprint through Microsoft Graph doesn't create its principal. Follow [Create an agent blueprint principal](create-blueprint.md#create-an-agent-blueprint-principal) when you provision it yourself. This object records the blueprint's presence in the tenant and enables it to acquire tokens and appear in audit logs. A single-instance blueprint doesn't have a blueprint principal.

### Traditional service principal (not recommended for AI agents)

Traditional service principals were designed for static, deterministic workloads. Microsoft Entra Agent ID exists because service principals lack the governance infrastructure AI agents need. There's no enforced sponsorship, no agent-aware audit entries, and no blueprint-managed lifecycle. For more information, see [Agent identities, service principals, and applications](agent-service-principals.md).

### Regular user account (not recommended for AI agents)

Regular Microsoft Entra user accounts are designed for human sign-in patterns. Assigning them to AI agents causes failures across every Zero Trust enforcement layer: Conditional Access policies built for humans don't apply correctly to agents, ID Protection detections are degraded, and identity governance processes can incorrectly remove agent access. For more information, see [Plan your agent identity architecture](how-to-plan-agent-identity-architecture.md).

## Agent operation patterns

The agent identity platform supports the following patterns for how agents operate and authenticate, each serving different use cases and security requirements.

[!INCLUDE [agent-type-definitions](includes/agent-type-definitions.md)]

## Agent owners, sponsors, and managers

The agent identity platform introduces an administrative model that separates technical administration from business accountability, ensuring operational control and compliance oversight without excessive permissions. The agent administrative roles include owners, managers, and sponsors.

- **Owners** serve as technical administrators for agents, handling operational and configuration aspects.
- **Sponsors** provide business accountability for agents, making lifecycle decisions without technical administrative access.
- **Managers** are human users who are designated as the hiring manager or operational owner for an agent's user account.

For more information, see [Administrative relationships for agent identities (Owners, sponsors, and managers)](agent-owners-sponsors-managers.md)

## Microsoft Entra ID Auth SDK (sidecar)

The Microsoft Entra ID Auth SDK (sidecar) is a containerized web service that handles token acquisition, validation, and secure downstream API calls for agents registered in the Microsoft identity platform. It runs as a companion container alongside your application, allowing you to offload identity logic to a dedicated service. For more information, see [Microsoft Entra ID Auth SDK (sidecar)](/entra/msidweb/agent-id-sdk/overview).

## Record the identifiers for your scenario

Record these values as you complete setup. Use only the rows your tutorial needs; you don't need to create every object in these tables. An application (client) ID identifies an OAuth client or resource. An object ID identifies one directory object in one tenant. They aren't interchangeable, even when both are GUIDs.

### Tenant and management client

The management client provisions and configures identities in the selected tenant. Its client ID isn't the agent's runtime client ID.

| Agent ID identifier | Identifier source | Required operation or field |
| --- | --- | --- |
| Tenant ID | Your directory's **Tenant ID**. | The authority and the tenant targeted by management requests. |
| Management client ID | The separate management app's **Application (client) ID**. | `Connect-MgGraph -ClientId`. This isn't the agent's runtime client ID. |

### Blueprint and agent identities

Use object IDs for directory operations and client IDs for OAuth requests. Single-instance provisioning uses the blueprint object ID; fleet provisioning uses its client ID.

| Agent ID identifier | Identifier source | Required operation or field |
| --- | --- | --- |
| Blueprint object ID | `id` in the blueprint creation response. | Microsoft Graph `/applications/{id}` updates, including credentials, redirect URIs, and scopes. Single-instance provisioning also uses this value for `agentIdentityBlueprintId`. |
| Blueprint client ID | `appId` in the blueprint creation response. | Blueprint authentication and its `api://` identifier URI. Fleet provisioning uses this value for `agentIdentityBlueprintId`. |
| Blueprint principal object ID | `id` in the blueprint principal creation response. Fleet scenarios only. | Operations on the blueprint's tenant service principal, including configured permission inheritance. Don't create this object for a single-instance agent. |
| Agent object ID | `id` in the agent identity creation response. | Microsoft Graph `/servicePrincipals/{id}`, assignments, and `oauth2PermissionGrants.clientId`. Despite that grant field's name, it takes the agent's service principal object ID, not its OAuth client ID. |
| Agent client ID | `appId` on the agent identity. | Runtime OAuth requests. A cloud or local single-instance agent shares its blueprint's client ID; a fleet identity has a separate client ID. |

### Resources and permissions

The resource client ID identifies the API. Permission grants use its service principal object ID; scope and role GUIDs identify the permissions within that resource.

| Agent ID identifier | Identifier source | Required operation or field |
| --- | --- | --- |
| Resource client ID | The downstream API application's `appId`. | Token audience, scope URI, and `requiredResourceAccess.resourceAppId`. |
| Resource service principal object ID | `id` of that API's service principal in the grant tenant. | `resourceId` in permission grants. Don't substitute the resource client ID. |
| Delegated scope ID and value | The API's `oauth2PermissionScopes[].id` and `.value`. | The GUID goes in permission declarations; the value, such as `read_data`, goes in a scope request or delegated grant. |
| App role ID | The resource's `appRoles[].id`. | Application-permission declarations and app role assignments. |

### Human users and dedicated agent users

Both values are directory object IDs, not client IDs. A dedicated agent-user account doesn't replace the human user in an OBO request.

| Agent ID identifier | Identifier source | Required operation or field |
| --- | --- | --- |
| Human user object ID | The signed-in user's directory `id`. | User-specific consent and ownership or sponsorship when the procedure requires a user. |
| Agent-user object ID | `id` returned when you create the optional dedicated agent user. | Dedicated-agent-user operations, not human-user OBO requests. |

Keep credentials separate from this worksheet. Never record access tokens, client secrets, private keys, or PFX passwords in source control or shared troubleshooting notes.

## Next steps

- [Choose an integration path for your agent](choose-agent-integration-path.md).
- [Create an identity for a cloud or local agent](create-single-instance-agent.md).
- [Set up a blueprint for an agent fleet](set-up-blueprint-agent-fleet.md).

## Related content

- [What is an agent ID?](what-are-agent-identities.md)
- [Microsoft Entra Agent ID OAuth protocols](agent-oauth-protocols.md)
- [Inheritable permissions](concept-inheritable-permissions.md)
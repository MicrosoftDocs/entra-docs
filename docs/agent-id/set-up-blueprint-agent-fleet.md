---
title: Set up an agent identity blueprint for a fleet
description: Configure an agent identity blueprint, credential, permissions, and inbound scope for a fleet of agents on a shared runtime.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform, I want to configure one blueprint for my fleet so that the runtime can provision agent identities and acquire tokens for each agent.
---

# Set up an agent identity blueprint for a fleet

A fleet runtime uses one [agent identity blueprint](agent-blueprint.md) to create agent identities and to acquire tokens for them. Configure the blueprint once, before the first agent is deployed. For the overall design, see [Plan an agent fleet on a shared runtime](plan-agent-fleet.md).

## Prerequisites

- The Agent ID Developer role, to create the blueprint.
- An administrator who can grant tenant-wide admin consent for Microsoft Graph application permissions.
- An Azure compute resource for the runtime with a user-assigned managed identity.

## Create the blueprint and its principal

1. [Create an agent identity blueprint](create-blueprint.md#create-an-agent-identity-blueprint). Record its client ID.
1. [Create the agent identity blueprint principal](create-blueprint.md#create-an-agent-blueprint-principal) in the tenant. The principal creates agent identities and receives admin consent.

Record the tenant ID, blueprint client ID and object ID, blueprint principal object ID, and runtime managed identity client ID for the developer who configures provisioning. Use [Record the identifiers for your scenario](key-concepts.md#record-the-identifiers-for-your-scenario) to distinguish these values.

## Add the blueprint credential

[Add the runtime's managed identity as a federated identity credential](create-blueprint.md#configure-credentials-for-the-agent-identity-blueprint) on the blueprint. The runtime and the provisioning service use this credential to authenticate as the blueprint.

Don't use client secrets in production. Every agent in the fleet depends on this credential.

## Grant provisioning permissions

The blueprint principal needs the following Microsoft Graph application permissions to provision identities. Neither permission is granted by default.

| Permission | Required for |
| --- | --- |
| `AgentIdentity.CreateAsManager` | Creating and deleting agent identities |
| `AgentIdUser.ReadWrite.IdentityParentedBy` | Creating and deleting agent's user accounts |

Skip `AgentIdUser.ReadWrite.IdentityParentedBy` if no agent in the fleet needs an agent's user account. Skip both if [Agent 365 provisions your agents](plan-agent-fleet.md#choose-how-agents-are-provisioned).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **App registrations** and open the blueprint app registration.
1. Select **API permissions** > **Add a permission** > **Microsoft Graph** > **Application permissions**.
1. Select `AgentIdentity.CreateAsManager` and, if needed, `AgentIdUser.ReadWrite.IdentityParentedBy`.
1. Select **Add permissions**, and then select **Grant admin consent**.

Before handing setup back to the runtime developer, confirm that admin consent is granted for each selected Microsoft Graph application permission on this blueprint. A permission listed without consent doesn't make the provisioning service ready. Keep these provisioning permissions separate from the downstream permissions granted to agents.

For more information about these permissions, see [Agent identity blueprint principals](agent-id-creation-channels.md#agent-identity-blueprint-principals).

## Plan how agents get access

Grant access to each agent identity individually. This approach is recommended because each agent's access stays separate and visible on its agent identity. After the provisioning service creates an agent identity, grant it the application permissions, delegated permissions, Azure role assignments, or other access that the agent needs:

- [Grant application permissions](grant-application-permissions-agent-identity.md)
- [Grant delegated permissions](grant-agent-access-microsoft-365.md)

### Optionally configure inheritable permissions

If every agent in the fleet needs the same permissions, you can grant them once on the blueprint principal and let each agent identity inherit them. This approach is a convenience: new agent identities receive the permissions without a separate grant.

1. Add the shared permissions to the blueprint's required resource access.
1. [Configure inheritable permissions](configure-inheritable-permissions-blueprints.md) for each resource app, such as Microsoft Graph or your custom API.
1. Have an administrator grant admin consent for those permissions on the blueprint principal.

Inherited permissions don't appear on agent identities in the admin center or through Microsoft Graph. They appear only in the tokens that agent identities receive. For the rules that determine which permissions are inherited, see [Inheritable permissions](concept-inheritable-permissions.md#declaration-grant-and-inheritance).

## Expose the inbound scope

If users or client applications call agents in the fleet, [configure an identifier URI and the `access_agent` scope](create-blueprint.md#configure-identifier-uri-and-scope) on the blueprint. Every agent in the fleet shares this audience.

To limit who can call the fleet, [define app roles and require assignment](control-user-access-agents.md) on the blueprint principal. App roles apply to every agent in the fleet. Enforce per-agent access in the runtime.

## Next steps

Continue with the integration path for the runtime:

- [Provision agent identities with ASP.NET Core](aspnet-core-fleet-provision-agent-identities.md)
- [Provision agent identities with the Auth SDK sidecar](sidecar-fleet-provision-agent-identities.md)

## Related content

- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)
- [Create an agent identity blueprint](create-blueprint.md)
- [Inheritable permissions](concept-inheritable-permissions.md)
- [Agent creation channels](agent-id-creation-channels.md)

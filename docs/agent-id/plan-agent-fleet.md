---
title: Plan an agent fleet on a shared runtime
description: Learn how to design authentication for many agents hosted on a shared cloud runtime, with one blueprint and one agent identity per agent.
titleSuffix: Microsoft Entra Agent ID
ms.topic: concept-article
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform, I want to understand how to provision and use an agent identity for each agent in my fleet so that every agent authenticates with its own identity.
---

# Plan an agent fleet on a shared runtime

An agent fleet is a set of agents that run on a shared cloud runtime. For example, a platform that lets teams or customers deploy their own agents hosts each new agent on the same compute and code base. Each agent in the fleet gets its own [agent identity](what-are-agent-identities.md), so its sign-ins, permissions, and audit records stay separate from the other agents.

The runtime holds a single [agent identity blueprint](agent-blueprint.md) credential and uses it to acquire tokens for any agent identity created from that blueprint. The runtime chooses which agent identity to use on each token request.

## Choose between a single agent and a fleet

| Consideration | Single agent | Agent fleet |
| --- | --- | --- |
| Number of agents per deployment | One | Many, added and removed at runtime |
| When agent identities are created | Before the agent is deployed, by a developer or administrator | When each agent is deployed, by the runtime or by Agent 365 |
| Where the agent identity ID comes from | Configuration | A lookup on each request |
| How access is granted | To the agent identity, before the agent is deployed | To each agent identity, when the agent is provisioned |
| Guidance | [Build cloud agents with ASP.NET Core](call-api-custom.md) or [the Auth SDK sidecar](authentication-with-auth-sdk-sidecar.md) | This article and the fleet articles that follow it |

The fleet runtime selects an agent's identity for each operation. Follow the fleet examples throughout this journey: the cloud-agent tutorials use one configured identity and omit the per-request identity selection required by a fleet.

## Components

| Component | Purpose | Cardinality |
| --- | --- | --- |
| Agent identity blueprint | Defines the fleet's permissions, inbound scope, and app roles. Creates and deletes agent identities. | One per fleet, or one per agent type |
| Blueprint credential | Authenticates the runtime as the blueprint. Use a managed identity federated credential in production. | One per blueprint |
| Agent identity | Represents one agent. Receives the access tokens used to call APIs. | One per agent |
| Agent's user account | Gives an agent a user object for Microsoft 365 workloads such as a mailbox or Teams membership. | Optional, at most one per agent identity |
| Agent directory | The runtime's store that maps each agent to its agent identity and agent's user account. | One per fleet |
| Provisioning service | Creates and deletes identities when agents are deployed and retired. | One per fleet |
| Token broker | Acquires tokens for a given agent identity. *Microsoft.Identity.Web* in the runtime process, or the Auth SDK sidecar. | One or more per runtime |

## Agent lifecycle

1. **Deploy.** A user or pipeline deploys a new agent to the runtime.
1. **Provision.** The provisioning service creates an agent identity from the blueprint. If the agent needs Microsoft 365 user capabilities, it also creates an agent's user account. It records both IDs in the agent directory, and the agent identity is granted the access that this agent needs.
1. **Run.** For each operation, the runtime looks up the agent's identity in the agent directory and passes it to the token broker.
1. **Retire.** The provisioning service deletes the agent's user account and then the agent identity, and removes the agent directory entry.

## Choose how agents are provisioned

| Option | How it works | Use it when |
| --- | --- | --- |
| The runtime provisions identities | The provisioning service authenticates as the blueprint and calls Microsoft Graph to create and delete agent identities and agent's user accounts. | The runtime controls agent deployment. |
| Agent 365 provisions identities | Agent 365 creates the agent identity when an agent is provisioned. The runtime listens for agent provisioning events, which include the agent identity ID, and records it in the agent directory. | Agents are created through Microsoft 365 experiences. For details, see the [Agent 365 developer documentation](/microsoft-agent-365/developer/). |

Both options produce the same agent directory entry. The rest of the fleet guidance applies to either option.

## Select the agent identity on each request

The blueprint credential can acquire tokens for every agent identity created from the blueprint. The runtime code that chooses the agent identity is therefore a security boundary.

- Resolve the agent identity from the agent directory by using a key that the runtime controls, such as its own agent ID.
- Don't accept an agent identity client ID or agent's user account ID from a request, prompt, or tool output.
- Confirm that the caller is allowed to use the target agent before you request a token for it.

## Plan trust boundaries

- **Keep the credential away from agent code.** Hold the blueprint credential in the runtime or in the sidecar, never in code that an agent author or model controls.
- **Isolate the token broker.** If agents run untrusted or customer-supplied code, don't let that code call the token broker directly. A process that can reach the broker can request a token for any agent in the fleet.
- **Separate provisioning from token acquisition.** The provisioning service uses blueprint tokens that can create and delete identities. Run it with its own access path so agent code can't request those tokens.
- **Limit the blast radius.** Use more than one blueprint when groups of agents run in different trust zones or belong to different customers.

## Plan for limits

A blueprint principal can create at most 250 agent identities. For a larger fleet, create more blueprints and assign each agent to a blueprint when it's provisioned. Record the blueprint in the agent directory entry. For details, see [Agent identity blueprint principals](agent-id-creation-channels.md#agent-identity-blueprint-principals).

The implementation articles that follow use one blueprint per runtime configuration. If you extend them to multiple blueprints, also resolve the matching blueprint configuration and credential for each agent; selecting an agent ID alone doesn't select a different blueprint. The sample directory record needs to be extended for that design.

## Grant access to each agent

Give each agent identity only the access that its agent needs. Grant application permissions, delegated permissions, Azure role assignments, and access to other resources directly to the agent identity, as part of provisioning or soon after. Per-agent grants keep each agent's access separate, so you can review, change, or revoke one agent's access without affecting the rest of the fleet. For the ways to grant access, see [Grant application permissions](grant-application-permissions-agent-identity.md) and [Grant delegated permissions](grant-agent-access-microsoft-365.md).

For permissions that every agent in the fleet needs, you can use [inheritable permissions](concept-inheritable-permissions.md) as a convenience. An administrator grants those permissions once on the blueprint principal, and every agent identity created from the blueprint receives them in its tokens. Inherited permissions don't appear on the agent identity, so per-agent grants are easier to audit.

## Route user requests to agents

Users call a fleet agent with an access token for the blueprint's `access_agent` scope. Every agent in the fleet shares that audience, so the token proves who the user is but doesn't identify the agent. The runtime must:

1. Determine the target agent from the request, such as from a route segment.
1. Confirm that the user is allowed to use that agent. App roles on the blueprint apply to the whole fleet, so enforce per-agent access in the runtime.
1. Use the target agent's identity for any On-Behalf-Of (OBO) token request.

## Next step

[Set up an agent identity blueprint for a fleet](set-up-blueprint-agent-fleet.md)

## Related content

- [Agent ID design patterns](concept-agent-id-design-patterns.md)
- [Plan your agent identity architecture](how-to-plan-agent-identity-architecture.md)
- [Agent creation channels](agent-id-creation-channels.md)
- [Grant application permissions](grant-application-permissions-agent-identity.md)
- [Inheritable permissions](concept-inheritable-permissions.md)

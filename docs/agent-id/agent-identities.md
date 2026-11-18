---
title: Overview of agent identities in Microsoft Entra
description: Learn about agent identities in Microsoft Entra ID, specialized identity constructs that enable secure authentication and authorization for AI agents in enterprise environments.
ms.topic: concept-article
ms.date: 11/03/2026
ms.reviewer: dastrock
ai-usage: ai-assisted
#customer-intent: As a developer or IT administrator, I want to understand what agent identities are in Microsoft Entra ID, how they differ from application and human identities, and why my organization needs them so that I can deploy AI agents securely in our Microsoft Entra environment.
---

# Agent identities in Microsoft Entra Agent ID

An agent identity is a special service principal in Microsoft Entra ID. Its blueprint defines authentication settings and holds any client credentials. In multi-instance mode, the blueprint impersonates its child agent identities. In single-instance mode, the blueprint and Agent ID share an OAuth client ID, and the Agent ID requests tokens directly.

An agent can request application tokens for autonomous work or delegated tokens for a signed-in user. Public clients don't send a client credential. In either case, permissions must be granted before the agent can access a resource.

Agent identities can be used to:

- Request agent tokens from Microsoft Entra ID. The subject of the access token is the agent identity.
- Receive incoming access tokens issued by Microsoft Entra ID. The audience of the access token is the agent identity.
- Request user tokens from Microsoft Entra ID for an authenticated user. The subject of the token is a user, while the actor is the agent identity.

## Anatomy of an agent identity

An account used by an AI agent is referred to as an **agent identity**. Much like your typical user account, an agent identity has a few key components:

:::image type="content" source="media/agent-identities/agent-identity.png" alt-text="Diagram showing an agent identity illustration.":::

- **Identifier**. Each agent identity has an `id` (also known as object ID), such as `aaaaaaaa-1111-2222-3333-bbbbbbbbbb`. Microsoft Entra generates the `id` and uniquely identifies the account within a Microsoft Entra tenant.

- **Credentials**. Credentials are configured on the blueprint, not the agent identity. Multi-instance identities use blueprint impersonation; single-instance confidential clients use the blueprint credential directly.

- **Display name**. An agent identity's display name is surfaced in many experiences such as the Microsoft Entra admin center, Azure portal, Teams, Outlook, and more. It's the human-friendly name of an agent and can be changed.

- **Sponsor**. Agent identities can have a sponsor, which records the human user or group that's accountable for an agent. This sponsor is used for various purposes, such as contacting a human in case a security incident happens.

- **Blueprint**. All agent identities are created from a reusable template called an agent identity blueprint. The agent identity blueprint establishes the kind of agent and records metadata shared across all agent identities of a common kind.

- **Agent's user account (optional)**. Some agents need access to systems that strictly require a Microsoft Entra user account be used for authentication. In these cases, an agent can be given a second account, called an **agent's user account**. This second account is a user account in the Microsoft Entra tenant that is decorated as an AI agent. It has a different `id` than the agent identity, but a 1:1 relationship is always established between an agent identity and its agent's user account.

These are the basic components of an agent identity that enable secure authentication and authorization. The full object schema of an agent identity is available in Microsoft Graph reference documentation.

## Authorizing agent identities

Agent identity is the primary account used by an AI agent to authenticate to various systems. Its object ID identifies the directory object, while its application (client) ID identifies it in OAuth requests. A single-instance Agent ID shares the blueprint's client ID but has a separate object ID. Don't substitute one identifier for another in Microsoft Graph requests.

Unlike human users, AI agents don't use passwords, Short Message Service (SMS), passkeys, or authenticator apps for authentication. For multi-instance Agent IDs, the blueprint authenticates and provides an impersonation token that the Agent ID uses as a client assertion. Credentials reside on the blueprint, not the agent identity. Credential types on the blueprint include:

- Federated identity credentials
- Certificates / cryptographic keys
- Client secrets

A single-instance confidential client authenticates directly with its shared client ID and a credential configured on the blueprint. A public client instead uses authorization code flow with PKCE and no client credential. For the requests and consent requirements, see [Authenticate a single-instance agent identity](authenticate-single-instance-agent.md).

Agent identities can only be issued tokens in the Microsoft Entra tenant where they're created. They can't access resources or APIs in other tenants.

> [!NOTE]
> While agent identities are single-tenant, agent identity blueprints can be configured as multitenant. A multitenant blueprint can be published and added to other tenants, where it creates tenant-local agent identities. The agent identities themselves always remain single-tenant.

## Blueprints: Consistent security for agent identities

A key characteristic of agent identities is that all agent identities are created from a reusable template called an agent identity blueprint. The blueprint establishes the "kind" of agent and records metadata shared across all agent identities of a common kind.

:::image type="content" source="media/agent-identities/agent-blueprint.png" alt-text="Diagram showing relationship between agent identity and agent identity blueprint.":::

Imagine that an organization uses an AI agent called a "Sales Assistant Agent." Whether the agent is purchased or built in-house, an agent identity blueprint would be added to the organization's Microsoft Entra tenant. The blueprint captures the following information:

- The name of the blueprint, such as "Sales Assistant Agent"
- The organization who published the blueprint, such as "Contoso"
- Any roles the agent might offer, such as "sales manager" or "sales rep"
- Any Microsoft Graph permissions that its agents are granted, such as "read the signed in user's calendar"

Many sales teams within the organization deploy the AI agent. An agent is deployed for North America sales. Another is deployed for South America sales. One for enterprise sales, one for small/medium businesses, and another for startups. Upon creation, each of these agents is given an agent identity. Each agent begins running and performing tasks using its agent identity for authentication.

Because each agent identity is created using the same agent identity blueprint, all agents appear as "Sales Assistant Agents" in the Microsoft Entra admin center. This feature allows the Microsoft Entra administrator to take actions like:

- Apply a conditional access policy to all Sales Assistant Agents.
- Disable all Sales Assistant agents.
- Revoke a permission grant for all Sales Assistant agents.

Agent identity blueprints give the Microsoft Entra administrator the ability to secure agent identities at scale by setting rules and performing operations based on the kind of agent. This feature ensures consistent security for each AI agent that is deployed in the organization.

## Related content

- [Create an agent identity](./create-delete-agent-identities.md)
- [Microsoft Entra Agent ID authentication protocol](agent-oauth-protocols.md)

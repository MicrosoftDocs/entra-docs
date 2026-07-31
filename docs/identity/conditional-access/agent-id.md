---
title: Microsoft Entra Conditional Access for agents overview
description: Learn how Microsoft Entra Conditional Access evaluates agent access and choose the right policy guidance for each agent access pattern.
author: gracenagy
ms.author: gracenagy
ms.service: entra-id
ms.topic: concept-article
ms.date: 07/31/2026
ms.reviewer: yoelhor, kvenkit
ms.custom: msecd-doc-authoring-1017
ai-usage: ai-assisted

#customer intent: As an identity administrator, I want to understand how Conditional Access evaluates agent access so that I can choose the right policy target and guidance.
---

# Microsoft Entra Conditional Access for agents overview

Conditional Access for agents is an extension of the Conditional Access policy engine that controls how agents access resources protected by Microsoft Entra ID. It evaluates the subject that requests an access token and the resource that the token is for.

Understanding the agent's access pattern helps you target the correct identity. An agent can act on behalf of a signed-in user, use its own agent identity, or use its own agent user account.

## Requirements and licensing

Conditional Access for agents requires Microsoft Entra ID P1 or P2 and a Microsoft Agent 365 license for each user. Enforcement of Agent 365 licensing is coming soon. Network controls for agents require Microsoft Entra Internet Access.

For more information, see [What is Microsoft Entra Agent ID](../../agent-id/what-is-microsoft-entra-agent-id.md#how-to-get-started).

<a name='how-conditional-access-evaluates-agent-access-requests'></a>

## How Conditional Access evaluates agent access

To access a resource such as a SharePoint file, MCP server, or Open API service, a user or agent requests an access token from Microsoft Entra ID.

When a Conditional Access policy applies, Microsoft Entra ID evaluates the policy requirements before it issues the token. If the requirements are satisfied, Microsoft Entra ID issues the token. The target resource validates the token and uses its claims to make authorization decisions.

:::image type="content" source="media/agent-id/data-access-patterns-diagram.png" alt-text="Diagram showing the data access patterns for agent identities." lightbox="media/agent-id/data-access-patterns-diagram.png":::

Each access token has one subject and one audience:

- **Subject**: The identity that receives the token. In delegated access, the token represents the user and identifies the calling application or agent. In application-only access, the application or autonomous agent is the subject. In agent-user access, the agent's user account is the subject.
- **Audience**: The target resource that the token is for. If a subject accesses multiple resources, it typically needs a separate token for each resource.

Conditional Access evaluates both the subject that requests access and the audience being accessed. It evaluates policies when Microsoft Entra ID issues or refreshes an access token. Some resources also support Continuous Access Evaluation, which can trigger near-real-time enforcement for specific events.

<a name='agent-access-patterns'></a>

## Choose an agent access pattern

Choose the access pattern based on the subject of the token, not the platform where the agent was built.

| If the agent | Access pattern | Policy target | Guidance |
|---|---|---|---|
| Accesses downstream resources for a signed-in user | On-behalf-of (OBO), also known as delegated access | Users and groups | [Agent OAuth flows: On-behalf-of](../../agent-id/agent-on-behalf-of-oauth-flow.md) |
| Accesses resources with its own agent identity and no signed-in user | Application-only, also known as client credentials or app-only access | Agent identity or agent identity blueprint | [Secure autonomous agents with Conditional Access](policy-autonomous-agents.md) |
| Accesses resources through its own user account | Agent-user access | Agent's user account | [Secure agents that act as users with Conditional Access](policy-agent-user.md) |

An agent can use more than one access pattern. Create separate policies for each token subject that the agent uses. A policy that targets an agent identity doesn't apply to the agent's user account, and a policy that targets the agent's user account doesn't apply to the agent identity.

<a name='agents-acting-on-behalf-of-a-user'></a>

## Agents that act on behalf of a user

In the OBO flow, a user signs in to an agent application. The agent accesses downstream resources with the user's identity and delegated permissions.

The agent can't reuse the user's original token because that token is for a different audience. The agent exchanges the token for a new token for the target resource. Conditional Access evaluates this token exchange.

Because the user is the subject, Conditional Access policies target users and groups, not agent identities. The OBO flow describes the authentication flow, not a type of agent. Any agent can use this flow when a signed-in user is present and the agent needs the user's identity and permissions.

<a name='agents-acting-as-an-application'></a>

## Agents that act as applications

In application-only access, an agent accesses resources with its own agent identity and no signed-in user. This access pattern applies to agents that:

- Run in the background, respond to events, or run on a schedule.
- Use their own identity for a backend service that users can't access.
- Are published for public use without delegated user context.

The token is issued to the agent identity. Conditional Access policies therefore target the agent identity or its agent identity blueprint. For policy examples, see [Secure autonomous agents with Conditional Access](policy-autonomous-agents.md).

<a name='agents-acting-as-a-user'></a>

## Agents that act as users

An agent user account lets an agent have a mailbox, access chat, or participate in collaborative workflows as a team member. An administrator creates the user account in the directory and links it to the agent identity.

The token is issued to the agent's user account. Conditional Access policies therefore target the agent's user account, not the agent identity.

Agents that run on managed endpoints such as Windows 365 Cloud PCs for Agents can use device compliance and compliant network controls. The **Agent execution environments (Preview)** condition limits these policies to endpoint-based sessions. For policy examples, see [Secure agents that act as users with Conditional Access](policy-agent-user.md).

<a name='conditional-access-policies-and-agent-identity-blueprints'></a>

## Agent identity blueprints

An agent identity blueprint defines the configuration and governance model for agent identities created from it. A policy that targets a blueprint applies to all agent identities created from that blueprint, including agent identities created later.

Targeting an agent identity blueprint doesn't cover agent user accounts.

:::image type="content" source="media/agent-id/conditional-access-agent-identity-blueprint-diagram.png" alt-text="Diagram showing a Conditional Access policy applied to agent identities from one blueprint." lightbox="media/agent-id/conditional-access-agent-identity-blueprint-diagram.png":::

For example, several agents in one project might operate independently or work together. If they come from the same blueprint, one policy on the blueprint can apply consistent controls across the collection.

## Attribute-driven Conditional Access

Custom security attributes let you categorize agent identities and resources with business-specific labels. Conditional Access policies can target those attributes instead of individual objects.

Policies based on custom security attributes apply to matching agent identities, including matching identities created later.

:::image type="content" source="media/agent-id/conditional-access-agent-diagram.png" alt-text="Diagram showing Conditional Access applied to agent identities by using custom security attributes." lightbox="media/agent-id/conditional-access-agent-diagram.png":::

For a policy example, see [Allow approved agents by using custom security attributes](policy-autonomous-agents.md#allow-approved-agents-by-using-custom-security-attributes).

## Boundaries and limitations

Conditional Access policies don't apply in these cases:

- An agent identity blueprint gets a token for Microsoft Graph to create an agent identity or agent user account. Agent blueprints can't act independently to access resources. Agent identities perform agent tasks.
- An agent identity blueprint or agent identity performs an intermediate token exchange at the `AAD Token Exchange Endpoint: Public` endpoint with resource ID `fb60f99c-7a34-4190-8149-302f77469936`. Tokens for this endpoint can't call Microsoft Graph.
- Security defaults are enabled.
- An agent accesses a resource without Microsoft Entra ID authentication, such as by using an API key.

The following configurations aren't currently supported:

- Policies that target all users don't include agent user accounts.
- Policies can't include or exclude agent user accounts based on group membership.
- A policy that targets agent identities doesn't apply to agent user accounts.
- A policy that targets agent identities through a blueprint covers only the agent identities, not agent user accounts.

## Related content

- [Target agent identities in Conditional Access policies](howto-target-agent-identities.md)
- [Secure autonomous agents with Conditional Access](policy-autonomous-agents.md)
- [Secure agents that act as users with Conditional Access](policy-agent-user.md)

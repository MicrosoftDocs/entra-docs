---
title: Conditional Access for Agents in Microsoft Entra
description: Learn how Conditional Access for agents in Microsoft Entra ID extends Zero Trust principles to AI agents, ensuring secure access and governance. Choose the right policy guidance for each agent access pattern.
author: gracenagy
ms.author: gracenagy
ms.service: entra-id
ms.topic: concept-article
ms.date: 07/31/2026
ms.reviewer: yoelhor, kvenkit
ms.custom: msecd-doc-authoring-1017
ai-usage: ai-assisted
---

# Conditional Access for agents

Conditional Access for agents is an extension of the Conditional Access policy engine that controls how agents access resources protected by Microsoft Entra ID. It brings together real-time signals such as user's and agent's context, device, location, and risk information to determine when to allow, block, or limit access, or require more verification steps.

Understanding the agent's access pattern helps you target the correct identity. An agent can act on behalf of a signed-in user, use its own agent identity, or use its own agent user account.

Learn about Conditional Access for agents:

- High-level overview of Conditional Access: [What is Conditional Access?](overview.md)
- Guide to managing agent identities across your organization: [Manage agent identities in your organization](../../agent-id/manage-agent-identities-admin.md).
- [How to target agent identities in Conditional Access](howto-target-agent-identities.md)
- [Secure autonomous agents with Conditional Access](policy-autonomous-agents.md)
- [Secure agent users with Microsoft Entra Conditional Access](policy-agent-user.md)
## Requirements and licensing

Microsoft Entra ID Conditional Access for agents requires one of the following license plans:
- **Microsoft 365 E7**, which includes Agent 365 and Microsoft Entra Suite.
- **Microsoft Agent 365** license paired with at least Microsoft Entra P1 or Microsoft 365 E3.

For more information, see [Microsoft Agent 365 plans and pricing](https://www.microsoft.com/microsoft-agent-365#plans-and-pricing).

<a name='how-conditional-access-evaluates-agent-access-requests'></a>

## How Conditional Access evaluates agent access

To access a resource such as a SharePoint file, MCP server, or Open API service, a user or agent requests an access token from Microsoft Entra ID.

When a Conditional Access policy applies, Microsoft Entra ID evaluates the policy requirements before it issues the token. If the requirements are satisfied, Microsoft Entra ID issues the token. The target resource validates the token and uses its claims to make authorization decisions.

:::image type="content" source="media/agent-id/data-access-patterns-diagram.png" alt-text="Diagram showing the data access patterns for agent identities." lightbox="media/agent-id/data-access-patterns-diagram.png":::

Each access token has one subject and one audience:

- **Subject**: The identity that receives the token. 
	- In delegated access, the token represents the user while also identifying the calling application or agent.
	- In application-only access, the agent identity is the subject. 
	- In agent-user access, the agent's user account is the subject.
- **Audience**: The target resource that the token is for, which must be registered in Entra ID. If a subject accesses multiple resources, it typically needs a separate token for each resource.

Conditional Access evaluates both the subject that requests access and the audience being accessed. It evaluates policies when Microsoft Entra ID issues or refreshes an access token. Some resources also support Continuous Access Evaluation, which can trigger near-real-time enforcement for specific events.

### How Conditional Access decisions are made

Conditional Access policies operate as if-then statements:

- If the conditions defined in a policy are met, the configured access controls are enforced.
- If the required controls are satisfied, access is granted.
- If the required controls are not satisfied, access is denied.

For example, an organization may require multifactor authentication before a user can authorize an agent to access their email. Similarly, an organization may configure a policy to block access from agents identified as high risk.

### When Conditional Access is evaluated

Conditional Access is evaluated whenever Microsoft Entra ID issues or refreshes an access token. Some resources also support Continuous Access Evaluation, which can trigger near-real-time enforcement for specific events.


<a name='agent-access-patterns'></a>

## Agent access patterns

Agents can access Microsoft Entra-protected resources using one of the following patterns:

| If the agent                                                         | Access pattern                                                        | Policy target                              | Guidance                                                                           |
| -------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------ | ---------------------------------------------------------------------------------- |
| Accesses downstream resources for a signed-in user                   | On-behalf-of (OBO), also known as delegated access                    | Users and groups                           | [Agent OAuth flows: On-behalf-of](../../agent-id/agent-on-behalf-of-oauth-flow.md) |
| Accesses resources with its own agent identity and no signed-in user | Application-only, also known as client credentials or app-only access | Agent identity or agent identity blueprint | [Secure autonomous agents with Conditional Access](policy-autonomous-agents.md)    |
| Accesses resources through its own user account                      | Agent-user access                                                     | Agent's user account                       | [Secure agents that act as users with Conditional Access](policy-agent-user.md)    |

An agent can use more than one access pattern. Create separate policies for each token subject that the agent uses. A policy that targets an agent identity doesn't apply to the agent's user account, and a policy that targets the agent's user account doesn't apply to the agent identity.

<a name='agents-acting-on-behalf-of-a-user'></a>

### Agents that act on behalf of a user

The most common access pattern is the on-behalf-of (OBO) flow. In the OBO flow, a user signs in to an agent application. The agent accesses downstream resources with the user's identity and delegated permissions. For example, when an agent reads your emails, it accesses your mailbox *on your behalf*. For more information about how the OBO flow works for agents, see [Agent OAuth flows: On-behalf-of](../../agent-id/agent-on-behalf-of-oauth-flow.md).

> [!NOTE]
> The on-behalf-of flow is also known as delegated access. "On-behalf-of" describes the authentication flow, not the type of agent. These interactive agents involve a user interface for human interaction. Any agent can use this flow when a signed-in user is present and the agent needs to access resources with that user's identity and permissions.

In this flow, the agent can't reuse the user's original token because it was issued for a different audience. Instead, the agent uses the OBO flow to exchange tokens with Microsoft Entra ID, obtaining a new token scoped to the target resource. This token exchange is also evaluated by Conditional Access, letting admins enforce granular controls over which resources agents can access on behalf of the user.

Because the user is the subject in this flow, Conditional Access policies target **users and groups**, not agent identities. Policies that target agent identities don't apply to OBO traffic. Use user-targeted policies to provide the Conditional Access guardrails for resources the agent accesses on the user's behalf.

<a name='agents-acting-as-an-application'></a>

### Agents that act as applications

Agents might access resources without a signed-in user. In this case the agent accesses the resource with its own identity. This flow is also known as client credentials flow, or app only access. All types of agents might use this flow. For more information about how agents authenticate with their own identity, see [Agent OAuth flows: Autonomous apps](../../agent-id/agent-autonomous-app-oauth-flow.md).

This flow applies in the following common scenarios:

- **Autonomous agents that operate independently** run in the background, respond to events, or run on a schedule.
  - For example, an agent that generates a daily report and sends the result to a group of employees.
  - In this scenario, there's no user present, and the agent operates on its own.
- **Interactive agents that use their own identity** don't always access resources on a user's behalf; sometimes they use their own identity.
  - For example, if an agent calls a backend SMS service that users don't have access to, the OBO flow doesn't apply, and the agent authenticates directly as itself.
- **Agents published on the web for public use** don't authenticate the user or don't support delegating the user's context to corporate resources.

In these scenarios, the agent requests an access token using its own agent identity and credentials managed through the agent identity blueprint. The token is issued to the agent identity (not the user). Therefore, Conditional Access policies are scoped to the agent identity rather than the user. For step-by-step policy configuration, see [Secure autonomous agents with Conditional Access](policy-autonomous-agents.md).

<a name='agents-acting-as-a-user'></a>

### Agents that act as users

Sometimes it's not enough for an agent to perform tasks on behalf of a user or operate with its own identity. In certain scenarios, an agent has its own [agent's user account](../../agent-id/agent-users.md) that functions as a digital worker with its own mailbox, access to chat, and the ability to participate in collaborative workflows as a team member.

In this model, an admin creates a user account in the directory and links it to the agent's identity. From there, it's like any other user account. Licenses can be assigned to access Microsoft 365 resources such as a mailbox and calendar. The account can be added to administrative units and security groups just like a human user account.

Agents using this flow are also considered autonomous agents as they don't involve a user interface for human interaction. In this model, the access token is issued to the agent's user account (the token subject), and policy is evaluated against the agent's user account, not the agent identity. For step-by-step policy configuration, see [Conditional Access for autonomous agents](policy-autonomous-agents.md). For more information about the agent user OAuth flow, see [Agent user OAuth flow](../../agent-id/agent-user-oauth-flow.md).

Agents running on managed endpoints like [Windows 365 Cloud PCs for Agents](/windows-365/agents/introduction-windows-365-for-agents) can also be subject to device compliance and compliant network controls. Use the **Agent execution environments (Preview)** condition to scope these policies to endpoint-based sessions only. For more information, see [Require a compliant device for agents' user accounts](policy-autonomous-agents.md#require-a-compliant-device-for-agents-user-accounts).

<a name='conditional-access-policies-and-agent-identity-blueprints'></a>

## Conditional Access policies and agent identity blueprints

In addition to the specific agent access patterns, you can also select [agent identity blueprints](../../agent-id/agent-blueprint.md) to apply Conditional Access policies to a class of agents. An agent identity blueprint defines the configuration and governance model for agent identities created from it. A policy that targets a blueprint applies to all agent identities created from that blueprint, including agent identities created later.

The following diagram shows that only agent identities associated with blueprint "A" are granted access; all other agents are excluded and blocked.

:::image type="content" source="media/agent-id/conditional-access-agent-identity-blueprint-diagram.png" alt-text="Diagram showing a Conditional Access policy applied to agent identities from one blueprint." lightbox="media/agent-id/conditional-access-agent-identity-blueprint-diagram.png":::

For example, imagine a project where you have several agents, each with its own purpose. Some operate independently, while others collaborate with other agents (A2A) to complete tasks. If they're all created under the same blueprint, a single policy applied to that blueprint enforces consistent access controls across the entire collection.

## Attribute-driven Conditional Access

As the number of agent identities grows, individually managing each one across every policy becomes unsustainable. [Custom security attributes](../../fundamentals/custom-security-attributes-overview.md) let you categorize agent identities and resources with business-specific labels, then target those attributes in Conditional Access policies. Policies automatically apply to every agent with matching attributes, including ones added in the future.

:::image type="content" source="media/agent-id/conditional-access-agent-diagram.png" alt-text="Diagram showing the Conditional Access flow for agent identities." lightbox="media/agent-id/conditional-access-agent-diagram.png":::

For a policy example, see [Allow approved agents by using custom security attributes](policy-autonomous-agents.md#use-custom-security-attributes).

## Boundaries and limitations

Conditional Access policies don't apply when:

- An agent identity blueprint acquires a token for Microsoft Graph to create an agent identity or agent's user account.
  - Agent blueprints have limited functionality. They can't act independently to access resources and are only involved in creating agent identities and agents' user accounts.
  - Agent tasks are always performed by the agent identity.
- An agent identity blueprint or agent identity performs an intermediate token exchange at the `AAD Token Exchange Endpoint: Public` endpoint (Resource ID: `fb60f99c-7a34-4190-8149-302f77469936`).
  - Tokens scoped to the `AAD Token Exchange Endpoint: Public` can't call Microsoft Graph.
  - Agent flows are protected because Conditional Access protects token acquisition from the agent identity or agent's user account.
- [Security defaults](../../fundamentals/security-defaults.md) are enabled.
- Conditional Access only protects resources secured by Microsoft Entra ID. For example, if an agent accesses resources using an API key, it bypasses the Microsoft Entra ID authentication and token issuance pipeline entirely and Conditional Access policies won't apply to them.

The following configurations aren't currently supported:

- Policies scoped through the "Users" assignment don't apply to agent user accounts. This boundary applies whether the policy targets all users, selected users, groups, directory roles, or external users. To protect agent user accounts, create a policy that targets "Agent Users."
- Scoping a Conditional Access policy to include or exclude agent's user account based on their group membership. 
- A Conditional Access policy targeting agent identities won't apply to the agent's user account.
- A Conditional Access policy targeting agent identities using agent identity blueprint covers only the agent identity, not the agent's user account.

Instead, to scope policies to agent users, under **Assignments** > **Users, agents, or workload identities**, select **Agents**, and then target all agent users or specific agent users.

## Related content

- [Target agent identities in Conditional Access policies](howto-target-agent-identities.md)
- [Secure autonomous agents with Conditional Access](policy-autonomous-agents.md)
- [Secure agents that act as users with Conditional Access](policy-agent-user.md)

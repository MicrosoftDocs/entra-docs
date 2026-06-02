---
title: Conditional Access for Agents in Microsoft Entra
description: Learn how Conditional Access for agents in Microsoft Entra ID extends Zero Trust principles to AI agents, ensuring secure access and governance.
ms.topic: concept-article
ms.date: 06/02/2026
ms.reviewer: yoelhor, kvenkit
ms.custom: msecd-doc-authoring-1012
ai-usage: ai-assisted
#customer-intent: As an identity administrator, I want to understand how Conditional Access policies apply to agent identities in Microsoft Entra ID, so that I can effectively manage and secure access for AI agents in my organization.
---

# Conditional Access for agents

Conditional Access is an intelligent policy engine that helps organizations control how users and agents access corporate resources. It brings together real-time signals such as user's and agent's context, device, location, and session risk information to determine when to allow, block, or limit access, or require more verification steps.

Learn about Conditional Access for agents:

- High-level overview of Conditional Access: [What is Conditional Access?](overview.md)
- Guide to managing agent identities across your organization: [Manage agent identities in your organization](../../agent-id/manage-agent-identities-admin.md).
- - Securing agent flows using Conditional Access:
    - [Configure policies for autonomous agent access](policy-autonomous-agents.md)
    - [Configure policies for on-behalf-of agent access](policy-on-behalf-of-agents.md)

## How Conditional Access evaluates agent access requests

To access a corporate resource such as SharePoint file, MCP servers, or Open API services, a user or agent first requests an access token from Microsoft Entra ID.
 
When a Conditional Access policy applies, Microsoft Entra ID evaluates the configured policy requirements before issuing the token. If the requirements are satisfied, an access token is issued. The token is then presented to the target resource, which validates the token and uses its claims to make authorization decisions.

The following diagram illustrates the data access patterns.

:::image type="content" source="media/agent-id/data-access-patterns-diagram.png" alt-text="Diagram showing the data access patterns for agent identities." lightbox="media/agent-id/data-access-patterns-diagram.png":::

### How subjects and audiences are used

Microsoft Entra ID issues an access token to a subject for a specific audience (resource). Each access token has exactly one subject and one audience.

**Subject**: The identity receiving the token.

- In delegated access scenarios, the token represents the user while also identifying the calling application or agent.
- In application-only scenarios, the application or autonomous agent is the subject.
- In agent's user account scenarios, the agent's user account is the subject.

**Audience**: The target resource the token is intended for.

- The resource must be registered in Microsoft Entra ID.
- If a subject needs to access multiple resources (for example, multiple MCP servers or APIs), it typically requires a separate access token for each resource, each with its own audience and permissions.

Conditional Access policies are evaluated based on both the subject requesting access and the audience being accessed.

### How Conditional Access decisions are made

Conditional Access policies operate as if-then statements:

- If the conditions defined in a policy are met, the configured access controls are enforced.
- If the required controls are satisfied, access is granted.
- If the required controls are not satisfied, access is denied.

For example, an organization may require multifactor authentication before a user can authorize an agent to access their email. Similarly, an organization may configure a policy to block access from agents identified as high risk.

### When Conditional Access is evaluated

Conditional Access is evaluated whenever Microsoft Entra ID issues or refreshes an access token. Some resources also support Continuous Access Evaluation, which can trigger near-real-time enforcement for specific events.

Agents can access Microsoft Entra-protected resources using one of the following patterns:

- On behalf of a user (delegated access)
- As an application (autonomous access using the agent identity)
- As a user (autonomous access using the agent's user account)

This access model provides a consistent framework for securing both human and agent access to organizational resources.

## Agent access patterns

There are three agent access patterns for Conditional Access. The on-behalf-of flow, the agents acting as an application (autonomous access) flow, and the agents acting as a user flow.

### On-behalf-of flow

The most common access is the on-behalf-of signed-in user (OBO) flow. In this flow, the agent accesses resources with the user's identity and permissions to retrieve data or perform actions that the user can also can do. For example, when an agent reads your emails, the agent is accessing your mailbox *on your behalf*.

> [!NOTE]
> The on-behalf-of flow is also known as delegated access. Agents using this type of access are sometimes called interactive agents or assistive agents, as they involve a user interface for human interaction.

The following diagram shows the OBO flow used when an agent accesses a resource on a user's behalf, including the following components:

- **User**: Who submits prompts to the agent
- **Agent/Client application**: The user interface where users submit their prompts
- **Microsoft Entra ID**: The identity provider managing the agent identity, user account, and where the resources are registered
- **AI platform**: The runtime environment in which the large language model (LLM) runs
- **Resource**: The resource the agent calls to retrieve data or perform an action, such as Work IQ, SharePoint online, or a custom MCP server

:::image type="content" source="media/agent-id/on-behalf-of-agent-flow-diagram.png" alt-text="Diagram showing the OBO flow for agents accessing resources on behalf of a user." lightbox="media/agent-id/on-behalf-of-agent-flow-diagram-expanded.png":::

The following steps describe the flow in more detail:

1. User accesses the agent application.
    1. The agent application is registered in Microsoft Entra ID and its access is governed by Microsoft Entra ID.
    1. To access the app, users first must authenticate with their account. Admins can target the agent application in the Conditional Access policy.

1. After the user signs in, the app validates the user's access token and grants access.
    1. The user submits a prompt to the AI platform (for example, Copilot Studio, Microsoft Foundry, or a non-Microsoft platform).
    1. To handle and respond to the request, the LLM calls a corporate resource.

1. The corporate resource (SharePoint, email, etc.) is protected by Microsoft Entra ID and requires its own access token.
    - You can't pass the token from step one, because it's issued for a different audience and permissions.
    - Instead, use the OBO flow to exchange tokens with Microsoft Entra ID and obtain a new token scoped to the resource.
    - This token exchange is also evaluated by the Conditional Access policies, letting admins enforce granular controls over which resources agents can access on behalf of the user.
    - Depending on your agent architecture, the OBO token exchange can happen at different layers: the agent application itself, a custom middleware API, an AI platform like Copilot Studio or Azure AI Foundry, or even the MCP server.

1. With the new access token obtained, the agent invokes the resource, presenting the token for authentication.
    - The resource validates the inbound token, returns its response, and the flow is completed.

### Agents acting as an application

Agents might access resources without a signed-in user. In this case the agent accesses the resource with its own identity. This flow is also known as client credentials flow, or app only access. All types of agents might use this flow.

The following diagram shows the application only access authorization flow.

:::image type="content" source="media/agent-id/application-only-flow-diagram.png" alt-text="Diagram showing the application only access flow for agents accessing resources with their own identity." lightbox="media/agent-id/application-only-flow-diagram-expanded.png":::

This flow applies in the following common scenarios:

- **Autonomous agents that operate independently**:
  - These agents run in the background, respond to events, or run on a schedule.
  - For example, an agent that generates a daily report and sends the result to a group of employees. In this scenario, there's no user present, and the agent operates on its own.
- **Interactive agents that use their own identity**:
  - These agents don't always access resources on a user's behalf; sometimes they use their own identity.
  - For example, if an agent calls a backend SMS service that users don't have access to, the OBO flow doesn't apply, and the agent authenticates directly as itself.
- **Agents published on the web for public use**:
  - These agents either don't authenticate the user or don't support delegating the user's context to corporate resources.

In these scenarios, the agent requests an access token using its own agent identity and credentials managed through the agent identity blueprint. The token is issued to the agent identity (not the user). Therefore, Conditional Access policies are scoped to the agent identity rather than the user. You can target agents acting as applications in Conditional Access using the following options:

- **All agent identities**: Targets all agent identities in your directory.
- **Select agent identities**: Target specific agent identities individually.

### Agents acting as a user

Sometimes it's not enough for an agent to perform tasks on behalf of a user or operate with its own identity. In certain scenarios, an agent has its own agent's user account. For example, digital workers that function as team members with their own mailboxes, access to chat, and can participate in collaborative workflows as a team member.

In this model, an admin creates a user account in the directory and links it to the agent's identity. From there, it's like any other user account. Licenses can be assigned to access Microsoft 365 resources such as a mailbox and calendar. The account can be added to administrative units and security groups just like a human user account.

Agents using this flow are sometimes called "digital worker," or "AI teammate." They're also considered autonomous agents as they don't involve a user interface for human interaction. In this model, the access token is issued to the agent's user account (the token subject), and policy is evaluated against the agent's user account, not the agent identity. You can target agent user accounts in Conditional Access using the following options:

- **All agent users (Preview)**: Targets all agent user accounts in your directory.
- **Select agent users (Preview)**: Target specific agent user accounts individually.

#### Agent risk (Preview)

Admins with access to [ID Protection](../../id-protection/overview-identity-protection.md) can evaluate agent risk as part of a Conditional Access policy. Agent risk shows the likelihood that an agent is compromised. For more information, see [ID Protection for agents](../../id-protection/concept-risky-agents.md).

#### Device and network protections for agents on endpoints

Not all agents run the same way. Some agents run directly from the cloud similar to SaaS applications (for example, Copilot Studio hosted agents) with no associated device. Others run on managed endpoints. This distinction determines which Conditional Access controls can be enforced. For more information about agents, see [What is Windows 365 for Agents?](/windows-365/agents/introduction-windows-365-for-agents).

Device compliance and compliant network controls depend on signals that only an endpoint can provide. A Cloud PC enrolled in Microsoft Intune can prove its compliance. An agent running directly from the cloud like a managed service has no device to check, so a policy requiring device compliance would block it with no path to remediation.

The **Agent execution environments (Preview)** condition provides a way for administrators to scope a policy to only apply when the agent's user account session is initiated from an endpoint. When a policy uses this condition, agents that are not running on a device are excluded from evaluation, preventing unintended blocking.

**Device compliance** works for agents on endpoints because:
- Computer-using agents operate within dedicated hosted environments, such as Windows 365 Cloud PCs.
- The Cloud PC is an Intune-managed Windows device, so its compliance status can be evaluated just like any employee laptop.
- If the device falls out of compliance, the agent's access is blocked until compliance is restored.

**Compliant network** works for agents on endpoints because:
- The hosted environment can have a [Global Secure Access](/entra/global-secure-access/overview-what-is-global-secure-access) client installed.
- The Global Secure Access client provides the network location signal that Conditional Access evaluates.
- Agents running in cloud infrastructure without a Global Secure Access client can't provide this signal.

> [!IMPORTANT]
> An agent *can* technically run on any machine, including unmanaged Linux servers or personal devices. But without Intune enrollment and a Global Secure Access client, there's no mechanism to enforce device compliance or network checks. The execution environments condition ensures policies requiring these controls only target sessions where the controls can actually be enforced.

## Ways to select agents to apply Conditional Access policies

In addition to the specific agent access patterns, you can also select agent identity blueprints to apply Conditional Access policies to a class of agents. Custom security attributes can also be used to categorize and target agents for Conditional Access.

### Agent identity blueprints

Another way to apply a Conditional Access policy to multiple agent identities at once is by targeting their parent agent identity blueprint. Every agent identity is derived from an agent identity blueprint, which defines its configuration and governance model. Applying a policy at the blueprint level automatically covers all agent identities derived from it, including any new ones added in the future. Targeting the agent identity blueprint does not cover agents' user accounts.

The following diagram shows that only agent identities associated with blueprint "A" are granted access; all other agents are excluded and blocked.

:::image type="content" source="media/agent-id/conditional-access-agent-identity-blueprint-diagram.png" alt-text="Diagram showing the Conditional Access flow for agent identity blueprints." lightbox="media/agent-id/conditional-access-agent-identity-blueprint-diagram.png":::

For example, imagine a project where you have several agents, each with its own purpose. Some operate independently, while others collaborate with other agents (A2A) to complete tasks. If they're all created under the same blueprint, a single policy applied to that blueprint enforces consistent access controls across the entire collection.

### Attribute-driven Conditional Access

As the number of agent identities grows, individually adding each agent identity across every Conditional Access policy becomes operationally unsustainable. Before you start creating Conditional Access policies, it's important to organize your agent identities to enable consistent, scalable access control enforcement.

Custom security attributes in Microsoft Entra ID are a convenient way to organize agent identities at scale. Custom security attributes are business-specific key-value attributes that you can define and assign to Microsoft Entra objects, including users, agent identities, and enterprise applications (service principals). These attributes let you store meaningful information about each agent identity, like the sensitivity level of the data the agent handles.

The following diagram shows that agent identities with the "Data Sensitivity" attribute set to "Confidential" are blocked; all other agents are excluded and allowed. These custom security attribute values can be used as filters during Conditional Access evaluation, enabling attribute-based targeting. Instead of maintaining a manual list of agent identities or target resources, you can define a rule such as: "If the Data Sensitivity attribute is Confidential, then block access." The policy then automatically applies to every agent identity with those attributes, including ones added in the future.

:::image type="content" source="media/agent-id/conditional-access-agent-diagram.png" alt-text="Diagram showing the Conditional Access flow for agent identities." lightbox="media/agent-id/conditional-access-agent-diagram.png":::

The following table shows a few examples of how you can categorize your agent identities:

| Attribute | Type | Example values |
| --- | --- | --- |
| AgentClassification | String | Orchestrator, SubAgent, Connector |
| DataSensitivity | String | Public, Internal, Confidential, Restricted |
| AgentOrigin | String | Copilot Studio, MicrosoftFoundry, non-Microsoft |
| ForPublicUse | Boolean | True or false |

Custom security attributes aren't just for agent identities. You can also use them to classify the corporate resources the agents access, then use both in your Conditional Access policies for a consistent labeling system across the entire access chain. For more information, see [What are custom security attributes in Microsoft Entra ID](../../fundamentals/custom-security-attributes-overview.md).

### Target resource considerations

To select a target resource in a Conditional Access policy, the resource must have an enterprise application (service principal) with its set of permission in your Microsoft Entra ID tenant. This policy applies to all resource types, including SharePoint Online, Exchange Online, Work IQ MCP servers, the Azure MCP Server, the Microsoft 365 MCP Server, Microsoft Graph, Open API, MCP servers, non-Microsoft tools, and custom tools you build. For more information, see [Targeting resources with Conditional Access](concept-conditional-access-cloud-apps.md).

The enterprise application is required regardless of the data access pattern. The type of permissions granted will differ between user-delegated and application access, but the service principal requirement applies in all cases.

Some Microsoft services require an explicit provisioning step before they appear in your directory. For example, enable the required license or running a PowerShell command. For more information, see the relevant product documentation for details.

For custom MCP servers, Open API-based tools, or any other custom tool type, register the tool as an application in Microsoft Entra ID and expose its set of permissions (delegated or app roles). For more information, see [How to configure an application to expose a web API](../../identity-platform/quickstart-configure-app-expose-web-apis.md).

## Plan Conditional Access deployment

Planning your Conditional Access deployment is critical to achieving your organization's access strategy for agents, users, and resources. Conditional Access policies provide significant configuration flexibility. However, this flexibility means you need to plan carefully to avoid undesirable results. For more information, see [Plan a Conditional Access deployment](plan-conditional-access.md).

To ensure coverage across all agent access patterns, design your policies to cover the three access patterns described in this article: on-behalf-of signed-in users, agent access using the agent's own identity, and agents that operate as users (agents' user accounts).

## Conditional Access boundaries and limitations

Conditional Access policies don't apply when:

- An agent identity blueprint acquires a token for Microsoft Graph to create an agent identity or agent's user account.
  - Agent blueprints have limited functionality. They can't act independently to access resources and are only involved in creating agent identities and agents' user accounts.
  - Agentic tasks are always performed by the agent identity.
- An agent identity blueprint or agent identity performs an intermediate token exchange at the `AAD Token Exchange Endpoint: Public` endpoint (Resource ID: `fb60f99c-7a34-4190-8149-302f77469936`).
  - Tokens scoped to the `AAD Token Exchange Endpoint: Public` can't call Microsoft Graph.
  - Agentic flows are protected because Conditional Access protects token acquisition from the agent identity or agent's user account.
- [Security defaults](../../fundamentals/security-defaults.md) are enabled.
- Conditional Access only protects resources secured by Microsoft Entra ID. For example, if an agent accesses resources using an API key, it bypasses the Microsoft Entra ID authentication and token issuance pipeline entirely and Conditional Access policies won't apply to them.

The following configurations aren't currently supported:

- Scoping a Conditional Access policy to include or exclude agent's user account based on their group membership
- A Conditional Access policy targeting agent identities won't apply to the agent's user account.
- A Conditional Access policy targeting agent identities using agent identity blueprint covers only the agent identity, not the agent's user account.

## Investigating policy evaluation using sign-in logs

Admins can use the sign-in logs to investigate why a Conditional Access policy did or didn't apply. For agent-specific entries, filter for `agentType`. Some of these events appear in the **User sign-ins (non-interactive)** while others appear under **Service principal sign-ins**. For more information, see [Microsoft Entra Agent ID sign-in and audit logs](../../agent-id/sign-in-audit-logs-agents.md).

- Agent identities (actor) accessing any resources → **Service principal sign-in logs** → agentType: agent identity
- Agent's user account accessing any resources → **Non-interactive user sign-ins** → agentType: agent's user account
- Users accessing agents → **User sign-ins**

## Next steps

Learn how to configure Conditional Access policies for agent identities:

- [Block high-risk agent identities](policy-agent-block-high-risk.md)
- [Configure policy for autonomous agent access](policy-autonomous-agents.md)
- [Configure policy for on-behalf-of agent access](policy-on-behalf-of-agents.md)
---
title: Conditional Access for Agent Identities in Microsoft Entra
description: Learn how Conditional Access for agent identities in Microsoft Entra ID extends Zero Trust principles to AI agents, ensuring secure access and governance.
ms.topic: concept-article
ms.date: 05/15/2026
ms.reviewer: yoelhor
ms.custom: msecd-doc-authoring-1012
ai-usage: ai-assisted
#customer-intent: As an identity administrator, I want to understand how Conditional Access policies apply to agent identities in Microsoft Entra ID, so that I can effectively manage and secure access for AI agents in my organization.
---

# Conditional Access for agent identities

Conditional Access is an intelligent policy engine that helps organizations control how users and agent identities access corporate resources. It brings together real-time signals such as user's context, device, location, and session risk information to determine when to allow, block, or limit access, or require more verification steps.

Learn about Conditional Access and agent identities:

- High-level overview of Conditional Access: [What is Conditional Access?](overview.md)
- Guide to managing agent identities across your organization: [Manage agent identities in your organization](../../agent-id/manage-agent-identities-admin.md).
- Policy templates:
    - [Block high-risk agent identities](policy-agent-block-high-risk.md)
    - [Configure policy for autonomous agent access](policy-autonomous-agents.md)
    - [Configure policy for on-behalf-of agent access](policy-on-behalf-of-agents.md)

## Attribute-driven Conditional Access

As the number of agent identities grows, individually adding each agent identity across every Conditional Access policy becomes operationally unsustainable. Before you start creating Conditional Access policies, it's important to organize the agent identities, enabling consistent, scalable access control enforcement.

Custom security attributes in Microsoft Entra ID are a convenient way to organize agent identities at scale. Custom security attributes are business-specific key-value attributes that you can define and assign to Microsoft Entra objects, including users, agent identities, and enterprise applications (service principals). These attributes let you store meaningful information about each agent identity, like the sensitivity level of the data the agent handles.

The following diagram shows that agent identities with the "Data Sensitivity" attribute set to "Confidential" are blocked; all other agents are excluded and allowed. These custom security attribute values can be used as filters during Conditional Access evaluation, enabling attribute-based targeting. Instead of maintaining a manual select agent identities or target resources, you can define a rule such as: "If the Data Sensitivity attribute is Confidential," then block access. The policy then automatically applies to every agent identity with those attributes, including the ones added in the future.

:::image type="content" source="media/agent-id/conditional-access-agent-diagram.png" alt-text="Diagram showing the Conditional Access flow for agent identities." lightbox="media/agent-id/conditional-access-agent-diagram.png":::

The following table shows a few examples of how you can categorize your agent identities:

| Attribute | Type | Example values |
| --- | --- | --- |
| AgentClassification | String | Orchestrator, SubAgent, Connector |
| DataSensitivity | String | Public, Internal, Confidential, Restricted |
| AgentOrigin | String | Copilot Studio, MicrosoftFoundry, non-Microsoft |
| ForPublicUse | Boolean | True or false |

Custom security attributes aren't just for agent identities. You can also use them to classify the corporate resources the agents access, then use both in your Conditional Access policies for a consistent labeling system across the entire access chain. For more information, see [What are custom security attributes in Microsoft Entra ID](../../fundamentals/custom-security-attributes-overview.md).

## Agent identity blueprints

Another way to apply a Conditional Access policy to multiple agent identities at once is by targeting their parent agent identity blueprint. Every agent identity is derived from an agent identity blueprint, which defines its configuration and governance model. Applying a policy at the blueprint level automatically covers all agent identities derived from it, including any new ones added in the future. Targeting the agent identity blueprint does not cover agents' user accounts.

The following diagram shows that only agent identities associated with blueprint "A" are granted access; all other agents are excluded and blocked.

:::image type="content" source="media/agent-id/conditional-access-agent-identity-blueprint-diagram.png" alt-text="Diagram showing the Conditional Access flow for agent identity blueprints." lightbox="media/agent-id/conditional-access-agent-identity-blueprint-diagram.png":::

For example, imagine a project where you have several agents, each with its own purpose. Some operate independently, while others collaborate with other agents (A2A) to complete tasks. If they're all created under the same blueprint, a single policy applied to that blueprint enforces consistent access controls across the entire collection.

## Data access patterns overview

To access a corporate resource such as SharePoint file, MCP servers, or Open API services, a user, or agent first requests an access token from Microsoft Entra ID. However, access tokens are issued only after the required Conditional Access controls are satisfied. Once the access token is issued, the agent presents that token to the resource to prove its identity. The resource validates the token and uses its claims to enforce authorization.

The following diagram illustrates the data access patterns.

:::image type="content" source="media/agent-id/data-access-patterns-diagram.png" alt-text="Diagram showing the data access patterns for agent identities." lightbox="media/agent-id/data-access-patterns-diagram.png":::

Conditional Access policies are if-then statements: *if* a user or agent wants to access a resource, *then* something must happen first. For example, if an agent needs to read a user's email on their behalf through the Work IQ MCP, the user must complete multifactor authentication before access is granted. Likewise, if an agent attempts to access any resource not explicitly included in the policy, access is blocked by default.

Microsoft Entra ID issues an access token to a subject for a specific audience (resource). Each token has exactly one subject and one audience.

- **The "subject" identifies who the token was issued to**:
  - When an application or agent requests a token on behalf of a user, the user is the subject.
  - When an application or agent requests a token for itself, the application or the agent is the subject.
- **The "audience" identifies the target resource the token is meant for**:
  - This resource must be registered in Microsoft Entra ID.
  - If the subject needs to call multiple resources (for example, two different MCP servers), it typically needs a separate access token for each resource, each with its own audience and permissions.

Conditional Access policies are reevaluated each time an access token is requested, which typically happens upon token expiration or when a critical event is triggered, such as Continuous Access Evaluation.

Agents can access corporate resources that are protected by Microsoft Entra ID using one of the following patterns:

- [On behalf of a user](#on-behalf-of-obo-flow)
- [Application only](#application-only-access-flow)
- [Agent user's account](#agents-user-account)

For more information about the types of agents and the identity and access management challenges they present, see [Security for AI](../../agent-id/security-for-ai-overview.md).

## Select the target resource

To select a target resource in a Conditional Access policy, the resource must have an enterprise application (service principal) with its set of permission in your Microsoft Entra ID tenant. This policy applies to all resource types, including SharePoint Online, Exchange Online, Work IQ MCP servers, the Azure MCP Server, the Microsoft 365 MCP Server, Microsoft Graph, Open API, MCP servers, non-Microsoft tools, and custom tools you build.

The enterprise application is required regardless of the data access pattern, whether agents access on-behalf-of a user, application-only access, or an agent's user account. The type of permissions granted will differ between user-delegated and application access, but the service principal requirement applies in all cases.

Some Microsoft services require an explicit provisioning step before they appear in your directory. For example, enable the required license or running a PowerShell command. For more information, see the relevant product documentation for details.

For custom MCP servers, Open API-based tools, or any other custom tool type, register the tool as an application in Microsoft Entra ID and expose its set of permissions (delegated or app roles). For more information, see [How to configure an application to expose a web API](../../identity-platform/quickstart-configure-app-expose-web-apis.md).

## On-Behalf-Of (OBO) flow

The most common access is the on-behalf-of signed-in user (OBO) flow. In this flow, the agent accesses resources with the user's identity and permissions to retrieve data or perform actions that the user can also can do. For example, when an agent reads your emails, the agent is accessing your mailbox *on your behalf*.

> [!NOTE]
> The on-behalf-of flow is also known as delegated access. Agents using this type of access are sometimes called interactive agents or assistive agents, as they involve a user interface for human interaction.

The following diagram shows the OBO flow used when an agent accesses a resource on a user's behalf, including the following components:

:::image type="content" source="media/agent-id/on-behalf-of-agent-flow-diagram.png" alt-text="Diagram showing the OBO flow for agents accessing resources on behalf of a user." lightbox="media/agent-id/on-behalf-of-agent-flow-diagram-expanded.png":::

- **User**: Who submits prompts to the agent
- **Agent/Client application**: The user interface where users submit their prompts
- **Microsoft Entra ID**: The identity provider managing the agent identity, user account, and where the resources are registered
- **AI platform**: The runtime environment in which the large language model (LLM) runs
- **Resource**: The resource the agent calls to retrieve data or perform an action, such as Work IQ, SharePoint online, or a custom MCP server

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

### Configure Conditional Access policy for OBO flow

To create a Conditional Access policy for agents operating on-behalf-of a user, use the following settings:

- **Assignments**: In an OBO flow, the access token is issued to the user (the token subject), so you assign the policy to users or groups, but not the agent or [agent's user account](../../agent-id/agent-users.md).
- **Target resources**: Select what the user or the agent on behalf of the user is trying to access:
  - For any target resource, either choose to target "all resources", "all agents", or select each individual resource you want to target with that policy.
- **Network assignment**: Admins can create policies that target specific network locations as a signal along with other conditions in their decision-making process. In this context, *network* refers to the locations where the user signs in, not where the agent runs.
- **Conditions**: Configure the signals Conditional Access evaluates, such as user risk, sign-in risk, or other factors.
- **Access control**: Enforce whether access to a target resource is granted, denied, limit access, or require more verification steps from the user.

## Application only access flow

Agents might access resources without a signed-in user. In this case the agent accesses the resource with its own identity. The following diagram illustrates how agent access resources with their own identity.

This flow is also known as client credentials flow, or app only access. All types of agents might use this flow.

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

In these scenarios, the agent requests an access token using its own agent identity and credentials managed through the agent identity blueprint. The token is issued to the agent identity (not the user). Therefore, Conditional Access policies are scoped to the agent identity rather than the user.

### Configure Conditional Access policy for application access flow

To create a Conditional Access policy for agents operating with their own identity, use the following settings:

- **Assignments**: In an agent access flow, the access token is issued to the agent identity (the token subject), so you assign the policy to agent identities or their agent identity blueprint.
- **Target resources**: Select the resources the agent identity needs to access.
- **Conditions**: Configure Conditional Access policy for agents' user accounts accessing resources.
- **Access control**: Because this agent accesses resources with its own identity, there's no remediation and the only available option is blocking access.

## Agent's user account

Sometimes it's not enough for an agent to perform tasks on behalf of a user or operate with its own identity. In certain scenarios, an agent is actually a user. For example, digital workers that function as team members with their own mailboxes, access to chat, and can participate in collaborative workflows as a team member.

In this model, an admin creates a user account in the directory and links it to the agent's identity. From there, it's like any other user account. Licenses can be assigned to access Microsoft 365 resources such as a mailbox and calendar. The account can be added to administrative units and security groups just like a human user account.

Agents using this flow are sometimes called "digital worker," or "AI teammate." They're also considered autonomous agents as they don't involve a user interface for human interaction.

In this model, the access token is issued to the agent's user account (the token subject), and policy is evaluated against the agent's user account, not the agent identity. Today, you can target an agent's user account with a single scope: "all agents acting as a user."

### Agent's user account Conditional Access considerations

Agent's user accounts have a different security risk profile than human users. For example, an agent's user account is inherently phish resistant. For this reason, many of the main user-based Conditional Access controls such as MFA and device compliance do not apply to them.   

For example, "Require MFA" assumes a human user can complete an interactive authentication challenge, including phishing-resistant methods where applicable. An agent's user account cannot satisfy such interactive requirements in the same manner as human users.

"Require compliant device" assumes access originates from a managed client device whose compliance posture can be evaluated. Today, agents' user accounts do not operate from traditional end-user client devices.

For these reasons, human-centric Conditional Access controls are intentionally not applied to agents' user accounts. This separation is a deliberate design choice to preserve correct policy semantics across supported Microsoft and non-Microsoft agent scenarios.

### Configure Conditional Access policy for an agent's user account

To create a Conditional Access policy for an agent's user account, use the following settings:

- **Assignments**: In an agent's user account flow, choose the "Select agents acting as users", and then select "All agent users"
- **Target resources**: All resources
- **Access control**: At this time, blocking access to all resources is the only policy configuration allowed for agents' user accounts. Because this policy covers an agent's user account, there's no remediation to authentication challenges, therefore the only available option is blocking access.

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

- Scoping a Conditional Access policy to include or exclude agent's user account based on their group membership and Custom Security Attributes.
- A Conditional Access policy targeting agent identities in an agent-to-agent scenario using Custom Security Attributes won't apply to the agent's user account.
- A Conditional Access policy targeting agent identities in an agent-to-agent scenario using agent identity blueprint covers only the agent identity, not the agent's user account.

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
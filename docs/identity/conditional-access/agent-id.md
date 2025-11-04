---
title: Conditional Access for Agent Identities in Microsoft Entra
description: Learn how Conditional Access for Agent IDs in Microsoft Entra ID extends Zero Trust principles to AI agents, ensuring secure access and governance.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: concept-article
ms.date: 11/03/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: kvenkit
---
# Conditional Access and agent identities (Preview)

Conditional Access for Agent ID is a new capability in Microsoft Entra ID that brings Conditional Access evaluation and enforcement to AI agents. This extends the same Zero Trust controls that already protect human users and apps to your agents. Conditional Access treats agents as first-class identities and evaluates their access requests the same way it does for human users or workload identities, but with agent-specific logic.

These agent users are designed for experiences such as Digital Workers. Because agent users have built-in security features, such as always being authenticated with strong credentials and running in secure context, that differ from human users, existing Conditional Access conditions (like device platform, client apps) and controls (like MFA) in your existing user-based policies don't apply to them.

Admins can use new Conditional Access policies to govern agent users. During public preview, block access to all resources is the only policy configuration allowed for agent users. 

## Agent identity architecture in Microsoft Entra

To understand how Conditional Access works with agent identities, it is important to understand the fundamentals of Microsoft Entra Agent ID. Agent ID introduces first-class identity constructs for agents. These are modelled as applications (agent identities) and users (agent users).

| Term | Description |
| --- | --- |
| Agent blueprint | A logical definition of an agent type. Necessary for agent identity blueprint principal creation in the tenant. |
| Agent identity blueprint principal | A service principal representing the agent blueprint in the tenant; executes only creation of agent identities and agent users |
| Agent identity | Instantiated agent identity. Performs token acquisitions to access resources. |
| Agent user | Non-human user identity used for agent experiences that require a user account. Performs token acquisitions to access resources. |
| Agent resource | Agent blueprint or agent identity acting as the resource app (for example, in agent to agent (A2A) flows) |

For more information see the article [Microsoft Entra agent ID security capabilities for AI Agents](../../agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents.md).

## Conditional Access capabilities for agent apps and agent users

Conditional Access enforces Zero Trust principles across all token acquisition flows initiated by agent identities and agent users.

Conditional Access applies when: 

- An agent identity requests a token for any resource (agent identity → resource flow). 
- An agent user requests a token for any resource (agent user → resource flow).

Conditional Access does not apply when:

- Agent identity blueprint acquires a token for Microsoft Graph to create an agent identity or agent user.

   > [!NOTE]
   > Agent blueprints have limited functionality. They cannot act independently to access resources and are only involved in creation of agent identities and agent users. Agentic tasks are always performed by the agent identity (Agent ID). 

- Agent identity blueprint or agent identity performs an intermediate token exchange at the AAD Token Exchange Endpoint: Public endpoint (Resource ID: fb60f99c-7a34-4190-8149-302f77469936).

   > [!NOTE]
   > Tokens scoped to AAD Token Exchange Endpoint: Public can't call MS Graph. Agentic flows are protected because we protect token acquisition from agent identity or agent user.

- Conditional Access policies scoped to users or workload identities don't apply to agents.
- [Security defaults](../../fundamentals/security-defaults.md) don't apply to agents.

| Authentication flow | Does Conditional Access apply | Details |
| --- | :---: | --- |
| Agent identity blueprint → Graph (create agent identity (Agent ID)/agent user) | ❌<br>No | Blueprint can only create agent identities and agent users; it's not a risk. |
| Agent identity blueprint or Agent identity (Agent ID) → Token Exchange | ❌<br>No | This is an internal flow with limited audience scope. |
| Agent identity (Agent ID) → Resource | ✅<br>Yes | Governed by agent identity policies. |
| Agent user → Resource | ✅<br>Yes | Governed by agent user policies. |

## Policy configuration

Creating a Conditional Access policy for agents involves these four key components: 

:::image type="content" source="media/agent-id/conditional-access-agent-settings.png" alt-text="Screenshot of the Conditional Access interface with a policy blocking all agent identities at high risk." lightbox="media/agent-id/conditional-access-agent-settings.png":::

1. Assignments (Agent Selection) 
   1. Scope policies to: 
      1. All agent identities in the tenant.
      1. Specific agent identities based on their GUID.
      1. Agent identities based on custom security attributes.
      1. Agent identities grouped by their blueprint.
      1. All agent users in the tenant.*
1. Target Resources 
   1. Resource targeting options include: 
      1. All resources (cloud apps + agent blueprints + agent identities).
      1. All agent resources (agent blueprints and agent identities).
      1. Specific resources grouped by custom security attributes.
      1. Specific resources based on their GUID.
      1. Agent blueprints (targeting the blueprint covers the agent identities parented by the blueprint).
1. Conditions 
   1. Agent risk (high, medium, low)
      1. Detections: Unfamiliar Resource Access, Sign-In Spike, Failed Access Attempt, and Sign-In by Risky User.
1. Access Controls 
   1. Block.
1. Policies can be toggled On, Off, or set to Report-only for simulation.

## Common Conditional Access scenarios - biz scenarios

### Scenario 1: My organization is testing agents. I want to configure a Conditional Access policy to allow only approved agents to access specific resources.

#### Method 1: The first method is using custom security attributes. 

##### Create and assign custom attributes

This approach uses steps similar to those documented in [Filter for applications in Conditional Access policy](concept-filter-for-applications.md). Attributes across multiple attribute sets can be assigned to an agent or cloud application.

1. Create the custom security attributes using the following steps:
   1. Create an **Attribute set** named *AgentAttributes*.
   1. Create **New attributes** named *agentStatus* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**. 
      1. Add the following predefined values: New, In Review, Approved.
   1. Assign the ‘Approved’ value to agents that your organization is ready to test.
1. Create another attribute set to group resources that your agents are allowed to access.
   1. Create an **Attribute set** named *sensitivity*.
   1. Create **New attributes** named *businessImpact* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**.
      1. Add the following predefined values: Low, Medium, High.
   1. Assign the ‘Low’ value to resources that your agent is allowed to access.

##### Create Conditional Access policy

Once done, the following steps help create a Conditional Access policy to block all agent identities except those vetted and approved by your organization. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Attribute Definition Reader](../role-based-access-control/permissions-reference.md#attribute-definition-reader).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Under **What does this policy apply to?**, select **Agents (Preview)**.
      1. Under **Include**, select **All agent identities (Preview)**.
      1. Under **Exclude**: 
         1. Select **Select agent identities based on attributes**.
         1. Set **Configure** to **Yes**. 
         1. Select the Attribute we created earlier called **agentStatus**.
         1. Set **Operator** to **Contains**.
         1. Set Value to **approved**.
         1. Select **Done**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
   1. Include **Select resources**.
      1. Select **Select resources based on attributes**.
      1. Set **Configure** to **Yes**.
      1. Select the Attribute we created earlier called **businessImpact**.
      1. Set **Operator** to **Contains**.
      1. Set **Value** to **low**
      1. Select a second Attribute called **department**.
      1. Set **Operator** to **Contains**.
      1. Set **Value** to **HR**.
      1. Select **Done**.
1. Under **Access controls** > **Grant**. 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

#### Method 2: The second method uses enhanced agent and resource selection experience



### Scenario 2: I want to configure a Conditional Access policy to block high risk agent identities from accessing my organization’s resources

The following steps help create a Conditional Access policy to block agent identities at high risk.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Undr **What does this policy apply to?**, select **Agents (Preview)**.
      1. Under **Include**, select **All agent identities (Preview)**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
   1. Include, **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Agent risk (Preview)**, set **Configure** to **Yes**.
   1. Under **Configure agent risk levels needed for policy to be enforced**, select **High**. This guidance is based on Microsoft recommendations and might be different for each organization.
1. Under **Access controls** > **Grant**. 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

Conditional Access policies can be used to block authentication and token issuance of Agent IDs. Applying the policies below will prevent existing and new Agent IDs from authenticating. It will not prevent the creation of Agent IDs in your tenant (see below).
Applying these policies in your tenant requires the Microsoft Entra Agent ID license, which is currently available at no cost. To acquire this license, go to this page.
To comprehensively block authentication and token issuance of Agent IDs, create the following condtitional access block policies. It's recommended to run these policies in report-only mode and understand their impact before enforcing them.

#### Policy 1: Block agent identity authentication

The following steps help create a Conditional Access policy to block issuance of access tokens requested using agent identities.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Undr **What does this policy apply to?**, select **Agents (Preview)**.
      1. Under **Include**, select **All agent identities (Preview)**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
   1. Include, **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**. 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

#### Policy 2: Block agent user authentication

The following steps help create a Conditional Access policy to block issuance of access tokens requested using agent users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Undr **What does this policy apply to?**, select **Agents (Preview)**.
      1. Under **Include** > **Select agents** > **Select agents acting as users** > **All agents acting as users (Preview)**
      1. Select **Select**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
   1. Include, **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**. 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select Create to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

#### Policy 3: Block users signing into agents

The following steps help create a Conditional Access policy to block issuance of access tokens to agent resources when requested by human users. This blocks human users from signing into agents and agents performing actions on their behalf.

Purpose: Block users from signing into agents and agents performing actions on their behalf.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Under **Include**, select **All users**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
   1. Include, select **All agent resources (Preview)**.
1. Under **Access controls** > **Grant**. 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select Create to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Investigating policy evaluation using sign-in logs

Agent identities (actor) accessing any resources -> Service principal sign-in logs -> agentType: agent identity
Agent users accessing any resources -> Non-interactive user sign-ins -> agentType: agent user
Users accessing agents -> User sign-ins

## Conditional Access policy evaluation details for agents

## FAQ: (a) My org doesn't want to deploy agents - what do I do? 

### SKU

Requires the Microsoft Entra Agent ID SKU. Learn more about Microsoft Entra Agent ID capabilities, or any of the four new A365 SKUs.

## Next steps

---
title: Conditional Access for Agent Identities in Microsoft Entra
description: Learn how Conditional Access for Agent IDs in Microsoft Entra ID extends Zero Trust principles to AI agents, ensuring secure access and governance.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: concept-article
ms.date: 11/05/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: kvenkit
---
# Conditional Access and agent identities (Preview)

Conditional Access for Agent ID is a new capability in Microsoft Entra ID that brings Conditional Access evaluation and enforcement to AI agents. This capability extends the same Zero Trust controls that already protect human users and apps to your agents. Conditional Access treats agents as first-class identities and evaluates their access requests the same way it evaluates requests for human users or workload identities, but with agent-specific logic.

For more information about the types of agents and the challenges they present, see [Security for AI with Microsoft Entra agent identity](../../agent-id/identity-professional/security-for-ai.md).

Admins can use new Conditional Access policies to govern agent identities and users. During public preview, blocking access to all resources is the only policy configuration allowed for agent users. 

[!INCLUDE [entra-agent-id-license-note](../../includes/entra-agent-id-license-note.md)]

## Agent identity architecture in Microsoft Entra

To understand how Conditional Access works with agent identities, it's important to understand the fundamentals of Microsoft Entra Agent ID. Agent ID introduces first-class identity constructs for agents. These are modeled as applications (agent identities) and users (agent users).

| Term | Description |
| --- | --- |
| Agent blueprint | A logical definition of an agent type. Necessary for agent identity blueprint principal creation in the tenant. |
| Agent identity blueprint principal | A service principal that represents the agent blueprint in the tenant and executes only creation of agent identities and agent users. |
| Agent identity | Instantiated agent identity. Performs token acquisitions to access resources. |
| Agent user | Nonhuman user identity used for agent experiences that require a user account. Performs token acquisitions to access resources. |
| Agent resource | Agent blueprint or agent identity acting as the resource app (for example, in agent to agent (A2A) flows). |

For more information, see [Microsoft Entra agent ID security capabilities for AI Agents](../../agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents.md).

## Conditional Access capabilities for agent apps and agent users

Conditional Access enforces Zero Trust principles across all token acquisition flows initiated by agent identities and agent users.

Conditional Access applies when: 

- An agent identity requests a token for any resource (agent identity → resource flow). 
- An agent user requests a token for any resource (agent user → resource flow).

Conditional Access doesn't apply when:

- An agent identity blueprint acquires a token for Microsoft Graph to create an agent identity or agent user.

   > [!NOTE]
   > Agent blueprints have limited functionality. They can't act independently to access resources and are only involved in creating agent identities and agent users. Agentic tasks are always performed by the agent identity.

- An agent identity blueprint or agent identity performs an intermediate token exchange at the AAD Token Exchange Endpoint: Public endpoint (Resource ID: fb60f99c-7a34-4190-8149-302f77469936).

   > [!NOTE]
   > Tokens scoped to AAD Token Exchange Endpoint: Public can't call MS Graph. Agentic flows are protected because we protect token acquisition from agent identity or agent user.

- The Conditional Access policy is scoped to users or workload identities, **not** to agents.
- [Security defaults](../../fundamentals/security-defaults.md) are enabled.

| Authentication flow | Does Conditional Access apply | Details |
| --- | :---: | --- |
| Agent identity blueprint → Graph (create agent identity (Agent ID)/agent user) | ❌<br>No | Blueprints can only create agent identities and agent users; it's not a risk. |
| Agent identity blueprint or Agent identity (Agent ID) → Token Exchange | ❌<br>No | This is an internal flow with limited audience scope. |
| Agent identity (Agent ID) → Resource | ✅<br>Yes | Governed by agent identity policies. |
| Agent user → Resource | ✅<br>Yes | Governed by agent user policies. |

## Policy configuration

Creating a Conditional Access policy for agents involves these four key components: 

:::image type="content" source="media/agent-id/conditional-access-agent-settings.png" alt-text="Screenshot of the Conditional Access interface with a policy blocking all agent identities at high risk." lightbox="media/agent-id/conditional-access-agent-settings.png":::

1. Assignments
   1. Scope policies to: 
      1. All agent identities in the tenant.
      1. Specific agent identities based on their GUID.
      1. Agent identities based on custom security attributes.
      1. Agent identities grouped by their blueprint.
      1. All agent users in the tenant.
1. Target resources
   1. Resource targeting options include: 
      1. All resources (cloud apps + agent blueprints + agent identities).
      1. All agent resources (agent blueprints and agent identities).
      1. Specific resources grouped by custom security attributes.
      1. Specific resources based on their appId.
      1. Agent blueprints (targeting the blueprint covers the agent identities parented by the blueprint).
1. Conditions
   1. Agent risk (high, medium, low).
1. Access controls
   1. Block.
1. Policies can be toggled On, Off, or set to Report-only for simulation.

## Common business scenarios

There are two key business scenarios that we envision Conditional Access policies taking care of when it comes to agents. 

The first scenario is your organization is testing agents and you want to configure a Conditional Access policy to allow only approved agents to access specific resources. You can accomplish this either by tagging all agents and resources with custom security attributes you target in policy, or by manually picking the agents and resources using the enhanced object picker.

The second scenario uses signals from Microsoft Entra ID Protection to block agents performing risky behaviors.

### [Using custom security attributes](#tab/custom-security-attributes)

The recommended approach for the first scenario is to create and assign custom security attributes to each agent or agent blueprint, then target those attributes with a Conditional Access policy. This approach uses steps similar to those documented in [Filter for applications in Conditional Access policy](concept-filter-for-applications.md). You can assign attributes across multiple attribute sets to an agent or cloud application.

##### Create and assign custom attributes

1. Create the custom security attributes:
   1. Create an **Attribute set** named *AgentAttributes*.
   1. Create **New attributes** named *agentStatus* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**. 
      1. Add the following predefined values: **New**, **In Review**, and **Approved**.
   1. Assign the **Approved** value to agents that your organization is ready to test.
1. Create another attribute set to group resources that your agents are allowed to access.
   1. Create an **Attribute set** named *sensitivity*.
   1. Create **New attributes** named *businessImpact* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**.
      1. Add the following predefined values: **Low**, **Medium**, and **High**.
   1. Assign the **Low** value to resources that your agent is allowed to access.

##### Create Conditional Access policy using custom security attributes

After you complete the previous steps, create a Conditional Access policy using custom security attributes to block all agent identities except those reviewed and approved by your organization. 

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
         1. Set **Value** to **Approved**.
         1. Select **Done**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
      1. Include **All resources (formerly 'All cloud apps')**
      1. Exclude **Select resources**.
         1. Select **Select resources based on attributes**.
         1. Set **Configure** to **Yes**.
         1. Select the Attribute we created earlier called **businessImpact**.
         1. Set **Operator** to **Contains**.
         1. Set **Value** to **Low**.
1. Under **Access controls** > **Grant**: 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

### [Using the enhanced object picker](#tab/enhanced-object-picker)

##### Create Conditional Access policy using the enhanced object picker

Alternatively, organizations can create a Conditional Access policy using the enhanced object picker to block all agent identities except those reviewed and approved by your organization. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Attribute Definition Reader](../role-based-access-control/permissions-reference.md#attribute-definition-reader).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Under **What does this policy apply to?**, select **Agents (Preview)**.
      1. Under **Include**, select **All agent identities (Preview)**.
      1. Under **Exclude**: 
         1. Select **Select individual agent identities**.
1. Using the enhanced object picker, switch between the tabs **All**, **Agent blueprints**, and **Agent identities** to select the individual agent blueprints and/or agent identities approved for use in your environment.
         1. Select **Select**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
      1. Include **All resources (formerly 'All cloud apps')**
      1. Exclude **Select resources**.
         1. Select **Select specific resources**.
1. Using the enhanced object picker, switch between the tabs **All**, **Enterprise applications**, and **Agent blueprints** to select individual resources.
         1. Select **Select**.
1. Under **Access controls** > **Grant**: 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

---

### Block high risk agent identities from accessing my organization’s resources

Create a Conditional Access policy to block high-risk agent identities based on signals from Microsoft Entra ID Protection.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Under **What does this policy apply to?**, select **Agents (Preview)**.
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

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Investigating policy evaluation using sign-in logs

Admins can use the Sign-in logs to investigate why a Conditional Access policy did or didn't apply as explained in [Microsoft Entra sign-in events](troubleshoot-conditional-access.md#microsoft-entra-sign-in-events). For agent-specific entries, filter for **agentType** of **agent user** or **agent identity**. Some of these events appear in the **User sign-ins (non-interactive)** while others appear under **Service principal sign-ins**.

- Agent identities (actor) accessing any resources → Service principal sign-in logs → agentType: agent identity
- Agent users accessing any resources → Non-interactive user sign-ins → agentType: agent user
- Users accessing agents → User sign-ins

## Frequently asked questions

### My organization doesn't want to deploy agents - what do I do?

See [Block all agent authentication and token issuance](#block-all-agent-authentication-and-token-issuance) for complete guidance on blocking all agent authentication and token issuance in your tenant.

### Block all agent authentication and token issuance

While there's no way to completely stop your users from creating agents in your tenant, you can comprehensively block all agent authentication and token issuance by implementing **all three** of the following Conditional Access policies together. 

> [!IMPORTANT]
> You must implement all three policies to ensure complete coverage. Each policy blocks a different authentication path that agents can use to access resources.

These policies will:

- Block existing and new agent identities from authenticating
- Block agent users from accessing resources  
- Block human users from signing into agents
- **Won't** prevent the creation of new agent identities in your tenant

> [!NOTE]
> We recommend running these policies in report-only mode first to understand their impact before enforcing them.

#### Policy 1: Block agent identity authentication

The following steps help create a Conditional Access policy to block issuance of access tokens requested using agent identities.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Under **What does this policy apply to?**, select **Agents (Preview)**.
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
   1. Under **What does this policy apply to?**, select **Agents (Preview)**.
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

<!--- PENDING INFO FROM PM
## Conditional Access policy evaluation details for agents
--->

## Related content

- [Conditional Access template policies](concept-conditional-access-policy-common.md#ai-agentstabai-agents)
- [Conditional Access: Users, groups, agents, and workload identities](concept-conditional-access-users-groups.md)
- [Conditional Access: Target resources](concept-conditional-access-cloud-apps.md)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
- [Conditional Access: Grant](concept-conditional-access-grant.md)
- [Security for AI with Microsoft Entra agent identity](../../agent-id/identity-professional/security-for-ai.md)

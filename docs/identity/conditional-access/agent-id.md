---
title: Conditional Access for Agent Identities in Microsoft Entra
description: Learn how Conditional Access for Agent IDs in Microsoft Entra ID extends Zero Trust principles to AI agents, ensuring secure access and governance.
ms.topic: concept-article
ms.date: 11/05/2025
ms.custom: agent-id-ignite
manager: dougeby
ms.reviewer: kvenkit
---
# Conditional Access for Agent ID (Preview)

Conditional Access for Agent ID is a new capability in Microsoft Entra ID that brings Conditional Access evaluation and enforcement to AI agents. This capability extends the same Zero Trust controls that already protect human users and apps to your agents. Conditional Access treats agents as first-class identities and evaluates their access requests the same way it evaluates requests for human users or workload identities, but with agent-specific logic.

For more information about the types of agents and the identity and access management challenges they present, see [Security for AI with Microsoft Entra agent identity](../../agent-id/identity-professional/security-for-ai.md).

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

## Conditional Access capabilities for agent identities and agent users

Conditional Access enforces Zero Trust principles across all token acquisition flows initiated by agent identities and agent users.

Conditional Access applies when: 

- An agent identity requests a token for any resource (agent identity → resource flow). 
- An agent user requests a token for any resource (agent user → resource flow).

Conditional Access doesn't apply when:

- An agent identity blueprint acquires a token for Microsoft Graph to create an agent identity or agent user.

   > [!NOTE]
   > Agent blueprints have limited functionality. They can't act independently to access resources and are only involved in creating agent identities and agent users. Agentic tasks are always performed by the agent identity.

- An agent identity blueprint or agent identity performs an intermediate token exchange at the `AAD Token Exchange Endpoint: Public endpoint (Resource ID: fb60f99c-7a34-4190-8149-302f77469936)`.

   > [!NOTE]
   > Tokens scoped to the `AAD Token Exchange Endpoint: Public` can't call Microsoft Graph. Agentic flows are protected because Conditional Access protects token acquisition from agent identity or agent user.

- The Conditional Access policy is scoped to users or workload identities, **not** to agents.
- [Security defaults](../../fundamentals/security-defaults.md) are enabled.

| Authentication flow | Does Conditional Access apply | Details |
| --- | :---: | --- |
| Agent identity → Resource | ✅<br>Yes | Governed by agent identity policies. |
| Agent user → Resource | ✅<br>Yes | Governed by agent user policies. |
| Agent identity blueprint → Graph (create agent identity (Agent ID)/agent user) | ❌<br>No | Not governed by Conditional Access because this flow involves creation of agent identities and agent users by the blueprint. |
| Agent identity blueprint or Agent identity (Agent ID) → Token Exchange | ❌<br>No | Not governed by Conditional Access because this flow involves the blueprint or agent identity making an intermediate token exchange call that enables it to perform agentic tasks. This flow does not involve any resource access. |

## Policy configuration

Creating a Conditional Access policy for agents involves these four key components: 

:::image type="content" source="media/agent-id/conditional-access-agent-settings.png" alt-text="Screenshot of Conditional Access interface showing a policy configured to block all high-risk agent identities, with assignments scoped to all agent identities." lightbox="media/agent-id/conditional-access-agent-settings.png":::

1. Assignments
   1. Scope policies to: 
      1. All agent identities in the tenant.
      1. Specific agent identities based on their object ID.
      1. Agent identities based on custom security attributes preassigned to them.
      1. Agent identities grouped by their blueprint.
      1. All agent users in the tenant.
1. Target resources
   1. Resource targeting options include: 
      1. All resources.
      1. All agent resources (agent blueprints and agent identities).
      1. Specific resources grouped by custom security attributes preassigned to them.
      1. Specific resources based on their appId.
      1. Agent blueprints (targeting the blueprint covers the agent identities parented by the blueprint).
1. Conditions
   1. Agent risk (high, medium, low).
1. Access controls
   1. Block.
1. Policies can be toggled On, Off, or set to Report-only for simulation.

## Common business scenarios

There are two key business scenarios where Conditional Access policies can help you manage agents effectively.

In the first scenario, you may want to ensure that only approved agents can access specific resources. You can do this by tagging agents and resources with custom security attributes targeted in your policy, or by manually selecting them using the enhanced object picker.

In the second scenario, Conditional Access uses [signals from Microsoft Entra ID Protection](/entra/id-protection/concept-risky-agents) to detect and block agents exhibiting risky behavior from accessing resources.

### Scenario 1: Allow only specific agents to access resources

#### [Using custom security attributes](#tab/custom-security-attributes)

###### Create Conditional Access policy using custom security attributes

The recommended approach for the first scenario is to create and assign custom security attributes to each agent or agent blueprint, then target those attributes with a Conditional Access policy. This approach uses steps similar to those documented in [Filter for applications in Conditional Access policy](concept-filter-for-applications.md). You can assign attributes across multiple attribute sets to an agent or cloud application.

###### Create and assign custom attributes

1. Create the custom security attributes:
   1. Create an **Attribute set** named *AgentAttributes*.
   1. Create **New attributes** named *AgentApprovalStatus* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**. 
      1. Add the following predefined values: **New**, **In_Review**, **HR_Approved**, **Finance_Approved**, **IT_Approved**.
1. Create another attribute set to group resources that your agents are allowed to access.
   1. Create an **Attribute set** named *ResourceAttributes*.
   1. Create **New attributes** named *Department* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**.
      1. Add the following predefined values: **Finance**, **HR**, **IT**, **Marketing**, **Sales**.
1. Assign the appropriate value to resources that your agent is allowed to access. For example, you may want only agents that are **HR_Approved** to be able to access resources that are tagged **HR**.

###### Create Conditional Access policy

After you complete the previous steps, create a Conditional Access policy using custom security attributes to block all agent identities except those reviewed and approved by your organization. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Attribute Assignment Reader](../role-based-access-control/permissions-reference.md#attribute-assignment-reader).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Under **What does this policy apply to?**, select **Agents (Preview)**.
      1. Under **Include**, select **All agent identities (Preview)**.
      1. Under **Exclude**: 
         1. Select **Select agent identities based on attributes**.
         1. Set **Configure** to **Yes**. 
         1. Select the Attribute we created earlier called **AgentApprovalStatus**.
         1. Set **Operator** to **Contains**.
         1. Set **Value** to **HR_Approved**.
         1. Select **Done**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
      1. Include **All resources (formerly 'All cloud apps')**
      1. Exclude **Select resources**.
         1. Select **Select resources based on attributes**.
         1. Set **Configure** to **Yes**.
         1. Select the Attribute we created earlier called **Department**.
         1. Set **Operator** to **Contains**.
         1. Set **Value** to **HR**.
1. Under **Access controls** > **Grant**: 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

#### [Using the enhanced object picker](#tab/enhanced-object-picker)

###### Create Conditional Access policy using the enhanced object picker

Alternatively, organizations can create a Conditional Access policy using the enhanced object picker to block all agent identities except those reviewed and approved by your organization. 

The enhanced object picker replaces the previous flat list experience in both the assignment and target resources sections of policy configuration. The new experience is meant to simplify the selection of items you want to scope in the policy.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
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
            :::image type="content" source="media/agent-id/enhanced-object-picker.png" alt-text="Screenshot of the enhanced object picker with tabs for All, Enterprise applications, and Agent blueprints, showing resource selection options." lightbox="media/agent-id/enhanced-object-picker.png":::
         1. Select **Select**.
1. Under **Access controls** > **Grant**: 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

---

### Scenario 2: Block high-risk agent identities from accessing my organization’s resources

Organizations can create a Conditional Access policy to block high-risk agent identities based on [signals from Microsoft Entra ID Protection](/entra/id-protection/concept-risky-agents).

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

- Agent identities (actor) accessing any resources → Service principal sign-in logs → agent type: agent ID user
- Agent users accessing any resources → Non-interactive user sign-ins → agentType: agent user
- Users accessing agents → User sign-ins

## Related content

- [Conditional Access template policies](concept-conditional-access-policy-common.md)
- [Conditional Access: Users, groups, agents, and workload identities](concept-conditional-access-users-groups.md)
- [Conditional Access: Target resources](concept-conditional-access-cloud-apps.md)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
- [Conditional Access: Grant](concept-conditional-access-grant.md)
- [Security for AI with Microsoft Entra agent identity](../../agent-id/identity-professional/security-for-ai.md)
- [Microsoft Entra ID Protection and agents](/entra/id-protection/concept-risky-agents)

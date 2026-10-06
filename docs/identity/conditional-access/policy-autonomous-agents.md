---
title: Secure autonomous agents with Conditional Access
description: Learn how to configure Microsoft Entra Conditional Access policies for autonomous agents that access resources with their own agent identities.
author: gracenagy
ms.author: gracenagy
ms.service: entra-id
ms.topic: how-to
ms.date: 07/31/2026
ms.reviewer: kvenkit
ms.custom: msecd-doc-authoring-1017
ai-usage: ai-assisted
---

# Secure autonomous agents with Conditional Access

Use Conditional Access to control access for autonomous agents that authenticate with their own agent identity and no signed-in user. This access pattern includes agents that run in the background, respond to events, run on a schedule, or are published for public use without delegated user context.

In this access pattern, the access token's subject is the agent identity. Conditional Access policies therefore target the agent identity, not a user or an agent's user account.

Before you start, review the licensing, role, and agent setup requirements.

## Prerequisites

- One of the following license plans:
	- Microsoft 365 E7, which includes Agent 365 and Microsoft Entra Suite, to provide governance of user and agent identities.
	- Microsoft Agent 365 license paired with at least Microsoft Entra P1 or Microsoft 365 E3.
- At least the [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role.
- At least one agent identity registered in your tenant.
- The agent uses the [autonomous app OAuth flow](../../agent-id/agent-autonomous-app-oauth-flow.md).

> [!IMPORTANT]
> Before configuring a Conditional Access policy, read the [Conditional Access for agents](agent-id.md) article. It covers the authentication, service boundaries, and limitations to ensure you cover all scenarios and your corporate data and services are well protected.


## Allow only specific agents to access resources

Create a block policy that excludes approved agent identities or agent identity blueprints. Start in report-only mode so you can review the policy's effect before you enforce it. You can do this by tagging agents and resources with [custom security attributes](/entra/fundamentals/custom-security-attributes-overview) targeted in your policy, or by manually selecting them using the enhanced object picker.
### [Use the enhanced object picker](#tab/use-the-enhanced-object-picker)

### Create Conditional Access policy using the enhanced object picker

Organizations can create a Conditional Access policy using the enhanced object picker to block all agents except those reviewed and approved by your organization. 

The enhanced object picker replaces the previous flat list experience in both the assignment and target resources sections of policy configuration. The new experience is meant to simplify the selection of items you want to scope in the policy.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Users, agents or workload identities**.
    1. Under **What does this policy apply to?**, select **Agents**.
        1. Under **Include**, select **All agent identities**.
        1. Under **Exclude**:
            1. Select **Select individual agent identities**.
            1. Using the enhanced object picker, switch between the **All**, **Agent blueprint principals**, and **Agent identities** tabs to select the individual agent blueprints, agent identities, or both that you want to exclude.
            1. Select **Select**.
1. Under **Target resources**:
    1. Under **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**:
    1. Select **Block**.
    1. Select **Select**.
1. Confirm your settings, and set **Enable policy** to **Report-only**.
1. Select **Create** to create your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

For more information about assignment options and the object picker, see [Target agent identities in Conditional Access policies](howto-target-agent-identities.md).

<a name='use-custom-security-attributes'></a>

### [Use custom security attributes](#tab/use-custom-security-attributes)

### Create Conditional Access policy using custom security attributes

The recommended approach for creating this policy is to create and assign custom security attributes to each agent or agent blueprint, then target those attributes with a Conditional Access policy. This approach uses steps similar to those documented in [Filter for applications in Conditional Access policy](concept-filter-for-applications.md). You can assign attributes across multiple attribute sets to an agent or cloud application.

#### Create and assign custom attributes

1. Create the custom security attributes:
    1. Create an **Attribute set** named *AgentAttributes*.
    1. Create a **New attribute** named *AgentApprovalStatus* that has **Allow multiple values to be assigned** and **Only allow predefined values to be assigned** selected.
        1. Add the following predefined values: **New**, **In_Review**, **HR_Approved**, **Finance_Approved**, and **IT_Approved**.
1. Create another attribute set to group resources that your agents are allowed to access:
    1. Create an **Attribute set** named *ResourceAttributes*.
    1. Create a **New attribute** named *Department* that has **Allow multiple values to be assigned** and **Only allow predefined values to be assigned** selected.
        1. Add the following predefined values: **Finance**, **HR**, **IT**, **Marketing**, and **Sales**.
1. Assign the appropriate value to resources that your agent is allowed to access. For example, you might want only agents that are **HR_Approved** to access resources tagged **HR**.

#### Create Conditional Access policy

After you complete the previous steps, create a Conditional Access policy using custom security attributes to block all agents except those reviewed and approved by your organization. 

After you complete the previous steps, create a Conditional Access policy using custom security attributes to block all agents except those reviewed and approved by your organization.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Users, agents or workload identities**.
    1. Under **What does this policy apply to?**, select **Agents**.
        1. Under **Include**, select **All agent identities**.
        1. Under **Exclude**:
            1. Select **Select agent identities based on attributes**.
            1. Set **Configure** to **Yes**.
            1. Select the attribute you created earlier, **AgentApprovalStatus**.
            1. Set **Operator** to **Contains**.
            1. Set **Value** to **HR_Approved**.
            1. Select **Done**.
1. Under **Target resources**:
    1. Under **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**:
    1. Select **Block**.
    1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

---
<a name='block-high-risk-agents-from-accessing-organizational-resources'></a>

## Block high-risk agent identities

Create a policy that blocks high-risk agent identities, based on [signals from Microsoft Entra ID Protection](/entra/id-protection/concept-risky-agents), from organizational resources. For details on risk detection types and response actions for agents, see [Identity Protection for agents](/entra/id-protection/concept-risky-agents). Agent risk is in Preview.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
2. Browse to **Entra ID** > **Conditional Access** > **Policies**.
3. Select **New policy**.
4. Enter a name for the policy.
5. Under **Assignments**, select **Users, agents or workload identities**.
	1. Under **What does this policy apply to?**, select **Agents**.
		1. Under **Include**, select **All agent identities**.
6. Under **Target resources** > **Include**, select **All resources (formerly 'All cloud apps')**.
7. Under **Conditions** > **Agent risk (Preview)**, set **Configure** to **Yes**.
	1. Under **Configure agent risk levels needed for policy to be enforced**, select **High**. This guidance is based on Microsoft recommendations and might be different for each organization.
8. Under **Access controls** > **Grant**, select **Block**, and then select **Select**.
9. Set **Enable policy** to **Report-only**.
10. Select **Create**.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

For details about agent risk detections, see [Microsoft Entra ID Protection and agents](../../id-protection/concept-risky-agents.md).

<a name='policies-for-autonomous-agents-user-accounts'></a>

## Policies for agent user accounts

To create policies for an agent that access resources through its own user account, find agent-user policy guidance in [Secure agents that act as users with Microsoft Entra Conditional Access](policy-agent-user.md). The article includes the following policies:

- <a name='block-risky-agents-user-accounts'></a>[Block risky agent user accounts](policy-agent-user.md#block-risky-agent-user-accounts)
- <a name='require-a-compliant-device-for-agents-user-accounts'></a>[Require a compliant device](policy-agent-user.md#require-a-compliant-device)
- <a name='require-a-compliant-network-for-agents-user-accounts'></a>[Require a compliant network](policy-agent-user.md#require-a-compliant-network)

## Related content

- [Conditional Access for agents](agent-id.md)
- [Target agent identities in Conditional Access policies](howto-target-agent-identities.md)
- [Secure agents that act as users with Microsoft Entra Conditional Access](policy-agent-user.md)

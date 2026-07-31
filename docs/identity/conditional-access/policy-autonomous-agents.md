---
title: Secure autonomous agents with Microsoft Entra Conditional Access
description: Learn how to configure Microsoft Entra Conditional Access policies for autonomous agents that access resources with their own agent identities.
author: gracenagy
ms.author: gracenagy
ms.service: entra-id
ms.topic: how-to
ms.date: 07/31/2026
ms.reviewer: kvenkit
ms.custom: msecd-doc-authoring-1017
ai-usage: ai-assisted

#customer intent: As an identity administrator, I want to control which autonomous agents can access resources so that only approved agents can reach organizational data and services.
---

# Secure autonomous agents with Microsoft Entra Conditional Access

Use Conditional Access to control access for autonomous agents that authenticate with their own agent identity and no signed-in user. This access pattern includes agents that run in the background, respond to events, run on a schedule, or are published for public use without delegated user context.

In this access pattern, the access token's subject is the agent identity. Conditional Access policies therefore target the agent identity, not a user or an agent's user account.

Before you start, review the licensing, role, and agent setup requirements.

## Prerequisites

- A Microsoft Entra ID P1 or P2 license.
- At least the [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role.
- At least one agent identity registered in your tenant.
- The agent uses the [autonomous app OAuth flow](../../agent-id/agent-autonomous-app-oauth-flow.md).

> [!IMPORTANT]
> Review [Conditional Access for agents](agent-id.md) before you create a policy. A policy that targets an agent identity doesn't apply to an agent's user account.

<a name='allow-only-specific-agents-to-access-resources'></a>

## Allow only approved agent identities

Create a block policy that excludes approved agent identities or agent identity blueprints. Start in report-only mode so you can review the policy's effect before you enforce it.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Conditional Access Administrator.
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Enter a name for the policy.
1. Under **Assignments**, select **Users, agents or workload identities**.
1. Under **What does this policy apply to?**, select **Agents**.
1. Under **Include**, select **All agent identities**.
1. Under **Exclude**, select **Select individual agent identities**.
1. In the object picker, use the **All**, **Agent blueprint principals**, and **Agent identities** tabs to select the approved agent identities or blueprints.
1. Select **Select**.
1. Under **Target resources** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**, select **Block**, and then select **Select**.
1. Set **Enable policy** to **Report-only**.
1. Select **Create**.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

For more information about assignment options and the object picker, see [Target agent identities in Conditional Access policies](howto-target-agent-identities.md).

## Allow approved agents by using custom security attributes

Use custom security attributes when you need to manage approved agents and resources at scale. The following example blocks agents from resources unless the agent has the `HR_Approved` value.

### Create and assign custom security attributes

Create attributes for agent approval status and resource departments, and then assign the appropriate values.

1. Create an attribute set named *AgentAttributes*.
1. Create an attribute named *AgentApprovalStatus*.
1. Configure the attribute to allow multiple values and only predefined values.
1. Add the predefined values **New**, **In_Review**, **HR_Approved**, **Finance_Approved**, and **IT_Approved**.
1. Create an attribute set named *ResourceAttributes*.
1. Create an attribute named *Department*.
1. Configure the attribute to allow multiple values and only predefined values.
1. Add the predefined values **Finance**, **HR**, **IT**, **Marketing**, and **Sales**.
1. Assign the appropriate value to each agent or agent blueprint and resource.

For more information about custom security attributes, see [Custom security attributes in Microsoft Entra ID](../../fundamentals/custom-security-attributes-overview.md).

### Create the Conditional Access policy

Create a block policy that excludes agents with the approved custom security attribute value.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Attribute Assignment Reader](../role-based-access-control/permissions-reference.md#attribute-assignment-reader).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Enter a name for the policy.
1. Under **Assignments**, select **Users, agents or workload identities**.
1. Under **What does this policy apply to?**, select **Agents**.
1. Under **Include**, select **All agent identities**.
1. Under **Exclude**, select **Select agent identities based on attributes**.
1. Set **Configure** to **Yes**.
1. Select the **AgentApprovalStatus** attribute.
1. Set **Operator** to **Contains**.
1. Set **Value** to **HR_Approved**, and then select **Done**.
1. Under **Target resources** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**, select **Block**, and then select **Select**.
1. Set **Enable policy** to **Report-only**.
1. Select **Create**.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

<a name='block-high-risk-agents-from-accessing-organizational-resources'></a>

## Block high-risk agent identities

Create a policy that blocks high-risk agent identities from organizational resources. Agent risk is in Preview.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Conditional Access Administrator.
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Enter a name for the policy.
1. Under **Assignments**, select **Users, agents or workload identities**.
1. Under **What does this policy apply to?**, select **Agents**.
1. Under **Include**, select **All agent identities**.
1. Under **Target resources** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Agent risk (Preview)**, set **Configure** to **Yes**.
1. Select **High**.
1. Under **Access controls** > **Grant**, select **Block**, and then select **Select**.
1. Set **Enable policy** to **Report-only**.
1. Select **Create**.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

For details about agent risk detections, see [Microsoft Entra ID Protection and agents](../../id-protection/concept-risky-agents.md).

<a name='policies-for-autonomous-agents-user-accounts'></a>

## Policies for agent user accounts

Agent-user policy guidance moved to [Secure agents that act as users with Microsoft Entra Conditional Access](policy-agent-user.md). The article includes the following policies:

- <a name='block-risky-agents-user-accounts'></a>[Block risky agent user accounts](policy-agent-user.md#block-risky-agent-user-accounts)
- <a name='require-a-compliant-device-for-agents-user-accounts'></a>[Require a compliant device](policy-agent-user.md#require-a-compliant-device)
- <a name='require-a-compliant-network-for-agents-user-accounts'></a>[Require a compliant network](policy-agent-user.md#require-a-compliant-network)

## Related content

- [Conditional Access for agents](agent-id.md)
- [Target agent identities in Conditional Access policies](howto-target-agent-identities.md)
- [Secure agents that act as users with Microsoft Entra Conditional Access](policy-agent-user.md)

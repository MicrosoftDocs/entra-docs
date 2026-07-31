---
title: Secure agent users with Microsoft Entra Conditional Access
description: Learn how to configure Microsoft Entra Conditional Access policies for agents that access resources through their own agent user accounts.
author: gracenagy
ms.author: gracenagy
ms.service: entra-id
ms.topic: how-to
ms.date: 07/31/2026
ms.reviewer: kvenkit
ms.custom: msecd-doc-authoring-1017
ai-usage: ai-generated

#customer intent: As an identity administrator, I want to protect agents that act as users so that their access follows agent-specific risk, device, and network policies.
---

# Secure agents that act as users with Microsoft Entra Conditional Access

Use Conditional Access to protect an agent that accesses resources through its own agent user account. This access pattern supports agents that need a mailbox, access to chat, or the ability to participate in collaborative workflows as a team member.

In this access pattern, the access token's subject is the agent's user account. Conditional Access policies therefore target the agent's user account, not its agent identity.

Before you start, review the licensing, role, agent-user, device, and network requirements.

## Prerequisites

- A Microsoft Entra ID P1 or P2 license.
- At least the [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) role.
- An [agent user account](../../agent-id/agent-users.md) linked to an agent identity.
- For device compliance, an agent that runs on an Intune-managed Windows 365 Cloud PC for Agents.
- For compliant network policies, a Global Secure Access client installed on the endpoint.

> [!IMPORTANT]
> Agent user targeting is in Preview. Policies that target all users don't include agent user accounts. Group-based inclusion and exclusion also aren't supported for agent user accounts. Target all agent users, select individual agent users, or use custom security attributes.

A policy that targets an agent identity doesn't apply to the agent's user account. If the agent also uses its own agent identity, create a separate policy for that access pattern. For more information, see [Secure autonomous agents with Conditional Access](policy-autonomous-agents.md).

## Block risky agent user accounts

Create a policy that blocks agent user accounts when Microsoft Entra ID Protection detects medium or high agent risk. Agent risk is in Preview.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Conditional Access Administrator.
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Enter a name for the policy.
1. Under **Assignments**, select **Users, agents or workload identities**.
1. Under **What does this policy apply to?**, select **Agents**.
1. Under **Include**, select **All agent users (Preview)**.
1. Under **Target resources** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Agent risk (Preview)**, set **Configure** to **Yes**.
1. Select **Medium** and **High**.
1. Under **Access controls** > **Grant**, select **Block**, and then select **Select**.
1. Set **Enable policy** to **Report-only**.
1. Select **Create**.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Require a compliant device

Use this policy for an agent that runs on a managed endpoint, such as a Windows 365 Cloud PC for Agents. The **Agent execution environments (Preview)** condition limits the policy to agent user sessions that start from endpoints. Agents that don't run on a device are excluded from evaluation.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Conditional Access Administrator.
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Enter a name for the policy.
1. Under **Assignments**, select **Users, agents or workload identities**.
1. Under **What does this policy apply to?**, select **Agents**.
1. Under **Include**, select **All agent users (Preview)**.
1. Under **Target resources** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Agent execution environments (Preview)**, set **Configure** to **Yes**.
1. Under **Include**, select **Agent user sessions initiated from endpoints**.
1. Under **Access controls** > **Grant**, select **Grant access**.
1. Select **Require device to be marked as compliant**, and then select **Select**.
1. Set **Enable policy** to **Report-only**.
1. Select **Create**.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

> [!NOTE]
> Device compliance requires Intune enrollment. The current published guidance supports this check on Windows 365 Cloud PCs for Agents.

## Require a compliant network

Use this policy for an agent that runs on an endpoint with the Global Secure Access client. The client provides the network location signal that Conditional Access evaluates.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Conditional Access Administrator.
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Enter a name for the policy.
1. Under **Assignments**, select **Users, agents or workload identities**.
1. Under **What does this policy apply to?**, select **Agents**.
1. Under **Include**, select **All agent users (Preview)**.
1. Under **Target resources** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Agent execution environments (Preview)**, set **Configure** to **Yes**.
1. Under **Include**, select **Agent user sessions initiated from endpoints**.
1. Under **Access controls** > **Grant**, select **Grant access**.
1. Select **Require compliant network**, and then select **Select**.
1. Set **Enable policy** to **Report-only**.
1. Select **Create**.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related content

- [Conditional Access for agents](agent-id.md)
- [Target agent identities in Conditional Access policies](howto-target-agent-identities.md)
- [Secure autonomous agents with Microsoft Entra Conditional Access](policy-autonomous-agents.md)

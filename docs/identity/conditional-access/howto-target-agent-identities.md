---
title: Target agent identities in Conditional Access policies
description: Learn how to select and target agent identities in Microsoft Entra Conditional Access policies using the object picker, blueprints, and custom security attributes.
ms.topic: how-to
ms.date: 06/02/2026
ms.reviewer: kvenkit
ms.custom: msecd-doc-authoring-1012
ai-usage: ai-assisted
#customer-intent: As an identity administrator, I want to target agent identities in Conditional Access policies so that I can enforce access controls on AI agents operating in my organization.
---

# Target agent identities in Conditional Access policies

Conditional Access policies for agent identities let you control how AI agents access corporate resources. As your organization deploys more agents, you need policies that target the right agents, evaluate the right signals, and enforce the right controls.

This article walks through each section of the Conditional Access policy builder for agents:

- Selecting which agents the policy applies to
- Choosing target resources
- Configuring conditions
- Setting access controls.

Each section builds on the previous one to form a complete policy.

## Prerequisites

- A Microsoft Entra ID P1 or P2 license
- An Agent 365 license for each user
- [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) to create and manage Conditional Access policies
- At least one agent identity registered in your tenant

## Create a Conditional Access policy for agent identities

Policies that target agent identities introduce unique assignment options, conditions, and control limitations that differ from user-targeted policies. Templates for specific scenarios are also available. We recommend reviewing this article first to understand the best practices and considerations for agent-specific policies.

- [Block high-risk agent identities](policy-agent-block-high-risk.md)
- [Configure policy for autonomous agent access](policy-autonomous-agents.md)
- [Configure policy for on-behalf-of agent access](policy-on-behalf-of-agents.md)

To create a new Conditional Access policy for agent identities:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies. 

## Assignments

The first agent-specific configuration is selecting which agents the policy applies to.

1. Under **Assignments**, select **Users, agents (Preview) or workload identities**.
1. Under **What does this policy apply to**, select **Agents**.
    :::image type="content" source="media/howto-target-agent-identities/agent-policy-select-agents.png" alt-text="Screenshot of the Conditional Access policy builder showing the agent selection options." lightbox="media/howto-target-agent-identities/agent-policy-select-agents.png":::
1. Select the agent identity option for your scenario:
    - **All agent identities**: Applies the policy to every agent identity in your tenant.
    - **All agent users (Preview)**: Applies the policy to every agent's user account in your tenant.
    - **Select agent identities**: Choose individual agents or select agents based on custom security attributes.
    - **Select agent users (Preview)**: Choose individual agents' user accounts or select agents' user accounts based on custom security attributes.

### Considerations for selecting agent assignments

Keep in mind the following important details when selecting agent assignments:

- The **agent users** option targets agents' user accounts. This option is currently in Preview.
- Agent-based policies apply when agents access resources using their own identity, not on behalf of a user.
- Targeting a blueprint automatically covers all agent identities derived from it, including ones added in the future. For more information about targeting agent identity blueprints, see [Conditional Access for agent identities: Agent identity blueprints](agent-id.md#agent-identity-blueprints).

## Target resources

Target resources define which resources the policy protects when agents attempt to access them.

1. Under **Target resources**, select the resources you want to protect.
1. Under **Include**, select one of the following:
    - **All agent resources**: Applies the policy when agents access any agent-specific resource.
    - **All resources (formerly 'All cloud apps')**: Applies the policy when agents access any resource protected by Microsoft Entra ID.
    - **Select resources**: Choose specific resources the agent needs to access.

## Network

The network settings control agent access based on where they run, such as cloud-hosted virtual machines or endpoints with a Global Secure Access client. This option is only available when the policy targets **All agent users (Preview)**.

1. Under **Network**, set **Configure** to **Yes** to enable the network location options.
1. Under **Include**, select one of the following:
    - **Any location**: The policy applies regardless of where the agent runs.
    - **All Compliant Network locations**: The policy applies only to agents connecting from compliant network locations.
    :::image type="content" source="media/howto-target-agent-identities/agent-policy-agent-users-network.png" alt-text="Screenshot of the Conditional Access policy builder showing the network options for agent users." lightbox="media/howto-target-agent-identities/agent-policy-agent-users-network.png":::

## Conditions

Conditions are the signals that Conditional Access evaluates when deciding whether to apply a policy. The available conditions depend on whether the policy targets agent identities, agents' user accounts, or users in OBO flows.

### Conditions for agent identities

When an agent identity is targeted in a policy (either all agent identities or individually selected agent identities), the only condition available is **Agent risk (Preview)**. For more information, see [ID Protection for agents](../../id-protection/concept-risky-agents.md).

1. Under **Conditions** set **Configure** to **Yes**
1. Select the agent risk levels (high, medium, low) needed for the policy to be enforced.

### Conditions for agents' user accounts

When you target agents' user accounts in Conditional Access, the following conditions are available. These conditions don't apply to agent identities or agent identity blueprints. For the full condition reference, see [Conditional Access: Conditions](concept-conditional-access-conditions.md).

- **Agent risk (Preview)**: Evaluate whether the agent is likely compromised and enforce risk-based access decisions.
- **Agent execution environments (Preview)**: Scope policies to agent's user account sessions initiated from endpoints.
- **Device platforms**: Restrict agents to specific operating systems. Only applies to agents running on endpoints.
- **Filter for devices**: Restrict agents to specific admin-approved devices. Only applies to agents running on endpoints.
- **Network**: Enforce compliant network locations. Only applies to agents on endpoints with a Global Secure Access client.

Keep in mind the following important details when selecting conditions for agents' user accounts:

- The 'Device platforms' and 'Filter for devices' conditions require device information and only apply to agents running on endpoints, including local devices and cloud-hosted virtual machines.
- Because the 'agent user' options are in preview, these conditions should also be considered as preview capabilities.
- The 'Network' condition is only available for agents running on endpoints with a Global Secure Access client.

#### Agent execution environments

Configure restrictions based on where the agent user is executed.

1. Under **Conditions**, set **Configure** to **Yes** to enable the agent execution environments.
1. Under **Include** select the execution environments that apply to your agents:
    - **All agent user sessions**
    - **Agent user sessions initiated from endpoints**
    :::image type="content" source="media/howto-target-agent-identities/agent-policy-agent-execution-environment.png" alt-text="Screenshot of the Conditional Access policy builder showing the agent execution environments options." lightbox="media/howto-target-agent-identities/agent-policy-agent-execution-environment-expanded.png":::

#### Device platforms

Apply the policy to selected device platforms.

1. Under **Device platforms**, set **Configure** to **Yes** to enable device platform selection.
1. Under **Include** select the device platforms that apply to your agents:
    - **Any device**
    - **Select device platforms**: Android, iOS, Windows Phone, Windows, macOS, Linux

#### Filter for devices

Configure a filter to apply the policy to specific devices.

1. Under **Filter for devices**, set **Configure** to **Yes** to enable device filtering.
1. Select whether to **Include filtered devices in policy** or **Exclude filtered devices from policy**.
1. Use the rule builder or rule syntax text box to create or edit the filter rule.

## Access controls

Access controls determine what happens when conditions are met.

### Controls for agent identities

- **Block access**: The only available option for agent identities, because there's no interactive remediation possible.

### Controls for agent users

- **Block access**: Deny the agent user account access to resources.
- **Grant access** with:
  - **Require device to be marked as compliant**: Requires agents to run on Intune-managed compliant devices, such as Windows 365 Cloud PCs for Agents.
    :::image type="content" source="media/howto-target-agent-identities/agent-policy-grant-device-compliant.png" alt-text="Screenshot of the Conditional Access policy builder showing the grant option for device compliance." lightbox="media/howto-target-agent-identities/agent-policy-grant-device-compliant.png":::

> [!IMPORTANT]
> Agents running directly in cloud infrastructure may not provide device compliance signals. To avoid unintended blocking, apply device compliance policies only to agents running on endpoints using the **Agent execution environments** condition.

## Related content

- [Conditional Access for agent identities](agent-id.md)
- [Block high-risk agent identities](policy-agent-block-high-risk.md)
- [Configure policy for autonomous agent access](policy-autonomous-agents.md)
- [Configure policy for on-behalf-of agent access](policy-on-behalf-of-agents.md)
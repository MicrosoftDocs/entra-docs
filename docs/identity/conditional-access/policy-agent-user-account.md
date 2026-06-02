---
title: Conditional Access for agent's user account
description: Learn how to configure Conditional Access for agents' user accounts in Microsoft Entra ID to extend Zero Trust principles to AI agents, ensuring secure access and governance.
ms.topic: how-to
ms.date: 06/01/2026
ai-usage: ai-assisted
ms.reviewer: kvenkit
ms.custom: msecd-doc-authoring-1012
---
# Block access for high-risk agent's user account

An [agent's user account](../../agent-id/agent-users.md) is a specialized identity type provided by [Microsoft Entra Agent ID](../../agent-id/what-is-microsoft-entra-agent-id.md). This identity type is designed to bridge the gap between agents and human user capabilities. The agent's user account enables AI-powered applications to interact with systems and services that require user identities, while maintaining appropriate security boundaries and management controls. It allows organizations to manage the agent's access using similar capabilities as they do for human users.

In contrast to the [on-behalf-of flow](agent-id.md), where an agent operates within the delegated context of a signed-in user, an agent's user account is actually a user, functioning as a digital worker. For example, digital employees that function as team members with their own mailboxes, chat access and participate in collaborative workflows as a team member.

In this model, an admin creates a user account in the directory and links it to the agent's identity. From there, it’s like any other user account. Licenses can be assigned to access Microsoft 365 resources such as mailbox and calendars, and the account can be added to administrative units and security groups just like a human user account.

Conditional Access works differently in this model. The access token is issued to the user (the token subject), but the policy is evaluated against the user (agent's user account). Today, you can target this with a single scope: "all agents acting as a user."

> [!IMPORTANT]
> Before configuring a Conditional Access policy, read the [Conditional Access for agent identities](agent-id.md) article. It covers the authentication flow, service boundaries, and limitations to ensure you cover all scenarios and your corporate data and services are well protected.

## Create a Conditional Access policy

Follow these steps to configure a Conditional Access policy that applies to all agents' user accounts, blocking access to any resource when their identity is at risk.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Users, agents or workload identities**.
	1. Under **What does this policy apply to?**, select **Agents**.
		1. Under **Include**, select **Select agents acting as users**.
		1. Select **All agents' user accounts**.
1. Under **Target resources**, select the following options:
	1. Select what this policy applies to **Resources (formerly cloud apps)**.
	1. Include, **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Agent risk (Preview)**, set **Configure** to **Yes**.
	1. Under **Configure agent risk levels needed for policy to be enforced**, select the risk levels needed for your organization.
1. Under **Access controls** > **Grant**.
	1. Select **Block**.
	1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]


## Investigating policy evaluation using sign-in logs

Admins can use the Sign-in logs to investigate why a Conditional Access policy did or didn't apply as explained in [Microsoft Entra sign-in events](troubleshoot-conditional-access.md#microsoft-entra-sign-in-events). These events appear in the **User sign-ins (non-interactive)**.

## Related content

- [Manage agent identities in your organization](/entra/agent-id/manage-agent-identities-organization) - Overview of agent identity management across the full lifecycle.
- [Conditional Access for agent identities](agent-id.md)
- [Conditional Access template policies](concept-conditional-access-policy-common.md)
- [Conditional Access: Users, groups, agents, and workload identities](concept-conditional-access-users-groups.md)
- [Conditional Access: Target resources](concept-conditional-access-cloud-apps.md)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
- [Conditional Access: Grant](concept-conditional-access-grant.md)
- [Security for AI with Microsoft Entra agent identity](../../agent-id/security-for-ai-overview.md)
- [Microsoft Entra ID Protection and agents](/entra/id-protection/concept-risky-agents)
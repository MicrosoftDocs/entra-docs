---
title: Conditional Access for agent user in Microsoft Entra
description: Learn how to configure Conditional Access for agent users in Microsoft Entra ID to extend Zero Trust principles to AI agents, ensuring secure access and governance.
ms.topic: how-to
ms.date: 03/24/2026
ms.custom: agent-id-ignite
ms.reviewer: kvenkit
---
# Conditional Access for agent user in Microsoft Entra

For a high-level guide to managing agent identities across your organization, see [Manage agent identities in your organization](/entra/agent-id/manage-agent-identities-organization). For information and best practices on Conditional Access for agent identities, see [Conditional Access for agent identities](agent-id.md).

## Overview

The [agent user](/entra/agent-id/agent-users) is a specialized identity typedesigned to bridge the gap between agents and human user capabilities. The agent user enables AI-powered applications to interact with systems and services that require user identities, while maintaining appropriate security boundaries and management controls. It allows organizations to manage the agent's access using similar capabilities as they do for human users.

In contrast to the [on-behalf-of flow](agent-id.md), where an agent operates within the delegated context of a signed-in user, an agent user is actually a user, functioning as a digital worker. For example, digital employees that function as team members with their own mailboxes, chat access and participate in collaborative workflows as a team member.

In this model, an admin creates a user account in the directory and links it to the agent's identity. From there, it’s like any other user account. Licenses can be assigned to access Microsoft 365 resources such as mailbox and calendars, and the account can be added to administrative units and security groups just like a human user account.
Conditional Access works differently in this model. The access token is issued to the user (the token subject), but the policy is evaluated against the user (agent's user account). Today, you can target this with a single scope: “all agents acting as a user”

> [!IMPORTANT]
> Before configuring a Conditional Access policy, read the [Conditional Access for agent identities](agent-id.md) article. It covers the authentication flow, service boundaries and limitations. To  ensure you cover all scenarios and your corporate data and services are well protected.

## Prerequisites

- Admins who interact with Conditional Access need one of the following role assignments, depending on the tasks they're performing.
   - [Security Reader](~/identity/role-based-access-control/permissions-reference.md#security-reader) to read Conditional Access policies and configurations.
   - [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) to create or modify Conditional Access policies.
- Microsoft Entra ID P1 license

## Create a Conditional Access policy

Follow these steps to configure a Conditional Access policy that applies to all agent user accounts, blocking access to any resource when their identity is at risk.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Agents**.
1. Choose **Select agents active as users**, and then select **All agent users**. 
1. Under **Target resources**, select **all resources**
1. Under **Conditions**, select the **Agent risk** needed for the policy to be enforced. 
1. Under **Access controls** > **Grant**, select **block access**.
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
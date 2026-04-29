---
title: Conditional Access for autonomous agents in Microsoft Entra
description: Learn how to configure Conditional Access for autonomous agents in Microsoft Entra ID to extend Zero Trust principles to AI agents, ensuring secure access and governance.
ms.topic: how-to
ms.date: 03/24/2026
ms.custom: agent-id-ignite
ms.reviewer: kvenkit
---
# Conditional Access for autonomous agents access

For a high-level guide to managing agent identities across your organization, see [Manage agent identities in your organization](/entra/agent-id/manage-agent-identities-organization). For information and best practices on Conditional Access for agent identities, see [Conditional Access for agent identities](agent-id.md).

## Overview

This walkthrough explains how to configure Conditional Access for agents that authenticate with their own identity, with no signed-in user. The access pattern is known **client credentials flow**. Instead of acting on behalf of a user, the agent authenticates with its own credentials - a client ID paired with a certificate or managed identity managed by the agent identity blueprint. This access pattern applies in the following common scenarios:

- Autonomous agents that operate independently. Those agents run in the background, responding to events, or run on a schedule. A typical example is an agent that generates a daily report and sends the result to a group of employees. In this scenario, there is no user present, and the agent operates on its own. 
- Agents don't always act on a user's behalf when accessing resources. Sometimes they operate entirely on their own. For example, a backend SMS service that is not accessible to users. In this scenario, the OBO flow is not applicable and agent accesses the target resource by authenticating directly with its own identity. 
- Agents published on the web for public use. These agents either don’t authenticate the user or don’t support delegating the user’s context to downstream resources

In those scenarios, the agent is the one who requests access, and the issued access token's subject is the [agent identity](https://learn.microsoft.com/en-us/entra/agent-id/what-are-agent-identities) rather than the user. As a result, the Conditional Access policy scope apply to the **agent identity**, not a user. 

> [!IMPORTANT]
> Before configuring a Conditional Access policy, read the [Conditional Access for agent identities](agent-id.md) article. It covers the authentication flow, service boundaries and limitations. To  ensure you cover all scenarios and your corporate data and services are well protected.

## Prerequisites

- Admins who interact with Conditional Access need one of the following role assignments, depending on the tasks they're performing.
   - [Security Reader](~/identity/role-based-access-control/permissions-reference.md#security-reader) to read Conditional Access policies and configurations.
   - [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) to create or modify Conditional Access policies.
- Microsoft Entra ID P1 license

## Allow only specific agents to access resources

There are two key business scenarios where Conditional Access policies can help you manage agents effectively. In the first scenario you might want to ensure that only approved agents can access resources. You can do this by tagging agents and resources with [custom security attributes](https://learn.microsoft.com/en-us/entra/fundamentals/custom-security-attributes-overview) targeted in your policy, or by manually selecting them using the enhanced object picker.

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
1. Assign the appropriate value to resources that your agent is allowed to access. For example, you might want only agents that are **HR_Approved** to be able to access resources that are tagged **HR**.

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
1. Under **Access controls** > **Grant**: 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

---

## Block high-risk agent identities from accessing my organization’s resources

In the second scenario, organizations can create a Conditional Access policy to block high-risk agent identities based on [signals from Microsoft Entra ID Protection](/entra/id-protection/concept-risky-agents). For details on risk detection types and response actions for agents, see [Identity Protection for agents](/entra/id-protection/concept-risky-agents).

The following steps create a Conditional Access policy to block all high-risk agent identities from accessing your organization's resources.

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

Admins can use the Sign-in logs to investigate why a Conditional Access policy did or didn't apply as explained in [Microsoft Entra sign-in events](troubleshoot-conditional-access.md#microsoft-entra-sign-in-events). These events appear in the **Service principal sign-ins**. You can also filter by **Agent type** is **agent identity**. 

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
---
title: Recommended policies for agents operating on-behalf-of a user in Microsoft Entra
description: Learn how to configure Conditional Access for agents operating on-behalf-of a user in Microsoft Entra ID, extending Zero Trust to AI agents.
ms.topic: how-to
ms.date: 06/02/2026
ms.custom: agent-id-ignite, msecd-doc-authoring-1012
ms.reviewer: kvenkit
ai-usage: ai-assisted
---
# Recommended policies for agents operating on-behalf-of a user

Use this guide to configure Conditional Access for agents operating on behalf of a user. This flow is commonly referred to as OBO (On-Behalf-Of). In this model, a user signs into an agent application and receives an access token. When the agent needs to access a downstream resource, such as Microsoft Graph, Work IQ MCP server, or any other service, it can't reuse that token, because it was issued for agent application (audience and permission scope). Instead, the agent uses the OBO flow to exchange the inbound token with a new token scoped to the target resource. If the agent needs to call multiple resources, for example, two different MCP servers, it may obtain a separate token for each one.

In the on-behalf-of flow the scope of the Conditional Access policy includes **users**, not agents. The users and groups can be included or excluded from Conditional Access policies. Microsoft Entra ID evaluates all policies and ensures all requirements are met before granting access.

> [!IMPORTANT]
> Before configuring a Conditional Access policy, read the [Conditional Access for agents](agent-id.md) article. It covers the authentication flow, service boundaries, and limitations to ensure you cover all scenarios and your corporate data and services are well protected.

## Create a Conditional Access policy

Follow these steps to create a Conditional Access policy that requires multifactor authentication strength to access corporate resources:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Users, agents or workload identities**.
   1. Under **What does this policy apply to?**, select **Users and groups**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**: 
      1. Select **Users and groups** 
         1. Choose your organization's emergency access or break-glass accounts.
         1. If you use hybrid identity solutions like Microsoft Entra Connect or Microsoft Entra Connect Cloud Sync, select **Directory roles**, then select **Directory Synchronization Accounts**
      1. You might choose to exclude your guest users if you're targeting them with a [guest user specific policy](policy-guests-mfa-strength.md). 
1. Under **Target resources** > **Include**, select the resources the agent may access on behalf of the user.
   - Choose **All resources (formerly 'All cloud apps')** to apply the policy broadly, or **Select resources** to target specific resources.

   > [!TIP]
   > Microsoft recommends all organizations create a baseline Conditional Access policy that targets: All users, all resources without any app exclusions, and requires multifactor authentication.

1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select the built-in **Multifactor authentication strength** from the list.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Agent context condition

The **Agent context** condition allows administrators to apply Conditional Access policies specifically when access is performed through an agent. This condition helps distinguish between:

- Direct user access to a resource
- Access performed by an agent on behalf of the user

For example, an organization can allow a user to access SharePoint directly while applying stricter protections when the same user accesses SharePoint through an agentic workflow.

### How agent-assisted policies work

Agent-assisted access policies are **additive protections**. Existing user protections continue to apply and remain the baseline enforcement layer. These policies add guardrails specifically when an agent participates in the access flow.

Existing protections that continue to apply include:

- MFA requirements
- Device compliance policies
- User risk policies
- Network restrictions

> [!IMPORTANT]
> Organizations don't need to recreate existing user Conditional Access policies for agent-assisted flows. Instead, use the agent context condition to incrementally introduce agent-specific guardrails on top of existing protections.

### Understanding agentic sessions

An agentic session represents an active execution context where an agent performs actions on behalf of a user. A session typically begins when an agent starts executing tasks and continues while the agent accesses resources, invokes tools, or performs workflow operations.

During an agentic session, the agent might:

- Access enterprise resources
- Execute multi-step workflows
- Invoke APIs and tools
- Read or write organizational data

### Block risky agentic sessions

This policy blocks agent-assisted access when the agentic session is evaluated as risky, helping prevent compromised or hijacked agent workflows from accessing resources on behalf of users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Users, agents or workload identities**.
   1. Under **What does this policy apply to?**, select **Users and groups**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**:
      1. Select **Users and groups**.
         1. Choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Agent context (Preview)**, set **Configure** to **Yes**.
   1. Select **Enabled** to apply this policy when access is performed through an agent.
1. Under **Conditions** > **Agent session risk (Preview)**, set **Configure** to **Yes**.
   1. Under **Configure agent session risk levels needed for policy to be enforced**, select **Medium** and **High**.
1. Under **Access controls** > **Grant**.
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

### Important behavior for agent-assisted access

| Scenario | Result | Explanation |
|----------|--------|-------------|
| User satisfies MFA, but the agentic session is evaluated as high risk | Access blocked | Agent session risk policy blocks the workflow |
| User access is blocked by an existing user policy | Access blocked | Agent-related policies don't bypass existing user protections |
| User policies require MFA and agent policies require compliant devices | Access allowed only if all applicable requirements are satisfied | Multiple Conditional Access requirements might apply together |
| No agent-specific policy is configured | Existing Conditional Access behavior continues to apply | User protections remain the baseline enforcement model |

## Recommended policies

In the On-Behalf-Of (OBO) flow, the scope of Conditional Access policy enforcement is applied to users. Agents aren't subject to these policies directly. The following Conditional Access policies can serve as baseline for implementing Zero Trust access controls across your organization's resources.

- [Block legacy authentication with Conditional Access](policy-block-legacy-authentication.md)
- [Require phishing-resistant multifactor authentication for administrators](policy-admin-phish-resistant-mfa.md)
- [Require multifactor authentication for guest users](policy-guests-mfa-strength.md)
- [Protect security info registration with Conditional Access policy](policy-all-users-security-info-registration.md)
- [Require multifactor authentication for elevated sign-in risk](policy-risk-based-sign-in.md)
- [Require remediation for risky users](policy-risk-based-user.md)
- [Require multifactor authentication for device registration](policy-all-users-device-registration.md)
- [Require device compliance with Conditional Access](policy-all-users-device-compliance.md)

## Related content

- [Manage agent identities in your organization](/entra/agent-id/manage-agent-identities-organization) - Overview of agent identity management across the full lifecycle.
- [Conditional Access for agents](agent-id.md)
- [Conditional Access template policies](concept-conditional-access-policy-common.md)
- [Conditional Access: Users, groups, agents, and workload identities](concept-conditional-access-users-groups.md)
- [Conditional Access: Target resources](concept-conditional-access-cloud-apps.md)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
- [Conditional Access: Grant](concept-conditional-access-grant.md)
- [Security for AI with Microsoft Entra agent identity](../../agent-id/security-for-ai-overview.md)
- [Microsoft Entra ID Protection and agents](/entra/id-protection/concept-risky-agents)
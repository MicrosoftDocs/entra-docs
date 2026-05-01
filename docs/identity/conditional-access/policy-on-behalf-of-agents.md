---
title: Conditional Access for agents operating on-behalf-of a user in Microsoft Entra
description: Learn how to configure Conditional Access for agents operating on-behalf-of a user in Microsoft Entra ID, extending Zero Trust to AI agents.
ms.topic: how-to
ms.date: 04/30/2026
ms.custom: agent-id-ignite, msecd-doc-authoring-1012
ms.reviewer: kvenkit
---
# Conditional Access for agents operating on-behalf-of a user in Microsoft Entra

Use this guide to configure Conditional Access for agents operating on behalf of a user. This flow is commonly referred to as OBO (On-Behalf-Of). In this model, a user signs into an agent application and receives an access token. When the agent needs to access a downstream resource, such as Microsoft Graph, Work IQ MCP server, or any other service, it can't reuse that token, because it was issued for agent application (audience and permission scope). Instead, the agent uses the OBO flow to exchange the inbound token with a new token scoped to the target resource. If the agent needs to call multiple resources, for example, two different MCP servers, it may obtain a separate token for each one.

In the on-behalf-of flow the scope of the Conditional Access policy includes **users**, not the agent identities. The users and groups can be included or excluded from Conditional Access policies. Microsoft Entra ID evaluates all policies and ensures all requirements are met before granting access.

> [!IMPORTANT]
> Before configuring a Conditional Access policy, read the [Conditional Access for agent identities](agent-id.md) article. It covers the authentication flow, service boundaries, and limitations to ensure you cover all scenarios and your corporate data and services are well protected.

## Create a Conditional Access policy

Follow these steps to create a Conditional Access policy that requires multifactor authentication strength to access corporate resources:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**: 
      1. Select **Users and groups** 
         1. Choose your organization's emergency access or break-glass accounts.
         1. If you use hybrid identity solutions like Microsoft Entra Connect or Microsoft Entra Connect Cloud Sync, select **Directory roles**, then select **Directory Synchronization Accounts**
      1. You might choose to exclude your guest users if you're targeting them with a [guest user specific policy](policy-guests-mfa-strength.md). 
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select the resources the agent may access.

   > [!TIP]
   > Microsoft recommends all organizations create a baseline Conditional Access policy that targets: All users, all resources without any app exclusions, and requires multifactor authentication.

1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select the built-in **Multifactor authentication strength** from the list.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Recommended policies

In the On-Behalf-Of (OBO) flow, the scope of Conditional Access policy enforcement is applied to users. The agent identities are not subject to these policies directly. The following Conditional Access policies can serve as baseline for implementing Zero Trust access controls across your organization's resources.

- [Block legacy authentication with Conditional Access](policy-block-legacy-authentication.md)
- [Require phishing-resistant multifactor authentication for administrators](policy-admin-phish-resistant-mfa.md)
- [Require multifactor authentication for guest users](policy-guests-mfa-strength.md)
- [Protect security info registration with Conditional Access policy](policy-all-users-security-info-registration.md)
- [Require multifactor authentication for elevated sign-in risk](policy-risk-based-sign-in.md)
- [Require remediation for risky users](policy-risk-based-user.md)
- [Require multifactor authentication for device registration](policy-all-users-device-registration.md)
- [Require device compliance with Conditional Access](policy-all-users-device-compliance.md)

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
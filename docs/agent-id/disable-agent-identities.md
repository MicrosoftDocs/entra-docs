---
title: Disable agent identities in your tenant
titleSuffix: Microsoft Entra Agent ID
description: Learn how to disable agent identities in your Microsoft Entra ID tenant using Conditional Access policies and creation restrictions.
ms.topic: how-to
ms.date: 04/29/2026
ms.reviewer: dastrock
ai-usage: ai-assisted
#Customer intent: As a security administrator managing agent identities in my tenant, I want to disable agent identities to prevent their use in my organization so that I can maintain strict control over identity types and reduce potential security risks from AI agents.
---

# Disable agent identities in your tenant

As an IT administrator overseeing agent identities in your tenant, you might need to temporarily stop agent activity to investigate an issue or review agent usage. You can disable agent identities and agent identity blueprints in your tenant depending on your need. Both actions have implications that you should understand before proceeding.

You can also configure Conditional Access policies and remove agent creation permissions, if your organization needs to restrict agent identities from being created or used in your tenant. These processes can serve as a different approach to disabling agent identities. This article covers scenarios related to disabling agent identities.

## Types of identities used by AI agents

Your Microsoft Entra tenant might contain AI agents with or without a Microsoft Entra agent identity.

- **Agents with agent identities**: Agents created in Microsoft Entra Agent ID or using the latest iterations of systems like Microsoft Copilot Studio, Azure AI Foundry, and Security Copilot are created with agent identities. Agent identities have clear classification, richer metadata, and features designed to address the unique security challenges of AI agents.

- **Agents without agent identities**: Agents created in earlier versions of Copilot Studio and Azure AI Foundry might have been created as classic applications / service principals in your tenant. These applications / service principals might have tag values that denote them as AI agents, but they don't have Microsoft Entra agent identities. They're subject to the same policies, governance, and processes as all other applications / service principals in your tenant.

## Disabling agent identity considerations

Disabling an agent identity in your tenant might have broader consequences than simply stopping new AI agents from being created or used. Before you proceed, evaluate the following considerations:

- Existing agents running in your organization might begin to fail.
- Microsoft product experiences that assume agent identity availability (for example, Copilot Studio agents, Security Copilot scenario agents, Microsoft Entra Conditional Access Optimization Agent) might fail or degrade to less transparent application or service principal patterns.
- Support or troubleshooting: Helpdesk and SOC teams might receive increased tickets when features fail quietly due to missing agent identities.
- Blocking agent identities might push teams to build agents using generic application or service principal identities, reducing visibility and making it harder to distinguish agents from other software projects.

## Monitor for agent identity creation and activity

Before disabling an agent identity or agent identity blueprint, you should be aware of what kind of activity is associated with those identities. Agent identity activities are logged under the base identity types they originate from. For example, creating an agent identity shows up as *add service principal" and adding an agent identity blueprint shows up as *add application* in the audit logs. 

To identify whether an audit event involves an agent identity, check the `agentType` property on the `initiatedBy` and `targetResources` fields. A value other than `notAgentic` indicates agent involvement.

The `agentSignIn` resource type provides descriptive information that identifies and classifies sign-in events as agentic. With this value you can determine when an agent identity was the subtype of the identity involved in an authentication event.

For more information, see [agent sign-in logs](sign-in-audit-logs-agents.md)

## Approaches to disabling agent identities

After reviewing agent activity, choose the approach that matches your scenario. Disabling agents in the Microsoft Entra admin center is object-scoped — it targets a specific blueprint or agent identity without affecting others. Conditional Access policies are tenant-wide enforcement that block token issuance for broad categories of identities, without modifying any agent identities or blueprints. The two approaches can be combined. Applying Conditional Access policies in your tenant requires the Microsoft Entra ID P1 license.

Conditional Access policies can block authentication and token issuance of agent identities. Applying the policies prevents existing and new agent identities from authenticating, but it doesn't prevent the creation of agent identities in your tenant. 

We recommend running these policies in [report-only mode](/entra/identity/conditional-access/concept-conditional-access-report-only) to understand their impact before enforcing them.

**Disable agents in the Microsoft Entra admin center when:**

- You want to prevent an agent identity from receiving tokens and authenticating, but you need to keep the agent identity and its metadata in your tenant.

**Use Conditional Access policies when:**

- You want to prevent all agent identities across your tenant from authenticating, including those you didn't create, without modifying individual objects.
    - [Policy 1: Block agent identity authentication](#policy-1-block-agent-identity-authentication).
- You want to prevent agents that act on behalf of users from receiving tokens (for example, agents performing delegated actions), without disabling the agent identity objects themselves
    - [Policy 2: Block agent's user account authentication](#policy-2-block-agents-user-account-authentication).
- You want to prevent human users from signing into agents or triggering agent actions on their behalf, while leaving agent-to-agent and autonomous flows unaffected
    - [Policy 3: Block users signing into agents](#policy-3-block-users-signing-into-agents).
- You need to enforce a temporary, reversible, tenant-wide hold on all agent authentication for compliance or incident response purposes, apply all three policies in report-only mode first, then enforce them.

## Disable agent identities and agent identity blueprints in the Microsoft Entra admin center

To disable an agent identity:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator).
1. Browse to **Entra ID** > **Agents** > **Agent identities**.
1. Select the agent identity you want to disable then select **Disable**.

To disable an agent identity blueprint: 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator).
1. Browse to **Entra ID** > **Agents** > **Agent blueprints**.
1. Select the agent identity blueprint you want to disable then select **Disable**.

## Create Conditional Access policies to disable agent activities

There are three policy templates you can use to block token issuance or prevent users from signing into agents. These policies can be created in the Microsoft Entra admin center or through the Microsoft Graph API. We recommend applying these policies in report-only mode first to understand their impact before enforcing them.

- Block token issuance to agent identities using Conditional Access > Policy 1: Block agent identity authentication
- Block token issuance to agents' user accounts using Conditional Access > Policy 2: Block agent's user account authentication
- Block users signing into agents using Conditional Access > Policy 3: Block users signing into agents

### Policy 1: Block agent identity authentication

The following steps help create a Conditional Access policy to block issuance of access tokens requested using agent identities.

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents or workload identities**.
   1. Under **Include**, select **All agent identities**
   1. Under **Exclude**, select **None**
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**.
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

### [Microsoft Graph API](#tab/microsoft-graph-api)

Example JSON for creating the **Block agent identity authentication** policy with the Microsoft Graph APIs:


```http
POST https://graph.microsoft.com/beta/identity/conditionalAccess/policies
Content-type: application/json

{
    "displayName": "Block all agent identities from accessing resources",
    "conditions": {
        "clientApplications": {
            "includeAgentIdServicePrincipals": [
                "All"
            ],
            "excludeAgentIdServicePrincipals": [],
            "agentIdServicePrincipalFilter": null
        },
        "applications": {
            "includeApplications": [
                "All"
            ],
            "excludeApplications": []
        }
    },
    "grantControls": {
        "operator": "AND",
        "builtInControls": [
            "block"
        ]
    },
    "state": "enabledForReportingButNotEnforced"
}
```
---


### Policy 2: Block agent's user account authentication

The following steps help create a Conditional Access policy to block issuance of access tokens requested using agents' user accounts.

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents or workload identities**.
   1. Under **Include** > **Select agents** > **agents acting as users** > select **All agents acting as users**
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**.
   1. Select **Block access**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

### [Microsoft Graph API](#tab/microsoft-graph-api)

Example JSON for creating the **Block agent's user account authentication** policy with the Microsoft Graph APIs:

```http
POST https://graph.microsoft.com/beta/identity/conditionalAccess/policies
Content-type: application/json

{
    "displayName": "Block all agent users from accessing resources",
    "conditions": {
        "users": {
            "includeUsers": [
                "AllAgentIdUsers"
            ]
        },
        "applications": {
            "includeApplications": [
                "All"
            ]
        }
    },
    "grantControls": {
        "operator": "AND",
        "builtInControls": [
            "block"
        ]
    },
    "state": "enabledForReportingButNotEnforced"
}
```
---

### Policy 3: Block users signing into agents

The following steps help create a Conditional Access policy to block issuance of access tokens to agent resources when requested by human users. This blocks human users from signing into agents and agents performing actions on their behalf.

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents or workload identities**.
   1. Under **Include**, select **All users**
   1. Under **Exclude**: 
      1. Select **None** 
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All agent resources**.
1. Under **Access controls** > **Grant**.
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

### [Microsoft Graph API](#tab/microsoft-graph-api)

Example JSON for creating the **Block users signing into agents** policy with the Microsoft Graph APIs:

```http
POST https://graph.microsoft.com/beta/identity/conditionalAccess/policies
Content-type: application/json

{
    "displayName": "Block all users from accessing agent resources",
    "conditions": {
        "users": {
            "includeUsers": [
                "All"
            ]
        },
        "applications": {
            "includeApplications": [
                "AllAgentIdResources"
            ],
            "excludeApplications": []
        }
    },
    "grantControls": {
        "operator": "AND",
        "builtInControls": [
            "block"
        ]
    },
    "state": "enabledForReportingButNotEnforced"
}
```
---

## (Optional) Block creation of agent identities

The Conditional Access policies are sufficient to prevent all usage of agent identities in your tenant, including newly created agent identities. Should you wish to prevent creation of agent identities in your tenant, follow the steps in this section.

Agent identities can enter your tenant through various channels. For more information, see [Agent ID creation channels](agent-id-creation-channels.md). You can block creation of agent identities through the following methods.

- Block creation of agent identities in the Microsoft Entra admin center and other Microsoft Entra experiences.
- Block acquisition of agent identities from Independent Software Vendors (ISVs).
- Block creation of agent identities by Microsoft products and services.

### Block creation of agent identities in Microsoft Entra ID

To prevent users from creating agent identities in the Microsoft Entra admin center and other Microsoft Entra experiences:

1. Remove any eligible or active assignments to the **Agent ID Administrator** or **Agent ID Developer** built-in roles.
1. Remove any *oauth2PermissionGrants* or *appRoleAssignments* granted to service principals that allow creation of agent identities. Refer to the following table for the specific permissions.

| Permission | Type |
| ---------- | ------ |
| `AgentIdentity.Create.All` | Application permission |
| `AgentIdentityBlueprint.Create` | Delegated and application permission |
| `AgentIdentityBlueprint.ReadWrite.All` | Delegated and application permission |
| `AgentIdentityBlueprintPrincipal.Create` | Delegated and application permission |
| `AgentIdentityBlueprintPrincipal.ReadWrite.All` | Delegated and application permission |
| `AgentIdUser.ReadWrite.IdentityParentedBy` | Delegated and application permission |
| `AgentIdUser.ReadWrite.All` | Delegated and application permission |
| `User.ReadWrite.All` | Delegated and application permission. These permissions can also be used to manage human user accounts. Removing this permission causes systems to lose access to manage human users. |

See the [Microsoft Graph permissions reference](/graph/permissions-reference) for full details of these permissions.

### Block acquisition of agent identities from ISVs

To prevent users from creating agent identities by granting consent to an ISVs agent identity blueprint, use Microsoft Entra [settings to disable user ability to consent to applications](/entra/identity/enterprise-apps/configure-user-consent). There's no method to prevent users from granting consent to agent identities without also affecting ability to grant consent to applications. Disabling user consent is broad and also blocks onboarding of legitimate non-agent SaaS apps that depend on user consent flows and granting permissions to existing non-agent apps.

If this impact is too high, keep user consent enabled and instead rely on the [Conditional Access block policies](#policy-1-block-agent-identity-authentication) to prevent tokens for unapproved ISV agent identities.

### Block creation of agent identities by Microsoft products and services

To block Microsoft products and services from creating agent identities in your tenant, you must use the settings available in each Microsoft product:

#### Security Copilot

To disable agent identity creation by Security Copilot, shut off Security Copilot by deleting all Security Compute Unit (SCU) capacity. This blocks both agents and Security Copilot itself. For more information, see [Security Copilot documentation](/copilot/security/). Users with the following roles can turn Security Copilot back on by creating SCU capacity:

- Billing Administrator
- Microsoft Entra Compliance Administrator
- Global Administrator
- Intune Administrator
- Security Administrator
- Purview Compliance Administrator
- Purview Data Governance Administrator
- Purview Organization Management.

To enable use of Security Copilot but block agent creation, you can use the following methods depending on the type of agents you want to block:

- To block Microsoft agents (For example, Microsoft Entra conditional access Agent), request users with relevant roles not to enable each agent. Roles that can enable agent currently include:
    - Security Administrator
    - Identity Governance Administrator
    - Lifecycle Workflows Administrator
    - Security Copilot Contributor
- To block third-party agents (agents not owned by Microsoft), remove all users from the Owner / Contributor role in any Security Copilot workspaces.

#### Copilot Studio

To disable use of Copilot Studio and creation of agent identities, you can restrict agent creation via licensing, RBAC, or data policies.

- Licensing:
    - Prevent users from signing up for free trials of Copilot Studio.
    - Don't assign Copilot Studio licenses to users.
- RBAC:
    - Prevent users from signing up for free trials, which prevents creation of trial environments.
    - Creation of Copilot Studio environments requires the Power Platform Administrator role. Remove access to environments and ability to create new environments.
- Data policies:
    - Apply policies that prevent agents from being published, so nobody can chat with an agent. This does **not** block agent creation.

See Copilot Studio documentation for details, which [recommends using data policies](/microsoft-copilot-studio/security-faq#can-i-disable-microsoft-copilot-studio-agent-creation-in-my-organization).

#### Azure AI Foundry

To disable creation of agent identities, prevent users from creating projects and agents in Azure AI Foundry, you can turn off user ability to create Azure subscriptions via free trials or pay-as-you-go. This enforces the following settings:

- Only Billing Administrator or Account Administrator roles can create subscriptions.
- Within a subscription, only the Azure AI Account Owner role can create Foundry projects.
- Within a project, users must have the Azure AI User role to create agents.

By not assigning these roles to users, users can't create agents or agent identities.

For more information, see [Azure AI Foundry documentation here](/azure/ai-foundry/concepts/rbac-azure-ai-foundry).

#### Microsoft Teams

To disable creation of agent identities via Microsoft Teams, use settings in the Teams admin center:

- Prevent users from adding apps/agents to Teams.
- Pivot by Microsoft apps, third-party apps, or custom apps.
- Enable specific apps/agents for specific users/groups as needed.

For more information, see [Teams admin center documentation](/microsoftteams/manage-apps).

## Related content

- [Agent identity deletion](concept-agent-identity-deletion.md)
- [Create and delete agent identities](create-delete-agent-identities.md)
- [Agent sign-in and audit logs](sign-in-audit-logs-agents.md)
- [Agent identity creation channels](agent-id-creation-channels.md)
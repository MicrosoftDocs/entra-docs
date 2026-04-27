---
title: Disable agent identities in your tenant
titleSuffix: Microsoft Entra Agent ID
description: Learn how to disable agent identities in your Microsoft Entra ID tenant using Conditional Access policies and creation restrictions.
ms.topic: how-to
ms.date: 04/27/2026
ms.custom: agent-id-ignite
ms.reviewer: dastrock
ai-usage: ai-assisted
#Customer intent: As a security administrator managing agent identities in my tenant, I want to disable agent identities to prevent their use in my organization so that I can maintain strict control over identity types and reduce potential security risks from AI agents.
---

# Disable agent identities in your tenant

As an IT administrator overseeing agent identities in your tenant, you might need to temporarily stop agent activity to investigate an issue or review agent usage. You can disable agent identities in your tenant so that the infrastructure of the agent identity is in place, but it's not able to authenticate or be used.

You can also can configure Conditional Access policies and remove agent creation permissions, if your organization needs to restrict agent identities from being created or used in your tenant. This article covers scenarios related to disabling agent identities.

## Types of identities used by AI agents

Your Microsoft Entra tenant might contain two kinds of identities used by AI agents:

- **Agents with agent identities**: Agents created using the latest iterations of systems like Microsoft Copilot Studio, Azure AI Foundry, and Security Copilot are created with agent identities in your tenant. Agent identities have clear classification, richer metadata, and features designed to address the unique security challenges of AI agents.


- **Agents using applications / service principals**: Agents created in earlier versions of Copilot Studio and Azure AI Foundry might have been created as classic applications / service principals in your tenant. These applications / service principals have tag values that denote them as AI agents.

    While these identities appear in the Microsoft Entra admin center's agent identity management experience, they aren't agent identities. They're classic applications / service principals. This means that they're subject to the same policies, governance, and processes as all other applications / service principals in your tenant.
<!--- Do we talk about this elsewhere? --->
    This article doesn't discuss methods for disabling the use of applications / service principals in your tenant.



## Review existing agent identities in your tenant

Agent identities might already exist in your tenant. Before making changes, take inventory of agent identities using the following tools:
<!--- Need to point to A365 as well but need good line about what to look for where. --->
1. In the Microsoft Entra admin center, navigate to **Identity** > **Agent ID** to view all agent identities.
1. Alternatively, use Microsoft Graph API:
    - Query: `GET https://graph.microsoft.com/beta/servicePrincipals/graph.agentIdentity`
    - This returns a list of agent identities in your tenant.

1. Review the list to understand which agent identities have been created, their sponsors, and their usage.

## Understand the impact of disabling agent identities

Globally disabling agent identities in your tenant has broader consequences than simply stopping new AI agents from being created or used. Before you proceed, evaluate the following considerations:

- Existing agents running in your organization might begin to fail.
- Microsoft product experiences that assume agent identity availability (for example, Copilot Studio agents, Security Copilot scenario agents, Microsoft Entra Conditional Access Optimization Agent) might fail or degrade to less transparent application or service principal patterns.
<!--- How does this work for CA agent? iF you disable in AGent ID? --->
- Support or troubleshooting: Helpdesk and SOC teams might receive increased tickets when first-party features fail quietly due to missing agent identities.
- Blocking agent identities might push teams to build agents using generic application or service principal identities, reducing visibility and making it harder to distinguish agents from other software projects.

If full disable proves too disruptive, consider a partial approach while allowing some usage of agent identities in your tenant.

To disable agent identities in your tenant, follow these steps:

1. Apply Conditional Access policies to prevent agent identities from authenticating.
1. (Optional) Block creation of agent identities in your tenant via various channels.

## Monitor for agent identity creation and activity

To ensure disable controls remain effective and detect drift (new agent identities or attempted usage), implement lightweight monitoring.

### Review agent identity creation in audit logs

Agent identities are logged under the base identity types they originate from. This means that:

- The creation of an agent's user account appears as a *Create user* audit activity.
- The creation of an agent identity appears as a *Create service principal* audit event.

To monitor for agent identity creation, you must detect these creation events, and look up the object ID of the created object via Microsoft Graph to determine if the object created is an agent identity.

For more information, see [agent audit logs](sign-in-audit-logs-agents.md)

### Review agent identity authentication attempts in sign-in logs

The `agentSignIn` resource type provides descriptive information that identifies and classifies sign-in events as agentic. This allows customers to determine when an agent identity was the subtype of the identity involved in an authentication event. For more information, see [agent sign-in logs](sign-in-audit-logs-agents.md)

## Block token issuance to agent identities using Conditional Access

Conditional Access policies can block authentication and token issuance of agent identities. Applying the policies prevents existing and new agent identities from authenticating. It doesn't prevent the creation of agent identities in your tenant.

Applying these policies in your tenant requires the Microsoft Entra ID P1 license. Customers with [Microsoft 365 Business Premium licenses](/office365/servicedescriptions/office-365-service-descriptions-technet-library) can also use Conditional Access features. To find the right license for your requirements, see [Compare generally available features of Microsoft Entra ID](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

To block authentication and token issuance of agent identities, create the following Conditional Access block policies. We recommend running these policies in [report-only mode](/entra/identity/conditional-access/concept-conditional-access-report-only) and understand their impact before enforcing them.

### Policy 1: Block agent identity authentication

The following steps help create a conditional access policy to block issuance of access tokens requested using agent identities.

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

Example JSON for creation via Microsoft Graph APIs:


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

### Policy 2: Block agent's user account authentication

The following steps help create a conditional access policy to block issuance of access tokens requested using agents' user accounts.

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

Example JSON for creation via Microsoft Graph APIs:

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

### Policy 3: Block users signing into agents

The following steps help create a conditional access policy to block issuance of access tokens to agent resources when requested by human users. This blocks human users from signing into agents and agents performing actions on their behalf.

Purpose: Block users from signing into agents and agents performing actions on their behalf.

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

Example JSON for creation via Microsoft Graph APIs:

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

## (Optional) Block creation of agent identities

The Conditional Access policies are sufficient to prevent all usage of agent identities in your tenant, including newly created agent identities. Should you wish to prevent creation of agent identities in your tenant, follow the steps in this section.

Agent identities can enter your tenant through various channels. See [this article for details](agent-id-creation-channels.md). You can block creation of agent identities through the following methods.

- Block creation of agent identities via the Microsoft Entra admin center and other Microsoft Entra experiences.
- Block acquisition of agent identities from Independent Software Vendors (ISVs).
- Block creation of agent identities by Microsoft products and services.

### Block creation of agent identities via Microsoft Entra ID

To prevent users from creating agent identities via the Microsoft Entra admin center and other Microsoft Entra experiences:

1. Remove any assignments to the **Agent ID Administrator** or **Agent ID Developer** built-in roles.
1. Remove any *oauth2PermissionGrants* or *appRoleAssignments* granted to service principals that allow creation of agent identities. See table below.

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

To prevent users from creating agent identities by granting consent to an ISV's agent identity blueprint, use Microsoft Entra [settings to disable user ability to consent to applications](/entra/identity/enterprise-apps/configure-user-consent).

There's no method to prevent users from granting consent to agent identities without also affecting ability to grant consent to applications.

Disabling user consent is broad and also blocks:

- Onboarding of legitimate nonagent SaaS apps that depend on user consent flows.
- Granting permissions to existing nonagent apps.

If this impact is too high, keep user consent enabled and instead rely on the [Conditional Access block policies](#block-token-issuance-to-agent-identities-using-conditional-access) to prevent tokens for unapproved ISV agent identities.

### Block creation of agent identities by Microsoft products and services

To block Microsoft products and services from creating agent identities in your tenant, you must use the settings available in each Microsoft product:

#### Security Copilot

- To disable agent identity creation by Security Copilot, shut off Security Copilot by deleting all Security Compute Unit (SCU) capacity. This blocks both agents and Security Copilot itself. Users with the following roles can turn Security Copilot back on by creating SCU capacity:

    - Billing Administrator
    - Microsoft Entra Compliance Administrator
    - Global Administrator
    - Intune Administrator
    - Security Administrator
    - Purview Compliance Administrator
    - Purview Data Governance Administrator
    - Purview Organization Management.

- To enable use of Security Copilot but block agent creation, you can use the following methods depending on the type of agents you want to block:

    - To block Microsoft agents (For example, Microsoft Entra conditional access Agent), request users with relevant roles not to enable each agent. Roles that can enable agent currently include:
        - Security Administrator
        - Identity Governance Administrator
        - Lifecycle Workflows Administrator
        - Security Copilot Contributor

    - To block third-party agents (agents not owned by Microsoft), remove all users from the Owner / Contributor role in any Security Copilot workspaces.

For more information, see [Security Copilot documentation](/copilot/security/).

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

To disable creation of agent identities, prevent users from creating projects and agents in Azure AI Foundry:

Turn off user ability to create Azure subscriptions via free trials or pay-as-you-go. This enforces the following:

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

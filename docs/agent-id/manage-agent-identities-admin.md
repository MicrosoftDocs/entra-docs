---
title: Manage agent identities in your organization
titleSuffix: Microsoft Entra Agent ID
description: Learn how to manage agent identities across your organization. View, disable, govern, and monitor agents using the Microsoft Entra admin center and Conditional Access.
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 04/02/2026
ms.custom: msecd-doc-authoring-108

#customer intent: As an IT administrator, I want a unified guide for managing agent identities in my organization so that I can efficiently view, govern, monitor, and secure agents across the full management lifecycle.

---

# Manage agent identities in your organization

Microsoft Entra Agent ID provides a centralized set of tools for managing agent identities across your organization. Agent identities are a distinct identity type in Microsoft Entra ID, designed for AI agents with classification, metadata, and security controls tailored to agentic workloads.

This article covers key agent management tasks: from viewing and disabling agents, to governing access, monitoring activity, and responding to security risks. Each section summarizes a management area and links to the detailed article for step-by-step instructions.

[!INCLUDE [entra-agent-id-preview-note](../includes/entra-agent-id-preview-note.md)]

## Prerequisites

Different management tasks require different roles and licenses. The following table summarizes the roles you need for each area of agent identity management.

| Task | Required role | Notes |
|---|---|---|
| View agent identities | Microsoft Entra user account | No admin role needed for viewing. |
| Manage agent identities | Agent ID Administrator or Cloud Application Administrator | Agent identity owners can manage their own agents without these roles. |
| Create agent blueprints | Agent ID Developer | User is added as owner of the blueprint and its service principal. |
| Configure Conditional Access policies | Conditional Access Administrator | Requires Microsoft Entra ID P1 license. |
| View ID Protection risk reports | Security Administrator, Security Operator, or Security Reader | Requires Microsoft Entra ID P2 license during preview. |
| Configure Lifecycle Workflows | Lifecycle Workflows Administrator | &nbsp; |

[!INCLUDE [entra-agent-id-license](../includes/entra-agent-id-license-note.md)]

<!-- TODO: Confirm whether Billing Administrator access to M365 admin center (Copilot > Settings > User access > Copilot Frontier) is needed for licensing verification, and if this should be mentioned here. -->

## View agent identities

The Microsoft Entra admin center provides a centralized interface to view all agent identities in your tenant. You can search, filter, sort, and customize columns to find specific agents.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Agent ID** > **All agent identities**.
1. Select any agent identity to view its details, including name, description, status, owners, sponsors, granted permissions, and sign-in logs.

To search for a specific agent, enter the **name** or **object ID** in the search box, or add the **Agent Blueprint ID** filter. You can customize which columns are shown by selecting the **Choose columns** button. Available columns include **Name**, **Created On**, **Status**, **Object ID**, **View Access**, **Agent Blueprint ID**, **Owners**, and **Uses agent identity**.

For detailed instructions on filtering, column customization, and managing agents from this view, see [View and manage agent identities in your tenant](identity-platform/agent-lists.md).

## Manage agent identity blueprints

Agent identity blueprints are the parent definitions from which individual agent identities are created. The admin center lets you view all blueprint principals, manage their permissions, and monitor their activity.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Agent identities** > **All agent identities**.
1. Select **View agent blueprint** in the upper right of the command bar.
1. Select any agent identity blueprint principal to manage it.

From a blueprint's management page, you can:

- **View linked agent identities**: See all child agent identities created from this blueprint.
- **Manage blueprint access**: View, manage, and revoke permissions assigned to the blueprint.
- **Manage owners and sponsors**: Owners handle technical administration, while sponsors are accountable for the agent's purpose and lifecycle decisions.
- **View audit logs**: Track administrative changes for security and compliance.
- **View sign-in logs**: Monitor authentication events.
- **Disable the blueprint**: Select **Disable** in the command bar.

For detailed instructions, see [View and manage agent identity blueprints in your tenant](identity-platform/manage-agent-blueprint.md).

## Enable or disable agent identities

You can enable or disable agent identities from two locations, depending on your role:

### Admin center (administrators)

Administrators can disable one or more agent identities from the admin center:

1. Browse to **Entra ID** > **Agent ID** > **All agent identities**.
1. Select one or more agents from the list by checking the box next to their name.
1. Select the **Disable** button in the toolbar.

You can also navigate into a single agent identity and disable it from its details page. For the full procedure, see [View and manage agent identities in your tenant](identity-platform/agent-lists.md).

### My Account portal (owners and sponsors)

Agent identity owners and sponsors can manage agents they're responsible for through the My Account portal:

1. Sign in to the [My Account end user portal](https://myaccount.microsoft.com/) as an owner or sponsor of at least one agent identity.
1. In the left menu, select **Manage agents (Preview)**.
1. Choose either the **Agents you sponsor** or **Agents you own** tab.
1. Select an agent, then choose **Disable agent** or **Enable agent**.

Disabling an agent from either location has the same effect: it blocks users from accessing the agent and prevents token issuance. Re-enabling restores access and token issuance.

For the full end-user management experience, see [Manage agents in end user experience](identity-platform/manage-agent-identities-end-user.md).

## Control agent access with Conditional Access

Conditional Access policies provide tenant-wide controls for agent identity authentication. You can use these policies to block all agent identities, allow only specific agents, or block risky agents based on ID Protection signals.

Key points about Conditional Access for agent identities:

- Policies can scope to **All agent identities** or **All agent users** with a **Block** grant control.
- Policies can target **All resources** to prevent agent access across your organization.
- **Agent risk conditions** (high, medium, low) allow you to block agents based on risk signals from ID Protection.
- Policies support **Report-only mode** for safe evaluation before enforcement.

> [!IMPORTANT]
> Conditional Access enforcement applies when an agent identity or agent user requests a token for any resource. It does **not** apply when an agent identity blueprint acquires a token to create agent identities or agent users.

For detailed policy configuration, step-by-step walkthroughs, and business scenario examples, see [Conditional Access for Agent ID](/entra/identity/conditional-access/agent-id).

<!-- TODO: PM question: Should the standalone "Disable agent identities in your tenant" article be formally retired and redirected to the CA article? If so, should its creation-blocking guidance (product-specific methods for Security Copilot and Copilot Studio) and impact warnings be migrated to the CA article or this consolidated guide? -->

## Monitor agent activity and risk

### Sign-in and audit logs

Agent identity activities are captured in Microsoft Entra audit and sign-in logs:

- **Audit logs** record agent-related events under the base identity type from which they originate. For example, creating an agent identity user appears as a "Create user" audit activity, and creating an agent identity appears as a "Create service principal."
- **Sign-in logs** include the `agentSignIn` resource type, which provides properties about the agent and its sign-in behavior.

To view agent sign-in logs:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Use the following filters:
   - **Agent type**: Choose from **Agent ID user**, **Agent Identity**, **Agent Identity Blueprint**, or **Not Agentic**.
   - **Is Agent**: Choose from **No** or **Yes**.

You can also retrieve agent sign-in events using Microsoft Graph:

```http
GET https://graph.microsoft.com/beta/auditLogs/signIns?$filter=signInEventTypes/any(t: t eq 'servicePrincipal') and agent/agentType eq 'AgentIdentity'
```

For full details on log types and access methods, see [Microsoft Entra Agent ID logs](sign-in-audit-logs-agents.md).

### Identity Protection for agents

Microsoft Entra ID Protection monitors agent identities for anomalous behavior. It detects six offline risk types, including unfamiliar resource access, sign-in spikes, and failed access attempts. Administrators can review the **Risky Agents report** and take response actions: confirm compromise, confirm safe, dismiss risk, or disable the agent.

> [!NOTE]
> ID Protection for agents requires a Microsoft Entra ID P2 license during preview.

When you confirm an agent as compromised, the risk level is set to **High**. If you have a Conditional Access policy configured to block on High Agent Risk, the agent is automatically blocked from accessing resources.

For the full risk detection table, response actions, Graph API details, and report walkthrough, see [Identity Protection for agents](/entra/id-protection/concept-risky-agents).

## Respond to agent security incidents

When agent activity triggers a risk detection or security concern, follow this sequence:

1. **Detect**: Review the **Risky Agents report** in the Microsoft Entra admin center. Risk detections are viewable for up to 90 days. Details include the agent's display name, risk state, risk level, agent type, and sponsors.
1. **Respond**: Take an immediate action:
   - **Confirm compromise**: Sets the risk level to High and triggers risk-based Conditional Access policies configured to block on High Agent Risk.
   - **Disable**: Prevents all sign-ins across Microsoft Entra ID and connected apps.
1. **Investigate**: Review risk detection details, sign-in logs, and audit logs to understand the scope and impact.
1. **Recover**: Based on your investigation:
   - If false positive: dismiss the risk and re-enable the agent.
   - If true compromise: rotate credentials before re-enabling, or retire the agent identity.

For detailed information on risk types, detection mechanisms, and response actions, see [Identity Protection for agents](/entra/id-protection/concept-risky-agents).

## Govern agent identities and sponsor oversight

### Sponsor responsibilities

Each agent identity should have an accountable human sponsor responsible for lifecycle and access decisions. Key governance behaviors include:

- **Automatic sponsor transfer**: If a sponsor leaves the organization, Microsoft Entra ID automatically reassigns sponsorship to the sponsor's manager.
- **Expiration notifications**: Sponsors receive notifications when access package assignments approach expiration. Sponsors can request an extension (which triggers a new approval cycle) or let assignments expire.
- **Access request pathways**: Access packages can be requested through three pathways: the agent's own programmatic request, a sponsor on behalf of the agent, or an admin direct assignment.

Access packages can grant Security Group memberships, Application OAuth API permissions (including Microsoft Graph application permissions), and Microsoft Entra roles.

For the full governance overview including access package configuration and sponsor policies, see [Governing Agent Identities](/entra/id-governance/agent-id-governance-overview).

### Automate sponsor notifications with Lifecycle Workflows

Lifecycle Workflows provides two automated tasks for agent identity sponsorship:

- Send email to manager about sponsorship changes
- Send email to cosponsors about sponsor changes

Both tasks are **mover and leaver** category tasks: they trigger only under mover or leaver workflow templates, not joiner templates. This ensures continuity of sponsorship when an agent's sponsor changes roles or leaves the organization.

For step-by-step workflow configuration, see [Agent identity sponsor tasks in Lifecycle Workflows](/entra/id-governance/agent-sponsor-tasks).

<!-- TODO: PM question: Are periodic sponsor re-certification or manual reassignment features planned? Should we mention these as upcoming capabilities? -->

## Automate agent management at scale

For organizations managing large numbers of agent identities, the following options are available:

- **Multi-select disable**: The admin center supports selecting multiple agent identities at once and disabling them in batch from the **All agent identities** page.
- **Microsoft Graph API (beta)**: Agent identity endpoints on the `/beta` API support programmatic management. For example, ID Protection exposes `riskyAgents` and `agentRiskDetections` collections for programmatic risk monitoring.

> [!NOTE]
> Comprehensive scripting tutorials for agent identity management don't yet exist on Microsoft Learn. At-scale management beyond multi-select currently requires custom scripting using the Graph API.

## Related content

- [View and manage agent identities in your tenant](identity-platform/agent-lists.md)
- [View and manage agent identity blueprints in your tenant](identity-platform/manage-agent-blueprint.md)
- [Manage agents in end user experience](identity-platform/manage-agent-identities-end-user.md)
- [Conditional Access for Agent ID](/entra/identity/conditional-access/agent-id)
- [Identity Protection for agents](/entra/id-protection/concept-risky-agents)
- [Governing Agent Identities](/entra/id-governance/agent-id-governance-overview)
- [Agent identity sponsor tasks in Lifecycle Workflows](/entra/id-governance/agent-sponsor-tasks)
- [Microsoft Entra Agent ID logs](sign-in-audit-logs-agents.md)
- [Owners, sponsors, and managers](identity-platform/agent-owners-sponsors-managers.md)
- [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference)

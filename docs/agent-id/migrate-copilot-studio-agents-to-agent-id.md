---
title: Recreate Copilot Studio agents with Microsoft Entra Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Learn how to recreate Microsoft Copilot Studio agents with Microsoft Entra Agent ID for enhanced governance and security. No in-place migration path exists today.
ms.topic: how-to
ms.date: 06/15/2026
ms.custom: agent-id, msecd-doc-authoring-1013
ai-usage: ai-assisted
#customer intent: As an IT admin or Copilot Studio maker, I want to understand how to recreate my Copilot Studio agents with Microsoft Entra Agent ID so that I can take advantage of agent-specific governance, Conditional Access, and audit capabilities.
---

# Recreate Copilot Studio agents in Microsoft Entra Agent ID

Some agents created in Microsoft Copilot Studio authenticate by using platform-managed service principals. These agents could have been created before Copilot Studio began automatically creating agent identities for all new agents, which happened on March 18, 2026. These agents could have also been created before your organization opted in to the [Microsoft Entra Agent ID integration with Copilot Studio](/microsoft-copilot-studio/admin-use-entra-agent-identities) or if your organization opted out of creating agent identities.

These service principals let agents communicate with Azure Bot Service, Microsoft Teams, and Bot Framework skills, but Microsoft Entra treats these service principals as standard applications, not as AI agents. Adopting Microsoft Entra Agent ID gives you agent-specific governance, including Conditional Access policies, centralized audit logging, and lifecycle management.

This article describes the manual process of recreating Copilot Studio agents with Microsoft Entra Agent ID and decommissioning the legacy service principals. Because Copilot Studio manages the agent code, credentials, and deployment lifecycle, this process differs from custom-built agents. For agents where you own the code and identity configuration, see [Migrate custom app registrations to Agent ID](migrate-custom-app-registrations-to-agent-id.md).

> [!IMPORTANT]
> At this time, there is no automated or in-place migration path to convert an existing Copilot Studio agent's service principal to an agent identity. To use Microsoft Entra Agent ID with Copilot Studio, you must **create a new agent** with the Agent ID integration enabled, manually reconfigure the agent, and then decommission the legacy agent. This article describes that recreate-and-deprecate process.

## Prerequisites

Before you begin, make sure you meet the following requirements:

- One or more Copilot Studio agents that use legacy service principals, created before March 18, 2026 or before your tenant opted in to Microsoft Entra Agent ID.
- Access to the **Copilot Studio admin center** and the **Microsoft Entra admin center**.
- **Agent ID Developer** or **Agent ID Administrator** role in Microsoft Entra to manage agent identities.
- Microsoft Entra Agent ID integration enabled for your tenant in Copilot Studio.
- Familiarity with [Microsoft Entra Agent ID key concepts](key-concepts.md).

### Licensing requirements

[!INCLUDE [entra-agent-id-license-note](../includes/licensing-agent-id.md)]

## Why adopt Microsoft Entra Agent ID?

Copilot Studio agents that use legacy service principals don't take advantage of the governance capabilities that Microsoft Entra Agent ID provides. By adopting Microsoft Entra Agent ID, your organization gets:

[!INCLUDE [migrate-why-agent-id](includes/migrate-why-agent-id.md)]

## How Copilot Studio agents differ from custom agents

Copilot Studio agents require a different approach than custom agents:

| Aspect | Custom app registration | Copilot Studio |
|---|---|---|
| **Who controls the code** | You (the developer) | The Copilot Studio platform |
| **Who created the SP** | You, through the Azure portal or Graph API | Copilot Studio, automatically during agent publishing |
| **Credential management** | You configure FIC, managed identity, or client secrets | Copilot Studio manages credentials on your behalf |
| **Microsoft Entra Agent ID action** | Create blueprint + agent identity through Graph API, update your code | Create a new agent with Microsoft Entra Agent ID integration enabled, then manually reconfigure |
| **Rollback strategy** | Revert code to use old app registration | Keep the legacy agent active until the new agent is fully validated |

Because Copilot Studio manages the identity lifecycle, you can't create a blueprint and agent identity directly as you would for a custom agent. There's no in-place conversion that transforms an existing service principal into an agent identity, and republishing an existing agent doesn't create an agent identity. Instead, you must create a new agent in Copilot Studio with Microsoft Entra Agent ID integration enabled, manually reconfigure all channels and connections, and then decommission the legacy agent.

## Review the process phases

The recreate-and-deprecate process follows four phases, each building on the previous:

| Phase | Goal | Key output |
|---|---|---|
| **Discover** | Inventory all Copilot Studio agent-related service principals in your tenant. | A report or dashboard with identity metadata, agent mapping, sign-in activity, and channel deployments. |
| **Classify** | Categorize each agent by usage level. | A prioritized action plan: which agents to clean up, which to recreate with Microsoft Entra Agent ID, and which to leave as-is. |
| **Recreate** | Create new agents with Microsoft Entra Agent ID integration enabled and manually reconfigure them. | New agents running on Microsoft Entra Agent ID-native agent identities. |
| **Validate and decommission** | Confirm the new agent works end-to-end, then retire the legacy agent and service principal with safeguards. | Legacy service principals removed; agents running fully on Microsoft Entra Agent ID. |

## Phase 1: Discover Copilot Studio agents

Copilot Studio agents leave specific fingerprints on their service principals. Use the following signals to identify them:

- **Tag patterns:** Copilot Studio applies specific tag patterns to service principals during provisioning. The most reliable discovery signal is the `AgentCreatedBy:CopilotStudio` tag. Other consistent tags include `AgenticApp`, `AIAgentBuilder`, `AgenticInstance`, and a `power-virtual-agents-{agent-id}` tag that links the service principal to the specific agent in Copilot Studio.
- **Copilot Studio admin center:** Cross-reference discovered service principals with the **Copilot Studio admin center** to find the associated agent name and ID, last published date, and agent status.

Copilot Studio configures platform-managed credentials (federated identity credentials) on the agent's app registration to authenticate on behalf of the agent. Copilot Studio manages these credentials. You don't need to inspect or manage them directly.

For each Copilot Studio service principal, capture:

- **Identity metadata:** display name, application ID, object ID, creation date.
- **Agent mapping:** the corresponding agent name and ID in Copilot Studio.
- **Last published date:** when the agent was last published or updated.
- **Agent status:** active, inactive, or draft.
- **API permissions:** delegated and application permissions granted.
- **Connection references:** connectors and data sources the agent uses.
- **Channel deployments:** Teams, web chat, or other channels the agent is published to.
- **Downstream dependencies:** any workflows, Power Automate flows, or other resources that depend on the agent's service principal.

You can enrich your discovery with more data sources: Copilot Studio telemetry (agent session counts, last conversation date), Power Platform admin center (environment-level deployment status), and Microsoft 365 usage analytics.

## Phase 2: Classify Copilot Studio agents

Classify each Copilot Studio agent by its usage level to determine the migration approach:

| Usage | Signals | Recommended action |
|---|---|---|
| **Low** | No sign-in activity in 30+ days, no active conversations, agent in draft or unpublished state. | Candidate for cleanup. Decommission the agent and its service principal directly; no migration needed. |
| **Medium** | Some recent conversation activity, noncritical business function, identifiable owner. | Candidate for recreation with Microsoft Entra Agent ID. Proceed through Phase 3 with standard validation. |
| **High** | Active daily conversations, production business workflows dependent on the agent, integrated with Teams or customer-facing channels. | **Don't recreate at this time.** See [Production-critical agents](#production-critical-agents). |

The 30-day sign-in threshold is based on Microsoft Entra's default retention period. If your organization has extended audit log retention (through Microsoft Sentinel or another SIEM), adjust thresholds accordingly.

### Production-critical agents

For Copilot Studio agents with high usage, **don't recreate them until Microsoft provides an official automated migration path**. There's no automated migration path, and the manual recreation process carries significant risk for production agents. Maintain these service principals as-is until an official automated migration path is available.

The risks specific to high-usage Copilot Studio agents include:

- **Channel disruption:** Teams channel configurations, web chat embeddings, and other deployments reference the existing service principal's application ID. Creating a new agent generates a new identity, which requires reconfiguring all channel deployments.
- **Connector re-authorization:** Connection references tied to the old service principal need to be reauthorized with the new Microsoft Entra Agent ID.
- **Flow dependencies:** Power Automate flows and other integrations that reference the agent's service principal break during the transition.
- **No configuration portability:** Agent topics, knowledge sources, and settings must be manually recreated in the new agent.

## Phase 3: Recreate the agent with Microsoft Entra Agent ID

> [!WARNING]
> In-place migration of an existing Copilot Studio service principal to a Microsoft Entra Agent ID-native agent identity isn't supported. You must create a new agent in Copilot Studio with Microsoft Entra Agent ID integration enabled. Configuration, channels, and internal IDs don't carry over automatically.

For **medium-usage** Copilot Studio agents, complete the following seven-step recreation procedure:

### Step 1: Identify the agent

Find the corresponding agent in Copilot Studio for the service principal (SP) that you're replacing. Match the SP's display name and application ID with the agent listing in the **Copilot Studio admin center**.

### Step 2: Document the current configuration

Before making any changes, document:

- All API permissions on the existing SP.
- Connection references and their authorization status.
- Channel deployments (Teams, web chat, and others).
- Power Automate flows or other downstream integrations.
- Any custom connector configurations.

Use this documentation as your checklist to re-establish every item on the new agent.

### Step 3: Enable Microsoft Entra Agent ID integration

Ensure your tenant opts in to Microsoft Entra Agent ID integration for Copilot Studio. Verify this setting in the **Copilot Studio admin center** or through your tenant's feature settings.

### Step 4: Create a new agent with Microsoft Entra Agent ID

In Copilot Studio, create a new agent with the Microsoft Entra Agent ID integration enabled. This new agent receives a native agent identity during provisioning. Recreate the agent's topics, knowledge sources, and configuration to match the legacy agent.

> [!NOTE]
> Republishing or re-registering an existing agent does **not** create a Microsoft Entra agent identity. You must create a new agent to get a Microsoft Entra Agent ID-native agent identity.

### Step 5: Validate the new agent identity

Confirm the new agent identity appears correctly under the **Agents** area in the **Microsoft Entra admin center**. Verify:

- The agent identity is linked to the correct blueprint.
- The display name and metadata match your agent.
- The sponsor (owner) is correctly assigned.

### Step 6: Reconfigure permissions, connections, and channels

Manually configure the new agent to match the legacy agent:

- Assign API permissions.
- Authorize connection references.
- Configure connector access.
- Set up channel deployments (Teams, web chat, and others).
- **Assign the correct owner and sponsor:** creating a new agent defaults the creator as the owner. Review and update ownership to ensure the appropriate individual or group is designated as the agent's sponsor for governance purposes.

> [!IMPORTANT]
> Channel configurations (Teams app manifest, web chat embed codes) reference the agent's application ID. You must update all channel integrations to point to the new agent's identity.

<a name="step-7-monitor"></a>
### Step 7: Monitor the recreated agent in production

Monitor the new agent for **10–14 days** before proceeding to decommission the legacy agent. During this period, verify:

- Agent conversations function correctly.
- All connected data sources respond as expected.
- No authentication errors appear in Microsoft Entra sign-in logs.
- Channel integrations (Teams, web chat) work as expected.

## Phase 4: Validate and decommission

After recreating the agent, validate the new identity end to end and then decommission the legacy service principal using the safeguards in this phase.

<a name="validation-checklist"></a>
### Validate the recreated agent before decommissioning

Use the following checklist to confirm the new agent is functioning correctly before decommissioning the legacy identity.

| Check | How to verify | Expected result |
|---|---|---|
| **Agent conversations** | Send test messages through all configured channels. | Agent responds correctly with no authentication errors. |
| **Connection references** | Trigger actions that use each connected data source. | All data sources return expected results. |
| **Sign-in logs** | **Microsoft Entra admin center** > **Sign-in logs**, filter by the new agent identity. | Sign-in events appear for the new agent identity with successful status. |
| **Audit logs** | **Microsoft Entra admin center** > **Audit logs**. | Agent ID creation events are logged. |
| **Channel deployments** | Test each channel (Teams, web chat, and others). | Agent is reachable and functional on all channels. |
| **Power Automate flows** | Trigger any flows that reference the agent. | Flows execute successfully with the new identity. |

### Parallel run (recommended for medium-usage agents)

Where possible, run the old and new agents side by side before fully cutting over. To run a parallel validation, follow these steps:

1. Keep the old agent published and functional while the new agent with Agent ID is being validated.
1. Direct a subset of users or test channels to the new agent.
1. Monitor both for errors, conversation failures, and permission issues over 10–14 days.
1. Once the new agent is fully validated, proceed to decommission.

### Decommission safeguards

Before decommissioning the legacy SP:

- **Pre-deletion snapshot:** Export the SP's metadata, permissions, and audit history. This export provides a rollback reference if anything was missed.
- **Phased batches:** If you're decommissioning multiple Copilot Studio SPs, delete in small batches (20-50 SPs per wave).
- **Soft-delete first:** Use Microsoft Entra's soft-delete capability (30-day recycle bin) before hard deletion.

<a name="decommission-steps"></a>
### Decommission the legacy agent and service principal

> [!WARNING]
> If you delete the app registration without first unpublishing or deleting the agent in Copilot Studio, the agent's authentication breaks. Always decommission the agent in Copilot Studio before touching the Microsoft Entra identity.

To decommission the legacy service principal, follow these steps:

1. **Unpublish or delete the agent in Copilot Studio.** This step ensures the platform stops authenticating on behalf of the agent.
1. Remove API permissions from the old app registration.
1. Delete or rotate client secrets and certificates on the old app registration.
1. Delete the app registration (enters 30-day soft-delete).
1. After 30 days, confirm permanent deletion or hard-delete if needed.

## Troubleshoot common issues

The following table lists common issues you might encounter during the recreate-and-deprecate process and how to resolve them.

| Symptom | Likely cause | Resolution |
|---|---|---|
| New Agent ID doesn't appear in **Microsoft Entra admin center** after creating the agent | Agent ID integration might not be enabled for your tenant. | Verify tenant opt-in for Agent ID integration. Try creating the agent again. If the issue persists, contact Copilot Studio support. |
| Agent stops responding after switchover | Channel configurations still reference the old SP's application ID. | Update channel configurations to reference the new agent's identity. Check Teams app manifest and web chat embed codes. |
| Connection reference errors | Connectors were authorized against the old SP and need reauthorization with the new identity. | Reauthorize each connection reference in Copilot Studio using the new agent's identity. |
| Power Automate flows fail | Flows reference the old SP's application ID or service principal. | Update flow connections and triggers to use the new agent's identity. |

## Related content

- [Migrate custom app registrations to Agent ID](migrate-custom-app-registrations-to-agent-id.md)
- [Agent identity concepts](key-concepts.md)
- [Create an agent identity blueprint](create-blueprint.md)
- [Best practices for Agent ID](best-practices-agent-id.md)

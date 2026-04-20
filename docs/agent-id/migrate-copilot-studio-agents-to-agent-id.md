---
title: Migrate Copilot Studio agents to Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Learn how to migrate Microsoft Copilot Studio agents from legacy service principals to Microsoft Entra Agent ID for enhanced governance, visibility, and security.
author: Dickson-Mwendia
ms.author: dmwendia
ms.topic: how-to
ms.date: 04/20/2026
ms.custom: agent-id
ai-usage: ai-assisted
#customer intent: As an IT admin or Copilot Studio maker, I want to migrate my Copilot Studio agents from legacy service principals to Microsoft Entra Agent ID so that I can take advantage of agent-specific governance, Conditional Access, and audit capabilities.
---

# Migrate Copilot Studio agents to Agent ID

Microsoft Copilot Studio agents created before Agent ID integration authenticate using service principals that the platform auto-created. These service principals let agents communicate with Azure Bot Service, Microsoft Teams, and Bot Framework skills, but Microsoft Entra treats them like any other application — not as AI agents.

This guide covers how to migrate these platform-managed service principals to Agent ID. Because Copilot Studio manages the agent code, credentials, and deployment lifecycle — not you — the migration approach differs from custom-built agents.

> [!TIP]
> For agents where you own the code and identity configuration, see [Migrate custom app registrations to Agent ID](migrate-custom-app-registrations-to-agent-id.md).

[!INCLUDE [entra-agent-id-preview-note](../includes/entra-agent-id-preview-note.md)]

## Why migrate Copilot Studio agents?

Copilot Studio agents using legacy service principals miss out on the governance capabilities that Agent ID provides. Moving to Agent ID gives you:

[!INCLUDE [migrate-why-agent-id](includes/migrate-why-agent-id.md)]

## Prerequisites

[!INCLUDE [entra-agent-id-license-note](../includes/entra-agent-id-license-note.md)]

Before starting the migration, ensure you have:

- You have one or more Copilot Studio agents that use legacy (pre-Agent ID) service principals.
- You have access to the **Copilot Studio admin center** and the **Microsoft Entra admin center**.
- The required Microsoft Entra roles are assigned: **Agent ID Developer** or **Agent ID Administrator** to manage agent identities.
- Your tenant has opted in to Agent ID integration for Copilot Studio.
- You're familiar with Agent ID key concepts. For more information, see [Agent identity concepts](key-concepts.md).

## How Copilot Studio agents differ from custom agents

Understanding why this migration requires a separate path:

| Aspect | Custom app registration | Copilot Studio |
|---|---|---|
| **Who controls the code** | You (the developer) | The Copilot Studio platform |
| **Who created the SP** | You, through the Azure portal or Graph API | Copilot Studio, automatically during agent publishing |
| **Credential management** | You configure FIC, managed identity, or client secrets | Copilot Studio manages credentials on your behalf |
| **Migration action** | Create blueprint + agent identity through Graph API, update your code | Republish the agent in Copilot Studio to trigger native Agent ID creation |
| **Rollback strategy** | Revert code to use old app registration | Republish with previous configuration |

Because Copilot Studio manages the identity lifecycle, you can't directly create a blueprint and agent identity the way you would for a custom agent. Instead, the platform handles Agent ID creation when you republish the agent with Agent ID integration enabled.

> [!IMPORTANT]
> There's no in-place conversion that transforms an existing service principal into an agent identity. Migration for Copilot Studio agents requires a recreate approach — republishing or re-registering the agent to trigger creation of a new native Agent ID.

## Migration overview

The migration follows four phases, each building on the previous:

| Phase | Goal | Key output |
|---|---|---|
| **Discover** | Inventory all Copilot Studio agent-related service principals in your tenant. | A report or dashboard with identity metadata, agent mapping, sign-in activity, and channel deployments. |
| **Classify** | Categorize each agent by usage level. | A prioritized action plan: which agents to clean up, which to migrate, and which to leave as-is. |
| **Migrate** | Republish agents to trigger native Agent ID creation and reassign permissions. | Agents running on native Agent IDs. |
| **Validate and decommission** | Confirm the new identity works end-to-end, then retire the legacy SP with safeguards. | Legacy SPs removed; agents running fully on Agent ID. |

## Phase 1: Discover Copilot Studio agents

### Identify Copilot Studio service principals

Copilot Studio agents leave specific fingerprints on their service principals. Use these signals to identify them:

- **Tag patterns** — SPs carry specific tag patterns applied by Copilot Studio during provisioning. The most reliable discovery signal is the `AgentCreatedBy:CopilotStudio` tag. Other consistent tags include `AgenticApp`, `AIAgentBuilder`, `AgenticInstance`, and a `power-virtual-agents-{agent-id}` tag linking the SP to the specific agent in Copilot Studio.
- **Copilot Studio admin center** — Cross-reference discovered SPs with the **Copilot Studio admin center** to find the associated agent name/ID, last published date, and agent status.

> [!NOTE]
> Copilot Studio configures platform-managed credentials (federated identity credentials) on the agent's app registration to authenticate on its behalf. These are managed entirely by the platform — you don't need to inspect or manage them directly.

For each Copilot Studio SP, capture:

- **Identity metadata** — display name, application ID, object ID, creation date.
- **Agent mapping** — the corresponding agent name and ID in Copilot Studio.
- **Last published date** — when the agent was last published or updated.
- **Agent status** — active, inactive, or draft.
- **API permissions** — delegated and application permissions granted.
- **Connection references** — connectors and data sources the agent uses.
- **Channel deployments** — Teams, web chat, or other channels the agent is published to.
- **Downstream dependencies** — any workflows, Power Automate flows, or other resources that depend on the agent's SP.

> [!TIP]
> You can enrich your discovery with additional data sources: Copilot Studio telemetry (agent session counts, last conversation date), Power Platform admin center (environment-level deployment status), and Microsoft 365 usage analytics.

### Use the migration toolkit for discovery

The [Microsoft Entra Agent Identity Migration Toolkit](https://github.com/microsoft/entra-agentid-samples/tree/main/migration-toolkit/toolkit) automates discovery of Copilot Studio SPs by scanning for platform-specific tags. It enriches each SP with ownership, permissions, credentials, sign-in activity, and generates an interactive HTML dashboard for review.

## Phase 2: Classify Copilot Studio agents

Classify each Copilot Studio agent by its usage level to determine the migration approach:

| Usage | Signals | Recommended action |
|---|---|---|
| **Low** | No sign-in activity in 30+ days, no active conversations, agent in draft or unpublished state. | Candidate for cleanup. Decommission the agent and its SP directly — no migration needed. |
| **Medium** | Some recent conversation activity, non-critical business function, identifiable owner. | Candidate for migration. Proceed through Phase 3 with standard validation. |
| **High** | Active daily conversations, production business workflows dependent on the agent, integrated with Teams or customer-facing channels. | **Don't migrate at this time.** See [Production-critical agents](#production-critical-agents). |

> [!NOTE]
> The 30-day sign-in threshold is based on Microsoft Entra's default retention period. If your organization has extended audit log retention (through Sentinel or another SIEM), adjust thresholds accordingly.

### Production-critical agents

For Copilot Studio agents with high usage, **don't migrate at this time** without a formal, engineering-supported migration path from the Copilot Studio product team. Maintain these service principals as-is until official guidance is available.

The risks specific to high-usage Copilot Studio agents include:

- **Channel disruption** — Teams channel configurations, web chat embeddings, and other deployments reference the existing SP's application ID. Recreating the agent generates a new identity, which might require reconfiguring all channel deployments.
- **Connector re-authorization** — Connection references tied to the old SP might need to be re-authorized with the new Agent ID.
- **Flow dependencies** — Power Automate flows and other integrations that reference the agent's SP might break during the transition.

## Phase 3: Migrate

> [!WARNING]
> In-place, seamless migration of an existing Copilot Studio service principal to a native Agent ID isn't possible without some degree of impact or agent reconfiguration. Plan for a recreate approach.

For **medium-usage** Copilot Studio agents, follow these steps:

### Step 1: Identify the agent

Locate the corresponding agent in Copilot Studio for the SP being migrated. Match the SP's display name and application ID with the agent listing in the **Copilot Studio admin center**.

### Step 2: Document the current configuration

Before making any changes, document:

- All API permissions on the existing SP.
- Connection references and their authorization status.
- Channel deployments (Teams, web chat, and others).
- Power Automate flows or other downstream integrations.
- Any custom connector configurations.

This documentation serves as your migration checklist — every item must be re-established on the new Agent ID.

### Step 3: Enable Agent ID integration

Ensure your tenant has opted in to Agent ID integration for Copilot Studio. Verify this in the **Copilot Studio admin center** or through your tenant's feature settings.

### Step 4: Republish the agent

In Copilot Studio, republish or re-register the agent to trigger creation of a new native Agent ID.

> [!NOTE]
> Capability availability for this step is pending confirmation from the Copilot Studio product team. Check the [Copilot Studio release notes](/microsoft-copilot-studio/whats-new) for the latest status.

### Step 5: Validate the new Agent ID

Confirm the new Agent ID appears correctly under the **Agent ID** blade in the **Microsoft Entra admin center**. Verify:

- The agent identity is linked to the correct blueprint.
- The display name and metadata match your agent.
- The sponsor (owner) is correctly assigned.

### Step 6: Reassign permissions, connections, and ownership

Transfer all configurations from the old SP to the new Agent ID:

- Reassign API permissions.
- Re-authorize connection references.
- Update any connector access.
- Reconfigure channel deployments if required.
- **Assign the correct owner and sponsor** — republishing defaults the agent creator as the owner. Review and update ownership to ensure the appropriate individual or group is designated as the agent's sponsor for governance purposes.

### Step 7: Monitor

Monitor the agent for **10–14 days** before proceeding to decommission the legacy SP. During this period, verify:

- Agent conversations function correctly.
- All connected data sources respond as expected.
- No authentication errors appear in Microsoft Entra sign-in logs.
- Channel integrations (Teams, web chat) work as expected.

## Phase 4: Validate and decommission

### Validation checklist

| Check | How to verify | Expected result |
|---|---|---|
| **Agent conversations** | Send test messages through all configured channels. | Agent responds correctly with no authentication errors. |
| **Connection references** | Trigger actions that use each connected data source. | All data sources return expected results. |
| **Sign-in logs** | **Microsoft Entra admin center** > **Sign-in logs**, filter by the new agent identity. | Sign-in events appear for the new agent identity with successful status. |
| **Audit logs** | **Microsoft Entra admin center** > **Audit logs**. | Agent ID creation events are logged. |
| **Channel deployments** | Test each channel (Teams, web chat, and others). | Agent is reachable and functional on all channels. |
| **Power Automate flows** | Trigger any flows that reference the agent. | Flows execute successfully with the new identity. |

### Parallel run (recommended for medium-usage agents)

Where possible, run the old and new identities side by side before fully cutting over:

1. Keep the old agent published and functional while the new Agent ID is being validated.
1. Direct a subset of users or test channels to the republished agent with the new Agent ID.
1. Monitor both for errors, conversation failures, and permission issues over 10–14 days.
1. Once the new identity is fully validated, proceed to decommission.

### Decommission safeguards

Before decommissioning the legacy SP:

- **Pre-deletion snapshot** — Export the SP's metadata, permissions, and audit history. This export provides a rollback reference if anything was missed.
- **Phased batches** — If you're decommissioning multiple Copilot Studio SPs, delete in small batches (20–50 SPs per wave).
- **Soft-delete first** — Use Microsoft Entra's soft-delete capability (30-day recycle bin) before hard deletion.

### Decommission steps

> [!WARNING]
> Deleting the app registration without first unpublishing or deleting the agent in Copilot Studio causes the agent's authentication to break. Always decommission the agent in Copilot Studio before touching the Microsoft Entra identity.

1. **Unpublish or delete the agent in Copilot Studio** — this step ensures the platform stops authenticating on behalf of the agent.
1. Remove API permissions from the old app registration.
1. Delete or rotate client secrets and certificates on the old app registration.
1. Delete the app registration (enters 30-day soft-delete).
1. After 30 days, confirm permanent deletion or hard-delete if needed.

## Troubleshooting

| Symptom | Likely cause | Resolution |
|---|---|---|
| New Agent ID doesn't appear in **Microsoft Entra admin center** after republishing | Agent ID integration might not be enabled for your tenant, or the republish didn't trigger Agent ID creation. | Verify tenant opt-in for Agent ID integration. Try republishing again. If the issue persists, contact Copilot Studio support. |
| Agent stops responding after migration | Channel configurations still reference the old SP's application ID. | Update channel configurations to reference the new Agent ID. Check Teams app manifest and web chat embed codes. |
| Connection reference errors | Connectors were authorized against the old SP and need re-authorization with the new identity. | Re-authorize each connection reference in Copilot Studio using the new Agent ID. |
| Power Automate flows fail | Flows reference the old SP's application ID or service principal. | Update flow connections and triggers to use the new Agent ID. |

## Related content

- [Migrate custom app registrations to Agent ID](migrate-custom-app-registrations-to-agent-id.md)
- [Agent identity concepts](key-concepts.md)
- [Create an agent identity blueprint](create-blueprint.md)
- [Best practices for Agent ID](best-practices-agent-id.md)
- [Microsoft Entra Agent Identity Migration Toolkit](https://github.com/microsoft/entra-agentid-samples/tree/main/migration-toolkit/toolkit)

---
title: Migrate custom app registrations to Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Learn how to migrate AI agents that use standard Microsoft Entra app registrations or service principals to Microsoft Entra Agent ID for enhanced governance, visibility, and security.
author: Dickson-Mwendia
ms.author: dmwendia
ms.topic: how-to
ms.date: 04/20/2026
ms.custom: agent-id
ai-usage: ai-assisted
#customer intent: As a developer or IT admin who built AI agents using standard app registrations, I want to migrate them to Microsoft Entra Agent ID so that I can take advantage of agent-specific governance, Conditional Access, and audit capabilities.
---

# Migrate custom app registrations to Agent ID

Microsoft Entra Agent ID provides specialized identity constructs that enable secure authentication and authorization patterns for AI agents. Agent identity blueprints serve as governance templates, and agent identities are the runtime principals your agents use to authenticate, acquire tokens, and access resources. These constructs address the requirements of autonomous AI systems that differ from traditional user and application identities.

This guide walks you through migrating agents that authenticate using standard Microsoft Entra app registrations or service principals — where you own the code and the identity configuration — to Agent ID.

> [!TIP]
> For agents created through Microsoft Copilot Studio, see [Migrate Copilot Studio agents to Agent ID](migrate-copilot-studio-agents-to-agent-id.md).

[!INCLUDE [entra-agent-id-preview-note](../includes/entra-agent-id-preview-note.md)]

## Why migrate to Agent ID?

If you built AI agents before Agent ID was available, your agents are likely using Microsoft Entra app registrations or service principals for authentication. While these identities let agents communicate with services like Azure Bot Service, Microsoft Teams, and Bot Framework skills, Microsoft Entra treats them like any other application. They don't take advantage of the governance capabilities that Agent ID provides.

[!INCLUDE [migrate-why-agent-id](includes/migrate-why-agent-id.md)]

## Prerequisites

[!INCLUDE [entra-agent-id-license-note](../includes/entra-agent-id-license-note.md)]

Before starting the migration, ensure you have:

- An existing AI agent that uses an app registration or service principal for authentication.
- The required Microsoft Entra roles are assigned: **Agent ID Developer** or **Agent ID Administrator** to create blueprints and agent identities, and **Privileged Role Administrator** to grant Microsoft Graph application permissions.
- You have access to the Microsoft Graph v1.0 API.
- You're familiar with Agent ID key concepts. For more information, see [Agent identity concepts](key-concepts.md).

## How to migrate to agent identities

Migrating to Agent ID is a structured adoption journey, not a single-step switch. This guide organizes the process into four phases, each building on the outputs of the previous one. The phased model prevents premature deletion of service principals that might support active workloads. Proper discovery and classification occur before any migration or decommission action.

| Phase | Goal | Key output |
|---|---|---|
| **Discover** | Inventory all agent-related identities in your tenant — service principals, app registrations, and their usage signals. | A structured report or dashboard with identity metadata, sign-in activity, permissions, ownership, and builder origin for each agent. |
| **Classify** | Categorize each identity by usage level and origin. | A prioritized action plan: which identities to clean up, which to migrate, and which to leave as-is. |
| **Migrate** | Create Agent ID resources (blueprint + agent identity) and update your agents to use them. | New agent identities running on Agent ID with matching permissions and credentials. |
| **Validate and decommission** | Confirm the new identity works end-to-end, parallel-run if needed, then retire the legacy identity with safeguards. | Legacy identities removed; agents running fully on Agent ID. |

## Phase 1: Discover

Before migrating anything, build a complete inventory of the agent-related identities in your tenant. Start with an organization-wide sweep to find all migration candidates, then narrow down to individual agents to capture the configuration details you need during migration.

### Organization-level inventory

Scan your tenant for all service principals that might represent AI agents. The goal is to create a structured report that surfaces usage signals and helps you classify each identity in the next phase.

For each candidate service principal, capture:

- **Identity metadata** — display name, application ID, object ID, creation date, tenant.
- **Ownership** — assigned owner(s), owning team or department (where available).
- **Sign-in activity** — last interactive and non-interactive sign-in, sign-in count over 30/90/180 days.
- **Audit log signals** — source system that created the SP, creation event, recent modifications or permission changes.
- **Tag analysis** — tags applied to the SP; check whether it carries any builder-specific tag patterns.
- **API permissions** — delegated and application permissions granted, admin consent status, permission sensitivity level.
- **Other identity configurations** — credentials used, OAuth flows, custom attributes, RBAC role assignments, redirect URIs, and any downstream dependencies. You need this information during migration to correctly recreate the identity as an Agent ID.

> [!TIP]
> You can pull most of these configuration details programmatically using Microsoft Graph. Use the `GET /applications` and `GET /servicePrincipals` endpoints to pull permissions, credentials, ownership, and more. For OAuth flows your application uses and any downstream dependencies, check your application code.

### Heuristic discovery (log and permission analysis)

For service principals that carry no tags, use behavioral and configuration signals to identify likely agent identities. No single signal is definitive — weight them in combination to produce a confidence score.

| Signal category | What to look for | Why it indicates an agent |
|---|---|---|
| **API permissions** | Application permissions targeting Bot Framework, Azure OpenAI, Azure AI Services, or Cognitive Services APIs. | Agents require these APIs to function; traditional applications rarely request them together. |
| **Redirect URIs** | URIs pointing to `token.botframework.com`, `botframework.com`, or Azure Bot Service endpoints. | These are Bot Framework callback URLs used exclusively by conversational agents. |
| **Sign-in patterns** | Non-interactive or service principal sign-ins with high frequency and no associated user context. | Agents authenticate autonomously; human-facing apps typically have interactive sign-in activity. |
| **Token audience** | Tokens requested for `https://api.botframework.com`, Azure OpenAI endpoints, or AI Services endpoints. | The token audience reveals what resource the SP is calling. |
| **Resource group association** | SP linked to a resource group containing Bot Service, Azure OpenAI, or AI Search resources. | Co-location with AI infrastructure suggests the SP serves an agent workload. |
| **Naming conventions** | Display names containing terms like `agent`, `bot`, `copilot`, `assistant`, or `orchestrator`. | While not deterministic, naming patterns correlate strongly with agent workloads when combined with other signals. |

To operationalize heuristic discovery, query service principal sign-in logs and permission grants programmatically using Microsoft Graph. For tenants with extended log retention (through Microsoft Sentinel or another SIEM), expand the analysis window beyond Microsoft Entra's default 30-day sign-in retention to improve signal accuracy.

> [!IMPORTANT]
> Heuristic discovery produces candidates, not confirmed agents. Review every match before proceeding to classification. False positives — such as backend microservices that call Azure OpenAI but aren't autonomous agents — are common and expected.

### Organizational discovery

Automated methods won't find every agent. Custom-built agents that use generic API permissions and have no naming convention overlap are invisible to both tag-based and heuristic scanning. Close this gap with organizational input.

**CMDB and asset inventory reconciliation**

Cross-reference your discovered service principals against your organization's Configuration Management Database or application portfolio registry. Applications registered as "AI agent," "chatbot," or "virtual assistant" workload types in the CMDB should be matched to their corresponding service principals and added to the migration inventory.

**Developer self-attestation**

For tenants with large numbers of app registrations, publish the migration inventory to application owners and ask them to attest whether their service principal represents an AI agent. This approach scales discovery beyond what any automated scan can achieve, because the application owner has definitive knowledge of the workload type. Combine self-attestation with a deadline and escalation path to drive completion.

### Recommended discovery sequence

Run these methods in order:

1. **Tag-based scan** — Identify all tagged agents automatically. These are confirmed candidates.
1. **Heuristic analysis** — Scan remaining untagged service principals for behavioral signals. Flag high-confidence matches as probable candidates.
1. **CMDB reconciliation** — Match remaining service principals against your asset inventory to catch agents registered under non-obvious names.
1. **Developer attestation** — Publish the residual unmatched list to application owners for final classification.

## Phase 2: Classify

Using the discovery report, classify each service principal by usage level, which determines how you proceed with the migration.

| Usage | Signals | Recommended action |
|---|---|---|
| **Low** | No sign-in activity in 30+ days, no owner assigned, no API permissions in active use. | Candidate for cleanup. Skip migration — decommission directly (Phase 4). |
| **Medium** | Some recent sign-in activity, non-production permissions, identifiable owner. | Candidate for migration. Proceed through Phases 3–4 with standard validation. |
| **High** | Frequent sign-ins, production API permissions, active workflows dependent on the SP. | Migrate with extreme caution. Requires extended parallel run (Phase 4), rollback plan, and stakeholder sign-off. |

> [!NOTE]
> The 30-day sign-in threshold is based on Microsoft Entra's default retention period. If your organization has extended audit log retention (through Sentinel or another SIEM), adjust thresholds accordingly.

## Phase 3: Migrate

This phase covers the technical migration steps for agents where you own the code and the identity was created as a standard app registration or service principal. You create new Agent ID resources and update your application code to use the two-stage token acquisition model.

Steps 1 through 3 target the Microsoft Entra tenant. Step 4 targets changes to your application code.

> [!IMPORTANT]
> There's no in-place conversion that transforms an existing app registration or service principal into an agent identity. Migration requires creating a new agent identity alongside your existing identity, then transitioning your agent to use it.

### Step 1: Create an agent identity blueprint

> [!NOTE]
> **Required Microsoft Entra roles:** Agent ID Developer or Agent ID Administrator to create blueprints and agent identities, and Privileged Role Administrator to grant Microsoft Graph application permissions.

The blueprint is the governance template for your agent. It defines credentials and permission policies that all agent identities created under it inherit.

Create the blueprint using Microsoft Graph:

```http
POST https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint
Content-Type: application/json

{
    "@odata.type": "Microsoft.Graph.AgentIdentityBlueprint",
    "displayName": "My Agent Blueprint",
    "sponsors@odata.bind": [
        "https://graph.microsoft.com/v1.0/users/<sponsor-user-id>"
    ],
    "owners@odata.bind": [
        "https://graph.microsoft.com/v1.0/users/<owner-user-id>"
    ]
}
```

Or using PowerShell:

```powershell
$body = @{
    "@odata.type" = "Microsoft.Graph.AgentIdentityBlueprint"
    "displayName" = "My Agent Blueprint"
    "sponsors@odata.bind" = @("https://graph.microsoft.com/v1.0/users/<sponsor-user-id>")
    "owners@odata.bind" = @("https://graph.microsoft.com/v1.0/users/<owner-user-id>")
} | ConvertTo-Json -Depth 5

Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint" `
    -Body $body `
    -ContentType "application/json"
```

> [!IMPORTANT]
> You create credentials on your blueprint, not on individual agent identities. Configure the federated identity credential on the blueprint before creating agent identities.

#### Configure credentials on the blueprint

Agent ID uses federated identity credentials (FIC) as the recommended credential type. Managed identities are the preferred option for production deployments because they eliminate secret management. Client secrets and certificates are supported but are recommended only for local development and testing.

The recommended credentials depend on your hosting environment:

| Hosting environment | Recommended credential | Notes |
|---|---|---|
| Azure (App Service, AKS, Container Apps, VMs) | User-assigned managed identity | Most secure for production. No secret management required. |
| Non-Azure cloud (AWS, GCP) | Federated identity credential with external IDP | Configure workload identity federation with your cloud provider. |
| Local development | Client credentials/certificate for testing only | Use for local testing only. |

Create the blueprint service principal:

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals
Content-Type: application/json

{
    "appId": "<blueprint-app-id>"
}
```

### Step 2: Create the agent identity

The agent identity is the runtime principal your agent uses. It's created under a blueprint and must have a **sponsor** — a human user or group accountable for the agent.

```http
POST https://graph.microsoft.com/beta/serviceprincipals/Microsoft.Graph.AgentIdentity
OData-Version: 4.0
Content-Type: application/json

{
    "displayName": "Customer Service Agent - Production",
    "agentIdentityBlueprintId": "<blueprint-app-id>",
    "sponsors@odata.bind": [
        "https://graph.microsoft.com/v1.0/users/<sponsor-user-id>"
    ]
}
```

> [!NOTE]
> Record the agent identity's client ID from the response. You need this value when updating your application code.

### Step 3: Configure permissions

Replicate the API permissions from your original app registration onto the agent identity. You have two options:

- **Direct assignment** — Assign permissions directly to the agent identity. Use this option when each agent identity needs different permissions.
- **Inherited permissions** — Configure permissions on the blueprint and enable inheritance. Use this option when all agent identities under a blueprint share the same permissions.

For Azure RBAC role assignments, assign the new agent identity's service principal to the same roles:

```powershell
New-AzRoleAssignment `
    -ObjectId "<agent-identity-service-principal-id>" `
    -RoleDefinitionName "Contributor" `
    -Scope "/subscriptions/<sub-id>/resourceGroups/<rg-name>"
```

### Step 4: Update application code

Agent ID uses a two-stage token acquisition model. Your agent first acquires a bootstrap token using the blueprint's credential, then exchanges it for an agent-specific token. For more guidance on updating your code, see these scenarios:

- [Autonomous agent authentication and authorization flow](autonomous-agent-authentication-authorization-flow.md) for the complete token acquisition walkthrough.
- [Interactive agent authentication and authorization flow](interactive-agent-authentication-authorization-flow.md) for interactive agents guidance, code samples, and token configuration. The token flow in these agents adds an OBO exchange where a user token is exchanged for an agent token with user context.

## Phase 4: Validate and decommission

After migrating an agent identity, validate that the new Agent ID works correctly before decommissioning the old identity.

### Validation checklist

| Check | How to verify | Expected result |
|---|---|---|
| **Token acquisition** | Run your agent and inspect the token response. | Agent successfully acquires tokens using the two-stage flow. No authentication errors. |
| **API access** | Exercise all API calls the agent makes. | All downstream APIs return expected results. No 401/403 errors. |
| **Sign-in logs** | **Microsoft Entra admin center** > **Sign-in logs**, filter by the new agent identity. | Sign-in events appear for the new agent identity with successful status. |
| **Audit logs** | **Microsoft Entra admin center** > **Audit logs**. | Agent ID creation and permission assignment events are logged. |
| **Conditional Access** | Review CA policies that target the resource. | CA policies evaluate correctly for the new agent identity. No unexpected blocks. |

### Parallel run

For agents with high usage, run the old and new identities side by side before cutting over:

1. Deploy a parallel instance of your agent configured with the new Agent ID.
1. Route a percentage of traffic to the new instance (start with 5–10%).
1. Monitor both instances for errors, latency differences, and permission issues.
1. Gradually increase traffic to the new instance over 1–2 weeks.
1. Once 100% of traffic runs on the new identity, proceed to decommission.

> [!TIP]
> Use feature flags or traffic-splitting infrastructure to control the rollout. This approach lets you revert to the old identity instantly if issues arise.

### Decommission safeguards

Once the new Agent ID is validated and carrying production traffic, decommission the old identity. Follow these safeguards to minimize risk:

- **Pre-deletion snapshot** — Export the SP's metadata, permissions, and audit history before deletion. This export provides a rollback reference if anything was missed during validation.
- **Phased batches** — If you're decommissioning multiple identities, delete in small batches (20–50 SPs per wave) rather than bulk-deleting all at once.
- **Soft-delete first** — Use Microsoft Entra's soft-delete capability (30-day recycle bin for applications) before hard deletion. This gives you a recovery window.

### Decommission steps

1. Remove API permissions from the old app registration.
1. Revoke Azure RBAC role assignments for the old service principal.
1. Delete or rotate client secrets and certificates on the old app registration.
1. Delete the app registration (enters 30-day soft-delete).
1. After 30 days, confirm the app registration has been permanently deleted or hard-delete if needed.

## Troubleshooting

| Symptom | Likely cause | Resolution |
|---|---|---|
| Token exchange fails with `invalid_grant` | The federated identity credential on the blueprint is misconfigured or the managed identity isn't correctly linked. | Verify the FIC subject, issuer, and audience match your hosting environment. Check that the managed identity has the correct assignment. |
| Audience mismatch error | The token request specifies the wrong audience or the blueprint audience doesn't match the target resource. | Ensure the token request audience matches the resource you're calling. For Microsoft Graph, use `https://graph.microsoft.com/.default`. |
| `403 Forbidden` on API calls | API permissions weren't correctly replicated from the old app registration to the agent identity. | Compare the permissions on both identities. Ensure admin consent was granted for application permissions. |
| OBO flow fails | The agent identity isn't configured for delegated permissions, or the user token doesn't include the required scopes. | Verify delegated permissions are assigned. Check that the user token includes the scopes your agent needs for the OBO exchange. |
| `400 Bad Request: Object not found` (after creating blueprint) | Read-after-write consistency delay. The blueprint or agent identity isn't yet available for subsequent API calls. | Wait 30–60 seconds after creating the blueprint before creating agent identities or service principals. Implement retry logic with exponential backoff. |
| Agent ID not visible in **Microsoft Entra admin center** | Agent identities created through the API might take a few minutes to appear in the portal. | Wait and refresh. If the identity still doesn't appear, verify it was created successfully through the Graph API. |

## Related content

- [Migrate Copilot Studio agents to Agent ID](migrate-copilot-studio-agents-to-agent-id.md)
- [Agent identity concepts](key-concepts.md)
- [Create an agent identity blueprint](create-blueprint.md)
- [Create and delete agent identities](create-delete-agent-identities.md)
- [Best practices for Agent ID](best-practices-agent-id.md)

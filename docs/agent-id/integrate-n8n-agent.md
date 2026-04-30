---
title: Secure an n8n agent with Microsoft Entra Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Learn how to deploy n8n on Azure Container Apps and secure AI agent workflows with Microsoft Entra Agent ID and Microsoft Graph MCP Server for Enterprise.
ms.service: entra
ms.topic: how-to
ms.date: 04/30/2026
author: Dickson-Mwendia
ms.author: dmwendia
ms.reviewer: astaykov
ms.custom: agent-id

#customer intent: As a developer or IT admin, I want to secure n8n workflows with Microsoft Entra Agent ID so that my n8n agents can access Microsoft Graph and MCP Server for Enterprise using agent identities.

---

# Secure an n8n agent with Microsoft Entra Agent ID

This guide walks you through deploying [n8n](https://n8n.io/) on Azure Container Apps with Microsoft Entra Agent ID integration. The deployment uses the Azure Developer CLI (`azd`) for a single-command setup that provisions infrastructure, creates Entra identity objects, and configures n8n workflows automatically.

Unlike the sidecar pattern used for custom agents, this integration uses the [n8n-nodes-entraagentid](https://www.npmjs.com/package/@astaykov/n8n-nodes-entraagentid) community node to manage token acquisition directly within n8n workflows. The deployed workflows demonstrate both autonomous (app-only) and on-behalf-of (OBO) token flows, with access to Microsoft Graph and the [Microsoft Graph MCP Server for Enterprise](https://mcp.svc.cloud.microsoft/enterprise).

> [!NOTE]
> This sample demonstrates the use of the `n8n-nodes-entraagentid` community node within n8n. It isn't guidance for deploying n8n on Azure in production.

## Prerequisites

Before you begin, make sure you have:

- An Azure subscription with quota for Azure OpenAI (GPT-4o or similar), PostgreSQL Flexible Server, and Azure Container Apps.
- **Global Administrator** role in your Microsoft Entra tenant. This role is required because the automation creates multiple Entra objects and grants admin consent to permissions. Use [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) to activate this role just-in-time.

**Azure Cloud Shell** (recommended) comes with everything preinstalled: Azure CLI, Azure Developer CLI (`azd`), PowerShell 7, and Git.

If you're running locally instead of Cloud Shell, install these tools before proceeding:

- [Azure Developer CLI (`azd`)](/azure/developer/azure-developer-cli/install-azd) v1.9 or later.
- [Azure CLI (`az`)](/cli/azure/install-azure-cli) v2.60 or later.
- [PowerShell 7.4+](/powershell/scripting/install/installing-powershell).
- Git.

Sign in to both tools before running the deployment:

```bash
az login
azd auth login
```

## Clone and deploy

The entire deployment runs through a single `azd up` command that provisions Azure infrastructure and configures n8n automatically.

1. Open [Azure Cloud Shell](https://shell.azure.com) and select **PowerShell**.

1. Clone the repository and start the deployment:

   ```bash
   git clone https://github.com/astaykov/n8n-aca.git && cd n8n-aca && azd auth login && azd up
   ```

   > [!NOTE]
   > In Azure Cloud Shell, `azd auth login` displays a device code. Open the URL shown and enter the code to authenticate, then `azd up` continues automatically.

1. When prompted, provide the following values:

   - **Environment name:** Any name (for example, `my-n8n`). Used to isolate this deployment.
   - **Azure subscription:** Select the subscription to deploy into.
   - **Azure location:** Select a region (for example, `northeurope`).
   - **n8n admin email:** Email for the n8n owner account.
   - **n8n admin password:** Password for the n8n owner account (minimum 8 characters, mixed case, number).

1. During the postprovision phase, the automation performs a second sign-in. A device code is displayed, open the URL and enter the code. This step requires Global Administrator or Application Administrator role.

   The postprovision hook then:
   - Creates Microsoft Entra Agent ID objects (Blueprint, Agent Identity, Agent User).
   - Enables the Microsoft Graph MCP Server for Enterprise.
   - Waits for n8n to become ready.
   - Creates the owner account.
   - Installs the `@astaykov/n8n-nodes-entraagentid` community node.
   - Creates all credentials with real values.
   - Imports and activates the demo workflows.

When the deployment completes, the script prints your n8n URL and a summary of what was configured.

## Explore the deployed resources

### Azure infrastructure

The deployment creates the following Azure resources:

- **Container Apps Environment:** Hosts n8n and the test SPA.
- **n8n Container App:** Runs the official `n8nio/n8n` image with HTTPS ingress.
- **Static Web App:** Test SPA for the OBO webhook flow.
- **PostgreSQL Flexible Server:** Persistent store for workflows, credentials, and execution history (Burstable B1ms).
- **Storage Account and File Share:** Persistent `/home/node/.n8n` directory. Community nodes and configuration survive restarts.
- **Azure OpenAI:** GPT model deployment used by the AI agent workflows.
- **Log Analytics Workspace:** Diagnostics and monitoring.

### Entra identity objects

The automation creates these objects once and reuses them on subsequent runs:

- **Agent Identity Blueprint:** App registration that issues tokens on behalf of Agent Identities via Federated Identity Credentials.
- **Agent Identity service principal:** The AI agent's service principal. Acquires Microsoft Graph and MCP tokens autonomously.
- **Agent User:** A cloud-only user identity that enables delegated (OBO) token flows.
- **SPA app registration:** Client app for the webhook demo, preconfigured with redirect URIs and Blueprint API permissions.

### n8n credentials and workflows

The postprovision hook configures n8n automatically:

**Credentials created:**

- **EntraAgentID - Autonomous:** App-only Microsoft Graph API token (no user context).
- **EntraAgentID - Agent User OBO:** Delegated token on behalf of the Agent User.
- **Azure OpenAI:** Connection to the deployed GPT model for AI agent workflows.
- **AgentID Auth Manager - Access Token:** Token forwarding from the Auth Manager to downstream nodes.
- **Bearer from AuthManager:** Bearer token forwarding for MCP calls.

**Workflows imported:**

- **Agent ID Auth Manager - Agent User with MCP Enterprise:** Acquires a delegated MCP token for the Agent User and forwards it to a subworkflow.
- **HTTP Request with autonomous agent token:** Demonstrates an autonomous agent calling Microsoft Graph directly with an app-only token.
- **Webhook - assistive agent (on-behalf-of):** Webhook entry point that receives a bearer token from the SPA, calls the Auth Manager, and responds via the Graph MCP Server on behalf of the signed-in user.

## Deploy the test SPA (optional)

The test SPA is a static JavaScript app that demonstrates the OBO webhook flow from a browser.

1. Deploy it after the initial provisioning completes:

   ```bash
   azd deploy spa
   ```

## Understand the MCP Server scopes

The setup grants the following delegated `MCP.*` scopes to the Agent Identity service principal. These scopes mirror their Microsoft Graph counterparts (for example, `MCP.User.Read.All` corresponds to `User.Read.All`):

- `MCP.User.Read.All`: Read all users.
- `MCP.Organization.Read.All`: Read tenant organization info.
- `MCP.Group.Read.All`: Read all groups.
- `MCP.GroupMember.Read.All`: Read group memberships.
- `MCP.Application.Read.All`: Read app registrations and service principals.
- `MCP.AuditLog.Read.All`: Read sign-in and audit logs.
- `MCP.Reports.Read.All`: Read Microsoft 365 usage reports.
- `MCP.Policy.Read.All`: Read conditional access policies.
- `MCP.Domain.Read.All`: Read verified domains.
- `MCP.Device.Read.All`: Read Entra-registered devices.

To add more scopes, edit the `$MCP_SCOPES` array in `scripts/Setup-EntraAgentId.ps1` and rerun `azd provision`.

> [!NOTE]
> The MCP Server only supports delegated permission flows. Use the autonomous credential for app-only Microsoft Graph calls.

## Rerun and update the deployment

The deployment is fully idempotent:

- Azure resources that already exist are skipped by Bicep.
- Entra object IDs (Blueprint, Agent Identity, Agent User, Blueprint secret) are saved to the `azd` environment after the first run and reused on subsequent runs.
- n8n configuration (credentials, workflows) is applied fresh each run, which allows repairing a broken state.

To rerun just the postprovision scripts without modifying infrastructure:

```bash
azd provision
```

## Run the scripts manually (optional)

You can run the configuration scripts independently if needed:

- **Full end-to-end (Entra and n8n):**

  ```powershell
  .\scripts\Run-All.ps1 `
      -TenantId  "<your-tenant-id>" `
      -N8nUrl    "https://ca-n8n-<token>.<region>.azurecontainerapps.io"
  ```

- **n8n configuration only (skip Entra setup):**

  ```powershell
  .\scripts\Configure-N8n.ps1 `
      -N8nUrl          "https://ca-n8n-<token>.<region>.azurecontainerapps.io" `
      -OwnerEmail      "admin@contoso.com" `
      -OwnerPassword   "MyStr0ngPassword!"
  ```

- **Entra setup only:**

  ```powershell
  .\scripts\Setup-EntraAgentId.ps1 `
      -TenantId  "<your-tenant-id>" `
      -N8nUrl    "https://ca-n8n-<token>.<region>.azurecontainerapps.io"
  ```

## Estimate costs

| Resource | Configuration | Estimated monthly cost |
|---|---|---|
| n8n Container App | 1 vCore, 2 GiB | ~$15 |
| Static Web App | Free tier | $0 |
| PostgreSQL Flexible Server | Burstable B1ms | ~$12 |
| Azure OpenAI | Pay-per-token (GPT-4o) | Varies |
| Storage Account | LRS, less than 1 GB | ~$1 |
| Log Analytics | Pay-as-you-go | ~$2 |
| **Total (excluding OpenAI)** | | **~$30/month** |

## Clean up resources

Remove all Azure resources created by the deployment:

```bash
azd down --purge
```

The `azd down` command removes Azure resources but doesn't delete Entra objects such as blueprints, agent identities, or agernt user accounts. Remove these manually in the Microsoft Entra admin if they're no longer needed.

## Related content

- [Integrate third-party agents with Microsoft Entra Agent ID](configure-third-party-agents.md)
- [Authentication with Microsoft Entra Auth SDK (sidecar)](authentication-with-auth-sdk-sidecar.md)
- [n8n-nodes-entraagentid community node](https://www.npmjs.com/package/@astaykov/n8n-nodes-entraagentid)
- [Azure Developer CLI overview](/azure/developer/azure-developer-cli/overview)

---
title: Secure an n8n agent with Microsoft Entra Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Deploy n8n on Azure Container Apps and secure AI agent workflows with Microsoft Entra Agent ID and Microsoft Graph MCP Server for Enterprise.
ms.service: entra
ms.topic: how-to
ms.date: 04/30/2026
ms.reviewer: astaykov
ms.custom: agent-id, msecd-doc-authoring-1012

#customer intent: As a developer or IT admin, I want to secure n8n workflows with Microsoft Entra Agent ID so that my n8n agents can access Microsoft Graph and MCP Server for Enterprise using agent identities.

---

# Secure an n8n agent with Microsoft Entra Agent ID

This guide shows how to deploy [n8n](https://n8n.io/) on Azure Container Apps with Microsoft Entra Agent ID integration. The deployment uses the Azure Developer CLI (`azd`) to provision infrastructure, create Microsoft Entra identity objects, and configure n8n workflows automatically.

Unlike the [sidecar pattern](authentication-with-auth-sdk-sidecar.md) used for custom agents, this integration uses the [n8n-nodes-entraagentid](https://www.npmjs.com/package/@astaykov/n8n-nodes-entraagentid) community node to manage token acquisition directly within n8n workflows. The deployed workflows demonstrate both autonomous (app-only) and on-behalf-of (OBO) token flows, with access to Microsoft Graph and the Microsoft Graph MCP Server for Enterprise, `https://mcp.svc.cloud.microsoft/enterprise`.

> [!NOTE]
> This sample demonstrates the use of the `n8n-nodes-entraagentid` community node within n8n. It isn't guidance for deploying n8n on Azure in production.

## Prerequisites

Before you begin, make sure you have:

- An Azure subscription with quota for Azure OpenAI (GPT-4o or similar), PostgreSQL Flexible Server, and Azure Container Apps.
- **Global Administrator** role in your Microsoft Entra tenant. This role is required because the automation creates multiple Microsoft Entra objects and grants admin consent to permissions. Use [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) to activate this role just-in-time.

**Azure Cloud Shell** (recommended) comes with everything preinstalled: Azure CLI, Azure Developer CLI (`azd`), PowerShell 7, and Git.

If you're running locally instead of Cloud Shell, install these tools before proceeding:

- [Azure Developer CLI (`azd`)](/azure/developer/azure-developer-cli/install-azd) v1.9 or later.
- [Azure CLI (`az`)](/cli/azure/install-azure-cli) v2.60 or later.
- [PowerShell 7.4+](/powershell/scripting/install/installing-powershell).
- [Microsoft.Entra PowerShell module](/powershell/entra-powershell/) v1.2 or later.
- Git.

Sign in to Azure CLI and Azure Developer CLI before running the deployment:

```bash
az login
azd auth login
```

## Clone and deploy

The entire deployment runs through a single `azd up` command that provisions Azure infrastructure and configures n8n automatically. Follow these steps to deploy n8n:

1. Open [Azure Cloud Shell](https://shell.azure.com) and select **PowerShell**.

1. Clone the repository and start the deployment:

   ```bash
   git clone https://github.com/astaykov/n8n-aca.git && cd n8n-aca && azd auth login && azd up
   ```

   In Azure Cloud Shell, `azd auth login` displays a device code. Open the URL shown and enter the code to authenticate, then `azd up` continues automatically.

1. When prompted, provide the following values:

   - **Environment name:** Any name (for example, `my-n8n`). Used to isolate this deployment.
   - **Azure subscription:** Select the subscription to deploy into.
   - **Azure location:** Select a region (for example, `northeurope`).
   - **n8n admin email:** Email for the n8n owner account.
   - **n8n admin password:** Password for the n8n owner account (minimum 8 characters, mixed case, number).

1. During the postprovision phase, the automation performs a second sign-in. A device code is displayed. Open the URL and enter the code. This step requires the Global Administrator or Application Administrator role. The postprovision hook then:

   - Creates Microsoft Entra Agent ID objects (Blueprint, Agent Identity, Agent User).
   - Enables the Microsoft Graph MCP Server for Enterprise.
   - Waits for n8n to become ready.
   - Creates the owner account.
   - Installs the `@astaykov/n8n-nodes-entraagentid` community node.
   - Generates an API key for n8n automation.
   - Creates all five credentials with real values.
   - Imports and activates the three demo workflows.

When the deployment completes, the script prints your n8n URL and a summary of what was configured. The tenant ID is autodetected from your Azure sign-in, so no manual configuration is needed.

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

### Microsoft Entra identity objects

The automation creates these objects once and reuses them on subsequent runs:

- **Agent identity blueprint:** App registration that issues tokens on behalf of Agent Identities via Federated Identity Credentials.
- **Agent identity service principal:** The AI agent's service principal. Acquires Microsoft Graph and MCP tokens autonomously.
- **Agent user account:** A cloud-only user identity that enables delegated (OBO) token flows.
- **Single page app (SPA) app registration:** Client app for the webhook demo, preconfigured with redirect URIs and Blueprint API permissions.

### n8n credentials and workflows

The postprovision hook automatically configures n8n:

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

### Understand token flow 

The n8n deployment supports two token flow patterns:

- **Autonomous (app-only):** The n8n workflow uses the Agent Identity Blueprint credentials with Federated Identity Credentials to acquire an app-only token for the Agent Identity service principal. The workflow then calls Microsoft Graph directly with this token. No user context is involved.

- **On-behalf-of (OBO) with MCP:** A browser-based SPA sends a bearer token to an n8n webhook. The webhook calls the Auth Manager workflow, which uses the Blueprint credentials to acquire a delegated token on behalf of the Agent User. The Auth Manager forwards the token to a subworkflow that calls the Microsoft Graph MCP Server for Enterprise, which translates MCP tool calls into Microsoft Graph API requests using the delegated token.

In both patterns, the Agent Identity Blueprint acts as a token factory. It issues tokens for Agent Identities without storing credentials on the agent itself. The Auth Manager community node handles token acquisition and AES-256-GCM caching within each workflow run.

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
- `MCP.Device.Read.All`: Read Microsoft Entra-registered devices.

To add more scopes, edit the `$MCP_SCOPES` array in `scripts/Setup-EntraAgentId.ps1` and rerun `azd provision`.

> [!NOTE]
> The MCP Server only supports delegated permission flows. Use the autonomous credential for app-only Microsoft Graph calls.

## Rerun and update the deployment

The deployment is fully idempotent:

- Bicep skips Azure resources that already exist.
- The `azd` environment saves Microsoft Entra object IDs (Blueprint, Agent Identity, Agent User, Blueprint secret) after the first run and reuses them on subsequent runs.
- n8n configuration (credentials, workflows) is applied fresh each run, which allows repairing a broken state.

To rerun just the postprovision scripts without modifying infrastructure:

```bash
azd provision   # Bicep detects no changes, runs hooks only
```

## Run the scripts manually (optional)

You can run the configuration scripts independently if needed:

- **Full end-to-end (Microsoft Entra and n8n):**

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

## Clean up resources

Remove all Azure resources that the deployment created:

```bash
azd down --purge
```

> [!NOTE]
> The `azd down` command removes Azure resources but doesn't delete Microsoft Entra objects such as blueprints, agent identities, or agent user accounts. Remove these objects manually in the Microsoft Entra admin center if they're no longer needed.

## Related content

- [Integrate third-party agents with Microsoft Entra Agent ID](configure-third-party-agents.md)
- [Authentication with Microsoft Entra Auth SDK (sidecar)](authentication-with-auth-sdk-sidecar.md)
- [n8n-nodes-entraagentid community node](https://www.npmjs.com/package/@astaykov/n8n-nodes-entraagentid)
- [Azure Developer CLI overview](/azure/developer/azure-developer-cli/overview)

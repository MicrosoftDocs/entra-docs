---
title: Secure an n8n agent with Microsoft Entra Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Deploy n8n on Azure Container Apps. Then use an agent identity to call Microsoft Graph or its MCP server.
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: astaykov
ms.custom: msecd-doc-authoring-1013
ai-usage: ai-assisted

#customer intent: As a developer or IT admin, I want to secure n8n workflows with Microsoft Entra Agent ID so that my n8n agents can access Microsoft Graph and MCP Server for Enterprise using agent identities.

---

# Secure an n8n agent with Microsoft Entra Agent ID

This article shows you how to deploy [n8n](https://n8n.io/) on Azure Container Apps and configure sample workflows that use Microsoft Entra Agent ID. The Azure Developer CLI (`azd`) provisions the infrastructure, creates the Microsoft Entra objects, and configures n8n.

This integration doesn't use the Microsoft Entra ID Auth SDK sidecar. The [n8n-nodes-entraagentid](https://www.npmjs.com/package/@astaykov/n8n-nodes-entraagentid) community node runs inside n8n. It reads the blueprint credential from the n8n credential store, obtains and caches access tokens, and makes them available to downstream workflow nodes. The sample includes autonomous (app-only) and on-behalf-of (OBO) flows for Microsoft Graph and the Microsoft Graph MCP Server for Enterprise.

> [!NOTE]
> This sample demonstrates the use of the `n8n-nodes-entraagentid` community node within n8n. It isn't guidance for deploying n8n on Azure in production.

## Prerequisites

Before you begin, make sure you have:

- An Azure subscription with quota for Azure OpenAI (GPT-4o or a similar model), Azure Database for PostgreSQL flexible server, and Azure Container Apps.
- **Global Administrator** role in your Microsoft Entra tenant for the object creation and admin consent steps. Use [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) to activate this role only when needed.

**Azure Cloud Shell** (recommended) comes with everything preinstalled: Azure CLI, Azure Developer CLI (`azd`), PowerShell 7, and Git.

If you're running locally instead of Cloud Shell, install these tools before proceeding:

- [Azure Developer CLI (`azd`)](/azure/developer/azure-developer-cli/install-azd) v1.9 or later.
- [Azure CLI (`az`)](/cli/azure/install-azure-cli) v2.60 or later.
- [PowerShell 7.4+](/powershell/scripting/install/installing-powershell).
- [Microsoft.Entra PowerShell module](/powershell/entra-powershell/) v1.2 or later.
- Git.

Authenticate both the Azure CLI and Azure Developer CLI so that the deployment commands can create and manage resources in your subscription:

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

1. During the postprovision phase, the automation performs a second sign-in. A device code is displayed. Open the URL and enter the code. Sign in with the Global Administrator account required for the setup and consent operations. The `azd up` postprovision hook then:

   1. Creates the agent identity blueprint, agent identity, and agent user.
   1. Enables the Microsoft Graph MCP Server for Enterprise.
   1. Waits for n8n to become ready.
   1. Creates the owner account.
   1. Installs the `@astaykov/n8n-nodes-entraagentid` community node.
   1. Generates an API key for n8n automation.
   1. Creates all five credentials with real values.
   1. Imports and activates the three demo workflows.

When the deployment completes, the script prints your n8n URL and a summary of what was configured. The tenant ID is autodetected from your Azure sign-in, so no manual configuration is needed.

### Verify the first workflow

Open the printed n8n URL and sign in with the owner account you configured. Start with **HTTP Request with autonomous agent token**, the included app-only Microsoft Graph workflow. Run it and check the execution result for a successful Graph response before adding MCP or interactive sign-in to your test.

A reachable n8n page verifies hosting, not Agent ID access. If the workflow fails, use the failing node to distinguish token acquisition from the Graph request. For a Graph authorization failure, review the agent identity's application permissions and admin consent. Don't use this autonomous credential to test the delegated-only MCP server.

## Explore the deployed resources

The deployment creates Azure resources, Microsoft Entra identity objects, and n8n configuration assets that work together to support the sample workflows.

<a name="azure-infrastructure"></a>
### Review the Azure infrastructure resources

The deployment creates the following Azure resources:

- **Container Apps Environment:** Hosts n8n and the test SPA.
- **n8n Container App:** Runs the official `n8nio/n8n` image with HTTPS ingress.
- **Static Web App:** Test SPA for the OBO webhook flow.
- **PostgreSQL Flexible Server:** Persistent store for workflows, credentials, and execution history (Burstable B1ms).
- **Storage Account and File Share:** Persistent `/home/node/.n8n` directory. Community nodes and configuration survive restarts.
- **Azure OpenAI:** GPT model deployment used by the AI agent workflows.
- **Log Analytics Workspace:** Diagnostics and monitoring.

<a name="microsoft-entra-identity-objects"></a>
### Review the Microsoft Entra identity objects

The automation creates these objects once and reuses them on subsequent runs:

- **Agent identity blueprint:** App registration whose credential the community node uses to request tokens for the agent identity.
- **Agent identity service principal:** Service principal represented by app-only tokens for autonomous Microsoft Graph calls.
- **Agent user account:** Cloud-only user identity represented by delegated tokens in the OBO flow.
- **Single page app (SPA) app registration:** Client app for the webhook demo, preconfigured with redirect URIs and Blueprint API permissions.

<a name="n8n-credentials-and-workflows"></a>
### Review the n8n credentials and workflows

The postprovision hook automatically configures n8n:

**Credentials configured:**

- **EntraAgentID - Autonomous:** Blueprint credential used by the community node to obtain an app-only Microsoft Graph access token.
- **EntraAgentID - Agent User OBO:** Credential configuration used by the community node to obtain a delegated access token for the agent user.
- **Azure OpenAI:** Connection to the deployed GPT model for AI agent workflows.
- **Auth Manager credentials:** Access-token forwarding configuration used by downstream HTTP Request and MCP workflow nodes.

**Workflows imported:**

- **Agent ID Auth Manager - Agent User with MCP Enterprise:** Acquires a delegated MCP token for the Agent User and forwards it to a subworkflow.
- **HTTP Request with autonomous agent token:** Demonstrates an autonomous agent calling Microsoft Graph directly with an app-only token.
- **Webhook - interactive agent (on-behalf-of):** Webhook entry point that receives a bearer token from the SPA, calls the Auth Manager, and responds via the Graph MCP Server on behalf of the signed-in user.

### Understand the token flow

The n8n deployment supports two token flow patterns:

- **Autonomous (app-only):** The community node reads the blueprint credential from the n8n credential store and obtains an app-only token that represents the agent identity service principal. The HTTP Request node passes the token in the authorization header when it calls Microsoft Graph. No user context is involved.

- **On-behalf-of (OBO) with MCP:** The browser-based SPA obtains the signed-in user's token and passes it as a bearer token to the n8n webhook. The Auth Manager workflow gives that token and the blueprint credential to the community node, which performs the OBO exchange. The Auth Manager passes the resulting delegated token to the MCP subworkflow, which includes it when calling the Microsoft Graph MCP Server for Enterprise.

In both patterns, n8n stores the blueprint credential. The community node obtains and caches the access token by using AES-256-GCM encryption within each workflow run. Downstream nodes receive the token for the resource call; they don't receive the blueprint credential.

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

The deployment reuses existing resources and reapplies sample configuration:

- Bicep skips Azure resources that already exist.
- The `azd` environment saves Microsoft Entra object IDs (Blueprint, Agent Identity, Agent User, Blueprint secret) after the first run and reuses them on subsequent runs.
- n8n configuration (credentials, workflows) is applied fresh each run, which allows repairing a broken state.

Preserve any workflow customizations before rerunning, and review the postprovision hooks because they reapply credentials and workflows. A rerun isn't a substitute for diagnosing a failed token exchange or missing permission grant.

To rerun just the postprovision scripts without modifying infrastructure, run provisioning again. The Bicep templates detect no infrastructure changes and only execute the deployment hooks:

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

Remove all Azure resources that the deployment created and purge any retained deployment state:

```bash
azd down --purge
```

> [!NOTE]
> The `azd down` command removes Azure resources but doesn't delete Microsoft Entra objects such as blueprints, agent identities, or agent user accounts. Remove these objects manually in the Microsoft Entra admin center if they're no longer needed.

## Related content

- [Choose an integration path for an agent](choose-agent-integration-path.md)
- [Authentication with Microsoft Entra ID Auth SDK (sidecar)](authentication-with-auth-sdk-sidecar.md)
- [n8n-nodes-entraagentid community node](https://www.npmjs.com/package/@astaykov/n8n-nodes-entraagentid)
- [Azure Developer CLI overview](/azure/developer/azure-developer-cli/overview)

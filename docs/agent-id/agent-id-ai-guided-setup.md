---
title: AI-guided setup for Microsoft Entra Agent ID
description: Describes how to use an AI coding agent to automate the onboarding process for Microsoft Entra Agent ID, including blueprint creation, credential configuration, and agent identity provisioning.
ms.topic: how-to
author: shlipsey3
ms.author: sarahlipsey
ms.service: entra-id
ms.date: 05/12/2026
ms.reviewer: arluca
ai-usage: ai-assisted
---

# AI-guided setup for Microsoft Entra Agent ID

Onboarding to Microsoft Entra Agent ID involves multiple steps: creating an agent identity blueprint, configuring credentials, setting up identifier URIs and scopes, creating blueprint principals, and provisioning agent identities. Each step has its own prerequisites, validation checks, and decision points.

This AI-guided setup automates this entire workflow by using an AI coding agent (such as GitHub Copilot in VS Code) to execute the steps on your behalf. Instead of navigating between multiple documentation pages and running commands manually, you provide the AI agent with a single instruction file and it walks you through the process interactively. This instruction file is available as a Skill and can be accessed in more than one way.

## Benefits

The AI-guided setup offers several advantages over the manual workflow:

- **Single entry point**: One instruction file replaces the need to navigate between multiple documentation pages. The AI agent follows the steps in order and handles transitions automatically.
- **Automated prerequisite validation**: The AI agent validates that you have the correct Microsoft Entra roles, that the required tools and Graph modules are installed, and that required permissions are configured with admin consent before making any API calls.
- **Smart defaults and auto-detection**: The AI agent queries your tenant for existing user information and resource details, then uses those values as suggestions when collecting configuration inputs.
- **Derived naming conventions**: You provide a single display name for your agent, and the AI agent derives all related resource names (blueprint, blueprint principal, agent identities, identifier URIs) using consistent patterns.
- **Inline error handling**: When a command fails, the AI agent analyzes the error, suggests a fix, and retries rather than requiring you to search through troubleshooting documentation. This error handling is especially valuable for Agent ID-specific pitfalls like permission propagation delays and OData header requirements.
- **Idempotent operations**: The AI agent checks whether resources already exist before creating them, making it safe to rerun the setup if a previous attempt was interrupted.

## Prerequisites

Before you begin, ensure you have the following prerequisites.

### Required tools

The AI-guided setup requires an AI coding agent with terminal access:

- [Visual Studio Code](https://code.visualstudio.com/) with [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) and [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat) extensions installed.
- The [GitHub Copilot for Azure](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azure-github-copilot) extension, which provides the Microsoft Entra Agent ID skill directly in VS Code.

The skill supports two provisioning paths. Install one or both depending on your preference:

- **PowerShell path**: [PowerShell 7](/powershell/scripting/install/installing-powershell) or later with the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation). Install using `Install-Module Microsoft.Graph.Applications -Scope CurrentUser -Force`.
- **Python path**: [Python](https://www.python.org/downloads/) 3.8 or later with `azure-identity` and `requests`. Install using `pip install azure-identity requests`.

### Required accounts and permissions

- Access to a **Microsoft Entra tenant** with one of the following roles:
  - [Agent ID Developer](/entra/identity/role-based-access-control/permissions-reference#agent-id-developer) to create agent identity blueprints and agent identities. Any owner of an agent identity blueprint can create an agent identity for that blueprint without an Agent ID role.
  - [Agent ID Administrator](/entra/identity/role-based-access-control/permissions-reference#agent-id-administrator) for full administrative access to Agent ID resources.

[!INCLUDE [blueprint-owner-delegated-permission](includes/blueprint-owner-delegated-permission.md)]

- **Additional roles for permission grants:**
  - [Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-role-administrator) to grant Microsoft Graph application permissions.
  - [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) or [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) to grant Microsoft Graph delegated permissions.

### Required Microsoft Graph permissions

The client you use (PowerShell or a custom app registration) must be authorized with the following delegated permissions:

| Permission | Purpose |
|---|---|
| `AgentIdentityBlueprint.Create` | Create new agent identity blueprints |
| `AgentIdentityBlueprint.ReadWrite.All` | Read and update blueprint properties (identifier URI, scopes, credentials) |
| `AgentIdentityBlueprintPrincipal.Create` | Create the blueprint's service principal |
| `AgentIdentity.Create.All` | Create agent identities under a blueprint |
| `AgentIdentity.ReadWrite.All` | Read and update agent identities |
| `Application.ReadWrite.All` | Blueprint CRUD on application objects |
| `AppRoleAssignment.ReadWrite.All` | Grant application permissions to agent identities |
| `DelegatedPermissionGrant.ReadWrite.All` | Grant delegated permissions to agent identities |
| `User.Read` | Read the signed-in user's profile (for sponsor assignment) |

> [!IMPORTANT]
> **`DefaultAzureCredential` and Azure CLI tokens don't work with Agent Identity APIs.** Azure CLI tokens include `Directory.AccessAsUser.All`, which Agent Identity APIs reject with a 403 error. Use `Connect-MgGraph` with explicit delegated scopes (PowerShell) or a dedicated app registration with `client_credentials` (Python). Don't use `az login` tokens for Agent ID provisioning.

### Required agent code (optional)

If you already have a working agent project (Python, Node.js, or .NET) that needs an agent identity, have the project directory available. If you don't have one yet, you can still complete the blueprint setup independently.

## Get started

The AI-guided setup uses a skill, which is a single instruction file that contains all the steps and validation checks. You can access the skill in one of two ways:

- **Through the GitHub Copilot for Azure extension** (recommended): Install the [GitHub Copilot for Azure VS Code extension](/azure/developer/github-copilot-azure/introduction). The Microsoft Entra Agent ID skill activates automatically when you ask about Agent ID setup in Copilot Chat.
- **Directly from GitHub**: Use the standalone [Microsoft Entra Agent ID skill](https://github.com/microsoft/GitHub-Copilot-for-Azure/blob/main/plugin/skills/entra-agent-id/SKILL.md) by referencing it in your Copilot Chat prompt.

### Step 1: Open your project in VS Code

Open your agent project directory (or any working directory) in Visual Studio Code.

### Step 2: Open GitHub Copilot Chat in agent mode

Open the GitHub Copilot Chat panel and switch to **Agent mode**. Agent mode gives GitHub Copilot the ability to run terminal commands, read files, and interact with your environment, which the AI-guided setup requires.

> [!IMPORTANT]
> You must use **Agent mode** (not Ask or Edit mode). The AI-guided setup requires the ability to execute terminal commands and interact with your environment.

### Step 3: Start the guided setup

If you have the GitHub Copilot for Azure extension installed, ask Copilot to set up Agent ID. For example:

```text
@azure Use the Agent ID Skill to set up an agent identity blueprint and create agent identities for my project using Microsoft Entra Agent ID.
```

If you don't have the extension, reference the skill directly from GitHub:

```text
Follow the steps in https://github.com/microsoft/GitHub-Copilot-for-Azure/blob/main/plugin/skills/entra-agent-id/SKILL.md
```

The AI agent reads the skill and begins the guided setup. It works through the steps sequentially:

1. **Validate prerequisites**: Checks Microsoft Entra roles and validates that the required tools (PowerShell with Microsoft Graph module, or Python with `azure-identity`) are installed.
1. **Authenticate**: Connects to Microsoft Graph with the required scopes. For PowerShell, the skill uses `Connect-MgGraph` with explicit delegated scopes. For Python, it uses a dedicated app registration with client credentials.
1. **Create the agent identity blueprint**: Collects a display name, identifies the sponsor (you), creates the blueprint using the typed endpoint (`/applications/microsoft.graph.agentIdentityBlueprint`), and records the `appId`.
1. **Configure credentials**: Adds a federated identity credential with managed identity (for production) or a client secret (for local development/testing) to the blueprint.
1. **Configure identifier URI and scope**: Sets `identifierUris` to `api://{appId}` and creates an OAuth2 permission scope for agent-to-agent and user-to-agent communication.
1. **Create the blueprint principal**: Creates the service principal for the blueprint using the typed endpoint (the principal is **not** autocreated and must be done explicitly).
1. **Create agent identities**: Creates one or more agent identity service principals under the blueprint.

As the agent reads the skill, you may be prompted to install extensions or other tools. Follow the prompts to ensure your environment is ready.

### Step 4: Respond to prompts

The AI agent pauses at specific points to collect input from you:

- **Display name**: The display name for your agent identity blueprint (for example, "Contoso Budget Agent").
- **Sponsor**: The user or group who is accountable for the agent. Defaults to the currently signed-in user.
- **Owner**: The user or service principal who can make technical changes to the blueprint. Optional but recommended.
- **Credential type**: Whether to use a managed identity (recommended for production) or a certificate or client secret (for local development).
- **Agent identity count**: How many agent identities to create under this blueprint.
- **Derived value confirmation**: Review autogenerated names and URIs before resources are created.

> [!TIP]
> The AI agent shows real values from your Microsoft Entra tenant as examples when it asks for configuration inputs. You can accept the suggestions or provide your own values.

### Step 5: Verify in the Microsoft Entra admin center

After the setup completes, the AI agent provides instructions on how to verify the resources:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least an [Agent ID Developer](/entra/identity/role-based-access-control/permissions-reference#agent-id-developer).
2. Browse to **Entra ID** > **Agents** > **Agent identities** to see your new agent identity blueprint and any agent identities created under it.
3. Verify the blueprint has the correct credentials, identifier URI, and scope configured.

## What the AI-guided setup covers

The AI-guided setup automates the following stages of the Agent ID integration:

| Stage | What happens | Related documentation |
|---|---|---|
| Prerequisites | Validates Microsoft Entra roles, PowerShell module, and Graph permissions | [Create a blueprint: Prerequisites](create-blueprint.md#prerequisites) |
| Environment setup | Connects to Microsoft Graph with correct scopes | [Create a blueprint: Prepare your environment](create-blueprint.md#prepare-your-environment) |
| Blueprint creation | Creates the agent identity blueprint with sponsor and owner | [Create a blueprint](create-blueprint.md#create-an-agent-identity-blueprint-1) |
| Credential config | Adds managed identity FIC or client secret to the blueprint | [Configure credentials](create-blueprint.md#configure-credentials-for-the-agent-identity-blueprint) |
| Scope config | Sets identifier URI and OAuth2 permission scope | [Configure identifier URI and scope](create-blueprint.md#configure-identifier-uri-and-scope) |
| Principal creation | Creates the agent identity blueprint principal (service principal) | [Create an agent blueprint principal](create-blueprint.md#create-an-agent-blueprint-principal) |
| Agent identities | Creates agent identity service principals under the blueprint | [Create agent identities](create-delete-agent-identities.md) |

> [!NOTE]
> The AI-guided setup doesn't replace the need to integrate Agent ID into your agent's code. You should understand how your agent [acquires tokens](create-delete-agent-identities.md#get-an-access-token-using-agent-identity-blueprint) and perform operations using its agent identity. The guided setup creates the identity infrastructure your agent code uses.

## Common pitfalls the AI-guided setup handles

The Agent ID APIs have several requirements that the AI-guided setup detects and resolves automatically, but they're not obvious requirements. Understanding these pitfalls can be helpful if you need to debug issues or extend the setup.

### OData-Version header is required

All Agent ID API calls require the `OData-Version: 4.0` header. If you omit this header, the API might silently create a standard application instead of an agent identity blueprint. The AI-guided setup always includes this header. The skill also uses typed endpoints (such as `/applications/microsoft.graph.agentIdentityBlueprint`) instead of raw `/applications` with `@odata.type` properties to reduce the risk of this issue.

### Blueprint principal isn't autocreated

Creating an agent identity blueprint (`POST /applications`) does **not** automatically create its blueprint principal (service principal). Without the blueprint principal, all subsequent agent identity creation fails with:

```
400: The Agent Blueprint Principal for the Agent Blueprint does not exist.
```

The AI-guided setup always creates the blueprint principal immediately after the blueprint. It also handles the idempotent case. If a previous run created the blueprint but crashed before creating the principal, the setup detects this event and creates the missing principal.

### Sponsors are required

Sponsors are required and can be users, groups with dynamic membership, or unified groups. Both blueprint and agent identity creation require a `sponsors@odata.bind` field.  Without it, you receive:

```
400: No sponsor specified. Please provide at least one sponsor.
```

The AI-guided setup only accepts **User** objects for sponsor assignment and uses the `/users/{objectId}` URL format (not `/directoryObjects/` or `/servicePrincipals/`). The setup resolves the current user's object ID and uses it as the default sponsor. To assign a [supported group](agent-owners-sponsors-managers.md#sponsors) as sponsor for a blueprint, use the Microsoft Graph API directly.

### Permission propagation takes 30–120+ seconds

After you grant admin consent for Agent ID permissions, newly granted permissions don't appear in tokens immediately. The token endpoint serves cached claims, and propagation can take 30-120 seconds or more.

The AI-guided setup handles recent permission changes by retrying operations with exponential backoff when a 403 is received. If you're scripting this manually, implement retry logic:

```powershell
# Example: Retry with backoff after admin consent
$maxRetries = 5
for ($i = 0; $i -lt $maxRetries; $i++) {
    try {
        # Attempt the operation
        $result = Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body
        break
    } catch {
        if ($_.Exception.Response.StatusCode -eq 403 -and $i -lt $maxRetries - 1) {
            $wait = 20 * ($i + 1)
            Write-Host "Permission not yet propagated. Retrying in $wait seconds..."
            Start-Sleep -Seconds $wait
            # Disconnect and reconnect to force a fresh token
            Disconnect-MgGraph
            Connect-MgGraph -Scopes $scopes
        } else {
            throw
        }
    }
}
```

### Agent identities can't have password credentials

Agent identities are service principals without backing application objects. Attempting to add a `passwordCredential` directly to an agent identity results in:

```
PropertyNotCompatibleWithAgentIdentity
```

Credentials must be configured on the **blueprint**, not on individual agent identities. Use managed identity federation (recommended) or add secrets/certificates to the blueprint, and agent identities inherit the credential through impersonation.

### Identifier URI must be set explicitly

The blueprint's `identifierUris` field isn't set by default. Without it, the OAuth2 scope `api://{appId}/.default` won't resolve, and token acquisition for the agent will fail. The AI-guided setup always configures this value as part of the scope setup step.

### Federated identity credential path for blueprints

When adding federated identity credentials (FIC) for managed identity federation, you must use the agent-specific API path:

```
POST /applications/{blueprint-obj-id}/microsoft.graph.agentIdentityBlueprint/federatedIdentityCredentials
```

Using the `/applications/{id}/federatedIdentityCredentials` path might work for agent identity blueprints, but it's not supported and isn't recommended.

### Token issuer varies by endpoint version

When validating tokens in your agent backend, be aware of the following variations:
- v1.0 tokens use issuer `https://sts.windows.net/{tenant-id}/`
- v2.0 tokens use issuer `https://login.microsoftonline.com/{tenant-id}/v2.0`

Accept both formats in your token validation logic.

## Troubleshooting

### AI agent doesn't run terminal commands

If the AI agent describes commands but doesn't execute them, make sure you're using **Agent mode** in GitHub Copilot Chat. Ask and Edit modes don't have terminal access.

### AI agent skips validation steps

The instruction file enforces strict step ordering. If the AI agent appears to skip a step, remind it to follow the instructions from the beginning. For example:

```text
Please start from Step 1 in the setup instructions and work through each step in order.
```

### Graph commands fail with 403-Forbidden

The most common causes of 403 errors:

- **Using Azure CLI or `DefaultAzureCredential` tokens**: Azure CLI tokens include `Directory.AccessAsUser.All`, which Agent Identity APIs reject outright. Use `Connect-MgGraph` with explicit delegated scopes, or a dedicated app registration with `client_credentials`. See the [authentication warning](#required-microsoft-graph-permissions) in the prerequisites.
- **Permission propagation delay**: Wait 1–2 minutes after admin consent and retry. The AI-guided setup handles this automatically with retry logic.
- **Missing admin consent**: Verify that the required permissions have admin consent granted in the [Microsoft Entra admin center](https://entra.microsoft.com/) under **App registrations** > your client app > **API permissions**.

### Blueprint creation succeeds but returns a standard application

This result happens when the `OData-Version: 4.0` header is missing. Use the typed endpoint (`/applications/microsoft.graph.agentIdentityBlueprint`) instead of raw `/applications` with `@odata.type` to avoid this issue.

### Agent identity creation fails with "Blueprint Principal does not exist"

The blueprint principal must be created as a separate step after the blueprint. Run:

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals/microsoft.graph.agentIdentityBlueprintPrincipal
OData-Version: 4.0
Content-Type: application/json

{
  "appId": "<your-blueprint-app-id>"
}
```

### Credential lifetime policy errors

Your tenant might have credential lifecycle policies that restrict the maximum lifetime for client secrets. If you receive an error about credential lifetime when adding a password, reduce the `endDateTime` value to align with your organization's policy.

### Configuration values need to change

If you need to change configuration values after the setup, you can:

- Rerun the AI-guided setup with updated values. The idempotent checks skip resources that already exist correctly.
- Use Microsoft Graph PowerShell to update specific properties with `PATCH` requests.

## Next steps

- [Create and delete agent identities](./create-delete-agent-identities.md)
- [Administrative relationships in Agent ID (Owners, sponsors, and managers)](./agent-owners-sponsors-managers.md)
- [Agent identities, service principals, and applications](./agent-service-principals.md)
- [Agent identity blueprint concepts](./agent-blueprint.md)

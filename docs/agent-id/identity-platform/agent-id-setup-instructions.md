---
title: Agent ID Setup Instructions
description: This file is used by an AI coding agent (such as GitHub Copilot in VS Code Agent mode) to automate onboarding to Microsoft Entra Agent ID.
author: arlucaID
ms.author: arluca
ms.topic: how-to
ms.date: 3/09/2026
ms.custom: agent-id-ignite
ms.reviewer: shlipsey3
#customer-intent: As a developer, I want to understand how to integrate Microsoft Entra Agent ID into my applications so that I can create agents with distinct identities, permissions, and audit trails.
---

# Agent ID Setup Instructions

> This file is used by an AI coding agent (such as GitHub Copilot in VS Code Agent mode) to automate onboarding to Microsoft Entra Agent ID.
> Attach this file in Copilot Chat and prompt: `Follow the steps in #file:agent-id-setup-instructions.md`

---

## IMPORTANT: Read before executing

- Execute each step **sequentially** — do not skip ahead.
- **Always include `OData-Version: 4.0`** in any Microsoft Graph request that uses `@odata.type`.
- All Agent ID APIs are under the `/beta` endpoint — never use `/v1.0` for Agent ID operations.
- **Do not use Azure CLI tokens** (`az account get-access-token`) to call Agent ID APIs. Azure CLI tokens contain `Directory.AccessAsUser.All`, which is explicitly rejected by Agent ID APIs (403 Forbidden).
- After granting admin consent, permissions may take **30–120 seconds** to propagate. Implement retry with backoff on 403 errors.

---

## Step 1: Validate prerequisites

### 1.1 Check PowerShell version

Run in terminal:

```powershell
$PSVersionTable.PSVersion
```

**Requirement:** Major version must be 7 or higher. If not, instruct the user to install PowerShell 7+ from https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell.

### 1.2 Check Microsoft Graph PowerShell beta module

Run in terminal:

```powershell
Get-Module -ListAvailable Microsoft.Graph.Beta.Applications | Select-Object Name, Version
```

If not installed, install it:

```powershell
Install-Module Microsoft.Graph.Beta.Applications -Scope CurrentUser -Force
```

### 1.3 Verify Frontier access

Ask the user: "Do you have a Microsoft 365 Copilot license with the Frontier program enabled? (See https://adoption.microsoft.com/copilot/frontier-program/)"

If unsure, instruct them to check:
1. Sign in to the Microsoft 365 admin center (https://admin.microsoft.com/).
2. Browse to **Copilot > Settings > User access > Copilot Frontier**.
3. Ensure it's enabled for their users.

### 1.4 Verify Entra roles

Ask the user which role they have:
- **Agent ID Developer** — can create blueprints and agent identities.
- **Agent ID Administrator** — full administrative access.

They also need **Privileged Role Administrator** if granting application permissions, or **Cloud Application Administrator** / **Application Administrator** for delegated permissions.

**Do not proceed until the user confirms they have at least Agent ID Developer role.**

---

## Step 2: Connect to Microsoft Graph

### 2.1 Connect with required scopes

Run in terminal:

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create", "AgentIdentityBlueprint.AddRemoveCreds.All", "AgentIdentityBlueprint.ReadWrite.All", "AgentIdentityBlueprintPrincipal.Create", "User.Read"
```

The user will be prompted to sign in and consent to the required permissions in a browser window.

### 2.2 Verify connection

Run in terminal:

```powershell
Get-MgContext | Select-Object Account, TenantId, Scopes
```

Confirm the scopes include the Agent Identity permissions. Record the **TenantId** for later use.

### 2.3 Set the Graph profile to beta

Run in terminal:

```powershell
Select-MgProfile -Name beta
```

If `Select-MgProfile` is not available (newer SDK versions), the beta module handles this automatically. Verify by confirming the module loaded is `Microsoft.Graph.Beta.*`.

### 2.4 Get the current user's ID (for sponsor assignment)

Run in terminal:

```powershell
$currentUser = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/me" -OutputType PSObject
$currentUser.id
$currentUser.displayName
```

Record the user's object ID — this will be used as the **sponsor** for the blueprint.

---

## Step 3: Create the agent identity blueprint

### 3.1 Collect configuration values

Ask the user for:
- **Display name** for the blueprint (e.g., "Contoso Budget Agent Blueprint")

Suggest defaults:
- **Sponsor**: The currently signed-in user (from Step 2.4)
- **Owner**: Same as sponsor (optional, but recommended)

### 3.2 Check if the blueprint already exists

Run in terminal (replace the display name):

```powershell
$existingBlueprints = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/applications?`$filter=displayName eq '<DISPLAY_NAME>'" -Headers @{"OData-Version"="4.0"} -OutputType PSObject
$existingBlueprints.value | Select-Object displayName, appId, id
```

If a blueprint with the same name already exists, ask the user if they want to use the existing one or create a new one with a different name. If using the existing one, record its `appId` and `id`, then skip to Step 3.4 (check for blueprint principal).

### 3.3 Create the blueprint

**CRITICAL:** Both `@odata.type` and the `OData-Version: 4.0` header are REQUIRED. Without them, the API creates a standard application instead of an agent identity blueprint.

Run in terminal (replace placeholders):

```powershell
$blueprintBody = @{
    "@odata.type" = "Microsoft.Graph.AgentIdentityBlueprint"
    "displayName" = "<DISPLAY_NAME>"
    "sponsors@odata.bind" = @(
        "https://graph.microsoft.com/v1.0/users/<SPONSOR_USER_ID>"
    )
    "owners@odata.bind" = @(
        "https://graph.microsoft.com/v1.0/users/<OWNER_USER_ID>"
    )
}

$blueprint = Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/applications" -Headers @{"OData-Version"="4.0"; "Content-Type"="application/json"} -Body ($blueprintBody | ConvertTo-Json -Depth 5) -OutputType PSObject
$blueprint | Select-Object displayName, appId, id
```

**Record these values — you need them for all subsequent steps:**
- `appId` (Application / Client ID)
- `id` (Object ID)

### 3.4 Verify the blueprint principal exists

**CRITICAL:** Creating a blueprint does NOT auto-create its service principal (blueprint principal). Without the principal, all agent identity creation FAILS.

Check if it exists:

```powershell
$existingSP = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/servicePrincipals?`$filter=appId eq '<BLUEPRINT_APP_ID>'" -Headers @{"OData-Version"="4.0"} -OutputType PSObject
$existingSP.value | Select-Object displayName, appId, id, servicePrincipalType
```

If no results, create it in Step 6. If it exists, record its ID.

---

## Step 4: Configure credentials

Ask the user: "Will your agent run on Azure (with a managed identity) or locally for development?"

### Option A: Managed identity (recommended for production)

Ask for the **managed identity's principal ID** (object ID, not client ID).

Run in terminal:

```powershell
$ficBody = @{
    "name" = "<CREDENTIAL_NAME>"
    "issuer" = "https://login.microsoftonline.com/<TENANT_ID>/v2.0"
    "subject" = "<MANAGED_IDENTITY_PRINCIPAL_ID>"
    "audiences" = @("api://AzureADTokenExchange")
}

Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/applications/<BLUEPRINT_OBJECT_ID>/federatedIdentityCredentials" -Headers @{"OData-Version"="4.0"; "Content-Type"="application/json"} -Body ($ficBody | ConvertTo-Json -Depth 5) -OutputType PSObject
```

**Key details:**
- The `subject` is the managed identity's **principalId** (object ID), NOT the client ID.
- The `audiences` must be `["api://AzureADTokenExchange"]` — NOT your API audience.
- Federated credentials go on the **blueprint**, not on individual agent identities.
- For agent identity blueprints, you may need to use the path: `/applications/{id}/microsoft.graph.agentIdentityBlueprint/federatedIdentityCredentials`

### Option B: Client secret (for local development/testing only)

Run in terminal:

```powershell
$secretBody = @{
    "passwordCredential" = @{
        "displayName" = "Dev Secret"
        "endDateTime" = "2027-03-11T23:59:59Z"
    }
}

$credential = Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/applications/<BLUEPRINT_OBJECT_ID>/addPassword" -Headers @{"OData-Version"="4.0"; "Content-Type"="application/json"} -Body ($secretBody | ConvertTo-Json -Depth 5) -OutputType PSObject
$credential | Select-Object displayName, secretText, endDateTime
```

**IMPORTANT:**
- **Save the `secretText` now** — it CANNOT be retrieved after this point.
- If you receive a credential lifetime policy error, reduce the `endDateTime` to align with your organization's policy.
- Client secrets are NOT recommended for production — use managed identities.
- **Agent identities CANNOT have their own password credentials** (you'll get `PropertyNotCompatibleWithAgentIdentity`). Credentials belong on the blueprint only.

---

## Step 5: Configure identifier URI and scope

**CRITICAL:** Without the identifier URI, the OAuth2 scope `api://{appId}/.default` won't resolve and token acquisition will fail.

### 5.1 Generate a GUID for the scope

Run in terminal:

```powershell
$scopeGuid = [guid]::NewGuid()
$scopeGuid.ToString()
```

### 5.2 Set identifier URI and scope

Run in terminal:

```powershell
$scopeBody = @{
    "identifierUris" = @("api://<BLUEPRINT_APP_ID>")
    "api" = @{
        "oauth2PermissionScopes" = @(
            @{
                "adminConsentDescription" = "Allow the application to access the agent on behalf of the signed-in user."
                "adminConsentDisplayName" = "Access agent"
                "id" = "<SCOPE_GUID>"
                "isEnabled" = $true
                "type" = "User"
                "value" = "access_agent"
            }
        )
    }
}

Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/beta/applications/<BLUEPRINT_OBJECT_ID>" -Headers @{"OData-Version"="4.0"; "Content-Type"="application/json"} -Body ($scopeBody | ConvertTo-Json -Depth 5)
```

A successful call returns no content (HTTP 204).

---

## Step 6: Create the blueprint principal

**CRITICAL:** This step is REQUIRED and is NOT automatic. Without it, agent identity creation will fail with: `The Agent Blueprint Principal for the Agent Blueprint does not exist.`

Run in terminal:

```powershell
$spBody = @{
    "appId" = "<BLUEPRINT_APP_ID>"
}

$blueprintPrincipal = Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/serviceprincipals/graph.agentIdentityBlueprintPrincipal" -Headers @{"OData-Version"="4.0"; "Content-Type"="application/json"} -Body ($spBody | ConvertTo-Json -Depth 5) -OutputType PSObject
$blueprintPrincipal | Select-Object displayName, appId, id, servicePrincipalType
```

If this fails with a conflict (409), the principal already exists — that's fine.

---

## Step 7: Create agent identities (optional)

Ask the user: "Would you like to create one or more agent identities now?"

If yes, ask for:
- **Display name** for the agent identity (e.g., "budget-agent-1")
- **Number of identities** to create

For each agent identity, run:

```powershell
$agentBody = @{
    "@odata.type" = "Microsoft.Graph.AgentIdentity"
    "displayName" = "<AGENT_DISPLAY_NAME>"
    "agentIdentityBlueprintId" = "<BLUEPRINT_APP_ID>"
    "sponsors@odata.bind" = @(
        "https://graph.microsoft.com/v1.0/users/<SPONSOR_USER_ID>"
    )
}

$agentIdentity = Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/serviceprincipals/Microsoft.Graph.AgentIdentity" -Headers @{"OData-Version"="4.0"; "Content-Type"="application/json"} -Body ($agentBody | ConvertTo-Json -Depth 5) -OutputType PSObject
$agentIdentity | Select-Object displayName, appId, id, servicePrincipalType
```

**Key details:**
- Agent identities are service principals — they do NOT have backing application objects.
- Agent identities CANNOT have their own credentials (no passwords, no certificates). They inherit credentials from the blueprint via impersonation.
- Sponsors must be User objects — ServicePrincipals are NOT accepted as sponsors.

---

## Step 8: Summary and verification

Present a summary table to the user:

| Resource | Name | ID |
|---|---|---|
| Blueprint | {displayName} | appId: {appId}, objectId: {id} |
| Blueprint Principal | {displayName} | id: {spId} |
| Credential | {type} | {details} |
| Identifier URI | api://{appId} | — |
| Scope | access_agent | id: {scopeGuid} |
| Agent Identity 1 | {name} | id: {agentId} |

Direct the user to verify in the Microsoft Entra admin center:
1. Go to https://entra.microsoft.com/
2. Navigate to **Agent ID** > **All agent identities**
3. Confirm the blueprint and agent identities appear

### Next steps

Instruct the user:
- To acquire tokens using the agent identity blueprint, see: https://learn.microsoft.com/en-us/entra/agent-id/identity-platform/create-delete-agent-identities#get-an-access-token-using-agent-identity-blueprint
- To learn about administrative relationships (owners, sponsors, managers), see: https://learn.microsoft.com/en-us/entra/agent-id/identity-platform/agent-owners-sponsors-managers
- To understand the agent service principal model, see: https://learn.microsoft.com/en-us/entra/agent-id/identity-platform/agent-service-principals

---

## Error handling reference

If any step fails, consult this section:

| Error | Cause | Fix |
|---|---|---|
| `403 Forbidden` | Token contains `Directory.AccessAsUser.All` or permissions not yet propagated | Use Graph PowerShell with explicit scopes. Wait 60–120s after admin consent and retry. |
| `400: No sponsor specified` | Missing `sponsors@odata.bind` | Add at least one user as sponsor. |
| `400: Blueprint Principal does not exist` | Blueprint principal not created | Run Step 6. |
| `PropertyNotCompatibleWithAgentIdentity` | Trying to add credentials to an agent identity instead of blueprint | Add credentials to the blueprint, not the agent identity. |
| Credential lifetime policy error | Secret `endDateTime` exceeds org policy | Reduce `endDateTime` to align with policy. |
| `409 Conflict` on service principal creation | Principal already exists | Safe to ignore — resource already exists. |
| `@odata.type` silently ignored | Missing `OData-Version: 4.0` header | Add `OData-Version: 4.0` to ALL Agent ID API requests. |

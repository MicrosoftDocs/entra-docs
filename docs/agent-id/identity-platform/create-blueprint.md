---
title: Create an agent identity blueprint
description: Learn how to create an agent identity blueprint that serves as a template for multiple agent identities using Microsoft Graph APIs and PowerShell.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 01/28/2026
ms.custom: agent-id-ignite
ms.reviewer: dastrock
#customer-intent: As a developer or IT administrator, I want to create an Agent Identity Blueprint that defines the security and permissions template for my agent identities, so that I can efficiently manage multiple agents with consistent security policies.
---

# Create an agent identity blueprint

An [agent identity blueprint](agent-blueprint.md) is used to create agent identities and request tokens using those agent identities. This guide walks you through creating an agent identity blueprint using Microsoft Graph REST API and Microsoft Graph PowerShell.

## Prerequisites

- [Privileged Role Administrator](../../identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) role is required to grant Microsoft Graph permissions.
- [Agent ID Developer](../../identity/role-based-access-control/permissions-reference.md#agent-id-developer) or [Agent ID Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) roles are required to create agent identity blueprints.
- If using PowerShell, version 7 is required.

## Authorize a client to create agent identity blueprints

In this article, you use Microsoft Graph PowerShell or another client to create your agent identity blueprint. You must authorize this client to create an agent identity blueprint. The client requires one of the following Microsoft Graph permissions:
<!--- The following permissions are the same?--->
- `AgentIdentityBlueprint.Create` (delegated permission)
- `AgentIdentityBlueprint.Create` (application permission)

A Privileged Role Administrator can grant these permissions to the client. With these permissions, an administrator can:
<!--- It seems confusing to just broadly mention these commands and tasks here outside of the context of the actual step. "use the command" and "run a script" are just vague. Why not explain these specific steps where the user encounters them in the process? If it's a prerequisite step, then we need to make it an explicit step.--->
- Use the `Connect-MgGraph` command.
- Run a script to create an `oAuth2PermissionGrant` or `appRoleAssignment` in the tenant.

## Create an agent identity blueprint

Creating a functional agent identity blueprint in your tenant requires two steps:

1. Create an `AgentIdentityBlueprint` in the tenant.
2. Create an `AgentIdentityBlueprintPrincipal` in the tenant.
<!--- This line is confusing to me I think because we're not talking about agent identities here - we're talking about blueprints. Should we explain the difference between the blueprint and the blueprint principal? --->
The principal created is different from the [agent identity](create-delete-agent-identities.md) used by the agent.

### [Microsoft Graph API](#tab/microsoft-graph-api)
<!--- I'm not sure if this step should be explicitly described? Is this an OK assumption to make that users will know how to obtain an access token? Is there any additional guidance we should provide here?

Also, I combined the two steps a bit. Seemed like extra work to make the user get an access token with one permission, then do it again with a different permission. Is it not OK to get a token with both? It also repeated the same tip. --->
First obtain an access token with the permission `AgentIdentityBlueprint.Create` and `AgentIdentityBlueprintPrincipal.Create`. Once you have an access token, complete the following steps.

> [!TIP]
> Always include the OData-Version header when using @odata.type.

**Create the agent identity blueprint application:**

```http
POST https://graph.microsoft.com/beta/applications/
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
  "@odata.type": "Microsoft.Graph.AgentIdentityBlueprint",
  "displayName": "My Agent Identity Blueprint",
  "sponsors@odata.bind": [
    "https://graph.microsoft.com/v1.0/users/<id>",
  ],
  "owners@odata.bind": [
    "https://graph.microsoft.com/v1.0/users/<id>"
  ]
}
```

After creating the agent identity blueprint, record its `appId` for the next step.

**Create the service principal:**

```http
POST https://graph.microsoft.com/beta/serviceprincipals/graph.agentIdentityBlueprintPrincipal
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
  "appId": "<agent-blueprint-app-id>"
}
```

### [Microsoft Graph PowerShell](#tab/powershell)

This step includes the following distinct tasks:

- Connect to your tenant with `AgentIdentityBlueprint.Create`, `User.Read`, and `AgentIdentityBlueprintPrincipal.Create` scopes.
- Add your display name and user ID as the sponsor and owner values for the agent identity blueprint.
- Create the agent identity blueprint application.

After creating the agent identity blueprint, record its `appId` for the next steps.

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create","User.Read", "AgentIdentityBlueprintPrincipal.Create" -TenantId <your-tenant>

$currentUser = Get-MgContext | Select-Object -ExpandProperty Account
$user = Get-MgUser -UserId $currentUser

Write-Host "Current user: $($user.DisplayName) ($($user.Id))"

$body = @{
    "@odata.type" = "Microsoft.Graph.AgentIdentityBlueprint"
    "displayName" = "My Agent Identity Blueprint"
    "sponsors@odata.bind" = @("https://graph.microsoft.com/v1.0/users/$($user.Id)")
    "owners@odata.bind" = @("https://graph.microsoft.com/v1.0/users/$($user.Id)")
} | ConvertTo-Json -Depth 5

$response = Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/applications/graph.agentIdentityBlueprint" `
    -Body $body `
    -ContentType "application/json"

$response

```

After creating the agent identity blueprint, create an agent identity blueprint principal using the newly created agent identity blueprint `appId`.

```powershell
Connect-MgGraph -Scopes  -TenantId <your-test-tenant>
$body = @{
    appId   = "<agent-blueprint-client-id>"
}
Invoke-MgGraphRequest -Method POST `
        -Uri "https://graph.microsoft.com/beta/serviceprincipals/graph.agentIdentityBlueprintPrincipal" `
        -Headers @{ "OData-Version" = "4.0" } `
        -Body ($body | ConvertTo-Json)
```
---


## Configure credentials for the agent identity blueprint

To request access tokens using the agent identity blueprint, you must add a client credential. We recommend using a managed identity as a federated identity credential (FIC) for production deployments. For local development and testing, use a client secret.

### [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the permission `AgentIdentityBlueprint.AddRemoveCreds.All`.

Add a managed identity as a credential using the following request:

```http
POST https://graph.microsoft.com/beta/applications/<agent-blueprint-object-id>/federatedIdentityCredentials
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
    "name": "my-msi",
    "issuer": "https://login.microsoftonline.com/<my-test-tenant-id>/v2.0",
    "subject": "<msi-principal-id>",
    "audiences": [
        "api://AzureADTokenExchange"
    ]
}
```

### [Microsoft Graph PowerShell](#tab/powershell)

This step currently requires the beta version of the module and includes the following distinct tasks:

- Install the beta version of the required module.
- Connect to your tenant with the `AgentIdentityBlueprint.AddRemoveCreds.All` scope.
- Add a managed identity as a credential for the agent identity blueprint using the previously created agent identity blueprint principal.

```powershell
Install-Module Microsoft.Graph.Beta.Applications -Scope CurrentUser -Force

Connect-MgGraph -Scopes "AgentIdentityBlueprint.AddRemoveCreds.All" -TenantId <your-test-tenant>

$applicationId = "<agent-blueprint-object-id>"

$federatedCredential = @{
  Name             = "my-msi"
  Issuer           = "https://login.microsoftonline.com/<my-test-tenant-id>/v2.0"
  Subject          = "api://graph.agentIdentityBlueprintPrincipal/<my-agent-blueprint-principal>"
  Audiences         = @("api://AzureADTokenExchange")
}

New-MgBetaApplicationFederatedIdentityCredential `
  -ApplicationId $applicationId `
  -BodyParameter $federatedCredential
```

---

### Other app credentials

In some tenants, other kinds of app credentials including `keyCredentials`, `passwordCredentials`, and `trustedSubjectNameAndIssuers` are also supported. These kinds of credentials aren't recommended for production, but can be convenient for local development and testing. To add a password credential:

## [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the delegated permission `AgentIdentityBlueprint.AddRemoveCreds.All`

```http
POST https://graph.microsoft.com/beta/applications/<agent-blueprint-object-id>/addPassword
Content-Type: application/json
Authorization: Bearer <token>

{
  "passwordCredential": {
    "displayName": "My Secret",
    "endDateTime": "2026-08-05T23:59:59Z"
  }
}
```

## [Microsoft Graph PowerShell](#tab/powershell)

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.AddRemoveCreds.All" -TenantId <your-tenant>

$applicationId = "<agent-blueprint-object-id>"

# Define the secret properties
$displayName = "My Secret"
$endDate = (Get-Date).AddYears(1).ToString("o")  # 1 year from now, in ISO 8601 format

# Construct the password credential
$passwordCredential = @{
    displayName = $displayName
    endDateTime = $endDate
}

# Add the password (client secret)
$response = Add-MgApplicationPassword -ApplicationId $applicationId -PasswordCredential $passwordCredential

# Output the generated secret (only returned once!)
Write-Host "Secret Text: $($response.secretText)"
```

---

Be sure to securely store the `passwordCredential` value generated. It can't be viewed after initial creation. You can also use client certificates as credentials; see [Add a certificate credential](/graph/api/application-addkey?tabs=http#example-3-add-a-certificate-credential-to-an-application).

## Configure identifier URI and scope

To receive incoming requests from users and other agents, you need to define an identifier URI and OAuth scope for your agent identity blueprint:

## [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the permission `AgentIdentityBlueprint.ReadWrite.All`.

```http
PATCH https://graph.microsoft.com/beta/applications/<agent-blueprint-object-id>
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
    "identifierUris": ["api://<agent-blueprint-id>"],
    "api": {
      "oauth2PermissionScopes": [
        {
          "adminConsentDescription": "Allow the application to access the agent on behalf of the signed-in user.",
          "adminConsentDisplayName": "Access agent",
          "id": "<generate-a-guid>",
          "isEnabled": true,
          "type": "User",
          "value": "access_agent"
        }
      ]
  }
}
```

## [Microsoft Graph PowerShell](#tab/powershell)

This step currently requires the beta version of the module and includes the following distinct tasks:

- Install the beta version of the required module.
- Connect to your tenant with the `AgentIdentityBlueprint.ReadWrite.All` scope.
- Configure the URI and scope for the new agent identity blueprint.

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.ReadWrite.All" -TenantId <your-tenant>

$AppId = "<agent-blueprint-object-id>"
$IdentifierUri = "api://<agent-blueprint-id>"
$ScopeId = [guid]::NewGuid()

# Construct the OAuth2 permission scope
$scope = @{
    adminConsentDescription = "Allow the application to access the agent on behalf of the signed-in user."
    adminConsentDisplayName = "Access agent"
    id = $ScopeId
    isEnabled = $true
    type = "User"
    value = "access_agent"
}

Update-MgBetaApplication -ApplicationId $AppId `
    -IdentifierUris @($IdentifierUri) `
    -Api @{ oauth2PermissionScopes = @($scope) }
```

---



## Related content

[Create and delete agent identities](create-delete-agent-identities.md)

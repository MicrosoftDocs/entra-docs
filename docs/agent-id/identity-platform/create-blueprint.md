---
title: Create an agent ID Blueprint
description: Learn how to create an agent ID Blueprint that serves as a template for multiple agent identities using Microsoft Graph APIs and PowerShell.
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.reviewer: dastrock
#customer-intent: As a developer or IT administrator, I want to create an Agent ID Blueprint that defines the security and permissions template for my agent identities, so that I can efficiently manage multiple agents with consistent security policies.
---

# Create an agent identity blueprint

An agent identity blueprint (agent ID blueprint) is used to create agent identities (agent IDs) and request tokens using those agent IDs. This guide walks you through creating an agent ID blueprint using Microsoft Graph REST API and Microsoft Graph PowerShell.

## Prerequisites

Before creating your agent ID blueprint, ensure you have the Agent ID Developer, Agent ID Administrator, or Global Administrator role.

## Authorize a client to create agent ID blueprints

In this article, you'll use Microsoft Graph PowerShell or another client to create your agent ID blueprint. You must authorize this client to create an agent ID blueprint. The client requires one of the following Microsoft Graph permissions:

- `AgentIdentityBlueprint.Create` (delegated permission)
- `AgentIdentityBlueprint.Create` (application permission)

Only a Global Administrator or Privileged Role Administrator is able to grant these permissions to the client. To grant these permissions, an administrator can:

- Use the `Connect-MgGraph` command in the following example:
- Run a script to create an `oAuth2PermissionGrant` or `appRoleAssignment` in the tenant.

The easiest way is to continue the following steps using an account that has the Global Administrator role.

## Create an agent ID blueprint

Creating a functional agent ID blueprint in your test tenant requires two steps:

1. Create an `AgentIdentityBlueprint` in the tenant.
2. Create an `AgentIdentityBlueprintPrincipal` in the tenant.

The principal created in this case is different than the agent identity that will be used by the agent.


## [Microsoft Graph API](#tab/microsoft-graph-api)

First obtain an access token with the permission `AgentIdentityBlueprint.Create`. Once you have an access token, make the following request.

> [!TIP]
> Always include the OData-Version header when using @odata.type.

```http
POST https://graph.microsoft.com/beta/applications/
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
  "@odata.type": "Microsoft.Graph.AgentIdentityBlueprint",
  "displayName": "My Agent ID Blueprint",
  "sponsors@odata.bind": [
    "https://graph.microsoft.com/v1.0/users/<id>",
  ]
}
```

## [Microsoft Graph PowerShell](#tab/powershell)

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create","User.Read" -TenantId <your-tenant>

$body = @{
    "@odata.type" = "Microsoft.Graph.AgentIdentityBlueprint"
    displayName   = "My Agent ID Blueprint"
}

Invoke-MgGraphRequest -Method POST `
First obtain an access token with the permission `AgentIdentityBlueprint.Create`. Once you have an access token, make the following request.
        -Headers @{ "OData-Version" = "4.0" } `
        -Body ($body | ConvertTo-Json)
```

---

Once you've created an agent ID blueprint, record its `appId` for upcoming steps in the guide. Next, create a service principal for your agent ID blueprint:

## [Microsoft Graph API](#tab/microsoft-graph-api)

To create the service principal, you first need to obtain an access token with the permission `AgentIdentityBlueprint.Create`. Once you have an access token, make the following request:

> [!TIP]
> Always include the OData-Version header when using @odata.type.

```http
POST https://graph.microsoft.com/beta/serviceprincipals/graph.agentIdentityBlueprintPrincipal
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create","User.Read" -TenantId <your-tenant>
  "appId": "<agent-blueprint-app-id>"
}
```

## [Microsoft Graph PowerShell](#tab/powershell)

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create","User.Read" -TenantId <your-tenant>

# Get the current user's ID
$currentUser = Get-MgContext | Select-Object -ExpandProperty Account
$user = Get-MgUser -UserId $currentUser

Write-Host "Current user: $($user.DisplayName) ($($user.Id))"

# Construct the body for the POST request
$body = @{
    "@odata.type" = "Microsoft.Graph.AgentIdentityBlueprint"
    "displayName" = "My Agent ID Blueprint"
    "sponsors@odata.bind" = @("https://graph.microsoft.com/v1.0/users/$($user.Id)")
} | ConvertTo-Json -Depth 5

# Make the POST request to create the agent ID blueprint application
$response = Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/applications" `
    -Body $body `
    -ContentType "application/json"

# Output the response
$response
```

---

## Configure credentials for the agent ID blueprint

To request access tokens using the agent ID blueprint, you must add a client credential. It's recommended to use a managed identity as a federated identity credential for production deployments. For local development and testing, it's recommended to use a client secret.

Add a managed identity as a credential using the following request:

## [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the permission `AgentIdentityBlueprint.Create`.

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

## [Microsoft Graph PowerShell](#tab/powershell)

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create" -TenantId <your-test-tenant>

$applicationId = "<agent-blueprint-object-id>"

$federatedCredential = @{
  Name             = "my-msi"
  Issuer           = "https://login.microsoftonline.com/<my-test-tenant-id>/v2.0"
  Subject          = "<msi-principal-id>"
  Audiences         = @("api://AzureADTokenExchange")
}

New-MgApplicationFederatedIdentityCredential `
  -ApplicationId $applicationId `
  -BodyParameter $federatedCredential
```

---

In some tenants, other kinds of app credentials including `keyCredentials`, `passwordCredentials`, and `trustedSubjectNameAndIssuers` are also supported. These kinds of credentials aren't recommended for production, but can be convenient for local development and testing. To add a password credential:

## [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the delegated permission `AgentIdentityBlueprint.Create`.

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
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create" -TenantId <your-tenant>

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

Be sure to securely store the `passwordCredential` value generated. It can't be viewed after initial creation. You can also use client certificates as credentials; see [Add a certificate credential](graph/api/application-addkey?tabs=http#example-3-add-a-certificate-credential-to-an-application).

## Configure identifier URI and scope

To receive incoming requests from users and other agents, you need to define an identifier URI and OAuth scope for your agent ID blueprint:

## [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the permission `AgentIdentityBlueprint.Create`.

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

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create" -TenantId <your-tenant>

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

Update-MgApplication -ApplicationId $AppId `
    -IdentifierUris @($IdentifierUri) `
    -Api @{ oauth2PermissionScopes = @($scope) }
```

---

---
title: Create an agent identity blueprint
description: Learn how to create an agent identity blueprint that serves as a template for multiple agent identities using Microsoft Graph APIs and PowerShell.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.topic: how-to
ms.date: 02/19/2026
ms.custom: agent-id-ignite
ms.reviewer: dastrock
#customer-intent: As a developer or IT administrator, I want to create an agent identity blueprint that defines the security and permissions template for my agent identities, so that I can efficiently manage multiple agents with consistent security policies.
---

# Create an agent identity blueprint

An [agent identity blueprint](agent-blueprint.md) is used to create agent identities and request tokens using those agent identities. During the process for creating an agent identity blueprint, you set the [owner and sponsor](agent-owners-sponsors-managers.md) of that blueprint, to establish accountability and administrative relationships. You also configure an identifier URI and define a scope for agents created from this blueprint if the agent is designed to receive incoming requests from other agents and users.

This guide walks you through creating an agent identity blueprint using the Microsoft Graph REST API and Microsoft Graph PowerShell.

## Prerequisites

- [Privileged Role Administrator](../../identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) role is required to grant Microsoft Graph Application permissions.
- [Cloud Application Administrator](../../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) or [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator) is required to grant Microsoft Graph delegated permissions.
- [Agent ID Developer](../../identity/role-based-access-control/permissions-reference.md#agent-id-developer) or [Agent ID Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) roles are required to create agent identity blueprints.
- If using PowerShell, version 7 is required.
- In preview, all operations with the agent identity blueprint require the beta version for both Microsoft Graph and PowerShell. 

## Prepare your environment

To streamline the process, take a few moments to get your environment set up for the right permissions and the beta version.

### Authorize a client to create agent identity blueprints

In this article, you use Microsoft Graph PowerShell or another client to create your agent identity blueprint. You must authorize this client to create and configure an agent identity blueprint and create an agent identity blueprint principal. The client requires the following Microsoft Graph permissions:

- [AgentIdentityBlueprint.Create](/graph/api/agentidentityblueprint-post?view=graph-rest-beta&preserve-view=true) delegated permission
- [AgentIdentityBlueprint.AddRemoveCreds.All](/graph/api/agentidentityblueprint-addpassword?view=graph-rest-beta&preserve-view=true) delegated permission
- [AgentIdentityBlueprint.ReadWrite.All](/graph/api/agentidentityblueprint-update?view=graph-rest-beta&preserve-view=true&tabs=http) delegated permission
- [AgentIdentityBlueprintPrincipal.Create](/graph/api/agentidentityblueprintprincipal-post?view=graph-rest-beta&preserve-view=true) delegated permission

The steps in this guide use all delegated permissions, but you can use application permissions for those scenarios that require them.

To connect to all of the required scopes for Microsoft Graph PowerShell, run the following command:

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create", "AgentIdentityBlueprint.AddRemoveCreds.All", "AgentIdentityBlueprint.ReadWrite.All", "AgentIdentityBlueprintPrincipal.Create", "User.Read" -TenantId <your-tenant-id>
```

### Use the beta version

Microsoft Entra Agent ID is in preview, so some steps are managed on the `/beta` endpoint of the Microsoft Graph API or require the beta version of the PowerShell module.

- For Microsoft Graph, ensure the version is set to beta.
- For PowerShell, install the beta version of the module using the following command:
    - `Install-Module Microsoft.Graph.Beta.Applications -Scope CurrentUser -Force`

## Create an agent identity blueprint

Agent identity blueprints must have a sponsor, which is the human user or group that's accountable for the agent. An owner is recommended, which is human the user or group that can make changes to the agent identity blueprint. For information, see [Administrative relationships in Microsoft Entra Agent ID](agent-owners-sponsors-managers.md).

#### [Microsoft Graph API](#tab/microsoft-graph-api)

This step creates the agent identity blueprint, assigns an owner and sponsor, and requires the following details:

- The `AgentIdentityBlueprint.Create` permission.
- The OData-Version header must be set to 4.0.
- An owner and a sponsor.

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

After creating the agent identity blueprint, record the value of the `appId` for the next step.

### [Microsoft Graph PowerShell](#tab/powershell)

This step creates the agent identity blueprint application, using the current user as the owner and sponsor, and includes the following distinct tasks:

- Connect to your tenant with `AgentIdentityBlueprint.Create` and `User.Read` scopes.
- Adds the current user as the sponsor and owner for the agent identity blueprint. 
- Create the agent identity blueprint application.

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create","User.Read" -TenantId <your-tenant-id>

$currentUser = Get-MgContext | Select-Object -ExpandProperty Account
$user = Get-MgUser -UserId $currentUser

Write-Host "Current user: $($user.DisplayName) ($($user.Id))"
Write-Host "Sponsor user: $($user.DisplayName) ($($user.Id))"


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

After creating the agent identity blueprint, record the value of the `appId` from the output.

---

## Configure credentials for the agent identity blueprint

To request access tokens using the agent identity blueprint, you must add a [client credential](../../identity-platform/v2-oauth2-client-creds-grant-flow.md). We recommend using a [managed identity](../../identity/managed-identities-azure-resources/overview.md) as a federated identity credential (FIC) for production deployments. Managed identities allow you to obtain Microsoft Entra tokens without having to manage any credentials. For more information, see [Managed identities for Azure resources](../../identity/managed-identities-azure-resources/overview.md).

Other kinds of app credentials including `keyCredentials`, `passwordCredentials`, and `trustedSubjectNameAndIssuers` are supported, but not recommended for production. They can be convenient for local development and testing or where managed identities won't work, but these options don't align with security best practices. For more information, see [Security best practices for application properties](../../identity-platform/security-best-practices-for-app-registration.md#credentials-including-certificates-and-secrets).

Keep in mind that to use a managed identity you must run your code on an Azure service, such as a virtual machine or Azure App Service. For local development and testing, use a [client secret](#other-app-credentials).

### [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request:
- You need the `AgentIdentityBlueprint.AddRemoveCreds.All` permission.
- Replace the `<agent-blueprint-id>` placeholder with the `appId` of the agent identity blueprint.
- Replace the  `<managed-identity-principal-id>` placeholder with the ID of your managed identity.

Add a managed identity as a credential using the following request:

```http
POST https://graph.microsoft.com/beta/applications/<agent-blueprint-id>/federatedIdentityCredentials
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
    "name": "my-managed-identity",
    "issuer": "https://login.microsoftonline.com/<your-tenant-id>/v2.0",
    "subject": "<managed-identity-principal-id>",
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

Connect-MgGraph -Scopes "AgentIdentityBlueprint.AddRemoveCreds.All" -TenantId <your-tenant-id>

$applicationId = "<agent-blueprint-id>"

$federatedCredential = @{
  Name             = "my-msi"
  Issuer           = "https://login.microsoftonline.com/<your-tenant-id>/v2.0"
  Subject          = "api://graph.agentIdentityBlueprintPrincipal/<my-agent-blueprint-principal>"
  Audiences         = @("api://AzureADTokenExchange")
}

New-MgBetaApplicationFederatedIdentityCredential `
  -ApplicationId $applicationId `
  -BodyParameter $federatedCredential
```

---

### Other app credentials

For scenarios where managed identities won't work or if you're creating a blueprint locally for testing, use the following steps to add the credentials.

#### [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the delegated permission `AgentIdentityBlueprint.AddRemoveCreds.All`

```http
POST https://graph.microsoft.com/beta/applications/<agent-blueprint-id>/addPassword
Content-Type: application/json
Authorization: Bearer <token>

{
  "passwordCredential": {
    "displayName": "My Secret",
    "endDateTime": "2026-08-05T23:59:59Z"
  }
}
```

#### [Microsoft Graph PowerShell](#tab/powershell)

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.AddRemoveCreds.All" -TenantId <your-tenant-id>

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

> [!NOTE]
> Your tenant might have credential lifecycle policies that restrict the maximum lifetime for client secrets. If you receive an error about credential lifetime, reduce the `endDateTime` value to align with your organization's policy.

Be sure to securely store the `passwordCredential` values generated. It can't be viewed after initial creation. You can also use client certificates as credentials; see [Add a certificate credential](/graph/api/application-addkey?tabs=http#example-3-add-a-certificate-credential-to-an-application).

If the agents created with the blueprint will support interactive agents, where the agent acts on behalf of a user, your blueprint must expose a scope so that the agent front end can pass an access token to the agent backend. This token can then be used by the agent backend to get an access token to act on behalf of the user.

## Configure identifier URI and scope

To receive incoming requests from users and other agents, you need to define an identifier URI and OAuth scope for your agent identity blueprint:

## [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request:
- You need the permission `AgentIdentityBlueprint.ReadWrite.All`.
- Replace the `<agent-blueprint-id>` placeholder with the `appId` of the agent identity blueprint.
- You need a Globally Unique Identifier (GUID). In PowerShell, run `[guid]::NewGuid()` or use an online GUID generator. Copy the generated GUID and use it to replace the `<generate-a-guid>` placeholder.

```http
PATCH https://graph.microsoft.com/beta/applications/<agent-blueprint-id>
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

A successful call generates a 204 response.

## [Microsoft Graph PowerShell](#tab/powershell)

This step currently requires the beta version of the module and includes the following distinct tasks:

- Install the beta version of the required module.
- Connect to your tenant with the `AgentIdentityBlueprint.ReadWrite.All` scope.
- Configure the URI and scope for the new agent identity blueprint.

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.ReadWrite.All" -TenantId <your-tenant-id>

$AppId = "<agent-blueprint-id>"
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

## Create an agent blueprint principal

In this step, you create a principal for the agent identity blueprint. For more information, see [Agent identities, service principals, and applications](agent-service-principals.md).

### [Microsoft Graph API](#tab/microsoft-graph-api)

Replace the `<agent-blueprint-app-id>` placeholder with the `appId` you copied from the results of the previous step.

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


After creating the agent identity blueprint, create an agent identity blueprint principal using the newly created agent identity blueprint `appId`.

Connect-MgGraph -Scopes "AgentIdentityBlueprint.Create", "User.Read", "AgentIdentityBlueprintPrincipal.Create" -TenantId `<your-tenant-id>`


```powershell
Connect-MgGraph -Scopes  -TenantId <your-tenant-id>
$body = @{
    appId   = "<agent-blueprint-client-id>"
}
Invoke-MgGraphRequest -Method POST `
        -Uri "https://graph.microsoft.com/beta/serviceprincipals/graph.agentIdentityBlueprintPrincipal" `
        -Headers @{ "OData-Version" = "4.0" } `
        -Body ($body | ConvertTo-Json)
```

---

## Delete an agent identity blueprint

When an agent is decommissioned or deleted, the associated agent identity blueprint should also be deleted. Before you delete an agent identity blueprint, you must first [remove all agent identities](create-delete-agent-identities.md#delete-an-agent-identity) and agent users associated with the agent. Then you can delete the agent identity blueprint and its service principal. Refer to the [Prepare your environment](#prepare-your-environment) section to make sure you have all the right prerequisites in place.


## [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you need the permission `AgentIdentityBlueprint.DeleteRestore.All`.

```http
DELETE https://graph.microsoft.com/beta/applications/<agent-blueprint-id>
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>
```

## [Microsoft Graph PowerShell](#tab/powershell)

This step currently requires the beta version of the module and includes the following distinct tasks:

- Install the beta version of the required module.
- Connect to your tenant with the `AgentIdentityBlueprint.DeleteRestore.All` scope.
- Replace the `<agent-blueprint-id>` placeholder with the `appId` of the agent identity blueprint.

```powershell
$Id = "<agent-blueprint-id>"

Invoke-MgBetaGraphRequest `
    -Method DELETE `
    -Uri "https://graph.microsoft.com/beta/applications/graph.agentIdentityBlueprint$($Id)" `
```

---

Your agent blueprint is now ready and visible in the [Microsoft Entra admin center](https://entra.microsoft.com). In the next step, you'll use this blueprint to [create agent identities](create-delete-agent-identities.md).

## Next step

> [!div class="nextstepaction"]
> [Create and delete agent identities](create-delete-agent-identities.md)
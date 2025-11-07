---
title: Request agent user tokens for autonomous agents
description: Learn how to create Agent ID users and authenticate using agent identities to obtain delegated access tokens for systems that require user accounts.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrcok

#customer-intent: As a developer, I want to create Agent ID users for my autonomous agents and authenticate as those users, so that my agents can connect to systems that require user account representation while maintaining proper security controls.
---

# Request agent user tokens for autonomous agents

In addition to requesting tokens using an agent identity, autonomous agents can also authenticate using an agent user. Agent users are a special type of user account in Microsoft Entra purpose-built for use by agents. They're most commonly used when an agent needs to connect to systems that require the existence of a user account. For instance, mailbox, teams channel, or other user-specific resources.

This guide walks you through creating an `AgentIdUser` in a tenant and requesting tokens as the `AgentIdUser`. Each agent identity can only have a single associated agent user, and vice versa. If you need multiple agent users, you need multiple agent identities.

## Prerequisites

Before creating and using agent users, ensure you have:

- A created Agent Blueprint and at least one agent identity as described in [Create and delete agent identities](create-delete-agent-identities.md)
- Understanding that each agent identity can only have a single associated agent user
- One of the following permissions to create agent users:
  - `AgentIdUser.ReadWrite.IdentityParentedBy` (recommended for Agent Blueprints)
  - `AgentIdUser.ReadWrite.All` (for other clients)

## Create the agent user

This section covers creating an agent user using your Agent Blueprint or other approved client.

The recommended way to create an agent user is using your Agent Blueprint with the `AgentIdUser.ReadWrite.IdentityParentedBy` permission, which gives your blueprint the ability to create agent users. Alternatively, agent users can be created using Microsoft Graph PowerShell or Graph Explorer with either `AgentIdUser.ReadWrite.IdentityParentedBy` or `User.ReadWrite.All` delegated permissions.

## [Microsoft Graph API](#tab/microsoft-graph-api)

Once you have an access token with the necessary permission, make the following request:

```http
POST https://graph.microsoft.com/beta/users
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
  "@odata.type": "microsoft.graph.agentUser",
  "displayName": "New Agent User",
  "userPrincipalName": "agentuserupn@tenant.onmicrosoft.com",
  "identityParentId": "{agent-identity-id}",
  "mailNickname": "agentuserupn",
  "accountEnabled": true
}
```

## [Microsoft Graph PowerShell](#tab/microsoft-graph-powershell)

```powershell
# Connect to Graph with beta profile
Connect-MgGraph -Scopes "User.ReadWrite.All"
Select-MgProfile -Name "beta"

# Define request body
$body = @{
    "@odata.type"       = "microsoft.graph.agentUser"
    displayName         = "New Agent User"
    userPrincipalName   = "agentuserupn@tenant.onmicrosoft.com"
    mailNickname        = "agentuserupn"
    accountEnabled      = $true
    identityParentId    = "{agent-identity-id}"
} | ConvertTo-Json -Depth 5

# Send request using the SDK's generic method
$response = Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/beta/users" -Body $body -ContentType "application/json"
$response | ConvertTo-Json -Depth 5
```

---

Once you have your agent user created, you don't need to configure anything else. These users don't have any credentials and can only be authenticated using an agent identity token as a federated identity credential (FIC). This FIC is determined during authentication time based on the user's identityParent value.

## Grant consent to agent identity

This section covers authorizing the agent identity to act on behalf of the agent user.

Agent users behave like any other user account. Before you can request tokens using your agent user, you need to authorize the agent identity to act on its behalf. You can authorize the agent identity using admin authorization as described in [Request authorization from Microsoft Entra admin](autonomous-agent-request-authorization-entra-admin.md). You can also obtain preauthorization for an Agent Blueprint registered in the Microsoft Services tenant, or manually create an oAuth2PermissionGrant.

## [Microsoft Graph API](#tab/microsoft-graph-api)

```http
POST https://graph.microsoft.com/v1.0/oauth2PermissionGrants
Authorization: Bearer {token}
Content-Type: application/json

{
  "clientId": "{agent-identity-id}",
  "consentType": "Principal",
  "principalId": "{agent-id-user-object-id}",
  "resourceId": "{ms-graph-service-principal-object-id}",
  "scope": "Mail.Read"
}
```

## [Microsoft Graph PowerShell](#tab/microsoft-graph-powershell)

```powershell
Connect-MgGraph -Scopes "DelegatedPermissionGrant.ReadWrite.All" -TenantId <your-test-tenant>

# Get the service principal for Microsoft Graph
$graphSp = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'"

# Get the service principal for your client app
$clientSp = Get-MgServicePrincipal -Filter "appId eq '{agent-identity-id}'"

# Create the delegated permission grant
New-MgOauth2PermissionGrant -BodyParameter @{
    clientId    = $clientSp.Id
    consentType = "Principal"
    principalId = "{agent-id-user-object-id}"
    resourceId  = $graphSp.Id
    scope       = "Mail.Read"
}
```

---

## Request agent user token

This section covers the three-step authentication process for agent users.

To authenticate an agent user, you need to follow a three-step process: get a token as the Agent Blueprint, use that token to get another token as the agent identity, and use both previous tokens to get another token as the agent user.

First, request a token as the Agent Blueprint, as described in [Request agent tokens](autonomous-agent-request-tokens.md). Once you have your agent blueprint token, use it to request a token for your agent identity:

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-identity-id>
&scope=api://AzureADTokenExchange/.default
&grant_type=client_credentials
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<agent-blueprint-token>
```

This example gives you an access token you can use to authenticate your agent user. To use it, make a request like:

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-identity-id>
&scope=https://graph.microsoft.com/.default
&grant_type=user_fic
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<agent-blueprint-token>
&user_id=<agent-user-object-id>
&user_federated_identity_credential=<agent-identity-token>
```

You can use `user_id=<user-object-id>` instead of `username=<UPN>` for the user identifier. It gives you a delegated access token you can use to call Microsoft Graph as your agent user.

## Related content

- [Request agent tokens](autonomous-agent-request-tokens.md)
- [Request authorization from Microsoft Entra admin](autonomous-agent-request-authorization-entra-admin.md)
- [Create and delete agent identities](create-delete-agent-identities.md)
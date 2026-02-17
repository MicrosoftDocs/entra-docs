---
title: Configure user authorization for interactive agents
description: Learn how to configure interactive agents to request delegated permissions from individual users through the OAuth authorization flow.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer, I want to configure my interactive agent to request delegated permissions from individual users, so that my agent can access resources on behalf of specific users who have granted consent.
---

# Configure user authorization for interactive agents

Agents often need to take actions on behalf of users that use the agent. To do so, interactive agents need to request delegated authorization from the user using the OAuth protocol. This article walks you through the process of requesting consent from a user using the agent identity. Steps include:

- Updating the agent identity blueprint with a redirect URI.
- Constructing an authorization request and redirecting the user to Microsoft Entra ID.

## Prerequisites

Before requesting user authorization, ensure you have:

- [An agent identity](create-delete-agent-identities.md)(create-delete-agent-identities.md)
- [OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow)

## Register a redirect URI

In order to support delegated permissions, your agent identity blueprint must be configured with a valid redirect URI. This URI is where Microsoft Entra ID sends users after they grant or deny consent to your agent.

## [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the delegated permission `AgentIdentityBlueprint.ReadWrite.All`.

```http
PATCH https://graph.microsoft.com/beta/applications/<agent-blueprint-id>
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
  "web": {
    "redirectUris": [
      "https://myagentapp.com/authorize"
    ]
  }
}
```

## [Microsoft Graph PowerShell](#tab/microsoft-graph-powershell)

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.ReadWrite.All" -TenantId <your-test-tenant>

$applicationId = "<agent-blueprint-id>"
$web = @{
    redirectUris= @(
        "https://myagentapp.com/authorize"
    )
}

$body = @{
    web   =  $web
}

Invoke-MgGraphRequest -Method PATCH `
        -Uri "https://graph.microsoft.com/beta/applications/$applicationId" `
        -Headers @{ "OData-Version" = "4.0" } `
        -Body ($body | ConvertTo-Json)
```

---

## Construct the authorization request URL

Now that your agent identity blueprint has a valid redirect URI, you can construct the authorization URL that is used to prompt the user to grant delegated permissions. The authorization URL follows the OAuth 2.0 authorization code flow standard.

Be sure to use the agent identity client ID in the following request, not the ID of the agent identity blueprint. Agent implementations might redirect the user to this URL in various ways, such as including it in a message sent to the user in a chat window.

```http
https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize?
  client_id=<agent-identity-id>
  &response_type=none
  &redirect_uri=https%3A%2F%2Fmyagentapp.com%2Fauthorize
  &response_mode=query
  &scope=User.Read
  &state=xyz123
```

When the user is redirected to this URL, they're asked to sign in and grant consent to the permissions specified in the scope parameter. After you grant consent, the user is returned to the specified redirect URI.

The key parameters in the authorization URL are:

- `client_id`: Use the agent identity client ID (not the agent identity blueprint client ID)
- `response_type`: Set to `none` for authorization code flow
- `redirect_uri`: Must match exactly what you configured in the previous step
- `scope`: Specify the delegated permissions you need (for example, `User.Read`)
- `state`: Optional parameter for maintaining state between the request and callback

## Related content

- [Sign-in users](interactive-agent-authenticate-user.md) for basic interactive agent authentication
- [Request user tokens](interactive-agent-request-user-tokens.md) for implementing the On-Behalf-Of flow
- [Permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview) for detailed OAuth concepts

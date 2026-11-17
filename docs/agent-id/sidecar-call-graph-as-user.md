---
title: Call Microsoft Graph as a user with the Auth SDK sidecar
description: Use the Auth SDK sidecar and On-Behalf-Of flow to call Microsoft Graph with delegated permissions.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock
---

# Call Microsoft Graph as a user with the Auth SDK sidecar

Use delegated Microsoft Graph permissions when an operation should run with the signed-in user's access.

## Prerequisites

- Completion of [Authenticate users with the Auth SDK sidecar](sidecar-authenticate-users.md), including consent for the upstream client to call the agent.
- Consent for the Microsoft Graph delegated permissions required by the operation.

## Configure access

1. Declare the Microsoft Graph delegated permission `User.Read` on the blueprint.
1. [Obtain user or administrator consent](grant-agent-access-microsoft-365.md) for `User.Read` on the agent identity.
1. Configure a sidecar API, such as `graph`, with the Microsoft Graph base URL and delegated scopes.

Request only the scopes required by the operation.

## Configure the sidecar

Add a delegated profile for Microsoft Graph:

```json
{
  "DownstreamApis": {
    "graph": {
      "BaseUrl": "https://graph.microsoft.com/v1.0/",
      "Scopes": [
        "User.Read"
      ]
    }
  }
}
```

Replace `User.Read` with the delegated Microsoft Graph permissions required by the operation. Use the shared client ID and keep identity overrides disabled as described in [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md).

## Read the signed-in user's profile

This example uses Node.js 18 or later and the built-in Fetch API. Pass the access token issued to the signed-in user for your agent API to the function. `User.Read` is the least-privileged delegated permission for this request.

The sidecar request uses the configured delegated profile and the inbound user token:

```http
GET /AuthorizationHeader/graph
Authorization: Bearer <agent-api-access-token>
```

```javascript
async function getMyGraphProfile(agentApiAccessToken) {
  const tokenResponse = await fetch("http://localhost:5000/AuthorizationHeader/graph", {
    headers: { Authorization: `Bearer ${agentApiAccessToken}` }
  });
  if (!tokenResponse.ok) {
    throw new Error(`Sidecar token request failed (HTTP ${tokenResponse.status}); check the inbound user token and User.Read consent.`);
  }
  const { authorizationHeader } = await tokenResponse.json();

  const response = await fetch("https://graph.microsoft.com/v1.0/me?$select=id,displayName", {
    headers: { Authorization: authorizationHeader }
  });
  if (!response.ok) {
    throw new Error(`Microsoft Graph returned HTTP ${response.status}; verify User.Read consent and the signed-in user's access.`);
  }
  return response.json();
}
```

Call `getMyGraphProfile(agentApiAccessToken)` while handling that user's request. A successful request returns `200 OK` with that user's ID and display name. If Graph returns `403`, verify that `User.Read` is consented and the access token represents the expected signed-in user; then retry. If the sidecar returns `401`, check that the inbound token is an access token for the agent API and that delegated consent is in place. After changing consent, retry with a newly issued agent API access token. Don't replace this flow with an app-only token or `/AuthorizationHeaderUnauthenticated`; Microsoft Graph doesn't support application permissions for `/me`. See the [Get a user API](/graph/api/user-get) for the delegated permission requirement.

## Related content

- [Microsoft Graph permissions reference](/graph/permissions-reference)
- [Microsoft identity platform On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)

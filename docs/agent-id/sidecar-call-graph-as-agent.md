---
title: Call Microsoft Graph as an agent with the Auth SDK sidecar
description: Use an app-only Agent ID token from the Auth SDK sidecar to call Microsoft Graph.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock
---

# Call Microsoft Graph as an agent with the Auth SDK sidecar

Use application permissions when an autonomous agent calls Microsoft Graph without a signed-in user.

## Prerequisites

- Completion of [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md), including the agent's registration and client ID.
- Administrator consent for the Microsoft Graph application permission `Organization.Read.All` on the Agent ID.

## Configure access

1. [Grant the Microsoft Graph application permission `Organization.Read.All`](grant-application-permissions-agent-identity.md) to the Agent ID and have an administrator consent to it.
1. Configure a sidecar API, such as `graph-app`, with the Microsoft Graph base URL and `https://graph.microsoft.com/.default` scope.

Application permissions can provide broad tenant access. Grant only the permissions required by the scenario.

## Configure the sidecar

Add an app-only profile for Microsoft Graph with the configured client ID:

```json
{
  "DownstreamApis": {
    "graph-app": {
      "BaseUrl": "https://graph.microsoft.com/v1.0/",
      "Scopes": [
        "https://graph.microsoft.com/.default"
      ],
      "RequestAppToken": true
    }
  }
}
```

For the blueprint identity, credential, and container configuration, see [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md).

## Read the organization with Microsoft Graph

This example uses Node.js 18 or later and the built-in Fetch API. Run it from the agent; don't pass a user token or identity override.

The sidecar request uses the configured app-only profile:

```http
GET /AuthorizationHeaderUnauthenticated/graph-app
```

```javascript
async function getOrganizationAsAgent() {
  const tokenResponse = await fetch("http://localhost:5000/AuthorizationHeaderUnauthenticated/graph-app");
  if (!tokenResponse.ok) {
    throw new Error(`Sidecar token request failed (HTTP ${tokenResponse.status}); check the profile, credential, and admin consent.`);
  }
  const { authorizationHeader } = await tokenResponse.json();

  const response = await fetch("https://graph.microsoft.com/v1.0/organization?$select=id,displayName", {
    headers: { Authorization: authorizationHeader }
  });
  if (!response.ok) {
    throw new Error(`Microsoft Graph returned HTTP ${response.status}; verify Organization.Read.All is consented for the Agent ID.`);
  }
  return response.json();
}
```

Call `getOrganizationAsAgent()` from the agent. A successful request returns `200 OK` and one organization object containing its ID and display name. If Graph returns `403`, verify that `Organization.Read.All` is granted to the Agent ID and admin consent is current; then retry. If the sidecar returns `401`, check token acquisition and the `graph-app` profile. Don't log the authorization header. See the [List organizations API](/graph/api/organization-list) for its application permission requirements.

## Next step

[Authenticate users to the agent](sidecar-authenticate-users.md)

## Related content

- [Microsoft Graph permissions reference](/graph/permissions-reference)
- [Auth SDK sidecar endpoint reference](/entra/msidweb/agent-id-sdk/endpoints)

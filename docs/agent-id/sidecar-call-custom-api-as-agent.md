---
title: Call a custom API as an agent with the Auth SDK sidecar
description: Use an app-only Agent ID token from the Auth SDK sidecar to call a custom protected API.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock
---

# Call a custom API as an agent with the Auth SDK sidecar

Use app-only access when a cloud agent performs scheduled, event-driven, or other autonomous work without a signed-in user. This article calls a custom API, but the same sidecar flow applies to Azure services and Microsoft Graph.

In this article, you configure application permissions and use the sidecar to acquire an app-only authorization header or call the API.

## Prerequisites

- Completion of [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md), including the agent's registration, client ID, and credential.
- An application permission exposed by the custom API.

## Configure access

1. Expose an application permission on the custom API.
1. [Grant that permission to the Agent ID and verify administrator consent](call-api-custom.md#grant-application-permissions). Use the shared client ID for consent and the agent identity's object ID when verifying the app role assignment.
1. Configure the API in the sidecar with its base URL and `api://<api-client-id>/.default` scope.
1. Configure the API to validate the Agent ID token and required app role.

## Configure the sidecar

The agent calls the sidecar through loopback in their shared network namespace. The sidecar uses the configured client ID and credential to acquire an authorization header for the API.

Add an app-only profile for the custom API. Keep identity overrides disabled as described in the sidecar setup:

```json
{
  "DownstreamApis": {
    "custom-api": {
      "BaseUrl": "https://api.contoso.com/",
      "Scopes": [
        "api://<custom-api-client-id>/.default"
      ],
      "RequestAppToken": true
    }
  }
}
```

For the blueprint identity, credential, and container configuration, see [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md).

## Get a token and call the API

```http
GET /AuthorizationHeaderUnauthenticated/custom-api
```

Send the returned `authorizationHeader` to the custom API. Don't pass an `AgentIdentity` override or send the blueprint credential to the API.

The API must verify the token's signature, issuer, audience, expiry, Agent ID claims, and required `roles` value.

Alternatively, use `POST /DownstreamApiUnauthenticated/custom-api` to have the sidecar call the configured API. No identity override is needed.

Confirm that the API operation succeeds with the required role and rejects a request without that role. A successful token response alone doesn't establish API authorization. Don't log the authorization header.

## Next step

[Authenticate users to the agent](sidecar-authenticate-users.md)

## Related content

- [Build a platform that hosts an agent fleet](plan-agent-fleet.md)
- [Validate Agent ID tokens in a downstream API](how-to-validate-agent-tokens-downstream-api.md)
- [Auth SDK sidecar endpoint reference](/entra/msidweb/agent-id-sdk/endpoints)

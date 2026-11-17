---
title: Call a custom API as a user with the Auth SDK sidecar
description: Use the Auth SDK sidecar and On-Behalf-Of flow to call a custom API for the signed-in user.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock
---

# Call a custom API as a user with the Auth SDK sidecar

Use the OAuth On-Behalf-Of (OBO) flow when an upstream client calls an agent for a signed-in user and the agent calls a custom API for that user.

The agent first validates the inbound access token, then forwards the same authorization header to the sidecar. The sidecar uses its configured credential to get a downstream authorization header for that user.

## Prerequisites

- Completion of [Authenticate users with the Auth SDK sidecar](sidecar-authenticate-users.md), including consent for the upstream client to call the agent.
- A delegated scope exposed by the downstream API.
- Consent for the agent to call that API for the user.

## Configure access

1. Expose a delegated scope on the custom API.
1. Declare the scope in the blueprint's `requiredResourceAccess`.
1. [Obtain user or administrator consent](grant-agent-access-microsoft-365.md) for the agent identity to use that scope.
1. Configure the API and scope in the sidecar.

## Configure the sidecar

Add a delegated profile for the custom API:

```json
{
  "DownstreamApis": {
    "custom-api": {
      "BaseUrl": "https://api.contoso.com/",
      "Scopes": [
        "api://<custom-api-client-id>/<delegated-scope>"
      ]
    }
  }
}
```

Use the shared client ID and keep identity overrides disabled as described in [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md).

## Get a downstream token

Forward the token issued for the agent API:

```http
GET /AuthorizationHeader/custom-api
Authorization: ******
```

Send the returned `authorizationHeader` to the custom API. The custom API must validate the token and enforce the required scope and user authorization.

Don't send the inbound token directly to the custom API. It is intended for the agent, not the downstream resource. Don't return or log either authorization header.

## Call the sidecar and custom API

The following example forwards the inbound user authorization header to the sidecar, reads the downstream authorization header, and calls the custom API:

# [Python](#tab/python)

```python
import requests

SIDECAR_URL = "http://localhost:5000"

inbound_auth_header = "<authorization-header-from-agent-request>"

sidecar_response = requests.get(
    f"{SIDECAR_URL}/AuthorizationHeader/custom-api",
    headers={"Authorization": inbound_auth_header},
    timeout=5,
)

if sidecar_response.status_code in (401, 403):
    raise PermissionError("The sidecar rejected the user token or OBO request.")

sidecar_response.raise_for_status()
authorization_header = sidecar_response.json()["authorizationHeader"]

api_response = requests.get(
    "https://api.contoso.com/user-data",
    headers={"Authorization": authorization_header},
    timeout=10,
)
api_response.raise_for_status()
response_body = api_response.json()
```

# [JavaScript](#tab/javascript)

```javascript
const SIDECAR_URL = "http://localhost:5000";

const inboundAuthHeader = "<authorization-header-from-agent-request>";

const sidecarResponse = await fetch(
    `${SIDECAR_URL}/AuthorizationHeader/custom-api`,
    { headers: { Authorization: inboundAuthHeader } }
);

if (sidecarResponse.status === 401 || sidecarResponse.status === 403) {
    throw new Error("The sidecar rejected the user token or OBO request.");
}

if (!sidecarResponse.ok) {
    throw new Error(`Sidecar request failed with status ${sidecarResponse.status}.`);
}

const { authorizationHeader } = await sidecarResponse.json();

const apiResponse = await fetch("https://api.contoso.com/user-data", {
    headers: { Authorization: authorizationHeader },
});

if (!apiResponse.ok) {
    throw new Error(`API request failed with status ${apiResponse.status}.`);
}

const responseBody = await apiResponse.json();
```

---

Keep `SIDECAR_URL` on loopback in the shared network namespace. Replace the authorization-header placeholder with the complete `Authorization` header received by the agent. Process `responseBody` according to the custom API's response contract.

Treat the sidecar response as a credential. Don't log or return `authorizationHeader`.

Verify that the API enforces the delegated scope and the user's access. If OBO reports missing consent, check upstream access to the agent separately from downstream consent; the OBO exchange can't display a consent prompt.

## Related content

- [Validate Agent ID tokens in a downstream API](how-to-validate-agent-tokens-downstream-api.md)
- [Microsoft identity platform On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)

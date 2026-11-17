---
title: Call APIs as a user in a fleet with the Auth SDK sidecar
description: Use the On-Behalf-Of flow with the routed agent's identity to call APIs for a signed-in user through the Auth SDK sidecar in a shared runtime.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with the Auth SDK sidecar, I want agents in my fleet to call APIs on behalf of the signed-in user with their own agent identity.
---

# Call APIs as a user in a fleet with the Auth SDK sidecar

After the runtime routes a user's request to an agent, the agent can call APIs for that user with the On-Behalf-Of (OBO) flow. Forward the user's token to the sidecar, and pass the routed agent's identity in the `AgentIdentity` parameter. The downstream token represents both the signed-in user and that agent.

## Prerequisites

- Complete [Authenticate users and route requests to agents in a fleet with the Auth SDK sidecar](sidecar-fleet-authenticate-users.md).
- Delegated permissions for the target API, [granted to the agent identity](grant-agent-access-microsoft-365.md) or [inherited from the blueprint](set-up-blueprint-agent-fleet.md#optionally-configure-inheritable-permissions).

## Configure the sidecar

Add a delegated profile for each API to the runtime sidecar:

```json
{
  "Sidecar": {
    "AllowOverrides": {
      "GetAuthorizationHeader": true
    }
  },
  "DownstreamApis": {
    "custom-api-user": {
      "BaseUrl": "https://api.contoso.com/",
      "Scopes": [
        "api://<custom-api-client-id>/<delegated-scope>"
      ]
    }
  }
}
```

Explicitly enable `GetAuthorizationHeader` as shown, even if you previously disabled overrides by following the single-instance setup. Otherwise the sidecar ignores `AgentIdentity`. Only trusted runtime code should select and send identity overrides.

## Get a token for the signed-in user

After routing the request and confirming the user can access the agent, call the sidecar:

# [Python](#tab/python)

```python
def authorization_header_for_user(
    inbound_auth_header: str, agent_id: str, api_name: str
) -> str:
    registration = directory.find(agent_id)

    response = requests.get(
        f"{SIDECAR_URL}/AuthorizationHeader/{api_name}",
        params={"AgentIdentity": registration["agent_identity_id"]},
        headers={"Authorization": inbound_auth_header},
        timeout=5,
    )
    if response.status_code in (401, 403):
        raise PermissionError("The sidecar rejected the user token or OBO request.")
    response.raise_for_status()
    return response.json()["authorizationHeader"]


inbound_auth_header = request.headers.get("Authorization")
authorize_agent_request(inbound_auth_header, agent_id)

api_response = requests.get(
    "https://api.contoso.com/user-data",
    headers={
        "Authorization": authorization_header_for_user(
            inbound_auth_header, agent_id, "custom-api-user"
        )
    },
    timeout=10,
)
api_response.raise_for_status()
```

# [JavaScript](#tab/javascript)

```javascript
async function authorizationHeaderForUser(inboundAuthHeader, agentId, apiName) {
    const registration = await directory.find(agentId);

    const params = new URLSearchParams({
        AgentIdentity: registration.agentIdentityId,
    });
    const response = await fetch(
        `${SIDECAR_URL}/AuthorizationHeader/${apiName}?${params}`,
        { headers: { Authorization: inboundAuthHeader } }
    );
    if (response.status === 401 || response.status === 403) {
        throw new Error("The sidecar rejected the user token or OBO request.");
    }
    if (!response.ok) {
        throw new Error(`Sidecar request failed with status ${response.status}.`);
    }
    const { authorizationHeader } = await response.json();
    return authorizationHeader;
}

const inboundAuthHeader = req.headers.authorization;
await authorizeAgentRequest(inboundAuthHeader, req.params.agentId);

const apiResponse = await fetch("https://api.contoso.com/user-data", {
    headers: {
        Authorization: await authorizationHeaderForUser(
            inboundAuthHeader, req.params.agentId, "custom-api-user"
        ),
    },
});
```

---

Always use the agent ID that passed the access check. If the runtime used a different agent's identity, the downstream API would see the wrong agent acting for the user. Don't send the inbound token directly to the downstream API, and don't log either authorization header.

## Call specific resources

Use the scopes and endpoints from the linked resource articles, while keeping the fleet's blueprint client ID and override settings. The single-instance requests omit `AgentIdentity`. For each fleet resource request, call `authorization_header_for_user` or `authorizationHeaderForUser` to supply the routed agent identity and inbound user token.

| Resource | Guidance |
| --- | --- |
| Custom API | [Call a custom API as a user](sidecar-call-custom-api-as-user.md) |
| Azure services | [Call Azure services as a user](sidecar-call-azure-api-as-user.md) |
| Microsoft Graph | [Call Microsoft Graph as a user](sidecar-call-graph-as-user.md) |

## Related content

- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)
- [Inheritable permissions](concept-inheritable-permissions.md)
- [OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)

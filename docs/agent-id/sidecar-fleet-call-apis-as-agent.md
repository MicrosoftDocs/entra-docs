---
title: Call APIs as an agent in a fleet with the Auth SDK sidecar
description: Select the agent identity for each app-only token request to the Auth SDK sidecar in a shared runtime that hosts many agents.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with the Auth SDK sidecar, I want each agent in my fleet to call APIs with its own agent identity.
---

# Call APIs as an agent in a fleet with the Auth SDK sidecar

In a fleet, the sidecar acquires app-only tokens for many agents with one blueprint credential. Look up the agent's identity in the agent directory, and pass it in the `AgentIdentity` parameter on each request. The request is otherwise the same as for a single agent.

## Prerequisites

- Complete [Provision agent identities for a fleet with the Auth SDK sidecar](sidecar-fleet-provision-agent-identities.md).
- Application permissions for the target API, [granted to the agent identity](grant-application-permissions-agent-identity.md) or [inherited from the blueprint](set-up-blueprint-agent-fleet.md#optionally-configure-inheritable-permissions).

## Configure the runtime sidecar

Configure the sidecar with the blueprint credential, as described in [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md). Set `AzureAd:ClientId` to the fleet's blueprint client ID. Unlike the single-instance setup, the fleet runtime must enable `GetAuthorizationHeaderUnauthenticated` and define an app-only profile for each API:

```json
{
  "Sidecar": {
    "AllowOverrides": {
      "GetAuthorizationHeaderUnauthenticated": true
    }
  },
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

The sidecar accepts only local requests. Colocate the trusted runtime and its sidecar in the same network namespace, such as a Kubernetes pod. For Docker Compose, use `network_mode: "service:sidecar"` on the runtime container and call `http://localhost:5000`, not `http://sidecar:5000`. Don't publish the sidecar port.

With the override enabled, any process that can reach the sidecar can request a token for any agent in the fleet. Only trusted runtime code should reach the sidecar. If agents run untrusted or customer-supplied code, run them outside the sidecar's network namespace and route their token requests through runtime code that selects the agent identity.

## Get a token for an agent

Resolve the agent identity from the runtime's own agent ID, never from a value in a request or in agent output:

# [Python](#tab/python)

```python
import requests

SIDECAR_URL = "http://localhost:5000"


def authorization_header_for_agent(agent_id: str, api_name: str) -> str:
    registration = directory.find(agent_id)
    if registration is None:
        raise LookupError(f"Agent '{agent_id}' isn't provisioned.")

    response = requests.get(
        f"{SIDECAR_URL}/AuthorizationHeaderUnauthenticated/{api_name}",
        params={"AgentIdentity": registration["agent_identity_id"]},
        timeout=5,
    )
    response.raise_for_status()
    return response.json()["authorizationHeader"]


api_response = requests.get(
    "https://api.contoso.com/data",
    headers={"Authorization": authorization_header_for_agent(agent_id, "custom-api")},
    timeout=10,
)
api_response.raise_for_status()
```

# [JavaScript](#tab/javascript)

```javascript
const SIDECAR_URL = "http://localhost:5000";

async function authorizationHeaderForAgent(agentId, apiName) {
    const registration = await directory.find(agentId);
    if (!registration) {
        throw new Error(`Agent '${agentId}' isn't provisioned.`);
    }

    const params = new URLSearchParams({
        AgentIdentity: registration.agentIdentityId,
    });
    const response = await fetch(
        `${SIDECAR_URL}/AuthorizationHeaderUnauthenticated/${apiName}?${params}`
    );
    if (!response.ok) {
        throw new Error(`Sidecar request failed with status ${response.status}.`);
    }
    const { authorizationHeader } = await response.json();
    return authorizationHeader;
}

const apiResponse = await fetch("https://api.contoso.com/data", {
    headers: { Authorization: await authorizationHeaderForAgent(agentId, "custom-api") },
});
```

---

Treat the returned `authorizationHeader` as a credential, and don't log it.

## Call specific resources

Use the scopes and endpoints from the linked resource articles, while keeping the fleet's blueprint client ID and override settings. The single-instance requests omit `AgentIdentity`. In the fleet, call `authorization_header_for_agent` or `authorizationHeaderForAgent` for every resource to supply the identity selected from the directory.

| Resource | Guidance |
| --- | --- |
| Custom API | [Call a custom API as an agent](sidecar-call-custom-api-as-agent.md) |
| Azure services | [Call Azure services as an agent](sidecar-call-azure-api-as-agent.md) |
| Microsoft Graph | [Call Microsoft Graph as an agent](sidecar-call-graph-as-agent.md) |

## Next step

[Call APIs as an agent's user account in a fleet with the Auth SDK sidecar](sidecar-fleet-call-apis-as-agent-user.md)

## Related content

- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)
- [Auth SDK sidecar endpoint reference](/entra/msidweb/agent-id-sdk/endpoints)

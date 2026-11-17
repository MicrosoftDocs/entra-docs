---
title: Authenticate users and route requests to agents in a fleet with the Auth SDK sidecar
description: Validate user access tokens with the Auth SDK sidecar, route each request to an agent in a shared runtime, and enforce per-agent access.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with the Auth SDK sidecar, I want to authenticate users and make sure they can only reach the agents they're allowed to use.
---

# Authenticate users and route requests to agents in a fleet with the Auth SDK sidecar

Users call a fleet agent with an access token for the blueprint's `access_agent` scope. Every agent in the fleet shares that audience, so token validation proves who the user is but not which agent they're allowed to use. The runtime routes each request to an agent and enforces per-agent access itself.

## Prerequisites

- Complete [Call APIs as an agent in a fleet with the Auth SDK sidecar](sidecar-fleet-call-apis-as-agent.md).
- The `access_agent` scope [exposed on the blueprint](set-up-blueprint-agent-fleet.md#expose-the-inbound-scope).
- An upstream client that signs in users and requests the scope `api://<agent-identity-blueprint-client-id>/access_agent`.

## Configure token validation

Token validation is the same as for a single agent. Configure the sidecar with the blueprint client ID and the `access_agent` scope, and validate each inbound token with `GET /Validate`. For details, see [Authenticate users with the Auth SDK sidecar](sidecar-authenticate-users.md). Keep the fleet's per-request identity overrides from the preceding articles and the shared network namespace for local sidecar requests; don't replace them with the single-instance defaults.

To limit which users can call the fleet at all, [require an app role assignment](sidecar-control-user-access-agents.md) on the blueprint principal. Those app roles apply to every agent in the fleet.

## Enforce per-agent access

Decide who can use each agent, and store that decision in the runtime. For example, record the users and groups that an agent's owner shares it with. Identify the user by the validated `tid` and `oid` claims. Don't use the user principal name or email as a stable key.

## Route requests to agents

Put the runtime's agent ID in the route. Validate the token, confirm the agent exists, and check the access policy before running the agent. The following examples assume an `access_policy` object that implements the runtime's per-agent access check.

# [Python](#tab/python)

```python
import requests

SIDECAR_URL = "http://localhost:5000"


class AgentNotFound(Exception):
    """Return 404 Not Found to the caller."""


def authorize_agent_request(inbound_auth_header: str, agent_id: str) -> dict:
    response = requests.get(
        f"{SIDECAR_URL}/Validate",
        headers={"Authorization": inbound_auth_header},
        timeout=5,
    )
    if response.status_code in (401, 403):
        raise PermissionError("The sidecar rejected the caller's access token.")
    response.raise_for_status()

    result = response.json()
    claims = result.get("claims", {})
    object_id = claims.get("oid")
    tenant_id = claims.get("tid")
    if (
        result.get("protocol", "").lower() != "bearer"
        or not object_id
        or not tenant_id
    ):
        raise PermissionError("The token isn't a validated user bearer token.")

    scopes = claims.get("scp", "").split()
    if "access_agent" not in scopes:
        raise PermissionError("The token doesn't contain the access_agent scope.")

    if directory.find(agent_id) is None or not access_policy.can_use_agent(
        tenant_id, object_id, agent_id
    ):
        raise AgentNotFound(agent_id)

    return claims


# For a request to POST /agents/{agent_id}/messages:
claims = authorize_agent_request(request.headers.get("Authorization"), agent_id)
```

# [JavaScript](#tab/javascript)

```javascript
const SIDECAR_URL = "http://localhost:5000";

class AgentNotFoundError extends Error {}

async function authorizeAgentRequest(inboundAuthHeader, agentId) {
    const response = await fetch(`${SIDECAR_URL}/Validate`, {
        headers: { Authorization: inboundAuthHeader },
    });
    if (response.status === 401 || response.status === 403) {
        throw new Error("The sidecar rejected the caller's access token.");
    }
    if (!response.ok) {
        throw new Error(`Sidecar validation failed with status ${response.status}.`);
    }

    const { protocol, claims = {} } = await response.json();
    const objectId = claims.oid;
    const tenantId = claims.tid;
    if (protocol?.toLowerCase() !== "bearer" || !objectId || !tenantId) {
        throw new Error("The token isn't a validated user bearer token.");
    }

    const scopes = (claims.scp ?? "").split(" ");
    if (!scopes.includes("access_agent")) {
        throw new Error("The token doesn't contain the access_agent scope.");
    }

    if (!(await directory.find(agentId))
        || !(await accessPolicy.canUseAgent(tenantId, objectId, agentId))) {
        throw new AgentNotFoundError(agentId);
    }

    return claims;
}

// For a request to POST /agents/:agentId/messages:
const claims = await authorizeAgentRequest(req.headers.authorization, req.params.agentId);
```

---

Return `401 Unauthorized` when the token is missing or invalid. Return `404 Not Found` both for an unknown agent and for an agent the user can't use, so callers can't discover other agents in the fleet. After these checks pass, use the same agent ID for every token request made while handling the request.

## Next step

[Call APIs as a user in a fleet with the Auth SDK sidecar](sidecar-fleet-call-apis-as-user.md)

## Related content

- [Authenticate users with the Auth SDK sidecar](sidecar-authenticate-users.md)
- [Control user access to agents with the Auth SDK sidecar](sidecar-control-user-access-agents.md)
- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)

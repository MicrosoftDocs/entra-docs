---
title: Provision agent identities for a fleet with the Auth SDK sidecar
description: Use an app-only blueprint token from the Auth SDK sidecar to create and delete agent identities and agent's user accounts as agents are deployed and retired.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with the Auth SDK sidecar, I want to create an agent identity for each agent I deploy so that every agent in my fleet has its own identity.
---

# Provision agent identities for a fleet with the Auth SDK sidecar

When an agent is deployed to the fleet, the provisioning service gets an app-only token for the agent identity blueprint from the sidecar and calls Microsoft Graph. It creates an agent identity and, if the agent needs one, an agent's user account. It records both in the agent directory so the runtime can select them on later token requests. When the agent is retired, the service deletes both identities.

## Prerequisites

- Complete [Set up an agent identity blueprint for a fleet](set-up-blueprint-agent-fleet.md).
- A user or group to assign as each agent's sponsor.
- A verified domain in the tenant for agent's user account user principal names, if agents need them.
- A persistent store for the agent directory, such as a database table.

## Configure a provisioning sidecar

Run a sidecar for the provisioning service with the blueprint credential, as described in [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md). Set `AzureAd:ClientId` to the fleet's blueprint client ID, and keep identity overrides disabled on this provisioning instance. Add an app-only Microsoft Graph profile:

```json
{
  "DownstreamApis": {
    "graph-provisioning": {
      "BaseUrl": "https://graph.microsoft.com/",
      "Scopes": [
        "https://graph.microsoft.com/.default"
      ],
      "RequestAppToken": true
    }
  }
}
```

The provisioning service requests a token without an `AgentIdentity` parameter, so the sidecar returns a token for the blueprint itself. That token can create and delete identities across the fleet.

Use a separate sidecar instance for provisioning. The sidecar accepts only local requests, so colocate it with the provisioning service in the same network namespace, such as a Kubernetes pod. For Docker Compose, use `network_mode: "service:provisioning-sidecar"` on the provisioning service and call `http://localhost:5000`, not the sidecar's DNS name. Don't publish the sidecar port or add the `graph-provisioning` profile to the sidecar that agents use for their own tokens.

## Define the agent directory

The agent directory maps the runtime's agent ID to the agent's identities. Later articles in this path use it to select the identity for each token request.

| Field | Value | Used by |
| --- | --- | --- |
| `agent_id` | The runtime's own identifier for the agent. | Lookups |
| `agent_identity_id` | The agent identity's ID. For an agent identity, the object ID (`id`) and client ID (`appId`) are the same value. | The `AgentIdentity` parameter, creating the agent's user account, and deleting the agent identity |
| `agent_user_id` | The agent's user account object ID, or empty. | The `AgentUserId` parameter and deletion |

The examples use a `directory` object with `find`, `save`, and `delete` methods. Replace it with your store.

## Provision an agent

Call the provisioning code from the code that deploys agents, not from an endpoint that agents or users can reach.

# [Python](#tab/python)

```python
import requests

SIDECAR_URL = "http://localhost:5000"
GRAPH_URL = "https://graph.microsoft.com"
BLUEPRINT_CLIENT_ID = "<agent-identity-blueprint-client-id>"


def graph_headers() -> dict:
    """Get an app-only blueprint authorization header from the sidecar."""
    response = requests.get(
        f"{SIDECAR_URL}/AuthorizationHeaderUnauthenticated/graph-provisioning",
        timeout=5,
    )
    response.raise_for_status()
    return {"Authorization": response.json()["authorizationHeader"]}


def provision_agent(agent_id, display_name, sponsor_user_id, agent_upn=None) -> dict:
    registration = directory.find(agent_id)

    if registration is None:
        response = requests.post(
            f"{GRAPH_URL}/beta/serviceprincipals/Microsoft.Graph.AgentIdentity",
            headers=graph_headers(),
            json={
                "@odata.type": "#Microsoft.Graph.AgentIdentity",
                "displayName": display_name,
                "agentIdentityBlueprintId": BLUEPRINT_CLIENT_ID,
                "sponsors@odata.bind": [
                    f"{GRAPH_URL}/v1.0/users/{sponsor_user_id}"
                ],
            },
            timeout=10,
        )
        response.raise_for_status()
        identity = response.json()
        registration = {
            "agent_id": agent_id,
            "agent_identity_id": identity["id"],
            "agent_user_id": None,
        }
        directory.save(registration)

    if agent_upn and registration["agent_user_id"] is None:
        response = requests.post(
            f"{GRAPH_URL}/v1.0/users/microsoft.graph.agentUser",
            headers=graph_headers(),
            json={
                "accountEnabled": True,
                "displayName": display_name,
                "mailNickname": agent_upn.split("@")[0],
                "userPrincipalName": agent_upn,
                "identityParentId": registration["agent_identity_id"],
            },
            timeout=10,
        )
        response.raise_for_status()
        registration["agent_user_id"] = response.json()["id"]
        directory.save(registration)

    return registration
```

# [JavaScript](#tab/javascript)

```javascript
const SIDECAR_URL = "http://localhost:5000";
const GRAPH_URL = "https://graph.microsoft.com";
const BLUEPRINT_CLIENT_ID = "<agent-identity-blueprint-client-id>";

async function graphHeaders() {
    const response = await fetch(
        `${SIDECAR_URL}/AuthorizationHeaderUnauthenticated/graph-provisioning`
    );
    if (!response.ok) {
        throw new Error(`Sidecar request failed with status ${response.status}.`);
    }
    const { authorizationHeader } = await response.json();
    return {
        Authorization: authorizationHeader,
        "Content-Type": "application/json",
    };
}

async function graphPost(path, body) {
    const response = await fetch(`${GRAPH_URL}${path}`, {
        method: "POST",
        headers: await graphHeaders(),
        body: JSON.stringify(body),
    });
    if (!response.ok) {
        throw new Error(`Microsoft Graph request failed with status ${response.status}.`);
    }
    return response.json();
}

async function provisionAgent(agentId, displayName, sponsorUserId, agentUpn) {
    let registration = await directory.find(agentId);

    if (!registration) {
        const identity = await graphPost(
            "/beta/serviceprincipals/Microsoft.Graph.AgentIdentity",
            {
                "@odata.type": "#Microsoft.Graph.AgentIdentity",
                displayName,
                agentIdentityBlueprintId: BLUEPRINT_CLIENT_ID,
                "sponsors@odata.bind": [`${GRAPH_URL}/v1.0/users/${sponsorUserId}`],
            }
        );
        registration = {
            agentId,
            agentIdentityId: identity.id,
            agentUserId: null,
        };
        await directory.save(registration);
    }

    if (agentUpn && !registration.agentUserId) {
        const agentUser = await graphPost("/v1.0/users/microsoft.graph.agentUser", {
            accountEnabled: true,
            displayName,
            mailNickname: agentUpn.split("@")[0],
            userPrincipalName: agentUpn,
            identityParentId: registration.agentIdentityId,
        });
        registration.agentUserId = agentUser.id;
        await directory.save(registration);
    }

    return registration;
}
```

---

The code saves the agent directory entry after each Microsoft Graph call and reuses saved identities on retries. This isn't an atomic transaction with Microsoft Graph. Serialize provisioning for each agent ID, and reconcile a successful Graph call whose response or directory write failed before retrying, to avoid duplicate identities.

Pass a user principal name only for agents that need an agent's user account. Use a verified domain and a unique alias for each agent. Creating the account doesn't assign licenses, a mailbox, or team membership. For those steps, see [Access Microsoft 365 as an agent's user account](sidecar-call-microsoft-365-as-agent-user.md#configure-the-account).

A new agent identity can take a short time to become available for token requests. If the agent's first token request reports that the identity can't be found, retry with backoff.

## Grant the agent access

After the agent identity exists, grant it the access that this agent needs. Grant application permissions, delegated permissions, Azure role assignments, and access to other resources directly to the agent identity. Each agent's access then stays separate and visible on its own identity.

- [Grant application permissions](grant-application-permissions-agent-identity.md)
- [Grant delegated permissions](grant-agent-access-microsoft-365.md)

Permissions that are [inherited from the blueprint](set-up-blueprint-agent-fleet.md#optionally-configure-inheritable-permissions) apply to the new agent identity without another grant.

## Retire an agent

Delete the agent's user account before the agent identity, and then remove the agent directory entry:

# [Python](#tab/python)

```python
def retire_agent(agent_id) -> None:
    registration = directory.find(agent_id)
    if registration is None:
        return

    if registration["agent_user_id"]:
        requests.delete(
            f"{GRAPH_URL}/v1.0/users/microsoft.graph.agentUser/{registration['agent_user_id']}",
            headers=graph_headers(),
            timeout=10,
        ).raise_for_status()

    requests.delete(
        f"{GRAPH_URL}/beta/serviceprincipals/{registration['agent_identity_id']}",
        headers=graph_headers(),
        timeout=10,
    ).raise_for_status()

    directory.delete(agent_id)
```

# [JavaScript](#tab/javascript)

```javascript
async function graphDelete(path) {
    const response = await fetch(`${GRAPH_URL}${path}`, {
        method: "DELETE",
        headers: await graphHeaders(),
    });
    if (!response.ok) {
        throw new Error(`Microsoft Graph request failed with status ${response.status}.`);
    }
}

async function retireAgent(agentId) {
    const registration = await directory.find(agentId);
    if (!registration) {
        return;
    }

    if (registration.agentUserId) {
        await graphDelete(`/v1.0/users/microsoft.graph.agentUser/${registration.agentUserId}`);
    }

    await graphDelete(`/beta/serviceprincipals/${registration.agentIdentityId}`);
    await directory.delete(agentId);
}
```

---

Deleted agent identities can be restored for a limited time. For details, see [Delete and restore agent identity objects](howto-delete-agent-identity.md).

In production, make retirement retry-safe by treating `404 Not Found` as already deleted and reconciling the directory after partial failures.

## Use Agent 365 provisioning instead

If agents are created through Agent 365, Agent 365 creates the agent identity. Instead of calling Microsoft Graph, listen for Agent 365 agent provisioning events, read the agent identity ID from each event, and save it in the agent directory. For event details, see the [Agent 365 developer documentation](/microsoft-agent-365/developer/).

## Next step

[Call APIs as an agent in a fleet with the Auth SDK sidecar](sidecar-fleet-call-apis-as-agent.md)

## Related content

- [Create and delete agent identities](create-delete-agent-identities.md)
- [Create and delete an agent's user account](create-delete-agent-user-account.md)
- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)
- [Auth SDK sidecar endpoint reference](/entra/msidweb/agent-id-sdk/endpoints)

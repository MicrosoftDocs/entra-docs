---
title: Call APIs as an agent's user account in a fleet with the Auth SDK sidecar
description: Select the agent identity and agent's user account for each token request to the Auth SDK sidecar in a shared runtime that hosts many agents.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/04/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with the Auth SDK sidecar, I want agents in my fleet to call Microsoft 365 as their own agent's user accounts.
---

# Call APIs as an agent's user account in a fleet with the Auth SDK sidecar

Some agents in a fleet need a user object for Microsoft 365 workloads, such as a mailbox or Teams membership. For those agents, look up both the agent identity and its agent's user account in the agent directory, and pass them in the `AgentIdentity` and `AgentUserId` parameters.

To decide whether an agent needs an agent's user account, see [Use an agent's user account with Microsoft 365](agent-user-oauth-flow.md#determine-whether-the-agent-needs-a-user-object).

## Prerequisites

- Complete [Call APIs as an agent in a fleet with the Auth SDK sidecar](sidecar-fleet-call-apis-as-agent.md).
- An agent's user account [provisioned for the agent](sidecar-fleet-provision-agent-identities.md#provision-an-agent).
- Delegated permissions for the target API, such as `Mail.ReadWrite`, [granted to the agent identity](grant-agent-access-microsoft-365.md) or [inherited from the blueprint](set-up-blueprint-agent-fleet.md#optionally-configure-inheritable-permissions).
- The Microsoft 365 licenses and resource access that the agent's user account needs. For details, see [Configure the account](sidecar-call-microsoft-365-as-agent-user.md#configure-the-account).

## Configure the sidecar

Add a delegated Microsoft Graph profile to the runtime sidecar:

```json
{
  "DownstreamApis": {
    "MsGraph": {
      "BaseUrl": "https://graph.microsoft.com/v1.0/",
      "Scopes": [
        "Mail.ReadWrite"
      ]
    }
  }
}
```

Replace `Mail.ReadWrite` with the delegated permissions the agents need. The `GetAuthorizationHeaderUnauthenticated` override from the previous article also covers the `AgentUserId` parameter.

## Get a token for an agent's user account

# [Python](#tab/python)

```python
def authorization_header_for_agent_user(agent_id: str, api_name: str) -> str:
    registration = directory.find(agent_id)
    if registration is None or not registration["agent_user_id"]:
        raise LookupError(f"Agent '{agent_id}' doesn't have an agent's user account.")

    response = requests.get(
        f"{SIDECAR_URL}/AuthorizationHeaderUnauthenticated/{api_name}",
        params={
            "AgentIdentity": registration["agent_identity_id"],
            "AgentUserId": registration["agent_user_id"],
        },
        timeout=5,
    )
    response.raise_for_status()
    return response.json()["authorizationHeader"]


graph_response = requests.get(
    "https://graph.microsoft.com/v1.0/me/messages",
    headers={"Authorization": authorization_header_for_agent_user(agent_id, "MsGraph")},
    timeout=10,
)
graph_response.raise_for_status()
```

# [JavaScript](#tab/javascript)

```javascript
async function authorizationHeaderForAgentUser(agentId, apiName) {
    const registration = await directory.find(agentId);
    if (!registration?.agentUserId) {
        throw new Error(`Agent '${agentId}' doesn't have an agent's user account.`);
    }

    const params = new URLSearchParams({
        AgentIdentity: registration.agentIdentityId,
        AgentUserId: registration.agentUserId,
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

const graphResponse = await fetch("https://graph.microsoft.com/v1.0/me/messages", {
    headers: { Authorization: await authorizationHeaderForAgentUser(agentId, "MsGraph") },
});
```

---

The token represents the agent's user account, so `/me` returns that account's data. Each agent can reach only the mailbox, files, and teams that its own account was given.

## Next step

[Authenticate users and route requests to agents in a fleet with the Auth SDK sidecar](sidecar-fleet-authenticate-users.md)

## Related content

- [Access Microsoft 365 as an agent's user account with the Auth SDK sidecar](sidecar-call-microsoft-365-as-agent-user.md)
- [Agent's user accounts](agent-users.md)
- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)

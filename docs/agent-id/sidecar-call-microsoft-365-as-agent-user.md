---
title: Access Microsoft 365 as an agent's user account with the Auth SDK sidecar
description: Use the Auth SDK sidecar to call Microsoft 365 as an agent's user account.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock

#customer-intent: As an agent developer, I want to use the Auth SDK sidecar to call Microsoft 365 as an agent's user account.
---

# Access Microsoft 365 as an agent's user account with the Auth SDK sidecar

Some Microsoft 365 scenarios require a user object rather than an application identity. Use an [agent's user account](agent-users.md) when an autonomous agent needs capabilities such as:

- Membership in a Microsoft Teams team.
- An Exchange Online mailbox.
- Direct access to shared SharePoint or OneDrive content.
- A Microsoft 365 license assigned to the agent.

Don't use an agent's user account when the service supports the required application permission. App-only access is easier to govern and doesn't consume a user license.

## Configure the account

1. [Create an agent's user account](create-delete-agent-user-account.md) and associate it with the Agent ID.
1. Assign only the licenses and service access required by the scenario.
1. [Grant the Agent ID the delegated permissions](grant-agent-access-microsoft-365.md) required by the Microsoft 365 workload, such as `Mail.ReadWrite` or `Files.ReadWrite`.
1. Configure the Microsoft 365 API in the sidecar.
1. Record the Agent ID and the agent user's object ID or user principal name.

## Configure the sidecar

Enable agent overrides for the unauthenticated authorization-header endpoint. Configure the Microsoft Graph delegated scopes required by the agent:

```json
{
  "Sidecar": {
    "AllowOverrides": {
      "GetAuthorizationHeaderUnauthenticated": true
    }
  },
  "DownstreamApis": {
    "MsGraph": {
      "BaseUrl": "https://graph.microsoft.com/v1.0/",
      "Scopes": [
        "User.Read"
      ]
    }
  }
}
```

Replace `User.Read` with the delegated Microsoft Graph permissions required by the operation. Don't use the application-permission `.default` scope for the agent user pattern.

Enabling overrides lets a caller select the Agent ID and agent's user account used for token acquisition. Keep the sidecar on a private network that only trusted agent code can access. Don't populate `AgentIdentity`, `AgentUserId`, or `AgentUsername` directly from untrusted request input.

## Get an authorization header

Request a token without an inbound human-user token:

```http
GET /AuthorizationHeaderUnauthenticated/MsGraph?AgentIdentity={agent-id}&AgentUserId={agent-user-object-id}
```

The endpoint doesn't require an inbound `Authorization` header. You can use `AgentUsername` instead of `AgentUserId` when the user principal name is the stable identifier available to the application. Don't send both parameters.

Send the returned `authorizationHeader` to the configured Microsoft 365 API.

## Call Microsoft Graph

The following example requests an authorization header for the agent's user account and uses it to call Microsoft Graph:

# [Python](#tab/python)

```python
import requests

SIDECAR_URL = "http://localhost:5000"
AGENT_IDENTITY_CLIENT_ID = "<agent-identity-client-id>"
AGENT_USER_OBJECT_ID = "<agent-user-object-id>"

sidecar_response = requests.get(
    f"{SIDECAR_URL}/AuthorizationHeaderUnauthenticated/MsGraph",
    params={
        "AgentIdentity": AGENT_IDENTITY_CLIENT_ID,
        "AgentUserId": AGENT_USER_OBJECT_ID,
    },
    timeout=5,
)
sidecar_response.raise_for_status()
authorization_header = sidecar_response.json()["authorizationHeader"]

graph_response = requests.get(
    "https://graph.microsoft.com/v1.0/me",
    headers={"Authorization": authorization_header},
    timeout=10,
)
graph_response.raise_for_status()
profile = graph_response.json()
```

# [JavaScript](#tab/javascript)

```javascript
const SIDECAR_URL = "http://localhost:5000";
const AGENT_IDENTITY_CLIENT_ID = "<agent-identity-client-id>";
const AGENT_USER_OBJECT_ID = "<agent-user-object-id>";

const params = new URLSearchParams({
    AgentIdentity: AGENT_IDENTITY_CLIENT_ID,
    AgentUserId: AGENT_USER_OBJECT_ID,
});

const sidecarResponse = await fetch(
    `${SIDECAR_URL}/AuthorizationHeaderUnauthenticated/MsGraph?${params}`
);

if (!sidecarResponse.ok) {
    throw new Error(`Sidecar request failed with status ${sidecarResponse.status}.`);
}

const { authorizationHeader } = await sidecarResponse.json();

const graphResponse = await fetch("https://graph.microsoft.com/v1.0/me", {
    headers: { Authorization: authorizationHeader },
});

if (!graphResponse.ok) {
    throw new Error(`Microsoft Graph request failed with status ${graphResponse.status}.`);
}

const profile = await graphResponse.json();
```

---

Keep `SIDECAR_URL` on loopback in the shared network namespace. Treat `authorizationHeader` as a credential, and don't log it.

## Configure the Microsoft 365 resource

The access token doesn't add the agent user to a team, create a mailbox, share a file, or assign a license. Configure those resources through their supported administration or Microsoft Graph APIs:

- [Add a member to a team](/graph/api/team-post-members)
- [Create user mailboxes in Exchange Online](/exchange/recipients-in-exchange-online/create-user-mailboxes)
- [Share a drive item](/graph/api/driveitem-invite)
- [Assign a license to a user](/graph/api/user-assignlicense)

## Next step

[Authenticate users](sidecar-authenticate-users.md) if the agent also handles requests from signed-in users.

## Related content

- [Agent's user account impersonation protocol](agent-user-oauth-flow.md)
- [Request consent for delegated permissions](grant-agent-access-microsoft-365.md)
- [Auth SDK sidecar endpoint reference](/entra/msidweb/agent-id-sdk/endpoints)

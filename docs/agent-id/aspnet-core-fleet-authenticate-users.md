---
title: Authenticate users and route requests to agents in a fleet with ASP.NET Core
description: Validate user access tokens once for a shared ASP.NET Core runtime, route each request to an agent, and enforce per-agent access.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with ASP.NET Core, I want to authenticate users and make sure they can only reach the agents they're allowed to use.
---

# Authenticate users and route requests to agents in a fleet with ASP.NET Core

Users call a fleet agent with an access token for the blueprint's `access_agent` scope. Every agent in the fleet shares that audience, so token validation proves who the user is but not which agent they're allowed to use. The runtime routes each request to an agent and enforces per-agent access itself.

## Prerequisites

- Complete [Call APIs as an agent in a fleet with ASP.NET Core](aspnet-core-fleet-call-apis-as-agent.md).
- The `access_agent` scope [exposed on the blueprint](set-up-blueprint-agent-fleet.md#expose-the-inbound-scope).
- An upstream client that signs in users and requests the scope `api://<agent-identity-blueprint-client-id>/access_agent`.

## Configure token validation

Token validation is the same as for a single agent. Use the blueprint client ID as the expected audience. For upstream client setup and validation details, see [Authenticate users to an ASP.NET Core agent API](aspnet-core-authenticate-users.md).

To limit which users can call the fleet at all, [require an app role assignment](control-user-access-agents.md) on the blueprint principal. Those app roles apply to every agent in the fleet.

## Enforce per-agent access

Decide who can use each agent, and store that decision in the runtime. For example, record the users and groups that an agent's owner shares it with. Define an access policy that the runtime checks on every request:

```csharp
using System.Security.Claims;

public interface IAgentAccessPolicy
{
    Task<bool> CanUseAgentAsync(ClaimsPrincipal user, string agentId);
}
```

Identify the user by the `tid` and `oid` claims. Don't use the user principal name or email as a stable key.

Implement `IAgentAccessPolicy` against your sharing records and register it in dependency injection before mapping the endpoint. The interface alone doesn't enforce access.

## Route requests to agents

Put the runtime's agent ID in the route. Validate the token, confirm the agent exists, and check the access policy before running the agent:

```csharp
using Microsoft.Identity.Web.Resource;

app.MapPost("/agents/{agentId}/messages", async (
    string agentId,
    HttpContext context,
    IAgentDirectory directory,
    IAgentAccessPolicy accessPolicy) =>
{
    context.VerifyUserHasAnyAcceptedScope("access_agent");

    if (await directory.FindAsync(agentId) is null
        || !await accessPolicy.CanUseAgentAsync(context.User, agentId))
    {
        return Results.NotFound();
    }

    // Run the agent for this request.
    return Results.Accepted();
})
.RequireAuthorization();
```

The endpoint returns `404 Not Found` both for an unknown agent and for an agent the user can't use, so callers can't discover other agents in the fleet. After these checks pass, use `agentId` for every token request made while handling the request.

Before adding agent work, test with a user who can access one agent but not another. The allowed request reaches the placeholder `202 Accepted` response; requests for the other agent and an unknown agent return `404 Not Found`. Confirm that neither rejected request runs agent work or requests a downstream token. The placeholder response verifies routing and access checks, not agent execution.

## Next step

[Call APIs as a user in a fleet with ASP.NET Core](aspnet-core-fleet-call-apis-as-user.md)

## Related content

- [Authenticate users to an ASP.NET Core agent API](aspnet-core-authenticate-users.md)
- [Control access to agents with app roles](control-user-access-agents.md)
- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)

---
title: Call APIs as an agent's user account in a fleet with ASP.NET Core
description: Select the agent identity and agent's user account for each token request in a shared ASP.NET Core runtime that hosts many agents.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with ASP.NET Core, I want agents in my fleet to call Microsoft 365 as their own agent's user accounts.
---

# Call APIs as an agent's user account in a fleet with ASP.NET Core

Some agents in a fleet need a user object for Microsoft 365 workloads, such as a mailbox or Teams membership. For those agents, look up both the agent identity and its agent's user account in the agent directory, and pass them to `WithAgentUserIdentity`.

To decide whether an agent needs an agent's user account, see [Use an agent's user account with Microsoft 365](agent-user-oauth-flow.md#determine-whether-the-agent-needs-a-user-object).

## Prerequisites

- Complete [Call APIs as an agent in a fleet with ASP.NET Core](aspnet-core-fleet-call-apis-as-agent.md).
- An agent's user account [provisioned for the agent](aspnet-core-fleet-provision-agent-identities.md#provision-an-agent).
- Delegated permissions for the target API, such as `Mail.ReadWrite`, [granted to the agent identity](grant-agent-access-microsoft-365.md) or [inherited from the blueprint](set-up-blueprint-agent-fleet.md#optionally-configure-inheritable-permissions).
- The Microsoft 365 licenses and resource access that the agent's user account needs. For details, see [Provision access](agent-user-oauth-flow.md#provision-access).

## Get a token for an agent's user account

Add a method to `FleetTokenService`:

```csharp
using System.Security.Claims;

public async Task<string> CreateAuthorizationHeaderForAgentUserAsync(
    string agentId, string scope)
{
    AgentRegistration registration = await GetRegistrationAsync(agentId);

    if (registration.AgentUserId is null)
    {
        throw new InvalidOperationException(
            $"Agent '{agentId}' doesn't have an agent's user account.");
    }

    var options = new AuthorizationHeaderProviderOptions()
        .WithAgentUserIdentity(
            registration.AgentIdentityId,
            Guid.Parse(registration.AgentUserId));

    return await authorizationHeaderProvider
        .CreateAuthorizationHeaderForUserAsync([scope], options, new ClaimsPrincipal());
}
```

Pass `new ClaimsPrincipal()` because no person is signed in. The user comes from the agent directory, not from the request context.

Call the method from the agent's work, and send the header to Microsoft Graph:

```csharp
using System.Net.Http.Headers;

string authorizationHeader = await fleetTokenService
    .CreateAuthorizationHeaderForAgentUserAsync(agentId, "https://graph.microsoft.com/.default");

HttpClient client = httpClientFactory.CreateClient();
client.DefaultRequestHeaders.Authorization =
    AuthenticationHeaderValue.Parse(authorizationHeader);

using HttpResponseMessage response =
    await client.GetAsync("https://graph.microsoft.com/v1.0/me/messages");
response.EnsureSuccessStatusCode();
```

The token represents the agent's user account, so `/me` returns that account's data. Each agent can reach only the mailbox, files, and teams that its own account was given.

For this example, verify that Microsoft Graph returns a successful messages response for the selected agent's mailbox. An empty messages collection isn't an authentication failure. If the call fails, check delegated permission grants separately from the account's license, mailbox provisioning, and resource access; acquiring a token doesn't provision a mailbox.

## Next step

[Authenticate users and route requests to agents in a fleet with ASP.NET Core](aspnet-core-fleet-authenticate-users.md)

## Related content

- [Use an agent's user account with Microsoft 365](agent-user-oauth-flow.md)
- [Agent's user accounts](agent-users.md)
- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)

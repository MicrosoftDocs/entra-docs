---
title: Call APIs as a user in a fleet with ASP.NET Core
description: Use the On-Behalf-Of flow with the routed agent's identity to call APIs for a signed-in user from a shared ASP.NET Core runtime.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with ASP.NET Core, I want agents in my fleet to call APIs on behalf of the signed-in user with their own agent identity.
---

# Call APIs as a user in a fleet with ASP.NET Core

After the runtime routes a user's request to an agent, the agent can call APIs for that user with the On-Behalf-Of (OBO) flow. Pass the routed agent's identity to `WithAgentIdentity`. The downstream token represents both the signed-in user and that agent.

## Prerequisites

- Complete [Authenticate users and route requests to agents in a fleet with ASP.NET Core](aspnet-core-fleet-authenticate-users.md).
- Delegated permissions for the target API, [granted to the agent identity](grant-agent-access-microsoft-365.md) or [inherited from the blueprint](set-up-blueprint-agent-fleet.md#optionally-configure-inheritable-permissions).

## Get a token for the signed-in user

Add a method to `FleetTokenService`:

```csharp
using System.Security.Claims;

public async Task<string> CreateAuthorizationHeaderForUserAsync(
    string agentId, string scope, ClaimsPrincipal user)
{
    AgentRegistration registration = await GetRegistrationAsync(agentId);

    var options = new AuthorizationHeaderProviderOptions()
        .WithAgentIdentity(registration.AgentIdentityId);

    return await authorizationHeaderProvider
        .CreateAuthorizationHeaderForUserAsync([scope], options, user);
}
```

The `user` argument is the authenticated `HttpContext.User`. *Microsoft.Identity.Web* uses the user's incoming access token as the OBO assertion.

## Call the API

Call the method after the routing and access checks from the previous article pass:

Replace the previous article's placeholder mapping for `POST /agents/{agentId}/messages` with this mapping; don't register both routes. Replace the sample API URL and delegated scope with values from the same downstream API registration.

```csharp
using System.Net.Http.Headers;
using Microsoft.Identity.Web.Resource;

app.MapPost("/agents/{agentId}/messages", async (
    string agentId,
    HttpContext context,
    IAgentDirectory directory,
    IAgentAccessPolicy accessPolicy,
    FleetTokenService fleetTokenService,
    IHttpClientFactory httpClientFactory) =>
{
    context.VerifyUserHasAnyAcceptedScope("access_agent");

    if (await directory.FindAsync(agentId) is null
        || !await accessPolicy.CanUseAgentAsync(context.User, agentId))
    {
        return Results.NotFound();
    }

    string authorizationHeader = await fleetTokenService
        .CreateAuthorizationHeaderForUserAsync(
            agentId, "api://<custom-api-client-id>/<delegated-scope>", context.User);

    HttpClient client = httpClientFactory.CreateClient();
    client.DefaultRequestHeaders.Authorization =
        AuthenticationHeaderValue.Parse(authorizationHeader);

    using HttpResponseMessage response =
        await client.GetAsync("https://api.contoso.com/user-data");
    response.EnsureSuccessStatusCode();

    return Results.Content(
        await response.Content.ReadAsStringAsync(),
        response.Content.Headers.ContentType?.ToString());
})
.RequireAuthorization();
```

Always use the agent ID that passed the access check. If the runtime used a different agent's identity, the downstream API would see the wrong agent acting for the user.

Verify the allowed request returns the downstream API's expected user data. Repeat the denied-agent and unknown-agent checks from the previous article: both must still return `404 Not Found` without calling the API. If only the allowed request fails downstream, check the selected agent's delegated grant and the API's user authorization rather than weakening the routing policy.

## Call specific resources

Use the resource scopes and permission setup from the linked articles, while keeping the fleet's blueprint configuration and `AddAgentIdentities` registration. The single-instance examples omit identity overrides. For each fleet request, call `CreateAuthorizationHeaderForUserAsync` with the routed agent ID and authenticated user.

| Resource | Example scope | Guidance |
| --- | --- | --- |
| Custom API | `api://<custom-api-client-id>/<delegated-scope>` | [Call a custom API as a user](aspnet-core-call-custom-api-as-user.md) |
| Azure services | `https://storage.azure.com/user_impersonation` | [Call Azure services as a user](aspnet-core-call-azure-api-as-user.md) |
| Microsoft Graph | `https://graph.microsoft.com/User.Read` | [Call Microsoft Graph as a user](aspnet-core-call-graph-as-user.md) |

For Azure REST APIs, use the same helper with the service's delegated scope and endpoint. For example, Azure Resource Manager uses `https://management.azure.com/user_impersonation`. The signed-in user's Azure role assignments determine resource access.

If you use `GraphServiceClient` instead of an HTTP authorization header, install and register it as described in the linked Graph article, but select the fleet agent on each call after the routing and access checks:

```csharp
using Microsoft.Graph;
using Microsoft.Identity.Web;

var me = await graphClient.Me.GetAsync(request =>
    request.Options.WithAuthenticationOptions(options =>
    {
        options.Scopes = ["https://graph.microsoft.com/User.Read"];
        options.User = context.User;
        options.WithAgentIdentity(registration.AgentIdentityId);
    }));
```

Here, `registration` is the directory entry for the agent ID that passed the access check, and `context` is the current `HttpContext`. Don't set `RequestAppToken` for OBO.

## Related content

- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)
- [Inheritable permissions](concept-inheritable-permissions.md)
- [OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)

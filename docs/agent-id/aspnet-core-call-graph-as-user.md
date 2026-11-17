---
title: Call Microsoft Graph as a user with ASP.NET Core
description: Configure GraphServiceClient to call Microsoft Graph on behalf of a signed-in user through an agent identity.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.reviewer: dastrock, jomondi
#customer-intent: As a developer building an interactive cloud agent, I want to call Microsoft Graph on behalf of the signed-in user.
---

# Call Microsoft Graph as a user with ASP.NET Core

Use Microsoft Graph to read the signed-in user's profile through your agent API.

In this article, the client calls the agent with an agent API token. Microsoft.Identity.Web exchanges it for a delegated Graph token without starting another interactive sign-in.

## Prerequisites

- Complete [Authenticate users to an ASP.NET Core agent API](aspnet-core-authenticate-users.md), including the local test client.
- Reuse the [blueprint credential and OBO services](aspnet-core-call-custom-api-as-user.md#configure-the-blueprint-credential). You don't need that walkthrough's custom downstream API registration, consent grant, or local API project for this Graph example.
- Declare the Microsoft Graph delegated permission `User.Read` on the blueprint and [grant delegated Microsoft Graph permissions to the agent identity](grant-agent-access-microsoft-365.md) for the test user. Client-to-agent consent doesn't grant the agent access to Graph.

## Add Microsoft Graph

Install the integration package:

```dotnetcli
dotnet add package Microsoft.Identity.Web.GraphServiceClient
```

Register `GraphServiceClient` with the services configured in the parent article. For this example, call `builder.Services.AddMicrosoftGraph` with `options.BaseUrl` set to `https://graph.microsoft.com/v1.0` and `options.Scopes` set to `["User.Read"]`. This configures downstream Graph access, not the incoming agent API's permission.

Place this registration before `builder.Build()` in the agent API's `Program.cs`.

```csharp
builder.Services.AddMicrosoftGraph(options =>
{
    options.BaseUrl = "https://graph.microsoft.com/v1.0";
    options.Scopes = ["User.Read"];
});
```

## Call Microsoft Graph

`GraphServiceClient` uses the authenticated user assertion from the request and the configured shared client ID. Don't set `RequestAppToken` or an Agent ID override; this call uses ordinary delegated access.

Require authentication and verify the incoming `access_agent` scope before calling `graphClient.Me.GetAsync()`. The incoming token is for the agent API; Microsoft.Identity.Web acquires a different token for Microsoft Graph.

Merge the following `using` directives with those at the top of `Program.cs`, and place the endpoint before its single `app.Run()`. You can omit the custom API endpoint from the parent walkthrough.

```csharp
using Microsoft.Graph;
using Microsoft.Identity.Web;
using Microsoft.Identity.Web.Resource;

app.MapGet("/graph-me", async (
    HttpContext context,
    GraphServiceClient graphClient) =>
{
    context.VerifyUserHasAnyAcceptedScope("access_agent");

    var user = await graphClient.Me.GetAsync();

    return Results.Ok(new
    {
        user?.Id,
        user?.DisplayName,
        user?.UserPrincipalName
    });
})
.RequireAuthorization();
```

The example requires `User.Read`. Add only the delegated permissions required by your Graph calls.

## Verify the Graph call

Start the agent API with `dotnet run --urls https://localhost:5001`. In the [local test client](aspnet-core-authenticate-users.md#run-the-test-client), change only the request URL to `https://localhost:5001/graph-me`; keep the agent API scope. Sign in as the user covered by both grants. Expect `HTTP 200` and that user's profile, with `id` matching the object ID returned by `/whoami`.

A call without a token must return `401`. If token acquisition reports missing consent, check the agent-to-Graph grant separately from the client's access to the agent. OBO can't display an interactive consent prompt. Stop the projects when finished and follow the steps to [clean up the local agent authentication test](aspnet-core-authenticate-users.md#clean-up-the-local-test) for test-only resources.

## Related content

- [Call a custom API as a user](aspnet-core-call-custom-api-as-user.md)
- [Microsoft Graph permissions reference](/graph/permissions-reference)
- [Call Microsoft Graph as an agent](call-api-microsoft-graph.md)

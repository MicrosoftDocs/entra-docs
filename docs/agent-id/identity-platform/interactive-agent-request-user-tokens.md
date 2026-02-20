---
title: Acquire user tokens for interactive agents
description: Learn how to implement the On-Behalf-Of flow for interactive agents to obtain access tokens on behalf of users who grant consent.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer, I want to implement the On-Behalf-Of flow for my interactive agent, so that my agent can obtain access tokens to call APIs on behalf of users who have granted delegated permissions.
---

# Acquire user tokens for interactive agents

After an interactive agent obtains user authorization, it needs to request access tokens that can be used to call APIs on behalf of the user. This article walks you through implementing the On-Behalf-Of (OBO) flow to obtain delegated access tokens for your interactive agent.

The OBO flow allows a web API to:

- Receive an access token from a client.
- Exchange it for a new access token for a downstream API like Microsoft Graph.
- Use that new token to access protected resources on behalf of the original user.

## Prerequisites

Before requesting user tokens, ensure you have:

- [An agent identity](create-delete-agent-identities.md)
- Completed user authorization as described in [Configure user authorization](interactive-agent-request-user-authorization.md)
- Access token with appropriate permissions for your agent identity

## Request user tokens

Whereas you could implement the OBO flow manually by following the protocol, we recommend using the `Microsoft.Identity.Web` library, which simplifies the implementation.

1. Install the required NuGet package:

    ```bash
    dotnet add package Microsoft.Identity.Web
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    ```

1. In your ASP.NET core web API project, update the Microsoft Entra ID authentication implementation.

    ```csharp
    // Program.cs
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.Identity.Abstractions;
    using Microsoft.Identity.Web;
    using Microsoft.Identity.Web.Resource;
    using Microsoft.Identity.Web.TokenCacheProviders.InMemory;
    
    var builder = WebApplication.CreateBuilder(args);
    
    // With Microsoft.Identity.Web
    builder.Services.AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
        .EnableTokenAcquisitionToCallDownstreamApi();
    builder.Services.AddAgentIdentities();
    builder.Services.AddInMemoryTokenCaches();
    
    var app = builder.Build();
    
    app.UseAuthentication();
    app.UseAuthorization();
    
    app.Run();
    ```

1. In the agent API, exchange the incoming access token for a new access token for the agent identity. *Microsoft.Identity.Web* takes care of validation of the incoming access token, but is currently not updated to handle the on-behalf-of token exchange.

    ```csharp
    app.MapGet("/agent-obo-user", async (HttpContext httpContext) =>
    {
       string agentid = "<your-agent-identity>";
        // Get the service to call the downstream API (preconfigured in the appsettings.json file)
        IAuthorizationHeaderProvider authorizationHeaderProvider = httpContext.RequestServices.GetService<IAuthorizationHeaderProvider>()!;
        AuthorizationHeaderProviderOptions options = new AuthorizationHeaderProviderOptions().WithAgentIdentity(agentid);
    
        // Request user token for the agent identity
        string authorizationHeaderWithUserToken = await authorizationHeaderProvider.CreateAuthorizationHeaderForUserAsync(["https://graph.microsoft.com/.default"], options);
    
        var response = new { header = authorizationHeaderWithUserToken };
        return Results.Json(response);
    })
    .RequireAuthorization();
    ```

## Use Microsoft Graph SDK

If you're using the Microsoft Graph SDK, you can authenticate to Microsoft Graph using the `GraphServiceClient`.

1. Install the *Microsoft.Identity.Web.GraphServiceClient that handles authentication for the Graph SDK

    ```bash
    dotnet add package Microsoft.Identity.Web.GraphServiceClient
    ```

1. In your ASP.NET core web API project, add the support for Microsoft Graph in your service collection.

    ```bash
    services.AddMicrosoftGraph();
    ```

1. Get a `GraphServiceClient` from the service provider and call Microsoft Graph APIs with the agent identity


    ```csharp
    app.MapGet("/agent-obo-user", async (HttpContext httpContext) =>
    {
        
        string agentIdentity = "<your-agent-identity>";
        builder.Services.AddMicrosoftGraph();
    
        GraphServiceClient graphServiceClient = httpContext.RequestServices.GetService<GraphServiceClient>()!;
        var me = await graphServiceClient.Me.GetAsync(r => r.Options.WithAuthenticationOptions(
            o =>
            {
                o.WithAgentIdentity(agentIdentity);
            }));
        return me.UserPrincipalName;
    })
    ```

## Related content

- [Sign-in users](interactive-agent-authenticate-user.md)
- [Request agent tokens](autonomous-agent-request-tokens.md)
- [Microsoft identity platform and OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)

---
title: Authenticate users in interactive agents
description: Learn how to authenticate users for interactive agents using Agent Identity. Concepts include token requests, validation, and extraction of user claims for authorization.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.author: shermanouko
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer building interactive agents, I want to learn how to authenticate users and validate access tokens for Agent Identity, so that I can enable secure user interactions and implement proper authorization in my agent applications.
---

# Authenticate users in interactive agents

Agents often need take actions on behalf of users that use the agent. The first step to building an interactive agent is to authenticate the user. This article walks through the process of building a simple web service that authenticates a user. The agent identity blueprint is used to secure the web service. Steps include:

1. A client obtains an access token scoped for the agent identity blueprint.
1. Validate that token in the agent's API.
1. Extract claims about the user that can be used for authorization.

## Prerequisites

[Agent identity blueprints](./agent-blueprint.md). Record the agent identity blueprint app ID (client ID).

## Request a token for the agent identity blueprint
To authenticate a user, the client app (such as a frontend or mobile app) should initiate an OAuth 2.0 authorization request to obtain a token where the audience is the agent identity blueprint.

1. Redirect the user to the Microsoft Entra ID authorization endpoint with the following parameters:

    ```http
    GET https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/authorize?client_id=<client-id>
    &response_type=code
    &redirect_uri=<redirect_uri>
    &response_mode=query
    &scope=api://<agent-blueprint-id>/access_agent
    &state=abc123
    ```

1. Once the user signs in, your app receives an authorization code at the redirect URI. You exchange it for an access token:

    ```http
    POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=<client-id>
    grant_type=authorization_code
    code=<authorization_code>
    redirect_uri=<redirect_uri>
    scope=api://<agent-blueprint-id>/access_agent
    client_secret=<client-secret>  # Only if using a confidential client
    ```

    The JSON response contains an access token that can be used to access the agent's API.

## Validate the token in the agent's API

The agent, typically exposed via a web API, must validate the access token. Always use an approved library to perform token validation and should never implement your own token validation code.

1. Install the `Microsoft.Identity.Web` NuGet package:

    ```http
    dotnet add package Microsoft.Identity.Web
    ```

1. In your ASP.NET Core web API project, implement Microsoft Entra ID authentication:

    ```csharp
    // Program.cs
    using Microsoft.Identity.Web;
    
    var builder = WebApplication.CreateBuilder(args);
    
    builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddMicrosoftIdentityWebApi(builder.Configuration.GetSection("AzureAd"));
    
    var app = builder.Build();
    
    app.UseAuthentication();
    app.UseAuthorization();
    ```

 1.  Configure authentication credentials in *appsettings.json* file:

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

```json
"AzureAd": {
"Instance": "https://login.microsoftonline.com/",
"TenantId": "<my-test-tenant>",
"ClientId": "<agent-blueprint-id>",
"Audience": "<agent-blueprint-id>",
"ClientCredentials": [
    {
    "SourceType": "ClientSecret",
    "ClientSecret": "your-client-secret"
    }
]
}
```

For more information on Microsoft.Identity.Web, [see official docs](/entra/msal/dotnet/microsoft-identity-web/).

## Validate user claims

After you validate the access token, the agent can now identify the user and perform authorization checks. This example API route extracts user claims from the access token and returns them in the API response:

```csharp
app.MapGet("/hello-agent", (HttpContext httpContext) =>
{   
    var claims = httpContext.User.Claims.Select(c => new
    {
        Type = c.Type,
        Value = c.Value
    });

    return Results.Ok(claims);
})
.RequireAuthorization();
```

## Related content

[Token claims](./agent-token-claims.md)

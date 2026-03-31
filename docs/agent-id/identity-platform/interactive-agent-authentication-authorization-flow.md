---
title: Authenticate users and acquire tokens for interactive agents
description: Learn how to authenticate users, configure authorization, and implement the On-Behalf-Of flow for interactive agents to access resources on behalf of users.
titleSuffix: Microsoft Entra Agent ID
author: Dickson-Mwendia
ms.author: dmwendia
ms.topic: how-to
ms.date: 03/17/2026
ms.custom: agent-id-ignite
ms.reviewer: dastrock, jomondi

#customer-intent: As a developer building interactive agents, I want to authenticate users, configure authorization, and acquire tokens through the On-Behalf-Of flow, so that my agent can securely act on behalf of users to access protected resources.
---

# Authenticate users and acquire tokens for interactive agents

Interactive agents take actions on behalf of users. To do so securely, the agent must authenticate the user, obtain consent for the required permissions, and acquire access tokens for downstream APIs. This article walks you through implementing the end-to-end flow for your interactive agent:

1. Register a redirect URI for your agent identity blueprint.
1. Configure user or admin authorization (consent).
1. Authenticate the user and obtain an access token.
1. Validate the token and extract user claims.
1. Acquire tokens for downstream APIs using the On-Behalf-Of (OBO) flow.

> [!NOTE]
> This article covers interactive agents that act **on behalf of** signed-in users using the OBO flow. If your agent needs its own user-like identity (a digital worker scenario), see [Agent users](agent-users.md) and [Agent user OAuth flow](agent-user-oauth-flow.md).

## Prerequisites

Before you begin, ensure you have:

- An [agent identity blueprint](agent-blueprint.md). Record the agent identity blueprint app ID (client ID).
- An [agent identity](create-delete-agent-identities.md).
- An agent application configured for your agent identity.
- Familiarity with the [OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow).

For admin authorization, you also need:

- An access token with `Application.ReadWrite.OwnedBy` delegated permission. Understand the difference between [delegated and application permissions](/entra/identity-platform/permissions-consent-overview).
- [Administrator access to grant consent](../identity-professional/grant-agent-access-microsoft-365.md) for application permissions.

## Register a redirect URI

To support delegated permissions, your agent identity blueprint must be configured with a valid redirect URI. This URI is where Microsoft Entra ID sends users after they grant or deny consent to your agent.

### [Microsoft Graph API](#tab/microsoft-graph-api)

To send this request, you first need to obtain an access token with the delegated permission `AgentIdentityBlueprint.ReadWrite.All`.

```http
PATCH https://graph.microsoft.com/beta/applications/<agent-blueprint-id>
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
  "web": {
    "redirectUris": [
      "https://myagentapp.com/authorize"
    ]
  }
}
```

### [Microsoft Graph PowerShell](#tab/microsoft-graph-powershell)

```powershell
Connect-MgGraph -Scopes "AgentIdentityBlueprint.ReadWrite.All" -TenantId <your-test-tenant>

$applicationId = "<agent-blueprint-id>"
$web = @{
    redirectUris= @(
        "https://myagentapp.com/authorize"
    )
}

$body = @{
    web   =  $web
}

Invoke-MgGraphRequest -Method PATCH `
        -Uri "https://graph.microsoft.com/beta/applications/$applicationId" `
        -Headers @{ "OData-Version" = "4.0" } `
        -Body ($body | ConvertTo-Json)
```

---

## Configure user authorization

Before the agent can act on behalf of a user, the user must consent to the required permissions. This consent step doesn't return a token. Instead, it records that the user has granted the agent permission to act on their behalf. Token acquisition happens in a [later step](#authenticate-the-user-and-request-a-token).

To prompt a user for consent, construct an authorization URL and redirect the user to it. The agent can present this URL in different ways, for example, as a link in a chat message.

> [!IMPORTANT]
> Use the **agent identity** client ID in the `client_id` parameter, not the agent identity blueprint ID.

```http
https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize?
  client_id=<agent-identity-id>
  &response_type=none
  &redirect_uri=https%3A%2F%2Fmyagentapp.com%2Fauthorize
  &response_mode=query
  &scope=User.Read
  &state=xyz123
```

When the user opens this URL, Microsoft Entra ID prompts them to sign in and grant consent to the permissions specified in the `scope` parameter. After consent is granted, the user is redirected to the specified redirect URI.

The key parameters in the consent URL are:

- `client_id`: The agent identity client ID (not the agent identity blueprint client ID).
- `response_type`: Set to `none` because this request records consent only. Token acquisition uses `response_type=code` in a [separate request](#authenticate-the-user-and-request-a-token).
- `redirect_uri`: Must match exactly what you configured in the previous step.
- `scope`: Specify the delegated permissions you need (for example, `User.Read`).
- `state`: Optional parameter for maintaining state between the request and callback.

For more information on OAuth authorization concepts, see [Permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview).

## Configure admin authorization

Agents can also request authorization from a Microsoft Entra ID administrator, who can grant authorization to the agent for all users in their tenant. Application permissions require admin authorization because individual users can't consent to them.

To grant admin consent, construct the authorization URL that prompts the administrator. Use the agent identity ID in the following request.

```http
https://login.microsoftonline.com/contoso.onmicrosoft.com/v2.0/adminconsent
?client_id=<agent-identity-id>
&scope=User.Read
&redirect_uri=https://entra.microsoft.com/TokenAuthorize
&state=xyz123
```

After the administrator grants consent, the permissions are applied tenant-wide and users in that tenant don't need to individually consent to those permissions.

## Authenticate the user and request a token

After authorization is configured, the client app (such as a frontend or mobile app) initiates an OAuth 2.0 authorization code request to obtain a token where the audience is the agent identity blueprint. In this step, `client_id` refers to the client app's own registered application ID, not the agent identity or agent identity blueprint ID.

1. Redirect the user to the Microsoft Entra ID authorization endpoint with the following parameters:

    ```http
    GET https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/authorize?client_id=<client-app-id>
    &response_type=code
    &redirect_uri=<redirect_uri>
    &response_mode=query
    &scope=api://<agent-blueprint-id>/access_agent
    &state=abc123
    ```

1. After the user signs in, your app receives an authorization code at the redirect URI. Exchange it for an access token:

    ```http
    POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=<client-app-id>
    &grant_type=authorization_code
    &code=<authorization_code>
    &redirect_uri=<redirect_uri>
    &scope=api://<agent-blueprint-id>/access_agent
    &client_secret=<client-secret>
    ```

    Include the `client_secret` parameter only if using a confidential client.

    The JSON response contains an access token that can be used to access the agent's API.

## Validate the access token

The agent, typically exposed via a web API, must validate the access token. Always use an approved library to perform token validation. Never implement your own token validation code.

1. Install the `Microsoft.Identity.Web` NuGet package:

    ```bash
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

1. Configure authentication credentials in the `appsettings.json` file:

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

For more information about Microsoft.Identity.Web, see [Microsoft.Identity.Web documentation](/entra/msal/dotnet/microsoft-identity-web/).

## Validate user claims

After you validate the access token, the agent can identify the user and perform authorization checks. This example API route extracts user claims from the access token and returns them in the API response:

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

## Acquire tokens for downstream APIs

After an interactive agent validates the user's token, it can request access tokens to call downstream APIs on behalf of the user. The On-Behalf-Of (OBO) flow allows the agent to:

- Receive an access token from a client.
- Exchange it for a new access token for a downstream API like Microsoft Graph.
- Use that new token to access protected resources on behalf of the original user.

### [Microsoft Identity Web](#tab/identity-web-tokens)

The `Microsoft.Identity.Web` library simplifies the OBO implementation by handling token exchange automatically, so you don't have to manually implement the flow by following the protocol.

1. Install the required NuGet packages:

    ```bash
    dotnet add package Microsoft.Identity.Web
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    ```

1. In your ASP.NET Core web API project, update the Microsoft Entra ID authentication implementation:

    ```csharp
    // Program.cs
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.Identity.Abstractions;
    using Microsoft.Identity.Web;
    using Microsoft.Identity.Web.Resource;
    using Microsoft.Identity.Web.TokenCacheProviders.InMemory;
    
    var builder = WebApplication.CreateBuilder(args);
    
    builder.Services.AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
        .EnableTokenAcquisitionToCallDownstreamApi();
    builder.Services.AddAgentIdentities();
    builder.Services.AddInMemoryTokenCaches();
    
    var app = builder.Build();
    
    app.UseAuthentication();
    app.UseAuthorization();
    
    app.Run();
    ```

1. In the agent API, exchange the incoming access token for a new access token for the agent identity. `Microsoft.Identity.Web` validates the incoming access token and handles the on-behalf-of token exchange:

    ```csharp
    app.MapGet("/agent-obo-user", async (HttpContext httpContext) =>
    {
        string agentIdentity = "<your-agent-identity>";
        IAuthorizationHeaderProvider authorizationHeaderProvider = httpContext.RequestServices.GetService<IAuthorizationHeaderProvider>()!;
        AuthorizationHeaderProviderOptions options = new AuthorizationHeaderProviderOptions().WithAgentIdentity(agentIdentity);
    
        string authorizationHeaderWithUserToken = await authorizationHeaderProvider.CreateAuthorizationHeaderForUserAsync(["https://graph.microsoft.com/.default"], options);
    
        var response = new { header = authorizationHeaderWithUserToken };
        return Results.Json(response);
    })
    .RequireAuthorization();
    ```

### [Microsoft Graph SDK](#tab/graph-sdk-tokens)

If you're using the Microsoft Graph SDK, you can authenticate to Microsoft Graph using the `GraphServiceClient`.

1. Install the required NuGet packages:

    ```bash
    dotnet add package Microsoft.Identity.Web
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    dotnet add package Microsoft.Identity.Web.GraphServiceClient
    ```

1. In your ASP.NET Core web API project, configure authentication and add support for Microsoft Graph:

    ```csharp
    // Program.cs
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.Identity.Web;
    using Microsoft.Identity.Web.TokenCacheProviders.InMemory;
    
    var builder = WebApplication.CreateBuilder(args);
    
    builder.Services.AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
        .EnableTokenAcquisitionToCallDownstreamApi();
    builder.Services.AddAgentIdentities();
    builder.Services.AddInMemoryTokenCaches();
    builder.Services.AddMicrosoftGraph();
    
    var app = builder.Build();
    
    app.UseAuthentication();
    app.UseAuthorization();
    
    app.Run();
    ```

1. Get a `GraphServiceClient` from the service provider and call Microsoft Graph APIs with the agent identity:

    ```csharp
    app.MapGet("/agent-obo-user", async (HttpContext httpContext) =>
    {
        string agentIdentity = "<your-agent-identity>";
    
        GraphServiceClient graphServiceClient = httpContext.RequestServices.GetService<GraphServiceClient>()!;
        var me = await graphServiceClient.Me.GetAsync(r => r.Options.WithAuthenticationOptions(
            o =>
            {
                o.WithAgentIdentity(agentIdentity);
            }));
        return me.UserPrincipalName;
    })
    .RequireAuthorization();
    ```

---

Under the hood, the OBO flow involves two token exchanges: first, the agent identity blueprint obtains an exchange token using its client credential, and then the agent identity exchanges that token along with the user's access token for a downstream API token. For the full protocol walkthrough, including HTTP request formats and token validation details, see [On-behalf-of flow in agents](agent-on-behalf-of-oauth-flow.md).

## Related content

- [Token claims reference](agent-token-claims.md)
- [On-behalf-of flow in agents](agent-on-behalf-of-oauth-flow.md)
- [Agent users](agent-users.md)
- [Request agent tokens for autonomous agents](autonomous-agent-request-tokens.md)
- [Permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview)
- [Microsoft identity platform and OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)

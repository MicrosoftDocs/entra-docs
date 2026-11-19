---
title: Secure an MCP server with Microsoft Entra ID
description: Learn how to protect an MCP server and check client access tokens.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As an MCP server developer, I want to protect my server with Microsoft Entra ID so that only authorized clients, users, and agents can call it.
---

# Secure a Model Context Protocol server with Microsoft Entra ID

An MCP server is an OAuth 2.0 protected resource. Register the server as an API in Microsoft Entra ID, publish protected-resource metadata, and validate each access token before processing an MCP request.

This guidance supports Microsoft identity platform v2.0 access tokens only.

## Prerequisites

- A Microsoft Entra tenant.
- An HTTPS endpoint with a nonempty path and no trailing slash, such as `https://mcp.contoso.com/mcp`.
- Permission to create an app registration and grant consent.
- An MCP client that supports OAuth protected-resource metadata.

## Register the MCP server

1. Register an application for the MCP server.
1. Set the Application ID URI to the MCP server's canonical endpoint URL, such as `https://mcp.contoso.com/mcp`.
1. Expose the delegated scopes required by MCP clients.
1. Define application roles only if the server supports app-only access.
1. Record the tenant ID, application client ID, and Application ID URI.

Grant only the permissions required by the tools and resources that the server exposes.

## Publish protected-resource metadata

Publish a metadata document at `<server-origin>/.well-known/oauth-protected-resource`, such as `https://mcp.contoso.com/.well-known/oauth-protected-resource`, and advertise its URL in the `WWW-Authenticate` header. This metadata URL is separate from the MCP endpoint at `https://mcp.contoso.com/mcp`. MCP clients that support OAuth protected-resource discovery fetch this document to find the authorization server and supported scopes before requesting a token.

The following example shows a minimal document for a Microsoft Entra-backed MCP server:

```json
{
  "resource": "https://mcp.contoso.com/mcp",
  "authorization_servers": [
    "https://login.microsoftonline.com/<tenant-id>/oauth21/2026-08"
  ],
  "scopes_supported": [
    "https://mcp.contoso.com/mcp/mcp.access"
  ],
  "bearer_methods_supported": [
    "header"
  ]
}
```

- **`resource`** — The canonical MCP server URL registered as the Application ID URI. This value must match the client's OAuth `resource` parameter. For v2 access tokens, the token's `aud` is the resource application's client-ID GUID, not this URL.
- **`authorization_servers`** — For CIMD support, advertise the versioned identifier `https://login.microsoftonline.com/<tenant>/oauth21/2026-08`. Use your tenant ID for a server that accepts users from a single tenant, or `organizations` for a server that accepts users from any organization. Clients append `/.well-known/openid-configuration` to this URL to discover the authorization and token endpoints. This field contains an authorization server identifier, not the full discovery-document URL, and must not contain a query string or fragment. The ordinary `/v2.0` discovery identifier is used for conventional integrations, but doesn't select the versioned CIMD endpoints.
- **`scopes_supported`** — The fully qualified delegated scopes exposed by the MCP server: the registered Application ID URI plus the exact scope name. For example, `https://mcp.contoso.com/mcp` and `mcp.access` produce `https://mcp.contoso.com/mcp/mcp.access`. List only the scopes clients need to call the server.
- **`bearer_methods_supported`** — Set to `["header"]` to indicate that clients must send the token in the `Authorization` request header.

For the full metadata format and discovery behavior, see the [MCP authorization specification](https://modelcontextprotocol.io/specification/2025-06-18/basic/authorization).

On an unauthenticated request, return a `401` response whose `WWW-Authenticate` header points to the metadata document and lists the required fully qualified scope:

```http
HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer resource_metadata="https://mcp.contoso.com/.well-known/oauth-protected-resource", scope="https://mcp.contoso.com/mcp/mcp.access"
```

## Validate access tokens

Require an access token on protected MCP requests. Validate the token's signature, issuer, audience, lifetime, tenant, client, and permissions. Always use a supported library to validate access tokens.

For v2 tokens issued to your MCP server, the following claims are issued:

| Value | Expected value |
| --- | --- |
| `iss` | `https://login.microsoftonline.com/<issuing-tenant-id>/v2.0` |
| `aud` | Your resource application's client-ID GUID |
| `scp` | The short, case-sensitive scope value, such as `mcp.access` |

For the complete validation checklist, see [Validate Agent ID tokens in a downstream API](how-to-validate-agent-tokens-downstream-api.md).

## Configure token validation in ASP.NET Core

Install Microsoft.Identity.Web:

```dotnetcli
dotnet add package Microsoft.Identity.Web
```

Configure the tenant and MCP server registration:

```json
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "<tenant-id>",
    "ClientId": "<mcp-server-client-id>"
  }
}
```

Register token validation and define a policy for the MCP delegated scope or application role:

```csharp
using Microsoft.Identity.Web;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddMicrosoftIdentityWebApiAuthentication(
    builder.Configuration);

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("McpAccess", policy =>
    {
        policy.RequireAuthenticatedUser();
        policy.RequireAssertion(context =>
            context.User.IsInRole("Mcp.Access")
            || context.User.FindAll("scp").Any(claim =>
                claim.Value
                    .Split(' ', StringSplitOptions.RemoveEmptyEntries)
                    .Contains("mcp.access", StringComparer.Ordinal)));
    });
});

var app = builder.Build();

app.UseAuthentication();
app.UseAuthorization();

app.MapPost("/mcp", () => Results.Ok())
    .RequireAuthorization("McpAccess");

app.Run();
```

Replace `mcp.access` with the delegated scope exposed by the MCP server. Replace `Mcp.Access` with its application role. Apply the `McpAccess` policy to the endpoint mapped by the MCP server framework rather than adding a second `/mcp` route.

The `Results.Ok()` handler is an authorization placeholder, not an MCP implementation. After applying the policy to your framework's endpoint, verify that an authorized client can perform the intended MCP tool or resource operation. Also test a missing token and a valid token without the required permission; an HTTP success from the placeholder alone doesn't verify MCP interoperability.

The authentication middleware returns `401 Unauthorized` for a missing or invalid token. The authorization policy returns `403 Forbidden` when a valid token lacks both the required delegated scope and application role.

For complete framework and authorization guidance, see [Configure protected web API apps](/entra/identity-platform/scenario-protected-web-api-app-configuration) and [Verify scopes and app roles in a protected web API](/entra/identity-platform/scenario-protected-web-api-verification-scope-app-roles).

## Connect a client

The client discovers the protected-resource metadata, signs in or authenticates through Microsoft Entra ID, requests a token for the MCP server, and sends the token in the request's `Authorization` header.

Use one of these client identity models:

- A registered Agent ID.
- A [Client ID Metadata Document](client-id-metadata-documents.md) URL when pre-registration isn't practical.

## Related content

- [Configure a client with a Client ID Metadata Document](configure-client-id-metadata-document.md)
- [Call a custom API as an agent](call-api-custom.md)
- [Configure protected web API apps](/entra/identity-platform/scenario-protected-web-api-app-configuration)
- [Verify scopes and app roles in a protected web API](/entra/identity-platform/scenario-protected-web-api-verification-scope-app-roles)
- [Microsoft identity platform OAuth 2.0 protocols](/entra/identity-platform/v2-protocols)

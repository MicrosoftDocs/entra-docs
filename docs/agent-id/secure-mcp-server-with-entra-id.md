---
title: Secure a Model Context Protocol (MCP) server with Microsoft Entra ID
titleSuffix: Microsoft Entra Agent ID
description: Learn how to secure a Model Context Protocol (MCP) server as an OAuth 2.0 protected resource with Microsoft Entra ID, and connect an MCP client by using Microsoft Entra Agent ID.
ms.topic: how-to
ms.date: 09/01/2026
ai-usage: ai-assisted

#customer-intent: As a developer building or securing an MCP server, I want to implement OAuth 2.0 correctly with Microsoft Entra ID as the authorization server so that MCP clients and agents can obtain and present valid access tokens for my server.
---

# Secure a Model Context Protocol (MCP) server with Microsoft Entra ID

The [Model Context Protocol (MCP)](https://modelcontextprotocol.io) lets AI agents and other clients call tools and data sources that you expose from an MCP server. Because an MCP server can act on behalf of a user or an autonomous agent, you should protect it like any other API: require an OAuth 2.0 access token on every request, and validate that token before you run a tool.

This article explains how to configure Microsoft Entra ID as the authorization server for your MCP server, register the server so that MCP clients can request tokens for it, and connect an MCP client by using [Microsoft Entra Agent ID](what-is-microsoft-entra-agent-id.md).

> [!IMPORTANT]
> Don't write your own token-validation logic from scratch. Token validation bugs can silently expose your MCP server to unauthorized callers. Use a well-tested authentication library or middleware for your platform, and follow the source-of-truth guidance linked in [Validate access tokens in your MCP server](#validate-access-tokens-in-your-mcp-server).

## Prerequisites

- A **Microsoft Entra tenant** where you can register applications. To register apps, you need at least the [Application Developer](/entra/identity/role-based-access-control/permissions-reference#application-developer) role.
- An **MCP server** that you host at an HTTPS URL, for example `https://mcp.contoso.com`.
- Familiarity with the [MCP authorization specification](https://modelcontextprotocol.io/specification/basic/authorization), which builds on OAuth 2.1, [Resource Indicators for OAuth 2.0 (RFC 8707)](https://www.rfc-editor.org/rfc/rfc8707), and [OAuth 2.0 Protected Resource Metadata (RFC 9728)](https://www.rfc-editor.org/rfc/rfc9728).

## How MCP authorization works with Microsoft Entra ID

In the MCP authorization model:

- Your **MCP server** is an OAuth 2.0 *protected resource*.
- **Microsoft Entra ID** is the *authorization server* that issues access tokens.
- The **MCP client**, such as an agent, is the *client* that requests a token and presents it to your server.

The MCP specification requires the client to identify the protected resource it wants a token for by sending the `resource` parameter (from RFC 8707) in its token request. The value of `resource` is the canonical URL of your MCP server. Microsoft Entra ID compares that `resource` value against the **Application ID URI** (also called the identifier URI) configured on your MCP server's app registration. If they match, Microsoft Entra ID issues a token whose audience (`aud`) claim is your MCP server. If they don't match, the token request fails.

For this matching to work, your MCP server must accept **v2 access tokens**. See [Register your MCP server in Microsoft Entra ID](#register-your-mcp-server-in-microsoft-entra-id) for the exact steps to configure the access token version.

The end-to-end flow looks like this:

1. The MCP client discovers your server's authorization requirements. When an unauthenticated request arrives, your server returns `HTTP 401` with a `WWW-Authenticate` header that points to your [protected resource metadata (RFC 9728)](https://www.rfc-editor.org/rfc/rfc9728), which in turn identifies Microsoft Entra ID as the authorization server.
1. The MCP client requests an access token from Microsoft Entra ID, sending `resource=<your MCP server URL>`.
1. Microsoft Entra ID validates the request, matches `resource` to your app registration's Application ID URI, and issues a v2 access token scoped to your server.
1. The MCP client calls your MCP server with the token in the `Authorization: Bearer` header.
1. Your MCP server validates the token and, if it's valid, runs the requested tool.

## Register your MCP server in Microsoft Entra ID

Register your MCP server as an application so that Microsoft Entra ID can issue tokens for it. 

If your MCP server is served by an an existing web service or REST API that is already secured by Entra - you may re-use its existing app registration and its OAuth scopes.

The order of the following steps matters: you must enable v2 access tokens *before* you can set an HTTPS Application ID URI that matches your server URL.

### Step 1: Create the app registration

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **App registrations** > **New registration**.
1. Enter a name for your MCP server, such as `Contoso MCP server`, and select **Register**.

### Step 2: Set the access token version to v2

This is the step that most people miss. Your app registration must request v2 access tokens by setting `requestedAccessTokenVersion` to `2` in the [Microsoft Graph app manifest](/entra/identity-platform/reference-microsoft-graph-app-manifest#api-attribute).

1. In your app registration, select **Manifest**.
1. In the `api` object, set `requestedAccessTokenVersion` to `2`:

    ```json
    "api": {
        "requestedAccessTokenVersion": 2
    }
    ```

1. Select **Save**.

> [!NOTE]
> If you skip this step and leave the app on v1 access tokens, you can't set an HTTPS Application ID URI that matches your MCP server's URL, and MCP clients that send `resource=<your MCP server URL>` receive an error. See [FAQ and troubleshooting](#faq-and-troubleshooting).

### Step 3: Set the Application ID URI to your MCP server URL

After the app issues v2 access tokens, set the Application ID URI to the exact canonical URL of your MCP server. This value is what MCP clients send in the `resource` parameter.

1. In your app registration, select **Expose an API**.
1. Next to **Application ID URI**, select **Add** (or **Edit**), and enter your MCP server's URL, for example `https://mcp.contoso.com`.
1. Select **Save**.

Alternatively, set `identifierUris` directly in the manifest. The `identifierUris` property is a list, so if your MCP server is reachable at more than one URL, add every URL that clients might use. A client typically sends the URL it connected to as its `resource` value, and Microsoft Entra ID only issues a token when that value exactly matches one of the registered Application ID URIs.

```json
"identifierUris": [
    "https://mcp.contoso.com",
    "https://mcp.contoso.com/mcp",
    "https://contoso-mcp.azurewebsites.net"
]
```

### Step 4: Define scopes

Delegated scopes let an MCP client that acts on behalf of a signed-in user request only the level of access it needs. If your MCP server serves interactive clients, define at least one OAuth scope so that clients can request a token for your server and users or administrators can consent to it.

1. In your app registration, select **Expose an API**.
1. Select **Add a scope**.
1. Enter a scope name that reflects an operation your server exposes, such as `tool.read` or `tool.execute`.
1. Choose who can consent (**Admins only**, or **Admins and users**), enter the consent display names and descriptions, set the state to **Enabled**, and select **Add scope**.

An MCP client then requests the fully qualified scope, which combines your Application ID URI and the scope name — for example, `https://mcp.contoso.com/tool.execute`.

Define as many OAuth scopes as needed to provide granular access to your MCP server.

### Step 5 (Optional): Define app roles

In addition to acting on behalf of users, MCP clients can also authenticate as an agent identity. To request an access token as an agent identity, the MCP client sends an OAuth client credentials grant request and uses a scope value such as `scope=https://mcp.contoso.com/.default`.

Entra **app roles** can be used to limit the access an MCP client has against your MCP server. You assign app roles to the MCP client's agent identity. Assigned roles appear in the `roles` claim of the access token, and your server checks that claim before it runs a tool.

1. In your app registration, select **App roles** > **Create app role**.
1. Enter a display name and a value such as `Tools.Execute.All`, set **Allowed member types** to **Applications**, and enable the role.
1. Assign the role to the agent identity (or other client application) that calls your server.

For more information, see [Add app roles and receive them in the token](/entra/identity-platform/howto-add-app-roles-in-apps).

## Publish protected resource metadata

MCP clients discover how to authenticate to your server by reading its [OAuth 2.0 Protected Resource Metadata (PRM)](https://datatracker.ietf.org/doc/html/rfc9728) document. The MCP authorization specification requires every HTTP MCP server to serve a PRM document and to reference it from the `WWW-Authenticate` header of its `401` responses. The document tells clients which authorization server to use (Microsoft Entra ID) and which resource identifier to request a token for.

Serve the document as JSON from the well-known path derived from your server's URL, for example `https://mcp.contoso.com/.well-known/oauth-protected-resource`. For a server secured by Microsoft Entra ID, it should look like this:

```json
{
  "resource": "https://mcp.contoso.com",
  "authorization_servers": [
    "https://login.microsoftonline.com/<tenant-id>/v2.0"
  ],
  "scopes_supported": [
    "tools.read",
    "tools.execute"
  ],
  "bearer_methods_supported": ["header"]
}
```

Set the fields as follows:

- **`resource`** — the canonical URL of your MCP server. This value must be identical to the Application ID URI you registered in [Step 3](#step-3-set-the-application-id-uri-to-your-mcp-server-url) and to the `resource` parameter that clients send. If your server exposes multiple URLs, each PRM document describes one specific URL, and clients request metadata for the URL they connected to.
- **`authorization_servers`** — the Microsoft Entra ID issuer for your tenant, `https://login.microsoftonline.com/<tenant-id>/v2.0`. Clients perform authorization server metadata discovery against this issuer (for example, at `https://login.microsoftonline.com/<tenant-id>/v2.0/.well-known/openid-configuration`) to find Entra's authorization and token endpoints. Use your tenant ID or a verified domain; use `organizations` or `common` in place of the tenant ID only for multitenant servers.
- **`scopes_supported`** — optional. List the delegated scopes you defined in [Step 4](#step-4-define-scopes). Clients use these to decide what to request when the `WWW-Authenticate` challenge doesn't specify a `scope`.
- **`bearer_methods_supported`** — set to `["header"]` because your server expects the token in the `Authorization: Bearer` request header.

> [!IMPORTANT]
> The `authorization_servers` value must be the **v2.0** issuer (`.../v2.0`), which matches the `iss` claim of the v2 access tokens your server accepts (see [Step 2](#step-2-set-the-access-token-version-to-v2)). The v1 issuer (`https://sts.windows.net/<tenant-id>/`) doesn't line up with the v2.0 authorization server metadata that clients discover.

On an unauthenticated request, return a `401` response whose `WWW-Authenticate` header points to this document. Optionally include a `scope` parameter to tell the client which scopes the current operation requires:

```http
HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer resource_metadata="https://mcp.contoso.com/.well-known/oauth-protected-resource", scope="tools.execute"
```

If you use an official MCP SDK or Azure App Service authentication, the platform can generate and serve this document and the `401` challenge for you. See [Validate access tokens in your MCP server](#validate-access-tokens-in-your-mcp-server).

## Validate access tokens in your MCP server

On every request, your MCP server must validate the access token before it runs a tool. At a minimum, verify the token's **signature**, **issuer** (`iss`), **tenant ID** (`tid`), **audience** (`aud`, which must equal the application ID of your MCP server), and expiry. Then check that the **subject** (`sub` or `oid`) of the token is authorized for the requested operation using the **role** (`roles`) claim or another authorization check. For delegated access tokens, also be sure to check the **scope** (`scp`) claim to confirm the caller / actor is authorized for the requested operation.

To avoid introducing a security vulnerability, don't implement these checks by hand. Use the guidance and libraries in the following source-of-truth articles:

- [Protected web API: overview](/entra/identity-platform/scenario-protected-web-api-overview) and [Protected web API: code configuration](/entra/identity-platform/scenario-protected-web-api-app-configuration) — the canonical pattern for protecting an API with Microsoft Entra ID, including recommended middleware such as Microsoft.Identity.Web.
- [Secure access tokens](/entra/identity-platform/access-tokens) and [Validate tokens](/entra/identity-platform/access-tokens#validate-tokens) — how to validate signature, issuer, and audience correctly.
- [Secure applications and APIs by validating claims](/entra/identity-platform/claims-validation) — how to authorize requests by validating the claims in a token, beyond signature and audience checks.
- [Validate agent identity tokens in a downstream API](how-to-validate-agent-tokens-downstream-api.md) — a worked example for Microsoft Entra Agent ID tokens, including how to detect that a caller is an agent identity.

If you host your MCP server on **Azure App Service**, you can offload authentication to the platform's built-in authentication (Easy Auth) instead of validating tokens in your app code. For step-by-step guidance, see [Secure MCP servers with Microsoft Entra authentication on Azure App Service](/azure/app-service/configure-authentication-mcp-server-vscode).

## Connect an MCP client using Microsoft Entra Agent ID

When the MCP client is an AI agent, use [Microsoft Entra Agent ID](what-is-microsoft-entra-agent-id.md) so the agent authenticates with its own identity instead of an embedded secret. The agent acquires a token for your MCP server and presents it on each call.

1. Set up the agent's identity. See [Create and delete agent identities](create-delete-agent-identities.md) and [Authentication protocols in agents](agent-oauth-protocols.md).
1. Grant the agent access to your MCP server, either by consenting to a delegated scope that you defined in [Step 4](#step-4-define-scopes) or by assigning an app role that you defined in [Step 5](#step-5-optional-define-app-roles).
1. Have the agent acquire a token for your MCP server. The client sends `resource=<your MCP server URL>` (per the MCP specification) and requests the appropriate OAuth scope.
1. The agent calls your MCP server with the token in the `Authorization: Bearer` header. Your server validates it as described in [Validate access tokens in your MCP server](#validate-access-tokens-in-your-mcp-server).

For a broader view of how agents call protected resources, see [Configure third-party agents with Agent ID](configure-third-party-agents.md) and [Call custom APIs from an agent](call-api-custom.md).

## FAQ and troubleshooting

### Should my MCP server use v1 or v2 access tokens?

Use **v2 access tokens**. Set `requestedAccessTokenVersion` to `2` on your MCP server's app registration, as described in [Step 2](#step-2-set-the-access-token-version-to-v2). MCP authorization relies on matching the client's `resource` parameter to an HTTPS Application ID URI, and that configuration requires v2 tokens.

### I get error AADSTS9010010 when a client requests a token for my MCP server

`AADSTS9010010` means the **Application ID URI configured on your app registration doesn't exactly match the value of the `resource` parameter** in the client's OAuth request. To fix it:

1. **Check for a trailing slash or other exact-match difference.** The `resource` value the client sends must match the Application ID URI character for character, including the scheme (`https://`), casing of the host, and path. A trailing slash is a common culprit: because an Application ID URI can't end with a slash, a client that sends `resource=https://mcp.contoso.com/` never matches the registered `https://mcp.contoso.com`. Remove the trailing slash (and any other difference) so the client's `resource` value and the Application ID URI are identical.
1. **Confirm your app uses v2 access tokens.** If `requestedAccessTokenVersion` isn't set to `2`, you can't register an HTTPS Application ID URI that matches your MCP server URL, so the `resource` value can never match. Complete [Step 2](#step-2-set-the-access-token-version-to-v2), then re-add the Application ID URI in [Step 3](#step-3-set-the-application-id-uri-to-your-mcp-server-url).
1. **Make sure the requested scope belongs to the same app registration as the `resource`.** This error also occurs when the client sends a scope that's defined on a *different* app registration than the one referenced by the `resource` parameter. Microsoft Entra ID resolves the `resource` and the scope to the same resource app; if they point at different app registrations, the request fails. Confirm that every scope the client requests is exposed by the app registration whose Application ID URI you send in `resource`, and remove any scope that belongs to another app.

### What if I can't use v2 access tokens?

Some MCP servers reuse an existing app registration that already issues v1 access tokens to other clients, and can't switch to v2 tokens without breaking those clients. In that case, you can keep v1 tokens and instead make the `aud` claim deterministic by configuring the [`aud` optional claim](/entra/identity-platform/optional-claims-reference#v10-specific-optional-claims-set) with the `use_guid` [additional property](/entra/identity-platform/optional-claims-reference#additionalproperties-of-optional-claims).

By default, the `aud` claim in a v1 access token is nondeterministic — Microsoft Entra ID can emit any of the app's Application ID URIs (with or without a trailing slash) or the resource's client ID. Setting `use_guid` forces `aud` to *always* be the resource's client ID in GUID format. Because the audience is no longer tied to a specific Application ID URI, Microsoft Entra ID relaxes the Application ID URI restrictions for the app, so you can add your MCP server's HTTPS URL as an Application ID URI ([Step 3](#step-3-set-the-application-id-uri-to-your-mcp-server-url)) even though the app still issues v1 tokens. Clients can then send `resource=<your MCP server URL>` and receive a token.

Add the optional claim to your app registration's manifest:

```json
"optionalClaims": {
    "accessToken": [
        {
            "name": "aud",
            "additionalProperties": ["use_guid"]
        }
    ]
}
```

With `use_guid` set, the token's `aud` claim is your resource's **client ID** (a GUID), not your MCP server URL. Configure your MCP server (or the middleware or MCP SDK that validates tokens) to expect that client-ID GUID as the audience. Whenever you can move to v2 tokens, prefer that approach ([Step 2](#step-2-set-the-access-token-version-to-v2)), because the v2 `aud` claim is consistently the resource's client ID and aligns with the authorization server metadata that MCP clients discover.

## Related content

- [What is Microsoft Entra Agent ID?](what-is-microsoft-entra-agent-id.md)
- [Authentication protocols in agents](agent-oauth-protocols.md)
- [Validate agent identity tokens in a downstream API](how-to-validate-agent-tokens-downstream-api.md)
- [Protected web API: overview](/entra/identity-platform/scenario-protected-web-api-overview)
- [Secure MCP servers with Microsoft Entra authentication on Azure App Service](/azure/app-service/configure-authentication-mcp-server-vscode)
- [Understand the app manifest (Microsoft Graph format)](/entra/identity-platform/reference-microsoft-graph-app-manifest)

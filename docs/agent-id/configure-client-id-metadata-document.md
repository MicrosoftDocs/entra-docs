---
title: Configure a client to use a Client ID Metadata Document
titleSuffix: Microsoft Entra Agent ID
description: Publish a Client ID Metadata Document and use its URL as the client ID when connecting an OAuth or MCP client to Microsoft Entra ID.
ms.topic: how-to
ms.date: 11/05/2026
ai-usage: ai-assisted

#customer-intent: As an MCP client developer, I want to publish a Client ID Metadata Document and request Microsoft Entra tokens so that my client can connect to Entra-protected MCP servers without prior registration.
---

# Configure a client to use a Client ID Metadata Document (preview)

By using a Client ID Metadata Document (CIMD), your OAuth client can use a public HTTPS URL as its `client_id`. This article explains how to publish a CIMD document and use it to request a delegated access token from Microsoft Entra ID.

> [!IMPORTANT]
> Client ID Metadata Document support in Microsoft Entra ID is in public preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

Before implementing CIMD, review [Client ID Metadata Documents in Microsoft Entra ID](client-id-metadata-documents.md) to understand the supported scenarios, security model, and limitations.

## Prerequisites

To complete this procedure, you need:

- An OAuth client that supports the authorization code flow and PKCE.
- A stable public HTTPS endpoint where you can publish a JSON document.
- An MCP server secured with Microsoft Entra ID. See [Prepare the MCP server](#prepare-the-mcp-server).
- A Microsoft Entra tenant in which CIMD support is available.
- A tenant administrator who can [add the CIMD client and grant delegated permissions](manage-client-id-metadata-document-clients.md#add-via-admin-center) when user consent isn't available. Give the administrator the document URL, target resource, and requested scopes before testing sign-in.

## Prepare the MCP server

A CIMD client learns everything about the MCP server from the server's protected resource metadata and from Microsoft Entra ID. Set up the server by following [Secure an MCP server with Microsoft Entra ID](secure-mcp-server-with-entra-id.md). That article covers registering the server, exposing a delegated scope, publishing protected resource metadata, and validating access tokens.

Host the MCP endpoint at a nonempty path with no trailing slash, such as `https://mcp.contoso.com/mcp`. Don't use the host root: some MCP clients append a slash, causing token acquisition to fail because the resource identifier no longer matches. Microsoft Entra ID doesn't accept trailing slashes on Application ID URIs.

Then confirm the following settings. The examples in this article use an MCP server at `https://mcp.contoso.com/mcp` that exposes the `mcp.access` scope.

| Setting | Required value | Example |
| --- | --- | --- |
| Application ID URI of the server's app registration | The server's canonical endpoint URL, with a nonempty path and no trailing slash. | `https://mcp.contoso.com/mcp` |
| `resource` in the protected resource metadata | The same value as the Application ID URI. The client sends this value in its `resource` parameter; the v2 access token's `aud` is the resource application's client-ID GUID. | `https://mcp.contoso.com/mcp` |
| `authorization_servers` in the protected resource metadata | The Microsoft Entra authorization server URL for the tenant, or `organizations` for a multitenant server. | `https://login.microsoftonline.com/{tenant}/oauth21/2026-08` |
| `scopes_supported` in the protected resource metadata | The fully qualified delegated scope that the client requests. | `https://mcp.contoso.com/mcp/mcp.access` |

Verify that the server publishes its metadata:

```http
GET https://mcp.contoso.com/.well-known/oauth-protected-resource
```

The response must contain the `resource`, `authorization_servers`, and `scopes_supported` values from the preceding table.

## Publish the metadata document

Publish a JSON document at the URL that you intend to use as the client ID. For example:

```http
GET https://client.contoso.com/oauth/client-metadata.json
Content-Type: application/json
```

```json
{
  "client_id": "https://client.contoso.com/oauth/client-metadata.json",
  "client_name": "Contoso Agent",
  "client_uri": "https://client.contoso.com",
  "logo_uri": "https://client.contoso.com/logo.png",
  "redirect_uris": [
    "https://client.contoso.com/oauth/callback"
  ],
  "grant_types": [
    "authorization_code",
    "refresh_token"
  ],
  "response_types": [
    "code"
  ],
  "token_endpoint_auth_method": "none"
}
```

Follow these requirements:

- Use an HTTPS URL with a nonempty path.
- Set `client_id` to the exact URL that serves the document.
- Keep the URL short and stable. It can appear in consent and administration experiences.
- List every redirect URI that the client might use. Microsoft Entra ID uses exact string matching.
- Use HTTPS redirect URIs. Loopback redirect URIs can be used for local native-client scenarios where the applicable OAuth specification permits them.
- Don't rely on HTTP redirects when Microsoft Entra ID retrieves the document.
- Return a successful HTTP status and a valid JSON response.
- Set `token_endpoint_auth_method` to `none`. Don't use a client secret or a private-key client assertion during preview.

The document format is defined by the [OAuth Client ID Metadata Document specification](https://datatracker.ietf.org/doc/draft-ietf-oauth-client-id-metadata-document/).

> [!CAUTION]
> Treat the document URL and its domain as long-lived security assets. If you move the document to another URL, Microsoft Entra ID treats it as a different client. Existing consent grants don't transfer.

## Check authorization server support

Before sending a URL as a client ID, confirm that the authorization server for the target tenant supports CIMD.

1. Identify the authorization server. For an MCP server, fetch its protected resource metadata from the URL advertised in its `WWW-Authenticate` header and read the `authorization_servers` value. The following example hosts metadata at the server origin, separately from the `/mcp` endpoint:

    ```http
    GET https://mcp.contoso.com/.well-known/oauth-protected-resource
    ```

    ```json
    {
      "resource": "https://mcp.contoso.com/mcp",
      "authorization_servers": ["https://login.microsoftonline.com/{tenant}/oauth21/2026-08"]
    }
    ```

    For other protected resources, use `https://login.microsoftonline.com/{tenant}/oauth21/2026-08`, where `{tenant}` is `common`, the tenant ID, or a verified domain of the organization.

1. Fetch the authorization server metadata by appending `/.well-known/openid-configuration` to the authorization server URL:

    ```http
    GET https://login.microsoftonline.com/{tenant}/oauth21/2026-08/.well-known/openid-configuration
    ```

1. Check the response for the `client_id_metadata_document_supported` property. A CIMD-capable authorization server returns `true`:

    ```json
    {
      "client_id_metadata_document_supported": true
    }
    ```

Don't send a CIMD client ID when the property is missing or `false`. Fall back to a registered client ID or another registration method that the authorization server supports.

## Send the authorization request

Set `client_id` to the URL of your metadata document. For an MCP server, also include the protected resource URL in the `resource` parameter.

```http
GET https://login.microsoftonline.com/{tenant}/oauth21/2026-08/authorize
    ?client_id=https%3A%2F%2Fclient.contoso.com%2Foauth%2Fclient-metadata.json
    &response_type=code
    &redirect_uri=https%3A%2F%2Fclient.contoso.com%2Foauth%2Fcallback
    &scope=offline_access%20https%3A%2F%2Fmcp.contoso.com%2Fmcp%2Fmcp.access
    &resource=https%3A%2F%2Fmcp.contoso.com%2Fmcp
    &code_challenge={PKCE_challenge}
    &code_challenge_method=S256
    &state={opaque_value}
```

Replace:

- `{tenant}` with the tenant identifier or verified domain for the organization.
- `{PKCE_challenge}` with the S256 challenge generated from your code verifier.
- `{opaque_value}` with a value that your client validates when the authorization response returns.
- The resource and scope values with those published by the MCP server.

Microsoft Entra ID retrieves and validates the metadata document. The requested `redirect_uri` must exactly match one of the values in `redirect_uris`.

Depending on tenant policy and whether an administrator added the client in advance, the user might:

- Continue without a new prompt because an administrator already granted the required scopes for all users in the tenant.
- Consent to the specific delegated permissions allowed by the tenant's consent policy.
- Be told that administrator approval is required.
- Be blocked from adding the client.

## Redeem the authorization code

After Microsoft Entra ID returns an authorization code, validate the `state` value, then redeem the authorization code at the `token_endpoint` returned by the versioned discovery document:

```http
POST https://login.microsoftonline.com/{tenant}/oauth21/2026-08/token
Content-Type: application/x-www-form-urlencoded

client_id=https%3A%2F%2Fclient.contoso.com%2Foauth%2Fclient-metadata.json&
grant_type=authorization_code&
code={authorization_code}&
redirect_uri=https%3A%2F%2Fclient.contoso.com%2Foauth%2Fcallback&
code_verifier={PKCE_code_verifier}&
scope=https%3A%2F%2Fmcp.contoso.com%2Fmcp%2Fmcp.access&
resource=https%3A%2F%2Fmcp.contoso.com%2Fmcp
```

## Troubleshoot common failures

| Failure | What to check |
| --- | --- |
| The metadata document can't be retrieved | Confirm that the URL is publicly reachable over HTTPS, returns a successful response directly, and doesn't redirect. |
| The client ID is rejected | Confirm that the requested `client_id`, the retrieval URL, and the document's `client_id` are identical. |
| The redirect URI is rejected | Compare the requested redirect URI with the document, including scheme, host, path, port, case, and trailing slash. |
| Token acquisition fails with a host-root or trailing-slash resource URL | Host the MCP endpoint at a path such as `/mcp` without a trailing slash. Use that exact URL for the Application ID URI, metadata `resource`, and OAuth `resource` parameter. |
| The user can't approve the client | Review assigned consent policies, risk-based step-up consent, and whether the requested permissions require administrator consent. Under the strict posture, an administrator grants scopes for all users. Under the loose posture, follow the CIMD policy and risk-based step-up configuration in the management article. |
| CIMD isn't discovered or the URL client ID is rejected by the authorization server | Use the versioned `/oauth21/2026-08` discovery document and the endpoints it advertises. Confirm that `client_id_metadata_document_supported` is `true`. |
| The MCP server returns HTTP 401 after token acquisition | Check server-side signature, lifetime, tenant, issuer, and audience validation. Don't equate the versioned discovery identifier with the token's tenant-specific `/v2.0` issuer. |
| The token has the wrong audience | Send the MCP server's canonical URL as `resource` and request a scope exposed by that resource. |
| A client with the URL already exists | Reuse the existing tenant-local identity. Only one CIMD-backed identity for a canonical URL can exist in a tenant. |
| The client stopped working after a URL change | Restore the original URL or onboard the new URL as a new identity and obtain consent again. |

## Related content

- [Authenticate a local agent with Microsoft Entra ID](authenticate-local-agent.md)
- [Client ID Metadata Documents in Microsoft Entra ID](client-id-metadata-documents.md)
- [Grant delegated permissions to an agent identity](grant-agent-access-microsoft-365.md)
- [Manage CIMD clients in Microsoft Entra ID](manage-client-id-metadata-document-clients.md)
- [Secure an MCP server with Microsoft Entra ID](secure-mcp-server-with-entra-id.md)

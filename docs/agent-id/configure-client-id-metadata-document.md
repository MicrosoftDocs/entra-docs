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
- A tenant administrator who can [add the CIMD client and grant delegated permissions](manage-client-id-metadata-document-clients.md#add-a-cimd-client-in-the-admin-center) when user consent isn't available. Give the administrator the document URL, target resource, and requested scopes before testing sign-in.

The client must be able to open a browser for user sign-in. CIMD clients can't use the client credentials grant.

## Prepare the MCP server

A CIMD client has no app registration, so it learns everything about the MCP server from the server's protected resource metadata and from Microsoft Entra ID. Set up the server by following [Secure an MCP server with Microsoft Entra ID](secure-mcp-server-with-entra-id.md). That article covers registering the server, exposing a delegated scope, publishing protected resource metadata, and validating access tokens.

Then confirm the following settings. The examples in this article use an MCP server at `https://mcp.contoso.com` that exposes the `mcp.access` scope.

| Setting | Required value | Example |
| --- | --- | --- |
| Application ID URI of the server's app registration | The server's canonical URL. | `https://mcp.contoso.com` |
| `resource` in the protected resource metadata | The same value as the Application ID URI. The client sends this value in its `resource` parameter, and Microsoft Entra ID issues the token with this audience. | `https://mcp.contoso.com` |
| `authorization_servers` in the protected resource metadata | The Microsoft Entra authorization server URL for the tenant, or `common` for a multitenant server. | `https://login.microsoftonline.com/{tenant}/oauth21/2026-08` |
| `scopes_supported` in the protected resource metadata | The delegated scope that the client requests. | `mcp.access` |
| Who can consent to the delegated scope | **Admins and users** lets users consent to the client themselves, if the tenant's consent policy permits it. **Admins only** requires an administrator to approve the client. | Admins and users |
| Supported account types | **Multiple Entra ID tenants** when `authorization_servers` uses `common`. | Single tenant |

Verify that the server publishes its metadata:

```http
GET https://mcp.contoso.com/.well-known/oauth-protected-resource
```

The response must contain the `resource`, `authorization_servers`, and `scopes_supported` values from the preceding table. The MCP server doesn't need CIMD-specific token-validation logic. Microsoft Entra ID issues the access token, and the server validates it like any other access token.

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
  "token_endpoint_auth_method": "none",
  "scope": "offline_access https://mcp.contoso.com/mcp.access"
}
```

Follow these requirements:

- Use an HTTPS URL with a nonempty path.
- Don't include user information or a fragment in the URL.
- Set `client_id` to the exact URL that serves the document.
- Keep the URL short and stable. It can appear in consent and administration experiences.
- List every redirect URI that the client might use. Microsoft Entra ID uses exact string matching.
- Use HTTPS redirect URIs. Loopback redirect URIs can be used for local native-client scenarios where the applicable OAuth specification permits them.
- Don't rely on HTTP redirects when Microsoft Entra ID retrieves the document.
- Return a successful HTTP status and a valid JSON response.
- Don't use a shared client secret. Set `token_endpoint_auth_method` to `none` for a public client.

The document format is defined by the [OAuth Client ID Metadata Document specification](https://datatracker.ietf.org/doc/draft-ietf-oauth-client-id-metadata-document/).

> [!CAUTION]
> Treat the document URL and its domain as long-lived security assets. If you move the document to another URL, Microsoft Entra ID treats it as a different client. Existing consent grants don't transfer.

## Check authorization server support

Before sending a URL as a client ID, confirm that the authorization server for the target tenant supports CIMD.

1. Identify the authorization server. For an MCP server, fetch its protected resource metadata from `<server-url>/.well-known/oauth-protected-resource` and read the `authorization_servers` value:

    ```http
    GET https://mcp.contoso.com/.well-known/oauth-protected-resource
    ```

    ```json
    {
      "resource": "https://mcp.contoso.com",
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

    The response contains other properties that aren't shown here, including `authorization_endpoint` and `token_endpoint`. A client that uses metadata discovery, such as an MCP client, sends its requests to those endpoints. The following examples use the Microsoft Entra v2.0 endpoints, which also support CIMD client IDs.

Don't send a CIMD client ID when the property is missing or `false`. Fall back to a registered client ID or another registration method that the authorization server supports.

## Send the authorization request

Set `client_id` to the URL of your metadata document. For an MCP server, also include the protected resource URL in the `resource` parameter.

```http
GET https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize
    ?client_id=https%3A%2F%2Fclient.contoso.com%2Foauth%2Fclient-metadata.json
    &response_type=code
    &redirect_uri=https%3A%2F%2Fclient.contoso.com%2Foauth%2Fcallback
    &scope=offline_access%20https%3A%2F%2Fmcp.contoso.com%2Fmcp.access
    &resource=https%3A%2F%2Fmcp.contoso.com
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

- Continue without a new prompt because an administrator already granted consent.
- Consent to low-risk delegated permissions.
- Be told that administrator approval is required.
- Be blocked from adding the client.

The authorization request is one way to grant delegated permissions to the client's agent identity. For the other methods, including administrator consent, see [Grant delegated permissions to an agent identity](grant-agent-access-microsoft-365.md).

During preview, grant permissions through the sign-in and consent endpoints or Microsoft Graph, not the portal permissions experience. The admin consent request workflow is disabled for Agent ID, including CIMD clients. In a default tenant, plan for an administrator to add the client and grant consent before users sign in; don't rely on user consent being available.

## Redeem the authorization code

After Microsoft Entra ID returns an authorization code, redeem it at the tenant's v2 token endpoint:

```http
POST https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=https%3A%2F%2Fclient.contoso.com%2Foauth%2Fclient-metadata.json&
grant_type=authorization_code&
code={authorization_code}&
redirect_uri=https%3A%2F%2Fclient.contoso.com%2Foauth%2Fcallback&
code_verifier={PKCE_code_verifier}&
scope=https%3A%2F%2Fmcp.contoso.com%2Fmcp.access&
resource=https%3A%2F%2Fmcp.contoso.com
```

Validate the `state` value before redeeming the code. Store tokens using the secure storage provided by the client platform.

The access token is issued to the resource, not to the CIMD client. The client uses the token to call the protected resource in the same way as another OAuth client.

## Troubleshoot common failures

| Failure | What to check |
| --- | --- |
| The metadata document can't be retrieved | Confirm that the URL is publicly reachable over HTTPS, returns a successful response directly, and doesn't redirect. |
| The client ID is rejected | Confirm that the requested `client_id`, the retrieval URL, and the document's `client_id` are identical. |
| The redirect URI is rejected | Compare the requested redirect URI with the document, including scheme, host, path, port, case, and trailing slash. |
| The user can't approve the client | Review the tenant's user consent policy and whether the requested permissions require administrator consent. |
| The token has the wrong audience | Send the MCP server's canonical URL as `resource` and request a scope exposed by that resource. |
| A client with the URL already exists | Reuse the existing tenant-local identity. Only one CIMD-backed identity for a canonical URL can exist in a tenant. |
| The client stopped working after a URL change | Restore the original URL or onboard the new URL as a new identity and obtain consent again. |

## Related content

- [Authenticate a local agent with Microsoft Entra ID](authenticate-local-agent.md)
- [Client ID Metadata Documents in Microsoft Entra ID](client-id-metadata-documents.md)
- [Grant delegated permissions to an agent identity](grant-agent-access-microsoft-365.md)
- [Manage CIMD clients in Microsoft Entra ID](manage-client-id-metadata-document-clients.md)
- [Secure an MCP server with Microsoft Entra ID](secure-mcp-server-with-entra-id.md)

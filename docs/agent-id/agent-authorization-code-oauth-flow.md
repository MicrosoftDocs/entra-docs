---
title: OAuth 2.0 authorization code grant
description: Learn how public and confidential clients use the authorization code grant with Agent ID.
titleSuffix: Microsoft Entra Agent ID
ms.topic: reference
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.reviewer: jmprieur

#customer-intent: As a developer, I want to understand how public and confidential clients use the authorization code grant in an Agent ID solution.
---

# OAuth 2.0 authorization code grant

The OAuth 2.0 authorization code grant signs in a user and obtains tokens with delegated permissions. The user signs in through a browser, Microsoft Entra ID returns a short-lived authorization code, and the client redeems the code at the token endpoint.

An Agent ID solution can use the grant in two ways:

| Client type | Typical role | Client credential | PKCE |
| --- | --- | --- | --- |
| Public client | A local agent signs in the user directly. | No | Required |
| Confidential client | A server-side web client signs in the user before calling a hosted agent. | Yes | Recommended |

Use Microsoft Authentication Library (MSAL) or Microsoft.Identity.Web instead of creating these requests directly. The requests in this article show the protocol fields for reference.

[!INCLUDE [Use Microsoft SDKs](./includes/use-microsoft-libraries.md)]

> [!IMPORTANT]
> Public-client Agent ID support is in preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

## Authorization request

Both client types send the user to the tenant's authorization endpoint:

```http
GET https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/authorize?
    client_id={client-id}
    &response_type=code
    &redirect_uri={encoded-redirect-uri}
    &response_mode=query
    &scope=openid%20profile%20offline_access%20api://{resource-client-id}/{scope}
    &state={random-state}
    &nonce={random-nonce}
    &code_challenge={pkce-challenge}
    &code_challenge_method=S256
```

- `client_id` identifies the public or confidential client. A CIMD-based public client uses its HTTPS metadata document URL as the client ID.
- `redirect_uri` must exactly match a redirect URI configured for the client.
- `scope` contains the delegated permissions the client requests. Omit the resource scope when the client only needs to sign in the user.
- `state` binds the response to the initiating session and helps prevent cross-site request forgery.
- `nonce` binds an OpenID Connect ID token to the initiating session.
- `code_challenge` is derived from a high-entropy PKCE verifier by using SHA-256.

After sign-in and consent, Microsoft Entra ID redirects the browser to the registered redirect URI:

```http
GET {redirect-uri}?code={authorization-code}&state={state}
```

Before redeeming the code, validate `state` and handle any OAuth error returned to the redirect URI.

## Public client token request

A public client can't protect a client credential. It redeems the code by using the PKCE verifier:

```http
POST https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id={agent-id-client-id-or-cimd-url}
&grant_type=authorization_code
&code={authorization-code}
&redirect_uri={redirect-uri}
&scope=openid profile offline_access api://{resource-client-id}/{scope}
&code_verifier={pkce-verifier}
```

Don't send a client secret, certificate assertion, or federated credential in this request.

A registered public-client Agent ID must use [single-instance mode](agent-blueprint.md#instance-modes-preview). A client that uses a [Client ID Metadata Document](client-id-metadata-documents.md) can use the document's HTTPS URL as its client ID. For implementation guidance, see [Sign in users from a local agent](authenticate-local-agent.md).

## Confidential client token request

A confidential client runs on a server that can protect credentials. The server, not browser code, redeems the authorization code. The request includes a client credential and the PKCE verifier when the authorization request used PKCE:

```http
POST https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id={confidential-client-id}
&grant_type=authorization_code
&code={authorization-code}
&redirect_uri={redirect-uri}
&scope=openid profile offline_access api://{agent-blueprint-client-id}/{scope}
&code_verifier={pkce-verifier}
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion={signed-client-assertion}
```

The example uses a certificate-based client assertion. A client secret is also supported, but use a certificate or workload identity federation when possible.

In a hosted Agent ID solution, the confidential client is normally the upstream web application, not the child Agent ID. Request an access token whose audience is the hosted agent's blueprint, send that access token to the agent API, and use the [On-Behalf-Of flow](agent-on-behalf-of-oauth-flow.md) to call downstream APIs.

For a single-instance agent identity (preview), `<agent-blueprint-client-id>` denotes the client ID shared by the blueprint and agent identity. For a fleet, it denotes the blueprint's client ID, not an individual child agent's ID. For single-instance mode, configure the upstream client's grant through [Grant the upstream client access](aspnet-core-authenticate-users.md#grant-the-upstream-client-access) before sign-in; browser consent doesn't support the agent identity as a resource.

Don't send an authorization code or ID token to the hosted agent API. Child Agent IDs in the confidential-client pattern don't initiate an interactive `/authorize` request.

## Token response

If the request succeeds, Microsoft Entra ID returns tokens such as:

```json
{
  "token_type": "Bearer",
  "scope": "api://<resource-client-id>/<scope>",
  "expires_in": 3599,
  "access_token": "<access-token>",
  "refresh_token": "<refresh-token>",
  "id_token": "<id-token>"
}
```

The exact response depends on the requested scopes:

- Use the access token only with the resource identified by its `aud` claim.
- Use the ID token to establish the user's sign-in session, not to call an API.
- A refresh token is returned when the request and policy allow offline access.

## Security requirements

- Use PKCE with the `S256` challenge method for public clients. Also use PKCE for confidential clients when the library supports it.
- Match the redirect URI exactly in the authorization and token requests.
- Generate a new `state`, `nonce`, and PKCE verifier for each authorization request.
- Redeem an authorization code only once and only from the client that started the request.
- Don't log authorization codes, client credentials, access tokens, refresh tokens, or ID tokens.
- Validate access tokens in the API. Don't treat possession of an authorization code or ID token as API authorization.

## Related content

- [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow)
- [Public client and confidential client applications](/entra/identity-platform/msal-client-applications)
- [Redirect URI restrictions and limitations](/entra/identity-platform/reply-url)
- [Certificate credentials for application authentication](/entra/identity-platform/certificate-credentials)
- [Choose an authentication protocol for an agent](agent-oauth-protocols.md)

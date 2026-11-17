---
title: Grant delegated permissions to an agent identity
description: Request or grant consent for OAuth scopes used by an agent to call APIs on behalf of a signed-in user.
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: ergreenl
#Customer intent: As a developer, I want to request consent for the minimum delegated permissions my agent needs to call APIs for a signed-in user.
---

# Grant delegated permissions to an agent identity

Delegated permissions, also called OAuth scopes, let an agent call a downstream API on behalf of a signed-in user. Each scope defines an operation the agent can perform with that user's access. Consent records whether a user or administrator approved the requested scopes for the agent identity.

An agent needs consent before it can use the OAuth On-Behalf-Of (OBO) flow to get a downstream access token. Request only the scopes required for the current task. Add other scopes later when the agent introduces features that need them.

In this article, you choose a consent method and request or grant the scopes your agent needs.

## Choose a consent method

You can grant delegated permissions to an agent identity in three ways:

| Method | Who grants consent | Use it when |
| --- | --- | --- |
| [Authorization request](#method-1-request-user-consent-with-an-authorization-request) | A user, for themselves | The permission allows user consent and the user is present. |
| [Admin consent endpoint](#method-2-request-administrator-consent-with-the-admin-consent-endpoint) | An administrator, for the organization | The permission requires administrator consent, or the organization approves the agent in advance. |
| [Microsoft Graph](#method-3-grant-consent-with-microsoft-graph) | An administrator or automation, for the organization or one user | You grant consent programmatically, such as when you provision an agent. |

Methods 1 and 2 use the agent identity's client ID; method 3 uses its service principal object ID. For identifier meanings, see [Record the identifiers for your scenario](key-concepts.md#record-the-identifiers-for-your-scenario).

For an introduction to scopes and consent, see [OAuth 2.0 scopes and OpenID Connect scopes](/entra/identity-platform/scopes-oidc) and [Permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview).

## Choose delegated permissions

Start with the operations the agent performs, and identify the least-privileged delegated permissions that support them:

- For Microsoft Graph, use the [Microsoft Graph permissions reference](/graph/permissions-reference).
- For a custom API, use the scopes exposed by the API owner.
- Check whether each permission allows user consent or requires administrator consent.

The downstream API includes the granted delegated permissions in the access token's `scp` claim.

## Method 1: Request user consent with an authorization request

Direct the signed-in user to the authorization endpoint to consent on their own behalf. Use the agent identity client ID as the OAuth client. For single-instance agents, it is shared with the blueprint; for fleets, use the selected agent's client ID, not the blueprint's.

The blueprint must have a registered web redirect URI. The consent-only authorization request uses `response_type=none`. It records consent without returning an access token.

```text
https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/authorize
?client_id=<agent-identity-client-id>
&response_type=none
&redirect_uri=<registered-redirect-uri>
&response_mode=query
&scope=https%3A%2F%2Fgraph.microsoft.com%2FUser.Read
&state=<opaque-state-value>
```

Replace the example scope with the fully qualified downstream scopes the agent needs. Validate `state` when the browser returns to the redirect URI to prevent request forgery.

For authorization-request parameters, see the [OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow).

## Method 2: Request administrator consent with the admin consent endpoint

An administrator can grant delegated permissions for the entire organization when:

- The permission requires administrator consent.
- User consent is turned off or restricted in the tenant.
- The organization wants to preapprove the agent before any user accesses it.

Direct the administrator to the admin consent endpoint:

```text
https://login.microsoftonline.com/<tenant-id>/v2.0/adminconsent
?client_id=<agent-identity-client-id>
&redirect_uri=<registered-redirect-uri>
&scope=https%3A%2F%2Fgraph.microsoft.com%2FUser.Read%20https%3A%2F%2Fgraph.microsoft.com%2FMail.Read
&state=<opaque-state-value>
```

| Parameter | Description |
| --- | --- |
| `client_id` | Client ID of the agent identity. For single-instance agents, this is shared with the blueprint. For fleets, don't use the blueprint client ID. |
| `redirect_uri` | A registered redirect URI on the blueprint app registration. |
| `scope` | Space-separated, percent-encoded fully qualified downstream scopes. |
| `state` | Opaque value validated on return to prevent request forgery. |

After the administrator authenticates and approves, Microsoft Entra redirects to the redirect URI. Validate `state` before processing the response.

## Method 3: Grant consent with Microsoft Graph

Create an `oauth2PermissionGrant` to record tenant-wide admin consent for the agent identity:

```http
POST https://graph.microsoft.com/v1.0/oauth2PermissionGrants
Content-Type: application/json
Authorization: Bearer <admin-token>

{
  "clientId": "<agent-identity-service-principal-object-id>",
  "consentType": "AllPrincipals",
  "resourceId": "<resource-api-service-principal-object-id>",
  "scope": "User.Read Mail.Read"
}
```

| Property | Description |
| --- | --- |
| `clientId` | Object ID of the agent identity's service principal. |
| `consentType` | `AllPrincipals` for tenant-wide admin consent. Use `Principal` with a `principalId` for single-user consent. |
| `resourceId` | Object ID of the resource API's service principal in the tenant. |
| `scope` | Space-separated scope names (not URLs). For example, `User.Read Mail.Read`. |

To find the resource API's service principal object ID, query by its app ID:

```http
GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=appId eq '<resource-app-id>'&$select=id,displayName
```

The Microsoft Graph app ID is always `00000003-0000-0000-c000-000000000000`. For a custom API, use the app registration's application (client) ID.

A successful request returns `201 Created`. Update an existing grant with `PATCH` instead of creating a duplicate.

## Verify consent

Request a new downstream access token after consent changes. Confirm that its `scp` claim contains the delegated scopes required by the operation.

If OBO returns a consent-related error, verify:

- The requested scope matches a delegated permission exposed by the downstream API.
- The user or an administrator granted that scope to the agent identity.
- The authorization request used the agent identity client ID (the shared client ID for a single-instance agent).

## Related content

- [Grant Microsoft Graph application permissions to an agent identity](grant-application-permissions-agent-identity.md)
- [Call a custom API as a user with ASP.NET Core](aspnet-core-call-custom-api-as-user.md)
- [Call a custom API as a user with the Auth SDK sidecar](sidecar-call-custom-api-as-user.md)
- [Microsoft identity platform On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)

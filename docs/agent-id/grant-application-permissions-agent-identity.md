---
title: Grant Microsoft Graph application permissions to an agent identity
description: Grant application permissions to an agent identity with an authorization request, the admin consent endpoint, or Microsoft Graph.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.reviewer: dastrock

#customer-intent: As a developer or administrator, I want to grant Microsoft Graph application permissions to an agent identity so that it can call APIs as itself without a signed-in user.
---

# Grant Microsoft Graph application permissions to an agent identity

Application permissions let an agent call Microsoft Graph as itself, without a signed-in user. All application permissions require administrator approval. Users can't consent to them.

You can grant application permissions to an agent identity in three ways:

| Method | Who grants consent | Use it when |
| --- | --- | --- |
| [Authorization request](#method-1-request-administrator-consent-with-an-authorization-request) | An administrator who signs in through the agent's consent flow | The agent or its setup experience prompts an administrator interactively. |
| [Admin consent endpoint](#method-2-request-administrator-consent-with-the-admin-consent-endpoint) | An administrator, for the organization | You send an administrator a link to approve the agent. |
| [Microsoft Graph](#method-3-assign-application-permissions-with-microsoft-graph) | An administrator or automation | You grant permissions programmatically, such as when you provision an agent. |

> [!NOTE]
> For Azure services, grant the agent identity an Azure RBAC role on the target resource rather than an application permission. See [Call Azure services as an agent with ASP.NET Core](call-api-azure-services.md).

## Prerequisites

- An agent identity created from a blueprint. Record its client ID for methods 1 and 2, and its service principal object ID for method 3. For identifier meanings, see [Record the identifiers for your scenario](key-concepts.md#record-the-identifiers-for-your-scenario).
- Global Administrator or Privileged Role Administrator role to grant admin consent.
- For methods 1 and 2, a web redirect URI registered on the blueprint.
- For method 3, a Microsoft Graph management client with `AppRoleAssignment.ReadWrite.All` and `Application.Read.All`. For delegated access, the signed-in administrator also needs **Privileged Role Administrator** to assign Microsoft Graph app roles. See the [app role assignment API permissions](/graph/api/serviceprincipal-post-approleassignments#permissions).

## Method 1: Request administrator consent with an authorization request

Direct an administrator to the authorization endpoint. Use the agent identity client ID as the OAuth client. For single-instance agents, it is shared with the blueprint; for fleets, use the selected agent's client ID, not the blueprint's. Use the `role` parameter to specify each required permission. The consent-only request uses `response_type=none`, so it records consent without returning a token.

```text
https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/authorize
?client_id=<agent-identity-client-id>
&response_type=none
&redirect_uri=<registered-redirect-uri>
&response_mode=query
&role=User.Read.All
&role=Mail.Read
&state=<opaque-state-value>
```

The administrator signs in and approves the permissions for the organization. Validate `state` when the browser returns to the redirect URI to prevent request forgery.

## Method 2: Request administrator consent with the admin consent endpoint

Direct an administrator to the admin consent endpoint. Use the `role` parameter to specify each required permission:

```text
https://login.microsoftonline.com/<tenant-id>/v2.0/adminconsent
?client_id=<agent-identity-client-id>
&role=User.Read.All
&redirect_uri=<registered-redirect-uri>
&state=<opaque-state-value>
```

To request multiple permissions in a single request, repeat the `role` parameter:

```text
https://login.microsoftonline.com/<tenant-id>/v2.0/adminconsent
?client_id=<agent-identity-client-id>
&role=User.Read.All
&role=Mail.Read
&redirect_uri=<registered-redirect-uri>
&state=<opaque-state-value>
```

| Parameter | Description |
| --- | --- |
| `client_id` | Client ID of the agent identity. For single-instance agents, this is shared with the blueprint. For fleets, don't use the blueprint client ID. |
| `role` | Permission name to grant, such as `User.Read.All`. Repeat for each permission. |
| `redirect_uri` | A registered redirect URI on the blueprint app registration. |
| `state` | Opaque value validated on return to prevent request forgery. |

After the administrator authenticates and approves, Microsoft Entra redirects to the redirect URI. Validate `state` before processing the response.

## Method 3: Assign application permissions with Microsoft Graph

Create an app role assignment directly on the agent identity's service principal:

Use the management client's access token, not the agent's runtime credential. Don't grant these directory-management permissions to the agent just to let it call a downstream API.

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals/<agent-identity-id>/appRoleAssignments
Content-Type: application/json
Authorization: Bearer <admin-token>

{
  "principalId": "<agent-identity-id>",
  "resourceId": "<microsoft-graph-service-principal-object-id>",
  "appRoleId": "<app-role-id>"
}
```

| Property | Description |
| --- | --- |
| `principalId` | ID of the agent identity. |
| `resourceId` | Object ID of the Microsoft Graph service principal in your tenant. |
| `appRoleId` | GUID of the specific application permission to grant. |

Grant one permission per request.

**Find the Microsoft Graph service principal object ID:**

```http
GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=appId eq '00000003-0000-0000-c000-000000000000'&$select=id,displayName
```

**Find the app role ID for a specific permission:**

```http
GET https://graph.microsoft.com/v1.0/servicePrincipals?$filter=appId eq '00000003-0000-0000-c000-000000000000'&$select=appRoles
```

In the response, find the entry in `appRoles` where `value` matches the permission name, such as `User.Read.All`. Use its `id` as `appRoleId`.

## Verify the assignment

After granting permissions, verify that each app role assignment was created:

```http
GET https://graph.microsoft.com/v1.0/servicePrincipals/<agent-identity-id>/appRoleAssignments
```

Each entry in the response represents one granted application permission. The agent identity can request tokens with `https://graph.microsoft.com/.default` to receive the granted roles in the token's `roles` claim.

## Related content

- [Grant delegated permissions to an agent identity](grant-agent-access-microsoft-365.md)
- [Call Microsoft Graph as an agent with ASP.NET Core](call-api-microsoft-graph.md)
- [Call Microsoft Graph as an agent with the Auth SDK sidecar](sidecar-call-graph-as-agent.md)
- [Microsoft Graph permissions reference](/graph/permissions-reference)

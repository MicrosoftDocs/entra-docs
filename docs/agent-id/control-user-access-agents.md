---
title: Control access to agents with app roles
description: Use app roles to control which users, groups, and applications can access an agent.
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: ergreenl
#Customer intent: As an administrator, I want to use app roles to control which users, groups, and applications can access an agent.
---

# Control access to agents with app roles

App roles define who can access an agent and what they can do. Use them to restrict agent operations to approved users, groups, or client applications.

In this article, you define an inbound access role, assign it to a caller, and enforce it in the agent API. Where you define the role depends on whether the agent uses a single-instance blueprint or a fleet.

## Prerequisites

- A blueprint and its agent API service principal.
- An authorized Microsoft Graph management client for role configuration. For delegated single-instance management, the signed-in user must own the agent identity or have the **Agent ID Administrator** role. See [Update servicePrincipal](/graph/api/serviceprincipal-update?view=graph-rest-beta&preserve-view=true) for the applicable API permissions.
- **Application Administrator** or **Cloud Application Administrator** to manage user and group app role assignments.
- `AppRoleAssignment.ReadWrite.All` and the appropriate read permission for programmatic assignments.

For the single-instance cloud journey, the API's service principal is the **agent identity**, not a blueprint principal. Use its object ID as `<agent-api-service-principal-object-id>` in the requests in this article. A single-instance blueprint has no blueprint principal. For the advanced fleet journey, use the fleet's **blueprint principal** instead; its assignments apply across the fleet.

## Define app roles

Choose the definition location for your instance mode:

| Instance mode | Define the inbound role on | Assign the role on |
| --- | --- | --- |
| Single-instance | The blueprint application and the Agent ID service principal, using the same role GUID and value. | The Agent ID service principal. |
| Fleet | The blueprint application. | The blueprint principal that represents the fleet API. |

Use one role when everyone has the same access level. For example, use `Agent.User` for standard tasks and add `Agent.Admin` only if you expose administrative tasks. Keep role values stable because your authorization policies check them.

### Declare the role on the blueprint

Define `Agent.User` in the blueprint application's `appRoles` collection. For a single-instance agent, also complete the next section to make the same role available on its Agent ID.

Read the blueprint's existing `appRoles` first. The following request is for a blueprint with no existing roles. For an existing collection, include the existing role definitions you intend to retain; updating `appRoles` replaces the collection. Omit the read-only `origin` field from requests.

Replace `<agent-user-role-id>` with a new GUID and save it for the assignment step:

```http
PATCH https://graph.microsoft.com/beta/applications/<blueprint-object-id>
Content-Type: application/json
Authorization: Bearer <management-access-token>

{
  "@odata.type": "#microsoft.graph.agentIdentityBlueprint",
  "appRoles": [
    {
      "id": "<agent-user-role-id>",
      "allowedMemberTypes": ["User"],
      "description": "Use standard agent features",
      "displayName": "Agent user",
      "isEnabled": true,
      "value": "Agent.User"
    }
  ]
}
```

### Single-instance user access

For a single-instance agent, publish the same user role directly in the Agent ID's `appRoles` collection. Use the **same GUID and value** as the blueprint declaration, not a second role GUID. The blueprint-only declaration doesn't make the role available for assignment on the Agent ID. The service-principal-only definition doesn't complete the blueprint configuration used in this procedure.

Read the Agent ID's existing roles first and retain their definitions in the update. For an Agent ID with no existing roles, send:

```http
PATCH https://graph.microsoft.com/beta/servicePrincipals/<agent-api-service-principal-object-id>
Content-Type: application/json
Authorization: Bearer <management-access-token>

{
  "appRoles": [
    {
      "id": "<agent-user-role-id>",
      "allowedMemberTypes": ["User"],
      "description": "Use standard agent features",
      "displayName": "Agent user",
      "isEnabled": true,
      "value": "Agent.User"
    }
  ]
}
```

This is role configuration on two separate objects, not permission inheritance or a downstream API grant. Don't create a blueprint principal for a single-instance agent.

The service-principal definition supports `User` for users and groups. Don't add `Application` to this request: roles assignable to client applications must be defined on an application object. This single-instance procedure covers inbound user access, not application-only callers. See the [appRole resource reference](/graph/api/resources/approle).

### Fleet access

For a fleet, use the blueprint declaration without the single-instance service-principal update. Include `User` in `allowedMemberTypes` for users or groups and `Application` for client applications. For the application-level procedure, see [Add app roles to an application](~/identity-platform/howto-add-app-roles-in-apps.md). Use the blueprint principal, not a child Agent ID, as the resource for inbound assignments.

## Verify the role on the resource principal

Before requiring or assigning a role, read back the blueprint with `GET https://graph.microsoft.com/beta/applications/<blueprint-object-id>?$select=appRoles` and the agent API principal with `GET https://graph.microsoft.com/v1.0/servicePrincipals/<agent-api-service-principal-object-id>?$select=appRoles`. Use an authorized management client, not the agent's runtime token.

Confirm that the principal's `appRoles` contains the role's exact `id` and `value`, that `isEnabled` is `true`, and that `allowedMemberTypes` includes the intended assignee type.

If an assignment returns `Permission being assigned was not found on application`, check the role definition on the resource principal and the assignment's `resourceId` and `appRoleId`. For a single-instance agent, complete the direct definition above if you defined the role only on the blueprint. Don't create a blueprint principal, substitute another resource, or remove the API's role check. Continue only after the intended principal exposes the role.

## Require an app role assignment

Set `appRoleAssignmentRequired` on the agent API service principal. When the property is `true`, Microsoft Entra ID issues an access token for the agent API only to assigned users and applications.

```http
PATCH https://graph.microsoft.com/v1.0/servicePrincipals/<agent-api-service-principal-object-id>
Content-Type: application/json
Authorization: Bearer <access-token>

{
  "appRoleAssignmentRequired": true
}
```

For more information, see the [Microsoft Graph update API reference](/graph/api/serviceprincipal-update).

## Assign an app role

Assign the app role to a user on the agent API service principal:

```http
POST https://graph.microsoft.com/v1.0/users/<user-object-id>/appRoleAssignments
Content-Type: application/json
Authorization: Bearer <access-token>

{
  "principalId": "<user-object-id>",
  "resourceId": "<agent-api-service-principal-object-id>",
  "appRoleId": "<app-role-id>"
}
```

Use the GUID saved when you defined `Agent.User` as `<app-role-id>`. For a group, create the assignment through the group's app role assignments. For a fleet role that allows `Application`, create a client application's assignment through that client's service principal. In every case, use the agent API service principal's object ID as `resourceId`.

## Enforce app roles in the agent API

When an assigned user or application gets an access token for the agent API, Microsoft Entra ID includes the assigned app role values in the token's `roles` claim. The agent API checks that claim before it allows the requested operation.

After [configuring authentication and token validation](aspnet-core-authenticate-users.md), add an authorization policy that requires the app role:

In `Program.cs`, merge the policy registration into `builder.Services.AddAuthorization` before `builder.Build()`. Place the endpoint mapping after the authentication and authorization middleware and before `app.Run()`; the two parts of this fragment aren't adjacent in a complete application.

```csharp
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy(
        "AgentUser",
        policy => policy.RequireRole("Agent.User"));
});

app.MapPost("/tasks", () => Results.Accepted())
    .RequireAuthorization("AgentUser");
```

`AddAuthorization` registers the ASP.NET Core authorization services. `RequireRole` checks the authenticated identity for the `Agent.User` role. Microsoft.Identity.Web recognizes Microsoft Entra app roles in the access token's `roles` claim.

Call `UseAuthentication` before `UseAuthorization` in the middleware pipeline, as shown in the authentication article. Request a new access token after changing an assignment. When troubleshooting, verify the assignment on the agent API service principal and the token's `roles` claim.

With a new token for the agent API and the assigned `Agent.User` role, the sample `POST /tasks` returns `202 Accepted`. Without a token, expect `401`; an otherwise valid token without that role is rejected with `403` if the tenant issues it. When assignment is required, Microsoft Entra ID might reject sign-in or token issuance before the request reaches your API.

## Related content

- [Authenticate users to an ASP.NET Core agent API](aspnet-core-authenticate-users.md)
- [Add app roles to an application](/entra/identity-platform/howto-add-app-roles-in-apps)
- [Role-based authorization in ASP.NET Core](/aspnet/core/security/authorization/roles)

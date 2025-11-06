---
title: Grant Agents Access to Microsoft 365 Resources
description: Learn how to grant access to agents through consent, manual authorization, and other authorization systems for Microsoft 365 resources.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.author: jomondi
ms.reviewer: ergreenl

#Customer intent: As an IT administrator managing agent identities, I want to understand how to grant agents access to Microsoft 365 resources through various authorization methods, so that I can properly configure consent, manual authorization, and other authorization systems for agents in my organization.
---

# Grant agents access to Microsoft 365 Resources

This article provides guidance on how to grant access to agents through consent, manual authorization, and other authorization systems. Learn about the different methods available for authorizing agents to access Microsoft 365 resources and when to use each approach.

## Prerequisites

- An agent identity blueprint and at least one agent identity created from it.
- An agent identity blueprint with a valid redirect URI.
- A tenant and appropriate admin permissions to grant tenant-wide consent when needed.

## How to request consent (delegated or application permissions)

This section explains how to request consent for delegated and application permissions for your agents.

### When to use delegated or application permissions

The type of permissions you request depends on how your agent operates and what resources it needs to access.

Use delegated permissions when your interactive agent needs to act on behalf of a signed-in user (for example, read that user's mail, calendar, or files). Delegated access is carried in the token's scp claim.

Use application permissions when your autonomous agent runs without a user present and requires app-only access (for example, to read all users' profiles). App permissions appear in the token's roles claim.

### How consent works

When you redirect the user to the Microsoft identity platform /authorize endpoint, they review scopes (for example, User.Read, Mail.Read). If consent is granted, Microsoft Entra records an OAuth2PermissionGrant from your agent (client) to the resource app (for example, Microsoft Graph). Future delegated tokens for that resource include the approved scopes in scp without reprompting (unless consent changes).

### Building the consent URL

The following example shows how to request consent-only (with no token exchange).

```http
https://login.microsoftonline.com/<tenant>/oauth2/v2.0/authorize?
  client_id=<agent-identity-id>
  &response_type=none
  &redirect_uri=https%3A%2F%2Fmyagentapp.com%2Fauthorize
  &response_mode=query
  &scope=User.Read
  &state=xyz123
```

### Application permissions

```http
https://login.microsoftonline.com/<tenant>/v2.0/adminconsent
  ?client_id=<agent-identity-id>
  &role=User.Read.All
  &redirect_uri=https://entra.microsoft.com/TokenAuthorize
  &state=xyz123
```

## How to manually grant authorization (delegated or application)

You can create the underlying authorization objects directly. It's useful for situations where you want to automate authorization or when you want to avoid interactive prompts.

### Manually grant delegated permissions

The following example shows how to manually grant delegated permissions.

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals/<agent-identity-sp-id>/oauth2PermissionGrants
Authorization: Bearer <token>
Content-Type: application/json

{
  "clientId": "<agent-identity-id>",
  "resourceId": "<resource-sp-object-id>",
  "scope": "User.Read"
}
```

### Manually grant application permissions (app role assignment)

The following example uses the Grant an appRoleAssignment to a service principal API to create an appRoleAssignment from the agent's service principal to the resource's service principal for a specific role.

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals/<agent-identity-id>/appRoleAssignments
Authorization: Bearer <token with Application.Read.All and AppRoleAssignment.ReadWrite.All>
Content-Type: application/json

{
  "principalId": "<agent-identity-id>",
  "resourceId": "<resource-sp-object-id>",
  "appRoleId": "<app-role-id>"
}
```

## Other authorization systems

Agents can be authorized in several ways beyond app-role assignments and OAuth2 permission grants. These alternative systems offer flexibility for assigning access tailored to different platforms, services, and security requirements. The following sections summarize some of the many methods for agent authorization.

### Azure role-based access control (Azure RBAC)

Assign Azure roles to the agent identity at the narrowest scope (resource, resource group, subscription). For example, you can grant the Key Vault Reader role on a single vault so the agent can read secrets without needing broad directory or tenant permissions.

### Microsoft Entra roles

Some low-privilege directory roles might be assignable to agents for metadata or read scenarios. High-privilege roles are blocked for agents by platform policy. To learn more about Microsoft Entra roles and PIM, see Microsoft Entra roles documentation and Privileged Identity Management overview.

### Exchange RBAC

Exchange RBAC (Role-Based Access Control) lets administrators delegate permissions to Exchange resources. It ensures agents can get granular authorization, such as autonomous access to one mailbox or a few mailboxes. For step-by-step guides, refer to Microsoft's documentation on Exchange RBAC overview and How RBAC works in Exchange.

### Teams Resource-Specific Consent (RSC)

Teams Resource-Specific Consent (RSC) enables granular permission assignments for agents within Microsoft Teams. RSC allows you to grant permissions to an app or agent on a per-team basis, rather than at the tenant level. This approach is especially useful when you want to limit access to only the resources and data within specific teams. Such data includes channels, messages, or roster information, without granting broader organizational permissions.

### Custom (third‑party) APIs

Agents can call other OAuth‑protected APIs. Ensure the resource application and its service principal exist in the tenant, define required scopes/app roles, and follow the same delegated or app‑permission flows. For more information, see Microsoft's guide to permissions and consent in the Microsoft identity platform.

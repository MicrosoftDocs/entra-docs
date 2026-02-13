---
title: Control user access to agents
description: Learn how to control user and agent access to applications using app roles and the assignmentRequired property for secure access management.
author: omondiatieno
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.author: jomondi
ms.reviewer: ergreenl

#Customer intent: As an IT administrator managing agent identities, I want to control user and agent access to applications using app roles and assignment requirements, so that I can enforce least privilege access and prevent unauthorized usage of agents.
---

# Control user access to agents

This article describes how to control user and agent access to applications using app roles and the `assignmentRequired` property. It covers defining app roles, enforcing explicit role assignments, assigning roles using Microsoft Graph or the Microsoft Entra admin center, and best practices for secure access management.

## Prerequisites

- An existing agent identity blueprint already created and configured
- Agent ID Administrator role for managing agent identities and assignments
- Application Administrator or Cloud Application Administrator role for managing app roles and assignmentRequired properties
- *AppRoleAssignment.ReadWrite.All* permission for Microsoft Graph API operations if using programmatic approach.

## What are app roles?

App roles define logical permissions or access levels for an application. They're declared in the agent identity blueprint and can be assigned to users, groups, service principals, or agent identities. The following section shows an example app role definition:

```json
{
  "id": "b1a2c3d4-e5f6-7890-abcd-ef1234567890",
  "allowedMemberTypes": ["User", "Application"],
  "description": "Grants ability to invoke agent actions",
  "displayName": "AgentInvoker",
  "isEnabled": true,
  "value": "AgentInvoker"
}
```

- `allowedMemberTypes` controls who can be assigned (users, apps, or both).
- `value` is the string that appears in the token's roles claim when assigned.

If an agent identity blueprint exposes no app-roles, the default app-role `<guid of all zeros>` can be used to assign principals to the agent identity.

When designing app roles for your agent applications, define granular roles that separate duties and responsibilities. For example, create specific roles like "AgentInvoker" for users who can call agent actions and "AgentAdmin" for users who can manage agent configurations. This approach provides better security control and makes it easier to audit access patterns.

## What is assignmentRequired?

The assignmentRequired property on an application or agent identity determines whether role assignment is mandatory for access.

- `assignmentRequired = true` → Only principals explicitly assigned an app role can sign in or call the agent identity.
- `assignmentRequired = false` → Any authenticated principal can access the agent identity (subject to other conditions).

## Why use assignmentRequired?

Here are reasons why you might use the assignmentRequired property:

- Enforces least privilege by requiring explicit assignment.
- Prevents accidental access by users or agents who weren't intended to use the agent.

Enable `assignmentRequired` for sensitive agent applications to enforce explicit role assignment and ensure only authorized principals can access critical agent functionality. If users can access an application without explicit assignment, it indicates that `assignmentRequired` is set to `false`. Change this setting to true and assign roles explicitly to maintain security controls.

## Configure assignmentRequired

The following example uses the Update application API to set the `assignmentRequired` property.

```http
PATCH https://graph.microsoft.com/v1.0/applications/<agent-app-id>
Content-Type: application/json
Authorization: Bearer <token>

{
  "appRoleAssignmentRequired": true
}
```

The `assignmentRequired` property ensures that only principals explicitly assigned an app role can access the agent application, enforcing least privilege and preventing accidental access.

## Assign app roles to control access

App roles are granted through app role assignments. They link a principal (user, group, or agent identity) to a specific app role on the target agent identity. If an agent identity fails to access an application after configuration, verify that an `appRoleAssignment` is created for the agent identity using the APIs shown in the following example.

### Assign an app role to a user

The following example uses the Grant an `appRoleAssignment` to a user API to assign an app role to a user.

```http
POST https://graph.microsoft.com/v1.0/users/<user-id>/appRoleAssignments
Authorization: Bearer <token with AppRoleAssignment.ReadWrite.All>
Content-Type: application/json

{
  "principalId": "<user-id>",
  "resourceId": "<agent-identity-blueprint-principal-id>",
  "appRoleId": "<app-role-id>"
}
```

### Assign an app role to an agent identity

The following example uses the Grant an `appRoleAssignment` to a service principal API to assign an app role to an agent identity.

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals/<agent-identity-id>/appRoleAssignments
Authorization: Bearer <token with AppRoleAssignment.ReadWrite.All>
Content-Type: application/json

{
  "principalId": "<agent-identity-id>",
  "resourceId": "<agent-identity-blueprint-principal-id>",
  "appRoleId": "<app-role-id>"
}
```

## Verify role assignment

To verify your role assignment, be sure to take the following actions:

- List `appRoleAssignments` for the user or agent identity.
- Check the roles claim in the token after sign-in.

If roles claims are missing from tokens, verify that the assignment exists with the correct appRoleId, then request a new token. Regularly audit these assignments using Microsoft Graph or the Microsoft Entra admin center to ensure they remain appropriate and remove any unnecessary access.

## Related content

- [Application manifest reference](../../identity-platform/reference-app-manifest.md)
- [Microsoft Entra roles and permissions for agent identities](authorization-agent-id.md#microsoft-entra-roles-allowed-for-agents)
- [conditional access for enhanced security controls](../../identity/conditional-access/overview.md)

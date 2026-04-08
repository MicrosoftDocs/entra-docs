---
title: Configure inheritable permissions for agent identity blueprints
description: Learn how to configure inheritable permissions for agent identity blueprints to automatically grant OAuth 2.0 delegated permission scopes and application roles to agent identities.
author: omondiatieno
ms.topic: how-to
ms.date: 11/04/2025
ms.author: jomondi
ms.reviewer: ergreenl

#Customer intent: As an IT administrator managing agent identity blueprints, I want to configure inheritable permissions so that newly created agent identities can automatically inherit OAuth 2.0 delegated permission scopes and application roles without requiring interactive consent prompts.
---

# Request permissions for agent identity blueprints

Inheritable permissions let agent identities automatically inherit delegated permission (scopes) and app-only permissions (approles) from their parent agent identity blueprint. Use inheritable permissions to preauthorize a base set of scopes and roles so that newly created agent identities can take action without interactive user or admin consent prompts.

## Prerequisites

- An existing agent identity blueprint already created and configured
- Agent ID Developer role for managing agent identity blueprints owned byt the user
- Agent ID Administrator role for managing agent identity blueprints

## How inheritable permissions work

You configure inheritable permissions for one or more resources on the agent identity blueprint, specifying which delegated scopes and application roles should be inherited by the blueprint's child agent identities. 

Inheritable permissions are configured only on the agent identity blueprint. You will not see the inheritable permissions as permissions on the blueprint's child agent IDs in the UI nor when calling Microsoft Graph. During token issuance for an agent identity, the platform merges any eligible inherited scopes and roles with the individual agent ID's granted scopes and roles. The inherited scopes appear in the agent's delegated permission access token (has the idtyp claim as "user") **scp** claim. Inherited application roles appear in the agent's app-only permission token (has the idtyp claim as "app") in the token's **roles** claim.

To be eligible for inheritance, the agent identity blueprint service principal must already be granted the permission, hold OAuth2PermissionGrants for those scopes or appRoleAssignments for those roles, to the target resource app. If inherited scopes or roles don't appear in tokens, verify that the agent identity blueprint principal (service principal) is granted the necessary delegated scopes and app role assignments for the resource application before retrying token acquisition.

## Inheritance patterns

The following inheritance patterns are supported per resource app for both scopes and roles:

| Inheritance | Kind | Description |
|-------------|------|-------------|
| All Allowed | `allAllowed` | Inherit all available delegated scopes or application roles for the specified resource app. Newly granted scopes or roles on the agent identity blueprint principal are automatically included. |
| None | `none` | Inherit no scopes or roles for the specified resource app. Use this to explicitly disable inheritance for scopes (`noScopes`) or roles (`noRoles`) independently. |

You can configure scopes and roles independently on the same resource. For example, you can inherit all scopes while inheriting no roles, or vice versa.

## Inheritable permissions limitations

- Maximum of 10 resource apps per agent identity blueprint (for example, up to 10 entries in the *inheritablePermissions* collection). If you exceed this limit, reduce the number of resource apps to stay within the supported boundary.
- The [blocklist of high-privilege scopes](https://learn.microsoft.com/en-us/graph/api/resources/agentid-platform-overview?#microsoft-graph-permissions-blocked-for-agents) is enforced. Some sensitive scopes aren't inheritable due to platform policy for agent identities. It aligns with the broader restriction on granting high-privilege Microsoft Graph scopes to agents. If you encounter policy errors when configuring inheritance, remove the blocked scopes from your configuration.

Regularly review and monitor your inheritable permissions configuration. Reevaluate inherited scopes and roles to ensure they remain appropriate for your use case. Audit which inherited scopes and roles are being used by agents and remove any unused permissions from both the agent identity blueprint principal and the inheritable permissions list to maintain security hygiene.

## Configure inheritable permissions (using Microsoft Graph)

To configure inheritable permissions, use the inheritablePermissions navigation property on the `agentIdentityBlueprint` application resource. Each entry specifies the scopes and roles inheritance configuration for a single resource app. Document your configuration decisions by tracking why each scope or role is inheritable and who approved it for audit purposes.

When specifying the `resourceAppId` in your requests, ensure you provide a valid GUID format. Invalid GUIDs result in 400 Bad Request errors.

### Add all scopes and roles inheritance for Microsoft Graph

**Request**

```http
POST https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions
Content-Type: application/json
OData-Version: 4.0

{
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "#microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "#microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

### Add all scopes and roles inheritance for multiple resources

You can configure inheritable permissions for multiple resource apps on the same blueprint. Each resource requires a separate POST request. The following example adds inheritance for both Microsoft Graph and SharePoint Online.

**Request (Microsoft Graph)**

```http
POST https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions
Content-Type: application/json
OData-Version: 4.0

{
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "#microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "#microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

**Request (SharePoint Online)**

```http
POST https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions
Content-Type: application/json
OData-Version: 4.0

{
  "resourceAppId": "00000003-0000-0ff1-ce00-000000000000",
  "inheritableScopes": {
    "@odata.type": "#microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "#microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0ff1-ce00-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

### Add scopes inheritance only (no roles)

To inherit delegated scopes but not application roles, set `inheritableRoles` to `noRoles`.

**Request**

```http
POST https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions
Content-Type: application/json
OData-Version: 4.0

{
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "#microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "#microsoft.graph.noRoles",
    "kind": "none"
  }
}
```

**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "microsoft.graph.noRoles",
    "kind": "none"
  }
}
```

### Add roles inheritance only (no scopes)

To inherit application roles but not delegated scopes, set `inheritableScopes` to `noScopes`.

**Request**

```http
POST https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions
Content-Type: application/json
OData-Version: 4.0

{
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "#microsoft.graph.noScopes",
    "kind": "none"
  },
  "inheritableRoles": {
    "@odata.type": "#microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.noScopes",
    "kind": "none"
  },
  "inheritableRoles": {
    "@odata.type": "microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

### Update to disable roles inheritance

If an entry already exists for a resourceAppId, use PATCH to update it rather than attempting to create a duplicate entry, which would result in a 409 Conflict error. The following example disables role inheritance while keeping scope inheritance enabled.

**Request**

```http
PATCH https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions/00000003-0000-0000-c000-000000000000
Content-Type: application/json
OData-Version: 4.0

{
  "inheritableRoles": {
    "@odata.type": "#microsoft.graph.noRoles",
    "kind": "none"
  }
}
```

**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  },
  "inheritableRoles": {
    "@odata.type": "microsoft.graph.noRoles",
    "kind": "none"
  }
}
```

### Update to disable scopes inheritance

The following example disables scope inheritance while keeping role inheritance enabled.

**Request**

```http
PATCH https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions/00000003-0000-0000-c000-000000000000
Content-Type: application/json
OData-Version: 4.0

{
  "inheritableScopes": {
    "@odata.type": "#microsoft.graph.noScopes",
    "kind": "none"
  }
}
```

**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0000-c000-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.noScopes",
    "kind": "none"
  },
  "inheritableRoles": {
    "@odata.type": "microsoft.graph.allAllowedRoles",
    "kind": "allAllowed"
  }
}
```

### Delete existing inheritable permissions

**Request**

```http
DELETE https://graph.microsoft.com/v1.0/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions/00000003-0000-0000-c000-000000000000
OData-Version: 4.0
```

**Response**

```http
HTTP/1.1 204 No Content
```

## Related content

- [Create an agent identity from your blueprint](identity-platform/create-delete-agent-identities.md)
- [Microsoft Entra roles and permissions for agent identities](authorization-agent-id.md#microsoft-entra-roles-allowed-for-agents)
- [OAuth 2.0 and OpenID Connect protocols on the Microsoft identity platform](../identity-platform/v2-protocols.md)

---
title: Configure inheritable permissions for agent identity blueprints
description: Learn how to configure inheritable permissions for agent identity blueprints to automatically grant OAuth 2.0 delegated permission scopes to agent identities.
author: omondiatieno
ms.topic: how-to
ms.custom: msecd-doc-authoring-1012
ms.date: 04/28/2026
ms.author: jomondi
ms.reviewer: ergreenl

#Customer intent: As an IT administrator managing agent identity blueprints, I want to configure inheritable permissions so that newly created agent identities can automatically inherit OAuth 2.0 delegated permission scopes without requiring interactive consent prompts.
---

# Request permissions for agent identity blueprints

Configure inheritable permissions on an agent identity blueprint to preauthorize a base set of delegated scopes and application roles. Agent identities created from the blueprint automatically inherit those permissions without interactive consent prompts.

For conceptual background on how inheritable permissions relate to required resource access and direct permission grants, see [Inheritable permissions and required resource access](concept-inheritable-permissions.md).

## Prerequisites

- An existing agent identity blueprint already created and configured
- [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) role for managing agent identity blueprints
- [Application Administrator](../identity/role-based-access-control/permissions-reference.md#application-administrator) or [Cloud Application Administrator](../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) role for managing OAuth2PermissionGrants

## How inheritable permissions work

During token issuance for an agent identity, the platform merges eligible inherited scopes with the agent's requested delegated scopes. Inherited scopes appear in the access token's **scp** claim and inherited roles appear in the **roles** claim. For details on inheritance conditions and the relationship between declarations, grants, and effective permissions, see [Inheritable permissions and required resource access](concept-inheritable-permissions.md).

> [!TIP]
> If inherited scopes don't appear in tokens, verify that the agent identity blueprint principal (service principal) has OAuth2PermissionGrants for those scopes to the target resource app before retrying token acquisition.

## Inheritance patterns

The concept article describes inheritance patterns at a high level. The following table shows the specific `kind` values used in the API when you configure inheritance per resource app:

| Inheritance | Kind | Description |
|-------------|------|-------------|
| All Scopes Inheritance | `allAllowed` | Inherit all available delegated scopes for the specified resource app. Newly granted scopes on the agent identity blueprint principal are automatically included. |
| Enumerated Scopes Inheritance | `enumerated` | Inherit only the explicitly listed scopes. Use it for fine-grained control and gradual expansion. |

> [!TIP]
> Start with the enumerated pattern using only essential scopes, then expand as needed. This approach provides better security control and makes it easier to track which permissions your agents use.

## Inheritable permissions limitations

- Maximum of 10 resource apps per agent identity blueprint (for example, up to 10 entries in the *inheritablePermissions* collection). If you exceed these limits, reduce the number of resource apps or enumerated scopes to stay within the supported boundaries.
- For kind: *enumerated*, maximum of 40 scopes per resource app.
- The blocklist of high-privilege scopes is enforced. Some sensitive scopes aren't inheritable due to platform policy for agent identities. It aligns with the broader restriction on granting high-privilege Microsoft Graph scopes to agents. If you encounter policy errors when configuring inheritance, remove the blocked scopes from your configuration.

Regularly review and monitor your inheritable permissions configuration. Reevaluate inherited scopes to ensure they remain appropriate for your use case. Audit, which inherited scopes are being used by agents and remove any unused scopes from both the agent identity blueprint principal and the inheritable permissions list to maintain security hygiene.

## Configure inheritable permissions (Microsoft Graph beta)

To configure inheritable permissions, use the inheritablePermissions navigation property on the `agentIdentityBlueprint` application resource. Document your configuration decisions by tracking why each scope is inheritable and who approved it for audit purposes.

When specifying the `resourceAppId` in your requests, ensure you provide a valid GUID format. Invalid GUIDs result in 400 Bad Request errors.

### Add enumerated scopes inheritance

**Request**

```http
POST https://graph.microsoft.com/beta/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions
Content-Type: application/json
OData-Version: 4.0

{
  "resourceAppId": "00000003-0000-0ff1-ce00-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.enumeratedScopes",
    "scopes": [
      "User.Read",
      "Mail.Read"
    ]
  }
}
```

**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0ff1-ce00-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.enumeratedScopes",
    "kind": "enumerated",
    "scopes": [
      "User.Read",
      "Mail.Read"
    ]
  }
}
```

### Add all scopes inheritance

**Request**

```http
POST https://graph.microsoft.com/beta/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions/00000003-0000-0ff1-ce00-000000000000
Content-Type: application/json
OData-Version: 4.0

{
  "resourceAppId": "00000003-0000-0ff1-ce00-000000000000",
  "inheritableScopes": {
    "@odata.type": "#microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  }
}
```

**Response**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0ff1-ce00-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.allAllowedScopes",
    "kind": "allAllowed"
  }
}
```

### Update existing inheritable permissions

If an entry already exists for a resourceAppId, use PATCH to update it rather than attempting to create a duplicate entry, which would result in a 409 Conflict error.

**Request**

```http
PATCH https://graph.microsoft.com/beta/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions/00000003-0000-0ff1-ce00-000000000000
Content-Type: application/json
OData-Version: 4.0

{
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.enumeratedScopes",
    "scopes": [
      "User.Read",
      "Mail.Read",
      "User.ReadBasic.All"
    ]
  }
}
```

**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#applications('bc057821-f236-49d6-9f2c-1ebf43e9437a')/inheritablePermissions/$entity",
  "resourceAppId": "00000003-0000-0ff1-ce00-000000000000",
  "inheritableScopes": {
    "@odata.type": "microsoft.graph.enumeratedScopes",
    "kind": "enumerated",
    "scopes": [
      "User.Read",
      "Mail.Read",
      "User.ReadBasic.All"
    ]
  }
}
```

### Delete existing inheritable permissions

**Request**

```http
DELETE https://graph.microsoft.com/beta/applications/microsoft.graph.agentIdentityBlueprint/bc057821-f236-49d6-9f2c-1ebf43e9437a/inheritablePermissions/00000003-0000-0ff1-ce00-000000000000
OData-Version: 4.0
```

**Response**

```http
HTTP/1.1 204 No Content
```

## Related content

- [Inheritable permissions and required resource access](concept-inheritable-permissions.md)
- [Create an agent identity from your blueprint](identity-platform/create-delete-agent-identities.md)
- [Microsoft Entra roles and permissions for agent identities](authorization-agent-id.md#microsoft-entra-roles-allowed-for-agents)
- [OAuth 2.0 and OpenID Connect protocols on the Microsoft identity platform](../identity-platform/v2-protocols.md)

---
title: Delete and restore agent identity objects
description: Learn how to delete an agent identity blueprint and restore soft-deleted agent identity objects in Microsoft Entra.
titleSuffix: Microsoft Entra Agent ID
author: shlipsey3
ms.author: sarahlipsey
ms.topic: how-to
ms.date: 04/29/2026
ms.custom: agent-id
ai-usage: ai-assisted

#Customer intent: As an IT admin or developer, I want to delete an agent identity blueprint and restore soft-deleted agent identity objects so I can manage the lifecycle of my agents.
---

# How to delete and restore agent identity objects

When you delete an agent identity blueprint, Microsoft Entra automatically cleans up all associated child agent identities and agents' user accounts. All deletions are soft deletions — deleted objects move to the recycle bin and can be restored within 30 days.

For a conceptual overview of how cascade cleanup works and quota considerations, see [Agent identity deletion works](concept-agent-identity-deletion.md).

## Prerequisites

To delete and restore agent identity objects, you need:

- [Agent ID Administrator](/entra/identity/role-based-access-control/permissions-reference#agent-id-administrator) to view and manage agent identity objects.
- [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) to delete the blueprint application and its service principal.
- The `Application.ReadWrite.All` permission for Microsoft Graph API or Microsoft Entra PowerShell operations.
- The `AgentIdentity.ReadWrite.All` permission to permanently delete soft-deleted agent identities.
- Owners of an agent identity blueprint can delete agent identity objects associated with that blueprint without these roles.

## Delete a blueprint

How you delete a blueprint depends on whether you use the Microsoft Entra admin center or the API directly.

- **Microsoft Entra admin center**: Locate the agent identity blueprint ID in Agent ID, then delete the blueprint from **Enterprise applications**, which removes both the service principal and its associated app registration.
- **Microsoft Graph API or PowerShell**: You can delete the agent identity blueprint and blueprint principal separately. Deleting the app registration also deletes the principal. Deleting only the principal leaves the app registration in place.

> [!NOTE]
> Standard deletion is always soft deletion. Objects are moved to the recycle bin, but not immediately removed. Permanent deletion happens automatically after 30 days, or you can force it using the standard hard-delete process described in [Deleting and recovering applications FAQ](../identity/enterprise-apps/delete-recover-faq.yml).

### [Microsoft Entra admin center](#tab/entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **App registrations**.
1. Find and select your agent identity blueprint application.
1. Select **Delete**, then confirm.

The blueprint principal is deleted automatically along with the app registration.

### [Microsoft Graph API](#tab/microsoft-graph-api)

To delete the blueprint application (which also deletes the principal):

```http
DELETE https://graph.microsoft.com/v1.0/applications/{blueprint-app-object-id}
```

To delete only the blueprint principal:

```http
DELETE https://graph.microsoft.com/v1.0/servicePrincipals/{blueprint-principal-object-id}
```

> [!NOTE]
> Explicit hard deletion of a blueprint principal (`permanentDelete`) is blocked. Use the standard delete endpoint shown above.

### [Microsoft Entra PowerShell](#tab/microsoft-entra-powershell)

To delete the blueprint application (which also deletes the principal):

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraApplication -ObjectId <blueprint-app-object-id>
```

To delete only the blueprint principal:

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraServicePrincipal -ObjectId <blueprint-principal-object-id>
```

---

After you delete the blueprint or its principal, Microsoft Entra automatically soft deletes all associated child agent identities and agents' user accounts. For more information on this process, see [Agent identity deletion](concept-agent-identity-deletion.md).

> [!IMPORTANT]
> If you restore the blueprint principal before the cascade cleanup runs, child agent identities aren't affected. After the cleanup runs, each child identity must be restored individually. Restoring the blueprint principal doesn't reverse cascade deletions that already occurred.

## Restore a blueprint principal

You can restore a soft-deleted blueprint principal within 30 days.

### [Microsoft Entra admin center](#tab/entra-admin-center)

Restoring a soft-deleted blueprint principal isn't currently supported in the Microsoft Entra admin center. Use the API or PowerShell to restore the principal.

### [Microsoft Graph API](#tab/microsoft-graph-api)

```http
POST https://graph.microsoft.com/v1.0/directory/deletedItems/{blueprint-principal-object-id}/restore
```

### [Microsoft Entra PowerShell](#tab/microsoft-entra-powershell)

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Restore-EntraDeletedDirectoryObject -Id <blueprint-principal-object-id>
```

---

## Restore child agent identities

If the cascade cleanup already ran and child agent identities were soft deleted, restore each one individually.

> [!NOTE]
> The Microsoft Graph `/directory/deletedItems` endpoint doesn't support filtering by agent identity type. Query for deleted service principals and filter results on the client side using known object IDs, app IDs, or display names to identify the correct agent identities.

### [Microsoft Entra admin center](#tab/entra-admin-center)

Restoring a soft-deleted agent identity isn't currently supported in the Microsoft Entra admin center. Use the API or PowerShell to restore the agent identity.

### [Microsoft Graph API](#tab/microsoft-graph-api)

1. List soft-deleted service principals to find affected agent identities:

   ```http
   GET https://graph.microsoft.com/v1.0/directory/deletedItems/microsoft.graph.servicePrincipal
   ```

1. Filter the results on the client side to identify agent identities linked to your blueprint, then restore each one:

   ```http
   POST https://graph.microsoft.com/v1.0/directory/deletedItems/{agent-identity-object-id}/restore
   ```

### [Microsoft Entra PowerShell](#tab/microsoft-entra-powershell)

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'

# List deleted service principals and identify agent identities
Get-EntraDeletedServicePrincipal

# Restore each agent identity individually
Restore-EntraDeletedDirectoryObject -Id <agent-identity-object-id>
```

---

## Permanently delete agent identity objects

Soft-deleted objects continue to count toward [directory quota](../identity/users/directory-service-limits-restrictions.md) until they're permanently deleted. If you're at the 250 agent identity limit for a blueprint using app-only permissions, you might need to force permanent deletion to free up quota immediately rather than waiting for the 30-day retention period to expire. Permanent deletion of an agent identity blueprint principal is blocked. To permanently free quota used by a blueprint principal, wait for the 30-day retention period to expire.

> [!CAUTION]
> Permanently deleted objects can't be restored. Only permanently delete objects when you're certain they're no longer needed.

### [Microsoft Entra admin center](#tab/entra-admin-center)

Permanently deleting a soft-deleted agent identity isn't currently supported in the Microsoft Entra admin center. Use the API or PowerShell to permanently delete the agent identity.

### [Microsoft Graph API](#tab/microsoft-graph-api)

Permanently delete a soft-deleted agent identity:

```http
DELETE https://graph.microsoft.com/v1.0/directory/deletedItems/{agent-identity-object-id}
```

Permanently delete a soft-deleted blueprint application:

```http
DELETE https://graph.microsoft.com/v1.0/directory/deletedItems/{blueprint-app-object-id}
```

### [Microsoft Entra PowerShell](#tab/microsoft-entra-powershell)

Permanently delete a soft-deleted agent identity:

```powershell
Connect-Entra -Scopes 'AgentIdentity.ReadWrite.All'
Remove-EntraDeletedDirectoryObject -DirectoryObjectId <agent-identity-object-id>
```

Permanently delete a soft-deleted blueprint application:

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraDeletedDirectoryObject -DirectoryObjectId <blueprint-app-object-id>
```

---

## Agents' user accounts

Agents' user accounts are paired 1:1 with agent identities. If agents' user accounts aren't automatically cleaned up as part of cascade deletion, delete them manually.

### [Microsoft Entra admin center](#tab/entra-admin-center)

Restoring a soft-deleted agent's user account isn't currently supported in the Microsoft Entra admin center. Use the API or PowerShell to restore the agent's user account.

### [Microsoft Graph API](#tab/microsoft-graph-api)

```http
DELETE https://graph.microsoft.com/v1.0/users/{agent-user-object-id}
```

### [Microsoft Entra PowerShell](#tab/microsoft-entra-powershell)

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Remove-EntraUser -UserId <agent-user-object-id>
```

---

## Related content

- [Understand agent identity deletion](concept-agent-identity-deletion.md)
- [Create and delete agent identities](create-delete-agent-identities.md)
- [Deleting and recovering applications FAQ](~/identity/enterprise-apps/delete-recover-faq.yml)

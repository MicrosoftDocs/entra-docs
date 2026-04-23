---
title: Cascade deletion for agent identity blueprint principals
description: Learn what happens when an agent identity blueprint principal is deleted, including cascade soft deletion of child agent identities and how to restore them.
titleSuffix: Microsoft Entra Agent ID
author: shlipsey3
ms.author: sarahlipsey
ms.topic: concept-article
ms.date: 04/23/2026
ms.custom: agent-id
ai-usage: ai-assisted

#Customer intent: As an IT admin or developer, I want to understand what happens when an agent identity blueprint principal is deleted so I can plan for restoration and avoid orphaned objects.
---

# Cascade deletion for agent identity blueprint principals

When you delete an agent identity blueprint principal in Microsoft Entra, the system initiates a cascade soft deletion process that affects all child agent identities created by that blueprint. This article explains the deletion behavior, timelines, and how to restore affected objects.

## How cascade deletion works

Deleting an agent identity blueprint principal triggers the following sequence:

1. **Blueprint principal is soft deleted** — The blueprint principal moves to the recycle bin immediately. You can restore it within 30 days.
1. **Grace period before child deletion** — After the blueprint principal is soft deleted, there's a delay of approximately 24 hours before the system starts deleting child identities. This delay is system-managed and timing isn't guaranteed to be exactly 24 hours.
1. **Child agent identities are soft deleted** — After the grace period, a background task soft deletes all agent identities that were created by the deleted blueprint principal. Each child identity moves to the recycle bin with its own 30-day retention window.
1. **Manual restore required for children** — Once child identities are soft deleted, you must restore each one individually. Restoring the blueprint principal after the grace period doesn't automatically restore its child identities.
1. **Permanent deletion after 30 days** — Soft-deleted objects that aren't restored within 30 days are permanently (hard) deleted and can't be recovered.

> [!IMPORTANT]
> To avoid having to manually restore each child agent identity, restore the agent identity blueprint principal before the background cleanup task runs (approximately 24 hours). After the cleanup runs, child agent identities are soft deleted and must be restored one by one.

<!-- TODO: Confirm with engineering whether the 24-hour delay is exact or approximate. The dev spec says "after 24 hours [configurable]". -->

## What happens to agents' user accounts

Agents' user accounts associated with deleted agent identities **aren't automatically deleted** as part of the cascade process. They remain in the tenant but can't authenticate. Clean up orphaned agents' user accounts manually using the Microsoft Entra admin center, Microsoft Graph APIs, or scripting tools.

## Directory quota impact

Soft-deleted objects still count fully toward your directory quota. Quota relief doesn't happen immediately when a blueprint principal is deleted because:

- The blueprint principal remains in the recycle bin for up to 30 days.
- Child agent identities aren't soft deleted until approximately 24 hours after the blueprint principal is deleted, and then they also remain in the recycle bin.
- After permanent (hard) deletion, objects become tombstones that count as one quarter of a regular object toward the directory quota.

## Prerequisites

To restore soft-deleted agent identity objects, you need:

- One of the following roles: Cloud Application Administrator, Application Administrator, or owner of the service principal.
- The `Application.ReadWrite.All` permission for Microsoft Graph API or Microsoft Entra PowerShell operations.

## Restore a deleted blueprint principal

If you restore the agent identity blueprint principal before the background cleanup task runs (approximately 24 hours), no child identities are affected.

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

## Restore child agent identities after cascade deletion

If the background cleanup task already ran and child identities were soft deleted, restore each one individually.

> [!NOTE]
> The Microsoft Graph `/directory/deletedItems` endpoint doesn't support filtering by agent identity type. You need to query for deleted service principals and filter results on the client side using known object IDs, app IDs, or display names to identify the correct agent identities.

### [Microsoft Graph API](#tab/microsoft-graph-api)

1. List soft-deleted service principals to find affected agent identities:

   ```http
   GET https://graph.microsoft.com/v1.0/directory/deletedItems/microsoft.graph.servicePrincipal
   ```

1. Filter results on the client side to identify agent identities linked to your blueprint, then restore each one:

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

## Frequently asked questions

### What happens to child agent identities when an agent identity blueprint principal is deleted?

When an agent identity blueprint principal is soft deleted, a background task soft deletes all child agent identities after approximately 24 hours. Each child identity must be restored individually from the recycle bin within 30 days. To avoid manual restoration of child identities, restore the agent identity blueprint principal before the cleanup task runs.

### Can I hard delete an agent identity blueprint principal?

No. Explicit hard deletion of an agent identity blueprint principal through the Microsoft Graph API is blocked. Blueprint principals can only be soft deleted. Permanent deletion occurs automatically after 30 days in the recycle bin.

### Does restoring a blueprint principal after cascade deletion automatically restore child identities?

No. Once child agent identities are soft deleted, they must be restored individually. Restoring the blueprint principal doesn't reverse the cascade soft deletion that already occurred.

### Are agents' user accounts affected by cascade deletion?

Agents' user accounts aren't soft deleted as part of the cascade process. They remain in the tenant but can't authenticate after their associated agent identity is deleted. Delete orphaned agents' user accounts manually.

## Related content

- [Create and delete agent identities](create-delete-agent-identities.md)
- [Restore a soft deleted enterprise application](~/identity/enterprise-apps/restore-application.md)
- [Deleting and recovering applications FAQ](~/identity/enterprise-apps/delete-recover-faq.yml)

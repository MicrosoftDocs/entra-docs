---
title: Learn how agent identity deletion works
description: Learn how deleting an agent identity blueprint triggers automatic cleanup of child agent identities in Microsoft Entra, and how to restore deleted objects.
titleSuffix: Microsoft Entra Agent ID
author: shlipsey3
ms.author: sarahlipsey
ms.topic: concept-article
ms.date: 04/27/2026
ms.custom: agent-id
ai-usage: ai-assisted

#Customer intent: As an IT admin or developer, I want to understand what happens when I delete an agent identity blueprint so I can plan for cleanup and restoration.
---

# Agent identity deletion

When you delete an agent identity blueprint or its principal, Microsoft Entra automatically cleans up all child agent identities and agents' user accounts with a *cascade cleanup* process. You don't need to manually query and delete each one. Understanding when and how this cascade cleanup happens helps you plan for restoration if needed.

Agent identity blueprints and their associated objects follow the same soft deletion and hard deletion behavior as other app registrations and service principals in Microsoft Entra. For a full overview of that process, see [Deleting and recovering applications FAQ](../identity/enterprise-apps/delete-recover-faq.yml). This article focuses on what's unique to agent identity deletion.

## Object relationships

The following objects are involved in the agent identity deletion lifecycle. The cascade cleanup process is based on these relationships.

| Object | Directory object type | Relationship |
|---|---|---|
| Agent identity blueprint | Application | Parent of the blueprint principal |
| Agent identity blueprint principal | Service principal | The principal for the blueprint |
| Agent identity | Service principal | Child of the blueprint principal |
| Agent's user account | User | Paired 1:1 with an agent identity |

## Disable versus delete

Before deleting a blueprint, consider whether disabling is the right action instead.

- **Disable**: Prevents the blueprint principal or its agent identities from authenticating, but leaves all objects in place. Use this when you want to temporarily stop agent activity, investigate an issue, or decommission agents gradually. Objects remain in the directory and count toward quota.
- **Delete**: Removes the agent identity blueprint or its agent identity blueprint principal from the directory and triggers cascade cleanup of child agent identities. Use this when you're permanently retiring a blueprint and all agents created from it. Deletion can't be undone after the 30-day soft-deletion window expires.

For information on disabling agent identities, see [Disable agent identities](disable-agent-identities.md).

## Cascade cleanup

When you delete an agent identity blueprint or its agent identity blueprint principal, Microsoft Entra automatically soft deletes all associated child agent identities and agents' user accounts. This cleanup is asynchronous.

The cascade process works as follows:

1. **You delete the agent identity blueprint or agent identity blueprint principal**: The object is soft deleted and moves to the recycle bin.
1. **Microsoft Entra triggers automatic cleanup**: A background task soft deletes all child agent identities and agents' user accounts associated with the deleted blueprint.
1. **Objects are restorable for 30 days**: Soft-deleted objects can be restored within 30 days. After that, they're permanently deleted.

> [!IMPORTANT]
> If you restore the agent identity blueprint principal before the background cleanup runs, child agent identities aren't affected. After the cleanup runs, each child identity must be restored individually. Restoring the agent identity blueprint principal doesn't reverse cascade deletions that already occurred.

## Orphaned objects and quota considerations

When an agent identity blueprint principal is permanently deleted, any associated agent identities and agents' user accounts that weren't deleted become **orphaned objects** and become soft-deleted. Orphaned objects can't authenticate but continue to count toward directory quota until they're permanently deleted after the 30-day retention period expires.

Agent identity deletion follows the same quota rules as other Microsoft Entra objects. Soft-deleted objects continue to count toward quota limits until permanently deleted. For general quota information, see [Microsoft Entra service limits and restrictions](~/identity/users/directory-service-limits-restrictions.md).

One consideration specific to agent identities: if you're using app-only permissions and are at the 250 agent identity limit for a blueprint, deleting an agent identity doesn't free up space until it's permanently deleted after the 30-day retention period expires. Agent identity blueprints also follow this 250 limit when using app-only permissions.

## Related content

- [Create and delete agent identities](create-delete-agent-identities.md)
- [Deleting and recovering applications FAQ](../identity/enterprise-apps/delete-recover-faq.yml)
- [Microsoft Entra service limits and restrictions](../identity/users/directory-service-limits-restrictions.md)

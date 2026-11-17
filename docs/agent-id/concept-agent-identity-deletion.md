---
title: Learn how agent identity deletion works
description: Learn what Microsoft Graph documents about deleting agent identity objects and which related-object behavior requires confirmation.
titleSuffix: Microsoft Entra Agent ID
ms.topic: concept-article
ms.date: 11/06/2026
ai-usage: ai-assisted

#Customer intent: As an IT admin or developer, I want to understand the documented deletion and recovery behavior for agent identity objects so I can plan cleanup without assuming undocumented cascade behavior.
---

# Agent identity deletion

Microsoft Graph documents soft deletion and recovery for agent identity and application objects. Its public delete API references don't specify whether deleting an agent identity blueprint or blueprint principal also deletes child agent identities or associated agent user accounts. Don't rely on a cascade unless Microsoft confirms the behavior for your scenario.

For general application soft-deletion behavior, see [Deleting and recovering applications FAQ](../identity/enterprise-apps/delete-recover-faq.yml). This article separates the behavior documented for individual Graph objects from related-object behavior that isn't specified in those API references.

## Object relationships

| Object | Directory object type | Documented relationship or operation |
|---|---|---|
| Agent identity blueprint | Application | Delete the application object by using the Graph application delete API. |
| Agent identity blueprint principal | Service principal | Delete the service principal by using the Graph servicePrincipal delete API. |
| Agent identity | `agentIdentity` service principal | The `agentIdentityBlueprintId` property identifies its blueprint. Delete an agent identity by using the Graph agentIdentity delete API. |
| Agent user | `agentUser`, a specialized user subtype | The [agentUser resource](/graph/api/resources/agentuser?view=graph-rest-beta&preserve-view=true) has a one-to-one relationship with a parent agent identity. The agentIdentity delete API doesn't specify what happens to the associated agent user. Check that object separately. |

## Disable versus delete

Before deleting a blueprint, consider whether disabling is the right action instead.

- **Disable**: Prevents the blueprint principal or its agent identities from authenticating, but leaves objects in place. Use this when you want to temporarily stop agent activity or investigate an issue. For more information, see [Disable agent identities](disable-agent-identities.md).
- **Delete**: Sends a delete request for the specific Graph object addressed. The [application delete API](/graph/api/application-delete) documents a 30-day recovery period for deleted applications. The [agentIdentity delete API](/graph/api/agentidentity-delete?view=graph-rest-beta&preserve-view=true) documents the same period for deleted agent identities.

## Related-object cleanup and restoration

Use the API that matches the object you intend to delete:

- Delete a blueprint application with `DELETE /applications/{applicationObjectId}`.
- Delete a blueprint principal with `DELETE /servicePrincipals/{servicePrincipalId}`.
- Delete one agent identity with `DELETE /servicePrincipals/{id}/microsoft.graph.agentIdentity`.

The public Graph API references describe deletion of the addressed object. They don't specify whether deleting a blueprint application or principal triggers cleanup of child agent identities or associated agent users. The [Graph restore API](/graph/api/directory-deleteditems-restore) specifies that restoring an application doesn't automatically restore its associated service principal; restore that principal separately. The API references don't specify cleanup timing, an internal cleanup actor, or whether restoring a parent restores or reverses changes to child objects.

Before deletion, record the object IDs you might need to recover. After the operation, check each related object independently. If an object was soft deleted, restore that object by its own ID; don't assume that restoring a blueprint or its principal restores related objects.

For restore steps, see [Delete and restore agent identity objects](howto-delete-agent-identity.md).

## Audit logs

Review the tenant's [Microsoft Entra audit logs](~/identity/monitoring-health/concept-audit-logs.md) to investigate recorded directory operations. The Graph delete API references don't specify a particular internal cleanup actor or audit sequence for related objects.

## Quota considerations

The public Graph API references document soft deletion and a 30-day recovery period for agent identities and applications. They don't specify an agent identity-specific quota, a maximum number of agent identities per blueprint, a maximum number of inheritable resource apps, or when quota becomes available after deletion. Check current Microsoft Entra service limits and confirm Agent ID-specific limits before capacity planning. Don't assume that soft deletion immediately frees quota.

For general directory limits, see [Microsoft Entra service limits and restrictions](~/identity/users/directory-service-limits-restrictions.md).

## Related content

- [Create and delete agent identities](create-delete-agent-identities.md)
- [Delete and restore agent identity objects](howto-delete-agent-identity.md)
- [Deleting and recovering applications FAQ](../identity/enterprise-apps/delete-recover-faq.yml)
- [Microsoft Entra service limits and restrictions](../identity/users/directory-service-limits-restrictions.md)

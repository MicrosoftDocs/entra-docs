---
title: Manage Object Connections - Microsoft Graph
description: Learn how to inspect and remove the stored connection between a source object and a target object for a Microsoft Entra provisioning job.
author: madipanz
ms.author: mpanzarella
ms.service: entra-id
ms.topic: how-to
ms.custom: msecd-doc-authoring-1030
ms.date: 10/16/2026
ms.reviewer: cmmdesai
ai-usage: ai-generated

#customer intent: As an application administrator, I want to inspect or remove a provisioning object connection so that the provisioning service can evaluate and match the object again.
---

# Manage provisioning object connections using Microsoft Graph (Preview)

When the Microsoft Entra provisioning service provisions an object, it stores an object connection that associates the source object with the corresponding target object. The service uses this connection during later provisioning cycles to update the correct target object.

This article is for application owners and administrators who need to inspect a connection for a known source or target object or remove an incorrect or stale connection. Before you begin, have the service principal and synchronization job IDs, a known object identifier, and the required authorization and Microsoft Graph permissions.

Removing an object connection doesn't delete the source or target object. It deletes only the provisioning service's stored association between them.

> [!NOTE]
> Managing provisioning object connections is currently in preview. We make previews available to our customers under the terms applicable to previews. These terms are outlined in the overall Microsoft product terms for [online services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

## Prerequisites

- The object ID of the application's service principal.
- The ID of the synchronization job.
- A known source or target identifier for the object connection.
- The following Microsoft Graph permissions for object-connection operations:

    | Operation | Delegated permission | Application permission |
    | --- | --- | --- |
    | Get an object connection | `SynchronizationMetadata.Read.All` | `SynchronizationMetadata.Read.OwnedBy` or `SynchronizationMetadata.Read.All` |
    | Delete an object connection | `SynchronizationMetadata.ReadWrite.All` | `SynchronizationMetadata.ReadWrite.OwnedBy` or `SynchronizationMetadata.ReadWrite.All` |

For delegated access, the signed-in user needs both the delegated Microsoft Graph permission and authorization for the provisioning scenario:

| Provisioning scenario | Signed-in user authorization |
| --- | --- |
| Standard application and HR provisioning | An owner of the application's service principal, or a user assigned Application Administrator, Cloud Application Administrator, or Hybrid Identity Administrator. |
| Cross-tenant synchronization | An owner of the application's service principal, or a user assigned Hybrid Identity Administrator. |
| Microsoft Entra Cloud Sync | A user assigned Hybrid Identity Administrator. Service-principal ownership alone isn't sufficient. |

The table lists the least-privileged supported administrator roles. A role or service-principal ownership doesn't replace the delegated permission requirement.

For application access, the `*.OwnedBy` permissions apply only when the calling application owns the service principal for the provisioning job. Use the corresponding `*.All` permission to access provisioning jobs across the organization. All four permissions require administrator consent.

### Permissions for job-management operations

The object-connection permissions don't authorize the job-management API calls used in the recovery procedure. If you use Microsoft Graph to perform those operations, also obtain the permissions for the operations that you call.

| Operation | Least-privileged delegated permission | Least-privileged application permission |
| --- | --- | --- |
| [Read job status](/graph/api/synchronization-synchronizationjob-get?view=graph-rest-beta&preserve-view=true) | `Synchronization.Read.All` | `Application.ReadWrite.OwnedBy` |
| [Pause](/graph/api/synchronization-synchronizationjob-pause?view=graph-rest-beta&preserve-view=true), [start](/graph/api/synchronization-synchronizationjob-start?view=graph-rest-beta&preserve-view=true), or [provision on demand](/graph/api/synchronization-synchronizationjob-provisionondemand?view=graph-rest-beta&preserve-view=true) | `Synchronization.ReadWrite.All` | `Application.ReadWrite.OwnedBy` |

The application permission in this table requires the calling application to own the service principal. For other supported permissions, see each operation's API reference. You don't need these additional API permissions if you perform the job-management operations in the Microsoft Entra admin center.

> [!IMPORTANT]
> The object connections API is available only in the Microsoft Graph `beta` endpoint. APIs in the `beta` endpoint are subject to change. Use of these APIs in production applications isn't supported.

## Find the required identifiers

Find the service principal, synchronization job, and object identifiers before you inspect or delete an object connection.

1. In the [Microsoft Entra admin center](https://entra.microsoft.com), browse to **Entra ID** > **Enterprise apps**.
1. Select the application.
1. Open **Provisioning**, and then select the **Overview** tab on the provisioning **Overview** page.
1. Under **Basic information**, copy **Service principal object id** and **Job ID**. Use these values for `{servicePrincipalId}` and `{jobId}` in the requests in this article. The service principal object ID isn't the application (client) ID.
1. Find the exact source or target identifier for the object that you want to inspect. See [Object connection identifiers by provisioning scenario](object-connection-identifiers.md) for the attributes and formats to use.

Provisioning logs can help you identify the source and target objects involved in an operation. For more information, see [Provisioning logs in Microsoft Entra ID](~/identity/monitoring-health/concept-provisioning-logs.md).

## Get an object connection

Get an object connection to inspect the stored association before you remove it. The synchronization job can be active, paused, or disabled.

1. Send the following request. The API first searches for the supplied identifier as a source identifier. If it doesn't find a connection, it searches for the identifier as a target identifier.

   ```http
   GET https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/objectConnections('{objectId}')
   Authorization: Bearer {token}
   ```

1. Review the `200 OK` response:

   ```http
   HTTP/1.1 200 OK
   Content-Type: application/json

   {
     "@odata.context": "https://graph.microsoft.com/beta/$metadata#objectConnection/$entity",
     "objectId": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
     "sourceAnchor": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
     "targetAnchor": "701984",
     "displayName": "Adele Vance",
     "objectTypeName": "user"
   }
   ```

   The response contains the following properties:

   | Property | Description |
   | --- | --- |
   | `objectId` | The object identifier used to retrieve the connection. |
   | `sourceAnchor` | The identifier of the object in the source system. |
   | `targetAnchor` | The identifier of the corresponding object in the target system. |
   | `displayName` | The display name stored for the object, when available. |
   | `objectTypeName` | The object type, such as `user` or `group`. |

1. If the API returns `404 Not Found`, verify the object identifier and synchronization job ID.

You must supply a known object identifier. Listing, filtering, or enumerating the object connections for a synchronization job isn't supported. A request to the collection returns `400 Bad Request`:

```http
GET https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/objectConnections
Authorization: Bearer {token}
```

## Delete an object connection

Delete an object connection when the stored association is incorrect or no longer valid. Correct the source data or matching configuration first so that a later provisioning cycle doesn't recreate the same connection.

> [!CAUTION]
> Deleting an object connection changes durable provisioning state. Use GET to verify the `sourceAnchor` and `targetAnchor` before you delete the connection.

1. Pause the synchronization job:

   ```http
   POST https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/pause
   Authorization: Bearer {token}
   Content-Length: 0
   ```

   Alternatively, in the Microsoft Entra admin center, browse to **Entra ID** > **Enterprise apps** > your application > **Provisioning**. Set **Provisioning Status** to **Off**, and then select **Save**.

1. Get the synchronization job and confirm that `schedule.state` is `Paused` or `Disabled`. A DELETE request for an active job returns `409 Conflict`. For API details, see [Pause synchronizationJob](/graph/api/synchronization-synchronizationjob-pause?view=graph-rest-beta&preserve-view=true) and [Get synchronizationJob](/graph/api/synchronization-synchronizationjob-get?view=graph-rest-beta&preserve-view=true).
1. Send the DELETE request:

   ```http
   DELETE https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/objectConnections('{objectId}')
   Authorization: Bearer {token}
   ```

1. Confirm that the API returns `204 No Content`:

   ```http
   HTTP/1.1 204 No Content
   ```

DELETE is idempotent. If no connection contains the supplied identifier, the API also returns `204 No Content`. Because a missing connection and a successful deletion have the same response, use GET to verify the identifier before you send the DELETE request.

## Repair an incorrect object connection

After you delete an incorrect connection, provision the object again to validate the corrected matching behavior.

1. Review the provisioning logs and identify the source and target objects in the incorrect connection.
1. Correct the source data, target data, attribute mappings, or matching configuration that caused the incorrect association.
1. Use GET to retrieve the object connection and verify its `sourceAnchor` and `targetAnchor`.
1. Pause or disable the synchronization job.
1. Confirm that the job's `schedule.state` is `Paused` or `Disabled`.
1. Use DELETE to remove the incorrect object connection.
1. [Provision the object on demand](provision-on-demand.md) to validate the corrected matching behavior.

   To use Microsoft Graph instead, see [Provision on demand](/graph/api/synchronization-synchronizationjob-provisionondemand?view=graph-rest-beta&preserve-view=true).

1. Use GET or review the provisioning logs to verify the new connection.
1. Start the synchronization job:

   ```http
   POST https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/start
   Authorization: Bearer {token}
   Content-Length: 0
   ```

   For API details, see [Start synchronizationJob](/graph/api/synchronization-synchronizationjob-start?view=graph-rest-beta&preserve-view=true).

### Example: Repair an incorrect Workday-to-Microsoft Entra ID connection

Suppose a Workday-to-Microsoft Entra ID provisioning job linked a Workday worker to the wrong Microsoft Entra user. Use the worker's Workday `WID` to inspect and remove the stored connection, and then validate a new connection to the intended user.

The following values are illustrative:

| Object | Identifier |
| --- | --- |
| Workday worker `WID` | `4f3c2b1a0e9d8c7b6a5f403122334455` |
| Incorrectly linked Microsoft Entra user object ID | `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` |
| Intended Microsoft Entra user object ID | `bbbbbbbb-1111-2222-3333-cccccccccccc` |

1. [Find the service principal and job IDs](#find-the-required-identifiers) for the Workday provisioning application.
1. Send a GET request with the worker's `WID` as the object identifier. Replace the sample `WID` with the value for your worker.

   ```http
   GET https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/objectConnections('4f3c2b1a0e9d8c7b6a5f403122334455')
   Authorization: Bearer {token}
   ```

1. Check `sourceAnchor` and `targetAnchor` in the GET response. In this example, `sourceAnchor` is the worker's `WID`, `4f3c2b1a0e9d8c7b6a5f403122334455`. The incorrect `targetAnchor` is `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`. Don't delete the connection if it isn't the association that you intend to remove.
1. [Pause or disable the job](#delete-an-object-connection) and confirm that `schedule.state` is `Paused` or `Disabled`.
1. Correct the source data, target data, attribute mappings, or matching configuration that caused the worker to match the wrong user. Deleting the connection alone doesn't correct the matching behavior.
1. Send a DELETE request with the same worker `WID`, and confirm a `204 No Content` response.

   ```http
   DELETE https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/objectConnections('4f3c2b1a0e9d8c7b6a5f403122334455')
   Authorization: Bearer {token}
   ```

   This request removes only the stored connection. It doesn't delete either user.

1. [Provision the worker on demand](provision-on-demand.md) by using the worker's `WID`.
1. Repeat the GET request. Confirm that `sourceAnchor` is still the worker's `WID`. Verify that `targetAnchor` is now the intended user's object ID, `bbbbbbbb-1111-2222-3333-cccccccccccc` in this example. Review the provisioning logs if the expected connection isn't established.
1. Start the synchronization job only after you verify the corrected connection.

## Troubleshoot HTTP responses

Use the following table to troubleshoot GET and DELETE requests. For broader provisioning issues, see [Troubleshoot provisioning to a Microsoft Entra gallery application](troubleshoot.md).

| Status code | Meaning |
| --- | --- |
| `200 OK` | GET found and returned the object connection. |
| `204 No Content` | DELETE removed the object connection, or the connection was already absent. |
| `400 Bad Request` | An identifier is invalid, or the request tries to list the object connections collection. |
| `401 Unauthorized` | The request doesn't contain a valid access token. |
| `403 Forbidden` | The caller doesn't have the required Microsoft Graph permission, Microsoft Entra role, or application authorization. |
| `404 Not Found` | The synchronization job or requested object connection wasn't found, or the API isn't available for the job. |
| `409 Conflict` | DELETE was requested while the synchronization job was active. Pause or disable the job and try again. |

## Known limitations

- The API is available only in Microsoft Graph `beta`.
- You can retrieve only one known object connection at a time.
- Listing, filtering, and enumerating all object connections isn't supported.
- You can't directly create or update an object connection.
- Deleting a connection doesn't delete or modify the source or target object.
- A later provisioning operation can create a new connection for the object.

## Related content

- [Microsoft Entra synchronization API overview](/graph/api/resources/synchronization-overview?view=graph-rest-beta&preserve-view=true)
- [Configure provisioning using Microsoft Graph APIs](application-provisioning-configuration-api.md)
- [On-demand provisioning in Microsoft Entra ID](provision-on-demand.md)

---
title: Manage provisioning object connections using Microsoft Graph
description: Learn how to inspect and remove the stored connection between a source object and a target object for a Microsoft Entra provisioning job.
ms.topic: how-to
ms.date: 09/28/2026
ms.reviewer: cmmdesai
ai-usage: ai-assisted
---

# Manage provisioning object connections using Microsoft Graph

When the Microsoft Entra provisioning service provisions an object, it stores an object connection that associates the source object with the corresponding target object. The service uses this connection during later provisioning cycles to update the correct target object.

You can use the Microsoft Graph object connections API to:

- Inspect the stored connection for a known source or target object.
- Remove an incorrect or stale connection.
- Allow the provisioning service to evaluate and match the object again.

Removing an object connection doesn't delete the source object or target object. It deletes only the provisioning service's stored association between them.

> [!IMPORTANT]
> The object connections API is available only in the Microsoft Graph `beta` endpoint. APIs in the `beta` endpoint are subject to change. Use of these APIs in production applications isn't supported.

## Prerequisites

To manage an object connection, you need:

- The object ID of the application's service principal.
- The ID of the synchronization job.
- A known source or target identifier for the object connection.
- An account with a supported Microsoft Entra role:
  - Application Administrator
  - Cloud Application Administrator
  - Hybrid Identity Administrator, for Microsoft Entra Cloud Sync

The following Microsoft Graph permissions are required:

| Operation | Delegated permission | Application permission |
| --- | --- | --- |
| Get an object connection | `Synchronization.Read.All` | `Synchronization.Read.All` or `Application.ReadWrite.OwnedBy` |
| Delete an object connection | `Synchronization.ReadWrite.All` | `Synchronization.ReadWrite.All` or `Application.ReadWrite.OwnedBy` |

For delegated access, the signed-in user must also be authorized to manage the application, such as by being an owner of its service principal or by having a supported Microsoft Entra role.

## Understand object connections

An object connection contains the identifiers that the provisioning service recorded when it associated a source object with a target object.

| Property | Description |
| --- | --- |
| `objectId` | The object identifier used to retrieve the connection. |
| `sourceAnchor` | The identifier of the object in the source system. |
| `targetAnchor` | The identifier of the corresponding object in the target system. |
| `displayName` | The display name stored for the object, when available. |
| `objectTypeName` | The object type, such as `user` or `group`. |

When you supply an object identifier, the API first searches for it as a source identifier. If no connection is found, the API searches for it as a target identifier.

Object connections are created and maintained by the provisioning service. You can't directly create or update an object connection by using this API.

## Find the required identifiers

### Find the service principal ID

The service principal represents the enterprise application in your tenant. You can retrieve it from the Microsoft Entra admin center or by using Microsoft Graph.

In the Microsoft Entra admin center:

1. Browse to **Entra ID** > **Enterprise apps**.
1. Select the application.
1. On the **Overview** page, copy the **Object ID**. This value is the service principal ID, not the application (client) ID.

### Find the synchronization job ID

List the synchronization jobs associated with the service principal:

```http
GET https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs
Authorization: Bearer {token}
```

From the response, copy the `id` property of the job that you want to manage.

For more information, see [List synchronization jobs](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-beta&preserve-view=true).

### Find an object identifier

Use a known identifier from either side of the connection:

- For Microsoft Entra ID objects, use the object's directory object ID.
- For an external source or target system, use the identifier recorded by the provisioning connector.

Provisioning logs can help you identify the source and target objects involved in an operation. For more information, see [Provisioning logs in Microsoft Entra ID](~/identity/monitoring-health/concept-provisioning-logs.md).

## Get an object connection

Use GET to inspect the stored connection for a known source or target object identifier.

The synchronization job can be active, paused, or disabled when you get an object connection.

### Request

```http
GET https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/objectConnections('{objectId}')
Authorization: Bearer {token}
```

### Response

If the connection is found, the API returns `200 OK` and the object connection.

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

If no connection contains the supplied identifier, the API returns `404 Not Found`.

### Listing object connections isn't supported

You must supply a known object identifier. The API doesn't support listing or filtering all object connections for a synchronization job.

The following request returns `400 Bad Request`:

```http
GET https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/objectConnections
Authorization: Bearer {token}
```

## Delete an object connection

Delete an object connection when the stored association is incorrect or no longer valid and you want the provisioning service to evaluate the object again.

> [!CAUTION]
> Deleting an object connection changes durable provisioning state. Verify the connection with GET before deleting it. Correct the underlying source data or matching configuration first; otherwise, a later provisioning cycle might recreate the same connection.

### Pause or disable the synchronization job

The synchronization job must be paused or disabled before you delete an object connection. A DELETE request for an active job returns `409 Conflict`.

To pause the job, use the following request:

```http
POST https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/pause
Authorization: Bearer {token}
Content-Length: 0
```

Alternatively, set **Provisioning Status** to **Off** in the Microsoft Entra admin center:

1. Browse to **Entra ID** > **Enterprise apps**.
1. Select the application.
1. Select **Provisioning**.
1. Set **Provisioning Status** to **Off**, and then select **Save**.

Before deleting the connection, retrieve the synchronization job and confirm that `schedule.state` is `Paused` or `Disabled`.

For more information, see [Pause synchronizationJob](/graph/api/synchronization-synchronizationjob-pause?view=graph-rest-beta&preserve-view=true) and [Get synchronizationJob](/graph/api/synchronization-synchronizationjob-get?view=graph-rest-beta&preserve-view=true).

### Request

```http
DELETE https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/objectConnections('{objectId}')
Authorization: Bearer {token}
```

### Response

If the connection is deleted successfully, the API returns `204 No Content`.

```http
HTTP/1.1 204 No Content
```

DELETE is idempotent. If no connection contains the supplied identifier, the API also returns `204 No Content`.

Because a missing connection and a successful deletion have the same response, use GET to verify the identifier before you send the DELETE request.

## Repair an incorrect object connection

Use the following workflow to safely remove an incorrect connection and allow the provisioning service to evaluate the object again:

1. Review the provisioning logs and identify the source and target objects in the incorrect connection.
1. Correct the source data, target data, attribute mappings, or matching configuration that caused the incorrect association.
1. Use GET to retrieve the object connection and verify its `sourceAnchor` and `targetAnchor`.
1. Pause or disable the synchronization job.
1. Confirm that the job's `schedule.state` is `Paused` or `Disabled`.
1. Use DELETE to remove the incorrect object connection.
1. Provision the object on demand to validate the corrected matching behavior.
1. Use GET or review the provisioning logs to verify the new connection.
1. Start or enable the synchronization job.

To provision the object on demand through the Microsoft Entra admin center, see [On-demand provisioning in Microsoft Entra ID](provision-on-demand.md). To use Microsoft Graph, see [Provision on demand](/graph/api/synchronization-synchronizationjob-provisionondemand?view=graph-rest-beta&preserve-view=true).

To start a paused job, use the following request:

```http
POST https://graph.microsoft.com/beta/servicePrincipals/{servicePrincipalId}/synchronization/jobs/{jobId}/start
Authorization: Bearer {token}
Content-Length: 0
```

For more information, see [Start synchronizationJob](/graph/api/synchronization-synchronizationjob-start?view=graph-rest-beta&preserve-view=true).

## HTTP responses

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

## Next steps

- [Microsoft Entra synchronization API overview](/graph/api/resources/synchronization-overview?view=graph-rest-beta&preserve-view=true)
- [Configure provisioning using Microsoft Graph APIs](application-provisioning-configuration-api.md)
- [On-demand provisioning in Microsoft Entra ID](provision-on-demand.md)
- [Troubleshoot provisioning to a Microsoft Entra gallery application](troubleshoot.md)

---
title: Object Connection IDs - Microsoft Entra ID
description: Find the source and target identifiers to use when inspecting or deleting provisioning object connections with Microsoft Graph.
author: madipanz
ms.author: mpanzarella
ms.service: entra-id
ms.topic: reference
ms.custom: msecd-doc-authoring-1030
ms.date: 10/22/2026
ms.reviewer: cmmdesai
ai-usage: ai-generated

#customer intent: As an application administrator, I want to identify the source and target attributes for my provisioning scenario so that I can retrieve or remove the correct object connection.
---

# Provisioning object connection identifiers in Microsoft Entra ID (Preview)

This reference helps application administrators find the source and target identifiers used in Microsoft Entra provisioning object connections. Use a known identifier to inspect or delete a connection for a synchronization job.

## Source and target identifiers

Use the exact source or target identifier as `{objectId}` in an object connection request. The API first searches for a source identifier. If it doesn't find a connection, it searches for a target identifier.

The API must be available for the provisioning job, and a stored connection must exist for the requested object.

Application target identifiers differ between System for Cross-domain Identity Management (SCIM) connectors and other connectors.

| Provisioning scenario | Source identifier | Target identifier |
| --- | --- | --- |
| Workday to Microsoft Entra ID | Workday `WID` attribute | Microsoft Entra user object ID (`objectId`), in GUID format |
| Workday to Active Directory | Workday `WID` attribute | Base64-encoded Active Directory `objectGUID` |
| SAP SuccessFactors to Microsoft Entra ID | SAP SuccessFactors `personIdExternal` attribute | Microsoft Entra user object ID (`objectId`), in GUID format |
| SAP SuccessFactors to Active Directory | SAP SuccessFactors `personIdExternal` attribute | Base64-encoded Active Directory `objectGUID` |
| Microsoft Entra ID to a SCIM application | Microsoft Entra object ID (`objectId`), in GUID format | The target application's SCIM resource `id` |
| Microsoft Entra ID to a non-SCIM application | Microsoft Entra object ID (`objectId`), in GUID format | The target identifier returned by the application's provisioning connector; the attribute and format vary by connector |
| Microsoft Entra ID to Salesforce | Microsoft Entra object ID (`objectId`), in GUID format | Salesforce record ID |
| Cross-tenant synchronization | Source tenant's Microsoft Entra object ID (`objectId`), in GUID format | Target tenant's Microsoft Entra object ID (`objectId`), in GUID format |
| Microsoft Entra Cloud Sync: Active Directory users to Microsoft Entra ID | Base64-encoded Active Directory `objectGUID` | Microsoft Entra user object ID (`objectId`), in GUID format |
| API-driven inbound provisioning to Microsoft Entra ID | The `externalId` supplied in the bulk-upload request | Microsoft Entra object ID (`objectId`), in GUID format |
| API-driven inbound provisioning to Active Directory | The `externalId` supplied in the bulk-upload request | Base64-encoded Active Directory `objectGUID` |

Identifier formats can vary by target application. For application provisioning, use the Microsoft Entra object ID when possible. The target identifier is assigned by the target application, such as the Salesforce record ID. It might differ from a username, email address, or user principal name (UPN).

In the GET response, `sourceAnchor` contains the stored source identifier and `targetAnchor` contains the stored target identifier. Verify both values before deleting a connection.

The service principal object ID and job ID identify the provisioning job, not the source or target object. To find them, see [Find the required identifiers](manage-object-connections.md#find-the-required-identifiers).

## Preserve the identifier format

Use the identifier exactly as stored, including its casing and encoding. The API doesn't convert other values into the stored identifier.

- For Workday, use `WID`, not `Worker_ID` or an employee ID.
- For SAP SuccessFactors, use `personIdExternal`, not `personId` or a username.
- For Active Directory, use the base64 representation of the `objectGUID` bytes. A conventional dashed GUID isn't converted automatically.
- For a SCIM target, use the resource `id` returned by the target application, not `externalId` or a UPN. Treat the value as an opaque identifier.
- For a non-SCIM target, confirm the identifier used by that connector. Don't assume that all application connectors use the same target attribute.

## Related content

- [Manage provisioning object connections using Microsoft Graph](manage-object-connections.md)
- [Provisioning logs in Microsoft Entra ID](~/identity/monitoring-health/concept-provisioning-logs.md)

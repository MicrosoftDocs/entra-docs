---
title: Audit log schemas reference
description: Reference information for Microsoft Entra audit logs schema, including field descriptions and examples.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: reference
ms.subservice: monitoring-health
ms.date: 07/23/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg
---

# Microsoft Entra audit logs schema reference

This article describes the information contained in the Microsoft Entra audit logs schema. This article includes the schema from the Microsoft Entra admin center and Microsoft Graph. Descriptions of some key fields are provided.

## Download the schema

You can download the audit log schema from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Identity** > **Monitoring & health** > **Audit logs**.
1. Select **Download**, choose **JSON**, and select **Download**.



```json
{
  "id": "000000-aaaaa-11111-bbbbb-222222",
  "category": "UserManagement",
  "correlationId": "aaaaaa-0000-1111-00000-bbbbb",
  "result": "success",
  "resultReason": "",
  "activityDisplayName": "Update business flow",
  "activityDateTime": "2024-07-23T18:09:04.1502113Z",
  "loggedByService": "Access Reviews",
  "operationType": "Update",
  "userAgent": "",
  "initiatedBy": {
      "user": null,
      "app": {
          "appId": "00000001-0000-0000-c000-000000000000",
          "displayName": null,
          "servicePrincipalId": null,
          "servicePrincipalName": null
      }
  },
  "targetResources": [
      {
          "id": "bbbbbbb-0000-1111-00000-aaaaa",
          "displayName": "Admin Consent request for application 00000-aaaaaa-1111-bbbbbbbb.",
          "type": "Policy",
          "userPrincipalName": null,
          "groupType": null,
          "modifiedProperties": []
      }
  ],
  "additionalDetails": [
      {
          "key": "tid",
          "value": "111111-0000-1111-00000-aaaaa"
      }
  ]
},
```
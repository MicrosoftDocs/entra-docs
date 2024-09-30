---
title: What are monitoring and health log schemas?
description: Learn about the Microsoft Entra audit and sign-in and logs schema, including field descriptions and examples.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: conceptual
ms.subservice: monitoring-health
ms.date: 09/30/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg
---

# What are Microsoft Entra logs schema?

This article describes the information contained in the Microsoft Entra sign-in and audit logs schemas. This article includes the schema from the Microsoft Entra admin center and Microsoft Graph. Descriptions of some key fields are provided.

## Download the schema

You can download the sign-in log schema from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Identity** > **Monitoring & health** > **Audit logs/Sign-in logs**.
1. Select the **Download** button and select **JSON**.
    - For sign-in logs you also need to select the type of logs you want to download: Interactive, non-interactive, service principal (ApplicationSignIns), or managed identity (MSISignIns).
1. Open the downloaded file to view the schema.
    - You may need to clean up the formatting to make the schema more readable.


## Sample JSON schema

Some properties were removed from the sample for brevity. Many of the values are placeholders and don't represent real data.

### [Sign-in logs](#tab/sign-in-logs)

For a full list of the properties, their descriptions, and the possible values, see [signIn resource type](graph/api/resources/signin?view=graph-rest-1.0&preserve-view=true).

```json
{
  "id": "111111-aaaaa-2222222-bbbb-000000000",
  "createdDateTime": "2024-07-23T15:19:52Z",
  "userDisplayName": "Bala Sandhu",
  "userPrincipalName": "BalaS@microsoft.com",
  "userId": "11bb11bb-cc22-dd33-ee44-55ff55ff55ff",
  "appId": "33334444-dddd-5555-eeee-6666ffff7777",
  "appDisplayName": "Azure Portal",
  "ipAddress": "10.1.1.1",
  "clientAppUsed": "Browser",
  "correlationId": "aaaa0000-bb11-2222-33cc-444444dddddd",
  "conditionalAccessStatus": "success",
  "riskDetail": "none",
  "riskLevelAggregated": "none",  
  "resourceId": "e4e4e4e4-ffff-aaaa-bbbb-c5c5c5c5c5c5",
  "resourceTenantId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
  "homeTenantId": "eeeeffff-4444-aaaa-5555-bbbb6666cccc",
  "authenticationRequirement": "multiFactorAuthentication",
  "userType": "guest",
  "flaggedForReview": false,
  "isTenantRestricted": false,
  "autonomousSystemNumber": 000,
  "status": {
      "errorCode": 0,
      "failureReason": "Other.",
      "additionalDetails": null
  },
  "deviceDetail": {
      "deviceId": "{PII Removed}",
      "displayName": "{PII Removed}",
      "operatingSystem": "Windows10",
      "browser": "Edge 126.0.0",
      "isCompliant": true,
      "isManaged": true,
      "trustType": "Azure AD joined"
  },
  "location": {
      "city": "City",
      "state": "State",
      "countryOrRegion": "US",
      }
  },
  "appliedConditionalAccessPolicies": [
      {
          "id": "bbbbbbbb-1111-aaaaa-0000-aaaaaaaa",
          "displayName": "CA004: Require multi-factor authentication for all users",
          "enforcedGrantControls": [
              "Mfa"
          ],
          "enforcedSessionControls": [],
          "sessionControlsNotSatisfied": [],
          "result": "success",
          "conditionsSatisfied": "application,users",
          "conditionsNotSatisfied": "none",
          "authenticationStrength": null,
          "includeRulesSatisfied": [
              {
                  "conditionalAccessCondition": "application",
                  "ruleSatisfied": "allApps"
              },
              {
                  "conditionalAccessCondition": "users",
                  "ruleSatisfied": "allUsers"
              }
          ],
          "excludeRulesSatisfied": []
      },
      {
          "id": "322628ae-d0cd-4d8f-833f-ccea68fdcc36",
          "displayName": "CA003: Block legacy authentication",
          "enforcedGrantControls": [
              "Block"
          ],
          "enforcedSessionControls": [],
          "sessionControlsNotSatisfied": [],
          "result": "notApplied",
          "conditionsSatisfied": "application,users",
          "conditionsNotSatisfied": "clientType",
          "authenticationStrength": null,
          "includeRulesSatisfied": [
              {
                  "conditionalAccessCondition": "application",
                  "ruleSatisfied": "allApps"
              },
              {
                  "conditionalAccessCondition": "users",
                  "ruleSatisfied": "allUsers"
              }
          ],
          "excludeRulesSatisfied": []
      },
  ],

```

### Field descriptions

| Property | Description |
| --- | --- | 
| createdDateTime | The date and time, in UTC. |
| resourceId | ID of the resource that the user signed into. |
| resourceTenantId | The tenant that owns the resource being accessed. Might be the same as the homeTenantId. |
| homeTenantId | The tenant that owns the user account that is signing in. |
| riskDetail | Provides the reason behind a specific state of a risky user, sign-in, or risk detection. The value `none` means that no action has been performed on the user or sign-in so far.<br>**Note:** Details for this property require a Microsoft Entra ID P2 license. Other licenses return the value `hidden`. |
| riskEventTypes_v2 | Risk detection types associated with the sign-in.  |
| riskLevelAggregated | Aggregated risk level. The value `hidden` means the user or sign-in wasn't enabled for Microsoft Entra ID Protection. **Note:** Details for this property are only available for Microsoft Entra ID P2 customers. All other customers will be returned `hidden`. |
| riskState | Reports status of the risky user, sign-in, or a risk event. |
| correlationId | Unique ID that helps correlate activities that span across various services. Used to troubleshoot sign-in activity. |
| crossTenantAccessType | Describes the type of cross-tenant access used to access the resource. B2B, Microsoft Support, and passthrough sign-ins are captured here. |
| status | Sign-in status. Includes the error code and description of the error (if a sign-in failure occurs). |

### Applied Conditional Access policies

If any Conditional Access policies were applied during the sign-in, a subsection under `appliedConditionalAccessPolicies` lists Conditional Access related information. A separate entry is created for each policy. For more information, see [conditionalAccessPolicy resource type](graph/api/resources/conditionalaccesspolicy?view=graph-rest-1.0&preserve-view=true).

## [Audit logs](#tab/audit-logs)

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

### Field descriptions

For a full list of the properties, their descriptions, and the possible values, see [directoryAudit resource type](graph/api/resources/drectoryaudit?view=graph-rest-1.0&preserve-view=true)

| Property | Description |
| --- | --- | 
| activityDateTime | The date and time, in UTC. |
| activityDisplayName | Indicates the activity name or the operation name (examples: "Create User" and "Add member to group"). For more information, see [Audit log activities](reference-audit-activities.md). |
| category | Indicates which resource category that's targeted by the activity. For example: `UserManagement`, `GroupManagement`, `ApplicationManagement`, `RoleManagement`. For more information, see [Audit log activities](reference-audit-activities.md). |
| correlationId | Unique ID that helps correlate activities that span across various services. Used to troubleshoot tenant activity. |
| initiatedBy | Indicates information about the user or app initiated the activity. |
| result | Indicates the result of the activity. Possible values are: `success`, `failure`, `timeout`, `unknownFutureValue`. |
| targetResources | Indicates information on which resource was changed due to the activity. Target Resource Type can be `User`, `Device`, `Directory`, `App`, `Role`, `Group`, `Policy` or `Other`. |
---

## Next steps

* [Interpret audit logs schema in Azure Monitor](./overview-monitoring-health.md)
* [Read more about Azure platform logs](/azure/azure-monitor/essentials/platform-logs-overview)

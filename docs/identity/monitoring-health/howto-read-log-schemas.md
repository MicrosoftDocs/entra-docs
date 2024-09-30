---
title: How to read the monitoring and health log schemas
description: Learn how to interpret the details found in the the Microsoft Entra audit and sign-in and logs schema.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 09/30/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg

# Customer intent: As an IT admin, I want to understand the schema of the Microsoft Entra audit and sign-in logs so that I can interpret the data in the logs and use it to monitor and troubleshoot my organization's identity and access management.
---

# How to read the Microsoft Entra logs schema

This article describes the information contained in the Microsoft Entra sign-in and audit logs and how that schema is used by other services. This article covers the schemas from the Microsoft Entra admin center and Microsoft Graph. Descriptions of some key fields are provided.

## Prerequisites

- For license and role requirements, see [Microsoft Entra monitoring and health licensing](../../fundamentals/licensing.md#microsoft-entra-monitoring-and-health).
- The option to download logs is available in all editions of Microsoft Entra ID.
- Downloading logs programmatically with Microsoft Graph requires a [premium license](../../fundamentals/licensing.md#microsoft-entra-monitoring-and-health).
- **Reports Reader** is the least privileged role required to view Microsoft Entra activity logs.
- Audit logs are available for features that you've licensed.
- The results of a downloaded log might show `hidden` for some properties if you don't have the required license.

## How to interpret the log schemas

Microsoft Entra monitoring and health offer logs, reports, and monitoring tools that can be integrated with Azure Monitor. Understanding the log schema is crucial for effective troubleshooting and data interpretation.

You can download the logs from the Microsoft Entra admin center in JSON format, which closely matches what you see when you query the logs using Microsoft Graph. However, the results of the query in Microsoft Graph vary if you're using the V1.0 or beta version of the schema. 

The V1.0 version of the schema is the most stable. The beta version often contains more properties, but they are subject to change. For this reason we don't recommend using the beta version of the schema in production environments.

Azure Monitor ingests the logs from Microsoft Entra but the schema is different for some properties. Some properties have a slightly different name or might be broken into multiple properties.

For full details on these schemas, see the following articles:

- [Azure Monitor audit logs](/azure/azure-monitor/reference/tables/auditlogs)
- [Azure Monitor sign-in logs](/azure/azure-monitor/reference/tables/signinlogs)
- [Azure Monitor provisioning logs](/azure/azure-monitor/reference/tables/aadprovisioninglogs)
- [Microsoft Graph audit logs](/graph/api/resources/directoryaudit?view=graph-rest-1.0&preserve-view=true)
- [Microsoft Graph sign-in logs](/graph/api/resources/signin?view=graph-rest-1.0&preserve-view=true)
- [Microsoft Graph provisioning logs](/graph/api/resources/provisioninglog?view=graph-rest-1.0&preserve-view=true)

### Sample JSON representations

Some properties were removed from the sample for brevity. Many of the values are placeholders and don't represent real data.

### [Sign-in logs](#tab/sign-in-logs)

For a full list of the properties, their descriptions, and the possible values, see [signIn resource type](/graph/api/resources/signin?view=graph-rest-1.0&preserve-view=true).

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
### [Audit logs](#tab/audit-logs)

For a full list of the properties, their descriptions, and the possible values, see [directoryAudit resource type](/graph/api/resources/directoryaudit?view=graph-rest-1.0&preserve-view=true).

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

---

## How to interpret the schema

When looking up the definitions of a value, pay attention to the version you're using. There might be differences between the V1.0 and beta versions of the schema.

### Values found in all log schemas

Some values are common across all log schemas. 

- `correlationId`: This unique ID helps correlate activities that span across various services and is used for troubleshooting.
- `status` or `result`: This important value indicates the result of the activity. Possible values are: `success`, `failure`, `timeout`, `unknownFutureValue`.
- Date and time: The date and time when the activity occurred is in Coordinated Universal Time (UTC).
- Displaying some properties require a Microsoft Entra ID P2 license. If you don't have the Other licenses return the value `hidden`.

### Audit logs

- `activityDisplayName`: Indicates the activity name or the operation name (examples: "Create User" and "Add member to group"). For more information, see [Audit log activities](reference-audit-activities.md).
- `category`: Indicates which resource category that's targeted by the activity. For example: `UserManagement`, `GroupManagement`, `ApplicationManagement`, `RoleManagement`. For more information, see [Audit log activities](reference-audit-activities.md).
- `initiatedBy`: Indicates information about the user or app initiated the activity.
- `targetResources`: Indicates information on which resource was changed due to the activity. Target Resource Type can be `User`, `Device`, `Directory`, `App`, `Role`, `Group`, `Policy` or `Other`.

### Sign-in logs

- ID values: There are unique identifiers for users, tenants, applications, and resources. Examples include:
    - `resourceId`: The resource that the user signed into.
    - `resourceTenantId`: The tenant that owns the *resource* being accessed. Might be the same as the `homeTenantId`.
    - `homeTenantId`: The tenant that owns the user *account* that is signing in.
- Risk details: Provides the reason behind a specific state of a risky user, sign-in, or risk detection.
    - `riskDetail`: Provides the reason behind a specific *state* of a risky user, sign-in, or risk detection. The value `none` means that no action has been performed on the user or sign-in so far.
    - `riskEventTypes_v2`: Risk detection types associated with the sign-in.
    - `riskLevelAggregated`: Aggregated risk level. The value `hidden` means the user or sign-in wasn't enabled for Microsoft Entra ID Protection.
    - `riskState`: Reports status of the risky user, sign-in, or a risk event.
- `crossTenantAccessType`: Describes the type of cross-tenant access used to access the resource. For example, B2B, Microsoft Support, and passthrough sign-ins are captured here.
- `status`: The sign-in status that includes the error code and description of the error (if a sign-in failure occurs).

### Applied Conditional Access policies

If any Conditional Access policies were applied during the sign-in, a subsection under `appliedConditionalAccessPolicies` lists Conditional Access related information. A separate entry is created for each policy. For more information, see [conditionalAccessPolicy resource type](/graph/api/resources/conditionalaccesspolicy?view=graph-rest-1.0&preserve-view=true).
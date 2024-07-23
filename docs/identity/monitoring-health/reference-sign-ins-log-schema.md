---
title: Sign-in log schemas
description: Reference information for Microsoft Entra sign-in logs schema, including field descriptions and examples.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: reference
ms.subservice: monitoring-health
ms.date: 07/23/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg
---

# Microsoft Entra sign-in logs schema reference

This article describes the information contained in the Microsoft Entra sign-in logs schema. This article includes the schema from the Microsoft Entra admin center and Microsoft Graph. Descriptions of some key fields are provided.

## Download the schema

You can download the sign-in log schema from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Identity** > **Monitoring & health** > **Sign-in logs**.
1. Select the **Download** button and select **JSON**.


```json
{
  "id": "111111-aaaaa-2222222-bbbb-000000000",
  "createdDateTime": "2024-07-23T15:19:52Z",
  "userDisplayName": "Bala Sandhu",
  "userPrincipalName": "BalaS@microsoft.com",
  "userId": "aaaaaaa-0000-bbbb-1111-aaaaaaaa",
  "appId": "bbbbbbbb-1111-aaaaa-0000-aaaaaaaa",
  "appDisplayName": "Azure Portal",
  "ipAddress": "10.1.1.1",
  "correlationId": "aaaaaaa-0000-bbbb-1111-bbbbbbb",
  "conditionalAccessStatus": "success",
  "riskDetail": "none",
  "resourceId": "bbbbbbbb-1111-aaaaa-0000-aaaaaaaa",
  "resourceTenantId": "000000-aaaa-bbbb-1111-00000000",
  "homeTenantId": "111111-aaaaa-bbbb-000000000",
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
      {
          "id": "85425b15-76c8-4cc6-b1df-36afcd094151",
          "displayName": "CA007: Require multi-factor authentication for risky sign-in",
          "enforcedGrantControls": [
              "Mfa"
          ],
          "enforcedSessionControls": [
              "SignInFrequency"
          ],
          "sessionControlsNotSatisfied": [],
          "result": "notApplied",
          "conditionsSatisfied": "application,users",
          "conditionsNotSatisfied": "signInRisk",
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
          "id": "a3f333f5-5287-4c7d-9dbf-f4cd52bdcad0",
          "displayName": "TESTING: Require phishing-resistant multifactor authentication for admins",
          "enforcedGrantControls": [],
          "enforcedSessionControls": [],
          "sessionControlsNotSatisfied": [],
          "result": "notApplied",
          "conditionsSatisfied": "application",
          "conditionsNotSatisfied": "users",
          "includeRulesSatisfied": [
              {
                  "conditionalAccessCondition": "application",
                  "ruleSatisfied": "allApps"
              },
              {
                  "conditionalAccessCondition": "users",
                  "ruleSatisfied": "roleId"
              }
          ],
          "excludeRulesSatisfied": [
              {
                  "conditionalAccessCondition": "users",
                  "ruleSatisfied": "groupId"
              }
          ],
          "authenticationStrength": {
              "displayName": null,
              "authenticationStrengthId": "00000000-0000-0000-0000-000000000004",
              "authenticationStrengthResult": "singleRegistrationRequired"
          }
      },
  ],

```


## Field descriptions

| Field name | Key | Description |
| --- | --- | --- | 
| Time |  - | The date and time, in UTC. |
| ResourceId | - | This value is unmapped, and you can safely ignore this field.  |
| OperationName | - | For sign-ins, this value is always *Sign-in activity*. |
| OperationVersion | - | The REST API version that's requested by the client. |
| Category | - | For sign-ins, this value is always *SignIn*. | 
| TenantId | - | The tenant GUID that's associated with the logs. |
| ResultType | - | The result of the sign-in operation can be `0` for success or an *error code* for failure. | 
| ResultSignature | - | This value is always *None*. |
| ResultDescription | N/A or blank | Provides the error description for the sign-in operation. |
| riskDetail | riskDetail | Provides the 'reason' behind a specific state of a risky user, sign-in or a risk detection. The possible values are: `none`, `adminGeneratedTemporaryPassword`, `userPerformedSecuredPasswordChange`, `userPerformedSecuredPasswordReset`, `adminConfirmedSigninSafe`, `aiConfirmedSigninSafe`, `userPassedMFADrivenByRiskBasedPolicy`, `adminDismissedAllRiskForUser`, `adminConfirmedSigninCompromised`, `unknownFutureValue`. The value `none` means that no action has been performed on the user or sign-in so far. <br>**Note:** Details for this property require a Microsoft Entra ID P2 license. Other licenses return the value `hidden`. |
| riskEventTypes | riskEventTypes | Risk detection types associated with the sign-in. The possible values are: `unlikelyTravel`, `anonymizedIPAddress`, `maliciousIPAddress`, `unfamiliarFeatures`, `malwareInfectedIPAddress`, `suspiciousIPAddress`, `leakedCredentials`, `investigationsThreatIntelligence`,  `generic`, and `unknownFutureValue`. |
| authProcessingDetails	| Azure Active Directory Authentication Library | Contains Family, Library, and Platform information in format: "Family: Microsoft Authentication Library: ADAL.JS 1.0.0 Platform: JS" |
| authProcessingDetails	| IsCAEToken | Values are True or False |
| riskLevelAggregated | riskLevel | Aggregated risk level. The possible values are: `none`, `low`, `medium`, `high`, `hidden`, and `unknownFutureValue`. The value `hidden` means the user or sign-in wasn't enabled for Microsoft Entra ID Protection. **Note:** Details for this property are only available for Microsoft Entra ID P2 customers. All other customers will be returned `hidden`. |
| riskLevelDuringSignIn | riskLevel | Risk level during sign-in. The possible values are: `none`, `low`, `medium`, `high`, `hidden`, and `unknownFutureValue`. The value `hidden` means the user or sign-in wasn't enabled for Microsoft Entra ID Protection. **Note:** Details for this property are only available for Microsoft Entra ID P2 customers. All other customers will be returned `hidden`. |
| riskState | riskState | Reports status of the risky user, sign-in, or a risk detection. The possible values are: `none`, `confirmedSafe`, `remediated`, `dismissed`, `atRisk`, `confirmedCompromised`, `unknownFutureValue`. |
| DurationMs | - | This value is unmapped, and you can safely ignore this field. |
| CallerIpAddress | - | The IP address of the client that made the request. | 
| CorrelationId | - | The optional GUID that's passed by the client. This value can help correlate client-side operations with server-side operations, and it's useful when you're tracking logs that span services. |
| Identity | - | The identity from the token that was presented when you made the request. It can be a user account, system account, or service principal. |
| Level | - | Provides the type of message. For audit, it's always *Informational*. |
| Location | - | Provides the location of the sign-in activity. |
| Properties | - | Lists all the properties that are associated with sign-ins.|
| ResultType | - | Contains the Microsoft Entra error code for the sign-in event (if an error code was present).|



## Next steps

* [Interpret audit logs schema in Azure Monitor](./overview-monitoring-health.md)
* [Read more about Azure platform logs](/azure/azure-monitor/essentials/platform-logs-overview)

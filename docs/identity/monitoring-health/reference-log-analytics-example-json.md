---
title: Example Conditional Access policy log JSON
description: Example Conditional Access policy log JSON needed to complete the Improve Log Analytics performance tutorial.
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: reference
ms.subservice: monitoring-health
ms.date: 12/03/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg14
---
# Example Conditional Access policy log JSON

```json
[
  {
    "RequestId": "225a4a9c-aeb7-42c1-8d4d-f17c5fd7cf00-40",
    "index": 40,
    "TimeGenerated": "2023-09-09T22:57:40.4023619Z",
    "policyId": "dd4fe198-0671-4057-ab7d-255bf4e31096",
    "displayName": "Require phishing-resistant multifactor authentication for admins",
    "enforcedGrantControls": [],
    "enforcedSessionControls": [],
    "result": "reportOnlyNotApplied",
    "conditionsSatisfied": 1,
    "conditionsNotSatisfied": 2,
    "includeRulesSatisfied": [
      "{\"conditionalAccessCondition\":\"application\",\"ruleSatisfied\":\"allApps\"}",
      "{\"conditionalAccessCondition\":\"users\",\"ruleSatisfied\":\"groupId\"}"
    ],
    "excludeRulesSatisfied": [
      "{\"conditionalAccessCondition\":\"application\",\"ruleSatisfied\":\"allApps\"}",
      "{\"conditionalAccessCondition\":\"users\",\"ruleSatisfied\":\"groupId\"}"
    ],
    "authenticationStrength": {
      "displayName": null,
      "authenticationStrengthId": "00000000-0000-0000-0000-000000000004",
      "authenticationStrengthResult": "singleRegistrationRequired"
    }
  },
  {
    "RequestId": "225a4a9c-aeb7-42c1-8d4d-f17c5fd7cf00-41",
    "index": 41,
    "TimeGenerated": "2023-09-09T22:57:40.4023619Z",
    "policyId": "b954b08c-05c2-4184-9a02-a5f634300e4f",
    "displayName": "Require compliant or hybrid Azure AD joined device for admins",
    "enforcedGrantControls": ["RequireCompliantDevice"],
    "enforcedSessionControls": [],
    "result": "reportOnlyNotApplied",
    "conditionsSatisfied": 1,
    "conditionsNotSatisfied": 2,
    "includeRulesSatisfied": [
      "{\"conditionalAccessCondition\":\"application\",\"ruleSatisfied\":\"allApps\"}",
      "{\"conditionalAccessCondition\":\"users\",\"ruleSatisfied\":\"groupId\"}"
    ],
    "excludeRulesSatisfied": [
      "{\"conditionalAccessCondition\":\"application\",\"ruleSatisfied\":\"allApps\"}",
      "{\"conditionalAccessCondition\":\"users\",\"ruleSatisfied\":\"groupId\"}"
    ]
  },
  {
    "RequestId": "225a4a9c-aeb7-42c1-8d4d-f17c5fd7cf00-42",
    "index": 42,
    "TimeGenerated": "2023-09-09T22:57:40.4023619Z",
    "policyId": "d349239d-cbe7-4caf-a8ff-1b180d00901e",
    "displayName": "Require multifactor authentication for Azure management",
    "enforcedGrantControls": ["Mfa"],
    "enforcedSessionControls": [],
    "result": "reportOnlyNotApplied",
    "conditionsSatisfied": 1,
    "conditionsNotSatisfied": 2,
    "includeRulesSatisfied": [
      "{\"conditionalAccessCondition\":\"application\",\"ruleSatisfied\":\"allApps\"}",
      "{\"conditionalAccessCondition\":\"users\",\"ruleSatisfied\":\"groupId\"}"
    ],
    "excludeRulesSatisfied": [
      "{\"conditionalAccessCondition\":\"application\",\"ruleSatisfied\":\"allApps\"}",
      "{\"conditionalAccessCondition\":\"users\",\"ruleSatisfied\":\"groupId\"}"
    ],
    "authenticationStrength": {
      "displayName": null,
      "authenticationStrengthId": "00000000-0000-0000-0000-000000000004",
      "authenticationStrengthResult": "singleRegistrationRequired"
    }
  },
  {
    "RequestId": "225a4a9c-aeb7-42c1-8d4d-f17c5fd7cf00-43",
    "index": 43,
    "TimeGenerated": "2023-09-09T22:57:40.4023619Z",
    "policyId": "35ceda44-051b-4b83-aad8-9693b5d3df7f",
    "displayName": "Jackson 2",
    "enforcedGrantControls": ["Block"],
    "enforcedSessionControls": [],
    "result": "reportOnlyNotApplied",
    "conditionsSatisfied": 0,
    "conditionsNotSatisfied": 1,
    "includeRulesSatisfied": [
      "{\"conditionalAccessCondition\":\"application\",\"ruleSatisfied\":\"allApps\"}",
      "{\"conditionalAccessCondition\":\"users\",\"ruleSatisfied\":\"groupId\"}"
    ],
    "excludeRulesSatisfied": [
      "{\"conditionalAccessCondition\":\"application\",\"ruleSatisfied\":\"allApps\"}",
      "{\"conditionalAccessCondition\":\"users\",\"ruleSatisfied\":\"groupId\"}"
    ]
  }
]
```
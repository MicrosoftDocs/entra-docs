---
title: Using groups managed by Privileged Identity Management with access packages
description: This article serves as a reference for Microsoft Entra ID behavior when assignment periods of an access package and PIM policy don't align.
author: owinfreyATL
ms.author: owinfrey
manager: dougeby
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 05/27/2025

#CustomerIntent: As a customer, I want to become informed on what happens in the different scenarios when PIM expiration dates differ from the access package expiration date.
---

# Using groups managed by Privileged Identity Management with access packages

This article contains information about Microsoft Entra ID behavior in scenarios where a group managed by PIM, and the access package expiration periods, differ. By assigning a group managed by PIM to an access package, you're able to assign eligible roles when an access package is requested. If you’re looking for a guide on setting up a group to assign eligible roles via access packages, see: [Assign eligible group membership and ownership in access packages via Privileged Identity Management for Groups (Preview)](entitlement-management-access-package-eligible.md).


## Shorter access package expiration

When an access package's expiration date is shorter than PIM's "*Expire eligible assignments after*" duration, then the PIM assignment expires when the access package expires.

### Example

| Access package policy assignment expiration | PIM policy max assignment duration | Microsoft Entra ID behavior |
|-------------------------------------|-----------------------------------|-----------------------------|
| 30 days                            | 365 days                          | Entitlement management sets a 365 day expiration on the PIM assignment when the access policy assignment is created, but removes the PIM assignment after the access policy assignment expires after 30 days. |

## Shorter PIM duration

When the PIM "*Expire eligible assignments after*" duration expires before the access package assignment, access is revoked when the PIM assignment expires irrespective of the access package's expiration date.

### Example

| Access package policy assignment expiration | PIM policy max assignment duration | Microsoft Entra ID behavior |
|--------------------------------------------|-----------------------------------|-----------------------------|
| 180 days                                   | 40 days                           | Entitlement management sets a 40 day expiration on the PIM assignment when the access policy assignment is created. On day 41, although the access package is still assigned, access is revoked. |

## Permanent access package assignment

If the Access package assignment is permanent, access is revoked based on when the PIM "*Expire eligible assignments after*" assignment expires.

### Example

| Access package policy assignment expiration | PIM Policy Max Assignment Duration | Microsoft Entra ID behavior |
|------------------------------------|------------------------------------|-----------------------------|
| None (permanent allowed)           | 40 days                            | Entitlement management sets a 40 day expiration on the PIM assignment when the access policy assignment is created. On day 41, although the access package is still assigned, access is revoked. |

## Permanent PIM assignment

When the PIM "*Expire eligible assignments after*" assignment is permanent, it's removed only when the access package assignment expires.

### Example

| Access package policy assignment expiration | PIM Policy Max Assignment Duration | Microsoft Entra ID behavior |
|------------------------------------|------------------------------------|-----------------------------|
| 60 days                            | None (permanent allowed)           | Entitlement management creates the PIM assignment and sets it to permanent on the access package policy assignment. Access is revoked on day 61 after the access package policy assignment expires. |

## Permanent access package and PIM assignment

If both the access package and PIM "*Expire eligible assignments after*" assignments are permanent, the PIM assignment remains as long as the access package assignment.

### Example

| Access package policy assignment expiration | PIM Policy Max Assignment Duration | Microsoft Entra ID behavior |
|------------------------------------|------------------------------------|-----------------------------|
| None (permanent allowed)           | None (permanent allowed)           | Entitlement management creates and sets the PIM assignment to permanent. The PIM assignment is only removed if the access package assignment is removed by other ways such as a removal request. |

## Related content

- [Change resource roles for an access package in entitlement management](entitlement-management-access-package-resources.md)
- [Assign eligible group membership and ownership in access packages via Privileged Identity Management for Groups (Preview)](entitlement-management-access-package-eligible.md)

---
title: Microsoft Entra ID Governance service limits
description: This article details service limits for offerings within Microsoft Entra ID Governance
author: owinfreyATL
ms.author: owinfrey
manager: dougeby
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 12/10/2024

#CustomerIntent: As a customer, I want to become informed on service limits for offerings within Microsoft Entra ID Governance so that restraints are understood and can be accounted for.
---

# Microsoft Entra ID Governance service limits

This article contains the default usage constraints for the Microsoft Entra ID Governance, part of Microsoft Entra, service. If you’re looking for the full set of non-governance specific Microsoft Entra service limits, see: [Microsoft Entra service limits and restrictions](../identity/users/directory-service-limits-restrictions.md).

> [!NOTE]
> Limits can be increased if your usage will exceed these listed default constraints. To go beyond the default quota, you must contact Microsoft Support.

## Entitlement Management

> [!Tip]
> We recommend that access packages contain more than one resource role and are modeled on the basis of departments, job functions, locations, projects or a combination of these.

|Feature  |Limit  |
|---------|---------|
|Access Packages   |  20,000 per tenant      |
|Access Package Assignments - An access package assignment is an assignment of an access package to a particular user   | 300,000 per tenant        |
|Access Package Assignments from a given automatic assignment policy      | 15,000 per automatic assignment policy       |
|Catalogs     |   7,500 per tenant      |
|Connected Organizations     |  2,500 per tenant       |
|Custom extensions     |  500 per tenant       |
|Policies - An access package assignment policy specifies the policy by which users can request or be assigned an access package    |  25,000 per tenant       |
|Connected Organizations referenced in a single policy as part of the 'Users who can request access' definition    |  1,000 per policy       |
|Combined number of users and groups explicitly referenced in a single policy as part of the 'Users who can request access' definition.     |  500 per policy       |
|Requests (within 3 months)  - An access package assignment request is created by or on behalf of a user who wants to obtain, update or remove an access package assignment. This includes requests which are created by the system for automatic assignment policies   |  200,000 per tenant       |

## Lifecycle Workflows

|Category  |Limit  |
|---------|---------|
|Number of Workflows     |   100 per tenant      |
|Number of Tasks     |  25 per workflow       |
|Number of Custom Task Extensions     |  100 per tenant       |
|offsetInDays range of triggerAndScopeBasedConditions executionConditions     |  180 days       |
|Workflow schedule interval in hours     |   1-24 hours      |
|Number of users per on-demand selection	     |  10       |
|durationBeforeTimeout range of custom task extensions     |   5 minutes-3 hours      |

> [!NOTE]
> If creating, or updating, a workflow via API the offsetInDays range will be between -180-180 days. The negative value will signal happening before the timeBasedAttribute, while the positive value will signal happening afterwards.

## Related content

- [Microsoft Entra ID Governance](identity-governance-overview.md)

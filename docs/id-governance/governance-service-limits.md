---
title: Microsoft Entra ID Governance service limits
description: This article details service limits for offerings within Microsoft Entra ID Governance
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 10/30/2023

#CustomerIntent: As a customer, I want to become informed on service limits for offerings within Microsoft Entra ID Governance so that restraints are understood and can be accounted for.
---

# Microsoft Entra ID Governance service limits

This article contains the default usage constraints for the Microsoft Entra ID Governance, part of Microsoft Entra, service. If you’re looking for the full set of non-governance specific Microsoft Entra service limits, see: [Microsoft Entra service limits and restrictions](../identity/users/directory-service-limits-restrictions.md).

> [!NOTE]
> Limits can be increased if your usage will exceed these listed default constraints. To go beyond the default quota, you must contact Microsoft Support.

## Entitlement Management

### Per Tenant

|Feature  |Limit  |
|---------|---------|
|Access Packages   |  20,000       |
|Access Package Assignments     | 300,000        |
|Access Package Assignments from a given automatic assignment policy      | 15,000        |
|Catalogs     |   7,500      |
|Connected Organizations     |  2,500       |
|Custom extensions     |  500       |
|Policies     |  25,000       |
|Requests (Within 3 months)     |  200,000       |

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

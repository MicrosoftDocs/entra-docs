---
title: Microsoft Entra ID Governance service limits
description: This article details service limits for offerings within Microsoft Entra ID Governance 
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: active-directory
ms.workload: identity
ms.topic: concept-article
ms.date: 10/30/2023

#CustomerIntent: As a customer, I want become educated of service limits for offerings within Microsoft Entra ID Governance so that limits are understood and met.
---

# Microsoft Entra ID Governance service limits

This article contains the usage constraints and other service limits for the Microsoft Entra ID Governance, part of Microsoft Entra, service. If you’re looking for the full set of Microsoft Azure service limits, see [Azure Subscription and Service Limits, Quotas, and Constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits).

## Entitlement Management

### Per Tenant

|Feature  |Limits  |
|---------|---------|
|Access Packages   |  4,000       |
|Access Package Assignments     | 100,000        |
|Catalogs     |   1,500      |
|Connected Organizations     |  2,500       |
|Custom extensions     |  500       |
|Lifetime of Requests     |  Three months after completion       |
|Policies     |  5,000       |
|Requests (Within 3 months)     |  50,000       |


### Per Catalog

|Feature  |Limits  |
|---------|---------|
|Access Packages   |  50      |
|Attributes    | 20        |
|Custom extensions     |  20       |
|Custom extensions per policy    |  5       |
|Resources     |  50      |
|Users delegated to roles     |  10      |

### Per Access Package

|Feature  |Limits  |
|---------|---------|
|Assignments    | 10,000        |
|Policies  |  10      |


## Lifecycle Workflows

### Per tenant

|Category  |Limit  |
|---------|---------|
|Custom Task Extensions     |  100     |
|Schedule interval in hours     |   1-24      |
|Workflows     |   50    |


### Per Workflow

|Category  |Limit  |
|---------|---------|
|Custom Task Extensions     |  100(tenant restriction)     |
|durationBeforeTimeout range of custom task extensions     |   5 minutes-3 hours      |
|Number of users per on-demand selection   |  10       |
|offsetInDays range of triggerAndScopeBasedConditions executionConditions     |  180 days       |
|Tasks     |  25 per workflow       |


## Related content

- [Microsoft Entra ID Governance](identity-governance-overview.md)

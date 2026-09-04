---
title: Licensing for Microsoft Entra Tenant Governance
titleSuffix: Microsoft Entra ID Governance
description: Learn which Microsoft Entra Tenant Governance features are available with each license tier, including P1, P2, and ID Governance
author: tafra00
ms.author: tafra00
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 07/29/2026
ms.custom: msecd-doc-authoring-1018
ai-usage: ai-assisted

#customer intent: As an IT decision maker, administrator, or partner, I want to understand Microsoft Entra Tenant Governance licensing so that I can plan licenses for the features and scenarios my organization uses.
---

# Licensing for Microsoft Entra Tenant Governance

Microsoft Entra Tenant Governance licensing applies to administrators who use Tenant Governance capabilities. This article is for IT decision makers, IT administrators, and partners. Use it to evaluate licensing for discovering, creating, managing, or governing tenants across an organization or customer environments.

Licensing isn't required for every user in a tenant. For governance relationships, administrators who perform delegated administration activities need licenses in the governing tenant.

## Features by license

[!INCLUDE [Microsoft Entra Tenant Governance](~/includes/licensing-tenant-governance.md)]

## Licensing scenarios by feature

The following scenarios show how to calculate licensing needs for common Tenant Governance uses.

### Configuration management

Tenant Governance Basic provides configuration monitoring and snapshot capacity. Tenant Governance Premium licenses add capacity for organizations that need to cover more configuration resources.

#### Monitor daily configuration drift with an E3 license

**Situation:** Contoso has Microsoft 365 E3, which includes Microsoft Entra P1. Its identity team wants to use Tenant Configuration Management without buying more licenses. Its monitoring scope fits within the Basic limit of 800 configuration resources per tenant per day.

**Licensing calculation:** Contoso can monitor up to 800 configuration resources each day with the Basic capacity included with its existing E3 licensing. It doesn't need more licenses for this scope.

**How Contoso uses the capacity:** The team prioritizes authentication methods, Conditional Access policies, role settings, and other high-impact tenant configurations. When a monitored setting changes, the team reviews the drift report to understand what changed and whether the change was expected. It restores the approved configuration after an unauthorized change or updates the baseline after an intentional change.

**Outcome:** Contoso gets daily drift visibility and stronger control for its most important tenant resources without additional licensing cost.

#### Expand monitoring beyond the Basic daily limit

**Situation:** Fabrikam's environment grows from within the Basic capacity to 1,000 configuration resources that need daily monitoring. The Basic daily limit covers 800 resources, leaving 200 resources outside the monitoring scope.

**Licensing decision:** Fabrikam can leave 200 resources unmonitored or add Premium licenses. Security and compliance stakeholders determine that all 1,000 resources need daily monitoring because they affect tenant security posture, audit readiness, and operational consistency.

**Licensing calculation:** Each Premium license adds capacity for 10 resources per day. The 200-resource shortfall requires 20 Premium licenses.

**Outcome:** The additional licenses let Fabrikam include all 1,000 resources in daily drift detection and reporting. No critical configurations are excluded, and the team maintains consistent drift visibility across the tenant.

#### Use Premium capacity for large monthly snapshots

**Situation:** Northwind already has Premium licensing and needs broader visibility than daily monitoring provides. Its identity team wants to capture more than the Basic monthly limit of 20,000 configuration resources for reporting, audit evidence, and operational review.

**Licensing calculation:** Northwind has 100 Premium licenses. At 35 additional resources per month for each license, these licenses add capacity for 3,500 resources. Northwind can capture up to 23,500 configuration resources each month.

**How Northwind uses the capacity:** The team includes security policies, identity settings, role configurations, and other tenant resources in its snapshot scope. It schedules recurring snapshot jobs to preserve historical configuration data, compare how configurations change over time, and identify unexpected or risky changes.

**Outcome:** Northwind supports large-scale monthly configuration extraction and uses the historical data for audit, governance, and operational analysis.

### Governance relationships

Governance relationship licenses are required only in the governing tenant. The governed tenant doesn't need licenses. For example, when a service provider establishes a governance relationship with a customer, only administrators in the service provider tenant who configure the relationship need licenses.

Cross-tenant delegated administration requires Microsoft Entra P1, Microsoft Entra P2, or Microsoft Entra ID Governance. Custom multitenant application provisioning requires Microsoft Entra ID Governance.

One license is required for each administrator who configures governance relationships. The number of relationships doesn't affect the license count.

| Scenario | Calculation | Number of licenses |
|---|---|---|
| One service provider administrator configures governance relationships with five customer tenants. | One license for the administrator who configures the relationships. The number of relationships and customer tenants doesn't add license requirements. | 1 |
| Three service provider administrators each configure cross-tenant delegated administration relationships with customers. | One license for each configuring administrator. | 3 |
| One administrator configures multitenant application provisioning from an organization's governing tenant. | One Microsoft Entra ID Governance license for the configuring administrator. The governed tenants don't need licenses. | 1 |

### Related tenants

One administrator enables Related tenants discovery for the tenant. After discovery is enabled, every administrator who uses Related tenants needs a license, whether they view results, trigger a refresh, or act on signals. The administrator who enables discovery also needs a license because they use the feature.

| Scenario | Calculation | Number of licenses |
|---|---|---|
| Woodgrove Bank has 12 administrators. One administrator enables Related tenants discovery and is the only administrator who uses the results. | One license for the administrator who enables and uses Related tenants. | 1 |
| Contoso has 30 administrators. Five administrators use Related tenants after one of them enables discovery. Three trigger refreshes and act on signals, and two only view results. | One license for each of the five administrators who uses Related tenants. | 5 |
| Fabrikam has 50 administrators. Ten administrators use Related tenants, including the administrator who enables discovery, six who review signals, and three who only view results. | One license for each of the 10 administrators who uses Related tenants. Administrators who don't use the feature don't need licenses for it. | 10 |

### Secure tenant creation

Secure add-on tenant creation is available with Microsoft Entra Free for paid Microsoft customers. A premium Microsoft Entra license isn't required, but the customer's existing tenant must be associated with a paid Microsoft cloud subscription. Customers who use only a free tenant or trial subscription can't create more tenants from the Microsoft Entra admin center.

For more information about the general tenant creation requirements, see [Create a new tenant in Microsoft Entra ID](~/fundamentals/create-new-tenant.md).

## Related content

- [What is Microsoft Entra Tenant Governance?](overview.md)
- [Governance relationships](governance-relationships.md)
- [Microsoft Entra licensing](~/fundamentals/licensing.md)

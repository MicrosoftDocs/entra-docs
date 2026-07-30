---
title: Create a governed workforce tenant
titleSuffix: Microsoft Entra ID Governance
description: Learn how to securely create a governed Microsoft Entra workforce tenant and establish governance from your home tenant.
author: tafra00
ms.author: tafra00
ms.topic: how-to
ms.date: 07/29/2026
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1018
#customer intent: As an IT administrator, I want to create a governed workforce tenant so that my organization can manage it through a governance relationship.
---

# Create a governed workforce tenant

This article is for IT administrators who need to create an add-on tenant that is governed from an existing Microsoft Entra tenant. Review the prerequisites before you use the secure add-on tenant creation flow.

When you create a tenant using the **Governed Workforce** option in the Microsoft Entra admin center, the secure add-on tenant creation flow automatically:

- Creates the new workforce tenant
- Establishes a [governance relationship](governance-relationships.md) between your home tenant and the new tenant based on your [governance policy template](governance-policy-templates.md)
- Provisions a Microsoft Entra ID Free [billing asset](signals-metrics.md) under your selected Azure subscription and resource group

This article doesn't cover creating an external tenant configuration for consumer-facing apps. For customer identity and access management scenarios, see [Microsoft Entra External ID for customers](~/external-id/customers/overview-customers-ciam.md).

## Prerequisites

Before you create a governed workforce tenant, confirm that you meet these requirements:

- Your organization is a paid customer. Customers using a free tenant or trial subscription can't create additional tenants from the Microsoft Entra admin center. If you need a new tenant, sign up for a [free Azure account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).
- Your selected Azure subscription is associated with an [Enterprise Agreement (EA)](/azure/cost-management-billing/manage/understand-ea-roles) or [pay-as-you-go](https://azure.microsoft.com/pricing/offers/ms-azr-0003p?cid=msft_learn) billing account. Legacy and modern billing experiences are supported. To identify your billing account type, see [View your billing accounts in the Azure portal](/azure/cost-management-billing/manage/view-all-accounts).
- Your Microsoft Entra tenant allows member users to create add-on tenants. If [**Restrict non-admin users from creating tenants**](~/fundamentals/users-default-permissions.md#restrict-member-users-default-permissions) is set to **Yes**, your account needs the [Tenant Creator](~/identity/role-based-access-control/permissions-reference.md#tenant-creator) role.
- You have the required permissions for the selected subscription through the **Tenant Contributor** or **Subscription Owner/Creator** role.
- The governing tenant has a configured **default** [governance policy template](governance-policy-templates.md). The tenant creation service uses only the default template (ID: `default`). If the default template isn't defined, the secure add-on tenant creation flow doesn't establish a governance relationship, even if other templates exist.

## Create the tenant

For step-by-step instructions on creating a governed workforce tenant, see the **Governed Workforce** tab in [Quickstart: Create a new tenant in Microsoft Entra ID](~/fundamentals/create-new-tenant.md).

## What happens after tenant creation

After the system creates the tenant:

1. A governance relationship forms between your home tenant and the new tenant, using the [default governance policy template](governance-policy-templates.md).
1. The policy template provisions resources including cross-tenant access settings, granular delegated admin privileges (GDAP) assignments, and service principals.
1. A Microsoft Entra ID Free billing asset appears in your Azure subscription under the resource group you selected.
1. The new tenant appears in your [related tenants](related-tenants.md) inventory.

To learn more about governance relationships and policy templates, see [Governance relationships](governance-relationships.md) and [Governance policy templates](governance-policy-templates.md).

## Related content

- [Tenant governance overview](overview.md)
- [Governance relationships](governance-relationships.md)
- [Governance policy templates](governance-policy-templates.md)
- [Quickstart: Create a new tenant in Microsoft Entra ID](~/fundamentals/create-new-tenant.md)

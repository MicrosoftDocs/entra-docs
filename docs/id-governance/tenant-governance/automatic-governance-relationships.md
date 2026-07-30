---
title: Automatic formation of governance relationships
titleSuffix: Microsoft Entra ID Governance
description: Learn how Microsoft Entra Tenant Governance automatically establishes governance relationships when you create add-on tenants using secure tenant creation.
ms.topic: concept-article
ms.date: 07/29/2026
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1018
---

# Automatic formation of governance relationships

When a permissioned user in your organization creates a new tenant using the secure add-on tenant creation feature, Microsoft Entra can automatically establish a governance relationship to the newly created tenant on your behalf.

If you defined a default [governance policy template](governance-policy-templates.md), a new governance relationship forms between the home (governing) tenant and the newly created add-on (governed) tenant, using the default policy template.

If roles and permissions haven't been defined in the default governance policy template, a governance relationship won't be established when a new add-on tenant is created. Changes to the template don't affect governance relationships that have already been established.

## Microsoft Entra ID Free billing asset

When you create a new Microsoft Entra tenant using the secure add-on tenant creation feature, you're prompted to select an existing paid Azure subscription and resource group. The subscription must be associated with an [Enterprise Agreement (EA)](/azure/cost-management-billing/manage/understand-ea-roles) or [pay-as-you-go](https://azure.microsoft.com/pricing/offers/ms-azr-0003p?cid=msft_learn) billing account. Legacy and modern billing experiences are supported. To identify your billing account type, see [View your billing accounts in the Azure portal](/azure/cost-management-billing/manage/view-all-accounts). For information about creating a subscription under a Microsoft Customer Agreement (MCA) billing account, see [Create a Microsoft Customer Agreement subscription](/azure/cost-management-billing/manage/create-subscription). When you create your new tenant, Microsoft generates a new billing asset called **Entra ID Free** under the selected subscription and resource group, which links to the newly created tenant.

The subscription tracks new tenants created with the same billing account, allowing you to maintain an inventory of all new tenants. The subscription also helps prove tenant ownership and helps regain administrative access if you ever lose it. To learn more, see [Microsoft Entra ID Free](/azure/cost-management-billing/manage/microsoft-entra-id-free).

## Related content

- [Governance relationships](governance-relationships.md)
- [Governance policy templates](governance-policy-templates.md)
- [Create a governed workforce tenant](how-to-create-tenant.md)

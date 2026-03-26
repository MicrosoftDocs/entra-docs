---
title: Automatic formation of governance relationships (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn how Microsoft Entra Tenant Governance automatically establishes governance relationships when you create add-on tenants using secure tenant creation.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/26/2026
ai-usage: ai-assisted
---

# Automatic formation of governance relationships (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

When a permissioned user in your organization creates a new tenant using the secure add-on tenant creation feature, Microsoft Entra can automatically establish a governance relationship to the newly created tenant on your behalf.

If you defined a default [governance policy template](governance-policy-templates.md), a new governance relationship forms between the home (governing) tenant and the newly created add-on (governed) tenant, using the default policy template.

If you want to disable this functionality, delete the contents of the default governance policy template.

## Microsoft Entra ID Free billing asset

When you create a new Microsoft Entra tenant using the secure add-on tenant creation feature, you're prompted to select an existing [Microsoft Customer Agreement (MCA) subscription](/azure/cost-management-billing/manage/create-subscription) and resource group from your billing account. When you create your new tenant, Microsoft generates a new billing asset called **Entra ID Free** under that subscription and resource group, which links to the newly created tenant.

The subscription tracks new tenants created with the same billing account, allowing you to maintain an inventory of all new tenants. The subscription also helps prove tenant ownership and helps regain administrative access if you ever lose it. To learn more, see [Microsoft Entra ID Free](/azure/cost-management-billing/manage/microsoft-entra-id-free).

## Related content

- [Governance relationships](governance-relationships.md)
- [Governance policy templates](governance-policy-templates.md)
- [Create a governed workforce tenant](how-to-create-tenant.md)

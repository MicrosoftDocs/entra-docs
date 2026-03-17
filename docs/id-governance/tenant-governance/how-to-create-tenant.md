---
title: Create a governed workforce tenant (preview)
description: Learn how to create a new Microsoft Entra tenant using the secure add-on tenant creation workflow in Tenant Governance.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/12/2026
---

# Create a governed workforce tenant (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

When you create a tenant using the **Governed Workforce** option in the Microsoft Entra admin center, the secure add-on tenant creation flow automatically:

- Creates the new workforce tenant
- Establishes a [governance relationship](governance-relationships.md) between your home tenant and the new tenant based on your [governance policy template](governance-policy-templates.md)
- Provisions a Microsoft Entra ID Free [billing asset](signals-metrics.md) under your selected Azure subscription and resource group

## Prerequisites

- You must have at least **Tenant Contributor** permissions on at least one Microsoft Customer Agreement (MCA) subscription.
- Enterprise Agreement (EA) subscriptions aren't supported.
- The **default** [governance policy template](governance-policy-templates.md) must be configured in the governing tenant. The tenant creation service uses only the default template (ID: `default`). If the default template isn't defined, the secure add-on tenant creation flow doesn't establish a governance relationship, even if other templates exist.

## Create the tenant

For step-by-step instructions on creating a governed workforce tenant, see the **Governed Workforce** tab in [Quickstart: Create a new tenant in Microsoft Entra ID](~/fundamentals/create-new-tenant.md).

## What happens after tenant creation

After the system creates the tenant:

1. A governance relationship forms between your home tenant and the new tenant, using the [default governance policy template](governance-policy-templates.md).
1. The policy template provisions resources including cross-tenant access settings, granular delegated admin privileges (GDAP) assignments, and service principals.
1. A Microsoft Entra ID Free billing asset appears in your Azure subscription under the resource group you selected.
1. The new tenant appears in your [related tenants](related-tenants.md) inventory.

To learn more about what the secure add-on tenant creation flow configures, see [Secure add-on tenant creation](tenant-creation-settings.md).

## Related content

- [Tenant governance overview](overview.md)
- [Governance relationships](governance-relationships.md)
- [Governance policy templates](governance-policy-templates.md)
- [Quickstart: Create a new tenant in Microsoft Entra ID](~/fundamentals/create-new-tenant.md)

---
title: Enable tenant discovery (preview)
description: Learn how to enable tenant discovery in Microsoft Entra Tenant Governance to identify related tenants across your organization
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: [How-to] Enable tenant discovery.docx -->

# Enable tenant discovery (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

Related tenants help administrators discover other Microsoft Entra tenants that have observable relationships with their tenant. Microsoft Entra infers these relationships from activity signals such as B2B collaboration, multitenant application consent, and shared billing accounts. A related tenant doesn't imply ownership or administrative control. It indicates an observed association across Microsoft services.

After you enable related tenant discovery, it remains enabled for your tenant if your tenant meets the licensing requirements.

## Prerequisites

Before you enable related tenants, make sure:

- You have the necessary permissions to enable related tenants. You must hold either the Tenant Governance Administrator or Global Administrator Microsoft Entra role.

- Your tenant is eligible for related tenants with the correct license.

- You understand that this setting isn't a toggle and remains enabled after you turn it on.

## Enable related tenants through the Microsoft Entra admin center

Use this option to enable discovery through the admin center rather than APIs.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a **Tenant Governance Administrator**.

1. Browse to **Tenant Governance** > **Related tenants**.

1. Review the description of enabling related tenants.

1. Select **Discover related tenants**.

After you enable the setting, Microsoft Entra begins aggregating discovery signals and surfaces related tenants in the admin center. The discovery data is synthesized from existing activity and might take time to populate.

## Enable related tenants through Microsoft Graph API

Use this option to enable discovery through scripts or automation.

**Endpoint**

```http
POST /directory/tenantGovernance/settings/enableRelatedTenants
```

This action enables related tenant discovery for the calling tenant.

**Important notes**

- The setting defaults to `false` for new tenants.

- After you enable the setting, `isRelatedTenantsEnabled` changes to `true` and can't be reverted.

## Next steps

After related tenants appear, take any of these actions:

- [Review the list of related tenants](related-tenants.md) surfaced by discovery.
- [Interpret tenant discovery data](how-to-interpret-discovery-data.md) to classify and prioritize related tenants.
- Use the data to inform governance decisions:
  - [Set up governance relationships](how-to-setup-governance-relationship.md) with discovered tenants.
  - Plan tenant inventory and cleanup efforts.
  - [Learn more about Tenant Governance](overview.md) and configuration management planning.

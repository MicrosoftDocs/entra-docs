---
title: Enable tenant discovery (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn how to enable tenant discovery in Microsoft Entra tenant governance to identify related tenants across your organization
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: [How-to] Enable tenant discovery.docx -->

# Enable tenant discovery (preview)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Related tenants help administrators discover other Microsoft Entra tenants that have observable relationships with their tenant. These relationships are inferred from activity signals such as B2B collaboration, multitenant application consent, and shared billing accounts. A related tenant doesn't imply ownership or administrative control. It simply indicates an observed association across Microsoft services.

After you enable related tenant discovery, it remains enabled for your tenant if your tenant meets the licensing requirements.

## Prerequisites

Before enabling related tenants, ensure:

- You have the necessary permissions to enable related tenants. You must hold either the Tenant Governance Administrator or Global Administrator Microsoft Entra role.

- Your tenant is eligible for related tenants with the correct license.

- You understand that this setting isn't a toggle and remains enabled after you turn it on.

## Enable related tenants through the Microsoft Entra admin center

Use this option to enable discovery through the admin center rather than APIs.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Tenant Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#tenant-governance-administrator).

1. Browse to **Tenant governance** > **Related tenants**.

1. Review the description of enabling related tenants.

1. Select **Discover related tenants**.

After you enable the setting, Microsoft Entra begins aggregating discovery signals and surfaces related tenants in the experience. The discovery data is synthesized from existing activity and might take time to populate.

## Enable related tenants through Microsoft Graph API

Use this option for scripted or automated enablement.

**Endpoint**

```http
POST /directory/tenantGovernance/settings/enableRelatedTenants
```

This action enables related tenant discovery for the calling tenant.

**Important notes**

- The setting defaults to `false` for new tenants.

- After you enable the setting, `isRelatedTenantsEnabled` is set to `true` and can't be reverted.

## Next steps

After related tenants appear, you can:

- [Review the list of related tenants](related-tenants.md) surfaced by discovery.
- Use the data to inform governance decisions:
  - [Set up governance relationships](how-to-setup-governance-relationship.md) with discovered tenants.
  - Plan tenant inventory and cleanup efforts.
  - [Learn more about tenant governance](overview.md) and configuration management planning.

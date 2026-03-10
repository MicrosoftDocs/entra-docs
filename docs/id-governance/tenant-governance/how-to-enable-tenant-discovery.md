---
title: Enable tenant discovery
titleSuffix: Microsoft Entra ID Governance
description: Learn how to enable tenant discovery in Microsoft Entra tenant governance to identify related tenants across your organization
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: [How-to] Enable tenant discovery.docx -->

# Enable tenant discovery

Related tenants help administrators discover other Microsoft Entra tenants that have observable relationships with their tenant. These relationships are inferred from activity signals such as B2B collaboration, multitenant application consent, and shared billing accounts. A related tenant does not imply ownership or administrative control, it simply indicates an observed association across Microsoft services.

Once enabled, related tenant discovery will remain enabled for your tenant provided your tenant holds the proper licensing requirements.

## Prerequisites

Before enabling related tenants, ensure:

- You have the necessary permissions to enable related tenants. User must hold either the Tenant Governance Administrator or Global Administrator Entra role.

- Your tenant is eligible for Related Tenants with the correct license.

- You understand that this is not a toggle and will remain enabled.

## Enable Related Tenants via Microsoft Entra Admin Center (UX)

Use this option if you want to enable discovery through the admin experience rather than APIs.

1. Sign in to the **Microsoft Entra admin center**.

1. Navigate to **Tenant Governance**.

1. Open **Related tenants**

1. Review the description of enabling related tenants.

1. Select **Discover related tenants**.

Once enabled, Microsoft Entra begins aggregating discovery signals and surfaces related tenants in the experience. The discovery data is synthesized from existing activity and may take time to populate.

## Enable Related Tenants via Microsoft Graph API

Use this option for scripted or automated enablement.

**Endpoint**

```http
POST /directory/tenantGovernance/settings/enableRelatedTenants
```

This action enables related tenant discovery for the calling tenant.

**Important Notes**

- The setting defaults to false for new tenants.

- Once enabled, ``isRelatedTenantsEnabled`` is set to true and cannot be reverted.

## Next steps

Once related tenants are visible, administrators can:

- Review the **list of related tenants** surfaced by discovery.

- Use the data to inform:

  - Governance relationship invitations

  - Tenant inventory and cleanup efforts

  - Configuration management planning

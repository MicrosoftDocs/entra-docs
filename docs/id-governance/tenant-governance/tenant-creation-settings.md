---
title: Secure add-on tenant creation (preview)
description: Learn how secure add-on tenant creation automatically establishes governance relationships and billing assets for new Microsoft Entra tenants.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/12/2026
---

<!-- source: concept guide -- automatic formation of governance relationships.docx -->

# Secure add-on tenant creation (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

Secure add-on tenant creation lets you create new Microsoft Entra tenants that are governed from the start. When you create an add-on tenant from an existing tenant, Tenant Governance automatically establishes a governance relationship and creates a billing asset that links the new tenant to your billing account. The feature is part of the broader [Tenant Governance](governance-relationships.md) capability in Microsoft Entra ID Governance.

## How secure add-on tenant creation works

The secure add-on tenant creation process combines governance and billing in a single operation. The end-to-end flow works as follows:

1. An authorized user in your organization creates a new tenant by using the secure add-on tenant creation feature.

1. During creation, the user selects an existing Microsoft Customer Agreement (MCA) subscription and resource group from the billing account.

1. If the default governance policy template has been configured, Tenant Governance automatically establishes a governance relationship between the home (governing) tenant and the newly created add-on (governed) tenant. If the default policy template hasn't been configured, no governance relationship is established and the tenant is created without centralized governance controls.

1. Microsoft generates a new billing asset called "Microsoft Entra ID Free" under the selected subscription and resource group, linking it to the new tenant.

The new tenant is immediately under centralized administration with a traceable billing relationship. Automatic governance reduces the risk of unmanaged or misconfigured tenants in your organization.

## Automatic formation of governance relationships

When you create a new add-on tenant, Tenant Governance automatically establishes a [governance relationship](governance-relationships.md) between the parent tenant and the new tenant. A governance relationship is a directional connection where one tenant (the governing tenant) governs another tenant (the governed tenant). Automatic formation brings newly created tenants under centralized administration and governance controls without any extra steps.

### Default policy template

The automatic governance relationship uses the [default governance policy template](governance-policy-templates.md). This special template is designed specifically for secure tenant creation scenarios. Unlike standard templates that use a GUID as an identifier, the default policy template has an ID of `default`. You must configure the default policy template before you can use it for secure add-on tenant creation.

A governance policy template serves as a blueprint for governance relationships and defines two key areas:

- **Cross-tenant delegated administration roles**: Specify which Microsoft Entra built-in roles users from the governing tenant have in the governed tenant.
- **Multi-tenant applications**: Select custom applications to create and manage across tenants.

If you want to disable the automatic formation of governance relationships, delete the contents of the default governance policy template.

### Resources provisioned automatically

When Tenant Governance creates the governance relationship, it provisions these resources:

- A governance relationship object in both the governing and governed tenants.
- Cross-tenant access configuration updates in the governed tenant.
- Granular delegated administrative privilege (GDAP) role assignments in the governed tenant, if delegated administration is configured in the default policy template.
- Service principals for multi-tenant applications in the governed tenant, if multi-tenant application management is configured in the default policy template.

### Policy snapshots

When Tenant Governance creates the governance relationship, it captures and stores a policy snapshot with the relationship. The snapshot represents the roles and permissions that applied at the time of creation. Updating the default governance policy template later doesn't automatically update existing relationships. To apply permission updates to an active relationship, you must repeat the request and approval process.

## Microsoft Entra ID Free billing asset

When you create a new Microsoft Entra tenant by using the secure add-on tenant creation feature, you're prompted to select an existing MCA subscription and resource group from your billing account. During creation, Microsoft generates a new billing asset called "Microsoft Entra ID Free" under that subscription and resource group. The billing asset links directly to the newly created tenant.

### Inventory tracking and ownership proof

The subscription tracks all new tenants created with the same billing account, giving you a centralized inventory of add-on tenants. The billing relationship also serves as proof of tenant ownership and can help you regain administrative access if you ever lose it.

### Billing signal for tenant discovery

The shared billing account creates a [billing signal](signals-metrics.md) that Tenant Governance uses for [tenant discovery](related-tenants.md). Shared billing account signals identify tenants connected through one or more shared billing accounts based on the concept of primary and associated billing tenants in Azure MCA enterprise billing accounts. The billing signal is a strong indicator of internal ownership or alignment and often correlates with centrally funded environments.

### MCA requirement

Secure add-on tenant creation requires a Microsoft Customer Agreement (MCA) enterprise billing account. Enterprise Agreement (EA) and legacy commerce constructs aren't supported at this time.

## Related content

- [Governance relationships](governance-relationships.md)
- [Governance policy templates](governance-policy-templates.md)
- [Set up a governance relationship](how-to-setup-governance-relationship.md)
- [Related tenants](related-tenants.md)
- [Microsoft Entra ID Free - Microsoft Cost Management](/azure/cost-management-billing/manage/microsoft-entra-id-free)

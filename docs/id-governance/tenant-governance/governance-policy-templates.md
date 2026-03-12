---
title: Governance policy templates (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn about governance policy templates and how to use them to enforce consistent governance across tenants in Microsoft Entra
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/10/2026
---

<!-- source: Governance policy templates.docx -->

# Governance policy templates (preview)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Governance policy templates are a foundational component of the Tenant governance service, which helps organizations secure Microsoft Entra tenants at scale. Before establishing a governance relationship between tenants, you must create a governance policy template that defines the relationship behavior. These templates are reusable across distinct governance relationships, enabling consistent and scalable management of cross-tenant access.

## How governance policy templates work

A governance policy template serves as a blueprint for governance relationships. When you create a template, you define two key areas of access:

- Cross-tenant delegated administration roles - Specify which Microsoft Entra built-in roles users from the governing tenant have in the governed tenant.

- Multi-tenant applications - Select custom applications to create and manage across tenants.

Once created, you can use the same template to establish multiple governance relationships with different governed tenants, ensuring consistent access policies across your organization.

When you create a governance relationship, the system captures and stores a policy snapshot with the relationship. This snapshot represents the roles and permissions that applied at the time you established or last updated the relationship.

Updating a governance policy template doesn't automatically update relationships that you created using that template. This design ensures that the governed tenant always has the opportunity to review desired permission changes for the relationship. To apply permission updates to an active relationship, you must repeat the request and approval process.

## Cross-tenant delegated administration configuration

By selecting Microsoft Entra built-in roles and assigning them to a group in the governing tenant, you define which roles (and level of access) users in that group have in the governed tenant. With these roles, users can:

- Sign in to the governed tenant using their governing tenant credentials.

- Manage the governed tenant without needing a local or B2B account in that tenant.

Each group can have multiple role assignments, and each policy template can have multiple groups defined. When you create the governance relationship, the system creates [GDAP (Granular delegated administrative privilege)](/partner-center/customers/gdap-introduction) role assignments in the governed tenant.

## Multi-tenant application configuration

By selecting custom, multi-tenant applications in the policy template, you enable centralized application management. When you create the governance relationship, the system creates a service principal with the same permissions in the governed tenant.

This capability allows you to manage your custom, multi-tenant applications at scale from the central governing tenant. You don't need to go into every tenant individually to monitor and maintain least privileged app access. For example, say you've built a custom line of business app—Contoso Resource Manager—responsible for monitoring, reporting, and automating resource configuration across your tenants. You can use the governance relationship to set up a service principal instance of Contoso Resource Manager across your governed tenants, with the right provisioned permissions consented. When you need to add or remove permissions, you can do so through the governance relationship instead of making changes and consenting to permissions on a per-tenant basis.

## Default policy template

The default policy template is a special template used for secure tenant creation scenarios. When you create a new add-on tenant, the system automatically establishes a governance relationship between the parent tenant and the add-on tenant using the default policy template. This setup ensures that new tenants immediately come under centralized tenant administration from the start.

The default policy template has the following characteristics:

- Unique identifier - Instead of a GUID, the default policy template has an ID of "default."

- Configuration required - You must configure the default policy template before you can use it.

## Related content

- [Governance relationships](governance-relationships.md)
- [Set up a governance relationship](how-to-setup-governance-relationship.md)
- [Cross-tenant delegated administration](cross-tenant-delegated-administration.md)

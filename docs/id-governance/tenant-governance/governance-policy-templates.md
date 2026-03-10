---
title: Governance policy templates
titleSuffix: Microsoft Entra ID Governance
description: Learn about governance policy templates and how to use them to enforce consistent governance across tenants in Microsoft Entra
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/10/2026
---

<!-- source: Governance policy templates.docx -->

# Governance policy templates

Governance policy templates are a foundational component of the Tenant governance service, which helps organizations secure Microsoft Entra tenants at scale. Before establishing a governance relationship between tenants, you must create a governance policy template that will define the relationship behavior. These templates are reusable across distinct governance relationships, enabling consistent and scalable management of cross-tenant access.

## How governance policy templates work

A governance policy template serves as a blueprint for governance relationships. When you create a template, you define two key areas of access:

- Cross tenant delegated administration roles - Specify which Entra built-in roles users from the governing tenant will have in the governed tenant

- Multi-tenant applications - Select custom applications to create and manage across tenants

Once created, you can use the same template to establish multiple governance relationships with different governed tenants, ensuring consistent access policies across your organization.

When a governance relationship is created, a policy snapshot is captured and stored with the relationship. This snapshot represents the roles and permissions that were applied at the time the relationship was established or last updated.

Updating a governance policy template does not automatically update relationships that were created using that template. This is to ensure that the governed tenant always has the opportunity to review permission changes desired for the relationship. To apply permission updates to an active relationship, you must repeat the request and approval process.

## Cross tenant delegated administration configuration

By selecting Entra built-in roles and assigning them to a group in the governing tenant, you define which roles (and level of access) users in that group have in the governed tenant. With these roles, users can:

- Sign in to the governed tenant using their governing tenant credentials

- Manage the governed tenant without needing a local or B2B account in that tenant

Each group can have multiple role assignments, and each policy template can have multiple groups defined. When the governance relationship is created, [GDAP (Granular delegated administrative privilege)](/partner-center/customers/gdap-introduction) role assignments are created in the governed tenant.

## Multi-tenant application configuration

By selecting custom, multi-tenant applications in the policy template, you enable centralized application management. When the governance relationship is created, a service principal with the same permissions is created in the governed tenant.

This capability allows you to manage your custom, multi-tenant applications at scale from the central governing tenant, rather than going into every tenant individually to monitor and maintain least privileged app access. For example, let's say that you've built a custom line of business app -- Contoso Resource Manager -- that is responsible for monitoring, reporting, and automating resource configuration across your tenants. You can leverage the governance relationship to setup a service principal instance of Contoso Resource Manager across your governed tenants, with the right provisioned permissions consented to. When you need to add or remove permissions, you can do so through the governance relationship, instead of making changes and consenting to permissions on a per tenant basis.

## Default policy template

The default policy template is a special template used for secure tenant creation scenarios. When a new add-on tenant is created, a governance relationship is automatically established between the parent tenant and the add-on tenant using the default policy template. This ensures that newly created tenants are immediately brought under centralized tenant administration from the start.

The default policy template has the following characteristics:

- Unique identifier - Instead of a GUID, the default policy template has an ID of "default"

- Configuration required - The default policy template must be configured before it can be used

## Related content

- [Governance relationships](governance-relationships.md)
- [Set up a governance relationship](how-to-setup-governance-relationship.md)
- [Cross-tenant delegated administration](cross-tenant-delegated-administration.md)

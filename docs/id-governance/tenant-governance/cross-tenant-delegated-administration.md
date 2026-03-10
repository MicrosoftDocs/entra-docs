---
title: Cross-tenant delegated administration
titleSuffix: Microsoft Entra ID Governance
description: Learn about cross-tenant delegated administration and how it enables centralized management across tenants in Microsoft Entra
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/10/2026
---

<!-- source: Cross-tenant delegated administration.docx -->

# Cross-tenant delegated administration

Cross tenant delegated administration is a capability within Tenant governance that enables administrators to monitor and manage multiple tenants using accounts from a central governing tenant, without creating local or guest (B2B) accounts in every governed tenant. This capability uses granular delegated admin privileges (GDAP) technology to provide secure, least-privileged access across tenant boundaries.

Before you can use cross tenant delegated administration, you must first create a governance relationship between the governing tenant and each governed tenant. The governance relationship establishes the trust boundary and defines the delegated administration policies that control which roles and permissions are available to governing tenant administrators.

Cross tenant delegated administration also gives governed tenants full visibility into governing tenant admin activity within their environment. All actions performed by delegated administrators are captured in the governed tenant's sign-in and audit logs, ensuring that governed tenant stakeholders can independently monitor, review, and audit administrative operations carried out on their behalf.

## How cross-tenant delegated administration works

Cross tenant delegated administration leverages GDAP technology, the same technology that Partner Center uses to enable partners to administer customer tenants. With this capability:

- Administrators sign in with their governing tenant credentials to access governed tenants

- No local or B2B accounts are required in the governed tenants

- Access and permissions are managed centrally from the governing tenant

- Role assignments follow the principle of least privilege

When a governance relationship is established with delegated administration configured, GDAP role assignments are created in the governed tenant. These role assignments allow designated users from the governing tenant to perform administrative tasks based on the roles defined in the governance policy template.

## Key components

### Governance policy template

The governance policy template defines which Entra built-in roles are enabled for delegated administration. When creating a template, you:

- Select the Entra built-in role(s) to assign

- Assign each role to a security group in the governing tenant

Each group can have multiple role assignments, and each policy template can have multiple groups defined.

## GDAP role assignments

GDAP role assignments are cross tenant role assignments that allow users from the governing tenant to sign in and manage a governed tenant. These assignments are created automatically in the governed tenant when a governance relationship with delegated administration is established.

## Benefits

Cross tenant delegated administration provides several advantages for organizations managing multiple tenants:

- Centralized access management: Manage permissions and access from a single governing tenant rather than configuring access in each individual tenant

- Reduced account sprawl: Eliminate the need for local or B2B accounts across multiple tenants

- Least privilege access: Define specific roles and permissions for delegated administrators

- Scalability: Manage hundreds or thousands of tenants using the same technology that powers Partner Center

- Audit trail: Track governing tenant admin activity in governed tenant sign-in and audit logs

## Related content

- [Set up a governance relationship](how-to-setup-governance-relationship.md)
- [Use delegated administration](how-to-delegated-administration.md)
- [Governance policy templates](governance-policy-templates.md)

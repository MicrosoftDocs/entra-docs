---
title: Update a governance relationship (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn how to update an existing governance relationship between a governing and governed tenant in Microsoft Entra tenant governance
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: How to update a governance relationship.docx -->

# Update a governance relationship (preview)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes how to update an existing governance relationship between a governing tenant and a governed tenant. You might need to update a governance relationship to add or modify delegated administration roles or multi-tenant application configurations.

## Prerequisites
- You must have an active governance relationship between a governing tenant and a governed tenant.

- You must have access to the governance policy template you used to create the existing relationship. If you deleted the policy template, you need to create a new relationship.

- Review role requirements in [Tenant governance roles](/entra/identity/role-based-access-control/permissions-reference#tenant-governance-administrator).

- Review license requirements for sending governance requests in [Tenant governance licensing](licensing.md).

## Update the governance policy template
Before you can update a governance relationship, you must first modify the governance policy template you used to establish the existing relationship. When you update the template, its version number automatically increments by one.

1. Sign in to the governing tenant as an admin.

1. Navigate to the governance policy template you previously used to set up the relationship.

1. Modify the template as needed. You can update one or more of the following configurations:

    - **Delegated administration roles**: Add or change the Microsoft Entra built-in roles assigned to security groups in the governing tenant. These roles determine the access level that users in those groups have when they sign in to the governed tenant.

    - **Multi-tenant application management**: Add or update custom, multi-tenant applications. When you update the relationship, the system creates or updates a service principal with the corresponding permissions in the governed tenant.

1. Save the updated governance policy template. The version number of the template increments by one.

> [!NOTE]
> Updating the governance policy template doesn't automatically update the governance relationship. The tenant admins must complete the governance request and approval process described in the following sections for the policy template changes to take effect.

## Send a new governance request with the updated template
After updating the governance policy template, send a new governance request from the governing tenant to the governed tenant using the updated template.

1. In the governing tenant, create a new governance request.

1. Select the governed tenant that has the existing relationship you want to update.

1. Select the updated governance policy template.

1. Submit the governance request. The governed tenant receives an email notification about the new governance request.

## Accept the governance request
An admin in the governed tenant must accept the governance request to complete the update.

1. Sign in to the governed tenant as an admin.

1. Navigate to the pending governance requests.

1. Review the updated governance request, including the changes in the policy template.

1. Accept the governance request. The system updates the existing governance relationship with the new policy template configuration. The governing tenant receives an email confirming the accepted request and the updated governance relationship.

When the governed tenant accepts the governance request, the following changes take effect:

- The system updates the policy snapshot of the existing governance relationship to reflect the latest version of the policy template.

- If you updated delegated administration roles, the system updates the GDAP role assignments in the governed tenant accordingly.

- If you updated multi-tenant application management, the system updates the corresponding service principal and its permissions in the governed tenant.

## Related content
- [Set up a governance relationship](how-to-setup-governance-relationship.md)

- [Terminate a governance relationship](how-to-terminate-governance-relationship.md)

- [Governance policy templates](governance-policy-templates.md)

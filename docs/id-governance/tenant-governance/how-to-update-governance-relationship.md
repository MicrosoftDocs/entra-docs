---
title: Update a governance relationship
description: Learn how to update an existing governance relationship in Microsoft Entra tenant governance.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: How to update a governance relationship.docx -->

# Update a governance relationship

This article describes how to update an existing governance relationship between a governing tenant and a governed tenant. You might need to update a governance relationship to add or modify delegated administration roles or multi-tenant application configurations.

## Prerequisites
- You must have an active governance relationship between a governing tenant and a governed tenant.

- You must have access to the governance policy template that was used to create the existing relationship. If the policy template has been deleted, you will need to create a new relationship.

- Review role requirements in [Tenant governance roles](https://aka.ms/TenantGovernance/Roles).

- Review license requirements for sending governance requests in [Tenant governance licensing](https://aka.ms/TenantGovernance/Licensing).

## Update the governance policy template
Before you can update a governance relationship, you must first modify the governance policy template that was used to establish the existing relationship. When you update the template, its version number automatically increments by one.

1. Sign in to the governing tenant as an admin.

1. Navigate to the governance policy template that was previously used to set up the relationship.

1. Modify the template as needed. You can update one or more of the following configurations:

    - **Delegated administration roles**: Add or change the Entra built-in role(s) assigned to security groups in the governing tenant. These roles determine the level of access users in those groups have when signing in to the governed tenant.

    - **Multi-tenant application management**: Add or update custom, multi-tenant applications. When the relationship is updated, a service principal with the corresponding permissions is created or updated in the governed tenant.

1. Save the updated governance policy template. The version number of the template increments by one.

> [!NOTE]

> Updating the governance policy template does not automatically update the governance relationship. The tenant admins must complete the governance request and approval process described in the following sections for the policy template changes to take effect.

## Send a new governance request with the updated template
After updating the governance policy template, send a new governance request from the governing tenant to the governed tenant using the updated template.

1. In the governing tenant, create a new governance request.

1. Select the governed tenant that has the existing relationship you want to update.

1. Select the updated governance policy template.

1. Submit the governance request. The governed tenant receives an email notification that a new governance request has been received.

## Accept the governance request
An admin in the governed tenant must accept the governance request to complete the update.

1. Sign in to the governed tenant as an admin.

1. Navigate to the pending governance requests.

1. Review the updated governance request, including the changes in the policy template.

1. Accept the governance request. The existing governance relationship is updated with the new policy template configuration. The governing tenant receives an email notification that the request has been accepted and the governance relationship has been updated.

When the governance request is accepted, the following changes take effect in the governed tenant:

- The policy snapshot of the existing governance relationship is updated to reflect the latest version of the policy template.

- If delegated administration roles were updated, the GDAP role assignments are updated in the governed tenant accordingly.

- If multi-tenant application management was updated, the corresponding service principal and its permissions in the governed tenant are updated.

## Related content
- [Set up a governance relationship](how-to-setup-governance-relationship.md)

- [Terminate a governance relationship](how-to-terminate-governance-relationship.md)

- [Governance policy templates](governance-policy-templates.md)

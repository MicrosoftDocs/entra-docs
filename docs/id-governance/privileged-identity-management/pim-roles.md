---
title: Roles you cannot manage in Privileged Identity Management
description: Describes the roles you cannot manage in Microsoft Entra Privileged Identity Management (PIM).

author: barclayn
manager: amycolannino

ms.service: entra-id-governance
ms.topic: conceptual
ms.subservice: privileged-identity-management
ms.date: 11/28/2023
ms.author: barclayn
ms.reviewer: shaunliu
ms.custom: pim ; H1Hack27Feb2017;oldportal;it-pro;

---

# Roles you can't manage in Privileged Identity Management

You can manage just-in-time assignments to all [Microsoft Entra roles](~/identity/role-based-access-control/permissions-reference.md) and all [Azure roles](/azure/role-based-access-control/built-in-roles) using Privileged Identity Management (PIM) in Microsoft Entra ID. Azure roles include built-in and custom roles attached to your management groups, subscriptions, resource groups, and resources. However, there are a few roles that you can't manage. This article describes the roles you can't manage in Privileged Identity Management.

## Classic subscription administrator roles

You cannot manage the following classic subscription administrator roles in Privileged Identity Management:

- Account Administrator
- Service Administrator
- Co-Administrator

For more information about the classic subscription administrator roles, see [Azure roles, Microsoft Entra roles, and classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles).

## What about Microsoft 365 admin roles?

We support all Microsoft 365 roles in the Microsoft Entra roles and Administrators portal experience, such as Exchange Administrator and SharePoint Administrator, but we don't support specific roles within Exchange RBAC or SharePoint RBAC. For more information about these Microsoft 365 services, see [Microsoft 365 admin roles](/microsoft-365/admin/add-users/about-admin-roles).

> [!NOTE]
> For information about delays activating the Microsoft Entra Joined Device Local Administrator role, see [How to manage the local administrators group on Microsoft Entra joined devices](../../identity/devices/assign-local-admin.md#manage-the-microsoft-entra-joined-device-local-administrator-role).

## Next steps

- [Assign Microsoft Entra roles in Privileged Identity Management](pim-how-to-add-role-to-user.md)
- [Assign Azure resource roles in Privileged Identity Management](pim-resource-roles-assign-roles.md)

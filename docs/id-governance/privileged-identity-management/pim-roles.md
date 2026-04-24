---
title: Roles you can't manage in Privileged Identity Management
description: Describes the roles you can't manage in Microsoft Entra Privileged Identity
  Management (PIM).
ms.topic: concept-article
ms.date: 03/23/2026
ms.reviewer: shaunliu
---

# Roles you can't manage in Privileged Identity Management

> [!div class="op_single_selector"]
> - **Customer intent:** As an administrator, I want to understand which roles cannot be managed in PIM to plan my privileged access management strategy.

## Overview

You can manage just-in-time assignments to all [Microsoft Entra roles](~/identity/role-based-access-control/permissions-reference.md) and all [Azure roles](/azure/role-based-access-control/built-in-roles) using Privileged Identity Management (PIM) in Microsoft Entra ID. Azure roles include built-in and custom roles attached to your management groups, subscriptions, resource groups, and resources. However, there are a few roles that you can't manage. This article describes the roles you can't manage in Privileged Identity Management.

## Classic subscription administrator roles

You can't manage the following classic subscription administrator roles in Privileged Identity Management:

- Account Administrator
- Service Administrator
- Co-Administrator

For more information about the classic subscription administrator roles, see [Azure roles, Microsoft Entra roles, and classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles).

## What about Microsoft 365 admin roles?

PIM supports all Microsoft 365 roles in the Microsoft Entra roles and Administrators portal experience, such as Exchange Administrator and SharePoint Administrator, but PIM doesn't support specific roles within Exchange RBAC or SharePoint RBAC. For more information about these Microsoft 365 services, see [Microsoft 365 admin roles](/microsoft-365/admin/add-users/about-admin-roles).

> [!NOTE]
> For information about delays activating the Microsoft Entra Joined Device Local Administrator role, see [How to manage the local administrators group on Microsoft Entra joined devices](../../identity/devices/assign-local-admin.md#manage-the-microsoft-entra-joined-device-local-administrator-role).

> [!NOTE]
> Use [PIM for Microsoft Entra roles](pim-how-to-add-role-to-user.md) instead of PIM for Groups to provide just-in-time access to SharePoint, Exchange, or Microsoft Purview portal. For more information, see [Privileged Identity Management (PIM) for Groups](concept-pim-for-groups.md#make-a-group-of-users-eligible-for-a-microsoft-entra-role).

## Next steps

- [Assign Microsoft Entra roles in Privileged Identity Management](pim-how-to-add-role-to-user.md)
- [Assign Azure resource roles in Privileged Identity Management](pim-resource-roles-assign-roles.md)

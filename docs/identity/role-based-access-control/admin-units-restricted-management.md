---
title: Restricted management administrative units in Microsoft Entra ID (Preview)
description: Use restricted management administrative units for more sensitive resources in Microsoft Entra ID.
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.topic: conceptual
ms.subservice: role-based-access-control
ms.date: 05/24/2025
ms.author: barclayn
ms.custom: oldportal, it-pro;, sfi-ga-nochange
---

# Restricted management administrative units in Microsoft Entra ID (Preview)

> [!IMPORTANT]
> Restricted management administrative units are currently in PREVIEW.
> See the [Product Terms](https://aka.ms/EntraPreviewsTermsOfUse) for legal terms that apply to features that are in beta, preview, or otherwise not yet released into general availability.

Restricted management administrative units allow you to protect specific objects in your tenant from modification by anyone other than a specific set of administrators that you designate. This allows you to meet security or compliance requirements without having to remove tenant-level role assignments from your administrators.

## Why use restricted management administrative units?

Here are some reasons why you might use restricted management administrative units to help manage access in your tenant.

- You want to protect your C-level executive accounts and their devices from Helpdesk Administrators who would otherwise be able to reset their passwords or access BitLocker recovery keys. You can add your C-level user accounts in a restricted management administrative unit and enable a specific trusted set of administrators who can reset their passwords and access BitLocker recovery keys when needed.
- You're implementing a compliance control to ensure that certain resources can only be managed by administrators in a specific country/region. You can add those resources in a restricted management administrative unit and assign local administrators to manage those objects. Even Global Administrators won't be allowed to modify the objects unless they assign themselves explicitly to a role scoped to the restricted management administrative unit (which is an auditable event).
- You're using security groups to control access to sensitive applications in your organization, and you don't want to allow your tenant-scoped administrators who can modify groups to be able to control who can access the applications. You can add those security groups to a restricted management administrative unit and then be sure that only the specific administrators you assign can manage them.

> [!NOTE]
> Placing objects in restricted management administrative units severely restricts who can make changes to the objects. This restriction can cause existing workflows to break.

## What objects can be members?

Here are the objects that can be members of restricted management administrative units.

| Microsoft Entra object type | Administrative unit | Administrative unit with restricted management setting enabled |
| --- | :---: | :---: |
| Users | Yes | Yes |
| Devices | Yes | Yes |
| Groups (Security) | Yes | Yes |
| Groups (Microsoft 365) | Yes | No |
| Groups (Mail enabled security) | Yes | No |
| Groups (Distribution) | Yes | No |

## What types of operations are blocked?

For administrators not explicitly assigned at the restricted management administrative unit scope, operations that directly modify the Microsoft Entra properties of objects in restricted management administrative units are blocked, whereas operations on related objects in Microsoft 365 services aren't affected.

| Operation type | Blocked | Allowed |
| --- | :---: | :---: |
| Read standard properties like user principal name, user photo |  | :white_check_mark: |
| Modify any Microsoft Entra properties of the user, group, or device | :x: |  |
| Delete the user, group, or device | :x: |  |
| Update password for a user | :x: |  |
| Modify owners or members of the group in the restricted management administrative unit | :x: |  |
| Add users, groups, or devices in a restricted management administrative unit to groups in Microsoft Entra ID |  | :white_check_mark: |
| Modify email and mailbox settings in Exchange for the user in the restricted management administrative unit |  | :white_check_mark: |
| Apply policies to a device in a restricted management administrative unit using Intune |  | :white_check_mark: |
| Add or remove a group as a site owner in SharePoint |  | :white_check_mark: |
| Assign licenses and update the usage location of users in a restricted management administrative unit |  | :white_check_mark: |

## Who can modify objects?

Only administrators with an explicit assignment at the scope of a restricted management administrative unit can change the Microsoft Entra properties of objects in the restricted management administrative unit.

| User role | Blocked | Allowed |
| --- | :---: | :---: |
| Global Administrator | :x: |  |
| Tenant-scoped administrators (including Global Administrator) | :x: |  |
| Administrators assigned at the scope of restricted management administrative unit |  | :white_check_mark: |
| Administrators assigned at the scope of another restricted management administrative unit of which the object is a member |  | :white_check_mark: |
| Administrators assigned at the scope of another regular administrative unit of which the object is a member | :x: |  |
| Groups Administrator, User Administrator, and other role assigned at the scope of a resource | :x: |  |
| Owners of groups or devices added to restricted management administrative units | :x: |  |

## Limitations

Here are some of the limits and constraints for restricted management administrative units.

- The restricted management setting must be applied during administrative unit creation and can't be changed once the administrative unit is created.
- Groups and users in a restricted management administrative unit can't be managed with Microsoft Entra ID Governance features such as [Privileged Identity Management](../../id-governance/privileged-identity-management/groups-discover-groups.md), [Entitlement management](../../id-governance/entitlement-management-overview.md), [Lifecycle workflows](../../id-governance/what-are-lifecycle-workflows.md) and [Access reviews](../../id-governance/access-reviews-overview.md).
- When a group is configured to have public membership (by setting the [visibility](/graph/api/resources/group#properties) property to `Public`), users can join the group by using [self-service group membership](../users/groups-self-service-management.md). This configuration is not the default setting, and it is not recommended to configure groups in restricted management administrative units to allow for public membership. This is a temporary limitation and will be removed.
- Role-assignable groups, when added to a restricted management administrative unit, can't have their membership modified. Group owners aren't allowed to manage groups in restricted management administrative units and only Global Administrators and Privileged Role Administrators (neither of which can be assigned at administrative unit scope) can modify membership.
- Certain actions might not be possible when an object is in a restricted management administrative unit, if the required role isn't one of the roles that can be assigned at administrative unit scope. For example, a Global Administrator in a restricted management administrative unit can't have their password reset by any other administrator in the system, because there's no admin role that can be assigned at the administrative unit scope that can reset the password of a Global Administrator. In such scenarios, the Global Administrator would need to be removed from the restricted management administrative unit first, and then have their password reset by another Global Administrator or Privileged Role Administrator.
- When deleting a restricted management administrative unit, it can take up to 30 minutes to remove all protections from the former members.

## Programmability

Applications can't modify objects in restricted management administrative units by default. To grant an application access to manage objects in a restricted management administrative unit, you must assign a Microsoft Entra role to the application at the scope of the restricted management administrative unit. If you assign [Microsoft Graph application permissions](/graph/permissions-reference) to the application, those permissions won't apply because it's restricted.

## License requirements

Restricted management administrative units require a Microsoft Entra ID P1 license for each administrative unit administrator, and Microsoft Entra ID Free licenses for administrative unit members. To find the right license for your requirements, see [Comparing generally available features of the Free and Premium editions](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

## Next steps

- [Create, update, or delete administrative units](admin-units-manage.md)
- [Add users or groups to an administrative unit](admin-units-members-add.md)
- [Assign Microsoft Entra roles with administrative unit scope](manage-roles-portal.md)

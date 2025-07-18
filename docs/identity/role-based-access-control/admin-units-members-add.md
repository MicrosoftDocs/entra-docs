---
title: Add users, groups, or devices to an administrative unit
description: Add users, groups, or devices to an administrative unit in Microsoft Entra ID
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.subservice: role-based-access-control
ms.date: 01/03/2025
ms.author: barclayn
ms.reviewer: anandy
ms.custom: oldportal;it-pro;, sfi-image-nochange
---

# Add users, groups, or devices to an administrative unit

In Microsoft Entra ID, you can add users, groups, or devices to an administrative unit to limit the scope of role permissions. Adding a group to an administrative unit brings the group itself into the management scope of the administrative unit, but **not** the members of the group. For additional details on what scoped administrators can do, see [Administrative units in Microsoft Entra ID](administrative-units.md).

This article describes how to add users, groups, or devices to administrative units manually. For information about how to add users or devices to administrative units dynamically using rules, see [Manage users or devices for an administrative unit with rules for dynamic membership groups](admin-units-members-dynamic.md).

## Prerequisites

- Microsoft Entra ID P1 or P2 license for each administrative unit administrator
- Microsoft Entra ID Free licenses for administrative unit members
- To add existing users, groups, or devices:
    - Privileged Role Administrator
- To create new groups:
    - Groups Administrator (scoped to the administrative unit or entire directory)
- [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) module when using PowerShell
- Admin consent when using Graph Explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

# [Admin center](#tab/admin-center)

You can add users, groups, or devices to administrative units using the Microsoft Entra admin center. You can also add users in a bulk operation or create a new group in an administrative unit.

### Add a single user, group, or device to administrative units


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID**.

1. Browse to one of the following:

    - **Users** > **All users**
    - **Groups** > **All groups**
    - **Devices** > **All devices**

1. Select the user, group, or device you want to add to administrative units.

1. Select **Administrative units**.

1. Select **Assign to administrative unit**.

1. In the **Select** pane, select the administrative units and then select **Select**.

    :::image type="content" source="./media/admin-units-members-add/assign-users-individually.png" alt-text="Screenshot of the Administrative units page for adding a user to an administrative unit." lightbox="./media/admin-units-members-add/assign-users-individually.png":::

### Add users, groups, or devices to a single administrative unit

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Roles & admins** > **Admin units**.

1. Select the administrative unit you want to add users, groups, or devices to.

1. Select one of the following:

    - **Users**
    - **Groups**
    - **Devices**

1. Select **Add member**, **Add**, or **Add device**.

1. In the **Select** pane, select the users, groups, or devices you want to add to the administrative unit and then select **Select**.

    :::image type="content" source="./media/admin-units-members-add/admin-unit-members-add.png" alt-text="Screenshot of adding multiple devices to an administrative unit." lightbox="./media/admin-units-members-add/admin-unit-members-add.png":::

### Add users to an administrative unit in a bulk operation

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Roles & admins** > **Admin units**.

1. Select the administrative unit you want to add users to.

1. Select **Users** > **Bulk operations** > **Bulk add members**.

    :::image type="content" source="./media/admin-units-members-add/bulk-assign-to-admin-unit.png" alt-text="Screenshot of the Users page for assigning users to an administrative unit as a bulk operation." lightbox="./media/admin-units-members-add/bulk-assign-to-admin-unit.png":::

1. In the **Bulk add members** pane, download the comma-separated values (CSV) template.

1. Edit the downloaded CSV template with the list of users you want to add.

    Add one user principal name (UPN) in each row. Don't remove the first two rows of the template.

1. Save your changes and upload the CSV file.

    :::image type="content" source="./media/admin-units-members-add/bulk-user-entries.png" alt-text="Screenshot of an edited CSV file for adding users to an administrative unit in bulk." lightbox="./media/admin-units-members-add/bulk-user-entries.png":::

1. Select **Submit**.

### Create a new group in an administrative unit

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](permissions-reference.md#groups-administrator).

1. Browse to **Entra ID** > **Roles & admins** > **Admin units**.

1. Select the administrative unit you want to create a new group in.

1. Select **Groups**.

1. Select **New group** and complete the steps to create a new group.

    :::image type="content" source="./media/admin-units-members-add/admin-unit-create-group.png" alt-text="Screenshot of the Administrative units page for creating a new group in an administrative unit." lightbox="./media/admin-units-members-add/admin-unit-create-group.png":::

# [PowerShell](#tab/ms-powershell)

Use the [New-MgDirectoryAdministrativeUnitMemberByRef](/powershell/module/microsoft.graph.identity.directorymanagement/new-mgdirectoryadministrativeunitmemberbyref) command to add user, groups, or devices to an administrative unit or create a new group in an administrative unit.

### Add users to an administrative unit

```powershell
$adminUnitObj = Get-MgDirectoryAdministrativeUnit -Filter "DisplayName eq '{admin-unit-id}'"
$userObj = Get-MgUser -Filter "UserPrincipalName eq '{user-principal-name}'"
$odataId = "https://graph.microsoft.com/v1.0/users/" + $userObj.Id
New-MgDirectoryAdministrativeUnitMemberByRef -AdministrativeUnitId $adminUnitObj.Id -OdataId $odataId
```

### Add groups to an administrative unit

```powershell
$adminUnitObj = Get-MgDirectoryAdministrativeUnit -Filter "DisplayName eq '{admin-unit-id}'"
$groupObj = Get-MgGroup -Filter "DisplayName eq 'group-name'"
$odataId = "https://graph.microsoft.com/v1.0/groups/" + $groupObj.Id
New-MgDirectoryAdministrativeUnitMemberByRef -AdministrativeUnitId $adminUnitObj.Id -OdataId $odataId
```

### Add devices to an administrative unit

```powershell
$adminUnitObj = Get-MgDirectoryAdministrativeUnit -Filter "DisplayName eq '{admin-unit-id}'"
$odataId = "https://graph.microsoft.com/v1.0/devices/{device-id}"
New-MgDirectoryAdministrativeUnitMemberByRef -AdministrativeUnitId $adminUnitObj.Id -OdataId $odataId
```

### Create a new group in an administrative unit

```powershell
$adminUnitObj = Get-MgDirectoryAdministrativeUnit -Filter "DisplayName eq '{admin-unit-id}'"
$params = @{
    "@odata.type" = "#microsoft.graph.group"
    description = "{group-description}"
    displayName = "{group-name}"
    groupTypes = @(
        "Unified"
    )
    mailEnabled = $false
    mailNickname = "{group-name}"
    securityEnabled = $true
}
New-MgDirectoryAdministrativeUnitMember -AdministrativeUnitId $adminUnitObj.Id -BodyParameter $params
```

# [Graph API](#tab/ms-graph)

Use the [Add a member](/graph/api/administrativeunit-post-members) API to add users, groups, or devices to an administrative unit or create a new group in an administrative unit.

### Add users to an administrative unit

Request

```http
POST https://graph.microsoft.com/v1.0/directory/administrativeUnits/{admin-unit-id}/members/$ref
```

Body

```http
{
    "@odata.id":"https://graph.microsoft.com/v1.0/users/{user-id}"
}
```

Example

```http
{
    "@odata.id":"https://graph.microsoft.com/v1.0/users/john@example.com"
}
```

### Add groups to an administrative unit

Request

```http
POST https://graph.microsoft.com/v1.0/directory/administrativeUnits/{admin-unit-id}/members/$ref
```

Body

```http
{
    "@odata.id":"https://graph.microsoft.com/v1.0/groups/{group-id}"
}
```

Example

```http
{
    "@odata.id":"https://graph.microsoft.com/v1.0/groups/871d21ab-6b4e-4d56-b257-ba27827628f3"
}
```

### Add devices to an administrative unit

Request

```http
POST https://graph.microsoft.com/v1.0/directory/administrativeUnits/{admin-unit-id}/members/$ref
```

Body

```http
{
    "@odata.id":"https://graph.microsoft.com/v1.0/devices/{device-id}"
}
```

### Create a new group in an administrative unit

Request

```http
POST https://graph.microsoft.com/v1.0/directory/administrativeUnits/{admin-unit-id}/members/
```

Body

```http
{
    "@odata.type": "#Microsoft.Graph.Group",
    "description": "{Example group description}",
    "displayName": "{Example group name}",
    "groupTypes": [
        "Unified"
    ],
    "mailEnabled": true,
    "mailNickname": "{examplegroup}",
    "securityEnabled": false
}
```

---

## Next steps

- [Administrative units in Microsoft Entra ID](administrative-units.md)
- [Assign Microsoft Entra roles with administrative unit scope](manage-roles-portal.md)
- [Manage users or devices for an administrative unit with rules for dynamic membership groups](admin-units-members-dynamic.md)
- [Remove users, groups, or devices from an administrative unit](admin-units-members-remove.md)

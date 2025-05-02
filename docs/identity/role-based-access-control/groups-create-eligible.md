---
title: Create a role-assignable group in Microsoft Entra ID
description: Learn how to a role-assignable group in Microsoft Entra ID using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API.

author: rolyon
manager: femila
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: how-to
ms.date: 01/03/2025
ms.author: rolyon
ms.reviewer: vincesm
ms.custom: it-pro, no-azure-ad-ps-ref


---

# Create a role-assignable group in Microsoft Entra ID

This article describes how to create a role-assignable group using the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API.

With Microsoft Entra ID P1 or P2, you can create [role-assignable groups](groups-concept.md) and assign Microsoft Entra roles to these groups. You create a new role-assignable group by setting **Microsoft Entra roles can be assigned to the group** to **Yes** or by setting the `isAssignableToRole` property set to `true`. A role-assignable group can't be a part of a [dynamic membership group](~/identity/users/groups-dynamic-membership.md) type. In Microsoft Entra, a single tenant can have a maximum of 500 role-assignable groups.

## Prerequisites

- Microsoft Entra ID P1 or P2 license
- [Privileged Role Administrator](./permissions-reference.md#privileged-role-administrator)
- [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) module when using PowerShell
- Admin consent when using Graph explorer for Microsoft Graph API

For more information, see [Prerequisites to use PowerShell or Graph Explorer](prerequisites.md).

## Create a role-assignable group

# [Admin center](#tab/admin-center)


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Groups** > **All groups**.

1. Select **New group**.

1. On the **New Group** page, provide group type, name, and description.

1. Set **Microsoft Entra roles can be assigned to the group** to **Yes**.

    This option is visible to Privileged Role Administrators because this role can set this option.

    :::image type="content" source="media/groups-create-eligible/eligible-switch.png" alt-text="Screenshot of option to make group a role-assignable group." lightbox="media/groups-create-eligible/eligible-switch.png":::
    
1. Select the members and owners for the group. You also have the option to assign roles to the group, but assigning a role isn't required here.

1. Select **Create**.

    You see the following message:
    
    Creating a group to which Microsoft Entra roles can be assigned is a setting that cannot be changed later. Are you sure you want to add this capability?

    :::image type="content" source="media/groups-create-eligible/group-create-message.png" alt-text="Screenshot of confirm message when creating a role-assignable group." lightbox="media/groups-create-eligible/group-create-message.png":::

1. Select **Yes**.

    The group is created with any roles you might have assigned to it.

# [PowerShell](#tab/ms-powershell)

Use the [New-MgGroup](/powershell/module/microsoft.graph.groups/new-mggroup?branch=main) command to create a role-assignable group.

This example shows how to create a Security role-assignable group.

```powershell
Connect-MgGraph -Scopes "Group.ReadWrite.All"
$group = New-MgGroup -DisplayName "Contoso_Helpdesk_Administrators" -Description "Helpdesk Administrator role assigned to group" -MailEnabled:$false -SecurityEnabled -MailNickName "contosohelpdeskadministrators" -IsAssignableToRole:$true
```

This example shows how to create a Microsoft 365 role-assignable group.

```powershell
Connect-MgGraph -Scopes "Group.ReadWrite.All"
$group = New-MgGroup -DisplayName "Contoso_Helpdesk_Administrators" -Description "Helpdesk Administrator role assigned to group" -MailEnabled:$true -SecurityEnabled -MailNickName "contosohelpdeskadministrators" -IsAssignableToRole:$true -GroupTypes "Unified"
```

# [Graph API](#tab/ms-graph)

Use the [Create group](/graph/api/group-post-groups?branch=main) API to create a role-assignable group.

This example shows how to create a Security role-assignable group.

```http
POST https://graph.microsoft.com/v1.0/groups
{
    "description": "Helpdesk Administrator role assigned to group",
    "displayName": "Contoso_Helpdesk_Administrators",
    "isAssignableToRole": true,
    "mailEnabled": false,
    "mailNickname": "contosohelpdeskadministrators",
    "securityEnabled": true
}
```

Response

```http
HTTP/1.1 201 Created
```

This example shows how to create a Microsoft 365 role-assignable group.

```http
POST https://graph.microsoft.com/v1.0/groups
{
  "description": "Helpdesk Administrator role assigned to group",
  "displayName": "Contoso_Helpdesk_Administrators",
  "groupTypes": [
    "Unified"
  ],
  "isAssignableToRole": true,
  "mailEnabled": true,
  "mailNickname": "contosohelpdeskadministrators",
  "securityEnabled": true,
  "visibility" : "Private"
}
```

For this type of group, `isPublic` is always false and `isSecurityEnabled` is always true.

---

## Next steps

- [Assign Microsoft Entra roles](manage-roles-portal.md)
- [Use Microsoft Entra groups to manage role assignments](groups-concept.md)
- [Troubleshoot Microsoft Entra roles assigned to groups](groups-faq-troubleshooting.yml)

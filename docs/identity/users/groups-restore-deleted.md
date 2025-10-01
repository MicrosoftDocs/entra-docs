---
title: Restore a deleted Microsoft 365 group
description: Learn how to restore a deleted group, view restorable groups, and permanently delete a group in Microsoft Entra ID.
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: quickstart
ms.date: 03/27/2025
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro, mode-other, has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sfi-ga-nochange
---
# Restore a deleted Microsoft 365 group in Microsoft Entra ID

When you delete a Microsoft 365 group in Microsoft Entra ID, the deleted group is retained but not visible for 30 days from the deletion date. This behavior is so that the group and its contents can be restored if needed. This functionality is restricted exclusively to Microsoft 365 groups in Microsoft Entra ID. It isn't available for security groups and distribution groups. The 30-day group restoration period isn't customizable.

Permissions that are required to restore a group are listed in the following table.

Role | Permissions
--------- | ---------
Global Administrator, Group Administrator, Partner Tier 2 Support, and Intune Administrator | Can restore any deleted Microsoft 365 group
User Administrator and Partner Tier 1 Support | Can restore any deleted Microsoft 365 group except those groups assigned to the Global Administrator role
User | Can restore any deleted Microsoft 365 group that they own

>[!NOTE]
> Soft delete is available for both M365 groups with assigned membership and M365 groups with dynamic membership. At this time, soft delete is not available for security groups.

## View and manage the deleted Microsoft 365 groups that are available to restore

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups** and then select **Deleted groups** to view the deleted groups that are available to restore.

   :::image type="content" source="./media/groups-restore-deleted/deleted-groups3.png" alt-text="Screenshot that shows viewing groups that are available to restore.":::

1. On the **Deleted groups** pane, you can:

   - Restore the deleted group and its contents by selecting **Restore group**.
   - Permanently remove the deleted group by selecting **Delete permanently**. To permanently remove a group, you must be an administrator.

## View the deleted Microsoft 365 groups that are available to restore by using PowerShell

Use the following cmdlets to view the deleted groups. You need to verify that the groups you're interested in weren't permanently purged. These cmdlets are part of the [Microsoft Graph PowerShell module](/powershell/microsoftgraph/installation?view=graph-powershell-1.0&preserve-view=true). For more information about this module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview?view=graph-powershell-1.0&preserve-view=true).

Run the following cmdlet to display all deleted Microsoft 365 groups in your Microsoft Entra organization that are still available to restore. Install the [Graph](/powershell/microsoftgraph/installation?view=graph-powershell-1.0&preserve-view=true) beta version if it isn't already installed on the machine.

```powershell
Install-Module Microsoft.Graph.Beta
Connect-MgGraph -Scopes "Group.ReadWrite.All"
Get-MgBetaDirectoryDeletedGroup
```

Alternatively, if you know the object ID of a specific group (and you can get it from the cmdlet in step 1), run the following cmdlet. You need to verify that the specific deleted group wasn't permanently purged.

```powershell
Get-MgBetaDirectoryDeletedGroup -DirectoryObjectId <objectId>
```

## Restore your deleted Microsoft 365 group

After you verify that the group is still available to restore, restore the deleted group with one of the following steps. If the group contains documents, SharePoint sites, or other persistent objects, it might take up to 24 hours to fully restore a group and its contents.

Run the following cmdlet to restore the group and its contents.

```powershell    
Restore-MgBetaDirectoryDeletedItem -DirectoryObjectId <objectId>
``` 

Alternatively, you can run the following cmdlet to permanently remove the deleted group.

```powershell
Remove-MgBetaDirectoryDeletedItem -DirectoryObjectId <objectId>
```

## How do you know restoration worked?

To verify that you successfully restored a Microsoft 365 group, run the `Get-MgBetaGroup –GroupId <objectId>` cmdlet to display information about the group. After the restore request is completed:

- The group appears in the left navigation pane on Exchange.
- The plan for the group appears in Planner.
- Any SharePoint sites and all their contents are available.
- You can access the group from any of the Exchange endpoints and other Microsoft 365 workloads that support Microsoft 365 groups.

## Next steps

For more information on Microsoft Entra groups:

* [Manage Microsoft Entra groups and group membership](/entra/fundamentals/how-to-manage-groups)
* [Manage rules for dynamic membership groups](groups-dynamic-membership.md)

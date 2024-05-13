---
title: Assign sensitivity labels to groups
description: Learn how to assign sensitivity labels to groups. See troubleshooting information and view more resources.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 11/08/2023
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Assign sensitivity labels to Microsoft 365 groups in Microsoft Entra ID

Microsoft Entra ID supports applying [sensitivity labels](/purview/sensitivity-labels) to Microsoft 365 groups when those labels are published in the [Microsoft Purview portal](/purview/purview-portal) or the [Microsoft Purview compliance portal](/purview/purview-compliance-portal) and the labels are configured for groups and sites. 

Sensitivity labels can be applied to groups across apps and services such as Outlook, Microsoft Teams, and SharePoint. For more information, see [Support for sensitivity labels](/purview/sensitivity-labels-teams-groups-sites#support-for-the-sensitivity-labels) from the Purview documentation.

> [!IMPORTANT]
> To configure this feature, there must be at least one active Microsoft Entra ID P1 license in your Microsoft Entra organization.

## Enable sensitivity label support in PowerShell

To apply published labels to groups, you must first enable the feature. These steps enable the feature in Microsoft Entra ID. The Microsoft Graph PowerShell SDK comes in two modules, `Microsoft.Graph` and `Microsoft.Graph.Beta`.

1. Open a PowerShell prompt on your computer and run the following commands to prepare to run the cmdlets.

    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser
    Install-Module Microsoft.Graph.Beta -Scope CurrentUser
    ```

1. Connect to your tenant.

    ```powershell
    Connect-MgGraph -Scopes "Directory.ReadWrite.All"
    ```

1. Fetch the current group settings for the Microsoft Entra organization and display the current group settings.

    ```powershell
    $grpUnifiedSetting = Get-MgBetaDirectorySetting -Search DisplayName:"Group.Unified"
    ```

   
    If no group settings were created for this Microsoft Entra organization, you get an empty screen. In this case, you must first create the settings. Follow the steps in [Microsoft Entra cmdlets for configuring group settings](~/identity/users/groups-settings-cmdlets.md) to create group settings for this Microsoft Entra organization.
    
    > [!NOTE]
    > If the sensitivity label was enabled previously, you see **EnableMIPLabels** = **True**. In this case, you don't need to do anything.

1. Apply the new settings.

    ```powershell
    $params = @{
	    Values = @(
		    @{
			    Name = "EnableMIPLabels"
			    Value = "True"
		    }
	    )
    }

    Update-MgBetaDirectorySetting -DirectorySettingId $grpUnifiedSetting.Id -BodyParameter $params
    ```

1. Verify that the new value is present.

    ```powershell
    $Setting = Get-MgBetaDirectorySetting -DirectorySettingId $grpUnifiedSetting.Id
    $Setting.Values
    ```

If you receive a `Request_BadRequest` error, it's because the settings already exist in the tenant. When you try to create a new `property:value` pair, the result is an error. In this case, follow these steps:

1. Issue a `Get-MgBetaDirectorySetting | FL` cmdlet and check the ID. If several ID values are present, use the one where you see the `EnableMIPLabels` property on the **Values** settings.
1. Issue the `Update-MgBetaDirectorySetting` cmdlet by using the ID that you retrieved.

You also need to synchronize your sensitivity labels to Microsoft Entra ID. For instructions, see [Enable sensitivity labels for containers and synchronize labels](/purview/sensitivity-labels-teams-groups-sites#how-to-enable-sensitivity-labels-for-containers-and-synchronize-labels).

## Assign a label to a new group in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups** > **New group**.
1. On the **New Group** page, select **Microsoft 365**. Then fill out the required information for the new group and select a sensitivity label from the list.

   :::image type="content" source="./media/groups-assign-sensitivity-labels/new-group-page.png" alt-text="Screenshot that shows assigning a sensitivity label on the New groups page.":::

1. Select **Create** to save your changes.

Your group is created and the site and group settings associated with the selected label are then automatically enforced.

## Assign a label to an existing group in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Groups**.
1. From the **All groups** page, select the group that you want to label.
1. On the selected group's page, select **Properties** and select a sensitivity label from the list.

   :::image type="content" source="./media/groups-assign-sensitivity-labels/assign-to-existing.png" alt-text="Screenshot that shows assigning a sensitivity label on the overview page for a group.":::

1. Select **Save** to save your changes.

## Remove a label from an existing group in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups**.
1. On the **All groups** page, select the group that you want to remove the label from.
1. On the **Group** page, select **Properties**.
1. Select **Remove**.
1. Select **Save** to apply your changes.

<a name='using-classic-azure-ad-classifications'></a>

## Use classic Microsoft Entra classifications

After you enable this feature, the "classic" classifications for groups appear only on existing groups and sites. You should use them for new groups only if you create groups in apps that don't support sensitivity labels. Your admin can convert them to sensitivity labels later, if needed. Classic classifications are the old classifications you set up by defining values for the `ClassificationList` setting in Azure AD PowerShell. When this feature is enabled, those classifications aren't applied to groups.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../docs/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

## Troubleshooting issues

This section offers troubleshooting tips for common issues.

### Sensitivity labels aren't available for assignment on a group

The sensitivity label option appears for groups only when all the following conditions are met:

1. The organization has an active Microsoft Entra ID P1 license.
1. The feature is enabled and `EnableMIPLabels` is set to **True** in the Microsoft Graph PowerShell module.
1. The sensitivity labels are published in the Microsoft Purview portal or the Microsoft Purview compliance portal for this Microsoft Entra organization.
1. Labels are synchronized to Microsoft Entra ID with the `Execute-AzureAdLabelSync` cmdlet in the Security & Compliance PowerShell module. It can take up to 24 hours after synchronization for the label to be available to Microsoft Entra ID.
1. The [sensitivity label scope](/purview/sensitivity-labels?preserve-view=true&view=o365-worldwide#label-scopes) must be configured for Groups & Sites.
1. The group is a Microsoft 365 group.
1. The current signed-in user:
    1. Has sufficient privileges to assign sensitivity labels. The user must be the group owner or at least a Groups Administrator.
    1. Must be within the scope of the [sensitivity label publishing policy](/purview/sensitivity-labels?preserve-view=true&view=o365-worldwide#what-label-policies-can-do).

Make sure all the preceding conditions are met to assign labels to a group.

### The label you want to assign isn't in the list

If the label you're looking for isn't in the list:

- The label might not be published in the Microsoft Purview portal or the Microsoft Purview compliance portal. Also, the label might no longer be published. Check with your administrator for more information.
- The label might be published, but it isn't available to the user who is signed in. Check with your administrator for more information on how to get access to the label.

### Change the label on a group

Labels can be swapped at any time by using the same steps as assigning a label to an existing group:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups**, and then select the group that you want to label.
1. On the selected group's page, select **Properties** and select a new sensitivity label from the list.
1. Select **Save**.

### Group setting changes to published labels aren't updated on the groups

When you make changes to group settings for a published label in the [Microsoft Purview portal](https://purview.microsoft.com/) or the [Microsoft Purview compliance portal](https://compliance.microsoft.com), those policy changes aren't automatically applied on the labeled groups. After the sensitivity label is published and applied to groups, Microsoft recommends that you don't change the group settings for the label in the portal.

If you must make a change, use a [PowerShell script](https://github.com/microsoftgraph/powershell-aad-samples/blob/master/ReassignSensitivityLabelToO365Groups.ps1) to manually apply updates to the affected groups. This method makes sure that all existing groups enforce the new setting.

## Next steps

- [Use sensitivity labels to protect content in Microsoft Teams, Microsoft 365 groups, and SharePoint sites](/purview/sensitivity-labels-teams-groups-sites)
- [Update groups after label policy change manually with Azure AD PowerShell script](https://github.com/microsoftgraph/powershell-aad-samples/blob/master/ReassignSensitivityLabelToO365Groups.ps1)
- [Edit your group settings](~/fundamentals/how-to-manage-groups.yml)
- [Manage groups using PowerShell commands](~/identity/users/groups-settings-v2-cmdlets.md)

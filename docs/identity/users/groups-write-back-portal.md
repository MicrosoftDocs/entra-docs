---
title: Group writeback portal operations (preview) in Microsoft Entra ID
description: Learn about the access points for group writeback to on-premises Active Directory in the Azure portal.
keywords:
author: barclayn
manager: amycolannino
ms.author: barclayn
ms.reviewer: jordan.dahl
ms.date: 12/13/2024
ms.topic: how-to
ms.service: entra-id
ms.subservice: users

ms.custom: "it-pro"
ms.collection: M365-identity-device-management
#Customer intent: As a new Microsoft Entra identity administrator, user management is at the core of my work, so I need to understand the user management tools such as groups, administrator roles, and licenses to manage users.
---

# Group writeback in the Microsoft Entra admin center

>[!NOTE]
>This article discusses how to perform operations in the Microsoft Entra admin center with regard to group writeback.  For information on setup and configuration see [Provision groups to Active Directory using Microsoft Entra Cloud Sync (Preview)](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md)

With the release of provisioning agent [1.1.1370.0](~/identity/hybrid/cloud-sync/reference-version-history.md#1113700), Cloud Sync now has the ability to provision groups directly to your on-premises Active Directory environment. With this capability, you can use identity governance features to govern access to Active Directory-based applications. For example, you can include a [group in an entitlement management access package](~/id-governance/entitlement-management-group-writeback.md). This is currently in public preview.  

For more information, see [Group provisioning to Active Directory](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md) and [Govern on-premises Active Directory-based apps (Kerberos) using Microsoft Entra ID Governance (preview)](~/identity/hybrid/cloud-sync/govern-on-premises-groups.md).

[!INCLUDE [deprecation](~/includes/gwb-v2-deprecation.md)]

If you're using Microsoft Entra Connect Sync Group Writeback v2, you need to move to Cloud Sync provisioning to Active Directory before you can take advantage of Cloud Sync group provisioning. For more information, see [Migrate Microsoft Entra Connect Sync Group Writeback v2 to Microsoft Entra Cloud Sync](~/identity/hybrid/cloud-sync/migrate-group-writeback.md).

>[!NOTE]
> If you were previously writing Microsoft 365 groups back to on-premises Active Directory as universal distribution groups, they appear in the Azure portal as not enabled for writeback on both the **Groups** page and the properties page for a group. These pages display a new property introduced for the preview, `writeback enabled`. This property isn't set by the current version of Group Writeback to ensure backward compatibility with the legacy version of Group Writeback and to avoid breaking existing customer setups.

To understand the behavior of `No writeback` in the portal, you can view the writeback state via Microsoft Graph. For more information, see [Get group](/graph/api/group-get).

| Portal | Microsoft Graph| Behavior|
|--------|---------|---------|
| Writeback | isEnabled = null or true | The group is written back. |
| No writeback | isEnabled = false | The group is not written back.| 
| No writeback | IsEnabled = null & onPremisesGroupType = null | If it's a Microsoft 365 group, it's written back to on-premises Active Directory as a distribution group. </br> If it's a Microsoft Entra security group, it's written back to on-premises Active Directory. |

By default, the **Group writeback state** of groups is set to **No writeback**. This means:

- **Microsoft 365 groups**: If the group is ```IsEnabled = null``` and ```onPremisesGroupType = null```, to ensure backward compatibility with older versions of Group Writeback, the group is written back to on-premises Active Directory as a distribution group.
- **Microsoft Entra security groups**: If the group is ```IsEnabled = null``` and ```onPremisesGroupType = null```, the group is written back to on-premises Active Directory.

## Show writeback columns

On the **All groups** overview page, you can add the group writeback columns **Target writeback type** and **Writeback enabled** to the view. The **Target writeback type** and **Writeback enabled** columns are available for the view whether or not you have writeback enabled in Microsoft Entra Connect.

​:::image type="content" source="./media/groups-write-back-portal/all-groups-columns.png" alt-text="Screenshot that shows selecting columns for writeback in the All groups list." lightbox="media/groups-write-back-portal/all-groups-columns.png":::

## Writeback column settings

The **Writeback enabled** column allows you to turn off the writeback capability for individual groups. The **Target writeback type** column allows you to specify to which group type you want this cloud group written back in on-premises Active Directory. For a Microsoft Entra Microsoft 365 group, you can write it back as a security group, a distribution group, or a mail-enabled security group. For a Microsoft Entra security group, you can write it back only as a security group.

:::image type="content" source="./media/groups-write-back-portal/all-groups-view.png" alt-text="Screenshot that shows writeback settings columns that are visible on the All groups page." lightbox="media/groups-write-back-portal/all-groups-view.png":::

## Writeback settings in group properties

You can also configure writeback settings for a group on the property page for the group. There's a **Group writeback state** setting that allows you to turn off writeback for the group or to specify the writeback group type. When **No writeback** is selected, the group isn't written back. If you select one of the other writeback types as an option (for example, security), then you have:

- Enabled the group for writeback.
- Targeted the writeback type as a security group.

:::image type="content" source="./media/groups-write-back-portal/groups-properties-view.png" alt-text="Screenshot that shows changing writeback settings in the group properties." lightbox="media/groups-write-back-portal/groups-properties-view.png":::

## Read the writeback configuration by using PowerShell

You can use PowerShell to get a list of writeback-enabled groups by using the following PowerShell `Get-MgGroup` cmdlet.

```powershell-console
Connect-MgGraph -Scopes @('Group.Read.all')
Select-MgProfile -Name beta
PS D:\> Get-MgGroup -All |Where-Object {$_.writebackConfiguration.isEnabled -Like $true} |Select-Object Displayname,@{N="WriteBackEnabled";E={$_.writebackConfiguration.isEnabled}}

DisplayName WriteBackEnabled
----------- ----------------
CloudGroup1           True
CloudGroup2           True
```

## Read the writeback configuration by using Graph Explorer

Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and use the endpoint ```https://graph.microsoft.com/beta/groups/{Group_ID}```.

Replace the group ID with a cloud group ID, and then select **Run query**.
On the **Response Preview**, scroll to the end to see the part of the JSON file.

```json
"writebackConfiguration": {
    "isEnabled": true,
    ...
}
```

## Next steps

- Check out the group's REST API documentation for the [preview writeback property on the settings template](/graph/api/resources/group?view=graph-rest-beta&preserve-view=true).
- For more information about group writeback operations, see [Microsoft Entra Connect group writeback](~/identity/hybrid/connect/how-to-connect-group-writeback-v2.md).
- For more information about the `writebackConfiguration` resource, see [`writebackConfiguration` resource type](/graph/api/resources/writebackconfiguration?view=graph-rest-beta&preserve-view=true).

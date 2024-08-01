---
title: Enable Enterprise State Roaming in Microsoft Entra ID
description: Frequently asked questions about Enterprise State Roaming settings in Windows devices.

ms.service: entra-id
ms.subservice: devices
ms.topic: how-to
ms.date: 01/04/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: guovivian
ms.custom: references_regions
---
# Enable Enterprise State Roaming in Microsoft Entra ID

Enterprise State Roaming provides users with a unified experience across their Windows devices and reduces the time needed for configuring a new device. Enterprise State Roaming operates similar to the standard [consumer settings sync](https://go.microsoft.com/fwlink/?linkid=2015135) that was first introduced in Windows 8. Enterprise State Roaming is available to any organization with a Microsoft Entra ID P1 or P2 or Enterprise Mobility + Security (EMS) license. For more information on how to get a Microsoft Entra subscription, see the [Microsoft Entra product page](https://azure.microsoft.com/services/active-directory).

> [!NOTE]
> This article applies to the Microsoft Edge Legacy HTML-based browser launched with Windows 10 in July 2015. The article does not apply to the new Microsoft Edge Chromium-based browser released on January 15, 2020. For more information on the Sync behavior for the new Microsoft Edge, see the article [Microsoft Edge Sync](/deployedge/microsoft-edge-enterprise-sync).

## To enable Enterprise State Roaming

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](../role-based-access-control/permissions-reference.md#global-administrator).
1. Browse to **Identity** > **Devices** > **Overview** > **Enterprise State Roaming**.
1. Select **Users may sync settings and app data across devices**. For more information, see [how to configure device settings](./manage-device-identities.md).

For a Windows 11 or Windows 10, version 21H2 or newer device to use the Enterprise State Roaming service, the device must authenticate using a Microsoft Entra identity. For devices that are joined to Microsoft Entra ID, the user’s primary sign-in identity is their Microsoft Entra identity, so no other configuration is required. For devices that use on-premises Active Directory, the IT admin must [Configure Microsoft Entra hybrid joined devices](./hybrid-join-plan.md).

## Data storage

Enterprise State Roaming data is hosted in one or more [Azure regions](https://azure.microsoft.com/regions/) that best align with the country/region value set in the Microsoft Entra instance. Enterprise State Roaming data is partitioned based on three major geographic regions: North America, EMEA, and APAC. Enterprise State Roaming data for the tenant is locally located with the geographical region, and isn't replicated across regions. For example:

| Country/region value | has their data hosted in |
| -------------------- | ------------------------ |
| An EMEA country/region such as France or Zambia | One or more of the Azure regions within Europe |
| A North American country/region such as United States or Canada | One or more of the Azure regions within the US |
| An APAC country/region such as Australia or New Zealand | One or more of the Azure regions within Asia |
| South American and Antarctica regions | One or more Azure regions within the US |

The country/region value is set as part of the Microsoft Entra directory creation process and can’t be modified later. If you need more details on your data storage location, file a ticket with [Azure support](https://azure.microsoft.com/support/options/).

## Data retention

Data synced to the Microsoft cloud using Enterprise State Roaming is retained until manually deleted or the data is determined to be stale.

### Explicit deletion

Explicit deletion is when an administrator deletes a user, directory, or requests explicitly that data is to be deleted.

* **User deletion**: When a user is deleted in Microsoft Entra ID, the user account roaming data is deleted after 90 to 180 days.
* **Directory deletion**: Deleting an entire directory in Microsoft Entra ID is an immediate operation. All the settings data associated with that directory is deleted after 90 to 180 days.
* **On request deletion**: If the Microsoft Entra admin wants to manually delete a specific user’s data or settings data, the admin can file a ticket with [Azure support](https://azure.microsoft.com/support/).

### Stale data deletion

Data that isn't accessed for one year (“the retention period”) is treated as stale and might be deleted from the Microsoft cloud. The retention period is subject to change but isn't less than 90 days. The stale data might be a specific set of Windows/application settings or all settings for a user. For example:

* If no devices access a particular settings collection like language, then that collection becomes stale after the retention period and might be deleted.
* If a user turned off settings sync on all their devices, then none of the settings data is accessed. All the settings data for that user will become stale and might be deleted after the retention period.
* If the Microsoft Entra directory admin turns off Enterprise State Roaming for the entire directory, then all users in that directory stop syncing settings. All settings data for all users will become stale and might be deleted after the retention period.

### Deleted data recovery

The data retention policy isn't configurable. Once the data is permanently deleted, it isn't recoverable. However, The settings data is deleted only from the Microsoft cloud, not from the end-user device. If any device later reconnects to the Enterprise State Roaming service, the settings are again synced and stored in the Microsoft cloud.

## Next steps

* [Settings and data roaming FAQ](enterprise-state-roaming-faqs.yml)
* [Group Policy and MDM settings for settings sync](enterprise-state-roaming-group-policy-settings.md)
* [Windows 10 roaming settings reference](enterprise-state-roaming-windows-settings-reference.md)
* [Troubleshooting](enterprise-state-roaming-troubleshooting.md)

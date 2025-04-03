---
title: Group Policy and MDM settings for ESR
description: Management settings for Enterprise State Roaming

ms.service: entra-id
ms.subservice: devices
ms.topic: reference
ms.date: 08/01/2024

ms.author: owinfrey
author: owinfreyATL
manager: femila
ms.reviewer: sempofu, micrider
---
# Group Policy and MDM settings

Use these Group Policy and mobile device management (MDM) settings only on corporate-owned devices because these policies are applied to the user’s entire device. Applying an MDM policy to disable settings sync for a personal, user-owned device negatively impacts the use of that device. These policies affect other user accounts on the device.

Enterprises that want to manage roaming for personal (unmanaged) devices can use the Microsoft Entra admin center to enable or disable roaming, rather than using Group Policy or MDM.
The following tables describe the policy settings available.

> [!NOTE]
> This article applies to the Microsoft Edge Legacy HTML-based browser launched with Windows 10 in July 2015. The article does not apply to the new Microsoft Edge Chromium-based browser released on January 15, 2020. For more information on the Sync behavior for the new Microsoft Edge, see the article [Microsoft Edge Sync](/deployedge/microsoft-edge-enterprise-sync).

## MDM settings

The MDM policy settings apply to Windows 10 or newer. Refer to [Devices and endpoints](enterprise-state-roaming-windows-settings-reference.md) for details on what devices are supported for Microsoft Entra ID-based syncing.

| Name | Description |
| --- | --- |
| Allow Microsoft Account Connection |Allows users to authenticate using a Microsoft account on the device |
| Allow Sync My Settings |Allows users to roam Windows settings and app data; Disabling this policy disables sync and backups on mobile devices |

## Group Policy settings

The Group Policy settings apply to Windows 10 or newer devices that are joined to an Active Directory domain. The table also includes legacy settings that would appear to manage sync settings. Legacy settings that don't work for Enterprise State Roaming for Windows 10 or newer are noted with ‘Do not use’ in the description.

These settings are located in Group Policy under: **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Sync your settings**.

| Name | Description |
| --- | --- |
| Accounts: Block Microsoft Accounts |This policy setting prevents users from adding new Microsoft accounts on this computer |
| Do not sync |Prevents users to roam Windows settings and app data |
| Do not sync personalize |Disables syncing of the Themes group |
| Do not sync browser settings |Disables syncing of the Internet Explorer group |
| Do not sync passwords |Disables syncing of Passwords group |
| Do not sync other Windows settings |Disables syncing of Other Windows settings group |
| Do not sync desktop personalization |Do not use; has no effect |
| Do not sync on metered connections |Disables roaming on metered connections, such as cellular 3G |
| Do not sync apps |Do not use; has no effect |
| Do not sync app settings |Disables roaming of app data |
| Do not sync start settings |Do not use; has no effect |

## Next steps

For an overview, see [enterprise State Roaming overview](./enterprise-state-roaming-enable.md).

---
title: Windows roaming settings reference
description: Settings that can roam or backed up in Windows with ESR

ms.service: active-directory
ms.subservice: devices
ms.topic: reference
ms.date: 01/04/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: guovivian
---
# Windows roaming settings reference

The following lists the settings that can roam or be backed up in Windows 10 or newer.

## Windows Settings details

List of settings that can be configured to sync in recent Windows versions.

| Settings | Windows 10 (21H1 or newer) |
| --- | --- |
| Keyboard: turn on toggle keys (off by default) | sync |
| Date, Time, and Region: country/region | sync |
| Date, Time, and Region: region format (locale) | sync |
| Language: language profile | sync |
| Language: list of keyboards | sync |
| Mouse: Primary Mouse Button | sync |
| Passwords: Web Credentials | sync |
| Pen: Pen Handedness | sync |
| Touchpad: Scrolling Direction | sync |
| Wi-Fi: Wi-Fi profiles (only WPA) | sync |

Control over these settings can be found in Windows 10 under **Settings** > **Accounts** > **Sync your settings** or in Windows 11 under **Settings** > **Accounts** > **Windows backup** > **Remember my preferences**.

## Browser settings

For more information on the Sync behavior for the new Microsoft Edge, see the article [Microsoft Edge Sync](/deployedge/microsoft-edge-enterprise-sync).

Microsoft Edge browser setting group (favorites, reading list) syncing is managed through the Microsoft Edge browser Settings menu option.

![Account](./media/enterprise-state-roaming-windows-settings-reference/entra-enterprise-state-roaming-edge.png)

## Next steps

For an overview, see [enterprise state roaming overview](./enterprise-state-roaming-enable.md).

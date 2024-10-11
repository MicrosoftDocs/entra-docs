---
title: Troubleshoot Enterprise State Roaming in Microsoft Entra ID
description: Provides answers to some questions IT administrators might have about settings and app data sync.

ms.service: entra-id
ms.subservice: devices
ms.topic: troubleshooting
ms.date: 08/01/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: sempofu, micrider
---
# Troubleshooting Enterprise State Roaming settings in Microsoft Entra ID

This article provides information on how to troubleshoot and diagnose issues with Enterprise State Roaming, and provides a list of known issues.

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

> [!NOTE]
> The article does not apply to the new Microsoft Edge Chromium-based browser released on January 15, 2020. For more information on the Sync behavior for the new Microsoft Edge, see the article [Microsoft Edge Sync](/deployedge/microsoft-edge-enterprise-sync).

## Preliminary steps for troubleshooting

Before you start troubleshooting, verify that the user and device are configured properly, and that all the requirements of Enterprise State Roaming are met.

1. Windows 10 or newer, with the latest updates, and a minimum Version 22H2 (OS Build 19045 or later) is installed on the device.
1. The device is Microsoft Entra joined or Microsoft Entra hybrid joined. For more information, see [how to get a device under the control of Microsoft Entra ID](overview.md).
1. Ensure that **Enterprise State Roaming** is enabled for the tenant in Microsoft Entra ID as described in [To enable Enterprise State Roaming](enterprise-state-roaming-enable.md). You can enable roaming for all users or for only a selected group of users.
1. The user is assigned a Microsoft Entra ID P1 or P2 license.  
1. The device must be restarted and the user must sign in again to access Enterprise State Roaming features.

## Troubleshooting and diagnosing issues

This section gives suggestions on how to troubleshoot and diagnose problems related to Enterprise State Roaming.

## Verify sync, and the "Sync your settings" settings page

1. After joining your Windows 10 or newer PC to a domain that is configured to allow Enterprise State Roaming, sign on with your work account. Go to **Settings** > **Accounts** > **Sync Your Settings** and confirm that sync and the individual settings are on, and that the top of the settings page indicates that you're syncing with your work account. Confirm the same account is also used as your account in **Settings** > **Accounts** > **Your Info**.
1. Verify that sync works across multiple machines by making some changes on the original machine, such as changing the "Country or Region" or using other supported settings see [Windows roaming settings reference](enterprise-state-roaming-windows-settings-reference.md). Watch the change propagate to the second machine within five minutes.

   * Locking and unlocking the screen (Win + L) can help trigger a sync.
   * You must be signing in with the same account on both PCs for sync to work – as Enterprise State Roaming is tied to the user account and not the machine account.

**Potential issue**: If the controls in the **Settings** page aren't available, and you see the message "Some Windows features are only available if you're using a Microsoft account or work account." This issue might arise for devices that are set up to be domain-joined and registered to Microsoft Entra ID, but the device hasn't authenticated to Microsoft Entra ID yet. A possible cause is that the device policy must be applied, but this application happens asynchronously, and might take a few hours.

### Verify the device registration status

Enterprise State Roaming requires the device to be registered with Microsoft Entra ID. Although not specific to Enterprise State Roaming, using the following instructions can help confirm that the Windows 10 or newer Client is registered, and confirm thumbprint, Microsoft Entra settings URL, NGC status, and other information.

1. Open the command prompt unelevated. To do this in Windows, open the Run launcher (Win + R) and type "cmd" to open.
1. Once the command prompt is open, type `*dsregcmd.exe /status*`.
1. For expected output, the **AzureAdJoined** field value should be `YES`, **WamDefaultSet** field value should be `YES`, and the **WamDefaultGUID** field value should be a GUID with `(AzureAD)` at the end.

**Potential issue**: **WamDefaultSet** and **AzureAdJoined** both have "NO" in the field value, the device was domain-joined and registered with Microsoft Entra ID, and the device doesn't sync. If it's showing this, the device might need to wait for policy to be applied or the authentication for the device failed when connecting to Microsoft Entra ID. The user might have to wait a few hours for the policy to be applied. Other troubleshooting steps might include retrying autoregistration by signing out and back in, or launching the task in Task Scheduler. In some cases, running "*dsregcmd.exe /leave*" in an elevated command prompt window, rebooting, and trying registration again might help with this issue.

**Potential issue**: The field for **SettingsUrl** is empty and the device doesn't sync. The user might have last logged in to the device before Enterprise State Roaming was enabled. Restart the device and have the user sign-in. Optionally, in the portal, try having the IT Admin navigate to **Identity** > **Devices** > **Overview** > **Enterprise State Roaming** disable and re-enable **Users may sync settings and app data across devices**. To disable click on "None" and to re-enable click on "All" or "Selected". Once re-enabled, restart the device and have the user sign-in. If this doesn't resolve the issue, **SettingsUrl** might be empty if there's a bad device certificate. In this case, running "*dsregcmd.exe /leave*" in an elevated command prompt window, rebooting, and trying registration again might help with this issue.

## Enterprise State Roaming and multifactor authentication

Under certain conditions, Enterprise State Roaming can fail to sync data if Microsoft Entra multifactor authentication is configured. For more information on these symptoms, see the support document [KB3193683](https://support.microsoft.com/kb/3193683).

**Potential issue**: If your device is configured to require multifactor authentication on the Microsoft Entra admin center, you might fail to sync settings while signing in to a Windows 10 or newer device using a password. This type of multifactor authentication configuration is intended to protect an Azure administrator account. Admin users might still be able to sync by signing in to their Windows 10 or newer devices with their Windows Hello for Business PIN or by completing multifactor authentication while accessing other Azure services like Microsoft 365.

**Potential issue**: Sync can fail if the admin configures the Active Directory Federation Services multifactor authentication Conditional Access policy and the access token on the device expires. Ensure that you sign in and sign out using the Windows Hello for Business PIN or complete multifactor authentication while accessing other Azure services like Microsoft 365.

### Event Viewer

For advanced troubleshooting, Event Viewer can be used to find specific errors. The events can be found under Event Viewer > **Applications and Services Logs** > **Microsoft** > **Windows** > **CloudStore** and for identity-related issues with sync **Applications and Services Logs** > **Microsoft** > **Windows** > **AAD**.

## Next steps

For an overview, see [enterprise state roaming overview](./enterprise-state-roaming-enable.md).

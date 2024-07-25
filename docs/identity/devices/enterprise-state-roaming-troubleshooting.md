---
title: Troubleshoot Enterprise State Roaming in Microsoft Entra ID
description: Provides answers to some questions IT administrators might have about settings and app data sync.

ms.service: entra-id
ms.subservice: devices
ms.topic: troubleshooting
ms.date: 01/04/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: guovivian
---
# Troubleshooting Enterprise State Roaming settings in Microsoft Entra ID

This article provides information on how to troubleshoot and diagnose issues with Enterprise State Roaming, and provides a list of known issues.

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

> [!NOTE]
> This article applies to the Microsoft Edge Legacy HTML-based browser launched with Windows 10 in July 2015. The article does not apply to the new Microsoft Edge Chromium-based browser released on January 15, 2020. For more information on the Sync behavior for the new Microsoft Edge, see the article [Microsoft Edge Sync](/deployedge/microsoft-edge-enterprise-sync).

## Preliminary steps for troubleshooting

Before you start troubleshooting, verify that the user and device are configured properly, and that all the requirements of Enterprise State Roaming are met.

1. Windows 10 or newer, with the latest updates, and a minimum Version 1511 (OS Build 10586 or later) is installed on the device.
1. The device is Microsoft Entra joined or Microsoft Entra hybrid joined. For more information, see [how to get a device under the control of Microsoft Entra ID](overview.md).
1. Ensure that **Enterprise State Roaming** is enabled for the tenant in Microsoft Entra ID as described in [To enable Enterprise State Roaming](enterprise-state-roaming-enable.md). You can enable roaming for all users or for only a selected group of users.
1. The user is assigned a Microsoft Entra ID P1 or P2 license.  
1. The device must be restarted and the user must sign in again to access Enterprise State Roaming features.

## Troubleshooting and diagnosing issues

This section gives suggestions on how to troubleshoot and diagnose problems related to Enterprise State Roaming.

## Verify sync, and the “Sync your settings” settings page

1. After joining your Windows 10 or newer PC to a domain that is configured to allow Enterprise State Roaming, sign on with your work account. Go to **Settings** > **Accounts** > **Sync Your Settings** and confirm that sync and the individual settings are on, and that the top of the settings page indicates that you're syncing with your work account. Confirm the same account is also used as your account in **Settings** > **Accounts** > **Your Info**.
1. Verify that sync works across multiple machines by making some changes on the original machine, such as moving the taskbar around the screen. Watch the change propagate to the second machine within five minutes.

   * Locking and unlocking the screen (Win + L) can help trigger a sync.
   * You must be signing in with the same account on both PCs for sync to work – as Enterprise State Roaming is tied to the user account and not the machine account.

**Potential issue**: If the controls in the **Settings** page aren't available, and you see the message “Some Windows features are only available if you're using a Microsoft account or work account.” This issue might arise for devices that are set up to be domain-joined and registered to Microsoft Entra ID, but the device hasn't authenticated to Microsoft Entra ID yet. A possible cause is that the device policy must be applied, but this application happens asynchronously, and might take a few hours.

### Verify the device registration status

Enterprise State Roaming requires the device to be registered with Microsoft Entra ID. Although not specific to Enterprise State Roaming, using the following instructions can help confirm that the Windows 10 or newer Client is registered, and confirm thumbprint, Microsoft Entra settings URL, NGC status, and other information.

1. Open the command prompt unelevated. To do this in Windows, open the Run launcher (Win + R) and type “cmd” to open.
1. Once the command prompt is open, type `*dsregcmd.exe /status*`.
1. For expected output, the **AzureAdJoined** field value should be `YES`, **WamDefaultSet** field value should be `YES`, and the **WamDefaultGUID** field value should be a GUID with `(AzureAD)` at the end.

**Potential issue**: **WamDefaultSet** and **AzureAdJoined** both have “NO” in the field value, the device was domain-joined and registered with Microsoft Entra ID, and the device doesn't sync. If it's showing this, the device might need to wait for policy to be applied or the authentication for the device failed when connecting to Microsoft Entra ID. The user might have to wait a few hours for the policy to be applied. Other troubleshooting steps might include retrying autoregistration by signing out and back in, or launching the task in Task Scheduler. In some cases, running “*dsregcmd.exe /leave*” in an elevated command prompt window, rebooting, and trying registration again might help with this issue.

**Potential issue**: The field for **SettingsUrl** is empty and the device doesn't sync. The user might have last logged in to the device before Enterprise State Roaming was enabled. Restart the device and have the user sign-in. Optionally, in the portal, try having the IT Admin navigate to **Identity** > **Devices** > **Overview** > **Enterprise State Roaming** disable and re-enable **Users may sync settings and app data across devices**. Once re-enabled, restart the device and have the user sign-in. If this doesn't resolve the issue, **SettingsUrl** might be empty if there's a bad device certificate. In this case, running “*dsregcmd.exe /leave*” in an elevated command prompt window, rebooting, and trying registration again might help with this issue.

## Enterprise State Roaming and multifactor authentication

Under certain conditions, Enterprise State Roaming can fail to sync data if Microsoft Entra multifactor authentication is configured. For more information on these symptoms, see the support document [KB3193683](https://support.microsoft.com/kb/3193683).

**Potential issue**: If your device is configured to require multifactor authentication on the Microsoft Entra admin center, you might fail to sync settings while signing in to a Windows 10 or newer device using a password. This type of multifactor authentication configuration is intended to protect an Azure administrator account. Admin users might still be able to sync by signing in to their Windows 10 or newer devices with their Windows Hello for Business PIN or by completing multifactor authentication while accessing other Azure services like Microsoft 365.

**Potential issue**: Sync can fail if the admin configures the Active Directory Federation Services multifactor authentication Conditional Access policy and the access token on the device expires. Ensure that you sign in and sign out using the Windows Hello for Business PIN or complete multifactor authentication while accessing other Azure services like Microsoft 365.

### Event Viewer

For advanced troubleshooting, Event Viewer can be used to find specific errors. The events can be found under Event Viewer > **Applications and Services Logs** > **Microsoft** > **Windows** > **SettingSync-Azure** and for identity-related issues with sync **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID**.

## Known issues

### Sync does not work on devices that have apps side-loaded using MDM software

Affects devices running the Windows 10 Anniversary Update (Version 1607). In Event Viewer under the SettingSync-Azure logs, the Event ID 6013 with error 80070259 is frequently seen.

**Recommended action**  
Make sure the Windows 10 v1607 client has the August 23, 2016 Cumulative Update ([KB3176934](https://support.microsoft.com/kb/3176934) OS Build 14393.82).

---

### Date, Time, and Region settings do not sync on domain-joined device
  
Devices that are domain-joined don't sync the setting Date, Time, and Region: automatic time. Using automatic time might override the other Date, Time, and Region settings and cause those settings not to sync.

**Recommended action**  
None.

---

### Domain-joined device is not syncing after leaving corporate network

Domain-joined devices registered to Microsoft Entra ID might experience sync failure if the device is off-site for extended periods of time, and domain authentication can't complete.

**Recommended action**  
Connect the device to a corporate network so that sync can resume.

---

### Microsoft Entra joined device is not syncing and the user has a mixed case User Principal Name

If the user has a mixed case UPN (for example, UserName instead of username) and the user is on a Microsoft Entra joined device, which upgraded from Windows 10 Build 10586 to 14393, the user's device might fail to sync.

**Recommended action**  
The user needs to unjoin and rejoin the device to the cloud. To do this process, sign-in as the Local Administrator user and unjoin the device by going to **Settings** > **System** > **About** and select "Manage or disconnect from work or school". Clean up the following files, and then Microsoft Entra join the device again in **Settings** > **System** > **About** and selecting "Connect to Work or School". Continue to join the device to Microsoft Entra ID and complete the flow.

In the cleanup step, clean up the following files:

* Settings.dat in `C:\Users\<Username>\AppData\Local\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Settings\`
* All the files under the folder `C:\Users\<Username>\AppData\Local\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\AC\TokenBroker\Account`

---

### Event ID 6065: 80070533 This user can’t sign in because this account is currently disabled

In Event Viewer under the SettingSync/Debug logs, this error can be seen when the user's credentials expire. In addition, it can occur when the tenant didn't automatically have AzureRMS provisioned.

**Recommended action**  
In the first case, have the user update their credentials and sign-in to the device with the new credentials. To solve the AzureRMS issue, proceed with the steps listed in [KB3193791](https://support.microsoft.com/kb/3193791).

---

### Event ID 1098: Error: 0xCAA5001C Token broker operation failed

In Event Viewer under the AAD/Operational logs, this error might be seen with `Event 1104: AAD Cloud AP plugin call Get token returned error: 0xC000005F`. This issue occurs if there are missing permissions or ownership attributes.

**Recommended action**  
Proceed with the steps listed [KB3196528](https://support.microsoft.com/kb/3196528).  

## Next steps

For an overview, see [enterprise state roaming overview](./enterprise-state-roaming-enable.md).

---
title: Global Secure Access Client for Windows Release Notes
description: This article tracks the changes in each released version of the Global Secure Access client for Windows.
ms.service: global-secure-access
ms.topic: reference
ms.date: 02/10/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazbarak


---
# Global Secure Access client for Windows release notes
This article lists the released versions of the Global Secure Access client for Windows along with the changes in each version.   

## Download the latest version
The current version of the Global Secure Access client is available to download from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select **Download Client**.
:::image type="content" source="media/reference-windows-client-release-history/client-download-screen.png" alt-text="Screenshot of the Client download screen with the Download Client button highlighted.":::

## Version 2.14.80
Released for download on February 11, 2025.
### Functional changes
- Support for long-lived User Datagram Protocol (UDP) connections.
- Support for routing connections directly to the network when there's no successful tunnel established to the Global Secure Access cloud service.
- Adds performance counters to Performance Monitor:
    - Flow count
    - Tunnel count
- Support for Microsoft Cloud for Sovereignty environments.
- Bug fix: Global Secure Access doesn't preserve the Disable Private Access status after a restart.
### Other changes
- Sends device name to the Global Secure Access cloud service.
- Bug fix: time sync fails when Internet Access is enabled.
- Adds telemetry for connections that fail to tunnel and fall back to hardening action.
- Verifies client certificate validity before using the certificate to establish a mutual Transport Layer Security (mTLS) connection.
- Improvements and bug fixes for Advanced diagnostics.
- Miscellaneous bug fixes and improvements.

## Version 2.8.45
Released for download on November 26, 2024.
### Functional changes
- Support for mTLS connections to Global Secure Access. 
> [!NOTE]
> The mTLS connection will have a gradual rollout to customers through the service in the cloud; customers will continue to use the Transport Layer Security (TLS) connection until they receive mTLS.
- Support for restricting nonprivileged users from disabling and enabling the Global Secure Access client on their device.
- Show health check tests when loading a log zip file to advanced diagnostics.
- Support for the Hyper-V internal switch: the Global Secure Access client installed on the host bypasses network traffic from Hyper-V guest machines. If needed, the Global Secure Access client can be installed on the guest machine, on the host machine, or both. 
> [!NOTE]
> The Global Secure Access client doesn't support host machines that have a Hyper-V external virtual switch.
- The forwarding profile update is triggered when a user signs in to Windows.
- Global Secure Access client's driver events are written to the Event Viewer under:    
`Applications and Services Logs > Microsoft > Windows > Global Secure Access > Kernel`
- Performance improvements for tunneled network traffic.
- Notifications when entering and exiting captive portal are turned off by default.
- On the Advanced diagnostics **Traffic** tab, status information appears across two columns: the **Connection status** and **Status Details**. If the Global Secure Access service stops a connection (for example, due to a filtering policy set to block), the **Connection status** column shows "Terminated" and the **Status Details** column shows the reason for the termination.  
- To accommodate when sign-in is required, the sign-in window is shown even if Windows notifications are disabled.
### Other changes
- Renamed services:
    - "Global Secure Access Management Service" is now called "Global Secure Access Engine Service."
    - "Global Secure Access Auto Upgrade Service" is now called "Global Secure Access Client Manager Service."
- The client's stale registry keys are deleted on uninstall.
- Bug fix: the policy retriever service stops polling for new policies when it encounters an error.
- The collected logs zip file name now contains the Global Secure Access client version number.
- Recovery after failures of the tunneling service.
- Telemetry is enabled for test tenants.
- Enhancements to log collection.
- Improvements and bug fixes for Advanced diagnostics.
- Miscellaneous bug fixes and improvements.

## Version 2.1.149
Released for download on August 27, 2024.
### Functional changes
- Coexistence with Azure VPN.
- Loading the health check results in advanced diagnostics from a zip file (created by collect logs).
- The **Pause** and **Resume** buttons were renamed to **Disable** and **Enable**.
### Other changes
- Miscellaneous bug fixes and improvements.

## Version 2.1.102
Released for download on July 30, 2024.
### Functional changes
- Support for coexistence with Netskope.
- Support for client installation on Azure virtual machines (VMs).
- Support for sign out.
- Icon update and event logs when user disables Private Access.
### Other changes
- Stabilization and reliability of the system tray icon status.
- Captive portal detection improvements.
- Bug fix: system tray icon crashes when registry keys are manually misconfigured.
- Miscellaneous bug fixes and improvements.

## Versions 2.0.0 and 1.8.239
Released for download on July 11, 2024.
### Functional changes
- First GA version.

## Related content
- [Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md)
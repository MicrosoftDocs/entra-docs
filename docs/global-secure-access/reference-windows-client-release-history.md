---
title: Global Secure Access Client for Windows Release Notes
description: This article tracks the changes in each released version of the Global Secure Access client for Windows.
ms.topic: reference
ms.date: 12/03/2025
ms.author: jayrusso
author: HULKsmashGithub
ms.reviewer: lirazbarak
ai-usage: ai-assisted

---
# Global Secure Access client for Windows release notes
This article lists the released versions of the Global Secure Access client for Windows and the changes in each version.   

## Download the latest version
You can download the current version of the Global Secure Access client from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select **Download Client**.
:::image type="content" source="media/reference-windows-client-release-history/client-download-screen.png" alt-text="Screenshot of the client download screen with the Download Client button highlighted.":::

## Version 2.24.117
Released for download on December 3, 2025.
### Functional changes
- Support for [Intelligent Local Access](enable-intelligent-local-access.md).
- Support for [B2B guest access](concept-b2b-guest-access.md).
- The client package includes a tracert tool.
- Support to display the **Disable Private Access** button when the **Disable** button is hidden. For details, see [Hide or unhide system tray menu buttons](how-to-install-windows-client.md#hide-or-unhide-system-tray-menu-buttons).
- The Global Secure Access interface includes a **View account** link to the user's Microsoft Entra **My Account** homepage.
### Other changes
- Improved error messages when installing client version intended for a different platform (x64 client on an Arm device or Arm client on an x64 device).
- Logs collect Kerberos registry keys.
- Improved log writing to event trace log (ETL) files.
- The health check test for NRPT rules supports non-English versions of Windows.
- The client installer includes .NET Runtime version 8.0.21.
- The client installer includes OneAuth version 6.5.0.
- New telemetries are available.
- Miscellaneous bug fixes and improvements.   

## Version 2.22.90
Released for download on November 5, 2025.
### Functional changes
- A new Windows service, **Global Secure Access Forwarding Profile Service**, replaces the previous **Global Secure Access Policy Retriever Service**.
- Support for interactive sign-in to get the forwarding profile, for example, if MFA or Terms of Use are required.
- The **Get policy** button lets you poll the Global Secure Access cloud service for the latest forwarding profile.
- Bug fix: the client uses Private DNS only when the Private Access channel is active.
### Other changes
- New telemetries are available.
- Miscellaneous bug fixes and improvements.

## Version 2.20.56
Released for download on June 24, 2025.
### Functional changes
- You can download a new Global Secure Access client installer for Windows on Arm in the portal.
- A new client user interface with channel status, a troubleshooting section, and settings. To open the interface, double-click the Global Secure Access icon in the system tray.
- Telemetry collection is enabled.
- The new UI includes a link to Microsoft's privacy policy to comply with the telemetry collection policy.
- The client supports non-ASCII characters in the OS name.
- The Advanced Diagnostics tool has accessibility improvements.
- The Global Secure Access client cleans up Name Resolution Policy Table (NRPT) rules when it starts in "Private Access disabled" mode.
- The client supports DNS records that point to an IP in the 127.0.0.0/8 address range.       
### Other changes
- .NET Runtime is upgraded to version 8.0.14.
- OneAuth is upgraded to version 5.6.0.    
- Improvements and bug fixes for Advanced diagnostics.   
- Miscellaneous bug fixes and improvements.   

## Version 2.18.62
Released for download on April 29, 2025.
### Functional changes
- Bug fix: Canonical name (CNAME) records resolve as A records to fix a Kerberos browser authentication issue.   
- The default client authentication is Web Account Manager (WAM).   
### Other changes
- Bug fix: the client retries connecting to traffic profiles after you remove them from the portal.   
- Bug fix: adds support for operating system names with non-ASCII characters, relevant for some non-English Windows versions.   
- Added and improved health check tests.   
- Improvements and bug fixes for Advanced diagnostics.   
- Miscellaneous bug fixes and improvements.   

## Version 2.14.80
Released for download on February 26, 2025.
### Functional changes
- Adds support for long-lived User Datagram Protocol (UDP) connections.
- Adds support for routing connections directly to the network when there's no successful tunnel established to the Global Secure Access cloud service.
- Adds performance counters to Performance Monitor:
    - Flow count
    - Tunnel count
- Adds support for Microsoft Cloud for Sovereignty environments.
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
- Adds support for mTLS connections to Global Secure Access. 
> [!NOTE]
> The mTLS connection rolls out gradually to customers through the cloud service. Customers continue to use the Transport Layer Security (TLS) connection until they receive mTLS.
- Adds support for restricting nonprivileged users from disabling and enabling the Global Secure Access client on their device.
- Shows health check tests when loading a log zip file to Advanced diagnostics.
- Adds support for the Hyper-V internal switch: the Global Secure Access client installed on the host bypasses network traffic from Hyper-V guest machines. If needed, the Global Secure Access client can be installed on the guest machine, on the host machine, or both. 
> [!NOTE]
> The Global Secure Access client doesn't support host machines with a Hyper-V external virtual switch.
- Triggers the forwarding profile update when a user signs in to Windows.
- Writes Global Secure Access client's driver events to the Event Viewer under:    
`Applications and Services Logs > Microsoft > Windows > Global Secure Access > Kernel`
- Performance improvements for tunneled network traffic.
- Notifications for entering and exiting captive portals are off by default.
- On the Advanced diagnostics **Traffic** tab, status information appears in two columns: **Connection status** and **Status Details**. If the Global Secure Access service stops a connection (for example, due to a filtering policy set to block), the **Connection status** column shows "Terminated" and the **Status Details** column shows the reason for the termination.  
- Shows the sign-in window even if Windows notifications are disabled to accommodate when sign-in is required.
### Other changes
- Renamed services:
    - "Global Secure Access Management Service" is now "Global Secure Access Engine Service."
    - "Global Secure Access Auto Upgrade Service" is now "Global Secure Access Client Manager Service."
- Deletes the client's stale registry keys during uninstall.
- Bug fix: the policy retriever service stops polling for new policies when it encounters an error.
- The collected logs zip file name now contains the Global Secure Access client version number.
- Recovery after failures of the tunneling service.
- Enables telemetry for test tenants.
- Enhancements to log collection.
- Improvements and bug fixes for Advanced diagnostics.
- Miscellaneous bug fixes and improvements.

## Version 2.1.149
Released for download on August 27, 2024.
### Functional changes
- Adds support for coexistence with Azure VPN.
- Loads the health check results in advanced diagnostics from a zip file (created by collect logs).
- Renames the **Pause** and **Resume** buttons to **Disable** and **Enable**.
### Other changes
- Miscellaneous bug fixes and improvements.

## Version 2.1.102
Released for download on July 30, 2024.
### Functional changes
- Adds support for coexistence with Netskope.
- Adds support for installing the client on Azure virtual machines (VMs).
- Adds support for signing out.
- The client updates the status icon and event logs when the user disables Private Access.
### Other changes
- Improves stabilization and reliability of the system tray icon status.
- Improves captive portal detection.
- Bug fix: system tray icon crashes when registry keys are manually misconfigured.
- Miscellaneous bug fixes and improvements.

## Versions 2.0.0 and 1.8.239
Released for download on July 11, 2024.
### Functional changes
- First GA version.

## Related content
- Learn how to install the [Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md).

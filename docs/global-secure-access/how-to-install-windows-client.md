---
title: The Global Secure Access Client for Windows
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the Windows client.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 01/10/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazbarak


# Customer intent: Windows users, I want to download and install the Global Secure Access client.
---
# Global Secure Access client for Microsoft Windows
The Global Secure Access client, an essential component of Global Secure Access, helps organizations manage and secure network traffic on end-user devices. The client's main role is to route traffic that needs to be secured by Global Secure Access to the cloud service. All other traffic goes directly to the network. The [Forwarding Profiles](concept-traffic-forwarding.md), configured in the portal, determine which traffic the Global Secure Access client routes to the cloud service.

>[!NOTE]
>The Global Secure Access Client is available for macOS, Android and iOS. To learn how to install the Global Secure Access client on the different platforms, see [Global Secure Access client for macOS](how-to-install-macos-client.md), [Global Secure Access client for Android](how-to-install-android-client.md), and [Global Secure Access client for iOS](how-to-install-ios-client.md).

This article describes how to download and install the Global Secure Access client for Windows.

## Prerequisites

- A Microsoft Entra tenant onboarded to Global Secure Access.
- A managed device joined to the onboarded tenant. The device must be either Microsoft Entra joined or Microsoft Entra hybrid joined. 
   - Microsoft Entra registered devices aren't supported.
- The Global Secure Access client requires a 64-bit version of Windows 10 or Windows 11.
   - Azure Virtual Desktop single-session is supported.
   - Azure Virtual Desktop multi-session isn't supported.
   - Windows 365 is supported.
- Local administrator credentials are required to install or upgrade the client.
- The Global Secure Access client requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## Download the client

The most current version of the Global Secure Access client is available to download from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select **Download Client**.
:::image type="content" source="media/how-to-install-windows-client/client-download-screen.png" alt-text="Screenshot of the Client download screen with the Download Client button highlighted.":::
    
## Install the Global Secure Access client
### Automated installation
Organizations can install the Global Secure Access client silently with the `/quiet` switch, or use Mobile Device Management (MDM) solutions, such as [Microsoft Intune](/mem/intune/apps/apps-win32-app-management) to deploy the client to their devices.

### Manual installation
To manually install the Global Secure Access client:
1. Run the *GlobalSecureAccessClient.exe* setup file. Accept the software license terms.
1. The client installs and silently signs you in with your Microsoft Entra credentials. If the silent sign-in fails, the installer prompts you to sign in manually.
1. Sign in. The connection icon turns green. 
1. Hover over the connection icon to open the client status notification, which should show as **Connected**.   
:::image type="content" source="media/how-to-install-windows-client/global-secure-access-client-installed-connected.png" alt-text="Screenshot showing the client is connected.":::

## Client actions
To view the available client menu actions, right-click the Global Secure Access system tray icon.
:::image type="content" source="media/how-to-install-windows-client/client-install-all-actions.png" alt-text="Screenshot showing the complete list of Global Secure Access client actions.":::

> [!TIP]
> The Global Secure Access client menu actions will vary according to your [Client registry keys](#client-registry-keys) configuration.

|Action   |Description  |
|---------|---------|
|**Sign out**   |*Hidden by default*. Use the **Sign out** action when you need to sign in to the Global Secure Access client with a Microsoft Entra user other than the one used to sign in to Windows. To make this action available, update the appropriate [Client registry keys](#client-registry-keys).         |
|**Disable**   |Select the **Disable** action to disable the client. The client remains disabled until you either enable the client or restart the machine.         |
|**Enable**   |Enables the Global Secure Access client.         |
|**Disable Private Access**   |*Hidden by default*. Use the **Disable Private Access** action when you wish to bypass Global Secure Access whenever you connect your device directly to the corporate network to access private applications directly through the network rather than through Global Secure Access. To make this action available, update the appropriate [Client registry keys](#client-registry-keys).         |
|**Collect logs**   |Select this action to collect client logs (information about the client machine, the related event logs for the services, and registry values) and archive them in a zip file to share with Microsoft Support for investigation. The default location for the logs is `C:\Program Files\Global Secure Access Client\Logs`.   You can also collect client logs on Windows by entering the following command in the Command Prompt: `C:\Program Files\Global Secure Access Client\LogsCollector\LogsCollector.exe" <username> <user>`.      |
|**Advanced diagnostics**   |Select this action to launch the Advanced diagnostics utility and access an assortment of [troubleshooting](#troubleshooting) tools.         |

## Client status indicators
### Status notification
Double-click the Global Secure Access icon to open the client status notification and view the status of each channel configured for the client.   
:::image type="content" source="media/how-to-install-windows-client/install-windows-client-client-status.png" alt-text="Screenshot showing the client status is connected.":::

### Client statuses in system tray icon

|Icon    |Message    |Description    |
|---------|---------|---------|
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-initializing.png":::	|Global Secure Access |The client is initializing and checking its connection to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-connected.png":::	|Global Secure Access - Connected	|The client is connected to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-disabled.png":::   |Global Secure Access - Disabled	|The client is disabled because services are offline or the user disabled the client.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-disconnected.png":::	|Global Secure Access - Disconnected	|The client failed to connect to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access - Some channels are unreachable	|The client is partially connected to Global Secure Access (that is, the connection to at least one channel failed: Microsoft Entra, Microsoft 365, Private Access, Internet Access).    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access - Disabled by your organization	|Your organization disabled the client (that is, all traffic forwarding profiles are disabled).    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access - Private Access is disabled	 |The user disabled Private Access on this device.    |
|:::image type="icon" source="media/how-to-install-windows-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access - could not connect to the Internet	|The client couldn't detect an internet connection. The device is either connected to a network that doesn't have an Internet connection or a network that requires captive portal sign in.    |

## Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Troubleshooting
To troubleshoot the Global Secure Access client, right-click the client icon in the taskbar and select one of the troubleshooting options: **Collect logs** or **Advanced diagnostics**.

> [!TIP]
> Administrators can modify the Global Secure Access client menu options by revising the [Client registry keys](#client-registry-keys).

For more detailed information on troubleshooting the Global Secure Access client, see the following articles:
- [Troubleshoot the Global Secure Access client: advanced diagnostics](troubleshoot-global-secure-access-client-advanced-diagnostics.md)
- [Troubleshoot the Global Secure Access client: Health check tab](troubleshoot-global-secure-access-client-diagnostics-health-check.md)

## Client registry keys
The Global Secure Access client uses specific registry keys to enable or disable different functionalities. Administrators can use a Mobile Device Management (MDM) solutions, such as Microsoft Intune or Group Policy to control the registry values.
> [!CAUTION] 
> Do not change other registry values unless instructed by Microsoft Support.

### Restrict nonprivileged users
The administrator can prevent nonprivileged users on the Windows device from disabling or enabling the client by setting the following registry key:   
`Computer\HKEY_LOCAL_MACHINE\Software\Microsoft\Global Secure Access Client`   
`RestrictNonPrivilegedUsers REG_DWORD`

|Data|Description|
|--|--|
| 0x0 | Nonprivileged users on the Windows device can disable and enable the client. |
| 0x1 | Nonprivileged users on the Windows device are restricted from disabling and enabling the client. A UAC prompt requires local administrator credentials for disable and enable options. The administrator can also hide the disable button (see [Hide or unhide system tray menu buttons](#hide-or-unhide-system-tray-menu-buttons)). |

### Disable or enable Private Access on the client
This registry value controls whether Private Access is enabled or disabled for the client. If a user is connected to the corporate network, they can choose to bypass Global Secure Access and directly access private applications.

Users can disable and enable Private Access through the system tray menu.

> [!TIP]
> This option is available on the menu only if it is not hidden (see [Hide or unhide system tray menu buttons](#hide-or-unhide-system-tray-menu-buttons)) and Private Access is enabled for this tenant.

Administrators can disable or enable Private Access for the user by setting the registry key:   
`Computer\HKEY_CURRENT_USER\Software\Microsoft\Global Secure Access Client`

|Value  |Type  |Data  |Description  |
|---------|---------|---------|---------|
|IsPrivateAccessDisabledByUser  |REG_DWORD  |0x0  |Private Access is enabled on this device. Network traffic to private applications goes through Global Secure Access.  |
|IsPrivateAccessDisabledByUser  |REG_DWORD  |0x1  |Private Access is disabled on this device. Network traffic to private applications goes directly to the network.  |

:::image type="content" source="media/how-to-install-windows-client/global-secure-access-registry-key-private-access-enabled.png" alt-text="Screenshot showing the Registry Editor with the IsPrivateAccessDisabledByUser registry key highlighted.":::
	
If the registry value doesn't exist, the default value is 0x0, Private Access is enabled.

### Hide or unhide system tray menu buttons
The administrator can show or hide specific buttons in the client system tray icon menu. Create the values under the following registry key:   
`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client`

|Value   |Type   |Data   |Default behavior   |Description   |
|---------|---------|---------|---------|---------|
|HideSignOutButton   |REG_DWORD   |0x0 - shown   0x1 - hidden   |hidden   |Configure this setting to show or hide the **Sign out** action. This option is for specific scenarios when a user needs to sign in to the client with a different Microsoft Entra user than the one used to sign in to Windows. Note: You must sign in to the client with a user in the same Microsoft Entra tenant to which the device is joined. You can also use the **Sign out** action to reauthenticate the existing user.         |
|HideDisablePrivateAccessButton   |REG_DWORD   |0x0 - shown   0x1 - hidden   |hidden   |Configure this setting to show or hide the **Disable Private Access** action. This option is for a scenario when the device is directly connected to the corporate network and the user prefers accessing private applications directly through the network instead of through the Global Secure Access.   |   
|HideDisableButton   |REG_DWORD   |0x0 - shown   0x1 - hidden   |shown   |Configure this setting to show or hide the **Disable** action. When visible, the user can disable the Global Secure Access client. The client remains disabled until the user enables it again. If the **Disable** action is hidden, a nonprivileged user can't disable the client.   |

:::image type="content" source="media/how-to-install-windows-client/global-secure-access-registry-key-private-hide-signout.png" alt-text="Screenshot showing the Registry Editor with the HideSignOutButton and HideDisablePrivateAccessButton registry keys highlighted.":::

For more information, see [Guidance for configuring IPv6 in Windows for advanced users](/troubleshoot/windows-server/networking/configure-ipv6-in-windows).

## Related content
- [Global Secure Access client for macOS](how-to-install-macos-client.md)
- [Global Secure Access client for Android](how-to-install-android-client.md)
- [Global Secure Access client for iOS](how-to-install-ios-client.md)

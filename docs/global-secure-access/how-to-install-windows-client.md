---
title: The Global Secure Access Client for Windows
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the Windows client.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 06/19/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: lirazbarak
ms.custom: sfi-image-nochange

# Customer intent: Windows users, I want to download and install the Global Secure Access client.
---
# Install the Global Secure Access client for Microsoft Windows
The Global Secure Access client is an essential part of Global Secure Access. It helps you manage and secure network traffic on end-user devices. The client routes traffic that needs to be secured by Global Secure Access to the cloud service. All other traffic goes directly to the network. The [Forwarding Profiles](concept-traffic-forwarding.md) you set up in the portal decide which traffic the Global Secure Access client routes to the cloud service.

> [!NOTE]
> The Global Secure Access Client is also available for macOS, Android, and iOS. To learn how to install the Global Secure Access client on these platforms, see [Global Secure Access client for macOS](how-to-install-macos-client.md), [Global Secure Access client for Android](how-to-install-android-client.md), and [Global Secure Access client for iOS](how-to-install-ios-client.md).   

This article describes how to download and install the Global Secure Access client for Windows.

## Prerequisites

- A Microsoft Entra tenant onboarded to Global Secure Access.
- A managed device joined to the onboarded tenant. The device must be either Microsoft Entra joined or Microsoft Entra hybrid joined. 
   - Microsoft Entra registered devices aren't supported.
- The Global Secure Access client needs a 64-bit version of Windows 10 or Windows 11, or an Arm64 version of Windows 11.
   - Azure Virtual Desktop single-session is supported.
   - Azure Virtual Desktop multi-session isn't supported.
   - Windows 365 is supported.
- You need local admin credentials to install or upgrade the Global Secure Access client.
- The Global Secure Access client needs a license. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [buy licenses or get trial licenses](https://aka.ms/azureadlicense).

## Download the client

The most current version of the Global Secure Access client is available to download from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select **Download Client**.
:::image type="content" source="media/how-to-install-windows-client/client-download-screen.png" alt-text="Screenshot of the Client download screen with the Download Client button highlighted.":::
    
## Install the Global Secure Access client
### Automated installation
Organizations can install the Global Secure Access client silently with the `/quiet` switch, or use Mobile Device Management (MDM) solutions, such as [Microsoft Intune](/mem/intune/apps/apps-win32-app-management) to deploy the client to their devices.

### Deploy Global Secure Access client with Intune

In this section, you learn how to manually install the Global Secure Access client on a Windows 11 client device with Intune.

#### Prerequisites

- A security group with devices or users to identify where to install the Global Secure Access client

#### Package the client

Convert the `.exe` file to a `.intunewin` file.

1. Download the Global Secure Access client from the [Microsoft Entra admin center](https://entra.microsoft.com/) > **Global Secure Access** > **Connect** > **Client download**. Select **Download client** under Windows 11.
1. Go to [Microsoft Win32 Content Prep Tool](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool). Select **IntuneWinAppUtil.exe**.

   :::image type="content" source="media/how-to-install-windows-client/install-content-prep-tool.png" alt-text="Screenshot of prep tool install file selection.":::

1. In the top right corner, select the **More file actions** and then select **Download**.

   :::image type="content" source="media/how-to-install-windows-client/raw-file-download.png" alt-text="Screenshot of More file actions menu to select Download.":::

1. Navigate to and run `IntuneWinAppUtil.exe`. A command prompt opens.
1. Enter the folder path location of the Global Secure Access `.exe` file. Select **Enter**.
1. Enter the name of the Global Secure Access `.exe` file. Select **Enter**.
1. Enter the folder path in which to place the `.intunewin` file. Select **Enter**.
1. Enter **N**. Select **Enter**.

   :::image type="content" source="media/how-to-install-windows-client/install-from-command-line.png" alt-text="Screenshot of command line to install client.":::

The `.intunewin` file is ready for you to deploy Microsoft Intune.

#### Deploy Global Secure Access client with Intune

Reference detailed guidance to [Add and assign Win32 apps to Microsoft Intune](/mem/intune/apps/apps-win32-add#add-a-win32-app-to-intune).

1. Navigate to [https://intune.microsoft.com](https://intune.microsoft.com/).
1. Select **Apps** > **All apps** > **Add**.
1. On **Select app type**, under **Other** app types, select **Windows app (Win32)**.
1. Select **Select**. The **Add app** steps appear.
1. Select **Select app package file**.
1. Select the folder icon. Open the `.intunewin` file you created in the previous section.

   :::image type="content" source="media/how-to-install-windows-client/app-package-file.png" alt-text="Screenshot of App package file selection.":::

1. Select **OK**.
1. Configure these fields:

   - **Name**: Enter a name for the client app.
   - **Description**: Enter a description.
   - **Publisher**: Enter **Microsoft**.
   - **App Version** *(optional)*: Enter the client version.

1. You can use the default values in the remaining fields. Select **Next**.

   :::image type="content" source="media/how-to-install-windows-client/add-app.png" alt-text="Screenshot of Add App to install client.":::

1. Configure these fields:

   - **Install command**: Use the original name of the `.exe` file for `"OriginalNameOfFile.exe" /install /quiet /norestart`.
   - **Uninstall command**: Use the original name of the `.exe` file for `"OriginalNameOfFile.exe" /uninstall /quiet /norestart`.
   - **Allow available uninstall**: Select **No**.
   - **Install behavior**: Select **System**.
   - **Device restart behavior**: Select **Determine behavior based on return codes**.

|Return code|Code type|
|-----------|---------|
|0|Success|
|1707|Success|
|3010|Success|
|1641|Success|
|1618|Retry|

> [!NOTE]
> The Return codes populate with default Windows exit codes. In this case, we changed two of the code types to **Success** to avoid unnecessary device reboots.

   :::image type="content" source="media/how-to-install-windows-client/program-install-parameters.png" alt-text="Screenshot of Program to configure installation parameters.":::

1. Select **Next**.
1. Configure these fields:

   - **Operating system architecture**: Select your minimum requirements.
   - **Minimum operating system**: Select your minimum requirements.

   :::image type="content" source="media/how-to-install-windows-client/requirements-install-parameters.png" alt-text="Screenshot of Requirements to configure installation parameters.":::

1. Leave the remaining fields blank. Select **Next**.
1. Under **Rules format**, select **Manually configure detection rules**.
1. Select **Add**.
1. Under **Rule type**, select **File**.
1. Configure these fields:

   - **Path**: Enter `C:\Program Files\Global Secure Access Client\TrayApp`.
   - **File or folder**: Enter `GlobalSecureAccessClient.exe`.
   - **Detection method**: Select **String (version)**.
   - **Operator**: Select **Greater than or equal to**.
   - **Value**: Enter the client version number.
   - **Associated with a 32-bit app on 64-bit client**: Select **No**.

   :::image type="content" source="media/how-to-install-windows-client/detection-rule.png" alt-text="Screenshot of Detection rule for client.":::

1. Select **OK**. Select **Next**.
1. Select **Next** two more times to get to **Assignments**.
1. Under **Required**, select **+Add group**. Select a group of users or devices. Select **Select**.
1. Select **Next**. Select **Create**.

#### Update the client to a newer version

To update to the newest client version, follow the [Update a line-of-business app](/mem/intune/apps/lob-apps-windows#update-a-line-of-business-app) steps. Be sure to update the following settings in addition to uploading the new `.intunewin` file:

- Client version
- Install and uninstall commands
- Detection rule value set to the new client version number

In a production environment, it's best practice to deploy new client versions in a phased deployment approach:

1. Leave the existing app in place for now.
1. Add a new app for the new client version, repeating the previous steps.
1. Assign the new app to a small group of users to pilot the new client version. It's okay to assign these users to the app with the old client version for an in-place upgrade.
1. Slowly increase the membership of the pilot group until you deploy the new client to all desired devices.
1. Delete the app with the old client version.

### Manual installation
To manually install the Global Secure Access client:
1. Run the *GlobalSecureAccessClient.exe* setup file. Accept the software license terms.
1. The client installs and silently signs you in with your Microsoft Entra credentials. If the silent sign-in fails, the installer prompts you to sign in manually.
1. Sign in. The connection icon turns green. 
1. Hover over the connection icon to open the client status notification, which should show as **Connected**.   
:::image type="content" source="media/how-to-install-windows-client/global-secure-access-client-installed-connected.png" alt-text="Screenshot showing the client is connected.":::

## Client interface
To open the Global Secure Access client interface, select the Global Secure Access icon in the system tray. The client interface provides a view of the current connection status, the channels configured for the client, and access to diagnostics tools.    

### Connections view
From the **Connections** view, you can see the client **Status** and the **Channels** configured for the client. If you wish to disable the client, select the **Disable** button. You can use the information in the **Additional details** section to help troubleshoot the client connection. Select **Show more details** to expand the section and view additional information.   
:::image type="content" source="media/how-to-install-windows-client/client-interface-connections.png" alt-text="Screenshot of the Connections view of the Global Secure Access client interface.":::   

### Troubleshooting view
From the **Troubleshooting** view, you can perform various diagnostics tasks. You can export and share logs with your IT admin. You can also access the **Advanced diagnostics** tool, which provides an assortment of troubleshooting tools. Note: you can also launch the **Advanced diagnostics** tool from the client system tray icon menu.   
:::image type="content" source="media/how-to-install-windows-client/client-interface-troubleshooting.png" alt-text="Screenshot of the Troubleshooting view of the Global Secure Access client interface.":::   

### Settings view
Switch to the **Settings** view to check the installed **Version** or access the **Microsoft Privacy Statement**.   
:::image type="content" source="media/how-to-install-windows-client/client-interface-settings.png" alt-text="Screenshot of the Settings view of the Global Secure Access client interface.":::   

## Client actions
To view the available client menu actions, right-click the Global Secure Access system tray icon.   
:::image type="content" source="media/how-to-install-windows-client/client-install-all-actions.png" alt-text="Screenshot showing the complete list of Global Secure Access client actions.":::

> [!TIP]
> The Global Secure Access client menu actions vary according to your [Client registry keys](#client-registry-keys) configuration.

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
> Don't change other registry values unless instructed by Microsoft Support.

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
> This option is available on the menu only if it isn't hidden (see [Hide or unhide system tray menu buttons](#hide-or-unhide-system-tray-menu-buttons)) and Private Access is enabled for this tenant.

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

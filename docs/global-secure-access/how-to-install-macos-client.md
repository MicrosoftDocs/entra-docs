---
title: The Global Secure Access Client for macOS
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the macOS client.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 02/25/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: femila
ms.reviewer: lirazbarak
ms.custom: sfi-image-nochange
# Customer intent: macOS users, I want to download and install the Global Secure Access client.
---
# Global Secure Access client for macOS (Preview)
> [!IMPORTANT]
> The Global Secure Access client for macOS is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

The Global Secure Access client, an essential component of Global Secure Access, helps organizations manage and secure network traffic on end-user devices. The client's main role is to route traffic that needs to be secured by Global Secure Access to the cloud service. All other traffic goes directly to the network. The [Forwarding Profiles](concept-traffic-forwarding.md), configured in the portal, determine which traffic the Global Secure Access client routes to the cloud service.

This article describes how to download and install the Global Secure Access client for macOS.

## Prerequisites

- A Mac device with an Intel, M1, M2, M3, or M4 processor, running macOS version 13 or newer.
- A device registered to Microsoft Entra tenant using Company Portal.
- A Microsoft Entra tenant onboarded to Global Secure Access.
- Deployment of the [Microsoft Enterprise single sign-on (SSO) plug-in for Apple devices](../identity-platform/apple-sso-plugin.md) is recommended for SSO experience based on the user who is signed in to the company portal.   
- An internet connection.

## Download the client

The most current version of the Global Secure Access client is available to download from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select **Download Client**.
:::image type="content" source="media/how-to-install-macos-client/macos-client-download-screen-PubPreview.png" alt-text="Screenshot of the Client download screen with the Download Client button highlighted.":::
    
## Install the Global Secure Access client
### Automated installation
Use the following command for silent installation. 
*Substitute your file path according to the download location of the .pkg file.*

`sudo installer -pkg ~/Downloads/GlobalSecureAccessClient.pkg -target / -verboseR`

The client uses system extensions and a transparent application proxy that need to be approved during the installation. For a silent deployment without prompting the end user to allow these components, you can deploy a policy to automatically approve the components with mobile device management.

### Allow system extensions through mobile device management (MDM)
The following instructions are for [Microsoft Intune](/mem/intune/apps/apps-win32-app-management) and you can adapt them for different MDMs:

1. In the Microsoft Intune admin center, select **Devices** > **Manage devices** > **Configuration** > **Policies** > **Create** > **New policy**.
1. Create a profile with a **Platform** of **macOS** and a **Profile type** set to **Settings catalog**. Select **Create**.
:::image type="content" source="media/how-to-install-macos-client/macos-client-create-profile.png" alt-text="Screenshot of the Create a profile form with the macOS Platform and Settings catalog Profile type highlighted.":::
1. On the **Basics** tab, enter a name for the new profile and select **Next**.
1. On the **Configuration settings** tab, select **+ Add settings**.
1. In the **Settings picker**, expand the **System Configuration** category and select **System Extensions**.
1. From the **System Extensions** subcategory, select **Allowed System Extensions**.
:::image type="content" source="media/how-to-install-macos-client/macOS-settings-picker.png" alt-text="Screenshot of the Settings picker with the category and subcategory selections highlighted.":::
1. Close the **Settings picker**.
1. In the list of **Allowed System Extensions**, select **+ Edit instance**.
1. In the **Configure instance** dialog, configure the System Extensions payload settings with the following entries:

|Bundle identifier   |Team identifier   |
|---------|---------|
|com.microsoft.naas.globalsecure.tunnel-df   |UBF8T346G9   |
|com.microsoft.naas.globalsecure-df   |UBF8T346G9   |

10. Select **Save** and **Next**.   
1. On the **Scope tags** tab, add tags as appropriate.
1. On the **Assignments** tab, assign the profile to a group of macOS devices or users.
1. On the **Review + create** tab, review the configuration and select **Create**.

### Allow transparent application proxy through MDM
The following instructions are for [Microsoft Intune](/mem/intune/apps/apps-win32-app-management) and you can adapt them for different MDMs:

1. In the Microsoft Intune admin center, select **Devices** > **Manage devices** > **Configuration** > **Policies** > **Create** > **New policy**.
1. Create a profile for the macOS platform based on a template of type **Custom** and select **Create**.
:::image type="content" source="media/how-to-install-macos-client/macos-client-create-profile-custom.png" alt-text="Screenshot of the Create a profile form with the macOS Platform, Templates Profile type, and Custom template highlighted.":::
1. On the **Basics** tab, enter a **Name** for the profile.   
1. On the **Configuration settings** tab, enter a **Custom configuration profile name**.
1. Keep **Deployment channel** set to "Device channel."
1. Upload an .xml file that contains the following data:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>PayloadUUID</key>
		<string>87cbb424-6af7-4748-9d43-f1c5dda7a0a6</string>
		<key>PayloadType</key>
		<string>Configuration</string>
		<key>PayloadOrganization</key>
		<string>Microsoft Corporation</string>
		<key>PayloadIdentifier</key>
		<string>com.microsoft.naas.globalsecure-df</string>
		<key>PayloadDisplayName</key>
		<string>Global Secure Access Proxy Configuration</string>
		<key>PayloadDescription</key>
		<string>Add Global Secure Access Proxy Configuration</string>
		<key>PayloadVersion</key>
		<integer>1</integer>
		<key>PayloadEnabled</key>
		<true/>
		<key>PayloadRemovalDisallowed</key>
		<true/>
		<key>PayloadScope</key>
		<string>System</string>
		<key>PayloadContent</key>
		<array>
			<dict>
				<key>PayloadUUID</key>
				<string>04e13063-2bb8-4b72-b1ed-45290f91af68</string>
				<key>PayloadType</key>
				<string>com.apple.vpn.managed</string>
				<key>PayloadOrganization</key>
				<string>Microsoft Corporation</string>
				<key>PayloadIdentifier</key>
				<string>com.microsoft.naas.globalsecure-df</string>
				<key>PayloadDisplayName</key>
				<string>Global Secure Access Proxy Configuration</string>
				<key>PayloadDescription</key>
				<string/>
				<key>PayloadVersion</key>
				<integer>1</integer>
				<key>TransparentProxy</key>
				<dict>
					<key>AuthenticationMethod</key>
					<string>Password</string>
					<key>Order</key>
					<integer>1</integer>
					<key>ProviderBundleIdentifier</key>
					<string>com.microsoft.naas.globalsecure.tunnel-df</string>
					<key>ProviderDesignatedRequirement</key>
					<string>identifier "com.microsoft.naas.globalsecure.tunnel-df" and anchor apple generic and certificate 1[field.1.2.840.113635.100.6.2.6] /* exists */ and certificate leaf[field.1.2.840.113635.100.6.1.13] /* exists */ and certificate leaf[subject.OU] = UBF8T346G9</string>
					<key>ProviderType</key>
					<string>app-proxy</string>
					<key>RemoteAddress</key>
					<string>100.64.0.0</string>
				</dict>
				<key>UserDefinedName</key>
				<string>Global Secure Access Proxy Configuration</string>
				<key>VPNSubType</key>
				<string>com.microsoft.naas.globalsecure-df</string>
				<key>VPNType</key>
				<string>TransparentProxy</string>
			</dict>
		</array>
	</dict>
</plist>
```

7. Complete the creation of the profile by assigning users and devices according to your needs.

### Manual interactive installation
To manually install the Global Secure Access client:
1. Run the GlobalSecureAccessClient.pkg setup file. The **Install** wizard launches. Follow the prompts.
1. On the **Introduction** step, select **Continue**.
1. On the **License** step, select **Continue** and then select **Agree** to accept the license agreement.
:::image type="content" source="media/how-to-install-macos-client/macos-install-license-agreement.png" alt-text="Screenshot of the Install wizard on the SumLicense step, showing the software license agreement pop-up.":::
1. On the **Installation** step, select **Install**.
1. On the **Summary** step, when the installation is complete, select **Close**.
1. Allow the Global Secure Access system extension.
    1. In the **System Extension Blocked** dialog, select **Open System Settings**.    
:::image type="content" source="media/how-to-install-macos-client/macos-client-open-system-settings.png" alt-text="Screenshot of the System Extension Blocked dialog box with the Open System Settings highlighted.":::    

    1. Allow the Global Secure Access client system extension by selecting **Allow**.
:::image type="content" source="media/how-to-install-macos-client/macos-allow-blocked-application.png" alt-text="Screenshot of the System Settings, open to the Privacy & Security options, showing a blocked application message, with the Allow button highlighted.":::   

    1. In the **Privacy & Security** dialog, enter your username and password to validate the approval of the system extension. Then select **Modify Settings**.    
:::image type="content" source="media/how-to-install-macos-client/macos-client-credentials.png" alt-text="Screenshot of the Privacy & Security pop-up requesting sign-in credentials and the Modify Settings button highlighted.":::

    1. Complete the process by selecting **Allow** to enable the Global Secure Access client to add proxy configurations.   
:::image type="content" source="media/how-to-install-macos-client/macos-add-proxy.png" alt-text="Screenshot of the Global Secure Access client would like to add proxy configurations pop-up with the Allow button highlighted.":::
   
1. After the installation is complete, you might be prompted to sign in to Microsoft Entra.
> [!NOTE]
> If the [Microsoft Enterprise SSO plug-in for Apple devices](../identity-platform/apple-sso-plugin.md) is deployed, the default behavior is to use single sign-on with the credentials entered in the company portal.   

8. The **Global Secure Access - Connected** icon appears in the system tray, indicating a successful connection to Global Secure Access.   
:::image type="content" source="media/how-to-install-macos-client/macos-client-system-tray-icon-connected.png" alt-text="Screenshot of the system tray with the Global Secure Access - Connected icon highlighted.":::
   
## Upgrade the Global Secure Access client
The client installer supports upgrades. You can use the installation wizard to install a new version on a device that is currently running a previous client version.

For a silent upgrade, use the following command.    
*Substitute your file path according to the download location of the .pkg file.*

`sudo installer -pkg ~/Downloads/GlobalSecureAccessClient.pkg -target / -verboseR`

## Uninstall the Global Secure Access client
To manually uninstall the Global Secure Access client, use the following command.

`sudo /Applications/Global\ Secure\ Access\ Client.app/Contents/Resources/install_scripts/uninstall`

If you're using an MDM, uninstall the client with the MDM.

## Client actions
To view the available client menu actions, right-click the Global Secure Access system tray icon.   
:::image type="content" source="media/how-to-install-macos-client/macos-client-actions.png" alt-text="Screenshot showing the list of Global Secure Access client actions.":::   

|Action   |Description   |
|---------|---------|
|**Disable**   |Disables the client until the user enables it again. When the user disables the client, they're prompted to enter a business justification and reenter their sign-in credentials. The business justification is logged.   |
|**Enable**   |Enables the client.   |
|**Pause**   |Pauses the client for either 10 minutes, until the user resumes the client, or until the device is restarted. When the user pauses the client, they're prompted to enter a business justification and reenter their sign-in credentials. The business justification is logged.   |
|**Resume**   |Resumes the paused client.   |
|**Restart**   |Restarts the client.   |
|**Collect logs**   |Collects client logs and archives them in a zip file to share with Microsoft Support for investigation.   |
|**Settings**   |Opens the Settings and Advanced diagnostics tool.   |
|**About**   |Shows information regarding the product's version.   |


### Client statuses in system tray icon

|Icon    |Message    |Description    |
|---------|---------|---------|
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-initializing.png":::	|Global Secure Access Client	|The client is initializing and checking its connection to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-connected.png":::	|Global Secure Access Client - Connected	|The client is connected to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-disabled.png":::   |Global Secure Access Client - Disabled	|The client is disabled because services are offline or the user disabled the client.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-disconnected.png":::	|Global Secure Access Client - Disconnected	|The client failed to connect to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access Client - Some channels are unreachable	|The client is partially connected to Global Secure Access (that is, the connection to at least one channel failed: Microsoft Entra, Microsoft 365, Private Access, Internet Access).    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access Client - Disabled by your organization	|Your organization disabled the client (that is, all traffic forwarding profiles are disabled).    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access - Private Access is disabled	 |The user disabled Private Access on this device.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access - could not connect to the Internet	|The client couldn't detect an internet connection. The device is either connected to a network that doesn't have an Internet connection or a network that requires captive portal sign in.    |

## Settings and troubleshooting
The Settings window allows you to set different configurations and do some advanced actions.
The settings window contains two tabs:

### Settings

|Option  |Description  |
|---------|---------|
|**Telemetry full diagnostics**     |Sends full telemetry data to Microsoft for application improvement.         |
|**Enable Verbose Logging**     |Enables verbose logging and network capture to be collected when exporting the logs to a zip file.         |

:::image type="content" source="media/how-to-install-macos-client/macos-client-settings-toggles.png" alt-text="Screenshot of the macOS Settings and Troubleshooting view, with the Settings tab selected.":::	

### Troubleshooting

|Action  |Description  |
|---------|---------|
|**Get Latest Policy**     |Downloads and applies the latest forwarding profile for your organization.         |
|**Clear cached data**     |Deletes the client's internal cached data related to authentication, forwarding profile, FQDNs, and IPs.         |
|**Export Logs**     |Exports logs and configuration files related to the client to a zip file.         |
|**Advanced Diagnostics Tool**     |An advanced tool to monitor and troubleshoot the client's behavior.         |

:::image type="content" source="media/how-to-install-macos-client/macos-client-troubleshooting-toggles.png" alt-text="Screenshot of the macOS Settings and Troubleshooting view, with the Troubleshooting tab selected.":::	

## Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Related content
- [Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md)
- [Global Secure Access client for iOS](how-to-install-ios-client.md)
- [Global Secure Access client for Android](how-to-install-android-client.md)

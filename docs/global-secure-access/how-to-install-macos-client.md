---
title: The Global Secure Access client for macOS
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the macOS client.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 10/26/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazbarak


# Customer intent: macOS users, I want to download and install the Global Secure Access client.
---
# Global Secure Access client for macOS
The Global Secure Access client, an essential component of Global Secure Access, helps organizations manage and secure network traffic on end-user devices. The client's main role is to route traffic that needs to be secured by Global Secure Access to the cloud service. All other traffic goes directly to the network. The [Forwarding Profiles](concept-traffic-forwarding.md), configured in the portal, determine which traffic the Global Secure Access client routes to the cloud service.

This article describes how to download and install the Global Secure Access client for macOS.

## Prerequisites

- A Mac device with an Intel, M1, M2, or M3 processor, running macOS version 13 or newer.
- A device registered to Microsoft Entra tenant using Company Portal.
- A Microsoft Entra tenant onboarded to Global Secure Access.
- Deployment of the Microsoft Enterprise SSO plug-in is recommended for SSO experience based on the user who is signed in to the company portal.
- An internet connection.

## Download the client

The most current version of the Global Secure Access client is available to download from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select **Download Client**.
:::image type="content" source="media/how-to-install-macos-client/macOS-client-download-screen-PubPreview.png" alt-text="Screenshot of the Client download screen with the Download Client button highlighted.":::
    
## Install the Global Secure Access client
### Automated installation
Use the following command for silent installation. 
*Substitute your file path and version number according to the download location of the .pkg file.*

`sudo installer -pkg ~/Downloads/GlobalSecureAccessClient_[version].pkg -target / -verboseR`

The client uses system extensions and a transparent application proxy that need to be approved during the installation. For a silent deployment without prompting the end user to allow these components, you can deploy a policy to automatically approve the components.

### Allow system extensions through mobile device management (MDM)
The following instructions are for [Microsoft Intune](/mem/intune/apps/apps-win32-app-management) and you can adapt them for different MDMs:

1. In the Microsoft Intune admin center, select **Devices** > **Manage devices** > **Configuration** > **Policies** > **Create** > **New policy**.
1. Create a profile for the macOS platform based on a template of type **Extensions**. Select **Create**.
:::image type="content" source="media/how-to-install-macos-client/macOS-client-create-profile.png" alt-text="Screenshot of the Create a profile form with the Platform, Profile type, and Template selections highlighted.":::
1. On the **Basics** tab, enter a name for the new profile and select **Next**.
1. On the **Configuration settings** tab, enter the **Bundle identifier** and the **Team identifier** of the two extensions according to the following table. Select **Next**.   
 
|Bundle identifier  |Team identifier  |
|---------|---------|
|com.microsoft.naas.globalsecure.tunnel-df     |UBF8T346G9         |
|com.microsoft.naas.globalsecure-df     |UBF8T346G9         |

5. Complete the creation of the profile by assigning users and devices according to your needs.

### Allow transparent application proxy through MDM
The following instructions are for [Microsoft Intune](/mem/intune/apps/apps-win32-app-management) and you can adapt them for different MDMs:

1. In the Microsoft Intune admin center, select **Devices** > **Manage devices** > **Configuration** > **Policies** > **Create** > **New policy**.
1. Create a profile for the macOS platform based on a template of type **Custom** and select **Create**.
:::image type="content" source="media/how-to-install-macos-client/macOS-client-create-profile-custom.png" alt-text="Screenshot of the Create a profile form with the Platform, Profile type, and Template selections highlighted.":::
1. On the **Basics** tab, enter a **Name** for the profile.
image.png
1. On the **Configuration settings** tab, enter a **Custom configuration profile name**.
1. Keep **Deployment channel** set to "Device channel."
1. Upload an .xml file that contains the following data:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>PayloadDescription</key>
    <string>Ttransparent proxy settings</string>
    <key>PayloadDisplayName</key>
    <string>Global Secure Access Client - AppProxy</string>
    <key>PayloadIdentifier</key>
    <string>com.microsoft.naas.globalsecure-df.</string>
    <key>PayloadType</key>
    <string>Configuration</string>
    <key>PayloadUUID</key>
    <string>68C6A9A4-ECF8-4FB7-BA00-291610F998D6</string>
    <key>PayloadVersion</key>
    <real>1</real>
    <key>TransparentProxy</key>
    <dict>
        <key>AuthName</key>
        <string>NA</string>
        <key>AuthPassword</key>
        <string>NA</string>
        <key>AuthenticationMethod</key>
        <string>Password</string>
        <key>ProviderBundleIdentifier</key>
        <string>com.microsoft.naas.globalsecure.tunnel-df</string>
        <key>RemoteAddress</key>
        <string>100.64.0.0</string>
        <key>ProviderDesignatedRequirement</key>
        <string>identifier &quot;com.microsoft.naas.globalsecure.tunnel-df&quot; and anchor apple generic and certificate 1[field.1.2.840.113635.100.6.2.6] /* exists */ and certificate leaf[field.1.2.840.113635.100.6.1.13] /* exists */ and certificate leaf[subject.OU] = UBF8T346G9</string>
        <key>Order</key>
        <string>1</string>
    </dict>
    <key>UserDefinedName</key>
    <string>Global Secure Access Client - AppProxy</string>
    <key>VPNSubType</key>
    <string>com.microsoft.naas.globalsecure.tunnel-df</string>
    <key>VPNType</key>
    <string>TransparentProxy</string>
</dict>
</plist>
```
:::image type="content" source="media/how-to-install-macos-client/macOS-client-custom-configuration-settings.png" alt-text="Screenshot of the Configuration settings tab showing a portion of the .xml data.":::

5. Complete the creation of the profile by assigning users and devices according to your needs.

### Manual interactive Installation
To manually install the Global Secure Access client:
1. Run the GlobalSecureAccessClient.pkg setup file. The *Install** wizard launches. Follow the prompts.
1. On the **Introduction** step, select **Continue**.
:::image type="content" source="media/how-to-install-macos-client/macOS-install-introduction.png" alt-text="Screenshot of the Install wizard on the Introduction step.":::
1. On the **License** step, select **Continue** and then select **Agree** to accept the license agreement.
:::image type="content" source="media/how-to-install-macos-client/macOS-install-license-agreement.png" alt-text="Screenshot of the Install wizard on the SumLicense step, showing the software license agreememnt pop-up.":::
1. On the **Install** step, select **Install**.
1. When the installation is complete, select **Close**.
:::image type="content" source="media/how-to-install-macos-client/macOS-install-summary.png" alt-text="Screenshot of the Install wizard on the Summary step.":::
1. Allow the Global Secure Access system extension.
    - In the **System Extension Blocked** dialog, select **Open System Settings**.
:::image type="content" source="media/how-to-install-macos-client/macOS-client-open-systeem-settings.png" alt-text="Screenshot of the System Extension Blocked dialog box with the Open System Settings highlighted.":::    
- Allow the system extension of Global Secure Access client by selecting “allow”.
image.png
Enter username and password to validate the approval of the system extension
image.png
• Finally, select “allow”
image.png
After the installation is completed, the user might be prompted to sign in to Microsoft Entra.
Note: The default behavior is to use single sign-on by the credentials entered in Company Portal, if Microsoft Enterprise SSO plug-in  is deployed.
Few seconds later an icon in the system tray will indicate a successful connection to Global Secure Access (tick mark):
image.png

Client upgrade
The client installer supports upgrades. A new version can be installed on a device that is running a previous client version.

Use the following command for silent upgrade.
Please update the file path and version number, as per the download location of pkg file.

sudo installer -pkg ~/Downloads/GlobalSecureAccessClient_[version].pkg -target / -verboseR

Client uninstall
To manually uninstall the client run the following command:

sudo /Applications/Global\ Secure\ Access\ Client.app/Contents/Resources/install_scripts/uninstall

If you are using an MDM, uninstall the client with the MDM.

Client actions
The following actions are supported by the right-click menu on the system tray icon:

action	description
Disable	Disables the client until it is enabled again by the user. The user will be prompted to enter business justification and re-enter his credentials. The business justification is logged.
Enable	Enables a client that was disabled.
Pause	Pauses the client for 10 minutes, until it is resumed by the user or until the device is restarted. The user will be prompted to enter business justification and re-enter his credentials. The business justification is logged.
Resume	Resumes a client that was paused
Restart	Restarts the client
Collect logs	Collects client logs and archives them in a zip file that can be sent to support for investigation.
Settings	Opens the settings and advanced diagnostics tool.
About	Shows information regarding the product's version.
image.png

### Client statuses in system tray icon

|Icon    |Message    |Description    |
|---------|---------|---------|
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-initializing.png":::	|Global Secure Access Client	|The client is initializing and checking its connection to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-connected.png":::	|Global Secure Access Client - Connected	|The client is connected to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-disabled.png":::   |Global Secure Access Client - Disabled	|The client is disabled because services are offline or the user disabled the client.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-disconnected.png":::	|Global Secure Access Client - Disconnected	|The client failed to connect to Global Secure Access.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access Client - Some channels are unreachable	|The client is partially connected to Global Secure Access (that is, the connection to at least one channel failed: Entra, Microsoft 365, Private Access, Internet Access).    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access Client - Disabled by your organization	|Your organization has disabled the client (that is, all traffic forwarding profiles are disabled).    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access - Private Access is disabled	 |The user disabled Private Access on this device.    |
|:::image type="icon" source="media/how-to-install-macos-client/global-secure-access-client-icon-warning.png":::	|Global Secure Access - could not connect to the Internet	|The client couldn't detect an internet connection. The device is either connected to a network that doesn't have an Internet connection or a network that requires captive portal sign in.    |

## Settings
The settings window allows to set different configurations and to do some advanced actions.
The settings window contains two tabs:

### Settings

|Option  |Description  |
|---------|---------|
|**Telemetry full diagnostics**     |Sends to Microsoft full telemetry data for application improvement.         |
|**Enable Verbose logging**     |Enables verbose logging and network capture to be collected when exporting the logs to a zip file.         |

:::image type="content" source="media/how-to-install-macos-client/macOS-client-settings-toggles.png" alt-text="Screenshot of the macOS Client download screen with the Get early access button highlighted.":::	

### Troubleshooting

|Action  |Description  |
|---------|---------|
|**Get Latest Policy**     |Downloads and applies the latest forwarding profile for your organization.         |
|**Clear cached data**     |Deletes the client's internal cached data related to authentication, forwarding profile, FQDNs and IPs.         |
|**Export Logs**     |Exports logs and configuration files related to the client to a zip file.         |
|**Advanced Diagnostics Tool**     |An advanced tool to monitor and troubleshoot the client's behavior.         |

:::image type="content" source="media/how-to-install-macos-client/macOS-client-troubleshooting-toggles.png" alt-text="Screenshot of the macOS Client download screen with the Get early access button highlighted.":::	

## Known limitations
For a list of known limitations for the Global Secure Access client, see [Global Secure Access known limitations](reference-current-known-limitations.md).

## Remediations
Use the following techniques to mitigate limitations:

### Secure DNS
If Secure DNS is enabled on the browser or in macOS and the DNS server supports Secure DNS, then the client does not tunnel traffic set to be acquired by FQDN (network traffic acquired by IP is not affected and is tunneled according to the forwarding profile). To mitigate the Secure DNS issue, disable Secure DNS, set a DNS server that doesn't support Secure DNS, or create rules based on IP.

### IPv6 is not supported
The client tunnels only IPv4 traffic. IPv6 traffic is not acquired by the client and therefore routed directly to the network.
To make sure that all traffic is routed to Global Secure Access, disable IPv6.

### Connection fallback
In case of a connection error to the cloud service, the client falls back to either direct Internet connection or blocking the connection, based on the hardening value of the matching rule in the forwarding profile (bypass or block).

### Geolocation of source IP address
For network traffic that is tunneled to the cloud service, the application server (website) detects the connection's source IP as the edge's IP address (and not as the user-device's IP address). This scenario might affect services that rely on geolocation.
> [!TIP]
> For Office 365 and Entra to detect the device's true source IP, consider enabling [Source IP restoration](how-to-source-ip-restoration.md).

### QUIC not supported for Internet Access
Since QUIC isn't yet supported for Internet Access, traffic to ports 80 UDP and 443 UDP can't be tunneled.
> [!TIP]
> QUIC is currently supported in Private Access and Microsoft 365 workloads.
Administrators can disable QUIC protocol on browsers, triggering clients to fall back to HTTPS over TCP, which is fully supported in Internet Access. For more information, see [QUIC not supported for Internet Access](troubleshoot-global-secure-access-client-diagnostics-health-check.md#quic-not-supported-for-internet-access).

---
title: The Global Secure Access client for iOS
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the iOS client app.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 09/13/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: dhruvinrshah


# Customer intent: As an iPhone user, I want to download and install the Global Secure Access client.
---
# Global Secure Access client for iOS

This topic describes how to install, configure, update, and use Global Secure Access client on iOS 
devices.

> [!CAUTION]
> Running other third-party endpoint protection products alongside Defender for Endpoint on iOS is likely to cause performance problems and unpredictable system errors.
> [!NOTE]
> - Global Secure Access clients is deployed via Microsoft Defender for Endpoint on iOS.
> - Global Secure Access client on iOS would use a VPN. This VPN is not a regular VPN. Instead, it's a local/self-looping VPN.

## Prerequisites
- To use the Global Secure Access iOS client, be sure to congigure your iOS end-point device as a Microsoft Entra registered device.
- The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- Onboard the tenant to Global Secure Access and configure one or more traffic forwarding profiles. For more information, see [Access the Global Secure Access area of the Microsoft Entra admin center](quickstart-access-admin-center.md).

## Requirements
### Network requirements
For Microsoft Defender for Endpoint on iOS (available in the [Apple App Store](https://apps.apple.com/us/app/microsoft-defender-security/id1526737990)) to function when connected to a network, you must configure the firewall/proxy to [enable access to Microsoft Defender for Endpoint service URLs](/defender-endpoint/configure-environment?view=o365-worldwide#enable-access-to-microsoft-defender-for-endpoint-service-urls-in-the-proxy-server).

> [!NOTE]
> Microsoft Defender for Endpoint on IOS isn't supported on userless or shared devices.

### System requirements
The iOS device (phone or tablet) must meet the following requirements:
- Run iOS 15.0 or newer.
- The Microsoft Authenticator or Intune Company Portal app is installed.
- Device enrollment for Intune device compliance policies to be enforced.

## Supported modes
Global Secure Access client on iOS supports installation on both modes of enrolled devices: supervised and unsupervised devices.

## Known limitations
- Tunneling QUIC (Quick UDP Internet Connections) traffic (except for EXO) is not supported.
- Side by Side with Intune VPN tunnel is not currently supported.
- Compliant network C___ A___ policy for all cloud apps is not currently supported.

## Installation Steps
### Deploy on Device Administrator enrolled devices with Microsoft Intune
1. In the [Microsoft Intune admin center](https://intune.microsoft.com/#home), go to **Apps** > ***iOS/iPadOS** > **Add** > **iOS store app** and 
select **Select**.
1. On the **Add app** page, select **Search the App Store** and type **Microsoft Defender** in the search bar. 
1. In the search results, select **Microsoft Defender** and select **Select**.
1. Select **iOS 15.0** as the minimum operating system. Review the rest of information about the app and select **Next**.
1. In the **Assignments** section, go to the **Required** section and select **Add group**. 
1. Choose the user groups that you would like to target with the Defender for Endpoint on iOS app. 
1. Select **Select** and then **Next**.
> [!NOTE]
> The selected user group should consist of Microsoft Intune enrolled users.
8. In the **Review + Create** section, verify that all the information entered is correct and then 
select **Create**. After a few moments, the Defender for Endpoint app is created successfully, and a notification appears at the top-right corner of the page.
1. On the app information page, in the **Monitor** section, select **Device install status** to verify that the device installation has completed successfully.

### Setup VPN profile and GSA Config for Microsoft Defender for Endpoint
1. In the [Microsoft Intune admin center](https://intune.microsoft.com/#home), go to **Devices** > **Configuration Profiles** > **Create Profile**.
1. Set the **Platform** to **iOS/iPadOS**, the **Profile type** to **Templates**, and the **Template name** to **VPN**. 
Select Create.
1. Type a name for the profile and select **Next**.
1. Set the **Connection Type** to **Custom VPN** and in the **Base VPN** section, enter the following:
- **Connection Name**: Microsoft Defender for Endpoint
- **VPN server address**: 127.0.0.1
- **Auth method**: "Username and password"
- **Split Tunneling**: Disable
- **VPN identifier**: com.microsoft.scmx
- In the key-value pairs: 
    1. Add the key **SilentOnboard** and set the value to **True**.
    1. Add the key **EnableGSA** and set appropriate key values from the table below:

|Key |Value |Details |
|---------|---------|---------|
|EnableGSA |No Value |Global Secure Access in not enabled and tile is not visible. |
|   |0 | Global Secure Access in not enabled and tile is not visible.|
|   |1 | The tile is visible and defaults to false (disabled state). User can enable or disable Global Secure Access using the toggle from the app.|
|   |2 | The tile is visible and defaults to true (enabled state). User can override. User can enable or disable Global Secure Access using the toggle from the app.|
|   |3 | The tile is visible and defaults to true (enabled state). User **cannot** disable Global Secure Access. |

    3. Add other keys as required (optional):
|Key |Value |Details |
|---------|---------|---------|
|EnableGSAPrivateChannel |No Value |Enabled by default. User can enable or disable. |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |

1. Add other key’s if required (optional)
EnableGSAPrivateChannel No Value – Enabled by default. User 
can enable/disable.
0 – GSA in not enabled and Toggle is 
not visible to user.
1 - Toggle is visible and Defaults to 
false(i.e. disabled state). User can 
enable/disable.
2 - Tile is visible and Defaults to 
true(i.e.enabled state). User can 
enable/disable.
3 - Toggle is visible and greyed out 
and Defaults to true(i.e.enabled 
state). – User cannot disable.
EnableGSAInternetChannel No Value – GSA in not enabled and 
Toggle is not visible to user.
0 – GSA in not enabled and Toggle is 
not visible to user.
1 - Toggle is visible and Defaults to 
false(i.e. disabled state). User can 
enable/disable.
2 - Tile is visible and Defaults to 
true(i.e.enabled state). User can 
enable/disable.
3 - Toggle is visible and greyed out 
and Defaults to true(i.e.enabled 
state). – User cannot disable.
o Type of Automatic VPN = On-demand VPN
o Select Add for On Demand Rules and select I want to do the following = Connect 
VPN, I want to restrict to = All domains.
o To mandate that VPN can't be disabled in users device, Admins can select Yes from 
Block users from disabling automatic VPN. By default, it's not configured and 
users can disable VPN only in the Settings.
o To allow Users to Change the VPN toggle from within the app, add 
EnableVPNToggleInApp = TRUE, in the key-value pairs. By default, users can't 
change the toggle from within the app.
1. Select Next and assign the profile to targeted users.
1. In the Review + Create section, verify that all the information entered is correct and then 
select Create.
Once the above configuration is done and synced with the device, the following actions take place 
on the targeted iOS device(s):
• Microsoft Defender for Endpoint will be deployed and silently onboarded and the device will 
be seen in the Defender for Endpoint portal.
• A provisional notification will be sent to the user device.
• Global Secure Access and other features will be activated.
Throubleshooting:
• GSA Tile does not appear in Defender app after onboarding tenant:
o Force Stop Defender app and re-launch it.
• Access to Private Access application shows connection time out error after successful
interactive sign-in
o Reloading the application (web browser refresh) should fix the issue.
Reference
• Microsoft Defender for Endpoint on IOS | Microsoft Learn
• Deploy Microsoft Defender for Endpoint on IOS with Microsoft Intun
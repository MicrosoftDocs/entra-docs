---
title: The Global Secure Access client for iOS
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the iOS client app.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 09/16/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: dhruvinrshah


# Customer intent: As an iPhone user, I want to download and install the Global Secure Access client.
---
# Global Secure Access client for iOS

This article describes how to install, configure, update, and use Global Secure Access client on iOS 
devices. For simplicity, this article refers to both iOS and iPadOS as **iOS**.  

> [!CAUTION]
> Running other third-party endpoint protection products alongside Defender for Endpoint on iOS is likely to cause performance problems and unpredictable system errors.
> [!NOTE]
> - The Global Secure Access client is deployed via Microsoft Defender for Endpoint on iOS.
> - The Global Secure Access client on iOS uses a VPN. This VPN is not a regular VPN. Instead, it's a local/self-looping VPN.

## Prerequisites
- To use the Global Secure Access iOS client, be sure to configure the iOS endpoint device as a Microsoft Entra registered device.
- The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- Onboard the tenant to Global Secure Access and configure one or more traffic forwarding profiles. For more information, see [Access the Global Secure Access area of the Microsoft Entra admin center](quickstart-access-admin-center.md).

## Requirements
### Network requirements
For Microsoft Defender for Endpoint on iOS (available in the [Apple App Store](https://apps.apple.com/us/app/microsoft-defender-security/id1526737990)) to function when connected to a network, you must configure the firewall/proxy to [Enable access to Microsoft Defender for Endpoint service URLs](/defender-endpoint/configure-environment?view=o365-worldwide#enable-access-to-microsoft-defender-for-endpoint-service-urls-in-the-proxy-server).

> [!NOTE]
> Microsoft Defender for Endpoint on iOS isn't supported on userless or shared devices.

### System requirements
The iOS device (phone or tablet) must meet the following requirements:
- The device has iOS 15.0 or newer installed.
- The device has the Microsoft Authenticator app or the Intune Company Portal app installed.
- The device is enrolled to enforce Intune device compliance policies.

## Supported modes
Global Secure Access client on iOS supports installation on both modes of enrolled devices: supervised and unsupervised devices.

## Known limitations
- Tunneling Quick User Datagram Protocol (UDP) Internet Connections (QUIC) traffic (except for EXO) isn't supported.
- Side by Side with Intune VPN tunnel isn't currently supported.
- Compliant network C___ A___ policy for all cloud apps isn't currently supported.

## Installation Steps
### Deploy on Device Administrator enrolled devices with Microsoft Intune
1. In the [Microsoft Intune admin center](https://intune.microsoft.com/#home), go to **Apps** > **iOS/iPadOS** > **Add** > **iOS store app** and 
select **Select**.
:::image type="content" source="media/how-to-install-ios-client/ios-client-add-ios-store-app.png" alt-text="The Microsoft Intune admin center with the steps to add an iOS store app highlighted.":::
1. On the **Add app** page, select **Search the App Store** and type **Microsoft Defender** in the search bar. 
1. In the search results, select **Microsoft Defender** and select **Select**.
1. Select **iOS 15.0** as the minimum operating system. Review the rest of information about the app and select **Next**.
1. In the **Assignments** section, go to the **Required** section and select **Add group**.
:::image type="content" source="media/how-to-install-ios-client/ios-client-add-group.png" alt-text="The Add App screen with the Add group option highlighted.":::   
1. Choose the user groups that you would like to target with the Defender for Endpoint on iOS app. 
> [!NOTE]
> The selected user group should consist of Microsoft Intune enrolled users.   
7. Select **Select** and then **Next**.   
1. In the **Review + Create** section, verify that all the information entered is correct and then 
select **Create**. After a few moments, the Defender for Endpoint app is created successfully, and a notification appears at the top-right corner of the page.
1. On the app information page, in the **Monitor** section, select **Device install status** to verify that the device installation is completed successfully.
:::image type="content" source="media/how-to-install-ios-client/ios-client-device-install-status.png" alt-text="The Device install status screen showing a list of installed devices.":::

### Create a VPN profile and configure Global Secure Access for Microsoft Defender for Endpoint
1. In the [Microsoft Intune admin center](https://intune.microsoft.com/#home), go to **Devices** > **Configuration Profiles** > **Create Profile**.
1. Set the **Platform** to **iOS/iPadOS**, the **Profile type** to **Templates**, and the **Template name** to **VPN**.
1. Select **Create**.
1. Type a name for the profile and select **Next**.
1. Set the **Connection Type** to **Custom VPN**.  
1. In the **Base VPN** section, enter the following:
    - **Connection Name**: Microsoft Defender for Endpoint
    - **VPN server address**: 127.0.0.1
    - **Auth method**: "Username and password"
    - **Split Tunneling**: Disable
    - **VPN identifier**: com.microsoft.scmx
1. In the key-value pairs fields: 
    - Add the key **SilentOnboard** and set the value to **True**.
    - Add the key **EnableGSA** and set the appropriate value from the following table:

        |Key |Value |Details |
        |---------|---------|---------|
        |EnableGSA |No value |Global Secure Access isn't enabled and tile isn't visible. |
        |  |0 | Global Secure Access in not enabled and tile isn't visible.|
        |  |1 | The tile is visible and defaults to false (disabled state). User can enable or disable Global Secure Access using the toggle from the app.|
        |  |2 | The tile is visible and defaults to true (enabled state). User can override. User can enable or disable Global Secure Access using the toggle from the app.|
        |  |3 | The tile is visible and defaults to true (enabled state). User **cannot** disable Global Secure Access. |   

    - Add more key-value pairs as required (optional):  

        |Key |Value |Details |
        |---------|---------|---------|
        |EnableGSAPrivateChannel |No value |Global Secure Access is enabled by default. User can enable or disable. |
        |  |0 |Global Secure Access isn't enabled and toggle isn't visible to user. |
        |  |1 |Toggle is visible and defaults to false (disabled state). User can enable or disable. |
        |  |2 |Tile is visible and defaults to true (enabled state). User can enable or disable. |
        |  |3 |Toggle is visible and grayed out and defaults to true (enabled state). User **cannot** disable Global Secure Access. |
        |EnableGSAInternetChannel  |No value |Global Secure Access isn't enabled and toggle isn't visible to user. |
        |  |0 |Global Secure Access isn't enabled and toggle isn't visible to user. |
        |  |1 |Toggle is visible and defaults to false (disabled state). User can enable or disable. |
        |  |2 |Tile is visible and defaults to true (enabled state). User can enable or disable. |
        |  |3 |Toggle is visible and grayed out and defaults to true (enabled state). User **cannot** disable Global Secure Access. |

1. Continue filling out the VPN form:  
    - **Type of Automatic VPN**: On-demand VPN
    - **On Demand Rules**: select **Add** and then:
        - Set **I want to do the following** to **Connect VPN**.
        - Set **I want to restrict** to **All domains**.
:::image type="content" source="media/how-to-install-ios-client/ios-client-set-up-vpn.png" alt-text="The VPN screen showing example setup parameters.":::
1. To prevent end users from disabling VPN, set **Block users from disabling automatic VPN** to **Yes**. By default, this setting isn't configured and users can disable VPN only in the Settings.   
1. To allow users to use the VPN toggle from within the app, add the key-value pair **EnableVPNToggleInApp = TRUE**. By default, users can't change the toggle from within the app.   
1. Select **Next** and assign the profile to targeted users.
1. In the **Review + Create** section, verify that all the information is correct and then select **Create**.
 
Once the configuration is complete and synced with the device, the following actions take place on the targeted iOS devices:
- Microsoft Defender for Endpoint is deployed and silently onboarded.  
- The device is listed in the Defender for Endpoint portal.  
- A provisional notification is sent to the user device.  
- Global Secure Access and other features are activated.

## Troubleshooting
- The Global Secure Access tile doesn't appear in the Defender app after onboarding the tenant:
    - Force stop the Defender app and relaunch it.
- Access to the Private Access application shows a connection time-out error after a successful interactive sign-in.
    - Reload the application (or refresh the web browser).

## Related content
- [Microsoft Defender for Endpoint on iOS](/defender-endpoint/microsoft-defender-endpoint-ios)
- [Deploy Microsoft Defender for Endpoint on iOS with Microsoft Intune](/defender-endpoint/ios-install)
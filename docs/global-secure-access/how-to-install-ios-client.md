---
title: Install the Global Secure Access Client for iOS
description: The Global Secure Access client helps secure network traffic at the user device. This article describes how to download and install the iOS client.
#customer intent: As an IT admin, I want to set up and deploy the Global Secure Access client for iOS devices so that I can secure network traffic for my organization.
ms.topic: how-to
ms.date: 10/13/2025
ms.author: jayrusso
author: HULKsmashGithub
ms.reviewer: cagautham
ms.custom: sfi-image-nochange

---

# Install the Global Secure Access client for iOS

This article explains how to set up and deploy the Global Secure Access client app on iOS and iPadOS devices. For simplicity, this article refers to both iOS and iPadOS as *iOS*.  

The Global Secure Access client is deployed through Microsoft Defender for Endpoint on iOS. The Global Secure Access client on iOS uses a VPN that isn't a regular VPN. Instead, it's a local/self-looping VPN.

> [!CAUTION]
> Running non-Microsoft endpoint protection products alongside Defender for Endpoint on iOS is likely to cause performance problems and unpredictable system errors.

## Prerequisites

- To use the Global Secure Access iOS client, configure the iOS endpoint device as a Microsoft Entra registered device.
- To enable Global Secure Access for your tenant, refer to the [licensing requirements](overview-what-is-global-secure-access.md#licensing-overview). If necessary, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- Onboard the tenant to Global Secure Access, and configure one or more traffic forwarding profiles. For more information, see [Access the Global Secure Access area of the Microsoft Entra admin center](quickstart-access-admin-center.md).
- To enable a Kerberos single sign-on (SSO) experience, create and deploy a profile for the iOS [SSO app extension](/intune/intune-service/configuration/ios-device-features-settings#single-sign-on-app-extension).

## Requirements

### Network requirements

For Microsoft Defender for Endpoint on iOS to function when it's connected to a network, you must configure the firewall/proxy to [enable access to Microsoft Defender for Endpoint service URLs](/defender-endpoint/configure-environment#enable-access-to-microsoft-defender-for-endpoint-service-urls-in-the-proxy-server). Microsoft Defender for Endpoint on iOS is available in the [Apple App Store](https://apps.apple.com/us/app/microsoft-defender-security/id1526737990).

> [!NOTE]
> Microsoft Defender for Endpoint on iOS isn't supported on userless or shared devices.

### System requirements

The iOS device (phone or tablet) must meet the following requirements:

- The device runs iOS 16.0 or newer.
- The device has the Microsoft Authenticator app or the Intune Company Portal app.
- If the device is supervised, it must be enrolled to enforce policies for Intune device compliance.

## Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Installation steps

### Deploy on Device Administrator enrolled devices with Microsoft Intune

1. In the [Microsoft Intune admin center](https://intune.microsoft.com/#home), go to **Apps** > **iOS/iPadOS** > **Add** > **iOS store app**. Then choose **Select**.

    :::image type="content" source="media/how-to-install-ios-client/ios-client-add-ios-store-app.png" alt-text="Screenshot of the Microsoft Intune admin center with the steps to add an iOS store app highlighted.":::

1. On the **Add app** page, select **Search the App Store** and enter **Microsoft Defender** on the search bar.

1. In the search results, select **Microsoft Defender** and then choose **Select**.

1. Select **iOS 15.0** as the minimum operating system. Review the rest of the information about the app, and then select **Next**.

1. In the **Assignments** section, go to the **Required** section and select **Add group**.

    :::image type="content" source="media/how-to-install-ios-client/ios-client-add-group.png" alt-text="Screenshot of the Add App page with the option for adding a group highlighted.":::
  
1. Choose the user groups to target with the Defender for Endpoint on iOS app.

    > [!NOTE]
    > Selected user groups should consist of Microsoft Intune enrolled users.

1. Choose **Select**, and then select **Next**.

1. In the **Review + Create** section, verify that all the entered information is correct and then select **Create**. After a few moments, the Defender for Endpoint app is created successfully, and a notification appears at the upper-right corner of the page.

1. On the app information page, in the **Monitor** section, select **Device install status** to verify that the device installation finished successfully.

    :::image type="content" source="media/how-to-install-ios-client/ios-client-device-install-status.png" alt-text="Screenshot that shows a list of installed devices on the pane for device installation status.":::

### Create a VPN profile and configure Global Secure Access for Microsoft Defender for Endpoint

1. In the [Microsoft Intune admin center](https://intune.microsoft.com/#home), go to **Devices** > **Configuration** > **Create** > **New Policy**.

1. Set **Platform** to **iOS/iPadOS**, **Profile type** to **Templates**, and **Template name** to **VPN**.

1. Select **Create**.

1. Enter a name for the profile, and then select **Next**.

1. Set **Connection type** to **Custom VPN**.  

1. In the **Base VPN** section, enter the following information:

    - **Connection name**: **Microsoft Defender for Endpoint**
    - **VPN server address**: **127.0.0.1**
    - **Authentication method**: **Username and password**
    - **Split tunneling**: **Disable**
    - **VPN identifier**: **com.microsoft.scmx**

1. In the boxes for key/value pairs:

    - Add the `EnableGSA` key and set the appropriate value from the following table:

      |Key |Value |Details |
      |---------|---------|---------|
      |`EnableGSA` |No value | Global Secure Access isn't enabled and the tile isn't visible. |
      |  |`0` | Global Secure Access isn't enabled and the tile isn't visible.|
      |  |`1` | Global Secure Access tile is visible and defaults to a disabled state. The user can enable or disable the tile by using the toggle.|
      |  |`2` | Global Secure Access tile is visible and defaults to an enabled state. The user can enable or disable the tile by using the toggle from the app. |
      |  |`3` | Global Secure Access tile is visible and defaults to an enabled state. The user *can't* disable Global Secure Access. |

    - Add the `SilentOnboard` key and set the value to `True`.

    - Add more key/value pairs as required (optional). If you add the `EnableGSAPrivateChannel` key, select one of the following values:  

      |Key |Value |Details |
      |---------|---------|---------|
      |`EnableGSAPrivateChannel` |No value |Use the `EnableGSA` configured option. |
      |  |`0` |Private Access isn't enabled and the toggle option isn't visible to the user. |
      |  |`1` |The Private Access toggle is visible and defaults to a disabled state. The user can enable or disable it. |
      |  |`2` |The Private Access toggle is visible and defaults to an enabled state. The user can enable or disable it. |
      |  |`3` |The Private Access toggle is visible but unavailable, and it defaults to an enabled state. The user *can't* disable Private Access. |

1. For **Type of automatic VPN**, select **On-demand VPN**.

1. For **On-demand rules**, select **Add** and then:

    - Set **I want to do the following** to **Connect VPN**.
    - Set **I want to restrict** to **All domains**.

    :::image type="content" source="media/how-to-install-ios-client/ios-client-set-up-vpn.png" alt-text="Screenshot of example setup parameters in VPN configuration settings.":::

1. To prevent users from disabling the VPN, set **Block users from disabling automatic VPN** to **Yes**. By default, this setting isn't configured, and users can disable the VPN only in the settings.

1. Select **Next** and assign the profile to targeted users.

1. In the **Review + Create** section, verify that all the information is correct and then select **Create**.

After the configuration is complete and synced with the device, the following actions take place on the targeted iOS devices:

- Microsoft Defender for Endpoint is deployed and silently onboarded.  
- The device is listed in the Defender for Endpoint portal.  
- A provisional notification is sent to the user device.  
- Global Secure Access and other Microsoft Defender for Endpoint-configured features are activated.

## Confirm Global Secure Access appears in the Defender app

Because the Global Secure Access client for iOS is integrated with Microsoft Defender for Endpoint, it's helpful to understand the user experience. The client appears in the Defender dashboard after you onboard to Global Secure Access.

:::image type="content" source="media/how-to-install-ios-client/ios-defender-dashboard-1.png" alt-text="Screenshot of the Microsoft Defender dashboard for iOS.":::

You can enable or disable the Global Secure Access client for iOS by setting the `EnableGSA` key in the [VPN profile](#create-a-vpn-profile-and-configure-global-secure-access-for-microsoft-defender-for-endpoint). Users can enable or disable individual services or the client itself based on the configuration settings, by using the appropriate toggles.

:::image type="content" source="media/how-to-install-ios-client/ios-client-enabled-disabled-1.png" alt-text="Screenshot of the Global Secure Access client on iOS that shows both the Active and Not Connected status screens.":::

## Troubleshooting

If the Global Secure Access tile doesn't appear in the Defender app after you onboard the tenant, restart the Defender app.

If access to the Private Access application shows a connection timeout error after a successful interactive sign-in, reload the application (or refresh the web browser).

## Related content

- [Troubleshoot the Global Secure Access mobile client: Advanced diagnostics](troubleshoot-global-secure-access-mobile-client-advanced-diagnostics.md)
- [Troubleshoot the Global Secure Access mobile client with Health check utility](troubleshoot-global-secure-access-mobile-client-health-check-utility.md)
- [Microsoft Defender for Endpoint on iOS](/defender-endpoint/microsoft-defender-endpoint-ios)
- [Deploy Microsoft Defender for Endpoint on iOS with Microsoft Intune](/defender-endpoint/ios-install)
- [Install the Global Secure Access client for macOS](how-to-install-macos-client.md)
- [Install the Global Secure Access client for Windows](how-to-install-windows-client.md)
- [Install the Global Secure Access client for Android](how-to-install-android-client.md)

---
title: The Global Secure Access client for Android
description: Install the Global Secure Access Android client.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 09/09/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: dhruvinrshah
---
# Global Secure Access client for Android

The Global Secure Access client can be deployed to compliant Android devices using Microsoft Intune and Microsoft Defender for Endpoint on Android. The Android client is built into the Defender for Endpoint Android app, which streamlines how your end users connect to Global Secure Access. The Global Secure Access Android client makes it easier for your end users to connect to the resources they need without having to manually configure VPN settings on their devices.

This article explains the prerequisites and how to deploy the client onto Android devices.

## Prerequisites

- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- You must enable at least one Global Secure Access [traffic forwarding profile](concept-traffic-forwarding.md).
- Device installation permissions on the device are required for installation.
- Android devices must be running Android 10.0 or later.
- Android devices must be Microsoft Entra registered devices.
  - Devices not managed by your organization must have the Microsoft Authenticator app must be installed.
  - Devices not managed through Intune must have the Company Portal app installed.
  - Device enrollment is required for Intune device compliance policies to be enforced.

### Known limitations

- Mobile devices running *Android (Go edition)* aren't currently supported.
- Microsoft Defender for Endpoint on Android *on shared devices* isn't currently supported.
- Tunneling IPv6 traffic isn't currently supported.
- Private Domain Name System (DNS) must be disabled on the device. This setting is often found in the System > Network and Internet options.
- Running non-Microsoft endpoint protection products alongside Microsoft Defender for Endpoint might cause performance problems and unpredictable system errors.
- Global Secure Access (GSA) coexistence with Microsoft Tunnel is not currently supported. For more information, see [Prerequisites for the Microsoft Tunnel in Intune](../en-us/mem/intune/protect/microsoft-tunnel-prerequisites.md).

## Supported scenarios

Global Secure Access client for Android supports deployment for the legacy Device Administrator and Android Enterprise scenarios. The following Android Enterprise scenarios are supported:

- Corporate-owned, fully managed user devices.
- Corporate-owned devices with a work profile.
- Personal devices with a work profile.

### Non-Microsoft mobile device management

Non-Microsoft mobile device management (MDM) scenarios are also supported. In these scenarios, known as *Global Secure Access only mode*, you only need to enable a traffic forwarding profile and configure the app according to the vendor documentation.

## Deploy Microsoft Defender for Endpoint Android

There are several combinations of deployment modes and scenarios for using the Global Secure Access client for Android.

Once you enable a traffic forwarding profile and configure your network, the Global Secure Access Android client appears in the Defender app automatically; however, the Global Secure Access client is disabled by default. Users can enable the client from the Defender app. The steps to enable the client are provided in the [Confirm Global Secure Access appears in Defender app](#confirm-global-secure-access-appears-in-defender-app) section.

### [Device Administrator](#tab/device-administrator)

This legacy enrollment mode allows you to deploy Defender for Endpoint on Android with Microsoft Intune Company Portal - Device Administrator enrolled devices.

The high level process is as follows:

1. Deploy Defender to Intune enrolled Android devices.

1. [Enable at least one traffic forwarding profile](concept-traffic-forwarding.md) if Defender is already deployed.

1. [Confirm Global Secure Access appears in the Defender app](#confirm-global-secure-access-appears-in-defender-app).

The detailed process for deploying Defender is as follows:

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/) as an [Intune Administrator](../identity/role-based-access-control/permissions-reference.md#intune-administrator).
1. Browse to **Apps** > **Android** > **Add** > **Android store app** > **Select**.

    ![Screenshot of the add Android app store options.](media/how-to-install-android-client/intune-add-android-store-app.png)

1. Provide a **Name**, **Description**, and **Publisher**.
1. Enter the URL in the **Appstore URL** field.
    - `https://play.google.com/store/apps/details?id=com.microsoft.scmx`
1. Leave all other fields as their default values and select **Next**.

    ![Screenshot of the completed fields.](media/how-to-install-android-client/intune-add-defender-app-fields.png)

1. In the **Required** section, select **Add group**, then select the groups to assign the app to and select **Next**.
    - The selected group should consist of your Intune enrolled users.
    - You can edit or add more groups later.

    ![Screenshot of the add groups steps.](media/how-to-install-android-client/intune-add-group.png)

1. On the **Review + create** tab, confirm the information is correct and select **Create**.
1. On the new app details page, select **Device install status** and confirm the app is installed.

**Users need to enable the client in the Defender app. It's disabled by default.** Proceed to the next section to confirm the app is installed and for how to enable the client.

### [Android Enterprise](#tab/android-enterprise)

Follow these steps to add the Microsoft Defender for Endpoint app into your managed Google Play store.

The high level process is as follows:

1. Deploy Defender on Android Enterprise enrolled devices.

1. [Enable at least one traffic forwarding profile](concept-traffic-forwarding.md).

1. [Confirm Global Secure Access appears in the Microsoft Defender for Endpoint app](#confirm-global-secure-access-appears-in-defender-app).

The detailed process for deploying to the Google Play store is as follows:

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/) as an [Intune Administrator](../identity/role-based-access-control/permissions-reference.md#intune-administrator).
1. Browse to **Apps** > **Android** > **Add** > **Managed Google Play app** > **Select**.

    ![Screenshot of the add Google Play app options.](media/how-to-install-android-client/intune-add-google-play-app.png)

1. On the managed Google Play page, search for **Microsoft Defender** and select it from the search results.
1. On the details page for Microsoft Defender, select the **Select** button.
1. Select the **Sync** button in the upper-left corner. This step syncs Defender with your apps list.

    ![Screenshot of the Defender app details, with the Sync button highlighted.](media/how-to-install-android-client/intune-sync-google-play.png)

1. Select the **Refresh** button on the Android apps screen so Microsoft Defender for Endpoint appears in the list.
1. Select **Microsoft Defender** from the app list and browse to **Properties** > **Assignments** > **Edit**.

    ![Screenshot of the Edit option for assigning groups.](media/how-to-install-android-client/intune-google-assignments-edit.png)

1. In the **Required** section, select **Add group**, then select the groups to assign the app to and select **Next**.
1. Select **Review + save** and once the details are confirmed, select **Save**.

    ![Screenshot of the Add group option.](media/how-to-install-android-client/intune-google-add-group.png)

After you assign a group, the app is automatically installed in the *work profile* during the next sync of the device via the Company Portal app.

**Users need to enable the client in the Defender app. It's disabled by default.** Proceed to the next section to confirm the app is installed and for how to enable the client.

---

## Confirm Global Secure Access appears in Defender app

Because the Android client is integrated with Defender for Endpoint, it's helpful to understand the end user experience. The client appears in the Defender dashboard after onboarding to Global Secure Access. Onboarding happens by enabling a traffic forwarding profile.

![Screenshot of the Defender app with the Global Secure Access tile on the dashboard.](media/how-to-install-android-client/defender-endpoint-dashboard.png)

**The client is disabled by default when it's deployed to user devices.** Users need to enable the client from the Defender app. To enable the client, tap the toggle.

![Screenshot of the disabled Global Secure Access client.](media/how-to-install-android-client/defender-global-secure-access-disabled.png)

To view the details of the client, tap on the tile on the dashboard. When enabled and working properly, the client displays an "Enabled" message. The date and time for when the client connected to Global Secure Access also appears.

![Screenshot of the enabled Global Secure Access client.](media/how-to-install-android-client/defender-global-secure-access-enabled.png)

If the client is unable to connect, a toggle appears to disable the service. Users can come back later to try enabling the client.

![Screenshot of the Global Secure Access client that is unable to connect.](media/how-to-install-android-client/defender-global-secure-access-unable.png)

## Troubleshooting

The Global Secure Access tile doesn't appear after onboarding the tenant to the service. Restart the Defender app.

When attempting to access a Private Access application, the connection might time out after a successful interactive sign-in. Reloading the application through a web browser refresh should resolve the issue.

## Related content

- [About Microsoft Defender for Endpoint on Android](/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint-android)
- [Deploy Microsoft Defender for Endpoint on Android with Microsoft Intune](/microsoft-365/security/defender-endpoint/android-intune)
- [Learn about managed Google Play apps and Android Enterprise devices with Intune](/mem/intune/apps/apps-add-android-for-work)

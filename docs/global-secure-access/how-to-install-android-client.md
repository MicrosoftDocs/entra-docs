---
title: The Global Secure Access Client for Android
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the Android client app.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 08/27/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: cagautham
ms.custom: sfi-image-nochange
# Customer intent: As an administrator, I want to set up and deploy the Global Secure Access mobile client for Android devices.
---
# Global Secure Access client for Android

The Global Secure Access client can be deployed to compliant Android devices using Microsoft Intune and Microsoft Defender for Endpoint on Android. The Android client is built into the Defender for Endpoint Android app, which streamlines how your end users connect to Global Secure Access. The Global Secure Access Android client makes it easier for your end users to connect to the resources they need without having to manually configure VPN settings on their devices.

This article explains how to deploy the Global Secure Access client onto Android devices.

## Prerequisites

- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- Enable at least one Global Secure Access [traffic forwarding profile](concept-traffic-forwarding.md).
- You need device installation permissions to install the client.
- Android devices need to run Android 10.0 or later.
- Android devices need to be Microsoft Entra registered devices.
  - Devices not managed by your organization need to have the Microsoft Authenticator app installed.
  - Devices not managed through Intune need to have the Company Portal app installed.
  - Device enrollment is required to enforce Intune device compliance policies.

### Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Supported scenarios

The Global Secure Access client for Android supports deployment in these Android Enterprise scenarios:

- Corporate-owned, fully managed user devices
- Corporate-owned devices with a work profile
- Personal devices with a work profile

### Non-Microsoft mobile device management

The Global Secure Access client also supports non-Microsoft mobile device management (MDM) scenarios. These scenarios, known as *Global Secure Access only mode*, require enabling a traffic forwarding profile and configuring the app based on the vendor documentation.

## Deploy Microsoft Defender for Endpoint on Android

To deploy Microsoft Defender for Endpoint on Android, create an MDM profile and configure Global Secure Access. 

1. In the [Microsoft Intune admin center](https://intune.microsoft.com/#home), go to **Apps** > **Android** > **Manage Apps** > **Configuration**. 
1. Select **+ Create**, and then select **Managed devices**. The **Create app configuration policy** form opens.
1. On the **Basics** tab:
    1. Enter a **Name**.
    1. Set the **Platform** to **Android Enterprise**.
1. Set the **Profile type** to **Fully Managed, Dedicated, and Corporate-Owned Work Profile Only**.
    1. Set the **Targeted app** to **Microsoft Defender**. 
1. Select **Next**.
:::image type="content" source="media/how-to-install-android-client/create-policy-basics.png" alt-text="Screenshot of the Create app configuration policy on the Basics tab.":::   

1. On the **Settings** tab:
    1. Set **Configuration settings format** to **Use configuration designer**.
1. Use the JSON editor to configure the disabled configuration keys, and then select the **+ Add** button.
    1. In the search field, type `global` and select these configuration keys:
        - **Global Secure Access** (this key is required to enable Global Secure Access). 
        - **GlobalSecureAccessPrivateChannel** (this optional key enables Global Secure Access Private channel). 
    1. Set the appropriate values for each configuration key according to the following table: 
 
| Configuration key                | Value    | Details   |
|----------------------------------|----------|-----------|
| Global Secure Access             | No value | Global Secure Access isn't enabled and the tile isn't visible. |
|                                  | 0        | Global Secure Access isn't enabled and the tile isn't visible. |
|                                  | 1        | The tile is visible and defaults to false (disabled state). The user can enable or disable Global Secure Access using the toggle in the app. |
|                                  | 2        | The tile is visible and defaults to true (enabled state). The user can override Global Secure Access. The user can enable or disable Global Secure Access using the toggle in the app. |
|                                  | 3        | The tile is visible and defaults to true (enabled state). The user **can't** disable Global Secure Access. |
| GlobalSecureAccessPrivateChannel | No value | Global Secure Access defaults to value 2 behavior. |
|                                  | 0        | Private Access isn't enabled and the toggle option isn't visible to the user. |
|                                  | 1        | The Private Access toggle is visible and defaults to the disabled state. The user can enable or disable Private Access. |
|                                  | 2        | The Private Access toggle is visible and defaults to the disabled state. The user can enable or disable Private Access. |
|                                  | 3        | The Private Access toggle is visible but grayed out, and defaults to the enabled state. The user **can't** disable Private Access. |

> [!NOTE]
> The **GlobalSecureAccessPA** configuration key is no longer supported.   

6. Select **Next**. 
:::image type="content" source="media/how-to-install-android-client/create-policy-settings.png" alt-text="Screenshot of the Create app configuration policy on the Settings tab.":::   

1. On the **Scope tags** tab, configure scope tags as needed and select **Next**.
1. On the **Assignments** tab, select **+ Add groups** to assign the configuration policy and enable Global Secure Access.
:::image type="content" source="media/how-to-install-android-client/create-policy-assignments.png" alt-text="Screenshot of the Create app configuration policy on the Assignments tab.":::   

> [!TIP]
> To enable the policy for all but a few specific users, select **Add all devices** in the **Included groups** section. Then, add the users or groups to exclude in the **Excluded groups** section.

9. Select **Next**.
1. Review the configuration summary and select **Create**. 

## Confirm Global Secure Access appears in the Defender app

Because the Android client is integrated with Defender for Endpoint, it's helpful to understand the end user experience. The client appears in the Defender dashboard after onboarding to Global Secure Access. Onboarding happens by enabling a traffic forwarding profile.

![Screenshot of the Defender app with the Global Secure Access tile on the dashboard.](media/how-to-install-android-client/defender-endpoint-dashboard.png)

**The client is disabled by default when it's deployed to user devices.** Users need to enable the client from the Defender app. To enable the client, tap the toggle.

![Screenshot of the disabled Global Secure Access client.](media/how-to-install-android-client/defender-global-secure-access-disabled.png)

To view client details, tap the tile on the dashboard. When enabled and working properly, the client shows an "Enabled" message. It also shows the date and time when the client connected to Global Secure Access.

![Screenshot of the enabled Global Secure Access client.](media/how-to-install-android-client/defender-global-secure-access-enabled.png)

If the client can't connect, a toggle appears to disable the service. Users can return later to enable the client.

![Screenshot of the Global Secure Access client that is unable to connect.](media/how-to-install-android-client/defender-global-secure-access-unable.png)

## Troubleshooting

If the Global Secure Access tile doesn't appear after onboarding the tenant to the service, restart the Defender app.

When you try to access a Private Access application, the connection might time out after a successful interactive sign-in. Reload the application by refreshing the web browser.

## Related content
- [About Microsoft Defender for Endpoint on Android](/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint-android)
- [Deploy Microsoft Defender for Endpoint on Android with Microsoft Intune](/microsoft-365/security/defender-endpoint/android-intune)
- [Learn about managed Google Play apps and Android Enterprise devices with Intune](/mem/intune/apps/apps-add-android-for-work)
- [Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md)
- [Global Secure Access client for macOS](how-to-install-macos-client.md)
- [Global Secure Access client for iOS](how-to-install-ios-client.md)
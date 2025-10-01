---
title: "Tutorial: Add Shared Device Mode support to an Android device"
description: In this tutorial, learn how to add Shared Device Mode support to an Android device using the Microsoft Authenticator App or Intune
author: Dickson-Mwendia
manager: dougeby
ms.author: dmwendia
ms.date: 08/30/2024
ms.service: identity-platform
ms.subservice: workforce
ms.reviewer: akgoel
ms.topic: tutorial
#Customer intent: As an application developer, I want to learn how to setup an Android device in Shared Device Mode using Microsoft Authenticator App.
---

# Set up an Android device in Shared Device Mode

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

In this tutorial, you learn how to add shared device mode support to an Android device with the Microsoft Authenticator App or a Mobile Device Management (MDM) tool like Microsoft Intune. Employees sign in once for single sign-on (SSO) to all SDM-supported apps and sign out to make the device ready for the next user with no access to previous data.

In this tutorial, you:

> [!div class="checklist"]
>
> - Zero-touch set up via Microsoft Intune
> - Supported third-party MDMs for zero-touch setup
> - Manual setup with the Microsoft Authenticator app

## Prerequisites

- An Azure account with an active subscription. If you don't have one, [create an account for free](https://azure.microsoft.com/free/).
- An Android device running Android OS version 8.0 or later.  Ensure the device is wiped either by a factory reset or uninstalling all Microsoft and other SDM-enabled app. 
- [Microsoft Authenticator app](https://play.google.com/store/apps/details/Microsoft_Authenticator?id=com.azure.authenticator&hl=en_NZ) latest version installed on the device.
- For setup via MDM, the device should be managed by an MDM that supports shared device mode such as Microsoft Intune.  

## Zero-touch setup via Intune

Microsoft Intune supports zero-touch provisioning for devices in Microsoft Entra shared device mode (SDM), which means that the device can be set up and enrolled in Intune with minimal interaction from the frontline worker. 

To set up device in shared device mode when using Microsoft Intune as the MDM, first step is to enroll the shared device into Intune and install Authenticator app with SDM enabled. For more information on how to set up the SDM using Microsoft Intune, see [Set up Intune enrollment for Android Enterprise dedicated devices](/mem/intune/enrollment/android-kiosk-enroll)

Once enrolled, switch on the device to initiate standard Android device setup, which automatically triggers device registration with Microsoft Entra ID and get it ready for use. 

## Supported third-party MDMs for zero-touch setup

The following third-party Mobile Device Management (MDM) tools support Microsoft Entra shared device mode

- [VMware Workspace ONE](https://docs.omnissa.com/bundle/UEMSharedDevicesVSaaS/page/UEMSharedDeviceConditionalAccess.html) - VMware supports Conditional Access capabilities but currently doesn’t support global sign-in and global sign-out with shared device mode.
- [SOTI MobiControl](https://soti.net/resources/blog/2023/soti-mobicontrol-supports-microsoft-shared-device-mode/)

> [!NOTE]
> If your MDM doesn’t support setting the device in shared device mode, reach out to your MDM provider to request support for this feature. Additionally, you can manually put devices in shared device mode for testing if your MDM doesn’t support shared device mode.

## Manual setup with the Microsoft Authenticator app

To complete manual setup using the Microsoft Authenticator app, you require a cloud device administrator account. Follow these steps to complete the setup process:

1. Launch the Authenticator App and navigate to main account page where you can see the **Add Account** option, as shown:

    :::image type="content" source="media/tutorial-v2-shared-device-mode/authenticator-add-account.png" alt-text="Screenshot of the Microsoft Authenticator app add account option.":::

1. Go to the **Settings** pane using the right-hand menu bar. Select **Device Registration** under **Work & School accounts**.

    :::image type="content" source="media/tutorial-v2-shared-device-mode/authenticator-settings.png" alt-text="Screenshot of the Microsoft Authenticator app settings.":::

1. When you select **Device Registration**, you're asked to authorize access to device contacts. This is due to Android's account integration on the device. Choose **Allow**.

    :::image type="content" source="media/tutorial-v2-shared-device-mode/authenticator-allow-screen.png" alt-text="Screenshot of the Microsoft Authenticator app allow access confirmation window.":::

1. Enter your organizational email under **Or register as a shared device**. Then select the **Register as shared device** button, and enter their credentials.

    :::image type="content" source="media/tutorial-v2-shared-device-mode/register-device.png" alt-text="Screenshot of the Microsoft Authenticator Device registration window in app.":::

    :::image type="content" source="media/tutorial-v2-shared-device-mode/sign-in.png" alt-text="Screenshot of the Microsoft sign-in page.":::

1. The device is now in shared mode.

    :::image type="content" source="media/tutorial-v2-shared-device-mode/shared-device-mode-screen.png" alt-text="Screenshot of the Microsoft Authenticator app showing shared device mode enabled.":::

Any sign-in and sign-out instances on the device are global, and apply to all apps that are integrated with MSAL and Microsoft Authenticator on the device. You can now deploy applications to the device that use shared-device mode features.

## View the shared device

Once you set up a device in shared-mode, it becomes known to your organization and is tracked in your organizational tenant. You can view your shared devices by looking at the **Join Type**.

:::image type="content" source="media/tutorial-v2-shared-device-mode/shared-device-mode-via-zero-touch-setup.png" alt-text="Screenshot of Microsoft Entra window showing a shared device that's registered via zero-touch.":::

   
## Related content

- [Shared device mode in Android devices](./msal-android-shared-devices.md)
- [Set up iOS/iPadOS device enrollment with Apple Configurator](/mem/intune/enrollment/apple-configurator-enroll-ios)

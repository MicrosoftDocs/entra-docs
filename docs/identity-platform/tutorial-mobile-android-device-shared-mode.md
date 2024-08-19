---
title: "Tutorial: Set up an Android device in Shared Device Mode"
description: In this tutorial, learn how to set up an Android device in Shared Device Mode using Microsoft Authenticator App or Intune
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 08/19/2024
ms.service: identity-platform
ms.reviewer: akgoel, henrymbugua
ms.topic: tutorial
#Customer intent: As an application developer, I want to learn how to setup an Android device in Shared Device Mode using Microsoft Authenticator App.
---

# Tutorial: Setup an Android device in Shared Device Mode

In this tutorial, you learn how to set up an Android device in Shared Device Mode (SDM) with the Microsoft Authenticator App or a Mobile Device Management (MDM) tool like Microsoft Intune. Employees sign in once for single sign-on (SSO) to all SDM-supported apps and sign out to make the device ready for the next user with no access to previous data.

In this tutorial:

> [!div class="checklist"]
>
> - Set up tenant and register the application
> - Manual setup with the Microsoft Authenticator app
> - Zero-touch set up via Microsoft Intune
> - Setup via third-party MDMs
> - Run the sample app

## Prerequisites

- An Azure account with an active subscription. If you don't have one, [create an account for free](https://azure.microsoft.com/free/).
- Completion of steps in [Tutorial: Implement shared-device mode in your Android application](./tutorial-v2-shared-device-mode.md)
- An Android device with Android OS version 8.0 or later that isn't registered with Microsoft Entra ID. If it's registered, reset it to factory settings.
- [Microsoft Authenticator app](https://play.google.com/store/apps/details/Microsoft_Authenticator?id=com.azure.authenticator&hl=en_NZ) installed on the device.

### Register the application and set up your tenant for testing

Before you can set up your application and put your device into shared-device mode, you need to register the application within your organizational tenant. You then provide these values in *auth_config.json* for your application to run correctly.

For information on how to do this, refer to [Register your application](./tutorial-v2-android.md).

> [!NOTE]
> When you register your app, please use the quickstart guide on the left-hand side and then select **Android**. This will lead you to a page where you'll be asked to provide the **Package Name** and **Signature Hash** for your app. These are very important to ensure your app configuration will work. You'll then receive a configuration object that you can use for your app that you'll cut and paste into your auth_config.json file.

:::image type="content" source="media/tutorial-v2-shared-device-mode/register-app.png" alt-text="Configure your Android app page":::

You should select **Make this change for me** and then provide the values the quickstart asks for. When done, Microsoft Entra ID generates all the configuration files you need.

:::image type="content" source="media/tutorial-v2-shared-device-mode/config-info.png" alt-text="Configure your project page":::

For testing purposes, set up the following roles in your tenant - at least two employees and a Cloud Device Administrator. To set the Cloud Device Administrator, you need to modify Organizational Roles. From the Microsoft Entra admin center, go to your Organizational Roles by selecting **Identity** > **Roles & admins** > **Roles & admins** > **All roles**, and then select **Cloud Device Administrator**. Add the users that can put a device into shared mode.


## Configure Authenticator app settings to register the device with Entra

Launch the Authenticator App and navigate to main account page where you can see the **Add Account** option, as shown:

:::image type="content" source="media/tutorial-v2-shared-device-mode/authenticator-add-account.png" alt-text="Authenticator add account screen":::

Go to the **Settings** pane using the right-hand menu bar. Select **Device Registration** under **Work & School accounts**.

:::image type="content" source="media/tutorial-v2-shared-device-mode/authenticator-settings.png" alt-text="Authenticator settings screen":::

When you select this button, you're asked to authorize access to device contacts. This is due to Android's account integration on the device. Choose **Allow**.

:::image type="content" source="media/tutorial-v2-shared-device-mode/authenticator-allow-screen.png" alt-text="Authenticator allow access confirmation screen":::

The Cloud Device Administrator should enter their organizational email under **Or register as a shared device**. Then select the **Register as shared device** button, and enter their credentials.

:::image type="content" source="media/tutorial-v2-shared-device-mode/register-device.png" alt-text="Device registration screen in app":::

:::image type="content" source="media/tutorial-v2-shared-device-mode/sign-in.png" alt-text="App screenshot showing Microsoft sign-in page":::

The device is now in shared mode.

:::image type="content" source="media/tutorial-v2-shared-device-mode/shared-device-mode-screen.png" alt-text="App screen showing shared device mode enabled":::

Any sign-in and sign-out instances on the device are global, and apply to all apps that are integrated with MSAL and Microsoft Authenticator on the device. You can now deploy applications to the device that use shared-device mode features.

## View the shared device

Once you set up a device in shared-mode, it becomes known to your organization and is tracked in your organizational tenant. You can view your shared devices by looking at the **Join Type**.

:::image type="content" source="media/tutorial-v2-shared-device-mode/registered-device-screen.png" alt-text="Screenshot that shows the all devices pane":::

## Running the sample app

The sample application is a simple app that will call the Graph API of your organization. On first run, you'll be prompted to consent as the application is new to your employee account.

:::image type="content" source="media/tutorial-v2-shared-device-mode/run-app-permissions-requested.png" alt-text="Application configuration info screen":::


## Zero-touch setup via Intune

Microsoft Intune supports zero-touch provisioning for devices in Microsoft Entra SDM, which means that the device can be set up and enrolled in Intune with minimal interaction from the frontline worker. 

To set up device in shared device mode when using Microsoft Intune as the MDM, first step is to enroll the shared device into Intune and install Authenticator app with SDM enabled. For more information on how to set up the SDM using Microsoft Intune, see [Set up Intune enrollment for Android Enterprise dedicated devices](/mem/intune/enrollment/android-kiosk-enroll)

Once enrolled, switch on the device to initiate standard Android device setup, which automatically triggers device registration with Entra ID and get it ready for use. 


## Setup via third-party MDM 

The following the third-party Mobile Device Management (MDM) tools support Microsoft Entra shared device mode: 

- [VMware Workspace ONE](https://docs.omnissa.com/bundle/UEMSharedDevicesVSaaS/page/UEMSharedDeviceConditionalAccess.html)
- SOTI MobiControl 

**Note:** VMware supports conditional access capabilities but currently doesn’t support global sign-in and global sign-out with shared device mode.      

## Related content

- [Shared device mode for Android devices reference](./msal-android-handling-exceptions.md)
- [Set up iOS/iPadOS device enrollment with Apple Configurator](/mem/intune/enrollment/apple-configurator-enroll-ios

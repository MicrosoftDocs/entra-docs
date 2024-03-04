---
title:  Register a passkey on Android or iOS device
description: Registration and management of passkey on Android or iOS device

services: active-directory
ms.service: active-directory
ms.subservice: authentication
ms.topic: how-to
ms.date: 02/26/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui

ms.collection: M365-identity-device-management
---
# Register a passkey on Android or iOS device

This article shows how to use your Android or iOS device to register and sign-in with a passkey (FIDO2). 

> [!NOTE]
> Microsoft Entra ID supports only device-bound passkeys. Support for synced passkeys is coming soon.

## First-time registration

1. First-time users need to register passkey (FIDO2) as an authentication method by navigating and completing the process from a browser at [My Security Info](https://mysignins.microsoft.com/security-info).
1. Tap **Add sign-in method** > **Choose a method** > **Passkey (preview)** > **Add**.
1. Sign in with multifactor authentication (MFA) before adding a passkey, then tap **Next**.
 
   :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/add-passkey.png" alt-text="Screenshot of the add a passkey on your iOS or Android device.":::

1. Select where you want to save your passkey. 

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey.

   :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/choose-where-store-passkey.png" alt-text="Screenshot of the dialog where to save your passkey on your iOS or Android device.":::
   
1. (Optional) If you've previously set up a passkey on a mobile device and selected the option to remember that device for quicker sign-in, the device name may appear as a selectable option. In this case, do the following: 

   1. Choose **iPhone**, **iPad**, or **Android** device.
   1. Open the camera on your device and scan the QR code shown below.

      :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/camera.png" alt-text="Screenshot of the dialog where to store your passkey on your iOS or Android device.":::

   1. In your camera, select the link to **Use a passkey** or **Save a passkey**.

1. Follow the remaining prompts to connect your device and register your new passkey for your preferred passkey manager. 

   > [!NOTE]
   > Your organization may limit which passkey manager you can use on mobile devices. Select the option on your device as allowed by your organization. 

1. Upon completion, review any additional information from the security dialog, then tap **Continue**. 
1. After you are redirected to security info, you can change the default name for the new sign-in method. 
1. Tap **Done** to finish registering the new method.

## Prompted registration

1. If your organization requires you to register a passkey, you’ll be prompted after sign-in to add a passkey.

   :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/inline-registration.png" alt-text="Screenshot of the add a passkey for a more secure sign-in on your iOS or Android device.":::

1. Tap **Next**, then you’ll be directed to `login.microsoft.com`. 
1. Select where you would like to save your passkey.

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** displays additional ways for you to save the passkey. 

    :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/choose-where-store-passkey.png" alt-text="Screenshot of the prompt where to store your passkey on your iOS or Android device..":::
 
1. (Optional) If you've previously set up a passkey on a mobile device and selected the option to remember that device for quicker sign-in, the device name may appear as a selectable option. In this case, do the following: 

   1. Choose **iPhone**, **iPad**, or **Android** device.
   1. Open the camera on your device and scan the QR code shown below.

      :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/camera.png" alt-text="Screenshot of the dialog where to store your passkey on your iOS or Android device.":::

1. Follow the remaining prompts to connect your device and register your new passkey for your preferred passkey manager. 

   > [!NOTE]
   > Your organization may limit which passkey manager you can use on mobile devices. Select the option on your device as allowed by your organization. 

1. Upon completion, review any additional information from the security dialog, then tap **Continue**. 
1. After you are redirected to security info, you can change the default name for the new sign-in method. 
1. Tap **Done** to finish registering the new method.

## Next steps

- [Choosing authentication methods for your organization](concept-authentication-methods.md)
- [Passkey authentication for Microsoft Entra ID](concept-authentication-passkey.md)
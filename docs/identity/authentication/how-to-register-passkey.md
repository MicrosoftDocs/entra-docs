---
title:  Register a passkey 
description: Registration and management of passkey.

services: active-directory
ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025

ms.author: justinha
author: justinha
manager: femila
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users will register a passkey using a browser or with a security key. 

---
# Register a passkey 

This article shows how users can register a security key using the **Passkey** flow. For registration on a mobile device, see [Register a passkey using a mobile device](how-to-register-passkey-mobile.md).

>[!NOTE]
>Looking to provide passkeys (FIDO2) on behalf of users? Use our [APIs](https://aka.ms/passkeyprovision).

For more information about enabling passkeys in Microsoft Authenticator, see [How to enable passkeys in Microsoft Authenticator](how-to-enable-authenticator-passkey.md).

## Manual registration 

1. Users can register a passkey (FIDO2) as an authentication method by navigating and completing the process from a browser at [Security info](https://aka.ms/mysecurityinfo).
1. Tap **Add sign-in method** > **Choose a method** > **Passkey** > **Add**.
1. Sign in with multifactor authentication (MFA) before adding a passkey, then tap **Next**.
   1. If you don't have at least one MFA method registered, you must add one.
   1. An Authentication Policy Administrator can also issue a [Temporary Access Pass](howto-authentication-temporary-access-pass.md) to allow a user to strongly authenticate and register a passkey.
 
   :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/add-passkey.png" alt-text="Screenshot of the Add a passkey on your iOS or Android device option.":::

1. A security dialog opens on your device and asks where to save your passkey. 

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey.

      :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/choose-where-store-passkey.png" alt-text="Screenshot of the dialog where to save your passkey on your iOS or Android device.":::

1. If your organization allows saving a passkey to a security key:
   1. Choose **Security Key**.
   1. Follow the guidance and insert or connect your security key when requested.
   1. You're prompted to create or enter a PIN for your security key, then perform the required gesture for the key.
   1. Upon completion, review any additional information from the security dialog, then tap Ok or Continue.

1. After you're redirected to Security info, you can change the default name for the new sign-in method. 
1. Tap **Done** to finish registering the new method.

<!---

If your organization allows saving a passkey to your mobile device: 
   Choose **iPhone**, **iPad**, or **Android** device.
   Open the camera on your device and scan the QR code shown.

      :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/camera.png" alt-text="Screenshot of the dialog where to store your passkey on your iOS or Android device.":::

In your camera, select the link to **Use a passkey** or **Save a passkey**.
  
> [!NOTE]
> For quicker sign-in, Android allows you to remember some browsers and Windows devices after scanning the WebAuthn QR code. In such cases, instead of having to scan a QR code each time, the device will appear as a selectable option and you will receive a notification on your mobile device to continue the passkey authentication.

Follow the remaining prompts to connect your device and register your new passkey for your preferred passkey provider. 

> [!NOTE]
> Your organization may limit which passkey providers you can use. Select the option on your device as allowed by your organization.

-->

<!---

## Guided registration

1. If your organization requires you to register a passkey, you’ll be prompted after sign-in to add a passkey.

   :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/inline-registration.png" alt-text="Screenshot of the Add a passkey for a more secure sign-in on your iOS or Android device option."::: 

1. Tap **Next**, then you’re directed to `login.microsoft.com`.
1. If you have yet to sign in with multifactor authentication (MFA), you're asked to sign-in.
   1. If you don't have at least one MFA method registered, you're not able to register a passkey. 
   1. An Authentication Policy Administrator can also issue a Temporary Access Pass (TAP) *for multiple use* to allow a user to strongly authenticate and register a passkey. A one-time TAP can't be used for guided registration. For more information, see [Configure Temporary Access Pass to register passwordless authentication methods](/entra/identity/authentication/howto-authentication-temporary-access-pass#limitations).

1. A security dialog opens on your device and asks where you would like to save your passkey. 

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey.

      :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/choose-where-store-passkey.png" alt-text="Screenshot of the dialog where to save your passkey on your iOS or Android device.":::
   
   > [!NOTE]
   > If you've previously set up a passkey on a mobile device and selected the option to remember that device for quicker sign-in, the device name may appear as a selectable option.

1. If your organization allows saving a passkey to a security key:
   1. Choose **Security Key**.
   2. Follow the guidance and insert or connect your security key when requested.
   3. You're prompted to create or enter a PIN for your security key, then perform the required gesture for the key.

1. If your organization allows saving a passkey to your mobile device:
   1. Choose **iPhone**, **iPad**, or **Android** device.
   1. Open the camera on your device and scan the QR code shown in this screenshot.

      :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/camera.png" alt-text="Screenshot of the dialog where to store your passkey on your iOS or Android device.":::

   1. In your camera, select the link to **Use a passkey** or **Save a passkey**.

1. Follow the remaining prompts to connect your device and register your new passkey for your preferred passkey manager. 

   > [!NOTE]
   > Your organization may limit which security key model or passkey provider you can use. Select the option on your device as allowed by your organization. 
   
1. Upon completion, review any additional information from the security dialog, then tap **Ok** or **Continue**. 
1. After you're redirected to Security info, you can change the default name for the new sign-in method. 
1. Tap **Done** to finish registering the new method.

-->

## Next steps

- [Choosing authentication methods for your organization](concept-authentication-methods.md)


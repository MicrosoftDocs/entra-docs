---
title: Register Microsoft Authenticator passkey on Android or iOS device in MySecurityInfo (preview)
description: Registration and management of passkey with Authenticator on iOS in MySecurityInfo (preview)

services: active-directory
ms.service: active-directory
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/05/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users can register a passkey in Microsoft Authenticator 

---
# Register Microsoft Authenticator passkey on Android or iOS device in MySecurityInfo (preview)

This article shows how to register a passkey using Microsoft Authenticator on your iOS or Android device using [My Security info](https://mysignins.microsoft.com/security). 

Passkeys in Microsoft Authenticator can be added directly from your device or through cross-device registration using another device, such as a laptop. Your mobile device needs to run iOS version 17 or later or Android version 14 or later. 

# [:::image type="icon" source="media/icons/ios-icon.png" border="false"::: **iOS**](#tab/iOS)

## Same device registration

1. Using your iOS device, open a web browser and sign-in to [My Security info](https://mysignins.microsoft.com/security).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_login.png" alt-text="Screenshot of how to sign in using Microsoft Authenticator for iOS devices.":::
   
1. Tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_securityinfo.png" alt-text="Screenshot of the Security Info screen in Microsoft Authenticator for iOS devices.":::

1. Select **Passkey in Microsoft Authenticator (preview)**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_in_authenticator.png" alt-text="Screenshot of the drop-down list of options in Microsoft Authenticator for iOS devices.":::

1. Tap **Add**. 
   
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_add-signin-method.png" alt-text="Screenshot of the Security Info screen Add Sign-in Method option.":::

1. Sign in with multifactor authentication (MFA) before adding a passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_2fa-authorization.png" alt-text="Screenshot of the 2-factor authentication requirement to setup a passkey.":::

1. After signing-in with MFA, continue through the rest of the passkey setup.

   1. If necessary, download Microsoft Authenticator and tap **Next**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_download_auth_app.png" alt-text="Screenshot of the download app option in Microsoft Authenticator for iOS devices.":::

   1. Follow the steps to turn on Authenticator in the **Settings app** of your iOS device:
      - On your iOS device, open the **Settings app**.
      - Open **Passwords** select **Password Opotions**.
      - Ensure **Autofill Passwords and and Passkeys** is turned on. 
      - Under **Use Passwords and Passkeys From** select **Authenticator**. 
      - Return to **My Security info** and click **Continue**. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_turn_on_support.png" alt-text="Screenshot of the turn on passkey support option in Microsoft Authenticator for iOS devices.":::

   1. When ready, read the reminder that you must save the passkey in Microsoft authenticator and tap **I understand** to continue.  

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_understand.png" alt-text="Screenshot of the I understand option in Microsoft Authenticator for iOS devices.":::

   1. Your device opens a security window. Save the passkey to Authenticator following the prompts on your device. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_create_passkey.png" alt-text="Screenshot of save passkey in Microsoft Authenticator for iOS devices.":::

   1. Once the passkey is successfully created on your device, you'll be directed back to **My Security info**, then tap **Done**. 
   1. Name the passkey something memorable to you and click **Done**. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_success.png" alt-text="Screenshot of the successful creation of a passkey in Microsoft Authenticator for iOS devices.":::

   1. You can now see the Microsoft Authenticator managed passkey along with your other registered security info options.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_listed_security_info.png" alt-text="Screenshot of the Security Info user display of the successful passkey.":::
      
## Cross-device registration 

1. Using another device, such as a laptop, open a web browser and sign in to [My Security info](https://mysignins.microsoft.com/Security info).
1. Tap **+ Add sign-in method** > **Choose a method** > **Passkey in Microsoft Authenticator (preview)** > **Add**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/add-passkey-authenticator.png" alt-text="Screenshot of how to add passkey in Microsoft Authenticator as a sign-in method.":::

1. Sign in with multifactor authentication (MFA) before you can add a passkey, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/set-up-passkey.png" alt-text="Screenshot that notifies user to sign in with a second factor before they add a passkey.":::

1. If necessary, download Microsoft Authenticator, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/organization.png" alt-text="Screenshot that notifies user that their organization requires them to add a passkey.":::

1. Tap **iOS**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-device.png" alt-text="Screenshot that lets user choose iOS or Android.":::

1. Follow the steps to turn on Authenticator in the **Settings app** of your iOS device:
   - On your iOS device, open the **Settings app**.
   - Open **Passwords** select **Password Opotions**.
   - Ensure **Autofill Passwords and and Passkeys** is turned on. 
   - Under **Use Passwords and Passkeys From** select **Authenticator** 
   - Return to My Security info and click **Continue** 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/turn-on-passkey-android.png" alt-text="Screenshot that notifies user to turn on Authenticator in Seetings app on their Android device.":::

1. Open your camera on your device and navigate back to **My security info**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to open a QR scanner app.":::

1. When ready, read the reminder that you must save the passkey in Microsoft authenticator and tap **I understand** to continue. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to save another way.":::
   
1. A security dialog will open on your device. 
1. Tap **iPhone, iPad, or Android device**, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-where-to-save.png" alt-text="Screenshot that lets user choose where to save their passkey.":::

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey.

1. Use the camera app to scan the QR code, then open the link.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan-code.png" alt-text="Screenshot of QR code.":::

1. Your iOS device should now connect over Bluetooth to the device you started registration with.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/device-connected.png" alt-text="Screenshot that notifies user that device is connected.":::
   
   > [!NOTE]
   > Bluetooth is required for this step and must be enabled on both your mobile and remote device. 

1. Your device opens a security window. Save the passkey to Authenticator following the prompts on your device. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_create_passkey.png" alt-text="Screenshot of save passkey in Microsoft Authenticator for iOS devices.":::


1. Once the passkey is successfully created on your device you'll be directed back to **My Security info**, tap **Done**. 
1. Name the passkey something memorable to you and click **Done**.
   
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/success.png" alt-text="Screenshot where user can change friendly nme of the new sign-in method.":::   


# [:::image type="icon" source="media/icons/android-icon.png" border="false"::: **Android**](#tab/Android)

## Same device registration

1. Using your Amdrpod device, open a web browser and sign-in to [My Security info](https://mysignins.microsoft.com/security).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_login.png" alt-text="Screenshot of how to sign in using Microsoft Authenticator for iOS devices.":::
   
1. Tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_securityinfo.png" alt-text="Screenshot of the Security Info screen in Microsoft Authenticator for iOS devices.":::

1. Select **Passkey in Microsoft Authenticator (preview)**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_in_authenticator.png" alt-text="Screenshot of the drop-down list of options in Microsoft Authenticator for iOS devices.":::

1. Tap **Add**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_add-signin-method.png" alt-text="Screenshot of the Security Info screen Add Sign-in Method option.":::

1. Sign in with multifactor authentication (MFA) before adding a passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_2fa-authorization.png" alt-text="Screenshot of the 2-factor authentication requirement to setup a passkey.":::

1. After signing in with MFA, you can continue through the rest of the passkey setup.

   1. If necessary, download Microsoft Authenticator and tap **Next**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_download_auth_app.png" alt-text="Screenshot of the download app option in Microsoft Authenticator for iOS devices.":::

   1. Follow the steps to turn on Authenticator in the **Settings app** on your Android device:
      - On your Android device, open the **Settings app**.
      - Open **Passwords & Accounts**.
      - Under **Additional providers** enable **Authenticator**. 
      - Return to **My Security info** and click **Continue**.
         
      > [!NOTE]
      > Enabling passkey providers on Android may vary based on the make and model of your device. Search for passkey on your device settings or consule your device manufacturer for guidance.
   
      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_turn_on_support.png" alt-text="Screenshot of the turn on passkey support option in Microsoft Authenticator for iOS devices.":::

   1. When ready, read the reminder that you must save the passkey in Microsoft authenticator and tap **I understand** to continue.  

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_understand.png" alt-text="Screenshot of the I understand option in Microsoft Authenticator for iOS devices.":::

   1. Your device opens a security window. Save the passkey to Authenticator following the prompts on your device. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_create_passkey.png" alt-text="Screenshot of save passkey in Microsoft Authenticator for iOS devices.":::

   1. Once the passkey is successfully created on your device, you'll be directed back to **My Security info**.
      
   1. Name the passkey something memorable to you and click **Done**. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_success.png" alt-text="Screenshot of the successful creation of a passkey in Microsoft Authenticator for iOS devices.":::

   1. You can now see the Microsoft Authenticator managed passkey along with your other registered security info options.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_listed_security_info.png" alt-text="Screenshot of the Security Info user display of the successful passkey.":::
      
## Cross-device registration 

1. Open a web browser and sign in to [My Security info](https://mysignins.microsoft.com/Security info).
1. Tap **+ Add sign-in method** > **Choose a method** > **Passkey in Microsoft Authenticator (preview)** > **Add**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/add-passkey-authenticator.png" alt-text="Screenshot of how to add passkey in Microsoft Authenticator as a sign-in method.":::

1. Sign in with multifactor authentication (MFA) before you can add a passkey, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/set-up-passkey.png" alt-text="Screenshot that notifies user to sign in with a second factor before they add a passkey.":::

1. If necessary, download Microsoft Authenticator, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/organization.png" alt-text="Screenshot that notifies user that their organization requires them to add a passkey.":::

1. Tap **Android**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-device.png" alt-text="Screenshot that lets user choose iOS or Android.":::

1. Follow the steps to turn on Authenticator in the **Settings app** of your Android device:
   - On your Android device, open the **Settings app**.
   - Open **Passwords & Accounts**.
   - Under **Additional providers** enable **Authenticator**. 
   - Return to **My Security info** and click **Continue**.
         
   > [!NOTE]
   > Enabling passkey providers on Android may vary based on the make and model of your device. Search for passkey on your device settings or consule your device manufacturer for guidance.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/turn-on-passkey-android.png" alt-text="Screenshot that notifies user to turn on Authenticator in Seetings app on their Android device.":::

1. Open your camera app on your device and navigate back to **My Security info**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to open a QR scanner app.":::

1. When ready, read the reminder that you must save the passkey in Microsoft authenticator and tap **I understand** to continue. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to save another way.":::
   
1. A security dialog will open on your device.
   
3.  Tap **iPhone, iPad, or Android device** and tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-where-to-save.png" alt-text="Screenshot that lets user choose where to save their passkey.":::

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey.

1. Use the camera app to scan the QR code, and then open the link.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan-code.png" alt-text="Screenshot of QR code.":::

1. Your Android device should now connect over Bluetooth to the device you started registration with.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/device-connected.png" alt-text="Screenshot that notifies user that device is connected.":::
   
   > [!NOTE]
   > Bluetooth is required for this step and must be enabled on both your mobile and remote device. 

1. Your device opens a security window. Save the passkey to Authenticator following the prompts on your device.
   
1. Once the passkey is successfully created on your device you'll be directed back to **My Security info**.
   
1. Name the passkey something memorable to you and click **Done**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_success.png" alt-text="Screenshot of the successful creation of a passkey in Microsoft Authenticator for iOS devices.":::

---

## Troubleshooting

1. If the a passkey for your account is already registered in Microsoft authenticator you will receive the following error: 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_already_exists.png" alt-text="Screenshot of the passkey that already exists in Microsoft Authenticator for iOS devices.":::

1. To re-register a passkey for your account, first remove the passkey from Authenticator by clicking the *Trash* icon, then tap **Delete** to confirm.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_delete.png" alt-text="Screenshot of the passkey to delete in Microsoft Authenticator for iOS devices.":::

> [!NOTE]
> You also need to delete the passkey from **Security Info**, using a web browser and logging in to [https://mysignins.microsoft.com/Security info](https://mysignins.microsoft.com/Security info).  



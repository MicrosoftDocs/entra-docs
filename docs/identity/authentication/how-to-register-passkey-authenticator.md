---
title: Register Microsoft Authenticator passkey on Android or iOS device in MySecurityInfo
description: Registration and management of passkey with Authenticator on iOS in MySecurityInfo

services: active-directory
ms.service: active-directory
ms.subservice: authentication
ms.topic: how-to
ms.date: 02/21/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui

ms.collection: M365-identity-device-management
---
# Register Microsoft Authenticator passkey on Android or iOS device in MySecurityInfo

# [:::image type="icon" source="media/icons/ios-icon.png" border="false"::: **iOS**](#tab/iOS)

This article shows how to register a passkey in Microsoft Authenticator on your iOS device in your security info in My Sign-Ins [Security info](https://mysignins.microsoft.com/security-info). Your device needs to run least iOS 17 or later.


1. Open a web browser and log in to your Microsoft (work or school) account.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_login.png" alt-text="Screenshot of how to sign in using Microsoft Authenticator for iOS devices.":::

1. Go to the **Security info** screen and tap on **+ Add sign-in method**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_securityinfo.png" alt-text="Screenshot of the Security Info screen in Microsoft Authenticator for iOS devices.":::

1. You should see options for the sign-in methods available.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_in_authenticator.png" alt-text="Screenshot of the drop-down list of options in Microsoft Authenticator for iOS devices.":::

1. Select **Passkey in Microsoft Authenticator** from the drop-down menu, then tap **Add**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_add-signin-method.png" alt-text="Screenshot of the Security Info screen Add Sign-in Method option.":::

1. Sign in with multifactor authentication (MFA) before adding a passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_2fa-authorization.png" alt-text="Screenshot of the 2-factor authentication requirement to setup a passkey.":::

1. Tap **Next** and step through the rest of the passkey setup.

   1. Verify your account.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios-signin-2fa.png" alt-text="Screenshot of the 2-factor method use to authenticate user.":::

   1. If necessary, download Microsoft Authenticator and tap **Next**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_download_auth_app.png" alt-text="Screenshot of the download app option in Microsoft Authenticator for iOS devices.":::

   1. Click **I understand**. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_understand.png" alt-text="Screenshot of the I understand option in Microsoft Authenticator for iOS devices.":::

   1. Create a passkey.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_create-passkey.png" alt-text="Screenshot of the create a passkey option in Microsoft Authenticator for iOS devices.":::

   1. Turn on passkey support.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_turn_on_support.png" alt-text="Screenshot of the turn on passkey support option in Microsoft Authenticator for iOS devices.":::

   1. Scan QR code to save your passkey. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_qr_code.png" alt-text="Screenshot of the scan QR code in Microsoft Authenticator for iOS devices.":::

   1. Save the passkey to Authenticator.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_create_passkey.png" alt-text="Screenshot of save passkey in Microsoft Authenticator for iOS devices.":::

   1. Once the passkey is successsfully created, tap **Done**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_success.png" alt-text="Screenshot of the successful creation of a passkey in Microsoft Authenticator for iOS devices.":::

   1. You can now display the passkey in **Security Info**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_listed_security_info.png" alt-text="Screenshot of the Security Info user display of the successful passkey.":::

   1. Read the passkey details.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey_details.png" alt-text="Screenshot of the passkey details page of the successful passkey.":::

- If the a passkey already exists, you see this screen: 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_already_exists.png" alt-text="Screenshot of the passkey that already exists in Microsoft Authenticator for iOS devices.":::

- To remove a passkey, click the *Trash* icon, then tap **Delete** to confirm.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkeyios_delete.png" alt-text="Screenshot of the passkey to delete in Microsoft Authenticator for iOS devices.":::

> [!NOTE]
> You also need to delete the passkey from **Security Info**, using a web browser and logging in to [https://mysignins.microsoft.com/security-info](https://mysignins.microsoft.com/security-info).   


# [:::image type="icon" source="media/icons/android-icon.png" border="false"::: **Android**](#tab/Android)

This article shows how to register a passkey with Microsoft Authenticator on your Android device in your security info in My Sign-Ins [Security info](https://mysignins.microsoft.com/security-info). Your device needs to run Android version 14 or later. 

1. Go to [Security info](https://mysignins.microsoft.com/security-info), and tap **+ Add sign-in method** > **Choose a method** > **Passkey in Microsoft Authenticator** > **Add**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/add-passkey-authenticator.png" alt-text="Screenshot of how to add passkey in Microsoft Authenticator as a sign-in method.":::

1. Sign in with multifactor authentication (MFA) before you can add a passkey, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/set-up-passkey.png" alt-text="Screenshot that notifies user to sign in with a second factor before they add a passkey.":::

1. If necessary, download Microsoft Authenticator, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/organization.png" alt-text="Screenshot that notifies user that their organization requires them to add a passkey.":::

1. Choose **Android**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-device.png" alt-text="Screenshot that lets user choose iOS or Android.":::

1. Follow the steps to turn on Authenticator in the **Settings app**:
   1. On your Android device, open the **Settings app**.
   1. Open **Passwords and accounts**.
   1. Under **Additional providers**, turn on Authenticator. 
   1. After you turn on Authenticator, tap **Continue**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/turn-on-passkey-android.png" alt-text="Screenshot that notifies user to turn on Authenticator in Seetings app on their Android device.":::

1. Open a QR scanner app and tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to open a QR scanner app.":::

1. The next screen lets you choose to **Save another way** when you create a passkey in Authenticator. Tap **I understand**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to save another way.":::
   
1. Chooose **iPhone, iPad, or Android device** and tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-where-to-save.png" alt-text="Screenshot that lets user choose where to save their passkey.":::

1. Use the Camera app to scan the QR code, and then open the link.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan-code.png" alt-text="Screenshot of QR code.":::

1. When prompted, sign in with a biometric option. If you can't use bioemtric, tap **Use screen lock**.

1. Your device should connect and sign you in. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/device-connected.png" alt-text="Screenshot that notifies user that device is connected.":::

1. After you are redirected to security info, you can change the default name for the new sign-in method. Click **Done** to save the new method.    

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/success.png" alt-text="Screenshot where user can change friendly nme of the new sign-in method.":::
 
---

## FAQs

### What if I already have a passkey?

### I chose the wrong passkey provider. How can I retry?

### How can I delete a passkey?

Go to [Security info](https://mysignins.microsoft.com/security-info), find the passkey in the list of available sign-in methods, and click **Delete**.


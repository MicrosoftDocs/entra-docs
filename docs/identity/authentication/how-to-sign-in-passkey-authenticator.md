---
title: Create a passkey for Android or iOS device in Microsoft Authenticator
description: Learn how to create a passkey for Android or iOS device with Microsoft Authenticator

services: active-directory
ms.service: active-directory
ms.subservice: authentication
ms.topic: how-to
ms.date: 02/20/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui

ms.collection: M365-identity-device-management
---
# Create a passkey for Android or iOS device in Microsoft Authenticator

# [:::image type="icon" source="media/icons/ios-icon.png" border="false"::: **iOS**](#tab/iOS)

[Wizard method](#wizard-method-ios)<br>
[Direct method](#direct-method-ios)<br>
[Sign-in steps](#sign-in-steps-ios)<br>

### Wizard method (iOS)

This article shows how to register a passkey with Microsoft Authenticator on your iOS device. Your device needs to run iOS version 17 or later. 

1. Open a web browser and log in to your Microsoft (work or school) account.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/open-browser.png" alt-text="Screenshot of the open a web browser prompt in Microsoft Authenticator for iOS devices.":::

1. Sign in to your Microsoft account. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/sign-in-account.png" alt-text="Screenshot of the sign-in to Microsoft prompt in Microsoft Authenticator for iOS devices.":::

1. Type your password. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/type-password.png" alt-text="Screenshot of the type your password prompt in Microsoft Authenticator for iOS devices.":::

1. More information required. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/more-info-required.png" alt-text="Screenshot of the more information required prompt in Microsoft Authenticator for iOS devices.":::

1. Click **Next** to keep your account secure. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/keep-account-secure.png" alt-text="Screenshot of the keep your account secure prompt in Microsoft Authenticator for iOS devices.":::

1. Select a sign-in method. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/add-sign-in-method.png" alt-text="Screenshot of the select a sign-in method prompt in Microsoft Authenticator for iOS devices.":::

1. Tap **Continue**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/click-continue.png" alt-text="Screenshot of the continue next prompt in Microsoft Authenticator for iOS devices.":::

1. Tap the iCloud password. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/icloud-password.png" alt-text="Screenshot of the iCloud password prompt in Microsoft Authenticator for iOS devices.":::

1. Tap **I understand** to continue.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/click-understand.png" alt-text="Screenshot of the understand to continue required prompt in Microsoft Authenticator for iOS devices.":::

1. Tap **Try again** to continue.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/try-again.png" alt-text="Screenshot of the try again prompt in Microsoft Authenticator for iOS devices.":::

1. Tap **Continue** to create a passkey. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/continue-save-passkey.png" alt-text="Screenshot of the create a passkey prompt in Microsoft Authenticator for iOS devices.":::

1. Tap **Try again** to continue.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/try-again-again.png" alt-text="Screenshot of the try again a second time prompt in Microsoft Authenticator for iOS devices.":::

1. Tap **Next** to continue. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/failed-to-continue.png" alt-text="Screenshot of the failed to continue prompt in Microsoft Authenticator for iOS devices.":::

1. Tap **Done** to create passkey. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-ios/create-passkey.png" alt-text="Screenshot of the done to create passkey prompt in Microsoft Authenticator for iOS devices."

### Direct method (iOS)

If your organization requires you to register a passkey in Microsoft Authenticator you’ll be prompted after sign-in to add a passkey. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/add-passkey.png" alt-text="Screenshot of the add passkey prompt in Microsoft Authenticator for iOS devices."::: 

1. If necessary, download **Microsoft Authenticator**, then tap **Next**. 

1. Choose **iPhone** or **iPad**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/save-as-ios.png" alt-text="Screenshot of the Save as iOS prompt in Microsoft Authenticator for iOS devices.":::

1. Follow the steps to turn on Authenticator in the **Settings** app: 

   1. On your iOS device, open the Settings app. 
   1. Under password, select **Password options**.   
   1. Ensure **Autofill Passwords and Passkeys** is turned on. 
   1. Select **Authenticator**, then tap **Continue**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/save-to-continue.png" alt-text="Screenshot of the save to continue prompt in Microsoft Authenticator for iOS devices.":::

   1. Tap **Next**, and you’ll be directed to `login.microsoft.com`.  
   1. A security prompt open and ask where you would like to save your passkey.

   > [!NOTE] 
   > Your browser and device might show different options. If the device where you started the registration process supports passkeys, you can save the passkey to that device. Select **Use another device** or **More options** to see other ways to save the passkey. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/choose-where-store-passkey.png" alt-text="Screenshot of the dialog where to save your passkey in Microsoft Authenticator for iOS devices.":::

1. (Optional) If you previously set up a passkey on a mobile device and selected the option to remember that device for quicker sign-in, the device name may appear as a selectable option. In this case, do the following:   

   1. Select **iPhone** or **iPad** device. 
   1. Open the camera on your iOS or Android device and scan the QR code shown. 

       :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/camera.png" alt-text="Screenshot of the QR code to scan in Microsoft Authenticator for Android devices.":::

   1. In your camera, tap the link to **Use a passkey** or **Save a passkey**. 
   1. Follow the system prompts, connect your device, and register a passkey in Microsoft Authenticator.
   1. Upon completion on the device, review any more information from the security dialog and continue.
   1. After you'e redirected to **Security info**, you can change the default name for the new sign-in method.    
   1. Tap **Done** to save the new method. 

### Sign-in steps (iOS)

1. Open your browser and go to `login.microsoftonline.com`.
1. Select **Sign-in options**. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for iOS devices.":::

1. Select **Face**, **Fingerprint**, **PIN**, or **Security key**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for iOS devices.":::

# [:::image type="icon" source="media/icons/android-icon.png" border="false"::: **Android**](#tab/Android)

[Wizard method](#wizard-method-android)
[Direct method](#direct-method-android)
[Sign-in steps](#sign-in-steps-android)

### Wizard method (Android)

This article shows how to sign in with a passkey in Microsoft Authenticator on your Android device. Your device needs to run least Android 14 or later.

1. Open a web browser and log in to your Microsoft (work or school) account.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/login-microsoft.png" alt-text="Screenshot of the login screen in Microsoft Authenticator for android devices.":::

1. Sign in using your credentials. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/sign-in-android.png" alt-text="Screenshot of the sign in screen in Microsoft Authenticator for android devices.":::

1. Type  your password. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/type-password.png" alt-text="Screenshot of the type password screen in Microsoft Authenticator for android devices.":::

1. Tap **next** to create a passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/more-information-required.png" alt-text="Screenshot of the more information required prompt in Microsoft Authenticator for android devices.":::

1. Tap **Next** to continue.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/keep-account-secure.png" alt-text="Screenshot of the keep account secure prompt in Microsoft Authenticator for android devices.":::

1. Add a sign-in method.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/add-sign-in-method.png" alt-text="Screenshot of the add sign-in method prompt in Microsoft Authenticator for android devices.":::

1. Tap **continue** to add passkey support.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/add-passkey-support.png" alt-text="Screenshot of the add passkey support prompt in Microsoft Authenticator for android devices.":::

1. List of password accounts. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/list-password-accounts.png" alt-text="Screenshot of the list password accounts prompt in Microsoft Authenticator for android devices.":::

1. Tap **I understand** to keep your account secure. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/keep-account-secure.png" alt-text="Screenshot of the keep accounts secure prompt in Microsoft Authenticator for android devices.":::

1. Tap **Try again** to save another way. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/save-another-way.png" alt-text="Screenshot of the save another way again prompt in Microsoft Authenticator for android devices.":::

1. Tap **Continue** to create a passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/create-passkey.png" alt-text="Screenshot of the create passkey prompt in Microsoft Authenticator for android devices.":::

1. Tap **Try again** to save a passkey. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/try-again.png" alt-text="Screenshot of the try again prompt in Microsoft Authenticator for android devices.":::

1. Try again if it failed to register a passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/failed-to-register.png" alt-text="Screenshot of the failed to register prompt in Microsoft Authenticator for android devices.":::

1. Select where to save passkey. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/select-save-passkey.png" alt-text="Screenshot of the select save passkey prompt in Microsoft Authenticator for android devices.":::

1. Use screen lock. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/use-screen-lock.png" alt-text="Screenshot of the use screenlock prompt in Microsoft Authenticator for android devices.":::

1. Try again to save another way. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/save-another-way.png" alt-text="Screenshot of the save another way again prompt in Microsoft Authenticator for android devices.":::

1. Tap **Done** to creata a passkey. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-interrupt-android/done-save-passkey.png" alt-text="Screenshot of the finished passkey prompt in Microsoft Authenticator for android devices.":::

### Direct method (Android)

1. If your organization requires you to register a passkey in Microsoft Authenticator, you get prompted to add a passkey after you sign in. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/add-passkey.png" alt-text="Screenshot of the add passkey prompt in Microsoft Authenticator for Android devices.":::

1. If necessary, download **Microsoft Authenticator**, then tap **Next**. 

1. Choose **Android**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/save-as-android.png" alt-text="Screenshot of the Save as Android prompt in Microsoft Authenticator for Android devices.":::

1. Follow the steps to turn on Authenticator in the **Settings** app: 

   1. On your Android device, open the **Settings** page. 
   1. Tap **Passwords and accounts**. 
   1. Under **Additional providers**, turn on **Authenticator**. 
   1. After you turn on **Authenticator**, tap **Continue**.  

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/save-to-continue.png" alt-text="Screenshot of the save to continue prompt in Microsoft Authenticator for Android devices.":::

   1. Tap **Next**, then you’ll be directed to `login.microsoft.com`.  
   1. A security prompt opens and asks where you would like to save your passkey.

   > [!NOTE] 
   > Your browser and device might show different options. If the device where you started the registration process supports passkeys, you can save the passkey to that device. Select **Use another device** or **More options** to see other ways to save the passkey. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/choose-where-store-passkey.png" alt-text="Screenshot of the dialog where to save your passkey in Microsoft Authenticator for Android devices.":::

1. (Optional) If you previously set up a passkey on a mobile device and selected the option to remember that device for quicker sign-in, you might be able to select that device. In this case, do the following:   

   1. Select **Android** device. 
   1. Open the camera on your iOS or Android device and scan the QR code shown. 

       :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/camera.png" alt-text="Screenshot of the QR code to scan in Microsoft Authenticator for Android devices.":::

   1. In your camera, tap the link to **Use a passkey** or **Save a passkey**. 
   1. Follow the system prompts, connect your device, and register a passkey in Microsoft Authenticator.
   1. Upon completion on the device, review any more information from the security dialog and continue.
   1. After you're redirected to **Security info**, you can change the default name for the new sign-in method.
   1. Tap **Done** to save the new method. 

 
### Sign-in steps (Android)

1. Open your browser and go to `login.microsoftonline.com`.
1. Select **Sign-in options**. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for Android devices.":::

1. Select **Face**, **Fingerprint**, **PIN**, or **Security key**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for Android devices.":::

---

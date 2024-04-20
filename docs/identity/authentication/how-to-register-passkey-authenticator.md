---
title: Register passkeys in Authenticator on Android and iOS devices in MySecurityInfo (preview)
description: Registration and management of passkey with Authenticator on iOS in MySecurityInfo (preview).

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 04/19/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users can register a passkey in Microsoft Authenticator 

---
# Register passkeys in Authenticator on Android or iOS devices (preview)

This article shows how to register a passkey using Microsoft Authenticator on your iOS or Android device by directly signing into the Authenticator app or by using [My Security info](https://aka.ms/mysecurityinfo). For more information on the availability of Microsoft Entra ID passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md).

**Note that the *easiest and fastest way* to add a passkey is to add it directly in the Authenticator app.**

Alternatively, you can add a passkey from your mobile device browser, or through cross-device registration using another device, such as a laptop. Your mobile device needs to run iOS version 17, or Android version 14, or later. 

## [**iOS**](#tab/iOS)

### Same-device registration by signing into Authenticator (iOS)
You can sign in to the Authenticator to create a passkey in the app and get seamless Single Sign-on across Microsoft native apps. This is the recommended and preferred flow to setup a passkey in the app. 

1. Open Authenticator.
1. Tap the **+** button.
1. Select **Work or school account**.
1. Sign in.
1. You need to complete multifactor authentication (MFA).
1. Follow the on-screen instructions. On your iOS device, open the **Settings** app.
   1. Open **Passwords** select **Password Options**.
   1. Ensure **Autofill Passwords and and Passkeys** is turned on.
   1. Under Use **Passwords and Passkeys** From select **Authenticator**.
1. Authenticator sets up passkey, passwordless, and/or MFA for sign-in according to your work or school account policies.

If you already have an account in the Authenticator app, or you are signed in to the Authenticator app, you still need to go through the above mentioned flow to add a passkey in the app.

### Same-device registration from a browser (iOS)
Alternatively, users can set up a passkey in the Authenticator by navigating to a browser and initiating the flow from My Security info.

1. Using your iOS device, open a web browser and sign-in to [My Security info](https://aka.ms/mysecurityinfo).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-login.png" alt-text="Screenshot of how to sign in using Microsoft Authenticator for iOS devices.":::
   
1. Tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-security-info.png" alt-text="Screenshot of the Security Info screen in Microsoft Authenticator for iOS devices.":::

1. Select **Passkey in Microsoft Authenticator (preview)**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-in-authenticator.png" alt-text="Screenshot of the drop-down list of options in Microsoft Authenticator for iOS devices.":::

1. Tap **Add**. 
   
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-add-sign-in-method.png" alt-text="Screenshot of the Security Info screen Add Sign-in Method option.":::

1. Sign in with multifactor authentication (MFA) before adding a passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-2fa-authorization.png" alt-text="Screenshot of the two-factor authentication requirement to set up a passkey.":::

   After  you sign-in with MFA, continue through the rest of the passkey setup.

1. If necessary, download Microsoft Authenticator and tap **Next**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-download-auth-app.png" alt-text="Screenshot of the download app option in Microsoft Authenticator for iOS devices.":::

1. Follow the steps to turn on Authenticator in the **Settings app** of your iOS device:
      - On your iOS device, open the **Settings app**.
      - Open **Passwords** select **Password Options**.
      - Ensure **Autofill Passwords and and Passkeys** is turned on. 
      - Under **Use Passwords and Passkeys From** select **Authenticator**. 
      - Return to **My Security info** and select **Continue**. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-turn-on-support.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for iOS devices.":::

1. When ready, read the reminder that you must save the passkey in Authenticator, and tap **I understand** to continue.  

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-understand.png" alt-text="Screenshot of the I understand option in Microsoft Authenticator for iOS devices.":::

1. Your device opens a security window. Save the passkey to Authenticator following the prompts on your device. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-create-passkey.png" alt-text="Screenshot of the save passkey option in Microsoft Authenticator for iOS devices.":::

1. Once the passkey is successfully created on your device, you're directed back to **My Security info**, then tap **Done**. 
1. Name the passkey something memorable to you, and select **Done**. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-success.png" alt-text="Screenshot of the successful creation of a passkey in Microsoft Authenticator for iOS devices.":::

1. You can now see the passkeys in Authenticator along with your other registered security info options.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-listed-security-info.png" alt-text="Screenshot of the Security Info user display of the successful passkey.":::

### Cross-device registration (iOS)
You can choose to attempt passkey registration from your computer or another mobile device. 

1. Using another device, such as a laptop, open a web browser and sign in to [My Security info](https://mysignins.microsoft.com/security-info).
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
   - Open **Passwords** select **Password Options**.
   - Ensure **Autofill Passwords and and Passkeys** is turned on. 
   - Under **Use Passwords and Passkeys From** select **Authenticator**. 
   - Return to My Security info and select **Continue**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/turn-on-passkey-android.png" alt-text="Screenshot that notifies user to turn on Authenticator in Settings app on their Android device.":::

1. Open the camera app on your mobile device. 
    > [!NOTE]
   > The camera inside the iOS Authenticator app does not support scanning a WebAuthn QR code. Please ensure you are using the system camera app.

1. When ready, read the reminder on the My Security info page that you must save the passkey in Authenticator and tap **Next** to continue. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to save another way.":::
   
1. A security dialog opens on your device. 

1. Tap **iPhone, iPad, or Android device**, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-where-to-save.png" alt-text="Screenshot that lets user choose where to save their passkey.":::

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey.

1. Use the system camera app to scan the QR code, then tap on **Save a passkey**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan-code.png" alt-text="Screenshot of QR code.":::

1. Your iOS device should now connect over Bluetooth to the device you started registration with.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/device-connected.png" alt-text="Screenshot that notifies user that device is connected.":::
   
   > [!NOTE]
   > Bluetooth and an internet connection is required for this step and must be enabled on both your mobile and remote device. 

1. Your iOS device opens a security window. Save the passkey to Authenticator following the prompts on your device. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-create-passkey.png" alt-text="Screenshot of save passkey in Microsoft Authenticator for iOS devices.":::

1. Once the passkey is successfully created on your device, you're directed back to **My Security info**, tap **Done**. 
1. Name the passkey something memorable to you and select **Done**.
   
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/success.png" alt-text="Screenshot where user can change friendly name of the new sign-in method.":::   

## Troubleshooting

If the passkey for your account is already registered in Authenticator, you'll see this error: 

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-already-exists.png" alt-text="Screenshot of the passkey that already exists in Microsoft Authenticator for iOS devices.":::

To re-register a passkey for your account, first remove the passkey from Authenticator. Click the *Trash* icon, then tap **Delete** to confirm.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-delete.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for iOS devices.":::

> [!NOTE]
> You also need to delete the passkey from [My Security info](https://aka.ms/mysecurityinfo).  

## [**Android**](#tab/Android)

### Same device registration by signing into Authenticator (Android)
You can sign in to the Authenticator to create a passkey in the app and get seamless Single Sign-on across Microsoft native apps. This is the recommended and preferred flow to setup a passkey in the app. 

1. Open Authenticator.
1. Tap the **+** button.
1. Select **Work or school account**.
1. Sign in.
1. You need to complete multifactor authentication (MFA).
1. Follow the on-screen instructions. On your Android device, open the **Settings app**.
   1. Open **Passwords & Accounts**.
   1. **Additional providers** enable **Authenticator**.
   1. Return to **My Security info** and select **Continue**.
1. Authenticator sets up passkey, passwordless, and/or MFA for sign-in according to your work or school account policies.

If you already have an account in the Authenticator app, or you are signed in to the Authenticator app, you still need to go through the above mentioned flow to add a passkey in the app.

[!INCLUDE [Need APIs to support browsers](~/includes/passkeys-with-chrome-browser.md)]

## Same-device registration from a browser (Android)
Alternatively, users can set up a passkey in the Authenticator by navigating to a browser and initiating the flow from My Security info.

1. Using your Android device, open a web browser and sign-in to [My Security info](https://aka.ms/mysecurityinfo).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-login.png" alt-text="Screenshot of how to sign in using Microsoft Authenticator for Android devices.":::
   
1. Tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-security-info.png" alt-text="Screenshot of the Security Info screen in Microsoft Authenticator for Android devices.":::

1. Tap **Passkey in Microsoft Authenticator (Preview)**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/select-method.png" alt-text="Screenshot of the drop-down list of options in Microsoft Authenticator for Android devices.":::

1. Tap **Add** to confirm.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/confirm-add.png" alt-text="Screenshot of the Security Info screen to confirm adding a passkey option for Android devices.":::
   
1. Sign in with multifactor authentication (MFA) before adding a passkey. After signing in with MFA, you can continue through the rest of the passkey setup.

1. If necessary, download Microsoft Authenticator and tap **Next**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-download-auth-app.png" alt-text="Screenshot of the download app option in Microsoft Authenticator for Android devices.":::

1. Follow the steps to turn on Authenticator in the **Settings app** on your Android device:
      - On your Android device, open the **Settings app**.
      - Open **Passwords & Accounts**.
      - Under **Additional providers** enable **Authenticator**. 
      - Return to **My Security info** and select **Continue**.
  
        :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-add-support.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for Android devices.":::
         
      > [!NOTE]
      > Enabling passkey providers on Android may vary based on the make and model of your device. Search for passkey on your device settings or consult your device manufacturer for guidance.  
  

1. Tap **Next** to set up your passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/auth-app-selected.png" alt-text="Screenshot of the Security Info screen setting up your passkey option for Android devices.":::

   
1. When ready, read the reminder that you must save the passkey in Authenticator and tap **I understand** to continue.  

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-understand.png" alt-text="Screenshot of the I understand option in Microsoft Authenticator for Android devices.":::

1. Tap **Continue** to save another way. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/save-another-way.png" alt-text="Screenshot of the option to save another way in Microsoft Authenticator for Android devices.":::

1. Your device opens a security window. Follow the prompts on your device to save the passkey to Authenticator. 
      
      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-auth-app.png" alt-text="Screenshot of selecting Authenticator for Android devices.":::

1. Name the passkey something memorable to you and select **Done**. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-success.png" alt-text="Screenshot of successfully creating of a passkey in Microsoft Authenticator for Android devices.":::

1. Once the passkey is successfully created on your device, you're directed back to **My Security info**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/done.png" alt-text="Screenshot of passkey saved in MySecurityInfo.":::

1. You can now see the passkeys in Authenticator along with your other registered security info options.
  
## Cross-device registration (Android)
You can choose to attempt passkey registration from your computer or another mobile device.

1. Open a web browser and sign in to [My Security info](https://mysignins.microsoft.com/security-info).
1. Tap **+ Add sign-in method** > **Choose a method** > **Passkey in Microsoft Authenticator (preview)** > **Add**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/add-passkey-authenticator.png" alt-text="Screenshot of how to add passkey in Microsoft Authenticator as a sign-in method for Android devices.":::

1. Sign in with multifactor authentication (MFA) before you can add a passkey, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/set-up-passkey.png" alt-text="Screenshot that notifies user to sign in with a second factor before they add a passkey for Android devices.":::

1. If necessary, download Microsoft Authenticator, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/organization.png" alt-text="Screenshot that notifies user that their organization requires them to add a passkey for Android devices.":::

1. Tap **Android**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-device.png" alt-text="Screenshot that lets user choose iOS or Android. Choose Android.":::

1. Follow the steps to turn on Authenticator in the **Settings app** of your Android device:
   - On your Android device, open the **Settings app**.
   - Open **Passwords & Accounts**.
   - Under **Additional providers** enable **Authenticator**. 
   - Return to **My Security info** and select **Continue**.
         
   > [!NOTE]
   > Enabling passkey providers on Android may vary based on the make and model of your device. Search for passkey on your device settings or consult your device manufacturer for guidance.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/turn-on-passkey-android.png" alt-text="Screenshot that notifies user to turn on Authenticator in Settings app on their Android device.":::

1. Open the system camera app on your mobile device. Alternatively, you can use the camera in the Authenticator as well by navigating to "Add work or school account" -> "Scan QR Code".  

1. When ready, read the reminder that you must save the passkey in Authenticator and tap **Next** to continue. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to save another way for Android devices.":::
   
1. A security dialog opens on your device.
   
1. Tap **iPhone, iPad, or Android device** and tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-where-to-save.png" alt-text="Screenshot that lets user choose where to save their passkey for Android devices.":::

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey.

1. Use the camera you have opened to scan the QR code, and then tap **Use passkey**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan-code.png" alt-text="Screenshot of QR code for Android devices.":::

1. Your Android device should now connect over Bluetooth to the device you started registration with.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/device-connected.png" alt-text="Screenshot that notifies user that device is connected for Android devices.":::
   
   > [!NOTE]
   > Bluetooth and an internet connection are required for this step and must both be enabled on your mobile and remote device. 

1. Your device opens a security window. Save the passkey to Authenticator following the prompts on your device.
   
1. Once the passkey is successfully created on your device, you're directed back to **My Security info**.
   
1. Name the passkey something memorable to you and select **Done**. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/success.png" alt-text="Screenshot of the successful creation of a passkey in Microsoft Authenticator for Android devices.":::

## Deleting your passkey in Authenticator
To remove the passkey from Authenticator, click the *Trash* icon, then tap **Delete** to confirm.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-delete.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for Android devices.":::

> [!NOTE]
> You also need to delete the passkey from **Security Info**, using a web browser and logging in to [My Security info](https://aka.ms/mysecurityinfo). 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server due to different reasons, such as when the passkey provider isn't permitted, or the connection timed out. In those instances, if you attempt to re-register the passkey, you need to first delete the passkey that was created locally in the Authenticator app.

To remove the passkey from Authenticator, click the *Trash* icon, then tap **Delete** to confirm.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-delete.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for Android devices.":::

> [!NOTE]
> You also need to delete the passkey from **Security Info**, using a web browser and logging in to [My Security info](https://aka.ms/mysecurityinfo).  

---

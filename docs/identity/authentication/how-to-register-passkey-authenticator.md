---
title: Register passkeys in Authenticator on Android and iOS devices in Security info
description: Registration and management of passkey with Authenticator on iOS in Security info.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/09/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users can register a passkey in Microsoft Authenticator 

---
# Register passkeys in Authenticator on Android or iOS devices

This article shows how to register a passkey using Microsoft Authenticator on your iOS or Android device by directly signing into the Authenticator app or by using [Security info](https://aka.ms/mysecurityinfo). For more information on the availability of Microsoft Entra ID passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md).

**The *easiest and fastest way* to add a passkey is to add it directly in the Authenticator app.**

Alternatively, you can add a passkey from your mobile device browser, or through cross-device registration using another device, such as a laptop. Your mobile device needs to run iOS version 17, or Android version 14, or later. Support for earlier versions of Android is coming soon. 

| Scenario | iOS | Android |
|------------------|---------------------------------|----------------|
| **Same-device registration by signing into Authenticator**              | &#x2705;          | &#x2705;       |
| **Same-device registration in a browser**            | &#x2705; | &#x2705;<sup>1</sup>     |
| **Cross-device registration**  | &#x2705;  | &#x2705;    |

<sup>1</sup>Support for same-device registration in Edge on Android is coming soon.

## [**iOS**](#tab/iOS)

### Same device registration using direct sign in to Authenticator (iOS)

You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on (SSO) across Microsoft native apps. This is the recommended and preferred flow to set up a passkey in Authenticator. If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Open Authenticator.
1. Tap **Add account** or the **+** button.
   > [!NOTE]
   > If you already have an account in Authenticator, you still need to tap on the **+** button to sign in and register a passkey for that same account.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/add-account-ios.png" alt-text="Screenshot of how to register using Microsoft Authenticator for iOS devices.":::

1. Select **Work or school account**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/work-school-account-ios.png" alt-text="Screenshot of choosing Work or School Account using Microsoft Authenticator for iOS devices.":::
 
1. Tap **Sign in**.
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/tap-sign-in-ios.png" alt-text="Screenshot of tapping the Sign in option using Microsoft Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot of completing  multifactor authentication (MFA) using Microsoft Authenticator for iOS devices.":::

1. click Register


1. Select **Open Settings** to enable Authenticator as a passkey provider.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-provider-ios.png" alt-text="Screenshot of Open Settings and follow the on-screen instructions using Microsoft Authenticator for iOS devices.":::

1. Open **Passwords**, then select **Password Options**.
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/password-options-ios.png" alt-text="Screenshot of select Passwords and selecting Password Options using Microsoft Authenticator for iOS devices.":::

1. Ensure **Autofill Passwords and Passkeys** is turned on.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/autofill-passwords-ios.png" alt-text="Screenshot of Autofill Passwords and Passkeys is turned on using Microsoft Authenticator for iOS devices.":::

1. In the **Use Passwords and Passkeys From** option, make sure **Authenticator** is selected.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/select-authenticator-ios.png" alt-text="Screenshot of Use Passwords and Passkeys from using Microsoft Authenticator for iOS devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign in according to your work or school account policies. 

    :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-added-ios.png" alt-text="Screenshot of setting up passkey, passwordless, and/or MFA for sign in using Microsoft Authenticator for iOS devices.":::

1. Tap **Go to Authenticator**. 

1. Tap **Continue** to complete the registration process. 

   enter TAP

1. After you see passkey added as a sign-in method for your account, click **Continue**. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-added-ios.png" alt-text="Screenshot of that shows passkey in Authenticator added as a sign-in method for iOS devices.":::

1. Authenticator opens, and you can see the new account you added.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/new-authenticator-account.png" alt-text="Screenshot of a new account in Authenticator for iOS devices.":::


### Same-device registration from a browser (iOS)

You can also use your web browser to set up a passkey in Authenticator.

1. Using your iOS device, open a web browser and sign-in to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-login.png" alt-text="Screenshot of how to sign in using Microsoft Authenticator for iOS devices.":::
   
1. Tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-security-info.png" alt-text="Screenshot of the Security Info screen in Microsoft Authenticator for iOS devices.":::

1. Where you're asked to **Choose a method**, select **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-in-authenticator.png" alt-text="Screenshot of the drop-down list of options in Microsoft Authenticator for iOS devices.":::

1. Tap **Add**. 
   
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-add-sign-in-method.png" alt-text="Screenshot of the Security Info screen Add Sign-in Method option.":::

1. If necessary, download Microsoft Authenticator and tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-download-auth-app.png" alt-text="Screenshot of the download app option in Microsoft Authenticator for iOS devices.":::

1. Read the steps to turn on Authenticator as a passkey provider in the **Settings** of your iOS device, and click **Continue**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/auth-app-install-step-one.png" alt-text="Screenshot of the steps to turn on Authenticator as a passkey provider.":::

1. On your iOS device, open **Settings** > **Passwords** > **Password Options**. Ensure **AutoFill Passwords and and Passkeys** is turned on. Under **Use Passwords and Passkeys From**, select **Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for iOS devices.":::
 
1. Return to [Security info](https://mysignins.microsoft.com/security-info) and complete MFA to sign in. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-manage-mode.png" alt-text="Screenshot of how to complete MFA to access the Security info page.":::

1. You can see your passkey in Authenticator as a new sign-in method. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/new-passkey-in-security-info.png" alt-text="Screenshot of a new passkey for Authenticator for iOS in the Security info page.":::



   select **Continue**. 


1. When ready, read the reminder that you must save the passkey in Authenticator, and tap **I understand** to continue.  

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-understand.png" alt-text="Screenshot of the I understand option in Microsoft Authenticator for iOS devices.":::

1. Your device opens a security window. Save the passkey to Authenticator following the prompts on your device. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-create-passkey.png" alt-text="Screenshot of the save passkey option in Microsoft Authenticator for iOS devices.":::

1. Once the passkey is successfully created on your device, you're directed back to [Security info](https://mysignins.microsoft.com/security-info). 
1. Name the passkey something memorable to you, and select **Done**. 

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-success.png" alt-text="Screenshot of the successful creation of a passkey in Microsoft Authenticator for iOS devices.":::

1. You can now see the passkeys in Authenticator along with your other registered security info options.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-listed-security-info.png" alt-text="Screenshot of the Security Info user display of the successful passkey.":::

### Cross-device registration (iOS)
You can also save a passkey in Authenticator from your computer or another mobile device. This registration option requires Bluetooth and an internet connection for both devices. If your organizations restricts Bluetooth usage, an administrator can allow cross-device registration of passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. Using another device, such as a laptop, open a web browser and sign in to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop.png" alt-text="Screenshot of how to enter a temporary access pass on a laptop.":::

1. When prompted to stay signed in, select **Yes**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/stay-signed-in.png" alt-text="Screenshot of option to Stay signed in.":::

1. Tap **+ Add sign-in method** > choose **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. When you're asked to sign in with multifactor authentication (MFA), select **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/sign-in-required.png" alt-text="Screenshot that notifies user to sign in with a second factor before they add a passkey.":::

1. If necessary, download Microsoft Authenticator, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. On you iOS device, open Microsoft Authenticator and click **+** to add an account.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/authenticator-add-account-ios-actual.png" alt-text="Screenshot that notifies user that their organization requires them to add a passkey.":::

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/authenticator-add-account-ios-small.png" alt-text="Screenshot that notifies user that their organization requires them to add a passkey.":::

1. Choose Work or school acount.

1. Tap **iOS**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-device-ios.png" alt-text="Screenshot that lets user choose iOS or Android.":::

1. Follow the steps to turn on Authenticator as a passkey provider in **Settings** of your iOS device:
   - On your iOS device, open **Settings**.
   - Open **Passwords** select **Password Options**.
   - Ensure **Autofill Passwords and and Passkeys** is turned on. 
   - Under **Use Passwords and Passkeys From** select **Authenticator**. 
   - Return to [Security info](https://mysignins.microsoft.com/security-info), and select **Continue**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/turn-on-passkey-android.png" alt-text="Screenshot that notifies user to turn on Authenticator in Settings app on their Android device.":::

1. Make sure Bluetooth is enabled on both devices, and click **I'm ready**.

   > [!NOTE]
   > Bluetooth and an internet connection is required for this step and must be enabled on both your mobile and remote device. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/bluetooth-ready.png" alt-text="Screenshot that notifies user that Bluetooth is enabled for iOS device.":::

1. In the security dialog that opens on your device, tap **iPhone, iPad, or Android device**, and tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-where-to-save.png" alt-text="Screenshot that lets user choose where to save their passkey for iOS devices.":::

   > [!NOTE]
   > The displayed options can vary on different browsers and devices. If the device where you started the registration process supports passkeys, you're asked to save the passkey to that device. Select **Use another device** or **More options** to see other ways you can save the passkey.

1. Open the camera app on your mobile device. 
   > [!NOTE]
   > The camera inside the iOS Authenticator app doesn't support scanning a WebAuthn QR code. Make sure you use the system camera app.

1. Use the system camera app to scan the QR code, then tap **Save a passkey**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan-code.png" alt-text="Screenshot of QR code.":::

1. Your iOS device should now connect over Bluetooth to the device you started registration with.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/device-connected.png" alt-text="Screenshot that notifies user that device is connected.":::
   

1. Your iOS device opens a security window. Save the passkey to Authenticator following the prompts on your device. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-create-passkey.png" alt-text="Screenshot of save passkey in Microsoft Authenticator for iOS devices.":::

1. Once the passkey is successfully created on your device, you're directed back to [Security info](https://mysignins.microsoft.com/security-info), tap **Done**. 
1. Name the passkey something memorable to you and select **Done**.
   
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/success.png" alt-text="Screenshot where user can change friendly name of the new sign-in method.":::

## Delete your passkey in Authenticator for iOS

To remove the passkey from Authenticator, click the *Trash* icon, then tap **Delete** to confirm.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-delete.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for Android devices.":::

> [!NOTE]
> You also need to delete the passkey from [Security info](https://mysignins.microsoft.com/security-info). 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-ios) that was created locally in Authenticator, and retry registration.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-delete.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for Android devices."::: 

## [**Android**](#tab/Android)

### Same device registration using direct sign in to Authenticator (Android)

You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on (SSO) across Microsoft native apps. This is the recommended and preferred flow to set up a passkey in Authenticator. If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Open Authenticator.
1. Tap **Add account** or the **+** button.
   > [!NOTE]
   > If you already have an account in the Authenticator, you need to still tap on the **+** button to sign in and register a passkey for that same account.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/add-account-android.png" alt-text="Screenshot of how to register using Microsoft Authenticator for Android devices.":::

1. Select **Work or school account**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/work-school-account-android.png" alt-text="Screenshot of choosing Work or School Account using Microsoft Authenticator for Android devices.":::

1. Tap **Sign in**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/tap-sign-in-android.png" alt-text="Screenshot of tapping the Sign in option using Microsoft Authenticator for Android devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/multifactor-auth-android.png" alt-text="Screenshot of completing multifactor authentication (MFA) using Microsoft Authenticator for Android devices.":::

1. Select **Settings** to enable Authenticator as a passkey provider.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/passkey-provider-android.png" alt-text="Screenshot of Open Settings and follow the on-screen instructions using Microsoft Authenticator for Android devices."::: 
 
1. Open **Passwords and accounts**.
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/password-options-android.png" alt-text="Screenshot of select Passwords and Password Options using Microsoft Authenticator for Android devices.":::

1. In the **Additional providers** section, make sure **Authenticator** is selected. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/enable-authenticator-android.png" alt-text="Screenshot of enabling Authenticator as a provider using Microsoft Authenticator for Android devices.":::

1. Return to **Authenticator app** and select **Done**.
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/passkey-done-android.png" alt-text="Screenshot of selecting Continue to complete using Microsoft Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign in according to your work or school account policies.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/passkey-added-android.png" alt-text="Screenshot of Use Passwords and Passkeys from using Microsoft Authenticator for Android devices.":::

## Same-device registration from a browser (Android)

Alternatively, users can set up a passkey in the Authenticator by navigating to a browser and initiating the flow from My Security info.

>[!NOTE]
>Support for same-device registration in Edge on Android is coming soon.

1. Using your Android device, open a web browser and sign-in to [My Security info](https://aka.ms/mysecurityinfo).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-login.png" alt-text="Screenshot of how to sign in using Microsoft Authenticator for Android devices.":::
   
1. Tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-security-info.png" alt-text="Screenshot of the Security Info screen in Microsoft Authenticator for Android devices.":::

1. Tap **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/select-method.png" alt-text="Screenshot of the drop-down list of options in Microsoft Authenticator for Android devices.":::

1. Tap **Add** to confirm.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/confirm-add.png" alt-text="Screenshot of the Security Info screen to confirm adding a passkey option for Android devices.":::
   
1. Sign in with multifactor authentication (MFA) before adding a passkey. After signing in with MFA, you can continue through the rest of the passkey setup.

1. If necessary, download Microsoft Authenticator and tap **Next**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-download-auth-app.png" alt-text="Screenshot of the download app option in Microsoft Authenticator for Android devices.":::

1. Follow the steps to turn on Authenticator as a passkey provider in the **Settings app** on your Android device:
      - On your Android device, open the **Settings app**.
      - Open **Passwords & Accounts**.
      - Under **Additional providers** enable **Authenticator**. 
      - Return to [Security info](https://mysignins.microsoft.com/security-info) and select **Continue**.
  
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

1. Once the passkey is successfully created on your device, you're directed back to [Security info](https://mysignins.microsoft.com/security-info).

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/done.png" alt-text="Screenshot of passkey saved in MySecurityInfo.":::

1. You can now see the passkeys in Authenticator along with your other registered security info options.


## Cross-device registration (Android)

You can also save a passkey in Authenticator from your computer or another mobile device. This registration option requires Bluetooth and an internet connection for both devices. If your organizations restricts Bluetooth usage, an administrator can allow cross-device registration of passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. Open a web browser and sign in to [Security info](https://mysignins.microsoft.com/security-info).
1. Tap **+ Add sign-in method** > choose **Passkey in Microsoft Authenticator** > **Add**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/add-passkey-authenticator.png" alt-text="Screenshot of how to add passkey in Microsoft Authenticator as a sign-in method for Android devices.":::

1. Sign in with multifactor authentication (MFA), then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/set-up-passkey.png" alt-text="Screenshot that notifies user to sign in with a second factor before they add a passkey for Android devices.":::

1. If necessary, download Microsoft Authenticator, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/organization.png" alt-text="Screenshot that notifies user that their organization requires them to add a passkey for Android devices.":::

1. Tap **Android**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-device-android.png" alt-text="Screenshot that lets user choose iOS or Android. Choose Android.":::

1. Follow the steps to turn on Authenticator as a passkey provider in **Settings** on your Android device:
   - On your Android device, open **Settings**.
   - Open **Passwords & Accounts**.
   - Under **Additional providers** enable **Authenticator**. 
   - Return to [Security info](https://mysignins.microsoft.com/security-info) and select **Continue**.
         
   > [!NOTE]
   > The steps to turn on a passkey provider on Android can vary on different devices. Search for passkey on your device settings or check your device help.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/turn-on-passkey-android.png" alt-text="Screenshot that notifies user to turn on Authenticator in Settings app on their Android device.":::

1. Make sure Bluetooth is enabled on both devices, and click **I'm ready**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/bluetooth-ready.png" alt-text="Screenshot that notifies user that Bluetooth is enabled for Android device.":::

1. In the security dialog that opens on your device, tap **iPhone, iPad, or Android device**, and tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-where-to-save.png" alt-text="Screenshot that lets user choose where to save their passkey for Android devices.":::

   > [!NOTE]
   > The displayed options can vary on different browsers and devices. If the device where you started the registration process supports passkeys, you're asked to save the passkey to that device. Select **Use another device** or **More options** to see other ways you can save the passkey.

1. Open the system camera app on your mobile device, or tap **Add work or school account** > **Scan QR Code** to use the camera in the Authenticator.  

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan-code.png" alt-text="Screenshot of QR code for Android devices.":::

   > [!NOTE]
   > For quicker sign-in, Android allows you to remember some browsers and Windows devices after scanning the WebAuthn QR code. In such cases, instead of having to scan a QR code each time, the device will appear as a selectable option, and you'll receive a notification on your mobile device to continue the passkey authentication.

1. Your Android device should now connect over Bluetooth to the device you started registration with.

   > [!NOTE]
   > Bluetooth and an internet connection are required for this step and both must be enabled on your mobile and remote device. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/device-connected.png" alt-text="Screenshot that notifies user that device is connected for Android devices.":::
   
1. A message confirms that the passkey is saved. Click **OK**.
   
1. Once the passkey is successfully created on your device, you're directed back to [Security info](https://mysignins.microsoft.com/security-info).
   
1. Name the passkey something memorable to you and select **Done**. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/success.png" alt-text="Screenshot of the successful creation of a passkey in Microsoft Authenticator for Android devices.":::

## Delete your passkey in Authenticator for Android

To remove the passkey from Authenticator, click the *Trash* icon, then tap **Delete** to confirm.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-delete.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for Android devices.":::

> [!NOTE]
> You also need to delete the passkey from [Security info](https://mysignins.microsoft.com/security-info). 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-android) that was created locally in Authenticator, and retry registration.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-delete.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for Android devices.":::

---

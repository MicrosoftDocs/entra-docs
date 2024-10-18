---
title: Register passkeys in Authenticator on Android and iOS devices
description: Registration and management of passkey with Authenticator on Android and iOS devices.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/18/2024

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

Alternatively, you can add a passkey from your mobile device browser, or through cross-device registration using another device, such as a laptop. Your mobile device needs to run iOS version 17, or Android version 14, or later.

| Scenario | iOS | Android |
|------------------|---------------------------------|----------------|
| **Same-device registration by signing into Authenticator**              | &#x2705;          | &#x2705;       |
| **Same-device registration in a browser**            | &#x2705; | &#x2705;<sup>1</sup>     |
| **Cross-device registration**  | &#x2705;  | &#x2705;    |

<sup>1</sup>Support for same-device registration in Edge on Android is coming soon.

## [**iOS**](#tab/iOS)

### Same device registration using direct sign in to Authenticator (iOS)

You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on (SSO) across Microsoft native apps. **This is the recommended and preferred flow to set up a passkey in Authenticator.** If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Download Authenticator from the App Store and go through the privacy screens once you open it.
1. Add your account in Authenticator on your iOS device. Tap **Add account** or the **+** button.
   > [!NOTE]
   > If you already have an account in Authenticator, tap on your account in the app and then tap on the settings gear on the top right of the account details page. Tap on "Create a passkey (Preview)" and skip directly to the sign in step of the flow.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/add-account-ios.png" alt-text="Screenshot 233x433 of how to register using Microsoft Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).

1. Select **Work or school account**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/work-school-account-ios.png" alt-text="Screenshot 233x409 of choosing Work or School Account using Microsoft Authenticator for iOS devices.":::
 
1. Tap **Sign in**.
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/tap-sign-in-ios.png" alt-text="Screenshot 234x417 of tapping the Sign in option using Microsoft Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot 246x445 of how to complete MFA by using Microsoft Authenticator for iOS devices.":::

1. When prompted to allow Authenticator to use Face ID/Touch ID, tap **Allow**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/allow-face.png" alt-text="Screenshot of how to allow Face ID for Microsoft Authenticator for iOS devices.":::

1. When prompted to allow Authenticator to send you notifications, tap **Allow**. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/allow-notifications.png" alt-text="Screenshot of how to allow notifications for Microsoft Authenticator for iOS devices.":::

1. Enable the Authenticator as a passkey provider. 
On iOS 18, navigate to **Settings** > **General** > **Autofill & Passwords**. On iOS 17, navigate to **Settings** > **Passwords** > **Password Options**. On both operating systems, make sure **AutoFill Passwords and and Passkeys** is turned on. Under **Autofill From**, make sure **Authenticator** is selected.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options-three.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for iOS devices.":::

1. Navigate back to the Authenticator app and continue. Authenticator sets up passkey, passwordless, and MFA for sign in according to your work or school account policies. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-added-ios.png" alt-text="Screenshot of setting up passkey, passwordless, and/or MFA for sign in using Microsoft Authenticator for iOS devices.":::

1. After you see passkey added as a sign-in method for your account, click **Continue** and you can now see the new account you added. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/new-authenticator-account.png" alt-text="Screenshot of a new account in Authenticator for iOS devices.":::


### Same-device registration from a browser (iOS)

You can also use your web browser to set up a passkey in Authenticator.

1. Using your iOS device, open a web browser and sign-in to [Security info](https://mysignins.microsoft.com/security-info). You need to complete MFA with any available method.

1. In Security info, tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-security-info-three.png" alt-text="Screenshot of the Security Info screen on an iOS devices.":::

1. Where you're asked to **Choose a method**, select **Passkey in Microsoft Authenticator (Preview)**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-in-authenticator-three.png" alt-text="Screenshot of the drop-down list of options in Microsoft Authenticator for iOS devices.":::

1. Tap **Add**. 
   
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-add-sign-in-method-three.png" alt-text="Screenshot of the Security Info screen Add Sign-in Method option.":::

1. If you haven't recently done MFA, you maybe prompted to do MFA. Tap **Next** and complete MFA to sign in. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/sign-in-required-ios.png" alt-text="Screenshot that notifies user to sign in with a second factor before they add a passkey on their iOS device.":::
  

1. If necessary, download Microsoft Authenticator and tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-download-auth-app-three.png" alt-text="Screenshot of the download app option in Microsoft Authenticator for iOS devices.":::

1. Read the steps to turn on Authenticator as a passkey provider in the **Settings** of your iOS device, and click **Continue**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/auth-app-install-step-one-three.png" alt-text="Screenshot of the steps to turn on Authenticator as a passkey provider.":::

1. On your iOS 18 device, navigate to **Settings** > **General** > **Autofill & Passwords**. On your iOS 17 device, navigate to **Settings** > **Passwords** > **Password Options**. On both operating systems, make sure **AutoFill Passwords and and Passkeys** is turned on. Under **Autofill From**, make sure **Authenticator** is selected..

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options-three.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for iOS devices.":::

1. In Security info, read the instructions on saving the passkey then tap **I'm ready**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/get-ready.png" alt-text="Screenshot of step to prepare device.":::

1. The OS will prompt to save the passkey in a passkey provider and you must save the passkey in the Authenticator app. After the passkey is setup, tap **Next** in SecurityInfo.

1. Your passkey in Authenticator appears as a new sign-in method [Security info](https://mysignins.microsoft.com/security-info). 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/new-passkey-in-security-info.png" alt-text="Screenshot of a new passkey for Authenticator for iOS in the Security info page.":::


### Cross-device registration (iOS)
You can also save a passkey in Authenticator from your computer or another mobile device. 
This registration option is convenient if you want to sign in with a passkey on another device and save it in Authenticator on your iOS device. 
This registration option requires Bluetooth and an internet connection for both devices. 

If your organization restricts Bluetooth usage, you can allow cross-device registration of passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. Using another device, such as a laptop, open a web browser and sign in to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop-eighty.png" alt-text="Screenshot of how to enter a temporary access pass on a laptop at 80%.":::

1. When prompted to stay signed in, select **Yes**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/stay-signed-in.png" alt-text="Screenshot of option to Stay signed in.":::

1. Tap **+ Add sign-in method** > choose **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. When you're asked to sign in with MFA, click **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/sign-in-required-laptop.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. If necessary, download Microsoft Authenticator to your iOS device. You can click [Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app) and scan a QR code to install Authenticator from the iOS App Store. After you download Authenticator, tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. Open Authenticator, review Microsoft Privacy information, and tap **Accept**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/privacy-statement.png" alt-text="Screenshot that explains Microsoft Privact statement in Authenticator.":::

1. Choose whether to share app usage data, and tap **Continue**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/share-app-usage-data.png" alt-text="Screenshot that allows users to share app data usage.":::

1. Add your account in Authenticator on your iOS device. If you just downloaded Authenticator, you can tap **Add work or school account** near the bottom of you're iOS device. If already use Authenticator, tap **+** in the upper right corner. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-authenticator.png" alt-text="Screenshot of wizard to complete the passkey setup in Authenticator.":::

1. Complete MFA on your iOS device, and tap **Sign in**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-sign-in-three.png" alt-text="Screenshot of how to complete MFA.":::

1. When prompted to set up phone sign-in, tap **Continue**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/set-up-phone-sign-in-three.png" alt-text="Screenshot of how to continue to set up phon sign-in.":::

1. When prompted to register your device, tap **Register**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/register.png" alt-text="Screenshot of how to register your iOS device.":::

1. After you see the account is added, tap **Continue**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/account-added-three.png" alt-text="Screenshot of account added to your iOS device.":::

1. On you iOS device, you can see passkey added for your new account in Authenticator.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/new-passkey-in-authenticator.png" alt-text="Screenshot of new account added to Authenticator on your iOS device.":::

1. Return to your other device after you complete the passkey setup in Authenticator, and click **Next**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-authenticator.png" alt-text="Screenshot of wizard to complete the passkey setup in Authenticator.":::

1. The wizard verifies the passkey in Authenticator. This step requires intenet connectivity and Bluetooth on both devices.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/verifying-passkey.png" alt-text="Screenshot of wizard verifying passkey in Authenticator.":::

1. After the passkey is created, click **Done**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-created.png" alt-text="Screenshot that confirms passkey is created.":::

1. In Security info, you can see the new passkey added.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-security-info-laptop.png" alt-text="Screenshot of a new passkey sign-in method in Security info on your other device.":::


## Delete your passkey in Authenticator for iOS

To remove the passkey from Authenticator, tap the account name, tap **Settings**, and then tap **Remove account**. Choose whether to remove the account only from Authenticator or from all apps on your device.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/remove-all-apps.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for iOS devices.":::

> [!NOTE]
> You also need to delete the passkey from [Security info](https://mysignins.microsoft.com/security-info). 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-ios) that was created locally in Authenticator, and retry registration.



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

You can also save a passkey in Authenticator from your computer or another mobile device. 
This registration option is convenient if you want to sign in with a passkey on another device and save it in Authenticator on your Android device. 
This registration option requires Bluetooth and an internet connection for both devices. 

If your organization restricts Bluetooth usage, you can allow cross-device registration of passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. Using another device, such as a laptop, open a web browser and sign in to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop-eighty.png" alt-text="Screenshot of how to enter a temporary access pass on a laptop at 80%.":::

1. When prompted to stay signed in, select **Yes**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/stay-signed-in.png" alt-text="Screenshot of option to Stay signed in.":::

1. Tap **+ Add sign-in method** > choose **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. When you're asked to sign in with MFA, click **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/sign-in-required-laptop.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. If necessary, download Microsoft Authenticator to your Android device. You can click [Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app) and scan a QR code to install Authenticator from Google Play. After you download Authenticator, tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. When prompted to allow notifications from Authenticator, tap **Allow**.   

1. Open Authenticator, review Microsoft Privacy information, and tap **Accept**.

1. Choose whether to share app usage data, and tap **Continue**.

1. Add your account in Authenticator on your iOS device. If you just downloaded Authenticator, you can tap **Add work or school account** near the bottom of you're iOS device. If already use Authenticator, tap **+** in the upper right corner. 

1. Tap **Sign in**.

1. Enter your user name and tap **Sign in**.

1. Enter your password or Temporary Access Pass (TAP).

1. When prompted to sign in with your phone, tap **Continue**.

1. Tap **Register**.

1. If prompted, unlock you phone to continue registration. 

1. When prompted to allow Authenticator to use passkeys, click **Settings**.

1. In Passwords, passkeys, and authentications, turn on **Authenticator**. When prompted to trust the app, click **OK**.

1. Return to the screen to allow Authenticator to use passkeys, and click **Done**.

1. Authenticator creates the passkey. If prompted, unlock the device. Authenticator shows the account is added. Tap **Continue**.

1. Review the message that App Lock is enabled and click **OK**.

1. On you Android device, you can see passkey added for your new account in Authenticator.

1. Return to your other device after you complete the passkey setup in Authenticator, and click **Next**. 

1. After the passkey is created, click **Done**.

1. In Security info, you can see the new passkey added.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-security-info-laptop.png" alt-text="Screenshot of a new passkey on Android sign-in method in Security info on your other device.":::

## Delete your passkey in Authenticator for Android

To remove the passkey from Authenticator, tap the account name, tap **Settings**, and then tap **Remove account**. 

> [!NOTE]
> You also need to delete the passkey from [Security info](https://mysignins.microsoft.com/security-info). 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-android) that was created locally in Authenticator, and retry registration.



---

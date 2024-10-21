---
title: Register passkeys in Authenticator on Android and iOS devices
description: Registration and management of passkey with Authenticator on Android and iOS devices.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/21/2024

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

### Registration by signing in to Authenticator (iOS)

You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on (SSO) across Microsoft native apps. This is the recommended and preferred flow to set up a passkey in Authenticator. If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Download Authenticator from the App Store, open it, and go through the privacy screens.
1. Add your account in Authenticator on your iOS device. Tap **Add account** or the **+** button.

   > [!NOTE]
   > If you already have an account in the Authenticator, tap your account in the app, and then tap the settings gear near the upper right of the account details page. Tap **Create a passkey (Preview)**, and skip directly to the sign-in step of the flow.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/add-account-ios.png" alt-text="Screenshot 233x433 of how to register using Microsoft Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).

1. Select **Work or school account**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/work-school-account-ios.png" alt-text="Screenshot 233x409 of choosing Work or School Account using Microsoft Authenticator for iOS devices.":::
 
1. Tap **Sign in**.
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/tap-sign-in-ios.png" alt-text="Screenshot 234x417 of tapping the Sign in option using Microsoft Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot 246x445 of how to complete MFA by using Microsoft Authenticator for iOS devices.":::

1. When prompted to allow Authenticator to use Touch ID/Face ID, tap **Allow**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/allow-face.png" alt-text="Screenshot of how to allow Face ID for Microsoft Authenticator for iOS devices.":::

1. When prompted to allow Authenticator to send you notifications, tap **Allow**. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/allow-notifications.png" alt-text="Screenshot of how to allow notifications for Microsoft Authenticator for iOS devices.":::

1. Select **Open Settings** to enable Authenticator as a passkey provider.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-provider-ios.png" alt-text="Screenshot of Open Settings and follow the on-screen instructions using Microsoft Authenticator for iOS devices.":::

1. Enable the Authenticator as a passkey provider. 

   - On iOS 18, navigate to **Settings** > **General** > **Autofill & Passwords**. 
   - On iOS 17, navigate to **Settings** > **Passwords** > **Password Options**. 

   On both operating systems, make sure **AutoFill Passwords and Passkeys** is turned on. 
   Under **Autofill From**, make sure **Authenticator** is selected.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options-three.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for iOS devices.":::

1. Navigate back to the Authenticator app and continue. Authenticator sets up passkey, passwordless, and MFA for sign in according to your work or school account policies. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-added-ios.png" alt-text="Screenshot of setting up passkey, passwordless, and/or MFA for sign in using Microsoft Authenticator for iOS devices.":::

1. After you see passkey added as a sign-in method for your account, tap **Continue** and you can now see the new account you added.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/new-authenticator-account.png" alt-text="Screenshot of a new account in Authenticator for iOS devices.":::


### Passkey registration from Security Info (iOS)

Security info by default will prompt users to sign in to the Authenticator app to register their passkey. 

1. On the same iOS device as the Authenticator or using another device, such as a laptop, open a web browser and sign in with MFA to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop-eighty.png" alt-text="Screenshot of how to enter a temporary access pass on a laptop at 80%.":::

1. In Security info, Tap **+ Add sign-in method** > choose **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. If you're asked to sign in with MFA, click **Next**.   

1. If necessary, download Microsoft Authenticator to your iOS device. You can click [Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app) and scan a QR code to install Authenticator from the iOS App Store. After you download Authenticator, tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. Open Authenticator, review Microsoft Privacy information, and tap **Accept**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/privacy-statement.png" alt-text="Screenshot that explains Microsoft Privact statement in Authenticator.":::

1. Choose whether to share app usage data, and tap **Continue**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/share-app-usage-data.png" alt-text="Screenshot that allows users to share app data usage.":::

1. Add your account in Authenticator on your iOS device. If you just downloaded Authenticator, you can tap **Add work or school account** near the bottom of your iOS device. If already using Authenticator, tap **+** in the upper right corner of the app. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-authenticator.png" alt-text="Screenshot of wizard to complete the passkey setup in Authenticator.":::

1. The rest of the flow is similar to the flow shared above to sign in to the Authenticator and complete passkey registration. Complete MFA on your iOS device, and tap **Sign in**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-sign-in-three.png" alt-text="Screenshot of how to complete MFA.":::

1. Go through the steps to enable Touch ID/Face ID and select **Open Settings** to enable Authenticator as a passkey provider.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-provider-ios.png" alt-text="Screenshot of Open Settings and follow the on-screen instructions using Microsoft Authenticator for iOS devices.":::

1. On your iOS 18 device, navigate to **Settings** > **General** > **Autofill & Passwords**. On your iOS 17 device, navigate to **Settings** > **Passwords** > **Password Options**. 

   On both operating systems, make sure **AutoFill Passwords and and Passkeys** is turned on. Under **Autofill From**, make sure **Authenticator** is selected.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options-three.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for iOS devices.":::

1. After you see the account is added, tap **Continue**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/account-added-three.png" alt-text="Screenshot of account added to your iOS device.":::

1. On you iOS device, you can see passkey added for your new account in Authenticator.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/new-passkey-in-authenticator.png" alt-text="Screenshot of new account added to Authenticator on your iOS device.":::

1. Return to your browser after you complete the passkey setup in Authenticator, and click **Next**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-authenticator.png" alt-text="Screenshot of wizard to complete the passkey setup in Authenticator.":::

1. The wizard verifies the passkey in Authenticator. This step requires intenet connectivity and Bluetooth on both devices.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/verifying-passkey.png" alt-text="Screenshot of wizard verifying passkey in Authenticator.":::

1. After the passkey is created, click **Done**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-created.png" alt-text="Screenshot that confirms passkey is created.":::

1. In Security info, you can see the new passkey added.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-security-info-laptop.png" alt-text="Screenshot of a new passkey sign-in method in Security info on your other device.":::


### Alternate registration flow from Security Info (iOS)
If a user is unable to sign in to the Authenticator to register a passkey, you can fall back to triggering registration directly from Security Info. If initiating this flow from a browser on a different device, Bluetooth and an internet connection will be required for both devices. Additionally, this flow only works when attestation is disabled in the passkey (FIDO2) authentication methods policy. 

If your organization restricts Bluetooth usage, you can allow cross-device registration of passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. In Security Info, when adding a Passkey in Microsoft Authenticator, tap on **Having trouble**.
2. Now, tap on **create your passkey a different way** and go through the rest of the flow. 


## Delete your passkey in Authenticator for iOS

To remove the passkey from Authenticator, tap the account name, tap **Settings**, and then tap **Remove account**. Choose whether to remove the account only from Authenticator or from all apps on your device.

:::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/remove-all-apps.png" alt-text="Screenshot of the passkey delete option in Microsoft Authenticator for iOS devices.":::

> [!NOTE]
> You also need to delete the passkey from [Security info](https://mysignins.microsoft.com/security-info). 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-ios) that was created locally in Authenticator, and retry registration.



## [**Android**](#tab/Android)

### Registration by signing in to Authenticator (Android)

You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on (SSO) across Microsoft native apps. **This is the recommended and preferred flow to set up a passkey in Authenticator.** If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Download Authenticator from Google Play, open it, and go through the privacy screens.
1. Add your account in Authenticator on your Android device. Tap **Add account** or the **+** button.
   > [!NOTE]
   > If you already have an account in the Authenticator, tap your account in the app, and then tap the settings gear near the upper right of the account details page. Tap **Create a passkey (Preview)**, and skip directly to the sign-in step of the flow.


   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/add-account-android.png" alt-text="Screenshot of how to register using Microsoft Authenticator for Android devices.":::

1. Select **Work or school account**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/work-school-account-android.png" alt-text="Screenshot of choosing Work or School Account using Microsoft Authenticator for Android devices.":::

1. Tap **Sign in**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/tap-sign-in-android.png" alt-text="Screenshot of tapping the Sign in option using Microsoft Authenticator for Android devices.":::

1. You need to complete multifactor authentication (MFA).
 
1. Tap **Settings** to enable Authenticator as a passkey provider.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/tap-settings-android.png" alt-text="Screenshot of Open Settings and follow the on-screen instructions using Microsoft Authenticator for Android devices."::: 
 
1. Open **Passwords and accounts**.
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/password-options-android.png" alt-text="Screenshot of select Passwords and Password Options using Microsoft Authenticator for Android devices.":::

1. In the **Additional providers** section, make sure **Authenticator** is selected. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/enable-authenticator-android.png" alt-text="Screenshot of enabling Authenticator as a provider using Microsoft Authenticator for Android devices.":::

1. Return to **Authenticator app** and select **Done**.
 
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/settings-done-android.png" alt-text="Screenshot of how to tap Done to complete using Microsoft Authenticator for Android devices.":::

1. After you see passkey added as a sign-in method for your account, tap **Continue**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/passkey-added-android.png" alt-text="Screenshot of an account added to Microsoft Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign in according to your work or school account policies. Tap your account to see details, including your new passkey. 

## Passkey registration from Security Info (Android)

Security info by default will prompt users to sign in to the Authenticator app to register their passkey.

>[!NOTE]
>Support for same-device registration in Edge on Android is coming soon.

1. On the same Android device as the Authenticator or using another device, such as a laptop, open a web browser and sign in with MFA to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop-eighty.png" alt-text="Screenshot of how to enter a temporary access pass on a laptop at 80%.":::

1. In Security info, tap **+ Add sign-in method** > choose **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. If prompted, tap **Next**, and sign in with MFA.   

1. If necessary, download Microsoft Authenticator to your Android device. You can click [Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app) and scan a QR code to install Authenticator from Google Play. After you download Authenticator to your Android device, click **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. Open Authenticator, go through the privacy scrteens as needed, and tap **Add account**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/add-account-android.png" alt-text="Screenshot of how to add your first account to Authenticator on Android.":::

1. Tap **Work or school account**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/work-or-school-account-android.png" alt-text="Screenshot of how to add work or school account to Authenticator on Android.":::

1. Tap **Sign in**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/sign-in-authenticator-android.png" alt-text="Screenshot of how to sign in to Authenticator on Android.":::

1. Enter your user name and tap **Sign in**.

1. Enter your password, Temporary Access Pass (TAP), or other sign-in method.

1. Set up a device lock if prompted. When prompted to allow Authenticator to use passkeys, click **Settings**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/tap-settings-android.png" alt-text="Screenshot of how to go to settings on Android.":::

1. In **Passwords, passkeys, and authenticators**, turn on **Authenticator**. When prompted to trust the app, click **OK**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/trust-app-android.png" alt-text="Screenshot of how to trust Authenticator app on Android.":::

    >[!NOTE]
   >Enabling passkey providers on Android may vary based on the make and model of your device. Search for passkey on your device settings or consult your device manufacturer for guidance.

1. Return to the screen to allow Authenticator to use passkeys, and click **Done**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/settings-done-android.png" alt-text="Screenshot of how to return to Authenticator passkey registration on Android.":::

1. After Authenticator creates the passkey, tap **Continue**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/account-added-android.png" alt-text="Screenshot that confirms the passkey is created in Authenticator on Android.":::

1. On you Android device, you can see passkey added for your new account in Authenticator.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/account-in-android.png" alt-text="Screenshot that shows the passkey in Authenticator on Android.":::

1. After you complete the passkey setup in Authenticator, return to your browser where Security info is open and click **Next**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-authenticator.png" alt-text="Screenshot of wizard to complete the passkey setup in Authenticator.":::

1. After the passkey is created, click **Done**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-created.png" alt-text="Screenshot that confirms passkey is created.":::

1. In Security info, you can see the new passkey added.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-security-info-laptop.png" alt-text="Screenshot of a new passkey on Android sign-in method in Security info on your other device.":::

## Alternate registration flow on Security Info (Android)

If a user is unable to sign in to the Authenticator to register a passkey, you can fall back to triggering registration directly from Security Info. If initiating this flow from a browser on a different device, Bluetooth and an internet connection will be required for both devices. Additionally, this flow only works when attestation is disabled in the passkey (FIDO2) authentication methods policy.  

If your organization restricts Bluetooth usage, you can allow cross-device registration of passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. In Security Info, when adding a Passkey in Microsoft Authenticator, tap on **Having trouble**.
2. Now, tap on **create your passkey a different way** and go through the rest of the flow. 

## Delete your passkey in Authenticator for Android

To remove the passkey from Authenticator, tap the account name, tap **Settings**, and then tap **Remove account**. 

> [!NOTE]
> You also need to delete the passkey from [Security info](https://mysignins.microsoft.com/security-info). 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-android) that was created locally in Authenticator, and retry registration.



---

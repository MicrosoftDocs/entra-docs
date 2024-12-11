---
title: Register passkeys in Authenticator on Android and iOS devices
description: Registration and management of passkey with Authenticator on Android and iOS devices.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 11/29/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users can register a passkey in Microsoft Authenticator 

---
# Register passkeys in Authenticator on Android or iOS devices 

This article shows how to register a passkey using Microsoft Authenticator on your iOS or Android device by directly signing into the Authenticator app or by using [Security info](https://aka.ms/mysecurityinfo). For more information about the availability of Microsoft Entra ID passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md).

**The *easiest and fastest way* to add a passkey is to add it directly in the Authenticator app.**

Alternatively, you can add a passkey from your mobile device browser, or through cross-device registration using another device, such as a laptop. Your mobile device needs to run iOS version 17, or Android version 14, or later. 

>[!NOTE]
>Support for registering passkeys in Authenticator when attestation is enforced is currently rolling out to iOS Authenticator app users. Support for registering attested passkeys in Authenticator on Android devices is available to all users in the latest version of the app.

| Scenario | iOS | Android |
|------------------|---------------------------------|----------------|
| **Same-device registration by signing into Authenticator**              | &#x2705;          | &#x2705;       |
| **Same-device registration in a browser**            | &#x2705; | &#x2705;<sup>1</sup>     |
| **Cross-device registration**  | &#x2705;  | &#x2705;    |

<sup>1</sup>Support for same-device registration in Edge on Android is coming soon.

## [**iOS**](#tab/iOS) 

### Registration by signing in to Authenticator (iOS) 


You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on (SSO) across Microsoft native apps. **This is the recommended and preferred flow to set up a passkey in Authenticator.** If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Download Authenticator from the App Store, and go through the privacy screens.

   1. If you installed Authenticator for the first time on your device, on the **Secure Your Digital Life** screen, tap **Add work or school account**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/ios-first-run.png" alt-text="Screenshot of the first screen to appear for Microsoft Authenticator for iOS devices.":::

   1. If you installed Authenticator on your device before but haven't added an account, tap **Add account** or the **+** button, and select **Work or school account**. Then tap **Sign in**. 

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/add-account-ios.png" alt-text="Screenshot of how to register using Microsoft Authenticator for iOS devices.":::

   1. If you already added an account in Authenticator, tap your account, and then tap **Create a passkey**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/ios-create-passkey.png" alt-text="Screenshot of how to create a passkey in Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot of how to complete MFA by using Microsoft Authenticator for iOS devices.":::

1. If necessary, tap **Settings** and set up a screen lock.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-lock-screen-required.png" alt-text="Screenshot of step to set up lock screen for passkey in Microsoft Authenticator for Android devices."::: 
 
1. Tap **Settings** to enable Authenticator as a passkey provider.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-provider-ios.png" alt-text="Screenshot of Open Settings and follow the on-screen instructions using Microsoft Authenticator for iOS devices.":::

1. On your iOS 18 device, navigate to **Settings** > **General** > **Autofill & Passwords**. On your iOS 17 device, navigate to **Settings** > **Passwords** > **Password Options**. 

   On both operating systems, make sure **AutoFill Passwords and and Passkeys** is turned on. Under **Autofill From**, make sure **Authenticator** is selected.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options-three.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for iOS devices.":::

1. After you return to Authenticator, tap **Done** to confirm you added Authenticator as a passkey provider. Then you can see passkey added as a sign-in method for your account. Tap **Done** again to finish.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-account-added.png" alt-text="Screenshot of an account added to Microsoft Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign-in according to your work or school account policies. Tap your account to see details, including your new passkey. 

### Passkey registration from Security info (iOS)

Security info by default will prompt users to sign in to the Authenticator app to register their passkey. 

1. On the same iOS device as the Authenticator or using another device, such as a laptop, open a web browser and sign in with MFA to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop.png" alt-text="Screenshot of how to enter a temporary access pass on a laptop at 80%.":::

1. In Security info, Tap **+ Add sign-in method** > choose **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. If you're asked to sign in with MFA, click **Next**.   

1. If necessary, download Microsoft Authenticator to your iOS device. You can click [Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app) and scan a QR code to install Authenticator from the iOS App Store. After you download Authenticator, tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. You're prompted to open the Authenticator app and create your passkey there. Open Authenticator and go through the privacy screens as needed.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-in-authenticator.png" alt-text="Screenshot of wizard to complete the passkey setup in Authenticator.":::
   
1. Add your account in Authenticator on your iOS device.

   1. If you installed Authenticator for the first time on your device, on the **Secure Your Digital Life** screen, tap **Add work or school account**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/ios-first-run.png" alt-text="Screenshot of the first screen to appear for Microsoft Authenticator for iOS devices.":::

   1. If you installed Authenticator on your device before but haven't added an account, tap **Add account** or the **+** button, and select **Work or school account**. Then tap **Sign in**. 

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/add-account-ios.png" alt-text="Screenshot of how to register using Microsoft Authenticator for iOS devices.":::

   1. If you already added an account in Authenticator, tap your account, and then tap **Create a passkey**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/ios-create-passkey.png" alt-text="Screenshot of how to create a passkey in Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot of how to complete MFA by using Microsoft Authenticator for iOS devices.":::

1. If necessary, tap **Settings** and set up a screen lock.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-lock-screen-required.png" alt-text="Screenshot of step to set up lock screen for passkey in Microsoft Authenticator for Android devices."::: 
 
1. Tap **Settings** to enable Authenticator as a passkey provider.

1. On your iOS 18 device, navigate to **Settings** > **General** > **Autofill & Passwords**. On your iOS 17 device, navigate to **Settings** > **Passwords** > **Password Options**. 

   On both operating systems, make sure **AutoFill Passwords and and Passkeys** is turned on. Under **Autofill From**, make sure **Authenticator** is selected.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options-three.png" alt-text="Screenshot of the turn-on passkey support option in Microsoft Authenticator for iOS devices.":::

1. After you return to Authenticator, tap **Done** to confirm you added Authenticator as a passkey provider. Then you can see passkey added as a sign-in method for your account. Tap **Done** again to finish.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-account-added.png" alt-text="Screenshot of an account added to Microsoft Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign-in according to your work or school account policies.  

1. Return to your browser after you complete the passkey setup in Authenticator, and click **Next**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/after-setup-in-authenticator.png" alt-text="Screenshot of return to wizard to complete the passkey setup in Authenticator.":::

1. The wizard verifies the passkey was created in Authenticator.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/verifying-passkey.png" alt-text="Screenshot of wizard verifying passkey in Authenticator.":::

1. After the passkey is created, click **Done**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-created.png" alt-text="Screenshot that confirms passkey is created.":::

1. In Security info, you can see the new passkey added.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-security-info-laptop.png" alt-text="Screenshot of a new passkey sign-in method in Security info on your other device.":::


### Alternate registration flow from Security Info if you have trouble (iOS)

If you can't sign in to the Authenticator to register a passkey, you can register directly from Security info with WebAuthn. If you sign in to Security info on a different device, you need Bluetooth, an internet connection, and connectivity to these two endpoints must be allowed in your organization:

- `https://cable.ua5v.com`
- `https://cable.auth.com`

If your organization restricts Bluetooth usage, you can permit Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators to allow cross-device registration of passkeys. For more information, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. In Security info, when adding a Passkey in Microsoft Authenticator, tap on **Having trouble**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/having-trouble-complete.png" alt-text="Screenshot of how to register another way if you have trouble.":::

2. Now, tap on **create your passkey a different way**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/having-trouble.png" alt-text="Screenshot of how to register a passkey another way.":::

3. Choose **iPhone or iPad** and go through the rest of the flow to register a passkey on the device.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/choose-ios-device.png" alt-text="Screenshot of how to choose another way on iOS if you have trouble.":::


If a user wants to revert to the original instructions and register a passkey in Microsoft Authenticator through sign-in: 

1. In Security Info, when adding a Passkey in Microsoft Authenticator, tap on **Having trouble**.
2. Now, tap on **Create your passkey a different way** by signing into the Authenticator.
3. Go through the rest of the flow to register a passkey on your device. 

 >[!NOTE]
   >If you register your passkey with Chrome browser on MacOS, allow `login.microsoft.com` to access your security key or device when prompted.

## Delete your passkey in Authenticator for iOS

To remove the passkey from Authenticator, tap the account name, tap **Settings**, and then tap **Delete passkey**. You will also need to delete your passkey from [Security info](https://mysignins.microsoft.com/security-info). 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-ios) that was created locally in Authenticator, and retry registration.



## [**Android**](#tab/Android)

### Registration by signing in to Authenticator (Android) 

You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on (SSO) across Microsoft native apps. **This is the recommended and preferred flow to set up a passkey in Authenticator.** If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Download Authenticator from Google Play, open it, and go through the privacy screens.
1. Add your account in Authenticator on your Android device. 
   
   1. If you installed Authenticator for the first time on your device, on the **Secure Your Digital Life** screen, tap **Add work or school account**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-first-run.png" alt-text="Screenshot of the first screen to appear for Microsoft Authenticator for Android devices.":::   

   1. If you installed Authenticator on your device before but haven't added an account, tap **Add account** or the **+** button, and select **Work or school account**. Then tap **Sign in**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/add-account-android.png" alt-text="Screenshot of how to register using Microsoft Authenticator for Android devices.":::

   1. If you already added an account in Authenticator, tap your account, and then tap **Create a passkey**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-create-passkey.png" alt-text="Screenshot of how to create a passkey in Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot of how to complete MFA by using Microsoft Authenticator for iOS devices.":::

1. If necessary, tap **Settings** and set up a screen lock.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-lock-screen-required.png" alt-text="Screenshot of step to set up lock screen for passkey in Microsoft Authenticator for Android devices."::: 
 
1. Tap **Settings** to enable Authenticator as a passkey provider.

   >[!NOTE]
   >The steps to enable passkey providers on Android may vary based on the make and model of your device. Search for passkey on your device settings or consult your device manufacturer for guidance. If your device runs Android 14 and you can't enable Microsoft Authenticator as a passkey provider, we recommend you upgrade to Android 15. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-allow-authenticator.png" alt-text="Screenshot of Open Settings and follow the on-screen instructions using Microsoft Authenticator for Android devices."::: 
 
   1. Open **Passwords and accounts**.
 
      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/password-options-android.png" alt-text="Screenshot of select Passwords and Password Options using Microsoft Authenticator for Android devices.":::

   1. In the **Additional providers** section, make sure **Authenticator** is selected. 

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/enable-authenticator-android.png" alt-text="Screenshot of enabling Authenticator as a provider using Microsoft Authenticator for Android devices.":::

1. After you return to Authenticator, tap **Done** to confirm you added Authenticator as a passkey provider. Then you can see passkey added as a sign-in method for your account. Tap **Done** again to finish.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-account-added.png" alt-text="Screenshot of an account added to Microsoft Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign-in according to your work or school account policies. Tap your account to see details, including your new passkey. 

## Passkey registration from Security Info (Android)

Security info by default will prompt users to sign in to the Authenticator app to register their passkey.


1. On the same Android device as the Authenticator or using another device, such as a laptop, open a web browser and sign in with MFA to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop.png" alt-text="Screenshot of how to enter a temporary access pass on a laptop at 80%.":::

1. In Security info, tap **+ Add sign-in method** > choose **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot of how to select passkey in Microsoft Authenticator as a sign-in method.":::

1. If prompted, tap **Next**, and sign in with MFA.   

1. If necessary, download Microsoft Authenticator to your Android device. You can click [Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app) and scan a QR code to install Authenticator from Google Play. After you download Authenticator to your Android device, click **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. You're prompted to open the Authenticator app and create your passkey there. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-in-authenticator.png" alt-text="Screenshot of wizard to complete the passkey setup in Authenticator.":::

1. Open Authenticator and go through the privacy screens as needed.

   1. If you installed Authenticator for the first time on your device, on the **Secure Your Digital Life** screen, tap **Add work or school account**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-first-run.png" alt-text="Screenshot of the first screen to appear for Microsoft Authenticator for Android devices.":::

   1. If you installed Authenticator on your device before but haven't added an account, tap **Add account** or the **+** button, and select **Work or school account**. Then tap **Sign in**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/add-account-android.png" alt-text="Screenshot of how to register using Microsoft Authenticator for Android devices.":::

   1. If you already added an account in Authenticator, tap your account, and then tap **Create a passkey**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-create-passkey.png" alt-text="Screenshot of how to create a passkey in Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot of how to complete MFA by using Microsoft Authenticator for iOS devices.":::

1. If necessary, tap **Settings** and set up a screen lock.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-lock-screen-required.png" alt-text="Screenshot of step to set up lock screen for passkey in Microsoft Authenticator for Android devices."::: 
 
1. Tap **Settings** to enable Authenticator as a passkey provider.

   >[!NOTE]
   >The steps to enable passkey providers on Android may vary based on the make and model of your device. Search for passkey on your device settings or consult your device manufacturer for guidance. If your device runs Android 14 and you can't enable Microsoft Authenticator as a passkey provider, we recommend you upgrade to Android 15. 

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-allow-authenticator.png" alt-text="Screenshot of Open Settings and follow the on-screen instructions using Microsoft Authenticator for Android devices."::: 
 
   1. Open **Passwords and accounts**.
 
      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/password-options-android.png" alt-text="Screenshot of select Passwords and Password Options using Microsoft Authenticator for Android devices.":::

   1. In the **Additional providers** section, make sure **Authenticator** is selected. 

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/enable-authenticator-android.png" alt-text="Screenshot of enabling Authenticator as a provider using Microsoft Authenticator for Android devices.":::

1. After you return to Authenticator, tap **Done** to confirm you added Authenticator as a passkey provider. Then you can see passkey added as a sign-in method for your account. Tap **Done** again to finish.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-account-added.png" alt-text="Screenshot of an account added to Microsoft Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign-in according to your work or school account policies.  

1. After you complete the passkey setup in Authenticator, return to your browser where Security info is open and click **Next**. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-authenticator.png" alt-text="Screenshot of wizard to complete the passkey setup in Authenticator on Android.":::

1. The wizard verifies the passkey was created in Authenticator.

1. After the passkey is created, click **Done**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-created.png" alt-text="Screenshot that confirms passkey is created on Android.":::

1. In Security info, you can see the new passkey added.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-security-info-laptop.png" alt-text="Screenshot of a new passkey on Android sign-in method in Security info on your other device.":::

## Alternate registration flow on Security info if you have trouble (Android) 

If you can't sign in to the Authenticator to register a passkey, you can register directly from Security info with WebAuthn. If you sign in to Security info on a different device, you need Bluetooth, an internet connection, and connectivity to these two endpoints must be allowed in your organization:

- `https://cable.ua5v.com`
- `https://cable.auth.com`

If your organization restricts Bluetooth usage, you can permit Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators to allow cross-device registration of passkeys. For more information, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. In Security info, when adding a Passkey in Microsoft Authenticator, tap on **Having trouble**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/having-trouble-complete.png" alt-text="Screenshot of how to register another way if you have trouble.":::

2. Now, tap on **create your passkey a different way**.


   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/having-trouble.png" alt-text="Screenshot of how to register a passkey another way.":::

3. Choose **Android** and go through the rest of the flow to register a passkey on your device.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/choose-android-device.png" alt-text="Screenshot of how to choose another way on Android if you have trouble.":::

If a user wants to revert to the original instructions and register a passkey in Microsoft Authenticator through sign-in: 

1. In Security info, when adding a Passkey in Microsoft Authenticator, tap on **Having trouble**.
2. Now, tap on **create your passkey a different way** by signing into the Authenticator.
3. Go through the rest of the flow to register a passkey on your device.

 >[!NOTE]
   >If you register your passkey with Chrome browser on MacOS, allow `login.microsoft.com` to access your security key or device when prompted.

## Delete your passkey in Authenticator for Android

To remove the passkey from Authenticator, tap the account name, tap **Settings**, and then tap **Delete passkey**. 

> [!NOTE]
> In most cases, the passkey is also deleted from [Security info](https://mysignins.microsoft.com/security-info). If not, navigate to Security info and click **Delete** to remove it. 

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but not registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-android) that was created locally in Authenticator, and retry registration.



---

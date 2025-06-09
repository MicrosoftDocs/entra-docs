---
title: Register passkeys in Authenticator on Android and iOS devices
description: Registration and management of passkeys with Microsoft Authenticator on Android and iOS devices.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025
ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: calui, tilarso
ms.collection: M365-identity-device-management
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to understand how users can register passkeys in Microsoft Authenticator.
---
# Register passkeys in Authenticator on Android or iOS devices

This article shows how to register a passkey by using Authenticator on your iOS or Android device by directly signing in to the Authenticator app or by using [Security info](https://aka.ms/mysecurityinfo). For more information about the availability of Microsoft Entra ID passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md).

*The easiest and fastest way to add a passkey is to add it directly in the Authenticator app.*

Alternatively, you can add a passkey from your mobile device browser or through cross-device registration by using another device, such as a laptop. Your mobile device needs to run iOS version 17 or Android version 14, or later. 

| Scenario | iOS | Android |
|------------------|---------------------------------|----------------|
| Same-device registration by signing into Authenticator              | &#x2705;          | &#x2705;       |
| Same-device registration in a browser            | &#x2705; | &#x2705;<sup>1</sup>     |
| Cross-device registration  | &#x2705;  | &#x2705;    |

<sup>1</sup>Support for same-device registration in Microsoft Edge on Android is coming soon.

## [**iOS**](#tab/iOS)

### Registration by signing in to Authenticator (iOS)

You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on across Microsoft native apps. **We recommend this preferred flow to set up a passkey in Authenticator.** If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Download Authenticator from the App Store, and go through the privacy screens.

   - If you installed Authenticator for the first time on your device, on the **Secure Your Digital Life** screen, tap **Add work or school account**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/ios-first-run.png" alt-text="Screenshot that shows the first screen to appear for Authenticator for iOS devices.":::

   - If you installed Authenticator on your device but you didn't add an account, tap **Add account** or the **+** button, and select **Work or school account**. Then tap **Sign in**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/add-account-ios.png" alt-text="Screenshot that shows how to register by using Authenticator for iOS devices.":::

   - If you already added an account in Authenticator, tap your account, and then tap **Create a passkey**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/ios-create-passkey.png" alt-text="Screenshot that shows how to create a passkey in Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot that shows how to complete MFA by using Authenticator for iOS devices.":::

1. If necessary, tap **Settings** and set up a screen lock.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-lock-screen-required.png" alt-text="Screenshot that shows how to set up a screen lock for a passkey in Authenticator for Android devices.":::

1. Tap **Settings** to enable Authenticator as a passkey provider.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/passkey-provider-ios.png" alt-text="Screenshot that shows opening Settings to follow the onscreen instructions by using Authenticator for iOS devices.":::

1. On your iOS 18 device, go to **Settings** > **General** > **Autofill & Passwords**. On your iOS 17 device, go to **Settings** > **Passwords** > **Password Options**.

   On both operating systems, make sure that **AutoFill Passwords and Passkeys** is turned on. Under **Autofill From**, make sure that **Authenticator** is selected.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options-three.png" alt-text="Screenshot that shows the turn-on passkey support option in Authenticator for iOS devices.":::

1. After you return to Authenticator, tap **Done** to confirm that you added Authenticator as a passkey provider. Then you can see **Passkey** added as a sign-in method for your account. Tap **Done** again to finish.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-account-added.png" alt-text="Screenshot that shows an account added to Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign-in according to your work or school account policies. Tap your account to see information, including your new passkey.

### Passkey registration from Security info (iOS)

By default, **Security info** prompts users to sign in to the Authenticator app to register their passkey.

1. On the same iOS device as the Authenticator or by using another device, such as a laptop, open a web browser and sign in with MFA to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop.png" alt-text="Screenshot that shows how to enter a temporary access pass on a laptop at 80%.":::

1. On **Security info**, tap **+ Add sign-in method** and select **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot that shows how to select passkey in Authenticator as a sign-in method.":::

1. If you're asked to sign in with MFA, select **Next**.

1. If necessary, download Authenticator to your iOS device. You can select [Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app) and scan a QR code to install Authenticator from the iOS App Store. After you download Authenticator, tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. You're prompted to open the Authenticator app and create your passkey there. Open Authenticator and go through the privacy screens as needed.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-in-authenticator.png" alt-text="Screenshot that shows the wizard used to complete the passkey setup in Authenticator.":::

1. Add your account in Authenticator on your iOS device.

   - If you installed Authenticator for the first time on your device, on the **Secure Your Digital Life** screen, tap **Add work or school account**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/ios-first-run.png" alt-text="Screenshot that shows the first screen to appear for Authenticator for iOS devices.":::

   - If you installed Authenticator on your device before but didn't add an account, tap **Add account** or the **+** button, and select **Work or school account**. Then tap **Sign in**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/add-account-ios.png" alt-text="Screenshot that shows how to register by using Authenticator for iOS devices.":::

   - If you already added an account in Authenticator, tap your account, and then tap **Create a passkey**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/ios-create-passkey.png" alt-text="Screenshot that shows how to create a passkey in Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot that shows how to complete MFA by using Authenticator for iOS devices.":::

1. If necessary, tap **Settings** and set up a screen lock.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-lock-screen-required.png" alt-text="Screenshot that shows how to set up a screen lock for a passkey in Authenticator for Android devices.":::

1. Tap **Settings** to enable Authenticator as a passkey provider.

1. On your iOS 18 device, go to **Settings** > **General** > **Autofill & Passwords**. On your iOS 17 device, go to **Settings** > **Passwords** > **Password Options**.

   On both operating systems, make sure that **AutoFill Passwords and Passkeys** is turned on. Under **Autofill From**, make sure that **Authenticator** is selected.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/password-options-three.png" alt-text="Screenshot that shows the turn-on passkey support option in Authenticator for iOS devices.":::

1. After you return to Authenticator, tap **Done** to confirm that you added Authenticator as a passkey provider. Then you can see **Passkey** added as a sign-in method for your account. Tap **Done** again to finish.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-account-added.png" alt-text="Screenshot that shows an account added to Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign-in according to your work or school account policies.  

1. Return to your browser after you finish the passkey setup in Authenticator, and select **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/after-setup-in-authenticator.png" alt-text="Screenshot that shows returning to the wizard to finish the passkey setup in Authenticator.":::

1. The wizard verifies that the passkey was created in Authenticator.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/verifying-passkey.png" alt-text="Screenshot that shows the wizard that verifies the passkey in Authenticator.":::

1. After the passkey is created, select **Done**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-created.png" alt-text="Screenshot that confirms that the passkey was created.":::

1. On **Security info**, you can see the new passkey that was added.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-security-info-laptop.png" alt-text="Screenshot that shows a new passkey sign-in method on Security info on your other device.":::

### Alternate registration flow from Security info if you have trouble (iOS)

If you can't sign in to Authenticator to register a passkey, you can register directly from **Security info** with WebAuthn. 

> [!NOTE]
> You can't register a passkey in Authenticator this way if attestation is enabled by you administrator. 

If you sign in to **Security info** on a different device, you need Bluetooth and an internet connection. Connectivity to the following two endpoints must be allowed in your organization:

- `https://cable.ua5v.com`
- `https://cable.auth.com`

If your organization restricts Bluetooth usage, you can permit Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators to allow cross-device registration of passkeys. For more information, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. On **Security info**, when you add a passkey in Authenticator, tap **Having trouble**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/having-trouble-complete.png" alt-text="Screenshot that shows how to register another way if you have trouble.":::

1. Now, tap **create your passkey a different way**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/having-trouble.png" alt-text="Screenshot that shows how to register a passkey another way.":::

1. Select **iPhone or iPad**, and go through the rest of the flow to register a passkey on the device.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/choose-ios-device.png" alt-text="Screenshot that shows how to choose another way on iOS if you have trouble.":::

If a user wants to revert to the original instructions and register a passkey in Authenticator through sign-in:

1. On **Security info**, when you add a passkey in Authenticator, tap **Having trouble**.
1. Now, tap **create your passkey a different way** by signing in to Authenticator.
1. Go through the rest of the flow to register a passkey on your device.

> [!NOTE]
> If you register your passkey with the Chrome browser on macOS, allow `login.microsoft.com` to access your security key or device when prompted.

## Delete your passkey in Authenticator for iOS

To remove the passkey from Authenticator, tap the account name, and then tap **Settings** > **Delete passkey**. You also need to delete your passkey from [Security info](https://mysignins.microsoft.com/security-info).

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but isn't registered on the authentication server. For example, the passkey provider might not be permitted or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-ios) that was created locally in Authenticator and retry registration.

## [**Android**](#tab/Android)

### Registration by signing in to Authenticator (Android)

You can sign in to Authenticator to create a passkey in the app and get seamless single sign-on across Microsoft native apps. **We recommend this preferred flow to set up a passkey in Authenticator.** If you're signed in or already have an account in Authenticator, you still need to complete these steps to add a passkey in Authenticator.

1. Download Authenticator from Google Play, open it, and go through the privacy screens.
1. Add your account in Authenticator on your Android device.

   - If you installed Authenticator for the first time on your device, on the **Secure Your Digital Life** screen, tap **Add work or school account**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-first-run.png" alt-text="Screenshot that shows the first screen to appear for Authenticator for Android devices.":::

   - If you installed Authenticator on your device before but didn't add an account, tap **Add account** or the **+** button, and select **Work or school account**. Then tap **Sign in**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/add-account-android.png" alt-text="Screenshot that shows how to register by using Authenticator for Android devices.":::

   - If you already added an account in Authenticator, tap your account, and then tap **Create a passkey**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-create-passkey.png" alt-text="Screenshot that shows how to create a passkey in Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).
 
   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot that shows how to complete MFA by using Authenticator for iOS devices.":::

1. If necessary, tap **Settings** and set up a screen lock.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-lock-screen-required.png" alt-text="Screenshot that shows how to set up a screen lock for a passkey in Authenticator for Android devices.":::

1. Tap **Settings** to enable Authenticator as a passkey provider.

   > [!NOTE]
   > The steps to enable passkey providers on Android might vary based on the make and model of your device. Search for **Passkey** on your device settings, or consult your device manufacturer for guidance. If your device runs Android 14 and you can't enable Authenticator as a passkey provider, we recommend that you upgrade to Android 15.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-allow-authenticator.png" alt-text="Screenshot that shows opening Settings and following the onscreen instructions by using Authenticator for Android devices.":::

   1. Open **Passwords & accounts**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/password-options-android.png" alt-text="Screenshot that shows selecting passwords and password options by using Authenticator for Android devices.":::

   1. In the **Additional providers** section, make sure that **Authenticator** is selected.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/enable-authenticator-android.png" alt-text="Screenshot that shows enabling Authenticator as a provider by using Authenticator for Android devices.":::

1. After you return to Authenticator, tap **Done** to confirm that you added Authenticator as a passkey provider. Then you can see **Passkey** added as a sign-in method for your account. Tap **Done** again to finish.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-account-added.png" alt-text="Screenshot that shows an account added to Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign-in according to your work or school account policies. Tap your account to see information, including your new passkey.

## Passkey registration from Security info (Android)

By default, **Security info** prompts users to sign in to the Authenticator app to register their passkey.

1. On the same Android device as Authenticator or by using another device, such as a laptop, open a web browser and sign in with MFA to [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/enter-temporary-access-pass-laptop.png" alt-text="Screenshot that shows how to enter a temporary access pass on a laptop at 80%.":::

1. On **Security info**, tap **+ Add sign-in method** and select **Passkey in Microsoft Authenticator**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/select-passkey-in-authenticator.png" alt-text="Screenshot that shows how to select a passkey in Authenticator as a sign-in method.":::

1. If prompted, tap **Next** and sign in with MFA.

1. If necessary, download Authenticator to your Android device. You can select [Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app) and scan a QR code to install Authenticator from Google Play. After you download Authenticator to your Android device, select **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/download-authenticator-laptop.png" alt-text="Screenshot that gives users an option to download Authenticator.":::

1. You're prompted to open the Authenticator app and create your passkey there.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-in-authenticator.png" alt-text="Screenshot that shows the wizard to complete the passkey setup in Authenticator.":::

1. Open Authenticator and go through the privacy screens, as needed.

   - If you installed Authenticator for the first time on your device, on the **Secure Your Digital Life** screen, tap **Add work or school account**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-first-run.png" alt-text="Screenshot that shows the first screen to appear for Authenticator for Android devices.":::

   - If you installed Authenticator on your device before but didn't add an account, tap **Add account** or the **+** button, and select **Work or school account**. Then tap **Sign in**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/add-account-android.png" alt-text="Screenshot that shows how to register by using Authenticator for Android devices.":::

   - If you already added an account in Authenticator, tap your account, and then tap **Create a passkey**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-create-passkey.png" alt-text="Screenshot that shows how to create a passkey in Authenticator for iOS devices.":::

1. You need to complete multifactor authentication (MFA).

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-ios/multifactor-auth-ios.png" alt-text="Screenshot that shows how to complete MFA by using Authenticator for iOS devices.":::

1. If necessary, tap **Settings** and set up a screen lock.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-lock-screen-required.png" alt-text="Screenshot that shows how to set up a lock screen for a passkey in Authenticator for Android devices.":::

1. Tap **Settings** to enable Authenticator as a passkey provider.

   > [!NOTE]
   > The steps to enable passkey providers on Android might vary based on the make and model of your device. Search for **Passkey** on your device settings, or consult your device manufacturer for guidance. If your device runs Android 14 and you can't enable Authenticator as a passkey provider, we recommend that you upgrade to Android 15.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-allow-authenticator.png" alt-text="Screenshot that shows opening Settings and following the onscreen instructions by using Authenticator for Android devices.":::

   1. Open **Passwords & accounts**.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/password-options-android.png" alt-text="Screenshot that shows selecting passwords and password options by using Authenticator for Android devices.":::

   1. In the **Additional providers** section, make sure that **Authenticator** is selected.

      :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/enable-authenticator-android.png" alt-text="Screenshot that shows enabling Authenticator as a provider by using Authenticator for Android devices.":::

1. After you return to Authenticator, tap **Done** to confirm that you added Authenticator as a passkey provider. Then you can see **Passkey** added as a sign-in method for your account. Tap **Done** again to finish.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/android-account-added.png" alt-text="Screenshot that shows an account added to Authenticator for Android devices.":::

1. Authenticator sets up passkey, passwordless, and MFA for sign-in according to your work or school account policies.

1. After you finish the passkey setup in Authenticator, return to your browser where **Security info** is open. Select **Next**.
   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/complete-setup-authenticator.png" alt-text="Screenshot that shows the wizard to complete the passkey setup in Authenticator on Android.":::

1. The wizard verifies that the passkey was created in Authenticator.

1. After the passkey is created, select **Done**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-created.png" alt-text="Screenshot that confirms the passkey was created on Android.":::

1. On **Security info**, you can see that the new passkey was added.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/passkey-android-security-info-laptop.png" alt-text="Screenshot that shows a new passkey on Android sign-in method in **Security info** on your other device.":::

## Alternate registration flow on Security info if you have trouble (Android)

If you can't sign in to the Authenticator to register a passkey, you can register directly from **Security info** with WebAuthn. 

> [!NOTE]
> You can't register a passkey in Authenticator this way if attestation is enabled by you administrator. 

If you sign in to **Security info** on a different device, you need Bluetooth and an internet connection. Connectivity to the following two endpoints must be allowed in your organization:

- `https://cable.ua5v.com`
- `https://cable.auth.com`

If your organization restricts Bluetooth usage, you can permit Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators to allow cross-device registration of passkeys. For more information, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. On **Security info**, when you add a passkey in Authenticator, tap **Having trouble**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/having-trouble-complete.png" alt-text="Screenshot that shows how to register another way if you have trouble.":::

1. Now, tap **create your passkey a different way**.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/having-trouble.png" alt-text="Screenshot that shows how to register a passkey another way.":::

1. Select **Android** and go through the rest of the flow to register a passkey on your device.

   :::image type="content" border="true" source="media/howto-register-passwordless-passkey-direct-android/choose-android-device.png" alt-text="Screenshot that shows how to choose another way on Android if you have trouble.":::

If a user wants to revert to the original instructions and register a passkey in Authenticator through sign-in:

1. On **Security info**, when you add a passkey in Authenticator, tap **Having trouble**.
1. Now, tap **create your passkey a different way** by signing in to Authenticator.
1. Go through the rest of the flow to register a passkey on your device.

> [!NOTE]
> If you register your passkey with the Chrome browser on macOS, allow `login.microsoft.com` to access your security key or device when prompted.

## Delete your passkey in Authenticator for Android

To remove the passkey from Authenticator, tap the account name, tap **Settings**, and then tap **Delete passkey**.

In most cases, the passkey is also deleted from [Security info](https://mysignins.microsoft.com/security-info). If not, go to **Security info** and select **Delete** to remove it.

### Troubleshooting

In some cases when you try to register a passkey, it gets stored locally in the Authenticator app but isn't registered on the authentication server. For example, the passkey provider might not be permitted, or the connection might time out. If you try to register a passkey and see an error that the passkey already exists, [delete the passkey](#delete-your-passkey-in-authenticator-for-android) that was created locally in Authenticator and retry registration.

---

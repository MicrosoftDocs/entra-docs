---
title: Sign in with passkeys in Authenticator for Android and iOS devices 
description: Learn how to sign in with passkeys for Android and iOS devices with Microsoft Authenticator.

services: active-directory
ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025

ms.author: justinha
author: justinha
manager: femila
ms.reviewer: mjsantani, calui

ms.collection: M365-identity-device-management
---

# Sign in with passkeys in Authenticator for Android and iOS devices

This article explains the sign-in experience when you use passkeys in Authenticator with Microsoft Entra ID. For more information about the availability of Microsoft Entra ID passkey (FIDO2) authentication across native applications, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md).

| Scenario | iOS | Android |
|------------------|---------------------------------|----------------|
| Same-device authentication in a browser              | &#x2705;          | &#x2705;<sup>1</sup>       |
| Same-device authentication in native Microsoft applications            | &#x2705; | &#x2705;    |
| Cross-device authentication  | &#x2705;  | &#x2705;    |

<sup>1</sup>Support for same-device registration in Microsoft Edge on Android is coming soon.

## [**iOS**](#tab/iOS)

To sign in with a passkey in Authenticator, your iOS device needs to run iOS 17 or later.

### Same-device authentication in a browser (iOS)

Follow these steps to sign in to Microsoft Entra ID with a passkey in Authenticator on your iOS device.

1. On your iOS device, open your browser and go to the resource you're trying to access, such as [Office](https://www.office.com).

1. Enter your username to sign in.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-user-name.png" alt-text="Screenshot that shows the sign-in with username in Authenticator for iOS devices.":::

   If you most recently used a passkey to sign in, you're prompted to sign in with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face, fingerprint, PIN or security key**.

   Alternatively, select **Sign-in options** to sign in without entering a username.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-microsoft.png" alt-text="Screenshot that shows sign-in options in Authenticator for iOS devices.":::

   If you selected **Sign-in options**, then select **Face, fingerprint, PIN or security key**. Otherwise, skip to the next step.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-options.png" alt-text="Screenshot that shows the options for sign-in in Authenticator for iOS devices.":::

   > [!NOTE]
   > If you try to sign in without a username and multiple passkeys are saved to your device, you're prompted to choose which passkey to use for sign-in.

1. To select your passkey, follow the steps in the iOS operating system dialog. Verify yourself by using Face ID or Touch ID, or by entering your device PIN.

You're now signed in to Microsoft Entra ID.

### Cross-device authentication (iOS)

Follow these steps to sign in to Microsoft Entra ID on another device with a passkey in Authenticator on your iOS device. 

This sign-in option requires Bluetooth and an internet connection for both devices. If your organization restricts Bluetooth usage, an administrator can allow cross-device sign-in for passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. On the other device where you want to sign in to Microsoft Entra ID, go to the resource you're trying to access, such as [Office](https://www.office.com).

1. Enter your username to sign in.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-user-name.png" alt-text="Screenshot that shows Sign-in options with username in Authenticator for iOS devices.":::

   If you last used a passkey to authenticate, you're prompted to authenticate with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face, fingerprint, PIN or security key**.

   Alternatively, select **Sign-in options** to sign in without entering a username.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-microsoft.png" alt-text="Screenshot that shows sign-in options in Authenticator for iOS devices.":::

   If you selected **Sign-in options**, then select **Face, fingerprint, PIN or security key**. Otherwise, skip to the next step.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-options.png" alt-text="Screenshot that shows the sign-in options in Authenticator for iOS devices.":::

   > [!NOTE]
   > If you try to sign in without a username and multiple passkeys are saved to your device, you're prompted to choose which passkey to use for sign-in.

1. To begin cross-device authentication, follow the steps in the operating system or browser prompt. On Windows 11 23H2 or later, select **iPhone, iPad, or Android device**.

1. A QR code should appear on the screen. Now, on your iOS device, open the camera app and scan the QR code.

   The camera inside the iOS Authenticator app doesn't support scanning a WebAuthn QR code. You need to use the system camera app.

1. Select **Sign in with passkey** when the option appears.

   Bluetooth and an internet connection are required for this step and must both be enabled on your mobile and remote device.

1. To select your passkey, follow the steps in the iOS operating system dialog. Verify yourself by using Face ID or Touch ID, or by entering your device PIN.

You're now signed in to Microsoft Entra ID on your other device.

### Same-device authentication in native Microsoft applications (iOS)

You can use Authenticator on your iOS device to seamlessly sign in with a passkey to other Microsoft apps, such as OneDrive, SharePoint, and Outlook.

## [**Android**](#tab/Android)

To sign in with a passkey in Authenticator, your Android device needs to run Android 14 or later.

### Same-device authentication in a browser (Android)

Follow these steps to sign in to Microsoft Entra ID with a passkey in Authenticator on your Android device.

> [!NOTE]
> Support for same-device registration in Microsoft Edge on Android is coming soon.

1. On your Android device, open your browser and go to the resource you want to access at [My Security info](https://aka.ms/mysecurityinfo).

1. When you're prompted to sign in, you have two options. You can sign in with your username or without using your username.

   1. Enter your username.

       :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-user-name.png" alt-text="Screenshot that shows the sign-in with username in Authenticator for Android devices.":::

   1. To sign in without using your username, select **Sign-in options**.

       :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-microsoft.png" alt-text="Screenshot that shows the Sign in pane for Authenticator for Android devices.":::

   1. If you selected **Sign-in options**, then select **Face, fingerprint, PIN or security key**. Otherwise, skip to the next step.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-options.png" alt-text="Screenshot that shows the sign-in options in Authenticator for Android devices.":::

   If you have more than one passkey saved to your device, you're prompted to choose a passkey.

1. To select your passkey, follow the steps in the Android operating system dialog. Verify yourself by scanning your face or fingerprint, or by entering your device PIN or unlock gesture.

You're now signed in to Microsoft Entra ID.

### Cross-device authentication (Android)

Follow these steps to sign in to Microsoft Entra ID on another device with a passkey in Authenticator on your Android device.

This sign-in option requires Bluetooth and an internet connection for both devices. If your organization restricts Bluetooth usage, an administrator can allow cross-device sign-in for passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

1. On the other device where you want to sign in to Microsoft Entra ID, go to the resource you're trying to access, such as [Office](https://www.office.com).

1. Enter your username to sign in.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-user-name.png" alt-text="Screenshot that shows the sign-in with a username in Authenticator for iOS devices.":::

   If you last used a passkey to authenticate, you're prompted to authenticate with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face, fingerprint, PIN or security key**.

   Alternatively, select **Sign-in options** to sign in without having to enter a username.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-microsoft.png" alt-text="Screenshot that shows the sign-in for Authenticator for Android devices.":::

   If you selected **Sign-in options**, then select **Face, fingerprint, PIN or security key**. Otherwise, skip to the next step.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-options.png" alt-text="Screenshot that shows the sign-in options in Authenticator for Android devices.":::

1. To begin cross-device authentication, follow the steps in the operating system or browser prompt. On Windows 11 23H2 or later, select **iPhone, iPad, or Android device**.

1. A QR code should appear on the screen. Now, on your Android device, open the system camera app and scan the QR code. You can also use the camera in Authenticator. Go to the passkey account tile and tap it. Under **Passkey details**, you can see a button in the lower-right corner to scan the QR code.

   > [!NOTE]
   > Bluetooth and an internet connection are required for this step and both must be enabled on your mobile and remote device.
   >
   > For quicker sign-in, Android allows you to remember some browsers and Windows devices after you scan the WebAuthn QR code. In such cases, instead of having to scan a QR code each time, you can select the device and receive a notification to continue the passkey authentication.

1. To select your passkey, follow the steps in the Android operating system dialog. Verify yourself by scanning your face or fingerprint, or enter your device PIN or unlock gesture.

On your other device, you're now signed in to Microsoft Entra ID.

## Same-device authentication in native Microsoft applications

You can use Authenticator on your Android device to seamlessly sign in with a passkey to other Microsoft apps, such as OneDrive, SharePoint, and Outlook.

---

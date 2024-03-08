---
title: Create a passkey for Android or iOS device in Microsoft Authenticator (preview)
description: Learn how to create a passkey for Android or iOS device with Microsoft Authenticator (preview)

services: active-directory
ms.service: active-directory
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/06/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: mayurs, calui

ms.collection: M365-identity-device-management
---
# Sign in to Microsoft Entra ID with a passkey in Microsoft Authenticator (preview)

This article covers the sign-in experience when using passkeys in Microsoft Authenticator with Microsoft Entra ID. For more information on the availability of Microsoft Entra ID passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [App and browser support of passkey (FIDO2) authentication](concept-passkey-fido2-compatibility.md).

# [:::image type="icon" source="media/icons/ios-icon.png" border="false"::: **iOS**](#tab/iOS)

**In this article**

[Same-device authentication](#same-device-authentication-ios)<br>
[Cross-device authentication](#cross-device-authentication-ios)<br>

To sign in with a passkey in Microsoft Authenticator, your iOS device needs to run iOS 17 or later.

### Same-device authentication (iOS)

This topic shows how to sign in to Microsoft Entra ID with a passkey in Microsoft Authenticator on your iOS device.

1. On your iOS device, open your browser and go to `myaccount.microsoft.com`.
1. Select **Sign-in options**. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for iOS devices.":::

1. Select **Face**, **Fingerprint**, **PIN**, or **Security key**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for iOS devices.":::

1. Follow the steps in the iOS operating system dialog to select your passkey. Verify that it's you by using Face ID, Touch ID, or entering your device PIN.

1. You're now signed into Microsoft Entra ID.

### Cross-device authentication (iOS)

This topic shows how to sign in to Microsoft Entra ID on another device with a passkey in Microsoft Authenticator on your iOS device.

1. On the other device where you are looking to sign in to Microsoft Entra ID, open your browser and go to `myaccount.microsoft.com`.

1. Select **Sign-in options**. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for iOS devices.":::

1. Select **Face**, **Fingerprint**, **PIN**, or **Security key**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for iOS devices.":::

1. Follow the steps in the operating system or browser prompt to initiate cross-device authentication. On Windows 11 23H2 or later, select **iPhone, iPad, or Android device**.

1. A QR code should be shown on screen. Now, on your iOS device, open the Camera app and scan the QR code. Click **Sign-in with passkey** when the option appears.

1. Follow the steps in the iOS operating system dialog to select your passkey. Verify that it's you by using Face ID, Touch ID, or entering your device PIN.

1. You're now signed into Microsoft Entra ID on your other device.

# [:::image type="icon" source="media/icons/android-icon.png" border="false"::: **Android**](#tab/Android)

**In this article**

[Same-device authentication](#same-device-authentication-android)<br>
[Cross-device authentication](#cross-device-authentication-android)<br>

To sign in with a passkey in Microsoft Authenticator, your Android device needs to run Android 14 or later.

### Same-device authentication (Android)

This topic shows how to sign in to Microsoft Entra ID with a passkey in Microsoft Authenticator on your Android device.

1. On your Android device, open your browser and go to `login.microsoftonline.com`.
1. Select **Sign-in options**. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for Android devices.":::

1. Select **Face**, **Fingerprint**, **PIN**, or **Security key**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for Android devices.":::

1. Follow the steps in the Android operating system dialog to select your passkey. Verify that it's you by scanning your face, fingerprint, or entering your device PIN or unlock gesture.

1. You're now signed into Microsoft Entra ID.

### Cross-device authentication (Android)

This topic shows how to sign in to Microsoft Entra ID on another device with a passkey in Microsoft Authenticator on your Android device.

1. On the other device where you are looking to sign in to Microsoft Entra ID, open your browser and go to `myaccount.microsoft.com`.

1. Select **Sign-in options**. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for Android devices.":::

1. Select **Face**, **Fingerprint**, **PIN**, or **Security key**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for Android devices.":::

1. Follow the steps in the operating system or browser prompt to initiate cross-device authentication. On Windows 11 23H2 or later, select **iPhone, iPad, or Android device**.

1. A QR code should be shown on screen. Now, on your Android device, open the Camera app and scan the QR code. Click **Sign-in with passkey** when the option appears.

1. Follow the steps in the Android operating system dialog to select your passkey. Verify that it's you by scanning your face, fingerprint, or entering your device PIN or unlock gesture.

1. You're now signed into Microsoft Entra ID on your other device.

---

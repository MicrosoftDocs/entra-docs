---
title: Sign in with passkeys in Authenticator for Android and iOS devices (preview)
description: Learn how to sign in with passkeys for Android and iOS devices with Microsoft Authenticator (preview.

services: active-directory
ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/07/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: mjsantani, calui

ms.collection: M365-identity-device-management
---
# Sign in with passkeys in Authenticator for Android and iOS devices (preview)

This article covers the sign-in experience when using passkeys in Microsoft Authenticator with Microsoft Entra ID. For more information about the availability of Microsoft Entra ID passkey (FIDO2) authentication across native applications, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md).

| Scenario | iOS | Android |
|------------------|---------------------------------|----------------|
| **Same-device authentication in a browser**              | &#x2705;          | &#10060;<sup>2</sup>       |
| **Same-device authentication in native Microsoft applications**<sup>1</sup>            | &#x2705; | &#x2705;     |
| **Cross-device authentication**  | &#x2705;  | &#x2705;    |

<sup>1</sup>Support for same-device registration in Edge on Android is coming soon.

<sup>2</sup>Native app sign-in support is coming soon.


## [**iOS**](#tab/iOS)

To sign in with a passkey in Microsoft Authenticator, your iOS device needs to run iOS 17 or later.

### Same-device authentication in a browser (iOS)

Follow these steps to sign in to Microsoft Entra ID with a passkey in Authenticator on your iOS device. 

1. On your iOS device, open your browser and navigate to the resource you're trying to access such as [Office](https://www.office.com).

1. You can enter your username to sign in: 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-user-name.png" alt-text="Screenshot of the sign-in with username in Microsoft Authenticator for iOS devices.":::

   If you most recently used a passkey to sign in, you're automatically prompted to sign in with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face**, **fingerprint**, **PIN**, or **security key**.

   Alternatively, click **Sign-in options** to sign in more conveniently without having to enter a username. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for iOS devices.":::

   If you chose **Sign-in options**, select **Face**, **fingerprint**, **PIN**, or **security key**. Otherwise, skip to next step.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for iOS devices.":::

   > [!NOTE]
   > If you attempt to sign in without a username and multiple passkeys are saved to your device, you're prompted to choose which passkey to use for sign-in. 

1. To select your passkey, follow the steps in the iOS operating system dialog. Verify that it's you by using Face ID, Touch ID, or entering your device PIN.

1. You're now signed into Microsoft Entra ID.

### Cross-device authentication (iOS)

Follow these steps to sign in to Microsoft Entra ID on another device with a passkey in Authenticator on your iOS device.

1. On the other device where you're looking to sign in to Microsoft Entra ID, navigate to the resource you're trying to access such as [Office](https://www.office.com).

1. You can enter your username to sign in: 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-user-name.png" alt-text="Screenshot of the sign-in with username in Microsoft Authenticator for iOS devices.":::

   If you last used a passkey to authenticate, you will be automatically prompted to authenticate with a passkey. Otherwise, you may click on **Other ways to sign in** and then select **Face, fingerprint, PIN, or security key**.

   Alternatively, click **Sign-in options** to sign in more conveniently without having to enter a username. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for iOS devices.":::

   If you chose **Sign-in options**, select **Face, fingerprint, PIN, or security key**. Otherwise, skip to next step.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for iOS devices.":::

   > [!NOTE]
   > If you try to sign in without a username and multiple passkeys are saved to your device, you're prompted to choose which passkey to use for sign-in. 
   
1. To begin cross-device authentication, follow the steps in the operating system or browser prompt. On Windows 11 23H2 or later, select **iPhone, iPad, or Android device**.

1. A QR code should appear on screen. Now, on your iOS device, open the camera app and scan the QR code.
   
   > [!NOTE]
   > The camera inside the iOS Authenticator app doesn't support scanning a WebAuthn QR code. You need to use the system camera app.
    
1. Select **Sign in with passkey** when the option appears.

   > [!NOTE]
   > Bluetooth and an internet connection are required for this step and must both be enabled on your mobile and remote device.

1. To select your passkey, follow the steps in the iOS operating system dialog. Verify that it's you by using Face ID, Touch ID, or enter your device PIN.

1. You're now signed into Microsoft Entra ID on your other device.

### Same-device authentication in native Microsoft applications (iOS)

You can use Authenticator on your iOS device to seamlessly sign in with a passkey to other Microsoft apps, such as Microsoft OneDrive, SharePoint, and Outlook. 


## [**Android**](#tab/Android)

To sign in with a passkey in Microsoft Authenticator, your Android device needs to run Android 14 or later.

### Same-device authentication in a browser (Android)

Follow these steps to sign in to Microsoft Entra ID with a passkey in Microsoft Authenticator on your Android device.

>[!NOTE]
>Support for same-device registration in Edge on Android is coming soon.

1. On your Android device, open your browser and navigate to the resource you're trying to access at [My Security info](https://aka.ms/mysecurityinfo).

1. When prompted to sign in, you have two options. The *usernameless* option can be easier than entering your username.

   1. Type your username. 

       :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-user-name.png" alt-text="Screenshot of the sign-in with username in Microsoft Authenticator for Android devices.":::

   1. To sign in with the *usernameless* option, select **Sign-in options**. 

       :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for Android devices.":::

   1. If you chose **Sign-in options**, select **Face**, **Fingerprint**, **PIN**, or **Security key**. Otherwise, skip to next step.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for Android devices.":::

    > [!NOTE]
    > If you have more than one passkey saved to your device, you're prompted to choose a passkey. 

1. To select your passkey, follow the steps in the Android operating system dialog. Verify that it's you by scanning your face, fingerprint, or entering your device PIN or unlock gesture.

1. You're now signed into Microsoft Entra ID.


### Cross-device authentication (Android)

Follow these steps to sign in to Microsoft Entra ID on another device with a passkey in Microsoft Authenticator on your Android device.

1. On the other device where you're looking to sign in to Microsoft Entra ID, navigate to the resource you're trying to access such as [Office](https://www.office.com).

1. You can enter your username to sign in: 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-user-name.png" alt-text="Screenshot of the sign-in with username in Microsoft Authenticator for iOS devices.":::

   If you last used a passkey to authenticate, you will be automatically prompted to authenticate with a passkey. Otherwise, you may click on **Other ways to sign in** and then select **Face, fingerprint, PIN, or security key**.

   Alternatively, click **Sign-in options** to sign in more conveniently without having to enter a username. 

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-microsoft.png" alt-text="Screenshot of the sign-in Microsoft in Microsoft Authenticator for Android devices.":::

   If you chose **Sign-in options**, select **Face, fingerprint, PIN, or security key**. Otherwise, skip to next step.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-android/sign-in-options.png" alt-text="Screenshot of the sign-in options in Microsoft Authenticator for Android devices.":::

1. To begin cross-device authentication, follow the steps in the operating system or browser prompt. On Windows 11 23H2 or later, select **iPhone, iPad, or Android device**.

1. A QR code should appear on screen. Now, on your Android device, open the system camera app and scan the QR code. Alternatively, you can also use the camera in Authenticator. Navigate to the passkey account tile and tap on it. Under **Passkey details (preview)**, you'll see a button in the bottom-right corner to scan the QR code. 
   
   > [!NOTE]
   > Bluetooth and an internet connection are required for this step and both must be enabled on your mobile and remote device.
   > For quicker sign-in, Android allows you to remember some browsers and Windows devices after scanning the WebAuthn QR code. In such cases, instead of a QR code scan each time, the device appears as a selectable option, and you get a notification on your mobile device to continue the passkey authentication.

1. To select your passkey, follow the steps in the Android operating system dialog. Verify that it's you by scanning your face, fingerprint, or enter your device PIN or unlock gesture.

1. You're now signed into Microsoft Entra ID on your other device.

### Same-device authentication in native Microsoft applications (Android)

You can't use passkeys in Authenticator on your Android device to sign in to other Microsoft apps, such as Microsoft OneDrive, SharePoint, and Outlook. Support for Android devices is coming later during preview. 
---

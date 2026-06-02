---
title:  Sign in with a passkey (FIDO2) for your work or school account
description: Learn how to sign in with a passkey (FIDO2) for your work or school account.

services: active-directory
ms.topic: how-to
ms.date: 11/10/2025
ms.reviewer: kimhana

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users will sign in with a security key. 

---
# Sign in with a passkey (FIDO2) for your work or school account 

This article covers different ways that users can sign in to Microsoft Entra ID with a passkey. 

- [Sign in with a passkey (FIDO2) saved on the same device](#sign-in-with-a-passkey-fido2-saved-on-the-same-device)
- [Sign in with a passkey (FIDO2) saved on another device](#sign-in-with-a-passkey-fido2-saved-on-another-device)
- [Sign in with a passkey (FIDO2) saved on a security key](#sign-in-with-a-passkey-fido2-saved-on-a-security-key)

For more information about how to sign in with a passkey in Microsoft Authenticator, see [Sign in with passkeys in Authenticator for Android and iOS devices](~/identity/authentication/how-to-sign-in-passkey-authenticator.md).

For more information about the availability of Microsoft Entra ID passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md).

## Sign in with a passkey (FIDO2) saved on the same device

1. Open your browser and go to the resource you're trying to access, such as [Office](https://www.office.com).

1. You can enter your username to sign in. If you most recently used a passkey to sign in, you're automatically prompted to sign in with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face, fingerprint, PIN, or security key**. 

   Alternatively, click **Sign-in options** to sign in more conveniently without having to enter a username. If you chose **Sign-in options**, select **Face, fingerprint, PIN, or security key**. Otherwise, skip to next step.
   
1. Your device opens a security window. To use your security key, follow the steps in the operating system or browser dialog. Verify that it's you by scanning your fingerprint or entering your PIN.

## Sign in with a passkey (FIDO2) saved on another device  

1. Open your browser and go to the resource you're trying to access, such as [Office](https://www.office.com).
1. You can enter your username to sign in. If you most recently used a passkey to sign in, you're automatically prompted to sign in with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face, fingerprint, PIN, or security key**.

   Alternatively, select **Sign-in options** to sign in more conveniently without having to enter a username. If you chose **Sign-in options**, select **Face, fingerprint, PIN, or security key**. Otherwise, skip to the next step.

1. Your device opens a security window. To begin cross-device authentication, follow the steps in the operating system or browser prompt. On Windows 11 23H2 or later, select iPhone, iPad, or Android device.
1. A QR code should appear on the screen. Now, on your mobile device, open the camera app and scan the QR code.
1. Select **Sign in with passkey** when the option appears.
1. Bluetooth and an internet connection are required for this step and must both be enabled on your mobile and remote device.
1. To select your passkey, follow the steps in the iOS operating system dialog. Verify yourself by using face, fingerprint or device PIN.
1. You’re now signed in to Microsoft Entra ID.


## Sign in with a passkey (FIDO2) saved on a security key

1. Open your browser and go to the resource you're trying to access, such as [Office](https://www.office.com).
1. You can enter your username to sign in. If you most recently used a passkey to sign in, you're automatically prompted to sign in with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face, fingerprint, PIN, or security key**.

   Alternatively, select **Sign-in options** to sign in more conveniently without having to enter a username. If you chose **Sign-in options**, select **Face, fingerprint, PIN, or security key**. Otherwise, skip to the next step.

1. Your device opens a security window. To use your security key, follow the steps in the operating system or browser dialog. Scan your fingerprint or enter your PIN to verify that it's you.
1. Once you're signed in, your device displays a screen similar to this one:

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/welcome.png" alt-text="Screenshot of Microsoft Welcome page.":::

## Known issues

Review the following known issues to avoid problems with passkey (FIDO2) sign-in.

### Bluetooth must be enabled on both devices for cross-device authentication

If you’re signing-in using a different mobile device, Bluetooth must be enabled on the device you are trying to sign-in on and the mobile device with the passkey.

### Orphaned passkey

An orphaned passkey occurs when a passkey remains on a user’s device but is no longer registered with Microsoft Entra ID. This typically happens if the passkey was deleted from a user's Security info or removed due to policy changes, but the local credential was not cleaned up.

If you're blocked from sign-in by an orphaned passkey:

1. Remove the orphaned passkey from the device or passkey authenticator.
1. Re-register a new passkey after cleanup.

## Next steps

- [Support for passkey (FIDO2) authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md)

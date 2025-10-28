---
title:  Sign in with a passkey (FIDO2)
description: Learn how users sign in with a passkey (FIDO2).

services: active-directory
ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/27/2025

ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users will sign in with a security key. 

---
# Sign in with a passkey (FIDO2)

This article covers how users can sign in to Microsoft Entra ID with a passkey. For more information about how to sign in with a passkey in Microsoft Authenticator, see [Sign in with passkeys in Authenticator for Android and iOS devices](~/identity/authentication/how-to-sign-in-passkey-authenticator.md).

For more information about the availability of Microsoft Entra ID passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md).

To sign into your work or school account with a security key, follow these steps on your device:

1. Go to [Office](https://www.office.com).

1. You can enter your username to sign in: 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-user-name.png" alt-text="Screenshot of the sign-in with username.":::

   If you most recently used a passkey to sign in, you're automatically prompted to sign in with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face**, **fingerprint**, **PIN**, or **security key**.

   Alternatively, click **Sign-in options** to sign in more conveniently without having to enter a username. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-microsoft.png" alt-text="Screenshot of sign-in options.":::

   If you chose **Sign-in options**, select **Face**, **fingerprint**, **PIN**, or **security key**. Otherwise, skip to next step.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct-ios/sign-in-options.png" alt-text="Screenshot of Face, fingerprint, PIN, or security key in sign-in options.":::

1. Your device opens a security window. To use your security key, follow the steps in the operating system or browser dialog. Verify that it's you by scanning your fingerprint or entering your PIN.

1. Once you're signed in, your device displays a screen similar to this one:

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/welcome.png" alt-text="Screenshot of Microsoft Welcome page.":::

## Known issues

### Bluetooth must be enabled on both devices for cross-device authentication

If you’re signing-in using a different mobile device, Bluetooth must be enabled on the device you are trying to sign-in on and the mobile device with the passkey.

### Orphaned passkey

An orphaned passkey occurs when a passkey remains on a user’s device but is no longer registered with Microsoft Entra ID. This typically happens if the passkey was deleted from a user's Security info or removed due to policy changes, but the local credential was not cleaned up.

If you're blocked from sign-in by an orphaned passkey:

1. Remove the orphaned passkey from the device or passkey authenticator.
1. Re-register a new passkey after cleanup.

## Next steps

- [Support for passkey (FIDO2) authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md)

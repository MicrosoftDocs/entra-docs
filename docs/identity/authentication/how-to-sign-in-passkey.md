---
title:  Sign in with a passkey (FIDO2)
description: Learn how users sign in with a passkey (FIDO2).

services: active-directory
ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 04/19/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users will sign in with a security key. 

---
# Sign in with a passkey (FIDO2)

This article covers how users can sign in to Microsoft Entra ID with a passkey stored on a FIDO2 security key. For how to sign in with a passkey in Microsoft Authenticator, see [Sign in with passkeys in Authenticator for Android and iOS devices](~/identity/authentication/how-to-sign-in-passkey-authenticator.md)

For more information on the availability of Microsoft Entra ID passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md).

## Sign in with a security key

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

<!---

  :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/device-opens-security-window.png" alt-text="Screenshot showing that the device opens security window.":::

Depending on how your admin has set up your organization's authentication options, you'll see a screen that looks similar to this one. Select **Next** to continue.

  :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/sign-in-with-passkey.png" alt-text="Screenshot showing that options for signing in with a passkey.":::

-->

1. Once you're signed in, your device displays a screen similar to this one:

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/welcome.png" alt-text="Screenshot of Microsoft Welcome page.":::

## Known issues

### Mobile device might be prioritized over security key

If you're using Chrome or Edge, the browser may prioritize using a passkey stored on a mobile device over a passkey stored on a security key. 

- Beginning with Windows 11 version 23H2, the operating system shows the following prompt during sign-in. Below **More choices**, choose **Security key** and select **Next**.

  :::image type="content" border="true" source="./media/howto-authentication-passwordless-security-key/security-key.png" alt-text="Screenshot of option to choose security key on Windows 11."::: 

- On earlier versions of Windows, the browser may show the QR pairing screen to continue with using a passkey stored on a mobile device. To use a passkey stored on a security key instead, insert your security key and touch it to continue. 

  :::image type="content" border="true" source="./media/howto-authentication-passwordless-security-key/insert-device-bound-passkey.png" alt-text="Screenshot of option to insert a device-bound passkey on Windows 10."::: 

## Next steps

- [Support for FIDO2 authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md)

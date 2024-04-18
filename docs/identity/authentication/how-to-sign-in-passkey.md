---
title:  Sign in with a passkey (FIDO2) (preview)
description: Learn how users sign in with a passkey (FIDO2).

services: active-directory
ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 04/10/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users will sign in with a security key. 

---
# Sign in with a passkey (FIDO2) (preview)

Passkeys are a replacement for your password. With passkeys, you can sign into your Microsoft account using your face, fingerprint, or PIN. Signing in with a passkey is simple, fast, and helps protect you against phishing attacks. For information about FIDO2 support, see [Support for FIDO2 authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md).

## Prerequisite

In order for sign in with a passkey to work successfully, you'll first need to create a passkey. For more information, see [Register a passkey (preview)](~/identity/authentication/how-to-register-passkey.md).

## Sign in to your work or school account

To sign into your work or school account with a passkey, follow these steps on your device:

1. Go to [https://login.microsoftonline.com](https://login.microsoftonline.com).
1. Select **Sign-in options**.
   
    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/sign-in-hero-path.png" alt-text="Screenshot of the Microsoft sign-in page.":::

1. Select **Face, Fingerprint, PIN, or security key**.

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/sign-in-options.png" alt-text="Screenshot of Microsoft sign-in options.":::

1. Your device opens a security window where you can use your face, fingerprint, PIN, or security key.

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/device-opens-security-window.png" alt-text="Screenshot showing that the device opens security window.":::

1. Depending on how your admin has set up your organization's authentication options, you'll see a screen that looks similar to this one. Select **Next** to continue.

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/sign-in-with-passkey.png" alt-text="Screenshot showing that options for signing in with a passkey.":::

1. Once you're signed in, your device displays a screen similar to this one:

    :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-direct/welcome.png" alt-text="Screenshot of Microsoft Welcome page.":::

>[!NOTE]
> Biometric data stays on your device and is never shared with Microsoft.

## Next steps

- [Register passkeys in Authenticator on Android or iOS devices (preview)](how-to-register-passkey-authenticator.md)

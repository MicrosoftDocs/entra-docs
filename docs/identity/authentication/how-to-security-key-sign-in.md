---
title: Sign in with a FIDO2 security key
description: Learn how to sign in to Microsoft Entra ID with a FIDO2 security key. Sign in to web apps, Windows, and on-premises resources.
ms.topic: how-to
ms.date: 07/05/2026
ms.reviewer: kimhana
ms.collection: M365-identity-device-management
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1013
# Customer intent: As a user, I want to sign in to my work or school account by using a FIDO2 security key.
---
# Sign in with a FIDO2 security key

FIDO2 security keys are device-bound passkeys stored on a physical authenticator. The private key never leaves the security key, which provides strong protection against remote phishing attacks. Security keys come in a variety of form factors (USB, NFC, Bluetooth) and are recommended for highly regulated industries or users with elevated privileges.

For more information about the availability of passkey (FIDO2) authentication across native apps, web browsers, and operating systems, see [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md).

## Sign in with a security key

1. Open your browser and go to the resource you're trying to access, such as [Office](https://www.office.com).

1. You can enter your username and select **Next** to sign in. If you most recently used a passkey to sign in, you're automatically prompted to sign in with a passkey.

   :::image type="content" source="media/how-to-sign-in-passkey/sign-in-options-name.png" alt-text="Screenshot that shows the Sign in page with a username and the Next button.":::

   Or select **Sign-in options** >  **Face, fingerprint, PIN, or security key** to sign in without a username.

   :::image type="content" source="media/how-to-sign-in-passkey/sign-in-options-passkey.png" alt-text="Screenshots that show the Sign-in options button and the Face, fingerprint, PIN or security key option.":::

1. Select **Security key**.

   :::image type="content" source="media/how-to-security-key-sign-in/choose-passkey-security-key.png" alt-text="Screenshot that shows the Choose a passkey dialog with Security key option." border="true" lightbox="media/how-to-security-key-sign-in/choose-passkey-security-key.png":::

1. Your device opens a security window. Insert your FIDO2 security key if it's a USB key, or bring it near the reader if it's an NFC key.

1. To verify your identity, scan your fingerprint or enter your PIN when prompted by the operating system or browser dialog.

1. You're signed in with your work or school account.

## Known issues

### Orphaned passkey

An orphaned passkey occurs when a passkey remains on a security key but is no longer registered with Microsoft Entra ID. This typically happens if the passkey was deleted from a user's Security info or removed due to policy changes, but the local credential wasn't cleaned up.

If you're blocked from sign-in by an orphaned passkey:

1. Remove the orphaned passkey from the security key by using the security key's management tool.
1. Re-register a new passkey after cleanup.

## Related content

- [Register a passkey with a FIDO2 security key](how-to-register-passkey-with-security-key.md)
- [Enable passkeys (FIDO2) in Microsoft Entra ID](how-to-authentication-passkeys-fido2.md)
- [Enable security key sign-in to Windows](howto-authentication-passwordless-security-key-windows.md)
- [SSO to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md)
- [Passkey FAQ](passkey-faq.yml)
- [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md)

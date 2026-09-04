---
title: Register a synced passkey (FIDO2)
description: Learn how to register a synced passkey (FIDO2) as an authentication method on Windows, iOS, or Android by using a browser for phishing-resistant sign-in.
ms.topic: how-to
ms.date: 07/05/2026
ms.reviewer: kimhana, calui, tilarso
ms.collection: M365-identity-device-management
ms.custom: sfi-image-nochange, msecd-doc-authoring-1013
ai-usage: ai-assisted
# Customer intent: As an identity administrator, I want to understand how users will register a passkey using a browser on Windows, iOS, or Android.

---
# Register a synced passkey (FIDO2)

This article shows how users can register a synced passkey (FIDO2) by using the **Passkey** flow. A synced passkey is stored in a passkey provider (such as iCloud Keychain or Google Password Manager) and syncs across the user's devices. For an overview of synced passkeys, see [Synced passkeys in Microsoft Entra ID](how-to-synced-passkeys.md).

> [!NOTE]
> Looking to provide passkeys (FIDO2) on behalf of users? Use our [APIs](https://aka.ms/passkeyprovision).

## Prerequisites

You need to configure a password manager on your mobile device to save a synced passkey.

- On your iOS device, you need to set **Set Up Codes In** to **Passwords** to manage synced passkeys. Open **Settings** > **General** > **AutoFill & Passwords**. For **Set Up Codes In**, select **Passwords**.
- On your Android device, open **Settings** > **Security and privacy** > **More security settings** > **Passwords, passkeys, and autofill**, and then select a provider.

## Register a passkey

To register a passkey on your device, follow these steps:

1. Open a web browser and sign in to [Security info](https://mysignins.microsoft.com/security-info).
1. Sign in with multifactor authentication (MFA).
1. Tap **+ Add sign-in method**.

    :::image type="content" source="media/how-to-register-passkey/add-sign-in-method-ios.png" alt-text="Screenshot of the Security info page on iOS showing the Add sign-in method option." border="true" lightbox="media/how-to-register-passkey/add-sign-in-method-ios.png":::

1. Tap **Passkey**.

    :::image type="content" source="media/how-to-register-passkey/choose-passkey-ios.png" alt-text="Screenshot of the Add a sign-in method page on iOS showing the Passkey option." border="true" lightbox="media/how-to-register-passkey/choose-passkey-ios.png":::

1. Tap **Next**.

    :::image type="content" source="media/how-to-register-passkey/sign-in-faster-ios.png" alt-text="Screenshot of the Sign in faster with your face, fingerprint, or PIN page on iOS showing the Next option." border="true" lightbox="media/how-to-register-passkey/sign-in-faster-ios.png":::

1. On iOS, tap **Next**.

    :::image type="content" source="media/how-to-register-passkey/setting-up-passkey-ios.png" alt-text="Screenshot of the Setting up your passkey page on iOS showing the Next option." border="true" lightbox="media/how-to-register-passkey/setting-up-passkey-ios.png":::

    On Android, tap **Continue**.

    > [!NOTE]
    > The steps to enable passkey providers on Android might vary based on the make and model of your device. Search for Passkey on your device settings, or consult your device manufacturer for guidance. If your device runs Android 14 and you can't enable Authenticator as a passkey provider, we recommend that you upgrade to Android 15.

    :::image type="content" source="media/how-to-register-passkey/android-complete.png" alt-text="Screenshot of the Create a passkey page on Android showing the account name and Continue option." border="true" lightbox="media/how-to-register-passkey/android-complete.png":::

1. Name your passkey and tap **Next**. 

    :::image type="content" source="media/how-to-register-passkey/name-passkey.png" alt-text="Screenshot of the Let's name your passkey page showing the passkey name field and Next option." border="true" lightbox="media/how-to-register-passkey/name-passkey.png":::

1. After the passkey is created, tap **Done**. 

    :::image type="content" source="media/how-to-register-passkey/passkey-created-ios.png" alt-text="Screenshot of the Passkey created page showing the Done option." border="true" lightbox="media/how-to-register-passkey/passkey-created-ios.png":::

1. You can see your passkey in [Security info](https://mysignins.microsoft.com/security-info). 

    :::image type="content" source="media/how-to-register-passkey/passkey-added-ios.png" alt-text="Screenshot of the Security info page showing the registered passkey." border="true" lightbox="media/how-to-register-passkey/passkey-added-ios.png":::

## Related content

To register a passkey on a different type of authenticator, see:

- [Register passkeys in Microsoft Authenticator](how-to-register-passkey-authenticator.md)
- [Register a passkey with a FIDO2 security key](how-to-register-passkey-with-security-key.md)


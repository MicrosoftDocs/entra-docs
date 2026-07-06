---
title: Sign in with a synced passkey (FIDO2)
description: Learn how to sign in to Microsoft Entra ID with a synced passkey (FIDO2) for your work or school account by using a browser on Windows, iOS, or Android.
ms.topic: how-to
ms.date: 07/05/2026
ms.reviewer: kimhana
ms.collection: M365-identity-device-management
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1013
# Customer intent: As an identity administrator, I want to understand how users will sign in with a passkey.

---
# Sign in with a synced passkey (FIDO2)

This article describes how to sign in to your work or school account with a synced passkey.

Your passkey can be synced to the same device where you want to sign in, or it can be synced to another device.

- [Use a passkey from the same device](#use-a-passkey-from-the-same-device)
- [Use a passkey from another device](#use-a-passkey-from-another-device)

## Use a passkey from the same device

1. Select **Sign in** for a Microsoft application or website such as the [Azure portal](https://ms.portal.azure.com/).

1. If you most recently used a passkey to sign in, you're automatically prompted to sign in with a passkey. Choose your account.

    :::image type="content" source="media/how-to-sign-in-passkey/choose-synced-passkey-account.png" alt-text="Screenshot that shows the Pick an account dialog with a work or school account." lightbox="media/how-to-sign-in-passkey/choose-synced-passkey-account.png":::

    Otherwise, you can enter your username and select **Next** to sign in.

    :::image type="content" source="media/how-to-sign-in-passkey/sign-in-options-name.png" alt-text="Screenshot that shows the Sign in dialog with a username entered and the Next button." lightbox="media/how-to-sign-in-passkey/sign-in-options-name.png":::

1. Complete multifactor authentication (MFA).

1. You're signed in with your work or school account.

## Use a passkey from another device

1. Select **Sign in** for a Microsoft application or website such as the [Azure portal](https://ms.portal.azure.com/).

1. In Microsoft Edge, right-click where you enter your name, select **Use passkey from another device** > **Use a phone, tablet or security key**.

    :::image type="content" source="media/how-to-sign-in-passkey/use-passkey-from-another-device-edge.png" alt-text="Screenshots that show the Use passkey from another device option in Microsoft Edge and the Use a phone, tablet or security key option in the Sign in using a saved passkey dialog." lightbox="media/how-to-sign-in-passkey/use-passkey-from-another-device-edge.png":::

    In Google Chrome, select where you enter your name, then select **Use passkey from another device**.

    :::image type="content" source="media/how-to-sign-in-passkey/use-passkey-on-another-device-chrome.png" alt-text="Screenshot that shows the Use passkey from another device option in the Chrome account list." lightbox="media/how-to-sign-in-passkey/use-passkey-on-another-device-chrome.png":::

    You can also click **Sign in**, select **Sign-in options** > **Face, fingerprint, PIN or security key**.

    :::image type="content" source="media/how-to-sign-in-passkey/sign-in-options-combined.png" alt-text="Screenshots that show the Sign-in options button and the Face, fingerprint, PIN or security key option.":::

1. Select **iPhone, iPad, or Android device**. The other sign-in options that are shown vary depending on your account and device.

    :::image type="content" source="media/how-to-sign-in-passkey/sign-in-options-device.png" alt-text="Screenshot that shows the iPhone, iPad, or Android device option in the Choose a passkey dialog." lightbox="media/how-to-sign-in-passkey/sign-in-options-device.png":::

1. The device where you want to sign in shows a QR code. Scan the QR code with the other device that has your passkey.

    :::image type="content" source="media/how-to-sign-in-passkey/scan-code-no-name.png" alt-text="Screenshot that shows the Sign in with a passkey dialog with a QR code to scan." border="true" lightbox="media/how-to-sign-in-passkey/scan-code-no-name.png":::

1. On iOS, select **Sign in with passkey**. On Android, select **Use passkey to sign in**.

1. Bluetooth and an internet connection are required for this step and must be enabled on both devices. The device where you want to sign in shows this screen:

    :::image type="content" source="media/how-to-sign-in-passkey/device-connected.png" alt-text="Screenshot that shows the Sign in with a passkey dialog with a Device connected message." border="true" lightbox="media/how-to-sign-in-passkey/device-connected.png":::

1. Complete multifactor authentication (MFA).

1. You're signed in with the synced passkey for your work or school account.

## Known issues

Review the following known issues to avoid problems with synced passkey sign-in.

### Bluetooth must be enabled on both devices for cross-device authentication

If you're signing in by using a different mobile device, Bluetooth must be enabled on the device you're trying to sign in on and the mobile device with the passkey.

Some organizations restrict Bluetooth usage, which includes the use of passkeys. In such cases, organizations can allow passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=intune#passkeys-in-bluetooth-restricted-environments).

### Orphaned passkey

An orphaned passkey occurs when a passkey remains on a user's device but is no longer registered with Microsoft Entra ID. This typically happens if the passkey was deleted from a user's Security info or removed due to policy changes, but the local credential wasn't cleaned up.

If you're blocked from sign-in by an orphaned passkey:

1. Remove the orphaned passkey from the device or passkey provider.
1. Re-register a new passkey after cleanup.

## Related content

- [Register a synced passkey (FIDO2)](how-to-register-passkey.md)
- [Synced passkeys in Microsoft Entra ID](how-to-synced-passkeys.md)
- [Support for passkey (FIDO2) authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md)

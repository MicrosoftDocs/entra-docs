---
title: Transfer Microsoft Authenticator to a new phone
description: Learn how to back up and restore Microsoft Authenticator account entries when you switch to a new phone, including passkey setup steps.
ms.topic: how-to
ms.date: 07/02/2026
ms.reviewer: matursca
ms.collection: M365-identity-device-management
# Customer intent: As a user, I want to transfer my Microsoft Authenticator accounts and passkeys to a new phone so I can continue using secure sign-in methods without losing access.
---

# Transfer Microsoft Authenticator account entries to a new phone

Microsoft Authenticator helps make sign-in more secure and convenient by supporting multifactor authentication, verification codes, passwordless sign-in, and passkeys. When you get a new phone, you can recover supported account entries and continue using secure sign-in methods by backing up and restoring these methods. Work or school accounts require additional sign-in and setup steps after restore. Complete the transfer before you erase, trade in, or recycle your old phone.

For work or school accounts, backup and restore transfers the account name so you can recognize the account on the new phone. You still need to sign in again to complete setup. Passkeys are handled separately from Authenticator account backup. If a passkey was saved only to the old phone, add a new passkey for the new phone. If a passkey was saved to a synced credential manager, it might be available after you sign in to that credential manager.

> [!IMPORTANT]
> Keep your old phone until you confirm that you can sign in to the accounts and resources you use most often from the new phone.

Use the following steps to back up Microsoft Authenticator on your old phone, restore it on your new phone, and set up passkeys again when needed.

## Back up Microsoft Authenticator on iOS

To back up Authenticator on an iOS device, enable iCloud Drive, Keychain, and Backup for Authenticator.

1. Enable iCloud Drive on your iOS device.
1. Enable iCloud Keychain on your iOS device.
1. Enable iCloud Backup on your iOS device.
1. Go to **Apple Account** > **iCloud** > **Saved to iCloud** and search for **Authenticator**.
1. Turn on the **Authenticator** toggle.

   :::image type="content" source="media/how-to-transfer-authenticator-new-phone/authenticator-icloud-backup-toggle.jpg" alt-text="Screenshot showing the Authenticator toggle enabled in iCloud settings.":::

## Back up Microsoft Authenticator on Android

To back up your Authenticator account entries on an Android device:

1. Open Microsoft Authenticator.
1. Open the menu and select **Settings**.
1. Turn on **Cloud Backup**.
1. Select a Microsoft personal account where the backup will be stored.
1. Tap **OK**.

> [!NOTE]
> If you saved the backup to the wrong account, or need to change the recovery account, delete the existing backup and create a new backup.

## Expected behavior after restore

### Work or school accounts

- Only the account name is restored.
- To complete setup on the new phone, open the account and sign in again.
- You might see red text that says **"Sign in to add your account."**

   :::image type="content" source="media/how-to-transfer-authenticator-new-phone/authenticator-sign-in-to-add-account.jpg" alt-text="Screenshot of a restored work account in Microsoft Authenticator showing the Sign in to add your account message.":::
- If passkeys are enforced for the account, set up a passkey for the new phone before removing the old device.

Steps to set up a passkey on the new phone:

1. If you still have access to the old device, use it to sign in first.
1. Go to **Security info** at [aka.ms/mysecurityinfo](https://aka.ms/mysecurityinfo), select **Add sign-in method**, and choose **Passkey** or **Passkey in Microsoft Authenticator**.
1. Follow the prompts to create and save the new passkey.
1. Test sign-in with the new passkey.
1. After the new passkey works, remove old passkeys or devices that you no longer use.

> [!NOTE]
> If the passkey was saved to a synced credential manager, such as Microsoft Password Manager, Google Password Manager, or Apple iCloud Keychain, you might not need to create a new passkey. Verify the passkey is available before removing the old device.

If your IT admin doesn't allow self-service passkey setup, contact your admin or help desk for the approved recovery or registration process.

### Personal Microsoft accounts

- If the account uses only a one-time password code that refreshes every 30 seconds, the verification code entry is restored.
- If the account also uses passwordless sign-in, only the account name is restored and you must sign in again to complete setup.

### Third-party accounts (Amazon, Facebook, Gmail, etc.)

- These accounts typically use a one-time password code that refreshes every 30 seconds.
- The verification code entry is restored.

## Troubleshoot common issues

| Issue | Resolution |
|---|---|
| **"Sign in to add your account."** | Expected for work or school accounts after restore. Open the account and sign in again. |
| **Restore from backup isn't available.** | Verify backup was enabled on the old phone, you're using the same recovery account, and you're restoring to the same device type. |
| **No passkeys are available.** | Ensure the new phone has a screen lock enabled and that Bluetooth and internet connectivity are available for cross-device sign-in. |
| **A passkey can no longer be used.** | Create a new passkey and remove obsolete passkeys only after the new method is working. |

## Related content

- [Back up and recover account credentials with Microsoft Authenticator](concept-authentication-authenticator-app.md)
- [Register passkeys in Authenticator on Android and iOS devices](how-to-register-passkey-authenticator.md)
- [Sign in with a passkey in Microsoft Authenticator](how-to-sign-in-passkey-authenticator.md)
- [Support for passkey authentication with Microsoft Entra ID](how-to-support-authenticator-passkey.md)

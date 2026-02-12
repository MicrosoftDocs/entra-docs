---
title: How to Enable Synced Passkeys (FIDO2) in Microsoft Entra ID (Preview)
description: Learn how to enable synced passkeys (FIDO2) in Microsoft Entra ID.
ms.topic: how-to
ms.date: 10/31/2025
author: hanki71
ms.reviewer: kimhana
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable synced passkeys (FIDO2) in Microsoft Entra ID.
---

# How to enable synced passkeys (FIDO2) in Microsoft Entra ID (preview)

Passkeys (FIDO2) are a strong, phishing resistant alternative to passwords. With this preview, Microsoft Entra ID supports synced passkeys. Synced passkeys are stored in platform or with other passkey providers such as Apple iCloud Keychain, Google Password Manager, 1Password, or Bitwarden, and made available across a user’s devices. Synced passkeys simplify user onboarding and account recovery, which accelerates passwordless adoption for most organizations.

## What are synced versus device-bound passkeys?

Passkeys are FIDO2-based credentials that provide strong, phishing-resistant authentication. Microsoft Entra ID supports two main types of passkeys:

- Device-bound passkeys: The private key is created and stored on a single physical device and never leaves it. Examples:
  - Microsoft Authenticator (iOS)
  - Microsoft Authenticator (Android)
  - Security key
- Synced passkeys: The private key is stored in a passkey provider’s cloud (such as Apple iCloud Keychain, or Google Password Manager) and synced across the user’s devices. Examples: 
  - Apple iCloud Keychain
  - Google Password Manager

>[!NOTE]
>- Treat synced passkeys as phishing resistant credentials but with the same security posture as other unattested authenticators. For high assurance scenarios, enforce attestation and restrict registration to approved device-bound authenticators.

## Requirements

- Your organization must be enrolled in [Passkey profiles (preview)](how-to-authentication-passkey-profiles.md).
- Microsoft Entra ID tenant with permissions to manage Authentication methods. 
- The following table outlines the minimum device requirements for using synced passkeys. The columns represent the device platform where the user is signing in. 

  Passkey provider | Windows | macOS | iOS | Android
  -----------------|---------|-------|-----|--------
  Apple Passwords (also called iCloud Keychain) | N/A | Natively built in. macOS 13+| Natively built in. iOS 16+| N/A 
  Google Password Manager | Built in to Chrome | Built in to Chrome | Built in to Chrome. iOS 17+ | Natively built in (excluding Samsung devices). Android 9+
  Other passkey providers (such as 1Password, Bitwarden) | Check for browser extension | Check for browser extension | Check for app. iOS 17+ | Check for app. Android 14+ 


## Enable synced passkeys (preview)

1. Sign in to the Microsoft Entra admin center as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. Make sure you opted-in to the Passkey profiles (preview).
1. Browse to **Entra ID** > **Security** > **Authentication methods** > **Policies**.
1. Select **Passkey (FIDO2)** > **Configure**.
1. Add a profile or edit an existing profile.
1. Under **Target type**, select **Synced (preview)** and save the profile. 

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/enable-synced-passkeys.png" alt-text="Screenshot that shows how to enable synced passkeys."lightbox="media/how-to-authentication-passkey-profiles/enable-synced-passkeys.png":::

>[!Note] 
>If you disable synced passkeys for a given passkey profile, targeted users can't sign-in with a synced passkey even if they already registered one.

## Related content

[How to enable passkey (FIDO2) profiles in Microsoft Entra ID (preview)](how-to-authentication-passkey-profiles.md)

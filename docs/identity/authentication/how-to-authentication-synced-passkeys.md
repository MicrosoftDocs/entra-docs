---
title: How to Enable Synced Passkeys (FIDO2) in Microsoft Entra ID (Preview)
description: Learn how to enable synced passkeys (FIDO2) in Microsoft Entra ID.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/1/2025
ms.author: justinha
author: hanki71
manager: dougeby
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

>[!Notes]
>- Attested passkeys provide cryptographically verifiable device identity through FIDO Metadata Service (MDS). 
>  When attestation is enforced, relying parties can validate the authenticator model and apply policy decisions for certified devices.
>
>- Unattested passkeys, including synced passkeys and unattested device-bound passkeys, don't provide device provenance. 
>  AAGUID values can be spoofed unless attestation is enforced.
>
>- Treat synced passkeys as phishing resistant credentials but with the same security posture as other unattested authenticators. 
>  For high assurance scenarios, enforce attestation and restrict to approved device bound authenticators.

## When to use each type

We recommend enabling passkeys for all users in your organization. Any type of passkey is a significant security improvement over traditional MFA methods that can be phished, such as SMS codes, email OTPs, or even authenticator app codes. The choice of passkey type depends on your business needs and user scenarios:

- **For admins and highly privileged users**
  Use FIDO2 security keys for scenarios like bootstrapping a new device where the user is not yet signed in. Security keys provide strong device provenance and attestation support, making them ideal for high-assurance environments or regulated industries. Keep in mind that these keys require physical distribution and management, which can involve planning for training, helpdesk support, and recovery if they get lost.

  - **Alternative option for admins and highly privileged users**: Consider passkeys in Microsoft Authenticator as an alternative. This option integrates well with Microsoft Entra ID, and offers strong phishing resistance. However, current OS limitations—such as Android Work Profiles—may add usability challenges. Plan for user education and recovery processes similar to those for lost devices.

- **For information workers and frontline staff**
  Enable synced passkeys managed by providers like Apple iCloud Keychain or Google Password Manager. These passkeys deliver a seamless registration and sign-in experience across devices, making them a great fit for roles such as marketing, human resources (HR), finance, retail, or manufacturing. Synced passkeys are phishing-resistant and designed for convenience, helping reduce friction in large-scale deployments.

For more information about how other providers protect passkeys stored in their cloud with end-to-end encryption, see [About the security of passkeys](https://support.apple.com/en-us/102195) and [Manage passkeys in Chrome](https://support.google.com/chrome/answer/13168025). 

## Requirements

- Your organization must be enrolled in [Passkey profiles (preview)](how-to-authentication-passkey-profiles.md).
- Microsoft Entra ID tenant with permissions to manage Authentication methods. 
- The following table outlines the minimum device requirements for using synced passkeys. The columns represent the device platform where the user is signing in. 

  Passkey provider | Windows | macOS | iOS | Android
  -----------------|---------|-------|-----|--------
  Apple Passwords (also called iCloud Keychain) | N/A<sup>1</sup> | Natively built in. macOS 13+<sup>2</sup> | Natively built in. iOS 16+<sup>2</sup> | N/A<sup>1</sup> 
  Google Password Manager | Built in to Chrome<sup>2</sup> | Built in to Chrome<sup>2</sup> | Built in to Chrome. iOS 17+<sup>2</sup> | Natively built in (excluding Samsung devices). Android 9+<sup>2</sup>
  Other passkey providers (such as 1Password, Bitwarden) | Check for browser extension<sup>2</sup> | Check for browser extension<sup>2</sup> | Check for app. iOS 17+<sup>2</sup> | Check for app. Android 14+<sup>2</sup> 

  <sup>1</sup>Passkey provider is available on-device for same-device flows. 

  <sup>2</sup>Passkey provider is only available in cross-device flows. 

## Enable synced passkeys (preview)

1. Sign in to the Microsoft Entra admin center as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. Make sure you opted-in to the Passkey profiles (preview).
1. Browse to **Entra ID** > **Authentication methods** > **Authentication method policy**.
1. Under the method **Passkey (FIDO2)**, select **Configure**.
1. Add a profile or edit an existing profile.
1. Under **Target type**, select **Synced (preview)** and save the profile. 

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/enable-synced-passkeys.png" alt-text="Screenshot that shows how to enable synced passkeys."lightbox="media/how-to-authentication-passkey-profiles/enable-synced-passkeys.png":::

>[!Note] 
>If you disable synced passkeys for a given passkey profile, targeted users will no longer be able to sign-in with synced passkeys even if they have already registered one.

## Related content

[How to enable passkey (FIDO2) profiles in Microsoft Entra ID (preview)](how-to-authentication-passkey-profiles.md)
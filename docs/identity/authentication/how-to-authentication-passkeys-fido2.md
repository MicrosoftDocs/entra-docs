---
title: How to enable passkeys (FIDO2) in Microsoft Entra ID
description: Learn how to enable passkeys (FIDO2) in Microsoft Entra ID.
ms.topic: how-to
ms.date: 03/08/2026
author: hanki71
ms.reviewer: kimhana
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable passkeys (FIDO2) in Microsoft Entra ID.
---

# How to enable passkeys (FIDO2) in Microsoft Entra ID 

Passkeys (FIDO2) are a strong, phishing-resistant alternative to passwords. Microsoft Entra ID supports synced passkeys. Synced passkeys are stored on the platform or with other passkey providers, such as Apple iCloud Keychain, Google Password Manager, 1Password, or Bitwarden, and are made available across a user’s devices. Synced passkeys simplify user onboarding and account recovery, which accelerates passwordless adoption for most organizations.

## What are synced versus device-bound passkeys?

Passkeys are FIDO2-based credentials that provide strong, phishing-resistant authentication. Microsoft Entra ID supports two main types of passkeys:

- Device-bound passkeys: The private key is created and stored on a single physical device and never leaves it. Examples:
  - Microsoft Authenticator (iOS)
  - Microsoft Authenticator (Android)
  - Security key
- Synced passkeys: The private key is created by the hardware security module (HSM) and encrypted on the local device. This encrypted key is then synced and stored in the cloud passkey provider. Other devices authenticated with the passkey provider may then use the passkey. This may differ depending on the provider. Synced passkeys do not support attestation. Examples: 
  - [Apple iCloud Keychain](https://support.apple.com/en-us/102195)
  - [Google Password Manager](https://security.googleblog.com/2022/10/SecurityofPasskeysintheGooglePasswordManager.html)

> [!NOTE]
> Treat synced passkeys as phishing-resistant credentials but with the same security posture as other unattested authenticators. 

## Passkey (FIDO2) Authenticator Attestation GUID (AAGUID)

The FIDO2 specification requires each security key vendor to provide an Authenticator Attestation GUID (AAGUID) during registration. An AAGUID is a 128-bit identifier indicating the key type, such as the make and model. Passkey (FIDO2) providers on desktop and mobile devices are also expected to provide an AAGUID during registration.

>[!NOTE]
>The vendor must ensure that the AAGUID is identical across all substantially identical security keys or passkey (FIDO2) providers made by that vendor, and different (with high probability) from the AAGUIDs of all other types of security keys or passkey (FIDO2) providers. To ensure this, the AAGUID for a given security key model or passkey (FIDO2) provider should be randomly generated. For more information, see [Web Authentication: An API for accessing Public Key Credentials - Level 2 (w3.org)](https://w3c.github.io/webauthn/).

You can work with your security key vendor to determine the AAGUID of the passkey (FIDO2), or see [FIDO2 security keys eligible for attestation with Microsoft Entra ID](~/identity/authentication/concept-fido2-hardware-vendor.md#fido2-security-keys-eligible-for-attestation-with-microsoft-entra-id). If the passkey (FIDO2) is already registered, you can find the AAGUID by viewing the authentication method details of the passkey (FIDO2) for the user.

![Screenshot of how to view the AAGUID for a passkey.](media/how-to-enable-passkey-fido2/security-key-aaguid-details.png)

## Requirements

- Your organization must have [Passkey profiles](how-to-authentication-passkey-profiles.md) enabled.
- An account with at least [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator) permissions.
- The following table outlines the minimum device requirements for using synced passkeys. The columns represent the device platform where the user signs in.

  Passkey provider | Windows | macOS | iOS | Android
  -----------------|---------|-------|-----|--------
  Apple Passwords (also called iCloud Keychain) | N/A | Natively built in. macOS 13+ | Natively built in. iOS 16+ | N/A
  Google Password Manager | Built into Chrome | Built into Chrome | Built into Chrome. iOS 17+ | Natively built in (excluding Samsung devices). Android 9+
  Other passkey providers (such as 1Password, Bitwarden) | Check for a browser extension | Check for a browser extension | Check for an app. iOS 17+ | Check for an app. Android 14+


## Enable synced passkeys

1. Sign in to the Microsoft Entra admin center as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. Make sure passkey profiles are enabled.
1. Browse to **Entra ID** > **Security** > **Authentication methods** > **Policies**.
1. Select **Passkey (FIDO2)** > **Configure**.
1. Add a profile or edit an existing profile.
1. Under **Passkey type**, select **Synced**, and then save the profile.


> [!NOTE]
> If you disable synced passkeys for a given passkey profile, targeted users can't sign in with a synced passkey even if they already registered one.

## Delete a passkey (FIDO2)

To remove a passkey (FIDO2) associated with a user account, delete it from the user's authentication method.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) and search for the user whose passkey (FIDO2) needs to be removed.
1. Select **Authentication methods** > right-click **Passkey (device-bound)** and select **Delete**. 

## Enforce passkey (FIDO2) sign-in

To make users sign in with a passkey (FIDO2) when they access a sensitive resource, you can: 

- Use a built-in phishing-resistant authentication strength 

  Or
  
- Create a custom authentication strength

The following steps show how to create a custom authentication strength. It's a Conditional Access policy that allows passkey (FIDO2) sign-in for only a specific security key model or passkey (FIDO2) provider. For a list of FIDO2 providers, see [FIDO2 security keys eligible for attestation with Microsoft Entra ID](/entra/identity/authentication/concept-fido2-hardware-vendor).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Authentication strengths**.
1. Select **New authentication strength**.
1. Provide a **Name** for your new authentication strength.
1. Optionally provide a **Description**.
1. Select **Passkeys (FIDO2)**.
1. Optionally, if you want to restrict a specific AAGUID, select **Advanced options** > **Add AAGUID**. Enter the AAGUID, and select **Save**.
1. Choose **Next** and review the policy configuration.

## Related content

[How to enable passkey (FIDO2) profiles in Microsoft Entra ID](how-to-authentication-passkey-profiles.md)

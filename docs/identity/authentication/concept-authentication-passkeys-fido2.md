---
title: Passkeys (FIDO2) authentication method in Microsoft Entra ID
description: Learn about using passkey (FIDO2) authentication in Microsoft Entra ID to help improve and secure sign-in events
ms.topic: concept-article
ms.date: 11/10/2025
ms.reviewer: kimhana
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to understand how to use passkey (FIDO2) authentication in Microsoft Entra ID to improve and secure user sign-in events.
---

# Authentication methods in Microsoft Entra ID - passkeys (FIDO2) 

Remote phishing attacks are on the rise. These attacks aim to steal or relay identity proofs—such as passwords, SMS codes, or email one-time passcodes—without physical access to the user’s device. Attackers often use social engineering, credential harvesting, or downgrade techniques to bypass stronger protections like passkeys or security keys. With AI-driven attack toolkits, these threats are becoming more sophisticated and scalable.

Passkeys help prevent remote phishing by replacing phishable methods like passwords, SMS, and email codes. Built on **FIDO (Fast Identity Online) standards**, passkeys use origin-bound public key cryptography, ensuring credentials can't be replayed or shared with malicious actors. In addition to stronger security, passkeys (FIDO2) offer a frictionless sign-in experience by eliminating passwords, reducing prompts, and enabling fast, secure authentication across devices.

Passkeys (FIDO2) can also be used to sign in to Microsoft Entra ID or Microsoft Entra hybrid joined Windows 11 devices and get single-sign on to cloud and on-premises resources.

## What are passkeys?
Passkeys are phishing-resistant credentials that provide **strong authentication** and can serve as a **multifactor authentication (MFA)** method when combined with device biometrics or PIN. They also provide verifier impersonation resistance, which ensures an authenticator only releases secrets to the Relying Party (RP) the passkey was registered with and not an attacker pretending to be that RP. Passkeys (FIDO2) follow FIDO2 standards, using WebAuthn for browsers and CTAP for authenticator communication.

The following process is used when a user signs in to Microsoft Entra ID with a passkey (FIDO2):

1. The user initiates sign-in to Microsoft Entra ID.
1. The user selects a passkey:
   - Same device (stored on the device) 
   - Cross-device (via QR code) or a FIDO2 security key 
1. Microsoft Entra ID sends a challenge (nonce) to the authenticator. 
1. The authenticator locates the key pair using the hashed RP ID and credential ID. 
1. The user performs a biometric or PIN gesture to unlock the private key. 
1. The authenticator signs the challenge with the private key and returns the signature. 
1. Microsoft Entra ID verifies the signature using the public key and issues a token.

## Types of passkeys

- **Device-bound passkeys**: The private key is created and stored on a single physical device and never leaves it. Examples: 
  - Microsoft Authenticator 
  - FIDO2 Security keys 
- **Synced passkeys**: The private key is created by the hardware security module (HSM) and encrypted on the local device. This encrypted key is then synced and stored in the cloud passkey provider. Other devices authenticated with the passkey provider may then use the passkey. This may differ depending on the provider. Synced passkeys do not support attestation. Examples: 
  - [Apple iCloud Keychain](https://support.apple.com/en-us/102195)
  - [Google Password Manager](https://security.googleblog.com/2022/10/SecurityofPasskeysintheGooglePasswordManager.html)

Synced passkeys offer a seamless and convenient user experience where users can use a device’s native unlock mechanism like face, fingerprint or PIN to authenticate. Based on the learnings from hundreds of millions of consumer users of Microsoft accounts that have registered and are using synced passkeys, we have learned: 

- **99% of users successfully register synced passkeys** 
- Synced passkeys are **14x faster compared to password and a traditional MFA combination: 3 seconds instead of 69 seconds** 
- Users are **3x more successful signing-in with synced passkey than legacy authentication methods (95% vs 30%)** 
- Synced passkeys in Microsoft Entra ID bring MFA simplicity at scale for all enterprise users. They're a convenient and low-cost alternative to traditional MFA options like SMS and authenticator apps. 

For more information about how to deploy passkeys in your organization, see [How to enable synced passkeys](how-to-authentication-synced-passkeys.md). 

**Attestation** verifies the authenticity of the passkey provider or device during registration. When enforced:

- It provides cryptographically verifiable device identity through FIDO Metadata Service (MDS). When attestation is enforced, relying parties can validate the authenticator model and apply policy decisions for certified devices.
- Unattested passkeys, including synced passkeys and unattested device-bound passkeys, don't provide device provenance.

In Microsoft Entra ID:
- Attestation can be enforced at the **passkey profile** level.
- If attestation is enabled, only device-bound passkeys are allowed; synced passkeys are excluded.

## Choose the right passkey option 

FIDO2 security keys are recommended for highly regulated industries or users with elevated privileges. They provide strong security, but can increase costs for equipment, training, and helpdesk support—especially when users lose their physical keys and need account recovery. Passkeys in the Microsoft Authenticator app are another option for these user groups. 

For most users—those outside highly regulated environments or without access to sensitive systems—**synced passkeys** offer a convenient, low-cost alternative to traditional MFA. Apple and Google have implemented advanced protections for passkeys stored in their clouds. 

Regardless of type—device-bound or synced—passkeys represent a significant security upgrade over phishable MFA methods. 

For more details, see [Get started with phishing-resistant MFA deployment in Microsoft Entra ID](how-to-plan-prerequisites-phishing-resistant-passwordless-authentication.md). 

## Related content

- [Enable passkeys (FIDO2) in Microsoft Entra ID](how-to-enable-passkey-fido2.md)
- [Enable passkey profiles in Microsoft Entra ID](how-to-authentication-passkey-profiles.md)
- [Enable synced passkeys in Microsoft Entra ID](how-to-authentication-synced-passkeys.md)
- [Passkeys in Authenticator App](concept-authentication-authenticator-app.md#passkey-sign-in)
- [Attestation requirements](concept-fido2-hardware-vendor.md#attestation-requirements)

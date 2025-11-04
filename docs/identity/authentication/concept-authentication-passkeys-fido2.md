---
title: Passkeys (FIDO2) authentication method in Microsoft Entra ID
description: Learn about using passkey (FIDO2) authentication in Microsoft Entra ID to help improve and secure sign-in events
ms.service: entra-id
ms.subservice: authentication
ms.topic: concept-article
ms.date: 10/31/2025
ms.author: justinha
author: justinha
ms.reviewer: kimhana
manager: dougeby
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to understand how to use passkey (FIDO2) authentication in Microsoft Entra ID to improve and secure user sign-in events.
---

# Authentication methods in Microsoft Entra ID - passkeys (FIDO2) 

Passkeys (FIDO2) represent a modern, phishing-resistant authentication method that eliminates the need for passwords while providing enhanced security and improved user experience. Built on open standards from the FIDO Alliance and WebAuthn specification, passkeys use public key cryptography to create strong, unique credentials that are bound to specific websites and cannot be reused across different services. 

Microsoft Entra ID supports both device-bound passkeys, which are stored locally on hardware security keys or platform authenticators, and synced passkeys (preview), which are synchronized across devices through cloud-based passkey providers like iCloud Keychain and Google Password Manager. This dual approach allows organizations to implement passwordless authentication strategies that meet diverse security requirements while accommodating different user preferences and device ecosystems.

## Device-bound passkeys

Users can register a passkey (FIDO2) security key and choose it as their primary sign-in method. With a hardware device that handles the authentication, the security of an account is increased as there's no password that can be exposed or guessed. Currently in preview, an Authentication Administrator can also [provision a FIDO2 security](https://aka.ms/passkeyprovision) on behalf of a user by using Microsoft Graph API and a custom client. Provisioning on behalf of users is currently limited to security keys at this time. 

The FIDO (Fast IDentity Online) Alliance helps to promote open authentication standards and reduce the use of passwords as a form of authentication. FIDO2 is the latest standard that incorporates the web authentication (WebAuthn) standard. FIDO allows organizations to apply the WebAuthn standard by using an external security key, or a platform key built into a device, to sign in without a username or password.

FIDO2 security keys are an unphishable standards-based passwordless authentication method that can come in any form factor. They're commonly USB devices, but they can also use Bluetooth or near-field communication (NFC). Passkeys (FIDO2) are based on the same WebAuthn standard and can be saved in Authenticator, or on mobile devices, tablets, or computers.

FIDO2 security keys can be used to sign in to their Microsoft Entra ID or Microsoft Entra hybrid joined Windows 10 devices and get single-sign on to their cloud and on-premises resources. Users can also sign in to supported browsers. FIDO2 security keys are a great option for enterprises who are very security sensitive or have scenarios or employees who aren't willing or able to use their phone as a second factor.

For more information about passkey (FIDO2) support, see [Support for passkey (FIDO2) authentication with Microsoft Entra ID](fido2-compatibility.md). For developer best practices, see [Support FIDO2 auth in the applications they develop](~/identity-platform/support-fido2-authentication.md).

:::image type="content" border="true" source="./media/concept-authentication-passwordless/concept-web-sign-in-security-key.png" alt-text="Screenshot showing how to sign in to Microsoft Edge with a security key."lightbox="media/how-to-enable-authenticator-passkey/optional-settings.png":::


The following process is used when a user signs in with a FIDO2 security key:

:::image type="content" border="true" source="./media/concept-authentication-passwordless/fido2-security-key-flow.png" alt-text="Diagram that outlines the steps involved for user sign-in with a FIDO2 security key."lightbox="media/how-to-enable-authenticator-passkey/optional-settings.png":::

1. The user plugs the FIDO2 security key into their computer.
2. Windows detects the FIDO2 security key.
3. Windows sends an authentication request.
4. Microsoft Entra ID sends back a nonce.
5. The user completes their gesture to unlock the private key stored in the FIDO2 security key's secure enclave.
6. The FIDO2 security key signs the nonce with the private key.
7. The primary refresh token (PRT) token request with signed nonce is sent to Microsoft Entra ID.
8. Microsoft Entra ID verifies the signed nonce using the FIDO2 public key.
9. Microsoft Entra ID returns PRT to enable access to on-premises resources.

For a list of FIDO2 security key providers, see [Become a Microsoft-compatible FIDO2 security key vendor](concept-fido2-hardware-vendor.md). To get started with FIDO2 security keys, see [Enable passwordless sign using FIDO2 security keys](howto-authentication-passwordless-security-key.md).

## Synced passkeys (preview)

Synced passkeys represent a newer, more user-centric approach to authentication that removes the password entirely, works across devices by using services like iCloud Keychain, or Google Password Manager. Synced passkeys offer a seamless experience. Users authenticate with biometrics or device PINs. They don't need to remember or enter passwords or codes. Synced passkeys are built on the WebAuthn standard, where users verify their identity locally by using biometrics or device PINs. WebAuthn is supported across all major operating systems and browsers, including Windows, macOS, iOS, Android, Chrome, Safari, and Edge, which removes a key technical barrier and paves the way for broad, cross-platform adoption at scale. 

Admins can configure security groups for passkey authentication. Instead of a single tenant-wide setting, admins can customize requirements, such as attestation, passkey type (device-bound or synced), or a specific provider and model for their users, and apply them to different security groups in the enterprise. Enrollment campaigns can begin quickly.  

## Unsupported scenarios

We recommend no more than 20 sets of keys for each passwordless method for any user account. As more keys are added, the user object size increases, and you could notice degradation for some operations. In that case, you should remove unnecessary keys. 

## Related content

- [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/)
- [Plan a Windows Hello for Business deployment](/windows/security/identity-protection/hello-for-business/deploy/)
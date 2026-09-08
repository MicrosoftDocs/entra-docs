---
title: Microsoft Entra authentication overview
description: Authentication is the process of verifying identity before granting access. Learn about the authentication methods available in Microsoft Entra ID.
ms.reviewer: tilarso
ms.service: entra-id
ms.topic: concept-article
ms.custom: msecd-doc-authoring-108
ms.date: 04/30/2026

#customer intent: As an identity administrator, I want to understand the authentication methods available in Microsoft Entra ID so that I can choose the right methods for my organization's security and user experience requirements.

---

# Microsoft Entra authentication overview

Authentication is a security process that verifies a user's identity before granting access to apps, services, devices, or networks.

## Authentication methods supported by Microsoft Entra ID

The following table outlines when an authentication method can be used for primary authentication (first factor), secondary authentication with Microsoft Entra multifactor authentication (MFA), self-service password reset (SSPR), or account recovery.

| Method | Primary authentication | Secondary authentication | SSPR / Account recovery |
|---|---|---|---|
| [Authenticator Lite](how-to-mfa-authenticator-lite.md) | No | MFA | No |
| [Certificate-based authentication](concept-certificate-based-authentication.md) | Yes | MFA | No |
| [Email OTP](concept-sspr-howitworks.md#authentication-methods) | No | SSPR and sign-in<sup>2</sup> | SSPR |
| [External MFA](how-to-authentication-external-method-manage.md) | No | MFA | No |
| [Hardware OATH tokens (preview)](concept-authentication-oath-tokens.md#hardware-oath-tokens-preview) | No | MFA | SSPR |
| [Microsoft Authenticator passwordless](concept-authentication-authenticator-app.md#passwordless-sign-in-via-notifications) | Yes | No | No |
| [Microsoft Authenticator push notifications](concept-authentication-authenticator-app.md#mfa-via-notifications-through-mobile-app) | Yes | MFA | SSPR |
| [Passkey (FIDO2)](concept-authentication-passkeys-fido2.md) | Yes | MFA | No |
| [Passkey in Microsoft Authenticator](concept-authentication-authenticator-app.md) | Yes | MFA | No |
| Password | Yes | No | No |
| [Platform Credential for macOS](concept-authentication-platform-credential-for-macos.md) | Yes | MFA | No |
| [QR code](concept-authentication-qr-code.md) | Yes | No | No |
| [SMS sign-in](howto-authentication-sms-signin.md) | Yes | MFA | SSPR |
| [Software OATH tokens](concept-authentication-oath-tokens.md#software-oath-tokens) | No | MFA | SSPR |
| [Synced passkey](concept-authentication-passkeys-fido2.md) | Yes | MFA | No |
| [Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md) | Yes | MFA | No |
| [Verified ID](concept-authentication-verified-id.md)<sup>3</sup> | No | No | Account recovery |
| [Voice call](concept-authentication-phone-options.md) | No | MFA | SSPR |
| [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview) | Yes | MFA<sup>1</sup> | No |

<sup>1</sup>Windows Hello for Business can serve as a step-up MFA credential if a user is enabled for passkey (FIDO2) and has a passkey registered.

<sup>2</sup>Email OTP is available for tenant members for [self-service password reset (SSPR)](concept-sspr-howitworks.md#authentication-methods). You can also configure it for [sign-in by guest users](/entra/external-id/one-time-passcode).

<sup>3</sup>Verified ID is an identity verification capability, not a traditional authentication method. It provides proof of identity for account recovery but can't be used for sign-in, MFA, or SSPR.

## Phishing-resistant authentication methods

While traditional MFA with SMS, email OTP, or authenticator apps significantly improves security over password-only systems, these options introduce friction — requiring additional steps for users, like entering codes, approving push notifications, or using authenticator apps. Moreover, these MFA options are prone to remote phishing attacks. In a remote phishing attack, attackers use social engineering and AI-driven tools to steal identity credentials — like passwords or one-time codes — without physical access to a user's device.

Microsoft recommends using phishing-resistant authentication methods such as Windows Hello for Business, passkeys (FIDO2) and FIDO2 security keys, or certificate-based authentication (CBA) because they provide the most secure sign-in experience.

The following phishing-resistant authentication methods are available in Microsoft Entra ID:

- Windows Hello for Business
- Platform Credential for macOS
- Synced passkeys (FIDO2)
- FIDO2 security keys
- Passkeys in Microsoft Authenticator
- Certificate-based authentication (CBA)

## Verified ID identity verification

Verified ID is an identity verification capability in Microsoft Entra ID — not a traditional authentication method. It can't be used to satisfy authentication requirements like sign-in, MFA, or SSPR. Instead, Verified ID provides cryptographic proof of a user's verified identity for scenarios where trust must be re-established, such as account recovery when all authentication methods are lost.

Identity verification profiles control which users can participate in Verified ID flows, which provider performs verification, and how identity claims are validated. Admins configure profiles through the Account Recovery setup wizard in the Microsoft Entra admin center, and the Verified ID policy page provides visibility into profile assignments and global exclusions.

For more information, see [Verified ID identity verification overview](concept-authentication-verified-id.md).

## High-assurance account recovery

Account recovery is the process of helping users who have lost all their credentials and can no longer access their account. Traditionally, a user calls the help desk, answers questions to verify their identity, and the help desk resets their credentials. Microsoft Entra ID now supports government-issued ID verification with biometric matching for high-assurance account recovery — removing the need for helpdesk intervention and eliminating social engineering risks.

Organizations can choose from leading identity verification providers (IDV) through the [Microsoft Security Store](https://securitystore.microsoft.com/). These partners offer coverage across 192 countries/regions and remote verification for most government-issued ID documents, including driver's licenses and passports. Microsoft Entra Verified ID Face Check, powered by Azure AI services, verifies proof of presence by matching a user's real-time selfie to the photo from their identity document. Only the match result is shared — no sensitive identity data — which preserves user privacy while providing strong identity assurance.

## Related content

- [Passkeys (FIDO2)](concept-authentication-passkeys-fido2.md)
- [Verified ID identity verification overview](concept-authentication-verified-id.md)
- [Account recovery overview](concept-account-recovery-overview.md)
- [Enable and configure account recovery](how-to-account-recovery-enable.md)
- [Get started with phishing-resistant MFA deployment in Microsoft Entra ID](how-to-plan-prerequisites-phishing-resistant-passwordless-authentication.md)

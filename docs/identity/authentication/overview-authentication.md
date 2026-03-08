---
title: Microsoft Entra authentication overview
description: Learn about the authentication methods and security features for user sign-ins with Microsoft Entra ID.
ms.topic: overview
ms.date: 03/08/2026
ms.reviewer: sranjit

# Customer intent: As a Microsoft Entra administrator, I want to understand how Microsoft Entra ID makes it convenient to improve user sign-in security.
---
# What is Microsoft Entra authentication?

Authentication is the process of verifying a person's identity before granting access to a resource, application, service, device, or network. It's how a system makes sure **users are who they say they are** when they try to sign in.

## Authentication methods supported by Microsoft Entra ID 

The following table outlines when an authentication method can be used for primary authentication (first factor), secondary authentication with Microsoft Entra multifactor authentication (MFA), and self-service password reset (SSPR).   


| Method                         | Primary authentication | Secondary authentication  |
|--------------------------------|:----------------------:|:-------------------------:|
| [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview) | Yes   | MFA<sup>1</sup>  |
| [Platform Credential for macOS](/entra/identity/authentication/concept-authentication-platform-credential-for-macos) | Yes               | MFA |
| [Passkey (FIDO2)](concept-authentication-passkeys-fido2.md)  | Yes                    | MFA             |
| [Passkey in Microsoft Authenticator](concept-authentication-authenticator-app.md)| Yes                 | MFA           |
| [Synced passkey](concept-authentication-passkeys-fido2.md)| Yes                 | MFA           |
| [Certificate-based authentication](concept-certificate-based-authentication.md)| Yes            | MFA                       |
| [Microsoft Authenticator passwordless](concept-authentication-authenticator-app.md#passwordless-sign-in-via-notifications)| Yes | No |
| [Microsoft Authenticator push notifications](concept-authentication-authenticator-app.md#mfa-via-notifications-through-mobile-app) |Yes  | MFA and SSPR |
| [Authenticator Lite](/entra/identity/authentication/how-to-mfa-authenticator-lite)            | No                     | MFA     |
| [Hardware OATH tokens (preview)](concept-authentication-oath-tokens.md#hardware-oath-tokens-preview) | No            | MFA and SSPR |
| [Software OATH tokens](concept-authentication-oath-tokens.md#software-oath-tokens)          | No                  | MFA and SSPR   |
| [External authentication methods (preview)](/entra/identity/authentication/how-to-authentication-external-method-manage)| No    | MFA  |
| [Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md)    | Yes                    | MFA                       |
| [Short Message Service (SMS) sign-in](howto-authentication-sms-signin.md)         | Yes              | MFA and SSPR   |
| [Voice call](concept-authentication-phone-options.md)                   | No                     | MFA and SSPR              |
| [QR code](concept-authentication-qr-code.md)                       | Yes                    | No                    |
| [Email OTP](concept-sspr-howitworks.md#authentication-methods)  | No              | SSPR and sign-in<sup>2</sup>           |
| Password                       | Yes                    | No                        |

<sup>1</sup>Windows Hello for Business can serve as a step-up MFA credential if a user is enabled for passkey (FIDO2) and has a passkey registered.

<sup>2</sup>Email OTP is available for tenant members for [self-service password reset (SSPR)](concept-sspr-howitworks.md#authentication-methods). You can also configure it for [sign-in by guest users](/entra/external-id/one-time-passcode).

## Phishing-resistant authentication methods   

While traditional MFA with SMS, email OTP, or authenticator apps significantly improves security over password-only systems, these options introduce friction—requiring additional steps for users, like entering codes, approving push notifications, or using authenticator apps. Moreover, these MFA options are prone to remote phishing attacks. In a remote phishing attack, attackers use social engineering and AI-driven tools to steal identity credentials—like passwords or one-time codes—without physical access to a user's device.   

Microsoft recommends using phishing-resistant authentication methods such as Windows Hello for Business, passkeys (FIDO2) and FIDO2 security keys, or certificate-based authentication (CBA) because they provide the most secure sign-in experience.  

The following phishing-resistant authentication methods are available in Microsoft Entra ID.  

- Windows Hello for Business
- Platform Credential for macOS
- Synced passkeys (FIDO2) 
- FIDO2 security keys
- Passkeys in Microsoft Authenticator
- Certificate-based authentication (CBA)  

## High-assurance account recovery

Account recovery is the process of helping users who lost all their credentials and can no longer access their account. Traditionally, a user calls the help desk, answers questions to verify their identity, and the help desk resets their credentials. Microsoft Entra ID now supports government-issued ID verification with AI-powered biometric matching for high-assurance account recovery.

Organizations can choose from the leading identity verification providers (IDV) through the [Microsoft Security Store](https://securitystore.microsoft.com/): Idemia, Lexis Nexis, and Au10tix. These partners offer coverage across 192 countries/regions and remote verification for most government-issued ID documents, including driver's licenses and passports. Microsoft Entra Verified ID Face Check, powered by Azure AI services, adds a critical layer of trust by matching a user’s real-time selfie to the photo from their identity document. By sharing only the match results and not any sensitive identity data, Face Check improves user privacy while allowing enterprises to verify that the person claiming an identity is who they claim to be. 

Once enabled, this capability provides a natively integrated end-to-end flow for users to securely regain access to their accounts. For more information, see [Overview of Microsoft Entra ID account recovery](concept-account-recovery-overview.md). 

## Related content

* [Passkeys (FIDO2)](concept-authentication-passkeys-fido2.md)
* [Get started with phishing-resistant MFA deployment in Microsoft Entra ID](how-to-plan-prerequisites-phishing-resistant-passwordless-authentication.md)

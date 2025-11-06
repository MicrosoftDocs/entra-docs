---
title: Authentication and verification methods in Microsoft Entra ID
description: Learn about the different authentication methods and features available in Microsoft Entra ID that help improve and secure sign-in events
ms.service: entra-id
ms.subservice: authentication
ms.topic: concept-article
ms.date: 11/04/2025
ms.author: justinha
author: sipower
ms.reviewer: jupetter
manager: dougeby
ms.custom: sfi-image-nochange
# As an identity administrator, I want to understand what authentication options are available in Microsoft Entra ID and how or why I can use them to improve and secure user sign-in events. Doc should be used as a pre-sales or for pre-intent rather than detailed doc for deployment use. 
---
# Authentication and verification methods in Microsoft Entra ID

In today’s threat landscape, a user's sign-in methods are as critical as the systems they access. Credential-based attacks, especially remote phishing attacks, continue to target password-based accounts. Microsoft Entra ID multifactor authentication (MFA) adds another layer of security for password-based accounts. Sign-in methods that can perform MFA have varying degrees of security. Some methods are phishable, and others are remote phishing resistant.

This article explains the difference between phishing-resistant credentials and phishable credentials, and how authentication methods can better protect Microsoft Entra ID accounts.

## Phishing-resistant methods versus phishable methods

Remote phishing attacks remain one of the most common types of attacks. Remote phishing is where attackers use social engineering and AI-driven tools to steal identity credentials—like passwords or one-time codes—without physical access to a user's device. 

To better protect users from these attacks, it's recommended to use phishing-resistant authentication methods. Unlike traditional methods—such as passwords or one-time codes—that can be intercepted or socially engineered out of users, phishing-resistant authentication uses cryptographic credentials alongside a face, fingerprint, or PIN. These credentials can’t be reused, replayed, or stolen through deceptive means.

Microsoft recommends using phishing-resistant authentication methods such as Windows Hello for Business, passkeys (FIDO2) and FIDO2 security keys, or certificate-based authentication (CBA) because they provide the most secure sign-in experience. Although a user can sign-in by using other common methods such as a password, voice call, SMS, these methods should be replaced with more secure authentication methods.

The following table lists phishing-resistant and phishable authentication methods in Microsoft Entra ID.

Strength | Methods
---------|--------
Phishing-resistant | Windows Hello for Business, Platform Credential for macOS, synced passkeys (FIDO2), FIDO2 security keys, passkey in Microsoft Authenticator, certificate-based authentication (CBA)
Phishable | Password, SMS/Voice call, Authenticator push notifications, Authenticator passwordless sign-in, Temporary Access Pass (TAP), software-based and hardware-based OATH tokens

## Using multifactor authentication

You should register users for both MFA and self service password reset (SSPR). To simplify this, we recommend you [enable combined security information registration](howto-registration-mfa-sspr-combined.md). 

For resiliency, we recommend that you require users to register multiple authentication methods, and prioritize phishing-resistant credentials. When one method isn't available for a user during sign-in or SSPR, they can choose another method.

When you deploy phishing-resistant methods, plan how to onboard new user accounts and how to bootstrap current users. For more information, see [plan and deploy phishing-resistant MFA](how-to-deploy-phishing-resistant-passwordless-authentication.md).

## Primary and secondary factors for sign-in

In Microsoft Entra ID, administrators can configure authentication methods available for their users to prove their identity when they access an application, device, or service. Each method offers a different level of security and user experience. Organizations can require one or more authentication methods to ensure only authorized users gain access.

Some authentication methods can be used as the primary factor when you sign in to an application or device, such as using a FIDO2 security key or a password. Other authentication methods are only available as a secondary factor when you use Microsoft Entra multifactor authentication or SSPR.

The following table outlines when an authentication method can be used during a sign-in event.


| Method                         | Primary authentication | Secondary authentication  |
|--------------------------------|:----------------------:|:-------------------------:|
| [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview) | Yes   | MFA<sup>1</sup>  |
| Platform Credential for macOS   | Yes               | MFA |
| [FIDO2 security key](concept-authentication-passkeys-fido2.md)  | Yes                    | MFA             |
| [Microsoft Authenticator passkey](concept-authentication-authenticator-app.md)| Yes                 | MFA           |
| [Synced passkey (preview)](concept-authentication-passkeys-fido2.md)| Yes                 | MFA           |
| [Certificate-based authentication](concept-certificate-based-authentication.md)| Yes            | MFA                       |
| [Microsoft Authenticator passwordless](concept-authentication-authenticator-app.md#passwordless-sign-in-via-notifications)| Yes | No<sup>2</sup>|
| [Microsoft Authenticator push notifications](concept-authentication-authenticator-app.md#mfa-via-notifications-through-mobile-app) |Yes  | MFA and SSPR |
| [Authenticator Lite](/entra/identity/authentication/how-to-mfa-authenticator-lite)            | No                     | MFA     |
| [Hardware OATH tokens (preview)](concept-authentication-oath-tokens.md#hardware-oath-tokens-preview) | No            | MFA and SSPR |
| [Software OATH tokens](concept-authentication-oath-tokens.md#software-oath-tokens)          | No                  | MFA and SSPR   |
| [External authentication methods (preview)](/entra/identity/authentication/how-to-authentication-external-method-manage)| No    | MFA  |
| [Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md)    | Yes                    | MFA                       |
| [Short Message Service (SMS) sign-in](howto-authentication-sms-signin.md)         | Yes              | MFA and SSPR   |
| [Voice call](concept-authentication-phone-options.md)<sup>3</sup>                    | No                     | MFA and SSPR              |
| [QR code (preview)](concept-authentication-qr-code.md)                       | Yes                    | No                    |
| Password                       | Yes                    | No                        |

<sup>1</sup>Windows Hello for Business can serve as a step-up MFA credential if it's used in FIDO2 authentication. Users need to be registered for passkey (FIDO2).

<sup>2</sup>Passwordless sign-in can be used for secondary authentication only if [CBA is used for primary authentication](~/identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#mfa-with-single-factor-cba).

<sup>3</sup>Alternate phone methods can only be used for MFA.

These other verification methods can be used in certain scenarios:

* [App passwords](howto-mfa-app-passwords.md) - used for old applications that don't support modern authentication and can be configured for per-user Microsoft Entra multifactor authentication.
* [Security questions](concept-authentication-security-questions.md) - only used for SSPR
* [Email address](concept-sspr-howitworks.md#authentication-methods) - only used for SSPR

## Related content

- [Plan a phishing-resistant MFA deployment in Microsoft Entra ID](how-to-deploy-phishing-resistant-passwordless-authentication.md)
- [How Microsoft Entra multifactor authentication works](concept-mfa-howitworks.md)
- [How Microsoft Entra self-service password reset works](concept-sspr-howitworks.md)
- [Microsoft Graph REST API authentication methods](/graph/api/resources/authenticationmethods-overview)




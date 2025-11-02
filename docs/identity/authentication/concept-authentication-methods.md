---
title: Authentication methods and features
description: Learn about the different authentication methods and features available in Microsoft Entra ID that help improve and secure sign-in events
ms.service: entra-id
ms.subservice: authentication
ms.topic: concept-article
ms.date: 11/02/2025
ms.author: justinha
author: sipower
ms.reviewer: jupetter
manager: dougeby
ms.custom: sfi-image-nochange
# As an identity administrator, I want to understand what authentication options are available in Microsoft Entra ID and how or why I can use them to improve and secure user sign-in events. Doc should be used as a pre-sales or for pre-intent rather than detailed doc for deployment use. 
---
# What authentication and verification methods are available in Microsoft Entra ID?

In today’s threat landscape, a user's sign-in methods are as critical as the systems they access. Credential-based attacks, especially remote phishing attacks, continue to target password-based accounts. Microsoft Entra ID multifactor authentication (MFA) adds another layer of security for password-based accounts. Sign-in methods that can perform MFA have varying degrees of security. Some methods are phishable, and others are remote phishing resistant.

This article explains the difference between phishing-resistant credentials and phishable credentials, and how authentication methods can better protect Microsoft Entra ID accounts.

## Phishing-resistant methods versus phishable methods

Remote phishing attacks remain one of the most common types of attacks. Remote phishing is where attackers use social engineering and AI-driven tools to steal identity credentials—like passwords or one-time codes—without physical access to a user's device. 

To better protect users from these attacks, it's recommended to use phishing-resistant authentication methods. Unlike traditional methods—such as passwords or one-time codes—that can be intercepted or socially engineered out of users, phishing-resistant authentication uses cryptographic credentials alongside a face, fingerprint, or PIN. These credentials can’t be reused, replayed, or stolen through deceptive means.

Microsoft recommends using phishing-resistant authentication methods such as Windows Hello for Business, passkeys (FIDO2) and FIDO2 security keys, or certificate-based authentication (CBA) because they provide the most secure sign-in experience. Although a user can sign-in by using other common methods such as a password , voice call, SMS, these should be replaced with more secure authentication methods.
In the table below you will find the credentials types available in Entra ID, and whether they are phishable.

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
| [FIDO2 security key](concept-authentication-passkeys-fido2.md)                | Yes                    | MFA                       |
| [Microsoft Authenticator passkey](concept-authentication-authenticator-app.md)| Yes                 | MFA           |
| [Synced passkey (preview)](concept-authentication-passkeys-fido2.md#synced-passkeys-preview)| Yes                 | MFA           |
| [Certificate-based authentication](concept-certificate-based-authentication.md)| Yes            | MFA                       |
| [Microsoft Authenticator passwordless](concept-authentication-authenticator-app.md) | Yes                     | No<sup>2</sup>   |
| [Microsoft Authenticator push notifications](concept-authentication-authenticator-app.md) | Yes                     | MFA and SSPR   |
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

## Account recovery

Account recovery is a critical component of your organization’s security posture. The recovery process should be as strong as user authentication to prevent unauthorized access and preserve trust. For users protected by phishing-resistant authentication, such as passkeys (FIDO2) or certificate-based authentication, account recovery should be as robust as the initial onboarding process. This means you should perform strong identity verification and validation of account ownership as part of the recovery process.

In Microsoft Entra ID, we offer an integrated and seamless process for identity verification. Organizations can configure trusted partners to verify a user’s identity, typically by presenting government-issued identification. After other validation steps, users can securely replace lost credentials, such as by registering a new passkey, to maintain account security throughout the recovery process. For more information, see [Microsoft Entra ID account recovery](concept-self-service-account-recovery.md). 

For users who rely on passwords and do not have access to phishing-resistant methods, [self-service password reset (SSPR)](concept-sspr-howitworks.md) remains available. To enhance security for these users, especially those with multi-factor authentication (MFA) capability, we recommend requiring at least two distinct authentication methods to complete password reset. This layered approach reduces the risk of account compromise during recovery.

## Usable and nonusable methods

Administrators can view user authentication methods in the Microsoft Entra admin center. Usable methods are listed first, followed by nonusable methods. 

Each authentication method can become nonusable for different reasons. For example, a Temporary Access Pass might expire, or a FIDO2 security key might fail attestation. The portal gets updated to explain why the method isn't usable. 

Authentication methods that are no longer available due to **Require re-register multifactor authentication** also appear here.

## Related content

To get started, see the [tutorial for self-service password reset (SSPR)][tutorial-sspr] and [Microsoft Entra multifactor authentication][tutorial-azure-mfa].

To learn more about SSPR concepts, see [How Microsoft Entra self-service password reset works][concept-sspr].

To learn more about MFA concepts, see [How Microsoft Entra multifactor authentication works][concept-mfa].

Learn more about configuring authentication methods using the [Microsoft Graph REST API](/graph/api/resources/authenticationmethods-overview).

To review what authentication methods are in use, see [Microsoft Entra multifactor authentication authentication method analysis with PowerShell](https://github.com/Azure-Samples/azure-mfa-authentication-method-analysis).



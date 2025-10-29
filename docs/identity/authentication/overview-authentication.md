---
title: Microsoft Entra Authentication Overview
description: Learn about the authentication methods and security features for user sign-ins with Microsoft Entra ID.

ms.service: entra-id
ms.subservice: authentication
ms.topic: overview
ms.date: 10/28/2025

ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: sranjit

# Customer intent: As a Microsoft Entra administrator, I want to understand how Microsoft Entra ID makes it convenient to improve user sign-in security.
---
# What is Microsoft Entra authentication?

Microsoft Entra authentication is part of Microsoft Entra ID, which is the identity and access management service in the Microsoft Entra suite. Microsoft Entra authentication verifies user credentials when signing in to devices, apps, or services.
Key components include:

- Remote phishing-resistant multifactor authentication (MFA)
- High assurance account recovery
- Passwordless MFA and other verification methods
- Conditional Access authentication strength policies
- Hybrid integration
- Self-service password reset (SSPR)

Microsoft Entra authentication is a cornerstone of [Zero Trust security](/security/zero-trust/zero-trust-overview), where every access request is verified regardless of location or device. It helps administrators conveniently adopt phishing-resistant MFA methods like passkeys (FIDO2) and improve user sign-in security. Admins can use Microsoft Entra admin center or Microsoft Graph APIs to manage sign-in experiences for users. 

The next sections cover recent improvements for Microsoft Entra authentication.

## Passkeys (FIDO2) and phishing-resistant MFA

As phishing attacks increase, the estimated financial impact reaches billions of dollars.
Traditional multifactor (MFA) methods like one-time passwords (OTPs) and authenticator apps are cumbersome, which leads to user resistance and vulnerability to impersonation.

Passkeys (FIDO2) prevent credential phishing and impersonation by binding credentials to devices, or syncing across devices securely. 
They're based on FIDO (Fast Identity Online) standards and origin-bound public cryptography. 
Users with passkeys also see faster sign-in and a higher success rate. 

In Microsoft Entra ID, device-bound passkeys (FIDO2) are in General Availability and synced passkeys are in preview. 

Passkey type | Description | Examples
-------------|-------------|---------
Device-bound passkeys | The private key is created and stored on a single physical device and never leaves it | Microsoft Authenticator<br>FIDO2 security keys
Synced passkeys (preview) | The private key is stored in a passkey provider’s cloud and synced across devices signed-in to the same passkey provider account. Synced passkeys don't support attestation. | Apple iCloud Keychain<br>Google Password Manager  

Attestation verifies the authenticity of the passkey provider or device during registration. When enforced: 

- Attestation confirms the credential originates from a trusted authenticator
- Attestation helps prevent spoofed Authenticator Attestation GUIDs (AAGUIDs) that could misrepresent device type

In Microsoft Entra ID: 

- Attestation can be enforced at the passkey profile level. 
- If attestation is enabled, only device-bound passkeys are allowed; synced passkeys are excluded. 

For more information, see [Passkeys (FIDO2)](concept-authentication-passkeys-fido2.md).

## High assurance account recovery (preview)
Account recovery is a critical component of your organization’s security posture. The recovery process should be as strong as user authentication to prevent unauthorized access and preserve trust. For users protected by phishing-resistant authentication, such as passkeys (FIDO2) or certificate-based authentication, account recovery should be as robust as the initial onboarding process. This means you should perform strong identity verification and validation of account ownership as part of the recovery process. 

Microsoft Entra ID offers an integrated and seamless process for identity verification. Organizations can configure trusted partners to verify a user’s identity, typically by presenting government-issued identification. After other validation steps, users can securely replace lost credentials, such as by registering a new passkey, to maintain account security throughout the recovery process. 

Account recovery integrates biometric ID verification across 192 countries and supports billing with trusted identity verification providers to simplify integration. For more information about Microsoft Entra ID Account recovery, see [Account Recovery (preview)](concept-self-service-account-recovery.md).  

For users who rely on passwords and don't have access to phishing-resistant methods, self-service password reset (SSPR) remains available. To improve security for these users, especially those with multifactor authentication (MFA) capability, you should require at least two distinct authentication methods to complete password reset. This layered approach reduces the risk of account compromise during recovery. 

## Phishing-resistant MFA deployment guidance

Successful rollout strategies include forming user cohorts based on device and OS usage, prioritizing administrators, and starting with easier cohorts to build momentum.
Emphasis on strong helpdesk support, proactive exception management, geographic considerations, and targeted guidance for new hires ensures smooth transitions.
Account recovery security is enhanced by adopting robust identity proofing solutions alongside phishing-resistant credentials.

We've improved our phishing-resistant MFA deployment guide to emphasize phishing-resistant MFA for admins. The guide recommends ensuring device readiness by updating to the latest operating systems that support passwordless authentication, registering users for portable and local credentials, and implementing a structured onboarding process that includes identity verification and credential bootstrapping.

Additionally, the document details a phased deployment strategy and emphasizes effective user communication throughout the process. It encourages monitoring and reporting using tools like the Phishing-Resistant Passwordless Workbook and Microsoft Entra ID reports to track registration and usage of credentials. Finally, it highlights the importance of gradually enforcing the use of phishing-resistant credentials through Conditional Access policies and managing risks associated with identity-based threats using Microsoft Entra ID Protection.

For more information, see [Get started with phishing-resistant MFA deployment in Microsoft Entra ID](how-to-plan-prerequisites-phishing-resistant-passwordless-authentication).
## Related content

* [Passkeys (FIDO2)](concept-authentication-passkeys-fido2.md)
* [Account Recovery (preview)](concept-self-service-account-recovery.md)
* [Get started with phishing-resistant MFA deployment in Microsoft Entra ID](how-to-plan-prerequisites-phishing-resistant-passwordless-authentication)

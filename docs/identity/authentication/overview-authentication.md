---
title: Microsoft Entra Authentication Overview
description: Learn about the authentication methods and security features for user sign-ins with Microsoft Entra ID.

ms.service: entra-id
ms.subservice: authentication
ms.topic: overview
ms.date: 10/26/2025

ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: sranjit

# Customer intent: As a Microsoft Entra administrator, I want to understand how Microsoft Entra ID makes it convenient to improve user sign-in security.
---
# What is Microsoft Entra authentication?

We're making it convenient to make your users secure

Microsoft has significantly advanced the adoption of passkeys for secure authentication by issuing millions of passkeys for Microsoft Entra ID. Users with passkeys experience faster sign-in with a higher success rate.

Microsoft Entra account recovery aims to enhance real-world identity verification and reduce reliance on phishable credentials by using Verified ID.  using government-issued IDs and face ID verification. 

## Adoption and User Experience

Over 200 million synced passkeys have been registered, enabling passwordless authentication across devices.
New architecture prioritizes the most secure and convenient credentials per device, reducing password reset attempts and password use on iOS, with Android deployment underway.


## Security challenges and solutions

Phishing attacks increased by 58% in 2023, with an estimated financial impact of $3.5 billion in 2024.
Traditional MFA methods like OTPs and authenticator apps are cumbersome, leading to user resistance and vulnerability to impersonation.
Passkeys, based on FIDO standards and origin-bound public cryptography, prevent credential phishing and impersonation by binding credentials to devices or syncing across devices securely .

## Enterprise rollout and Microsoft Entra account recovery

Microsoft secured 92% of employee productivity accounts with phishing-resistant methods, including 42 million passkeys for Entra ID.
Challenges addressed include secure remote onboarding, account recovery with biometric verification against government IDs, and phased rollouts targeting device compatibility and productivity impact.
Custom applications for real-time biometric matching improve confidence in recovery and onboarding processes .

## Passkey management and customer benefits
Entra customers can now provision synced passkeys with configurable types for user groups, benefiting from intelligent credential prioritization and improved manageability.
New account recovery flows integrate biometric ID verification across 192 countries and support billing with leading identity verification providers, simplifying integration.
Planned features include step-up verification powered by Conditional Access starting Spring 2026 .

## Deployment best practices

Successful rollout strategies include forming user cohorts based on device and OS usage, prioritizing administrators, and starting with easier cohorts to build momentum.
Emphasis on strong helpdesk support, proactive exception management, geographic considerations, and targeted guidance for new hires ensures smooth transitions.
Account recovery security is enhanced by adopting robust identity proofing solutions alongside phishing-resistant credentials .

## Account recovery
Account recovery is a critical component of your organization’s security posture. The recovery process should be as strong as user authentication to prevent unauthorized access and preserve trust. For users protected by phishing-resistant authentication, such as passkeys (FIDO2) or certificate-based authentication, account recovery should be as robust as the initial onboarding process. This means you should perform strong identity verification and validation of account ownership as part of the recovery process. 

In Microsoft Entra ID, we offer an integrated and seamless process for identity verification. Organizations can configure trusted partners to verify a user’s identity, typically by presenting government-issued identification. After other validation steps, users can securely replace lost credentials, such as by registering a new passkey, to maintain account security throughout the recovery process. See more information on Entra ID Account recovery.  

For users who rely on passwords and do not have access to phishing-resistant methods, self-service password reset (SSPR) remains available. To enhance security for these users, especially those with multi-factor authentication (MFA) capability, we recommend requiring at least two distinct authentication methods to complete password reset. This layered approach reduces the risk of account compromise during recovery. 




One of the main features of an identity platform is to verify, or *authenticate*, credentials when a user signs in to a device, application, or service. In Microsoft Entra ID, authentication involves more than just the verification of a username and password. To improve security and reduce the need for help-desk assistance, Microsoft Entra authentication includes the following components:

* Self-service password reset (SSPR)
* Multifactor authentication (MFA)
* Hybrid integration to write password changes back to an on-premises environment
* Hybrid integration to enforce password protection policies for an on-premises environment
* Passwordless authentication

To learn more about these authentication components, watch our short video.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=5ee3cad5-3360-48da-b520-1a0d96710a38]





## Multifactor authentication

Multifactor authentication is a process in which a user is prompted for an additional form of identification during sign-in. For example, the user is prompted to enter a code on a phone or to provide a fingerprint scan.

If you use only a password to authenticate a user, it leaves a nonsecure vector for attack. If the password is weak or is exposed elsewhere, is it really the user who's signing in with the username and password, or is it an attacker? Requiring a second form of authentication increases security because this additional factor isn't easy for an attacker to obtain or duplicate.

![Conceptual diagram of the various forms of multifactor authentication.](./media/concept-mfa-howitworks/methods.png)

Microsoft Entra MFA works by requiring two or more of the following authentication methods:

* Something the user knows, typically a password
* Something the user has, such as a trusted device or a hardware key that isn't easily duplicated
* Something the user is; that is, biometrics like a fingerprint or face scan

Users can register themselves for both SSPR and MFA in one step to simplify the onboarding experience. Administrators can define what forms of secondary authentication to use. Administrators can also require MFA when users perform a self-service password reset, to further secure that process.


## Related content

* To get started, see the [tutorial for Microsoft Entra SSPR][tutorial-sspr] and the [tutorial for Microsoft Entra MFA][tutorial-azure-mfa].
* To learn more about SSPR concepts, see [How it works: Microsoft Entra self-service password reset][concept-sspr].
* To learn more about MFA concepts, see [How it works: Microsoft Entra multifactor authentication][concept-mfa].

<!-- INTERNAL LINKS -->
[tutorial-sspr]: tutorial-enable-sspr.md
[tutorial-azure-mfa]: tutorial-enable-azure-mfa.md
[concept-sspr]: concept-sspr-howitworks.md
[concept-mfa]: concept-mfa-howitworks.md

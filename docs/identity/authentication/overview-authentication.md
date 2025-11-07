---
title: Microsoft Entra Authentication Overview
description: Learn about the authentication methods and security features for user sign-ins with Microsoft Entra ID.

ms.service: entra-id
ms.subservice: authentication
ms.topic: overview
ms.date: 10/30/2025

ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: sranjit

# Customer intent: As a Microsoft Entra administrator, I want to understand how Microsoft Entra ID makes it convenient to improve user sign-in security.
---
# What is Microsoft Entra authentication?

Authentication is the process of verifying a person's identity before granting access to a resource, application, service, device, or network. It's how a system makes sure **users are who they say they are** when they try to sign in.

Microsoft Entra ID supports different [authentication methods](concept-authentication-methods.md), including options for [multifactor authentication (MFA)](tutorial-enable-azure-mfa.md) and enhanced security policies that enable customers to meet their business requirements for usability and security posture. 

While traditional MFA with SMS, email, OTP, or authenticator apps significantly improve security over password-only systems, these options introduce friction—requiring more steps for users, like entering codes, approving push notifications, or using authenticator apps, and remain vulnerable to remote phishing attacks. Despite these obstacles, MFA remains a critical security control, but its user experience and administrative overhead can hinder adoption and effectiveness. 

This article describes best practices for achieving convenient and usable authentication and recovery experiences while improving your organization's security posture. 

## Passkeys (FIDO2)

Passkeys (FIDO2) are modern user credentials based on FIDO standards that are both easy to use and more secure than traditional MFA options. Passkeys are built on origin-bound public cryptography thus preventing a user from inadvertently presenting their authentication credentials to a malicious actor or being intercepted by an attacker.

There are two types of passkeys – device-bound and synced passkeys. 

- **Device-bound passkeys** are those where the private key never leaves the device. Microsoft Entra ID already supports device-bound passkeys like FIDO2 security keys and passkeys in Microsoft Authenticator.  
- **Synced passkeys** sync through the provider's cloud (such as Apple iCloud Keychain, Google Password Manager). They can be used from multiple devices that belong to the same trust group and are signed in to the same sync service. Microsoft Entra ID supports synced passkeys (preview), and admins can select groups that can sign in with device-bound and synced passkeys.

Synced passkeys offer a seamless and convenient user experience where users can use device's native device unlock mechanism like face, fingerprint, or PIN to authenticate. The following observations are based on the learnings from hundreds of millions of consumer users of Microsoft accounts that have registered and are using synced passkeys:

- 99% of users successfully register synced passkeys 
- Synced passkeys are 14 times faster compared to password and a traditional MFA combination: 3 seconds instead of 69 seconds 
- Users are 3 times more successful at signing-in with passkey than legacy authentication methods (95% versus 30%)

Synced passkeys in Microsoft Entra ID bring MFA simplicity at scale for all enterprise users. They're a convenient and low-cost alternative to traditional MFA options like SMS and authenticator apps. Learn [how to deploy passkeys](how-to-authentication-passkey-profiles.md) in your organization.

It's recommended to use FIDO2 security keys in highly regulated industries or for users with high privilege. Note that however, these can incur higher equipment, training, and helpdesk costs due to lost productivity when users need to recover access to their account when they lose their physical key, and the cost of replacing lost physical keys is high. Passkeys in the Authenticator app are also an option for this user group.

For most users in your organization, outside of the regulated industries or for privileged users with access to customer data, critical information, or computing systems, synced passkeys should be considered as convenient and low-cost alternatives to traditional MFA. 

In general, any type of passkey, whether device-bound or synced, is a huge upgrade over MFA options that are vulnerable to phishing. 

For more information, see [Get started with phishing-resistant MFA deployment in Microsoft Entra ID](how-to-plan-prerequisites-phishing-resistant-passwordless-authentication.md). 

Next, we review how passkeys can be used in different scenarios where users need to authenticate. 

## Authenticating while bootstrapping new devices

This is the scenario where existing users are asked to perform some interactive authentication step on a device where the user has never authenticated before. For example, when users get a new physical device. Note that on a “new” physical device that doesn't yet have the user's account, the local lock screen (Face ID, Windows Hello for Business, etc.) inherently can't be used as a credential to bootstrap the device. In this scenario, our recommendation is to follow the same general recommendation for using FIDO2 security keys, Authenticator app passkey and synced passkey.

## Lock screens for primary re-authentication
After a user has bootstrapped a device with their account, there's some ongoing need to verify that the session is still controlled by the original user. Generally, the standard device-unlock gesture used to unlock a device is the primary form of interactive reauthentication used for that verification. 

For users who access high-risk applications, we more specifically recommend using full mobile device management (MDM) to:

- Enforce a lock screen
- Enforce operating system updates
- Integrate with Mobile Threat Defense (MTDs), including Mobile Defender for Endpoint, for antimalware
- Apply app protection policies

For users who access medium-risk applications, we recommend using mobile application management (MAM) where feasible, and rely on the aggressive efforts operating system vendors have to:

- Promote a lock screen
- Promote OS updates
- Help users avoid installing apps that might contain malware

For users who access low-risk applications, we recommend relying on the aggressive efforts operating system vendors have. Also rely on the efforts by browser vendors to promote incognito browsing.

## Single sign-on (SSO) after device bootstrap

For accounts and devices that follow the preceding guidance, once a user has bootstrapped their account, we don't recommend any interactive re-authentication when users try to access applications beyond the standard user gesture to unlock the device. Traditional SSO technology should be used instead (such as SAML, OpenID, and so on). This includes applications on remote virtual devices if SSO can be used to bootstrap a session for the same user account on that device. The Microsoft Entra ID default configuration comes down to "don't ask users to provide their credentials if the security posture of their sessions didn't change."

## Secondary re-authentication 

There's a limited set of scenarios where the standard device unlock gesture isn't the recommended approach for interactive re-authentication, and the user faces more UX friction with re-authentication. For accounts and devices that follow the preceding guidance, the recommended guidance for each scenario is: 

- **Step-up authentication**: Admins/power users might use a synced passkey, as described earlier, to bootstrap a new device if they initially access only low-risk or medium-risk applications. If they later want to access high-risk applications, they need to perform an interactive re-authentication flow with one of the other credential types suggested earlier.
- **Compromised account**: If an admin believes a user's account is compromised, then any sessions that belong to the account should be invalidated, and potentially compromised credentials should be removed from the account. The user then need to re-authenticate with a credential of a type listed earlier that is still valid, or was issued to the correct user as a new credential.
- **Adding new credentials**: If a user tries to add a new credential that can be used to bootstrap other devices, then Microsoft Entra ID risk engine may ask them to perform another interactive re-authentication step.
- **Extended inactivity**: If a session is completely unused for an extended period, then the user needs to re-authenticate with a credential listed above.  However, this would primarily be to prevent against local attacks by (1) someone who knew the user's lock screen PIN, and (2) had access to a device the good user had not used for an extended period of time, and (3) didn't have access to a device the good user more frequently used, which wouldn't have this other check. Given that low likelihood, this extended period defaults to 90 days in Microsoft Entra ID.
- **Transaction approval for specific high-risk actions**: If an admin/power-user is performing a high-risk action (such as large monetary transfer, or major software update to critical systems), then another interactive re-authentication may be used via authentication context as an added layer of protection against local malware. In such situations, we suggest forcibly invoking the lock screen as the lowest friction form of re-authentication. Note that malware could still trick users into performing re-authentication step no matter what credential type is used. In such cases we recommend also requiring a second employee, and on a different device, to review and approve the high-risk action.
- **Policy exception**: The section on lock screens gives guidance for high/medium/low risk application types.  If your organization wants to give access to high-risk applications without MDM to some users, then the time period of access could be limited to a few hours (or at most days) using the Conditional Access sign-frequency feature that enforces interactive reauthentication to happen again after that time period.  However, we still advise avoiding that configuration for high-risk applications and instead rely on MDM.  One way to do that is to allow employees to use a physical device for low-medium risk applications that do not have MDM and then require them to SSO into a virtual device that does have MDM to access high-risk applications.  
- **Other regulatory requirements**: Your organization may have regulatory requirements beyond the list above where SSO cannot be used, even after the user has performed the standard device unlock step.  Most such regulatory requirements take a while to be updated based on latest industry techniques such as the recommendations above. Until the requirements are updated, you can work with your compliance review process to accept the risk of instead following the guidance listed here. However, if you can't do that, you can use the features of Microsoft Entra ID Conditional Access to enforce another interactive re-authentication. In such situations, we suggest forcibly invoking the lock screen as the lowest friction form of re-authentication if that is an option in the regulations. If the regulation applies to an application that the employee is accessing on a virtual desktop, then Microsoft Entra ID has support for forcibly invoking the lock screen on the user's local device. If the regulatory requirement can't be met by forcibly invoking the lock screen, then you likely need to require interactive re-authentication using one of the credentials listed earlier.

## High assurance account recovery

Account recovery is a critical component of your organization's security posture. The recovery process should be as strong as user authentication to prevent unauthorized access and preserve trust. For users protected by phishing-resistant authentication, such as passkeys (FIDO2) or certificate-based authentication, account recovery should be as robust as the initial onboarding process. This means you should perform strong identity verification and validation of account ownership as part of the recovery process.

In Microsoft Entra ID, we offer an integrated and seamless process for identity verification. Organizations can configure trusted partners to verify a user's identity, typically by presenting government-issued identification. After other validation steps, users can securely replace lost credentials, such as by registering a new passkey, to maintain account security throughout the recovery process. For more information, see [Overview of Microsoft Entra ID Account Recovery](concept-account-recovery-overview.md).

For users who rely on passwords and don't have access to phishing-resistant methods, [self-service password reset (SSPR)](concept-sspr-deploy.md) remains available. To enhance security for these users, especially users with multifactor authentication (MFA) capability, we recommend requiring at least two distinct authentication methods to complete password reset. This layered approach reduces the risk of account compromise during recovery.

## Related content

* [Passkeys (FIDO2)](concept-authentication-passkeys-fido2.md)
* [Get started with phishing-resistant MFA deployment in Microsoft Entra ID](how-to-plan-prerequisites-phishing-resistant-passwordless-authentication.md)

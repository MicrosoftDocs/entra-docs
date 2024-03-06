---
title: Passkey authentication for Microsoft Entra ID (preview)
description: Learn about passkey support in Microsoft Entra ID.

services: active-directory
ms.service: active-directory
ms.subservice: authentication
ms.topic: conceptual
ms.date: 03/06/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui

ms.collection: M365-identity-device-management
---
# Passkey authentication for Microsoft Entra ID (preview)

Passkeys are a cross-industry, standards-based replacement for passwords. When used with Microsoft Entra ID, passkeys provide multifactor authentication (MFA) and phishing-resistant authentication. Passkeys provide a simple and more secure way for users to sign in. They don't need to remember anything, and they can store a passkey on their computer, mobile device, or a hardware-based authenticator, similar to a FIDO security key.

The FIDO ("Fast IDentity Online") Alliance, comprised of Apple, Google, Microsoft, and other members, developed the passkey specification. Before passkeys, the FIDO Alliance created the open standards specification for FIDO2 security keys. Security keys are physical devices that are also capable of MFA and phishing-resistant authentication. They use public key cryptography and the open standard Web Authentication API (WebAuthN). 

Instead of sending your password over the internet, your device generates a pair of keys: a private key and a public key. The private key is stored securely on your device, while the public key is registered with the website or application. To sign in, your device simply needs to prove that it has the corresponding private key by signing a challenge from the website or application. The website or application verifies the signature using the public key and grants you access. 

:::image type="content" border="true" source="./media/concept-authentication-passkey/key-pair.png" alt-text="Conceptual diagram of a public and private key pair.":::

Passkeys inherit and extend the existing specification of FIDO2 security keys. They make phishing-resistant authentication more available and easier to use by enabling computers and mobile devices as authenticators. Passkeys are supported on computers that run Windows and macOS, and devices that run Android and iOS.

Passkeys can either be bound to one device or synchronized between multiple devices. An example, FIDO2 security keys support device-bound passkeys, including the ability to store multiple deivce-bound passkeys per device. Passkeys on Android and iOS devices saved to Google password manager or the iCloud keychain automatically synchronize between a user’s devices where their Google or Apple account is signed-in. Some third-party apps can also manage passkeys across users' devices and browsers providing cross-platform syncing. 

>[!Note]
>Entra ID supports only device-bound passkeys. Support for synced passkeys is coming soon.

## Phishing-resistant sign in methods for Microsoft Entra ID

Among other requirements, [Executive Order 14028](https://www.whitehouse.gov/briefing-room/presidential-actions/2021/05/12/executive-order-on-improving-the-nations-cybersecurity/) mandates that US government agencies use phishing-resistant authentication by September 2024. Today in Microsoft Entra ID, we offer the following phishing-resistant authentication methods: 

- Certificate-based authentication (CBA): CBA is commonly used by US government agencies. It requires a Public Key Infrastructure (PKI). 
- Windows Hello for Business: Platform level Single Sign-on and device-bound passkey by definition. Windows Hello for Business can be complex. Windows Hello for Business is limited to PCs, and requires that Mobile Device Management (MDM) fully manage these devices. The Executive Order also requires a solution for unmanaged devices. 
- Passkeys (device-bound): Includes FIDO2 security keys and other physical devices. Adoption of security keys are limited because these physical devices are costly to acquire and manage at scale.
- Passkeys (WebAuthn credential): Can be applied from, passkeys (FIDO2), Microsoft Authenticator, Windows Hello, and Windows Hello For Business. 
- Passkey managed by Microsoft Authenticator: Device-bound passkeys (FIDO2) that users can save in Microsoft Authenticator on a mobile device that runs Android 14+ or iOS 17+.

## Advantages of passkeys for users

These advantages make passkeys one of the most beneficial authentication options for end users:

- Highly secure sign in
- Easy to download and use 
- Fast, seamless sign-in that leverages biometrics or PIN
- Sign in from all major platforms, including iOS, Android, macOS, Windows and Linux
- Sign in with dedicated security keys

## Security advantages for organizations

Let's take a look at the security benefits that passkeys offer for organizations. Passkeys are passwordless, multifactor, and phishing-resistant. They're easy to use and secure by design. 

### Multifactor authentication

Passkeys handle multifactor authentication (MFA) by design for websites and authentication apps, such as Microsoft Entra ID, that require user verification. To complete MFA, users must present at least two of the following: 

- Something they have 
- Something they are
- Something they know

The user’s device contains the passkey, which is something they have. To sign in with the passkey, the user must either use their biometrics, which is something they are, or a device PIN, which is something they know. 

This combination forms a secure multifactor authentication. The sign-in is more secure than legacy MFA options that are perishable, such as combining a password with an SMS text verification. 

>[!NOTE]
>Entra ID requires user verification with biometrics or PIN. Some websites or replying parties do not require require user verification when users authenticate with a passkey. In these scenarios the user isn't required to present two factors to complete MFA by using a passkey.  

:::image type="content" border="true" source="./media/concept-authentication-passkey/multifactor.png" alt-text="Conceptual diagram of how passkeys provide multifactor authentication.":::

## Phishing-resistant

Bad actors relentlessly attempt to compromise users by tricking users into giving away their password or providing them a one-time code used for MFA. This happens through the use of phishing campaigns or trustworthy looking website that emulates a well known application or provider. With MFA methods that rely on push notifications or approvals, a common tactic bad actors use is to overwhelm users with numerous requests, hoping users get fatigued and inadvertently approves one of them. Passkeys protect users from these types of attacks. 
 
Let’s say an attacker wants to steal the credentials of users who sign in to a legitimate website named contoso.com. The attacker creates a malicious website, con1oso.com, where the letter t is replaced with a digit 1. The attacker might trick a user into landing on this similar-looking website, but the user can never be tricked into presenting their passkey to this malicious website because their device won't allow it. When a passkey is created, it's only associated with the trusted domain of the website that it's registered with. A passkey that's created for contoso.com can only be used with contoso.com. 

:::image type="content" border="true" source="./media/concept-authentication-passkey/phishing-resistant.png" alt-text="Conceptual diagram of how passkeys are phishing-resistant.":::

## Cross-device authentication 

Users are also protected from phishing attacks during cross-device authentication, which is when a passkey on one device is used for sign-in on another device. This type of authentication is handy, for example, for when the user needs to sign in on a new device and has a passkey on their mobile device.  

To link two devices together for cross-device authentication, the user scans a QR code that's generated on the device where they want to sign in. During this process, a proximity check takes place using a localized bluetooth connection, to ensure that the passkey is only being used for authentication on a linked device that’s nearby. This way, bad actors can't use passkeys to remotely gain access to a device. 

:::image type="content" border="true" source="./media/concept-authentication-passkey/cross-device.png" alt-text="Image displaying registered passkey in Microsoft Authenticator.":::

## Using passkeys with Microsoft Authenticator

Organizations who want the added security and control, compared to synced passkeys, can utilize Microsoft Authenticator as a passkey provider. Microsoft Authenticator supports device-bound passkeys on Android 14+ and iOS 17+ devices. Authenticator uses passkeys to provide free, phishing-resistant credentials that are based on open standards and recent security improvements. For more information, see [Authentication methods in Microsoft Entra ID - Microsoft Authenticator app](concept-authentication-authenticator-app.md).

:::image type="content" border="true" source="./media/concept-authentication-passkey/passkey-authenticator.png" alt-text="Conceptual diagram of a public and private key pair in Microsoft Authenticator.":::

### Authentication methods policy configuration

Before users can sign in to Microsoft Entra ID using passkeys, an Authentication Policy Administrator must enable Microsoft Authenticator for phishing-resistant MFA in the Authentication methods policy. Customers can restrict the use of passkeys for certain users and groups within their organizations. They can also restrict passkey usage to specific provider types by restricting Authenticator Attestation GUIDs (AAGUIDs) allowed in an organization. For more information, see [How to enable Authenticator passkey](how-to-enable-authenticator-passkey.md).

## Next steps

- [Choosing authentication methods for your organization](concept-authentication-methods.md)
- [Combined registration experience](concept-registration-mfa-sspr-combined.md)


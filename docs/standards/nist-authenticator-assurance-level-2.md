---
title: Achieve NIST AAL2 with the Microsoft Entra ID
description: Guidance on achieving NIST authenticator assurance level 2 (AAL2) with Microsoft Entra ID.
ms.service: entra
ms.subservice: standards
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.reviewer: martinco
ms.date: 09/27/2024
ms.custom: it-pro
---

# NIST authenticator assurance level 2 with Microsoft Entra ID

The National Institute of Standards and Technology (NIST) develops technical requirements for US federal agencies implementing identity solutions. Organizations working with federal agencies must meet these requirements.

Before starting authenticator assurance level 2 (AAL2), you can see the following resources:

* [NIST overview](nist-overview.md): Understand AAL levels
* [Authentication basics](nist-authentication-basics.md): Terminology and authentication types
* [NIST authenticator types](nist-authenticator-types.md): Authenticator types
* [NIST AALs](nist-about-authenticator-assurance-levels.md): AAL components and Microsoft Entra authentication methods

## Permitted AAL2 authenticator types

The following table has authenticator types permitted for AAL2:

| Microsoft Entra authentication method| Phishing Resistant | NIST authenticator type |
| - | - | - |
| **Recommended methods** |   |   |
| Multi-factor software certificate <br> Windows Hello for Business with software Trusted Platform Module (TPM)| Yes | Multi-factor crypto software |
| Multi-factor hardware protected certificate <br> FIDO 2 security key <br> Platform SSO for macOS (Secure Enclave) <br> Windows Hello for Business with hardware TPM <br> Passkey in Microsoft Authenticator | Yes |  Multi-factor crypto hardware |
| **Additional methods** |  
| Microsoft Authenticator app (Phone Sign-in)  | No | Multi-factor out-of-band|
| Password **OR** QR Code (PIN) <br> **AND** <br>- Microsoft Authenticator app (Push Notification) <br>- **OR** <br>- Microsoft Authenticator Lite (Push Notification) <br>- **OR** <br>- Phone (SMS) | No | Memorized secret <br>**AND**<br> Single-factor out-of-band |
| Password **OR** QR Code (PIN) <br>**AND** <br>- OATH hardware tokens (preview) <br>- **OR**<br>- Microsoft Authenticator app (OTP)<br>- **OR**<br>- Microsoft Authenticator Lite (OTP)<br>- **OR** <br>- OATH software tokens | No | Memorized secret <br>**AND** <br>Single-factor OTP|
| Password **OR** QR Code (PIN) <br>**AND** <br>- Single-factor software certificate <br>- **OR**<br>- Microsoft Entra joined  with software TPM <br>- **OR**<br>- Microsoft Entra hybrid joined with software TPM  <br>- **OR**<br>- Compliant mobile device | Yes<sup>1</sup> | Memorized secret <br>**AND**<br> Single-factor crypto software |
| Password **OR** QR Code (PIN) <br>**AND**<br>- Microsoft Entra joined with hardware TPM <br>- **OR**<br>- Microsoft Entra hybrid joined with hardware TPM| Yes<sup>1</sup> |  Memorized secret <br>**AND**<br>Single-factor crypto hardware |

<sup>1</sup> [Protection from external phishing](../standards/memo-22-09-multi-factor-authentication.md#protection-from-external-phishing)


### AAL2 recommendations

For AAL2, use multi-factor cryptographic authenticator. This is phishing resistant, eliminates the greatest attack surface (the password), and offers users a streamlined method to authenticate.

For guidance on selecting a passwordless authentication method, see [Plan a passwordless authentication deployment in Microsoft Entra ID](~/identity/authentication/howto-authentication-passwordless-deployment.md). See also, [Windows Hello for Business deployment guide](/windows/security/identity-protection/hello-for-business/hello-deployment-guide)

## FIPS 140 validation

Use the following sections to learn about FIPS 140 validation.

### Verifier requirements

Microsoft Entra ID uses the Windows FIPS 140 Level 1 overall validated cryptographic module for authentication cryptographic operations. It's therefore a FIPS 140-compliant verifier required by government agencies.

### Authenticator requirements

Government agency cryptographic authenticators are validated for FIPS 140 Level 1 overall. This requirement isn't for non-governmental agencies. The following Microsoft Entra authenticators meet the requirement when running on [Windows in a FIPS 140-approved mode](/windows/security/security-foundations/certification/fips-140-validation):

* Password

* Microsoft Entra joined with software or with hardware TPM

* Microsoft Entra hybrid joined with software or with hardware TPM

* Windows Hello for Business with software or with hardware TPM

* Certificate stored in software or hardware (smartcard/security key/TPM)

For Microsoft Authenticator app (iOS/Android) FIPS 140 compliance information, See [FIPS 140 compliant for Microsoft Entra authentication](~/identity/authentication/concept-authentication-authenticator-app.md#fips-140-compliant-for-microsoft-entra-authentication)

For OATH hardware tokens and smartcards we recommend you consult with your provider for current FIPS validation status.

FIDO 2 security key providers are in various stages of FIPS certification. We recommend you review the list of [supported FIDO 2 key vendors](~/identity/authentication/concept-authentication-passwordless.md). Consult with your provider for current FIPS validation status.

Platform SSO for macOS is FIPS 140 compliant. We recommend referring to the [Apple Platform Certifications](https://support.apple.com/guide/certifications/apc3a7433eb89/web). 

## Reauthentication

For AAL2, the NIST requirement is reauthentication every 12 hours, regardless of user activity. Reauthentication is required after a period of inactivity of 30 minutes or longer. Because the session secret is something you have, presenting something you know, or are, is required.

To meet the requirement for reauthentication, regardless of user activity, Microsoft recommends configuring [user sign-in frequency](~/identity/conditional-access/howto-conditional-access-session-lifetime.md) to 12 hours.

With NIST you can use compensating controls to confirm subscriber presence:

* Set session inactivity time out to 30 minutes: Lock the device at the operating system level with Microsoft System Center Configuration Manager, group policy objects (GPOs), or Intune. For the subscriber to unlock it, require local authentication.

* Time out regardless of activity: Run a scheduled task (Configuration Manager, GPO, or Intune) to lock the machine after 12 hours, regardless of activity.

## Man-in-the-middle resistance

Communications between the claimant and Microsoft Entra ID are over an authenticated, protected channel. This configuration provides resistance to man-in-the-middle (MitM) attacks and satisfies the MitM resistance requirements for AAL1, AAL2, and AAL3.

## Replay resistance

Microsoft Entra authentication methods at AAL2 use nonce or challenges. The methods resist replay attacks because the verifier detects replayed authentication transactions. Such transactions won't contain needed nonce or timeliness data.

## Next steps

[NIST overview](nist-overview.md)

[Learn about AALs](nist-about-authenticator-assurance-levels.md)

[Authentication basics](nist-authentication-basics.md)

[NIST authenticator types](nist-authenticator-types.md)

[Achieve NIST AAL1 with Microsoft Entra ID](nist-authenticator-assurance-level-1.md)

[Achieve NIST AAL2 with Microsoft Entra ID](nist-authenticator-assurance-level-2.md)

[Achieve NIST AAL3 with Microsoft Entra ID](nist-authenticator-assurance-level-3.md)

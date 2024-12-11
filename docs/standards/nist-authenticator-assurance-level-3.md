---
title: Achieve NIST AAL3 by using Microsoft Entra ID
description: This article provides guidance on achieving NIST authenticator assurance level 3 (AAL3) by using Microsoft Entra ID.
ms.service: entra
ms.subservice: standards
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.reviewer: martinco
ms.date: 09/13/2022
ms.custom: it-pro
---

# NIST authenticator assurance level 3 by using Microsoft Entra ID

Use the information in this article for National Institute of Standards and Technology (NIST) authenticator assurance level 3 (AAL3).

Before obtaining AAL2, you can review the following resources:

* [NIST overview](nist-overview.md): Understand AAL levels
* [Authentication basics](nist-authentication-basics.md): Terminology and authentication types
* [NIST authenticator types](nist-authenticator-types.md): Authenticator types
* [NIST AALs](nist-about-authenticator-assurance-levels.md): AAL components and Microsoft Entra authentication methods

## Permitted authenticator types

Use Microsoft authentication methods to meet required NIST authenticator types.

| Microsoft Entra authentication methods| NIST authenticator type |
| - | -|
| **Recommended methods**|    |
|  Multi-factor hardware protected certificate <br> FIDO 2 security key <br> Platform SSO for macOS (Secure Enclave) <br> Windows Hello for Business with hardware TPM <br> Passkey in Microsoft Authenticator<sup>1</sup>| Multi-factor cryptographic hardware |
| **Additional methods**||
|Password<br>**AND**<br>Single-factor hardware protected certificate|Memorized secret <br>**AND**<br>Single-factor cryptographic hardware|

<sup>1</sup> Passkey in Microsoft Authenticator is overall considered partial AAL3 and can qualify as AAL3 on platforms with FIPS 140 Level 2 Overall (or higher) and FIPS 140 level 3 physical security (or higher). For additional information on FIPS 140 compliance for Microsoft Authenticator (iOS/Android) See [FIPS 140 compliant for Microsoft Entra authentication](~/identity/authentication/concept-authentication-authenticator-app.md#fips-140-compliant-for-microsoft-entra-authentication)
### Recommendations

For AAL3, we recommend using a multi-factor cryptographic hardware authenticator that provides passwordless authentication eliminating the greatest attack surface, the password.

For guidance, see [Plan a passwordless authentication deployment in Microsoft Entra ID](~/identity/authentication/howto-authentication-passwordless-deployment.md). See also [Windows Hello for Business deployment guide](/windows/security/identity-protection/hello-for-business/hello-deployment-guide).

## FIPS 140 validation

### Verifier requirements

Microsoft Entra ID uses the Windows FIPS 140 Level 1 overall validated cryptographic module for its authentication cryptographic operations, making Microsoft Entra ID a compliant verifier.

### Authenticator requirements

Single-factor and multi-factor cryptographic hardware authenticator requirements.

#### Single-factor cryptographic hardware

Authenticators are required to be:

* FIPS 140 Level 1 Overall, or higher

* FIPS 140 Level 3 Physical Security, or higher

Single-factor hardware protected certificate used with Windows device meet this requirement when:

* You run [Windows in a FIPS-140 approved mode](/windows/security/security-foundations/certification/fips-140-validation)

* On a machine with a TPM that's FIPS 140 Level 1 Overall, or higher, with FIPS 140 Level 3 Physical Security

  * Find compliant TPMs: search for Trusted Platform Module and TPM on [Cryptographic Module Validation Program](https://csrc.nist.gov/Projects/cryptographic-module-validation-program/validated-modules/Search).

Consult your mobile device vendor to learn about their adherence with FIPS 140.

#### Multi-factor cryptographic hardware

Authenticators are required to be:

* FIPS 140 Level 2 Overall, or higher

* FIPS 140 Level 3 Physical Security, or higher

FIDO 2 security keys, smart cards, and Windows Hello for Business can help you meet these requirements.

* Multiple FIDO2 security key providers meet FIPS requirements. We recommend you review the list of [supported FIDO2 key vendors](~/identity/authentication/concept-fido2-hardware-vendor.md). Consult with your provider for current FIPS validation status.

* Smart cards are a proven technology. Multiple vendor products meet FIPS requirements.

  * Learn more on [Cryptographic Module Validation Program](https://csrc.nist.gov/Projects/cryptographic-module-validation-program/validated-modules/Search)

**Windows Hello for Business**

FIPS 140 requires the cryptographic boundary, including software, firmware, and hardware, to be in scope for evaluation. Windows operating systems can be paired with thousands of these combinations. As such, it is not feasible for Microsoft to have Windows Hello for Business validated at FIPS 140 Security Level 2. Federal customers should conduct risk assessments and evaluate each of the following component certifications as part of their risk acceptance before accepting this service as AAL3:

* **Windows 10 and Windows Server** use the [US Government Approved Protection Profile for General Purpose Operating Systems Version 4.2.1](https://www.niap-ccevs.org/Profile/Info.cfm?PPID=442&id=442) from the National Information Assurance Partnership (NIAP). This organization oversees a national program to evaluate commercial off-the-shelf (COTS) information technology products for conformance with the international Common Criteria.

* **Windows Cryptographic Library** [has FIPS Level 1 Overall in the NIST Cryptographic Module Validation Program](https://csrc.nist.gov/Projects/cryptographic-module-validation-program/Certificate/3544) (CMVP), a joint effort between NIST and the Canadian Center for Cyber Security. This organization validates cryptographic modules against FIPS standards.

* Choose a **Trusted Platform Module (TPM)** that's FIPS 140 Level 2 Overall, and FIPS 140 Level 3 Physical Security. Your organization ensures hardware TPM meets the AAL level requirements you want.

To determine the TPMs that meet current standards, go to [NIST Computer Security Resource Center Cryptographic Module Validation Program](https://csrc.nist.gov/Projects/cryptographic-module-validation-program/validated-modules/Search). In the **Module Name** box, enter **Trusted Platform Module** for a list of hardware TPMs that meet standards.

**MacOS Platform SSO**

Apple macOS 13 (and above) are FIPS 140 Level 2 Overall, with most devices also FIPS 140 Level 3 Physical Security. We recommend referring to the [Apple Platform Certifications](https://support.apple.com/guide/certifications/apc3a7433eb89/web). 

#### Passkey in Microsoft Authenticator

For additional information on FIPS 140 compliance for Microsoft Authenticator (iOS/Android) See [FIPS 140 compliant for Microsoft Entra authentication](~/identity/authentication/concept-authentication-authenticator-app.md#fips-140-compliant-for-microsoft-entra-authentication)

## Reauthentication

For AAL3, NIST requirements are reauthentication every 12 hours, regardless of user activity. Reauthentication is recommended after a period of inactivity 15 minutes or longer. Presenting both factors is required.

To meet the requirement for reauthentication, regardless of user activity, Microsoft recommends configuring [user sign-in frequency](~/identity/conditional-access/howto-conditional-access-session-lifetime.md) to 12 hours.

NIST allows for compensating controls to confirm subscriber presence:

* Set timeout, regardless of activity, by running a scheduled task using Configuration Manager, GPO, or Intune. Lock the machine after 12 hours, regardless of activity.
  
* For the recommended inactivity time out, you can set a session inactivity time out of 15 minutes: Lock the device at the OS level by using Microsoft Configuration Manager, Group Policy Object (GPO), or Intune. For the subscriber to unlock it, require local authentication.

## Man-in-the-middle resistance

Communications between the claimant and Microsoft Entra ID are over an authenticated, protected channel for resistance to man-in-the-middle (MitM) attacks. This configuration satisfies the MitM resistance requirements for AAL1, AAL2, and AAL3.

## Verifier impersonation resistance

Microsoft Entra authentication methods that meet AAL3 use cryptographic authenticators that bind the authenticator output to the session being authenticated. The methods use a private key controlled by the claimant. The public key is known to the verifier. This configuration satisfies the verifier-impersonation resistance requirements for AAL3.

## Verifier compromise resistance

All Microsoft Entra authentication methods that meet AAL3:

* Use a cryptographic authenticator that requires the verifier store a public key corresponding to a private key held by the authenticator
* Store the expected authenticator output by using FIPS-140 validated hash algorithms

For more information, see [Microsoft Entra Data Security Considerations](https://aka.ms/AADDataWhitepaper).

## Replay resistance

Microsoft Entra authentication methods that meet AAL3 use nonce or challenges. These methods are resistant to replay attacks because the verifier can detect replayed authentication transactions. Such transactions won't contain the needed nonce or timeliness data.

## Authentication intent

Requiring authentication intent makes it more difficult for directly connected physical authenticators, like multi-factor cryptographic hardware, to be used without the subject's knowledge (for example, by malware on the endpoint). Microsoft Entra methods that meet AAL3 require user entry of pin or biometric, demonstrating authentication intent.

## Next steps

[NIST overview](nist-overview.md)

[Learn about AALs](nist-about-authenticator-assurance-levels.md)

[Authentication basics](nist-authentication-basics.md)

[NIST authenticator types](nist-authenticator-types.md)

[Achieving NIST AAL1 by using Microsoft Entra ID](nist-authenticator-assurance-level-1.md)

[Achieving NIST AAL2 by using Microsoft Entra ID](nist-authenticator-assurance-level-2.md)

---
title: NIST authenticator types and aligned Microsoft Entra methods
description: Explanations of how Microsoft Entra authentication methods align with NIST authenticator types.
ms.service: entra
ms.subservice: standards
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.reviewer: martinco
ms.date: 11/23/2022
ms.custom: it-pro
---

# NIST authenticator types and aligned Microsoft Entra methods

The authentication process begins when a claimant asserts its control of one of more authenticators associated with a subscriber. The subscriber is a person or another entity. Use the following table to learn about National Institute of Standards and Technology (NIST) authenticator types and associated Microsoft Entra authentication methods.

|NIST authenticator type| Microsoft Entra authentication method|
| - | - |
|Memorized secret <br> (something you know)|  Password <br> QR Code (PIN)|
|Look-up secret <br> (something you have)| None|
|Single-factor out-of-band <br>(something you have)| Microsoft Authenticator app (Push Notification) <br> Microsoft Authenticator Lite (Push Notification) <br> Phone (SMS): Not recommended |
| Multi-factor Out-of-band <br> (something you have + something you know/are) | Microsoft Authenticator app (Phone Sign-In) |
|Single-factor one-time password (OTP) <br> (something you have)| Microsoft Authenticator app (OTP) <br> Microsoft Authenticator Lite (OTP) <br> Single-factor hardware/software OTP<sup>1</sup>|
|Multi-factor OTP <br> (something you have + something you know/are)| Treated as single-factor OTP| 
|Single-factor crypto software <br> (something you have)|Single-factor software certificate <br> Microsoft Entra joined <sup>2</sup> with software TPM <br> Microsoft Entra hybrid joined <sup>2</sup> with software TPM  <br> Compliant mobile device<sup>2</sup> |
|Single-factor crypto hardware <br> (something you have) | Single-factor hardware protected certificate <br> Microsoft Entra joined <sup>2</sup> with hardware TPM <br> Microsoft Entra hybrid joined <sup>2</sup> with hardware TPM|
|Multi-factor crypto software <br> (something you have + something you know/are) | Multi-factor software certificate <br> Windows Hello for Business with software TPM |
|Multi-factor crypto hardware <br> (something you have + something you know/are) | Multi-factor hardware protected certificate <br> FIDO 2 security key <br> Platform SSO for macOS (Secure Enclave) <br> Windows Hello for Business with hardware TPM <br> Passkey in Microsoft Authenticator|

<sup>1</sup> 30-second or 60-second OATH-TOTP SHA-1 token

<sup>2</sup> For more information on device join states, see [Microsoft Entra device identity](~/identity/devices/index.yml)

## Public Switch Telephone Network (PSTN) SMS/Voice are not recommended

NIST does not recommend SMS or voice. The risks of device swap, SIM changes, number porting, and other behaviors can cause issues. If these actions are malicious, they can result in an insecure experience. Although SMS/Voice are not recommended, they are better than using only a password, because they require more effort for hackers.

## Next steps

[NIST overview](nist-overview.md)

[Learn about AALs](nist-about-authenticator-assurance-levels.md)

[Authentication basics](nist-authentication-basics.md)

[NIST authenticator types](nist-authenticator-types.md)

[Achieve NIST AAL1 with Microsoft Entra ID](nist-authenticator-assurance-level-1.md)

[Achieve NIST AAL2 with Microsoft Entra ID](nist-authenticator-assurance-level-2.md)

[Achieve NIST AAL3 with Microsoft Entra ID](nist-authenticator-assurance-level-3.md)

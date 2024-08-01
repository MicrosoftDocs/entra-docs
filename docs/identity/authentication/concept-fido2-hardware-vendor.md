---
title: Become a Microsoft-Compatible FIDO2 Security Key Vendor for sign-in to Microsoft Entra ID
description: Explains process to become a FIDO2 hardware partner
ms.date: 05/22/2024
ms.service: entra-id
ms.subservice: authentication
author: justinha
ms.author: justinha
ms.reviewer: calui
ms.topic: conceptual
---

# Become a Microsoft-compatible FIDO2 security key vendor

Most hacking related breaches use either stolen or weak passwords. Often, IT enforce stronger password complexity or frequent password changes to reduce the risk of a security incident. However, this increases help desk costs and leads to poor user experiences as users are required to memorize or store new, complex passwords.

FIDO2 security keys offer an alternative. FIDO2 security keys can replace weak credentials with strong hardware-backed public/private-key credentials that can't be reused, replayed, or shared across services. Security keys support shared device scenarios, allowing you to carry your credential with you and safely authenticate to a Microsoft Entra joined Windows 10 device that’s part of your organization.

Microsoft partners with FIDO2 security key vendors to ensure that security devices work on Windows, the Microsoft Edge browser, and online Microsoft accounts. FIDO2 security keys enable strong password-less authentication.

You can become a Microsoft-compatible FIDO2 security key vendor through the following process.  Microsoft doesn't commit to do go-to-market activities with the partner and evaluates partner priority based on customer demand.

1. First, your authenticator needs to have a FIDO2 certification. We aren't able to work with providers who don't have a FIDO2 certification. To learn more about the certification, visit the [FIDO Alliance Certification Overview website](https://fidoalliance.org/certification/).
2. After you have a FIDO2 certification, [submit a request form](https://forms.office.com/r/NfmQpuS9hF) to become a Microsoft-compatible FIDO2 security key vendor. Our engineering team only confirms the features supported by your FIDO2 devices. We don't retest features already tested as part of the FIDO2 certification and don't evaluate the security of your solutions. The process usually takes a few weeks to complete.
3. After the engineering team successfully confirmed the feature list, we'll confirm vendor's device is listed in the [FIDO Alliance Metadata Service](https://fidoalliance.org/metadata/).
4. Microsoft adds your FIDO2 Security Key on Microsoft Entra backend and to our list of approved FIDO2 vendors.

## Current partners

The following table lists partners who are Microsoft-compatible FIDO2 security key vendors.

| Provider | Biometric | USB | NFC | BLE |
|:-|:-:|:-:|:-:|:-:|
| Allthenticate | ![n] | ![y] | ![n] | ![y] |
| Authenton | ![n] | ![y] | ![y] | ![n] |
| AuthenTrend | ![y] | ![y]| ![y]| ![y]|
| ACS | ![n] | ![y]| ![y]| ![n]|
| ATOS| ![n] | ![y]| ![y]| ![n]|
| Ciright | ![n] | ![n]| ![y]| ![n]|
| Composecure | ![n] | ![n]| ![y]| ![n]|
| Crayonic | ![y] | ![n]| ![y]| ![y]|
| Cryptnox | ![n] | ![y]| ![y]| ![n]|
| CryptoTrust | ![n] | ![y] | ![n] | ![n] |
| Ensurity | ![y] | ![y]| ![n]| ![n]|
| Excelsecu | ![y] | ![y]| ![y]| ![y]|
| Feitian | ![y] | ![y]| ![y]| ![y]|
| Fortinet | ![n] | ![y]| ![n]| ![n]|
| Giesecke + Devrient (G+D)| ![y] | ![y]| ![y]| ![y]|
| Google | ![n] | ![y]| ![y]| ![n]|
| GoTrustID Inc.| ![n] | ![y]| ![y]| ![y]|
| HID | ![n] | ![y]| ![y]| ![n]|
| HIDEEZ | ![n] | ![y]| ![y]| ![y]|
| Hypersecu | ![n] | ![y]| ![n]| ![n]|
| Hypr | ![y] | ![y]| ![n]| ![y]|
| Identiv | ![n] | ![y]| ![y]| ![n]|
| IDmelon Technologies Inc. | ![y] | ![y]| ![y]| ![y]|
| Kensington | ![y] | ![y]| ![n]| ![n]|
| Keyxentic | ![n] | ![y]| ![y]| ![n]|
| KONA I | ![y] | ![n]| ![y]| ![y]|
| NeoWave | ![n] | ![y]| ![y]| ![n]|
| Nymi | ![y] | ![n]| ![y]| ![n]|
| Octatco | ![y] | ![y]| ![n]| ![n]|
| OneSpan Inc. | ![n] | ![y]| ![y]| ![y]|
| PONE Biometrics | ![y] | ![n]| ![n]| ![y]|
| Precision Biometric| ![y] | ![y]| ![y] | ![n]|
| RSA | ![n] | ![y]| ![n]| ![n]|
| Sentry | ![n] | ![n]| ![y]| ![n]|
| SmartDisplayer | ![y] | ![y]| ![y]| ![y]|
| SpearID | ![n] | ![y]| ![y]| ![y]|
| Swissbit | ![n] | ![y]| ![y]| ![n]|
| Thales Group | ![n] | ![y]| ![y]| ![n]|
| Thetis | ![y] | ![y]| ![y]| ![y]|
| Token2 Switzerland | ![y] | ![y]| ![y]| ![n]|
| Token Ring | ![y] | ![n]| ![y]| ![n]|
| TrustKey Solutions | ![y] | ![y]| ![n]| ![n]|
| Valmido | ![n] | ![n]| ![y]| ![y]|
| VinCSS | ![n] | ![y]| ![n]| ![n]|
| WiSECURE Technologies | ![n] | ![y]| ![n]| ![n]|
| Yubico | ![y] | ![y]| ![y]| ![n]|

<!--Image references-->
[y]: ./media/fido2-compatibility/yes.png
[n]: ./media/fido2-compatibility/no.png

## Next steps

[FIDO2 Compatibility](fido2-compatibility.md)

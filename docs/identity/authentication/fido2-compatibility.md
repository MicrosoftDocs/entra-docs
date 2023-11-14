---
title: Native app and browser support of FIDO2 passwordless authentication | Microsoft Entra ID
description: Browsers and operating system combinations support FIDO2 passwordless authentication for apps using Microsoft Entra ID

services: active-directory
ms.service: active-directory
ms.subservice: authentication
ms.topic: conceptual
ms.date: 11/14/2023

author: justinha
ms.author: justinha
manager: amycolannino
ms.reviewer: calui

ms.collection: M365-identity-device-management
---
# Native app and browser support of FIDO2 passwordless authentication

Microsoft Entra ID allows [FIDO2 security keys](./concept-authentication-passwordless.md#fido2-security-keys) to be used as a passwordless device. The availability of FIDO2 authentication for Microsoft accounts was [announced in 2018](https://techcommunity.microsoft.com/t5/identity-standards-blog/all-about-fido2-ctap2-and-webauthn/ba-p/288910), and it became [generally available](https://techcommunity.microsoft.com/t5/azure-active-directory-identity/passwordless-authentication-is-now-generally-available/ba-p/1994700) in March 2021. This topic covers which browsers, native apps, and operating systems support passwordless authentication using FIDO2 security keys with Microsoft Entra ID. Microsoft Entra ID currently supports only hardware FIDO2 keys and doesn't support passkeys for any platform.

## Native app support (preview)

Microsoft applications provide native support for FIDO2 authentication in preview for all users who have an authentication broker installed for their operating system. The following tables lists which authentication brokers are supported for different operating systems.

| Operating system | Authentication broker           | Supports FIDO2 |
|------------------|---------------------------------|----------------|
| iOS              | Microsoft Authenticator         | &#x2705;       |
| macOS            | Microsoft Intune Company Portal | &#x2705;       |
| Android<sup>1</sup> | Authenticator or Company Portal | &#10060;    |

<sup>1</sup>Native app support for FIDO2 on Android is in progress.

If a user has an authentication broker installed, they can choose to sign in with a security key when they access an application such as Outlook. They're redirected to sign in with FIDO2, and redirected back to Outlook as a signed in user after successful authentication.

If the user doesn't have an authentication broker installed, they can still sign in with a security key when they access MSAL-enabled applications that meet the requirements as listed in [Support for FIDO2 authentication](/entra/identity-platform/support-fido2-authentication).

## Browser support

This table shows browser support for authenticating Microsoft Entra ID and Microsoft accounts by using FIDO2. Microsoft accounts are created by consumers for services such as Xbox, Skype, or Outlook.com. 

| OS  | Chrome | Edge | Firefox | Safari |
|:---:|:------:|:----:|:-------:|:------:|
| **Windows**  | &#x2705; | &#x2705; | &#x2705; | N/A |
| **macOS**  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |
| **ChromeOS**  | &#x2705; | N/A | N/A | N/A |
| **Linux**  | &#x2705; | &#10060; | &#10060; | N/A |
| **iOS**  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |
| **Android**  | &#10060; | &#10060; | &#10060; | N/A |


## Browser support for each platform

The following tables show which transports are supported for each platform. Supported device types include **USB**, near-field communication (**NFC**), and bluetooth low energy (**BLE**).

### Windows

| Browser | USB  | NFC | BLE |
|---------|------|-----|-----|
| Edge    | &#x2705; | &#x2705; | &#x2705; |
| Chrome   | &#x2705; | &#x2705; | &#x2705; |
| Firefox   | &#x2705; | &#x2705; | &#x2705; |

### macOS

| Browser | USB  | NFC<sup>1</sup> | BLE<sup>1</sup> |
|---------|------|-----|-----|
| Edge    | &#x2705; | N/A | N/A |
| Chrome   | &#x2705; | N/A | N/A |
| Firefox<sup>2</sup>   | &#x2705; | N/A | N/A |
| Safari<sup>2</sup>   | &#x2705; | N/A | N/A |

<sup>1</sup>NFC and BLE security keys aren't supported on macOS by Apple.

<sup>2</sup>New security key registration doesn't work on these macOS browsers because they don't prompt to set up biometrics or PIN.

### ChromeOS

| Browser<sup>1</sup> | USB  | NFC | BLE |
|---------|------|-----|-----|
| Chrome  | &#x2705; | &#10060; | &#10060; |

<sup>1</sup>Security key registration isn't supported on ChromeOS or Chrome browser.

### Linux

| Browser | USB  | NFC | BLE |
|---------|------|-----|-----|
| Edge    | &#10060; | &#10060; | &#10060; |
| Chrome  | &#x2705; | &#10060; | &#10060; |
| Firefox | &#10060; | &#10060; | &#10060; |


### iOS

| Browser<sup>1</sup> | Lightning  | NFC | BLE<sup>2</sup> |
|---------|------------|-----|-----|
| Edge    |  &#x2705;  | &#x2705; | N/A | 
| Chrome  |  &#x2705;  | &#x2705; | N/A |
| Firefox |  &#x2705;  | &#x2705; | N/A |
| Safari  |  &#x2705;  | &#x2705; | N/A |

<sup>1</sup>New security key registration doesn't work on iOS browsers because they don't prompt to set up biometrics or PIN.

<sup>2</sup>BLE security keys aren't supported on iOS by Apple.

### Android

| Browser<sup>1</sup> | USB  | NFC | BLE |
|---------|------|-----|-----|
| Edge    | &#10060;  | &#10060; | &#10060; |
| Chrome  | &#10060;  | &#10060; | &#10060; |
| Firefox | &#10060;  | &#10060; | &#10060; |

<sup>1</sup>Security key biometrics or PIN for user verficiation are currently supported on Android by Google. Microsoft Entra ID requires user verification for all FIDO2 authentications.

## Minimum browser version

The following are the minimum browser version requirements. 

| Browser | Minimum version |
| ---- | ---- |
| Chrome | 76 |
| Edge | Windows 10 version 1903<sup>1</sup> |
| Firefox | 66 |

<sup>1</sup>All versions of the new Chromium-based Microsoft Edge support FIDO2. Support on Microsoft Edge legacy was added in 1903.

## Next steps
[Enable passwordless security key sign-in](./howto-authentication-passwordless-security-key.md)

<!--Image references-->
[y]: ./media/fido2-compatibility/yes.png
[n]: ./media/fido2-compatibility/no.png

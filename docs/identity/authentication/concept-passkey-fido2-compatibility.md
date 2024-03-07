---
title: App and browser support of passkey (FIDO2) authentication | Microsoft Entra ID
description: Browsers and operating system combinations support FIDO2 passwordless authentication for apps using Microsoft Entra ID

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/11/2024

author: justinha
ms.author: justinha
manager: amycolannino
ms.reviewer: calui
---
# App and browser support for passkey (FIDO2) authentication

Microsoft Entra ID allows device-bound [passkeys](./concept-authentication-passkey) to be used for passwordless authentication. This topic covers which native apps, web browsers, and operating systems support passwordless authentication using passkeys with Microsoft Entra ID. Microsoft Entra ID currently supports only device-bound passkeys stored on FIDO2 security keys and in Microsoft Authenticator.

## Native app support (preview)

Microsoft applications provide native support for FIDO2 authentication in preview for all users who have an authentication broker installed for their operating system. The following tables lists which authentication brokers are supported for different operating systems.

| Operating system | Authentication broker           | Supports FIDO2 |
|------------------|---------------------------------|----------------|
| iOS              | Microsoft Authenticator         | &#x2705;       |
| macOS            | Microsoft Intune Company Portal <sup>1</sup> | &#x2705;       |
| Android<sup>2</sup> | Authenticator or Company Portal | &#10060;    |

<sup>1</sup>On macOS, the [Microsoft Enterprise SSO plug-in](~/identity-platform/apple-sso-plugin.md) is required to enable Company Portal as an authentication broker. Devices that run macOS must meet SSO plug-in requirements, including enrollment in mobile device management. For FIDO2 authentication, make sure that you run the latest version of native applications. 

<sup>2</sup>Native app support for FIDO2 on Android is in development.

If a user installed an authentication broker, they can choose to sign in with a security key when they access an application such as Outlook. They're redirected to sign in with FIDO2, and redirected back to Outlook as a signed in user after successful authentication.

If the user hasn't installed an authentication broker, they can still sign in with a security key when they access MSAL-enabled applications that meet the requirements as listed in [Support for FIDO2 authentication](~/identity-platform/support-fido2-authentication.md).

## Browser support

This table shows browser support for authenticating Microsoft Entra ID and Microsoft accounts by using FIDO2. Microsoft accounts are created by consumers for services such as Xbox, Skype, or Outlook.com. 

| OS  | Chrome | Edge | Firefox | Safari |
|:---:|:------:|:----:|:-------:|:------:|
| **Windows**  | &#x2705; | &#x2705; | &#x2705; | N/A |
| **macOS**  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |
| **ChromeOS**  | &#x2705; | N/A | N/A | N/A |
| **Linux**  | &#x2705; | &#10060; | &#10060; | N/A |
| **iOS**  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |
| **Android**  | &#x2705; | &#x2705; | &#x2705; | N/A |

## Browser support for each platform

The following tables show which transports are supported for each platform. Supported device types include **USB**, near-field communication (**NFC**), and bluetooth low energy (**BLE**).

### Windows

| Browser | USB  | NFC | BLE |
|---------|------|-----|-----|
| Edge    | &#x2705; | &#x2705; | &#x2705; |
| Chrome   | &#x2705; | &#x2705; | &#x2705; |
| Firefox   | &#x2705; | &#x2705; | &#x2705; |

#### Minimum browser version

The following are the minimum browser version requirements on Windows. 

| Browser | Minimum version |
| ---- | ---- |
| Chrome | 76 |
| Edge | Windows 10 version 1903<sup>1</sup> |
| Firefox | 66 |

<sup>1</sup>All versions of the new Chromium-based Microsoft Edge support FIDO2. Support on Microsoft Edge legacy was added in 1903.

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

| Browser | USB  | NFC | BLE<sup>1</sup> |
|---------|------|-----|-----|
| Edge    | &#x2705;  | &#x2705; | &#10060; |
| Chrome  | &#x2705;  | &#x2705; | &#10060; |
| Firefox | &#x2705;  | &#x2705; | &#10060; |

<sup>1</sup>BLE security keys aren't supported on Android by Google.

## Known issues

### Mobile device might be prioritized over security key

If you're using Chrome or Edge, the browser might prioritize usage of a passkey that's stored on a mobile device over a passkey that's stored on a security key. 

- Beginning with Windows 11 version 23H2, the operating system shows the following prompt during sign-in. Below **More choices**, choose **Security key** and click **Next**.

  :::image type="content" border="true" source="./media/howto-authentication-passwordless-security-key/security-key.png" alt-text="Screenshot of option to choose security key on Windows 11."::: 

- On earlier versions of Windows, the browser may show the QR pairing screen to continue with using a passkey that's stored on a mobile device. To use a passkey that's stored on a security key instead, insert your security key and touch it to continue. 

  :::image type="content" border="true" source="./media/howto-authentication-passwordless-security-key/insert-device-bound-passkey.png" alt-text="Screenshot of option to insert a device-bound passkey on Windows 10."::: 

### PowerShell support

[Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) supports FIDO2. Some PowerShell modules that use Internet Explorer instead of Edge aren't capable of perfrming FIDO2 authentication. For example, PowerShell modules for SharePoint Online or Teams, or any PowerShell scripts that require admin credentials, don't prompt for FIDO2. 

As a workaround, most vendors can put certificates on the FIDO2 security keys. Certificate-based authentication (CBA) works in all browsers. If you can enable CBA for those admin accounts, you can require CBA instead of FIDO2 in the interim. 

## Next steps
[Enable passwordless security key sign-in](./howto-authentication-passwordless-security-key.md)

<!--Image references-->
[y]: ./media/fido2-compatibility/yes.png
[n]: ./media/fido2-compatibility/no.png

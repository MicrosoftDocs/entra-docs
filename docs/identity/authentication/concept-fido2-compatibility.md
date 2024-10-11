---
title: Support for FIDO2 authentication with Microsoft Entra ID
description: Web browser and native app support for FIDO2 passwordless authentication using Microsoft Entra ID.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 10/11/2024

author: justinha
ms.author: justinha
manager: amycolannino
ms.reviewer: calui
---
# Support for FIDO2 authentication with Microsoft Entra ID

Microsoft Entra ID allows passkeys to be used for passwordless authentication. This article covers which native applications, web browsers, and operating systems support passwordless authentication using passkeys with Microsoft Entra ID.

> [!NOTE]
> Microsoft Entra ID currently supports device-bound passkeys stored on FIDO2 security keys and in Microsoft Authenticator. Microsoft is committed to securing customers and users with passkeys. We are investing in both synced and device-bound passkeys for work accounts.

## Native application support

The following sections cover support for Microsoft and third-party applications. Passkey (FIDO2) authentication with a third-party Identity Provider (IDP) isn't supported in third-party applications using authentication broker, or Microsoft applications on macOS, iOS, or Android at this time.

### Native application support with authentication broker (preview)

Microsoft applications provide native support for FIDO2 authentication in preview for all users who have an authentication broker installed for their operating system. FIDO2 authentication is also supported in preview for third-party applications using the authentication broker.

The following tables lists which authentication brokers are supported for different operating systems.

| OS | Authentication broker           | Supports FIDO2 |
|------------------|---------------------------------|----------------|
| **iOS**              | Microsoft Authenticator         | &#x2705;       |
| **macOS**            | Microsoft Intune Company Portal<sup>1</sup> | &#x2705;       |
| **Android** | Authenticator, Company Portal, or Link to Windows app | &#x2705;    |

<sup>1</sup>On macOS, the [Microsoft Enterprise Single Sign On (SSO) plug-in](~/identity-platform/apple-sso-plugin.md) is required to enable Company Portal as an authentication broker. Devices that run macOS must meet SSO plug-in requirements, including enrollment in mobile device management. For FIDO2 authentication, make sure that you run the latest version of native applications. 

If a user installed an authentication broker, they can choose to sign in with a security key when they access an application such as Outlook. They're redirected to sign in with FIDO2, and redirected back to Outlook as a signed in user after successful authentication.

### Microsoft application support without authentication broker (preview)

The following table lists Microsoft application support for passkey (FIDO2) without an authentication broker. 

| Application    | macOS    | iOS      | Android  |
|----------------|----------|----------|----------|
| [Remote Desktop](/azure/virtual-desktop/compare-remote-desktop-clients) | &#x2705; | &#x2705; | &#10060; |
| [Windows App](/windows-app/compare-platforms-features)  | &#x2705; | &#x2705; | &#10060; |

### Third-party application support without authentication broker

If the user has yet to install an authentication broker, they can still sign in with a passkey when they access MSAL-enabled applications. For more information about requirements for MSAL-enabled applications, see [Support passwordless authentication with FIDO2 keys in apps you develop](~/identity-platform/support-fido2-authentication.md).

## Web browser support

This table shows browser support for authenticating Microsoft Entra ID and Microsoft accounts by using FIDO2. Consumers create Microsoft accounts for services such as Xbox, Skype, or Outlook.com. 

| OS  | Chrome | Edge | Firefox | Safari |
|:---:|:------:|:----:|:-------:|:------:|
| **Windows**  | &#x2705; | &#x2705; | &#x2705; | N/A |
| **macOS**  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |
| **ChromeOS**  | &#x2705; | N/A | N/A | N/A |
| **Linux**  | &#x2705; | &#10060; | &#10060; | N/A |
| **iOS**  | &#x2705; | &#x2705; | &#x2705; | &#x2705; |
| **Android**  | &#x2705; | &#x2705;<sup>1</sup> | &#10060; | N/A |

<sup>1</sup>Support for same-device registration in Edge on Android is coming soon.

## Web browser support for each platform

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
| Safari<sup>2</sup><sup>,</sup><sup>3</sup>   | &#x2705; | N/A | N/A |

<sup>1</sup>NFC and BLE security keys aren't supported on macOS by Apple.

<sup>2</sup>New security key registration doesn't work on these macOS browsers because they don't prompt to set up biometrics or PIN.

<sup>3</sup>See [Sign in when more than three passkeys are registered](#sign-in-when-more-than-three-passkeys-are-registered).

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

| Browser<sup>1</sup><sup>,</sup><sup>3</sup> | Lightning  | NFC | BLE<sup>2</sup> |
|---------|------------|-----|-----|
| Edge    |  &#x2705;  | &#x2705; | N/A | 
| Chrome  |  &#x2705;  | &#x2705; | N/A |
| Firefox |  &#x2705;  | &#x2705; | N/A |
| Safari  |  &#x2705;  | &#x2705; | N/A |

<sup>1</sup>New security key registration doesn't work on iOS browsers because they don't prompt to set up biometrics or PIN.

<sup>2</sup>BLE security keys aren't supported on iOS by Apple.

<sup>3</sup>See [Sign in when more than three passkeys are registered](#sign-in-when-more-than-three-passkeys-are-registered).


### Android

| Browser<sup>1</sup> | USB  | NFC | BLE<sup>2</sup> |
|---------------------|------|-----|-----------------|
| Edge    | &#x2705;  | &#10060; | &#10060; |
| Chrome  | &#x2705;  | &#10060; | &#10060; |
| Firefox | &#10060;  | &#10060; | &#10060; |

<sup>1</sup>Security key registration with Microsoft Entra ID isn't yet supported on Android.

<sup>2</sup>BLE security keys aren't supported on Android by Google.

## Known issues

### Sign in when more than three passkeys are registered

If you registered more than three passkeys, sign in with a passkey might not work. If you have more than three passkeys, as a workaround, click **Sign-in options** and sign in without entering a username.

:::image type="content" border="true" source="media/fido2-compatibility/sign-in-options.png" alt-text="Screenshot of sign-in options.":::

### PowerShell support

[Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) supports FIDO2. Some PowerShell modules that use Internet Explorer instead of Edge aren't capable of performing FIDO2 authentication. For example, PowerShell modules for SharePoint Online or Teams, or any PowerShell scripts that require admin credentials, don't prompt for FIDO2. 

As a workaround, most vendors can put certificates on the FIDO2 security keys. Certificate-based authentication (CBA) works in all browsers. If you can enable CBA for those admin accounts, you can require CBA instead of FIDO2 in the interim. 

## Next steps
[Enable passwordless security key sign-in](./howto-authentication-passwordless-security-key.md)

<!--Image references-->
[y]: ./media/fido2-compatibility/yes.png
[n]: ./media/fido2-compatibility/no.png

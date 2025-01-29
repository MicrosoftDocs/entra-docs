---
title: Support for FIDO2 authentication with Microsoft Entra ID
description: Web browser and native app support for FIDO2 passwordless authentication using Microsoft Entra ID.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 01/29/2025

author: justinha
ms.author: justinha
manager: amycolannino
ms.reviewer: calui
---
# Passkey (FIDO2) authentication matrix with Microsoft Entra ID

Microsoft Entra ID allows passkeys (FIDO2) to be used for multifactor passwordless authentication. This article covers which native applications, web browsers, and operating systems support sign-in using passkey with Microsoft Entra ID.

For enabling FIDO2 security keys to unlock a Windows device, see [Enable FIDO2 security key sign-in to Windows 10 and 11 devices with Microsoft Entra ID](howto-authentication-passwordless-security-key-windows.md).

> [!NOTE]
> Microsoft Entra ID currently supports device-bound passkeys stored on FIDO2 security keys and in Microsoft Authenticator. Microsoft is committed to securing customers and users with passkeys. We are investing in both synced and device-bound passkeys for work accounts.

## [**Web apps**](#tab/web)

| OS  | Chrome | Edge | Firefox | Safari | 
|:---:|:------:|:----:|:-------:|:------:|
| **Windows**  | &#x2705; | &#x2705; | &#x2705; | N/A | 
| **macOS**  | &#x2705; | &#x2705; | &#x2705; | &#x2705; | 
| **ChromeOS**  | &#x2705; | N/A | N/A | N/A | 
| **Linux**  | &#x2705; | &#x2705; | &#x2705; | N/A | 
| **iOS**  | &#x2705; | &#x2705; | &#x2705; | &#x2705; | 
| **Android**  | &#x2705; | &#x2705; | &#10060; | N/A | 

## Considerations for each platform

### Windows
- The best passkey sign-in experience is on Windows 11 version 22H2 or later.
- Sign-in with security key requires one of the following items:
  - Windows 10 version 1903 or later
  - Chromium-based Microsoft Edge
  - Chrome 76 or later
  - Firefox 66 or later
- [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) supports passkey (FIDO2). Some PowerShell modules that use Internet Explorer instead of Edge aren't capable of performing FIDO2 authentication. For example, PowerShell modules for SharePoint Online or Teams, or any PowerShell scripts that require admin credentials, don't prompt for FIDO2.
  - As a workaround, most vendors can put certificates on the FIDO2 security keys. Certificate-based authentication (CBA) works in all browsers. If you can enable CBA for those admin accounts, you can require CBA instead of FIDO2 in the interim. 

### macOS
- Sign-in with passkey requires macOS Catalina 11.1 or later with Safari 14 or later because Microsoft Entra ID requires user verification for multifactor authentication.
- Near-field communication (NFC) and Bluetooth Low Energy (BLE) security keys aren't supported on macOS by Apple.
- New security key registration doesn't work on these macOS browsers because they don't prompt to set up biometrics or PIN.
- See [Sign in when more than three passkeys are registered](#sign-in-when-more-than-three-passkeys-are-registered) for Safari on macOS.

### ChromeOS
- NFC and BLE security keys aren't supported on ChromeOS by Google.
- Security key registration isn't supported on ChromeOS or Chrome browser.

### Linux
- Sign-in with passkey in Microsoft Authenticator isn't supported in Firefox on Linux.

### iOS
- Sign-in with passkey requires iOS 14.3 or later because Microsoft Entra ID requires user verification for multifactor authentication.
- BLE security keys aren't supported on iOS by Apple.
- New security key registration doesn't work on iOS browsers because they don't prompt to set up biometrics or PIN.
- See [Sign in when more than three passkeys are registered](#sign-in-when-more-than-three-passkeys-are-registered).

### Android
- Sign-in with passkey requires Google Play Services 21 or later because Microsoft Entra ID requires user verification for multifactor authentication.
- BLE security keys aren't supported on Android by Google.
- Security key registration with Microsoft Entra ID isn't yet supported on Android.
- Sign-in with passkey isn't supported in Firefox on Android.

---
## [**Native apps**](#tab/native)

The following sections cover support for passkey (FIDO2) authentication in Microsoft and third-party applications with Microsoft Entra ID.

> [!NOTE]
> Passkey authentication with a third-party Identity Provider (IDP) isn't supported in third-party applications using authentication broker, or Microsoft applications on macOS, iOS, or Android at this time.

| OS  | Native apps |
|:---:|:------:|
| **Windows**  | &#x2705; |
| **macOS**    | &#x2705;<sup>1</sup> |
| **ChromeOS** | N/A |
| **Linux**    | &#10060; |
| **iOS**      | &#x2705;<sup>1</sup> |
| **Android**  | &#x2705;<sup>1</sup> |

<sup>1</sup>Requires an authentication broker to be installed on the user's device. Some Microsoft apps support passkey authentication without an authentication broker. 

### Native application support with authentication broker

Microsoft applications provide native support for passkey authentication for all users who have an authentication broker installed for their operating system. Passkey authentication is also supported for third-party applications using the authentication broker.

If a user installed an authentication broker, they can choose to sign in with a passkey when they access an application such as Outlook. They're redirected to sign in with passkey, and redirected back to Outlook as a signed in user after successful authentication.

The following tables lists which authentication brokers are supported for different operating systems.

| OS | Authentication broker           |
|----|---------------------------------|
| **iOS** | Microsoft Authenticator         |
| **macOS** | Microsoft Intune Company Portal |
| **Android** | Authenticator, Company Portal, or Link to Windows app |

#### iOS
- Sign-in with passkey in native apps without [Microsoft Enterprise Single Sign On (SSO) plug-in](~/identity-platform/apple-sso-plugin.md) requires iOS 16.0 or later.
- Sign-in with passkey in native apps with the SSO plug-in requires iOS 17.1 or later.

#### macOS
- On macOS, the [Microsoft Enterprise Single Sign On (SSO) plug-in](~/identity-platform/apple-sso-plugin.md) is required to enable Company Portal as an authentication broker. Devices that run macOS must meet SSO plug-in requirements, including enrollment in mobile device management.
- Sign-in with passkey in native apps with the SSO plug-in requires macOS 14.0 or later.

#### Android
- Sign-in with FIDO2 security key to native apps requires Android 13 or later.
- Sign-in with passkey in Microsoft Authenticator to native apps requires Android 14 or later.

### Microsoft application support without authentication broker 

The following table lists Microsoft application support for passkey (FIDO2) without an authentication broker. 

| Application    | macOS    | iOS      | Android  |
|----------------|----------|----------|----------|
| [Remote Desktop](/azure/virtual-desktop/compare-remote-desktop-clients) | &#x2705; | &#x2705; | &#10060; |
| [Windows App](/windows-app/compare-platforms-features)  | &#x2705; | &#x2705; | &#10060; |

### Third-party application support without authentication broker

If the user has yet to install an authentication broker, they can still sign in with a passkey when they access MSAL-enabled applications. For more information about requirements for MSAL-enabled applications, see [Support passwordless authentication with FIDO2 keys in apps you develop](~/identity-platform/support-fido2-authentication.md).

---

## Known issues

### Sign in when more than three passkeys are registered

If you registered more than three passkeys, sign in with a passkey might not work on iOS or Safari on macOS. If you have more than three passkeys, as a workaround, click **Sign-in options** and sign in without entering a username.

:::image type="content" border="true" source="media/fido2-compatibility/sign-in-options.png" alt-text="Screenshot of sign-in options.":::

## Next steps
[Enable passwordless security key sign-in](./howto-authentication-passwordless-security-key.md)

<!--Image references-->
[y]: ./media/fido2-compatibility/yes.png
[n]: ./media/fido2-compatibility/no.png

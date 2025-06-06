---
title: Support for FIDO2 authentication with Microsoft Entra ID
description: Web browser and native app support for FIDO2 passwordless authentication using Microsoft Entra ID.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 05/12/2025

author: justinha
ms.author: justinha
manager: dougeby
ms.reviewer: calui
---
# Passkey (FIDO2) authentication matrix with Microsoft Entra ID

This article provides a comprehensive overview of passkey (FIDO2) authentication support in Microsoft Entra ID. It outlines compatibility across web browsers, native apps, and operating systems, enabling passwordless multifactor authentication. You'll also find platform-specific considerations, known issues, and guidance for third-party app and identity provider (IdP) support. Use this information to ensure seamless integration and optimal user experiences with passkeys in your environment.

For more information about how to sign in with FIDO2 security keys on a Windows device, see [Enable FIDO2 security key sign-in to Windows 10 and 11 devices with Microsoft Entra ID](howto-authentication-passwordless-security-key-windows.md).

> [!NOTE]
> Microsoft Entra ID currently supports only device-bound passkeys stored on FIDO2 security keys or in Microsoft Authenticator. Microsoft is committed to securing customers and users with passkeys, and plans to support synced passkeys for Microsoft Entra ID.

## [**Web browsers**](#tab/web)

The following section covers support for passkey (FIDO2) authentication in web browsers with Microsoft Entra ID.

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
- Sign-in with security key requires one of the following items:
  - Windows 10 version 1903 or later
  - Chromium-based Microsoft Edge
  - Chrome 76 or later
  - Firefox 66 or later

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
- NFC with FIPS 140-3 certified security keys isn't supported on iOS by Apple.
- New security key registration doesn't work on iOS browsers because they don't prompt to set up biometrics or PIN.
- See [Sign in when more than three passkeys are registered](#sign-in-when-more-than-three-passkeys-are-registered).

### Android
- Sign-in with passkey requires Google Play Services 21 or later because Microsoft Entra ID requires user verification for multifactor authentication.
- BLE security keys aren't supported on Android by Google.
- Security key registration with Microsoft Entra ID isn't yet supported on Android.
- Sign-in with passkey isn't supported in Firefox on Android.

## Known issues

### Sign in when more than three passkeys are registered

If you registered more than three passkeys, sign in with a passkey might not work on iOS or Safari on macOS. If you have more than three passkeys, as a workaround, click **Sign-in options** and sign in without entering a username.

:::image type="content" border="true" source="media/fido2-compatibility/sign-in-options.png" alt-text="Screenshot of sign-in options.":::

## [**Native apps**](#tab/native)

The next sections cover support for passkey (FIDO2) authentication in Microsoft Entra ID for:

- [Microsoft app support with authentication broker](#microsoft-app-support-with-authentication-broker)
- [Microsoft app support without authentication broker](#microsoft-app-support-without-authentication-broker)
- [Third-party app support without authentication broker](#third-party-app-support-without-authentication-broker)
- [Third-party Identity Provider (IdP) support](#third-party-idp-support)

### Microsoft app support with authentication broker

Microsoft apps provide native support for passkey authentication for all users who have an authentication broker installed for their operating system. Passkey authentication is also supported for third-party apps using the authentication broker.

If a user installed an authentication broker, they can choose to sign in with a passkey when they access an app such as Outlook. They're redirected to sign in with passkey, and redirected back to Outlook as a signed in user after successful authentication.

The following tables lists which authentication brokers are supported for different operating systems.

| OS | Authentication broker           |
|----|---------------------------------|
| **iOS** | Microsoft Authenticator         |
| **macOS** | Microsoft Intune Company Portal |
| **Android** | Authenticator, Company Portal, or Link to Windows app |

### Microsoft app support without authentication broker 

The following table lists Microsoft app support for passkey (FIDO2) without an authentication broker. Update your apps to the latest version to make sure they work with passkeys.

| app    | macOS    | iOS      | Android  |
|----------------|----------|----------|----------|
| [Remote Desktop](/azure/virtual-desktop/compare-remote-desktop-clients) | &#x2705; | &#x2705; | &#x2705; |
| [Windows App](/windows-app/compare-platforms-features)  | &#x2705; | &#x2705; | &#x2705; |
| Microsoft 365 Copilot (Office) | N/A | &#x2705; | &#10060; |
| Word | &#x2705; | &#x2705; | &#10060; |
| PowerPoint | &#x2705; | &#x2705; | &#10060; |
| Excel | &#x2705; | &#x2705; | &#10060; |
| OneNote | &#x2705; | &#x2705; | &#10060; |
| Loop | N/A | &#x2705; | &#10060; |
| OneDrive | &#x2705; | &#x2705; | &#10060; |
| Outlook | &#x2705; | &#x2705; | &#10060; |
| Teams | &#x2705; | &#x2705; | &#10060; |
| Edge | &#x2705; | &#x2705; | &#10060; |

### Third-party app support without authentication broker

If the user has yet to install an authentication broker, they can still sign in with a passkey when they access MSAL-enabled apps. For more information about requirements for MSAL-enabled apps, see [Support passwordless authentication with FIDO2 keys in apps you develop](~/identity-platform/support-fido2-authentication.md).

### Third-party IdP support 

> [!NOTE]
> Passkey authentication with a third-party IdP isn't supported in third-party apps using authentication broker, or Microsoft apps on Android at this time.

On iOS and Mac devices that are managed by Mobile Device Management (MDM), third-party IdPs can implement their own single sign-on (SSO) extension.
Apple's extensible SSO framework on MDM-managed devices enables identity providers to intercept network requests directed to their URLs. 
When the SSO extension of the identity provider intercepts a network request, they can implement a custom authentication handshake. 
This allows them to use a system browser or native Apple APIs for passkey authentication without needing changes in Microsoft applications.

For more information, see the following Apple documentation:

- [ExtensibleSingleSignOn Device Management Profile](https://developer.apple.com/documentation/devicemanagement/extensiblesinglesignon)
- [Enterprise single sign-on (SSO) API collection](https://developer.apple.com/documentation/authenticationservices/enterprise-single-sign-on-sso?language=objc)

## Considerations for each platform

### Windows
- Sign-in with FIDO2 security key to native apps requires Windows 10 version 1903 or later.
- Sign-in with passkey in Microsoft Authenticator to native apps requires Windows 11 version 22H2 or later.
- [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) supports passkey (FIDO2). Some PowerShell modules that use Internet Explorer instead of Edge aren't capable of performing FIDO2 authentication. For example, PowerShell modules for SharePoint Online or Teams, or any PowerShell scripts that require admin credentials, don't prompt for FIDO2.
  - As a workaround, most vendors can put certificates on the FIDO2 security keys. Certificate-based authentication (CBA) works in all browsers. If you can enable CBA for those admin accounts, you can require CBA instead of FIDO2 in the interim. 

#### iOS
- Sign-in with passkey in native apps without [Microsoft Enterprise Single Sign On (SSO) plug-in](~/identity-platform/apple-sso-plugin.md) requires iOS 16.0 or later.
- Sign-in with passkey in native apps with the SSO plug-in requires iOS 17.1 or later.

#### macOS
- On macOS, the [Microsoft Enterprise Single Sign On (SSO) plug-in](~/identity-platform/apple-sso-plugin.md) is required to enable Company Portal as an authentication broker. Devices that run macOS must meet SSO plug-in requirements, including enrollment in mobile device management.
- Sign-in with passkey in native apps with the SSO plug-in requires macOS 14.0 or later.

#### Android
- Sign-in with FIDO2 security key to native apps requires Android 13 or later.
- Sign-in with passkey in Microsoft Authenticator to native apps requires Android 14 or later.
- Sign-in with Yubico-manufactured FIDO2 security keys with YubiOTP enabled might not work on Samsung Galaxy devices. As a workaround, users can disable YubiOTP and attempt to sign in again. For more information, see [FIDO issues on Samsung devices](https://support.yubico.com/hc/articles/18801283920156-FIDO-issues-on-Samsung-devices).

---

## Next steps
[Enable passwordless security key sign-in](./howto-authentication-passwordless-security-key.md)

<!--Image references-->
[y]: ./media/fido2-compatibility/yes.png
[n]: ./media/fido2-compatibility/no.png

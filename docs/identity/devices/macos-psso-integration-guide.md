---
title: Integrate macOS Platform Single Sign-On (PSSO) into your MDM solution
description: Learn how to integrate macOS Platform Single Sign-On (PSSO) into your MDM solution.
ms.service: entra-id
ms.subservice: devices
ms.topic: how-to
ms.date: 07/23/2025
ms.author: godonnell
author: garrodonnell
manager: dougeby

#Customer intent: As a developer for a 3rd party MDM solution, I want to integrate macOS Platform Single Sign-On (PSSO) into my MDM solution so that I can provide a seamless sign-in experience for users on macOS devices.
---

# Integrate macOS Platform Single Sign-On (PSSO) into your MDM solution
Platform Single Sign-On (PSSO) for macOS devices is a feature that allows users to sign in to macOS devices using their Microsoft Entra credentials. This feature provides a seamless sign-in experience for users and helps organizations manage access to resources on macOS devices.

In this guide, you learn how to integrate macOS Platform Single Sign-On (PSSO) into your MDM solution. This guide is intended for developers of 3rd party MDM solutions who want to support PSSO for macOS devices.

## Prerequisites
Before getting started, we recommend that you familiarize yourself with the following articles:
* Any documentation you were provided by Intune for Partner Managed Device Compliance Integration APIs
* [Microsoft Enterprise Single Sign-On (SSO) plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md).
* [macOS Platform Single Sign-on overview](./macos-psso.md).

## Minimum required payload properties

The following settings and payload properties are required for use with the [Microsoft Enterprise Single Sign-On (SSO) plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md). Ensure these settings are configured with the following values and add other settings as required to ensure proper SSO for your apps.

| **Setting** | **Value(s)** |
|---|---|
| Extension identifier  | com.microsoft.CompanyPortalMac.ssoextension  |
| Team identifier  | UBF8T346G9  |
| Authentication Method (Deprecated)    [Required for OS13 devices]  | One of...  Password <br> UserSecureEnclaveKey    |
| Authentication method  (OS14+ devices)  | One of...  Password <br> UserSecureEnclaveKey <br> Smartcard (macOS 14+)  |
| Screen Locked Behavior  | Do Not Handle  |
| Type  | Redirect  |
| URLs  | Supply the following URLs <br>  https://login.microsoftonline.com <br> https://login.microsoft.com <br> https://sts.windows.net <br> https://login.partner.microsoftonline.cn <br> https://login.chinacloudapi.cn <br> https://login.microsoftonline.us <br> https://login-us.microsoftonline.com  |
| Use Shared Device Keys  | Enable “Use Shared Device Keys” for the best PSSO experience and to avoid unnecessary re-registration experiences if enabled later.  |

## Event notifications
You may need to perform other actions upon completion of various PSSO events depending on the event's status. The following is a list of notifications posted by the Entra ID SSO extension for various PSSO events. MDMs can choose to listen to these notifications and perform appropriate actions. 

### Events
Consider using these events to record telemetry or monitoring for errors or success cases. Once Device & User registration have completed you should mark the device compliant via the compliance API service. 

|Notification Name  |Trigger  |
|---|---|
|Microsoft.PlatformSSO.DeviceRegistration.Started  |Device registration started  |
|Microsoft.PlatformSSO.DeviceRegistration.Succeeded  |Device registration finished  |
|Microsoft.PlatformSSO.DeviceRegistration.Failed  |Device registration failed  |
|Microsoft.PlatformSSO.UserRegistration.Started  |User registration started  |
|Microsoft.PlatformSSO.UserRegistration.Succeeded  |User registration finished  |
|Microsoft.PlatformSSO.UserRegistration.Failed  |User registration failed  |
|Microsoft.PlatformSSO.Registration.Succeeded  |Both device and user registration finished  |
|Microsoft.PlatformSSO.Registration.Failed  |Either device or user registration failed  |
|Microsoft.PlatformSSO.Registration.Removed  |Platform SSO registration removed  |

## Related content

* [macOS Platform Single Sign-on overview](./macos-psso.md)
* [Microsoft Enterprise Single Sign-On (SSO) plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)
* [Configure Platform Single Sign-On (PSSO) for macOS devices in Microsoft Intune](/intune/intune-service/configuration/platform-sso-macos)
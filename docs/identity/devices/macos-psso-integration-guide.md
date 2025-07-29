---
title: Integrate macOS Platform Single Sign On (PSSO) into your MDM solution
description: Learn how to integrate macOS Platform Single Sign On (PSSO) into your MDM solution.
ms.service: entra-id
ms.subservice: devices
ms.topic: how-to
ms.date: 07/23/2025
ms.author: godonnell
author: garrodonnell
manager: dougeby

#Customer intent: As a developer for a 3rd party MDM solution, I want to integrate macOS Platform Single Sign On (PSSO) into my MDM solution so that I can provide a seamless sign-in experience for users on macOS devices.
---

# Integrate macOS Platform Single Sign On (PSSO) into your MDM solution
Platform Single Sign On (PSSO) for macOS devices is a feature that allows users to sign in to macOS devices using their Microsoft Entra credentials. This feature provides a seamless sign-in experience for users and helps organizations manage access to resources on macOS devices.

In this guide, you will learn how to integrate macOS Platform SSO into your MDM solution. This guide is intended for developers of 3rd party MDM solutions who want to support Platform SSO for macOS devices.

## Prerequisites
Before getting started, we recommend that you familiarize yourself with the following articles:
* Any documentation you were provided by Intune for Partner Managed Device Compliance Integration APIs
* [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md).
* [macOS Platform Single Sign-on overview](./macos-psso.md).

## Minimum required payload properties

The following settings and payload properties are required for use with the [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md). Please ensure these are configured with the following values and add other settings as required to ensure proper SSO for your apps.

| **Setting ** | **Value(s) ** |
|---|---|
| Extension identifier  | com.microsoft.CompanyPortalMac.ssoextension  |
| Team identifier  | UBF8T346G9  |
| Authentication Method (Deprecated)    [Reqd for OS13 devices]  | One of...  Password  UserSecureEnclaveKey    |
| Authentication method  (OS14+ devices)  | One of...  Password  UserSecureEnclaveKey  Smartcard (macOS 14+)  |
| Screen Locked Behavior  | Do Not Handle  |
| Type  | Redirect  |
| URLs  | Supply the following URLs  https://login.microsoftonline.com  https://login.microsoft.com  https://sts.windows.net  https://login.partner.microsoftonline.cn  https://login.chinacloudapi.cn  https://login.microsoftonline.us  https://login-us.microsoftonline.com  |
| Use Shared Device Keys  | Enable “Use Shared Device Keys” for the best PSSO experience and to avoid unnecessary re-registration experiences if enabled later.  |

## Event notifications
You may need to perform additional actions upon completion of various Platform SSO events depending on the event's status. Below is the list of notifications that will be posted by the Entra ID SSO extension for various platform SSO events. MDMs can choose to listen to these and perform appropriate actions as needed. 

### Events
Consider using these events to record telemetry or monitoring for errors or success cases. Once Device & User registration have completed you should mark the device compliant via the compliance API service. 

|Notification Name  |Trigger  |
|---|---|
|Microsoft.PlatformSSO.DeviceRegistration.Started  |Device registration has started  |
|Microsoft.PlatformSSO.DeviceRegistration.Succeeded  |Device registration finished  |
|Microsoft.PlatformSSO.DeviceRegistration.Failed  |Device registration failed  |
|Microsoft.PlatformSSO.UserRegistration.Started  |User registration has started  |
|Microsoft.PlatformSSO.UserRegistration.Succeeded  |User registration has finished  |
|Microsoft.PlatformSSO.UserRegistration.Failed  |User registration has failed  |
|Microsoft.PlatformSSO.Registration.Succeeded  |Both device and user registration finished  |
|Microsoft.PlatformSSO.Registration.Failed  |Either device or user registration has failed  |
|Microsoft.PlatformSSO.Registration.Removed  |Platform SSO registration has been removed  |

## Related content

* [macOS Platform Single Sign-on overview](./macos-psso.md)
* [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)
* [Configure Platform SSO for macOS devices in Microsoft Intune](/intune/intune-service/configuration/platform-sso-macos)
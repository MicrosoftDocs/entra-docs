---
title: Learn about the Global Secure Access clients for Microsoft Entra Private Access and Microsoft Entra Internet Access
description: Learn about the Global Secure Access clients for Microsoft Entra Private Access and Microsoft Entra Internet Access.
author: kenwith    
ms.author: kenwith
manager: dougeby
ms.topic: concept-article
ms.date: 01/20/2026
ms.service: global-secure-access
ms.reviewer: frankgomulka
ai-usage: ai-assisted
---

# Global Secure Access client overview

The Global Secure Access client gives organizations control over network traffic at the end-user computing device. With this client, organizations can route specific traffic profiles through Microsoft Entra Internet Access and Microsoft Entra Private Access. Routing traffic in this method allows for more controls like continuous access evaluation (CAE), device compliance, or multifactor authentication to be required for resource access.

The Global Secure Access client uses a lightweight filter (LWF) driver to acquire traffic. In contrast, many other Security Service Edge (SSE) solutions integrate as a virtual private network (VPN) connection. This distinction allows the Global Secure Access client to coexist with these other solutions. The Global Secure Access client acquires traffic based on the traffic forwarding profiles you configure.


## Available clients

You install the client on a device, such as computer or phone, and then use Global Secure Access settings in the Microsoft Entra admin center to secure the device. Clients are currently available for Windows, Android, macOS, and iOS. To learn how to install the Windows client, see [Global Secure Access client for Windows](how-to-install-windows-client.md). To learn how to install the Android client, see [Global Secure Access client for Android](./how-to-install-android-client.md). To learn how to install the macOS client, see [Global Secure Access client for macOS](how-to-install-macos-client.md). To learn how to install the iOS client, see [Global Secure Access client for iOS](how-to-install-ios-client.md).

## BYOD support (preview)

Global Secure Access client supports bring your own device (BYOD) scenarios so users can access company resources without device enrollment to an MDM. As a tenant administrator, enable Global Secure Access traffic profiles for members, including internal guests. The client supports automatic Microsoft Entra device registration.

### Windows

- BYOD support without device enrollment is available through Microsoft Entra device registration.
- Supports secure access on Microsoft Entra registered Windows devices (not domain-joined).
- Only private application traffic is supported. Enable Private Access traffic profiles for these users.
- If the device isn’t registered or joined, the client registers the device to your tenant during first sign-in.
- If the device isn’t joined and has multiple registrations, the user selects the tenant at sign-in with Microsoft Entra user of the tenant.

> [!IMPORTANT]
> On Windows devices that are Microsoft Entra joined or hybrid joined, the client always connects to the joined tenant.

### Android

- BYOD support without device enrollment is available through Microsoft Authenticator or the Microsoft Intune Company Portal.
- Do the following on the device:
    1. Install Microsoft Authenticator from the App Store and register the device to the tenant or install the Company Portal app (no device enrollment required).
    2. Install the Microsoft Defender app from Google Play and complete sign-in.
- Enable required traffic profiles for these users.
- A device-wide VPN profile is created. The Global Secure Access tile is off by default; the user must turn it on to send Private Access traffic.

### iOS/iPadOS

- BYOD support without device enrollment is available through Microsoft Authenticator app.
- Do the following on the device:
    1. Install Microsoft Authenticator from the App Store and register the device to the tenant, or install the Company Portal app (no device enrollment required).
    2. Install the Microsoft Defender app from the App Store and complete sign-in.
- Enable required traffic profiles for these users.
- A device-wide VPN profile is created. The Global Secure Access toggle is off by default; the user must turn it on to send Private Access traffic.

### macOS

BYOD support without device enrollment is available through Microsoft Entra device registration.
- Install and register the device using the Company Portal (no device enrollment required).
- Enable required traffic profiles for these users.

## Tenant selection and switching (preview)

How the Global Secure Access client selects a tenant depends on platform and Microsoft Entra device state.

### Key concepts
- Microsoft Entra joined or hybrid joined: Windows-only device state that establishes tenant ownership and management.
- Microsoft Entra registered: User-associated device identity for BYOD and unmanaged devices across platforms.

### Platform behavior

| Platform/device state | Connection target | All Traffic support | Private Access only support | Notes |
|---|---|---:|---:|---|
| Windows | Always connects to the joined tenant. For non-joined tenants, user selects a tenant at first sign-in; remains connected to that tenant | From Microsoft Entra Joined and Hybrid joined device | From Microsoft Entra Registered device | For non-joined devices, multiple registrations allowed, no switching between registered tenants for now. Allows user to switch to a resource tenant using B2B collaboration. |
| macOS | User selects a tenant at first sign-in; remains connected to that tenant | Microsoft Entra Registered with and without device enrolment | ❌ | Applies to enrolled and unmanaged devices with Company Portal. |
| Android | User selects a tenant at first sign-in; remains connected to that tenant | Microsoft Entra Registered with and without device enrolment | ❌ | Applies to enrolled devices with Company Portal and unmanaged devices with Company portal and Authenticator app. |
| iOS/iPadOS | User selects a tenant at first sign-in; remains connected to that tenant | Microsoft Entra Registered with and without device enrolment | ❌ | Applies to enrolled devices with Company Portal and unmanaged devices with Authenticator app. |

### Summary
- ✅ Device join takes precedence on Windows; no tenant switching.
- ✅ Registered devices choose a tenant once at initial sign-in.

## Related content

- [Global Secure Access client for Windows](how-to-install-windows-client.md)
- [Global Secure Access client for Android](how-to-install-android-client.md)
- [Global Secure Access client for macOS](how-to-install-macos-client.md)
- [Global Secure Access client for iOS](how-to-install-ios-client.md)
- [Client for Windows version release notes](reference-windows-client-release-history.md)

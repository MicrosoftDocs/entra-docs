---
title: Learn about bring your own device (BYOD) with the Global Secure Access clients for Microsoft Entra Private Access and Microsoft Entra Internet Access
description: Learn about bring your own device (BYOD) with the Global Secure Access clients for Microsoft Entra Private Access and Microsoft Entra Internet Access.
author: kenwith    
ms.author: kenwith
manager: dougeby
ms.topic: concept-article
ms.date: 01/22/2026
ms.service: global-secure-access
ms.reviewer: gauthamca
ai-usage: ai-assisted
---

# Bring Your Own Device (Preview)

The Global Secure Access client supports bring your own device (BYOD) scenarios so users can access company resources. As a tenant administrator, enable Global Secure Access traffic profiles for members, including internal guests. The client supports automatic Microsoft Entra device registration.

## Windows

- Supports secure access on Microsoft Entra registered Windows devices (not domain-joined).
- Only private application traffic is supported. Enable Private Access traffic profiles for these users.
- If the device isn’t registered or joined, the client registers the device to your tenant during first sign-in.
- If the device isn’t joined and has multiple registrations, the user selects the tenant at sign-in with Microsoft Entra user of the tenant.

> [!IMPORTANT]
> On Windows devices that are Microsoft Entra joined or hybrid joined, the client always connects to the joined tenant.

## Android

- BYOD support without device enrollment is available using Microsoft Authenticator or the Microsoft Intune Company Portal through Microsoft Entra device registration.
- On the device:
    1. Install Microsoft Authenticator from the App Store and register the device to the tenant or install the Company Portal app (no device enrollment required).
    2. Install the Microsoft Defender app from Google Play and complete sign-in.
- Enable required traffic profiles for these users.
- A device-wide VPN profile is created. The Global Secure Access tile is off by default; the user must turn it on to send Private Access traffic.

## macOS

BYOD support without device enrollment is available through Microsoft Entra device registration.
- Install and register the device using the Company Portal (no device enrollment required).
- Enable required traffic profiles for these users.

## Tenant selection and switching (Preview)

How the Global Secure Access client selects a tenant depends on platform and Microsoft Entra device state.

### Key concepts
- Microsoft Entra joined or hybrid joined: Windows-only device state that establishes tenant ownership and management.
- Microsoft Entra registered: User-associated device identity for BYOD and unmanaged devices across platforms.

### Platform behavior

| Platform/device state | Connection target | All Traffic support | Private Access only support | Notes |
|---|---|---:|---:|---|
| Windows | Always connects to the joined tenant. For non-joined tenants, user selects a tenant at first sign-in; remains connected to that tenant | From Microsoft Entra Joined and Hybrid joined device | From Microsoft Entra Registered device | For non-joined devices, multiple registrations allowed, no switching between registered tenants for now. Allows user to switch to a resource tenant using B2B collaboration. |
| macOS | User selects a tenant at first sign-in; remains connected to that tenant | Microsoft Entra Registered with and without device enrollment | ❌ | Applies to enrolled and unmanaged devices with Company Portal. |
| Android | User selects a tenant at first sign-in; remains connected to that tenant | Microsoft Entra Registered with and without device enrollment | ❌ | Applies to enrolled devices with Company Portal and unmanaged devices with Company portal and Authenticator app. |

### Summary
- ✅ Device join takes precedence on Windows; no tenant switching.
- ✅ Registered devices choose a tenant once at initial sign-in.

## Related content

- [Global Secure Access client for Windows](how-to-install-windows-client.md)
- [Global Secure Access client for Android](how-to-install-android-client.md)
- [Global Secure Access client for macOS](how-to-install-macos-client.md)
- [Global Secure Access client for iOS](how-to-install-ios-client.md)
- [Client for Windows version release notes](reference-windows-client-release-history.md)

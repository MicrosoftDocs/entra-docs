---
title: The Global Secure Access Client for Android (preview)
description: Install the Global Secure Access Client for Android to enable connectivity to Microsoft's Security Edge Solutions, Microsoft Entra Internet Access and Microsoft Entra Private Access.
ms.service: network-access
ms.topic: how-to
ms.date: 11/06/2023
ms.author: kenwith
author: kenwith
manager: amycolannino
ms.reviewer: ashishj
---
# Global Secure Access Client for Android (preview)

Learn how to install the Global Secure Access Client for Android.

## Prerequisites

- Device installation permissions on the device are required for installation.
- The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- The Microsoft Defender for Endpoint on Android firewall/proxy must be configured to [enable access to the Microsoft Defender for Endpoint service URLs](/microsoft-365/security/defender-endpoint/configure-environment).
- Android devices must be running Android 8.0 or later.
- The Microsoft Authenticator *and* Intune Company Portal apps must be installed on the device.
- Device enrollment is required for Intune device compliance policies to be enforced.

### Known limitations

- Mobile devices running *Android (Go edition)* are currently not supported.

## Download the client

The most current version of the Global Secure Access Client can be downloaded from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access (Preview)** > **Devices** > **Clients**.
1. Select **Download**.

## Install the client

Install the client on the Android device.

## Related content

- [Enable universal tenant restrictions](how-to-universal-tenant-restrictions.md)

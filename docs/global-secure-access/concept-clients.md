---
title: Learn about the Global Secure Access clients for Microsoft Entra Private Access and Microsoft Entra Internet Access
description: Learn about the Global Secure Access clients for Microsoft Entra Private Access and Microsoft Entra Internet Access.
author: kenwith    
ms.author: kenwith
manager: amycolannino
ms.topic: concept-article
ms.date: 02/29/2024
ms.service: global-secure-access
ms.reviewer: frankgomulka
---

# Global Secure Access clients

The Global Secure Access client allows organizations control over network traffic at the end-user computing device, giving organizations the ability to route specific traffic profiles through Microsoft Entra Internet Access and Microsoft Entra Private Access. Routing traffic in this method allows for more controls like continuous access evaluation (CAE), device compliance, or multifactor authentication to be required for resource access.

The Global Secure Access client acquires traffic using a lightweight filter (LWF) driver, while many other Security Service Edge (SSE) solutions integrate as a virtual private network (VPN) connection. This distinction allows the Global Secure Access client to coexist with these other solutions. The Global Secure Access client acquires traffic based on the traffic forwarding profiles you configure.


## Available clients

You install the client on a device, such as computer or phone, and then use Global Secure Access settings in the Microsoft Entra admin center to secure the device. Clients are currently available for Windows and Android. To learn how to install the Windows client, see [Global Secure Access client for Windows](how-to-install-windows-client.md). To learn how to install the Android client, see [Global Secure Access client for Android](./how-to-install-android-client.md).

## Related content

- [Global Secure Access client for Windows](how-to-install-windows-client.md)
- [Global Secure Access client for Android](how-to-install-android-client.md)

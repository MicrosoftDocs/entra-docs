---
title: Learn How to Configure Explicit Forward Proxy HTTP Header Session Management
description: Learn How to Configure Explicit Forward Proxy HTTP Header Session Management
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# HTTP Header Session Management

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

You can configure Explicit Forward Proxy (preview) to rely on the private IP addresses of devices on your network to associate authenticated users with their devices. To use HTTP header session management with Explicit Forward Proxy (EFP), you need to securely communicate the private IP address of the device with the EFP service.

## Prerequisites
- The account used to configure HTTP Header Session Management has an active Global Secure Access Administrator role assignment.
- Your organization has an existing proxy service that can perform Transport Layer Security (TLS) inspection and header injection before sending traffic to EFP.
- Client devices that use EFP with HTTP Header Session Management trust the TLS certificate root CA.

## Configuration Steps

1. Navigate to the Microsoft Entra admin center and enable HTTP Header Session Management under Global Secure Access > Session Management > Explicit Forward Proxy
1. Configure your outbound proxy service to intercept traffic to *.internet.efp.globalsecureaccess.microsoft.com
1. Configure your outbound proxy service to inject x-ms-gsa-efp-forwarded-for header with the value of the private IP address detected on the incoming connection
1. Configure Microsoft Entra Conditional Access policy to allow authentication to EFP only from the known networks that your organization trusts.

>[!IMPORTANT]
>Don't skip the Conditional Access policy step. HTTP headers can be easily manipulated and as such, it's essential that x-ms-gsa-efp-forwarded-for is only sent from networks that you trust.

## Next Steps
[Learn about Explicit Forward Proxy Session Management Concepts](concept-efp-session-management.md)
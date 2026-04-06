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

You can configure EFP to rely on the private IP addresses of devices on your network to associate authenticated users with their devices. To use HTTP header session management with EFP, you need to securely communicate the private IP address of the device with the EFP service.

## Pre-requisites
- The account used to configure HTTP Header Session Management in the Microsoft Entra Portal has an active Global Secure Access Administrator role assignment.
- Your organization has an existing proxy service that can perform TLS termination and header injection prior to sending traffic to Explicit Forward Proxy.
- Client devices that will use EFP with HTTP Header Session Management trust the TLS certificate root CA.

## Configuration Steps

1. Navigate to the Entra Portal and enable HTTP Header Session Management under Global Secure Access > Session Management > Explicit Forward Proxy
1. Configure your outbound proxy service to intercept traffic to *.internet.efp.globalsecureaccess.microsoft.com
1. Configure your outbound proxy service to inject x-ms-gsa-efp-forwarded-for header with the value of the private IP address detected on the incoming connection
1. Configure Entra ID Conditional Access policy to allow authentication to EFP only from the known networks that your organization trusts.

>[!IMPORTANT]
>Do not skip the Conditional Access policy step. HTTP headers can be easily manipulated and as such, it is essential that x-ms-gsa-efp-forwarded-for is only sent from networks that you trust.

## Next Steps
[Learn about Explicit Forward Proxy Session Management Concepts](concept-efp-session-management.md)
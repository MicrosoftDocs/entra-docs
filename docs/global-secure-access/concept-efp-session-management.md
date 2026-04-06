---
title: Learn about Explicit Forward Proxy Session Management Concepts
description: Learn about Explicit Forward Proxy Session Management Concepts
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# Explicit Forward Proxy Session Management

Explicit Forward Proxy (EFP) uses Entra ID authentication and authorization to validate user access prior to allowing network traffic. This ensures support for Entra ID Conditional Access, modern credentials like passkeys, and Continuous Access Evaluation (CAE) with session revocation. Classic proxy authorization methods, such as basic, digest, NTLM, or Kerberos, are not supported.

> [!IMPORTANT]
> We recommend that you enable a Conditional Access policy that only allows access to EFP from your trusted networks.

## Session Management Settings

EFP supports smart session management (enabled by default), HTTP header-based session affinity (can be enabled), IP-based session affinity (enabled by default), and cookie-based session affinity. Different capabilities available with different affinity methods are described in the table below:

| | IP affinity | Session ID	| HTTP header |
| --- | --- | --- | --- |
| Enabled by default | Yes | Yes | No |
| Can be disabled | No | Yes | Yes |
| Supports User Profile Assignments | No | Yes | Yes |
| Relies on EFP-based PAC hosting | No | Yes | No |

## EFP Smart Session Management

Browsers request PAC files when the browser is first started, upon change of network location, change in power state of the device, and every 12 hours. When EFP is used for PAC file hosting, EFP will return a unique session ID as part of the EFP proxy endpoint defined in the PAC file. Each time PAC file is requested, a new session ID is generated. This allows EFP to map unique browsing sessions to specific authenticated users.

## HTTP Header Session Management

EFP also supports HTTP header session management. You can configure your organization’s outbound proxy service to inject x-ms-gsa-efp-forwarded-for header to all traffic for *.interent.efp.globalsecureaccess.microsoft.com with a unique IP address of the device (for example, internal IP address). This will allow EFP to use x-ms-gsa-efp-forwarded-for values to map authenticated users to EFP sessions.

## IP-based Session Affinity

Once the user session is authenticated and authorized, EFP records the source IP of that user connection. Subsequent requests from the same IP address are allowed. If no other session management mechanism can be negotiated besides the source IP, EFP falls back to baseline security profile enforcement.

## Cookie-based Session Affinity

To be completed.

## Continuous Access Evaluation

If the user session is revoked (for example, due to account becoming disabled, password reset/change, MFA methods reset, or user session revocation), EFP will receive a Continuous Access Evaluation (CAE) signal from Entra ID and invalidate sessions associated with that user identity in near real time (2-5 minutes). The user will be required to re-authenticate with Entra ID, and if successful, EFP connectivity will be re-established.

## Next Steps

- [Learn How to Configure Explicit Forward Proxy](how-to-configure-explicit-forward-proxy.md)
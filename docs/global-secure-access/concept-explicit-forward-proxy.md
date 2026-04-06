---
title: Learn about Explicit Forward Proxy Concepts
description: Learn about Explicit Forward Proxy Concepts
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# Explicit Forward Proxy Overview

Explicit Forward Proxy (EFP) is one of the traffic acquisition mechanisms that is useful in scenarios where installation of the Global Secure Access (GSA) client is difficult or not possible. EFP can be a simple and effective mechanism to protect internet traffic when users use browsers to access resources from multi-session Virtual Desktop Infrastructure (VDI), from browsers on Linux desktops, or on lightly managed devices.
EFP relies on proxy automatic configuration (PAC) files to configure browsers for Entra Internet Access connectivity. HTTP CONNECT protocol is used to facilitate network communication between the end user and the Entra Internet Access service. Entra ID and Entra ID Conditional Access are used to authenticate and authorize user access to internet resources.

## Traffic Flow
 
| Step | Details |
| --- | --- |
| **1** | EFP PAC configuration and intermediate certificate used for TLS inspection is delivered to the device. |
| **2** | User attempts to access an internet resource. EFP redirects the user to Entra ID. |
| **3** | User signs in to Entra ID either explicitly or via single sign on. Entra ID checks Conditional Access policies to authorize user access. |
| **4** | User is redirected to EFP with the Entra ID authorization code. |
| **5** | Entra Internet Access security policies are applied and an access decision is made. If allowed, user can retrieve the internet resource. |

## PAC File Hosting
Browsers need to retrieve the proxy configuration at the time of startup. There are two main approaches to achieve this:
**	EFP PAC file hosting. Browsers can be configured with tenant-specific PAC file URLs hosted by Entra Internet Access. These PAC files contain recommended configuration for EFP. 
** Self-hosting of PAC files. You can host PAC files on a web server that you manage. This will allow you to customize contents of the PAC files. Smart session management does not work when you self-host the PAC files.

> [!Note]
> Future updates to EFP will allow you to upload custom PAC files to be hosted by Entra Internet Access. Until then, you need to self-host the PAC files if you require customization of PAC file contents.

## Session Management

Modern web applications are complex and interactive redirection to Entra ID for user authorization may not be possible in all use cases. EFP uses several mechanisms to balance the user session affinity while maintaining optimal user experience. Foundational element of EFP session management is source IP affinity. Once the user is authenticated initially, the egress IP address that is visible to the EFP service is cached in relation to that user session. Given that a given IP address may be in use by multiple users/devices, you should configure an Entra ID Conditional Access policy to only allow company networks to access resources using EFP as the network channel. If EFP cannot establish an additional session management mechanism beyond the source IP address of the user, only the baseline security profile will apply.

You can choose to enable smart session management in EFP settings. Smart session management relies on EFP PAC file hosting and introduces a random session identifier each time the PAC file is requested. This ensures that each user in your organization will have a unique proxy FQDN, allowing EFP service to use that unique identifier together with the source IP to maintain the session after initial user authorization.
Optionally, you can also enable header-based session affinity and configure your egress proxy to send user’s private IP address in a specific HTTP header on all traffic to the EFP FQDNs. If EFP detects that HTTP header, it will use it together with the source IP for session affinity. 

Smart session management and HTTP headers can be enabled simultaneously. If EFP detects both HTTP headers and random identifier, it will prefer the random identifier for session management.

| EFP Session Management Features Enabled | Affinity method	| Security Profiles Applied |
| --- | --- | --- |
| None | Source IP | Baseline only |
| Smart Session Management | Source IP + Session ID | User-specific supported |
| HTTP Header | Source IP + private IP from HTTP header | User-specific supported |
| Smart Session management AND HTTP Header | Same as above. Source IP + Session ID takes precedence. | User-specific supported |

> [!Note]
> Even with smart session management and HTTP header session affinity enabled, if a particular request is missing both values, EFP reverts to relying on source IP-based affinity and baseline policies.

## Session Lifetime and Access Revocation

Users must authenticate with Entra ID to use EFP. Session management artifacts, such as smart session management, source IP, or HTTP headers, rely on the lifetime of the Entra ID access token, which is defaulted to a random value between 60 and 90 minutes. During the session lifetime, EFP will attempt to re-validate the user at regular intervals, when EFP detects that the request is likely to be triggered by the end user (for example, navigating to a new web resource). In most cases, this re-validation will be seamless to the end user, based on the Entra ID session cookie artifact. If successful, user’s cache entries will be extended by the lifetime of the new access token.

EFP supports Continuous Access Evaluation (CAE). This means that the user’s EFP session will be reset with identity change events, such as password reset/change, reset of MFA methods, session revocation, and any other events that triggers CAE. In that case, explicit navigation to a new web resource will trigger the authentication flow within 2-5 minutes, requiring the user to sign in to Entra ID.

## Next Steps

- [Learn about Explicit Forward Proxy Session Management Concepts](concept-efp-session-management.md)
- [Learn about Proxy Automatic Configuration (PAC)](concept-pac-files.md)
- [Learn How to Configure Explicit Forward Proxy](how-to-configure-explicit-forward-proxy.md)


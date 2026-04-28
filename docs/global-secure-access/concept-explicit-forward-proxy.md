---
title: Learn about Explicit Forward Proxy Concepts
description: Learn about Explicit Forward Proxy Concepts
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# Explicit Forward Proxy (preview) Overview

Explicit Forward Proxy (EFP) is one of the traffic acquisition mechanisms that's useful in scenarios where installation of the Global Secure Access (GSA) client is difficult or not possible. EFP is an effective mechanism to protect internet traffic when users use browsers to access resources from:
* multi-session Virtual Desktop Infrastructure (VDI)
* kiosks
* browsers on Linux desktops
* on lightly managed devices
* on bring-your-own devices with Microsoft Edge and Intune app policies

EFP relies on proxy automatic configuration (PAC) files to configure browsers for Microsoft Entra Internet Access connectivity. HTTP CONNECT protocol is used to facilitate network communication between the end user and the Microsoft Entra Internet Access service. Microsoft Entra ID and Microsoft Entra Conditional Access are used to authenticate and authorize user access to internet resources.

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Traffic Flow
 
| Step | Details |
| --- | --- |
| **1** | EFP PAC configuration and intermediate certificate used for Transport Layer Security (TLS) inspection are delivered to the device. |
| **2** | User attempts to access an internet resource. EFP redirects the user to Microsoft Entra ID. |
| **3** | User signs in to Microsoft Entra ID either explicitly or via single sign-on. Microsoft Entra ID checks Conditional Access policies to authorize user access. |
| **4** | User is redirected to EFP with the Microsoft Entra ID authorization code. |
| **5** | Microsoft Entra Internet Access security policies are applied and an access decision is made. If allowed, user can retrieve the internet resource. |

## PAC File Hosting
Browsers need to retrieve the proxy configuration at the time of startup. There are two main approaches to PAC file hosting:
**	EFP PAC file hosting. Browsers can be configured with tenant-specific PAC file URLs hosted by Microsoft Entra Internet Access. These PAC files contain recommended configuration for EFP. 
** Self-hosting of PAC files. You can host PAC files on a web server that you manage, allowing you to customize contents of the PAC files.

Smart session management features require that you use EFP PAC file hosting.

> [!Note]
> Future updates to EFP will allow you to upload custom PAC files to be hosted by Entra Internet Access. Until then, you need to self-host the PAC files if you require customization of PAC file contents.

## Session Management

Modern web applications are complex and interactive redirection to Microsoft Entra ID for user authorization isn't possible in all use cases. EFP uses several mechanisms to balance the user session affinity while maintaining optimal user experience.

Foundational element of EFP session management is source IP affinity, with Smart Session Management and Header-based session affinity built on it.

Smart Session Management is enabled by default when you enable EFP. This feature relies on EFP PAC file hosting and introduces a random session identifier each time the PAC file is requested, ensuring that each user in your organization always has a unique proxy address. This unique proxy address allows the EFP service to use that unique identifier together with the source IP to maintain the session after initial user authorization. When EFP detects a user-specific session identifier, a user-specific security profile is applied.

Optionally, you can also enable header-based session affinity and configure your egress proxy to send user’s private IP address in a specific HTTP header on all traffic to the EFP service domains. If EFP detects that HTTP header, a user-specific security profile is applied.

If both smart session management and header-based session affinity are disabled, EFP falls back to source IP affinity. Once the user is authenticated initially, the egress IP address that's visible to the EFP service is cached in relation to that user session. Given that a given IP address could be in use by multiple users/devices, you should configure a Microsoft Entra Conditional Access policy to only allow company networks to access resources using EFP as the network channel. If EFP can't establish a session management mechanism beyond the source IP address of the user, only the baseline security profile applies.

> [!IMPORTANT]
> EFP session management relies on IP affinity as one of the session management anchors. We recommend that you configure a Conditional Access policy that restricts the use of EFP to networks you trust. For more information, please see EFP Session Management and Configure Conditional Access Policy for EFP.


Smart session management and HTTP headers can be enabled simultaneously. If EFP detects both HTTP headers and random session identifier, it prefers the random session identifier for session management.

| EFP Session Management Features Enabled | Affinity method	| Security Profiles Applied |
| --- | --- | --- |
| None | Source IP | Baseline only |
| Smart Session Management | Source IP + Session ID | User-specific supported |
| HTTP Header | Source IP + private IP from HTTP header | User-specific supported |
| Smart Session management AND HTTP Header | Same as HTTP header. Source IP + Session ID takes precedence. | User-specific supported |

> [!Note]
> Even with smart session management and HTTP header session affinity enabled, if a particular request is missing both values, EFP reverts to relying on source IP-based affinity and baseline policies.

## Session Lifetime and Access Revocation

Users must authenticate with Microsoft Entra ID to use EFP. Session management artifacts, such as smart session management, source IP, or HTTP headers, rely on the lifetime of the Microsoft Entra ID access token. Default lifetime of this token is set randomly between 60 and 90 minutes. During the session lifetime, EFP attempts to revalidate the user at regular intervals using single sign-on. If successful, EFP extends user’s cache entry by the lifetime of the new access token.

EFP supports Continuous Access Evaluation (CAE). With CAE, user’s EFP session terminates with identity change events detected by Microsoft Entra ID and sent as a signal to EFP (password reset/change, reset of MFA methods, session revocation, user risk change). In that case, explicit navigation to a new web resource triggers the authentication flow within 2-5 minutes, requiring the user to sign in to Microsoft Entra ID.

## Limitations

- All traffic processed by EFP is TLS terminated. To bypass TLS termination, you must host your own PAC file and exclude specific destinations in the PAC file.
- Microsoft Entra ID traffic must bypass EFP to authorize the user before allowing the connection.
- EFP doesn't support acquisition of Office 365 traffic.

## Next Steps

- [Learn about Explicit Forward Proxy Session Management Concepts](concept-explicit-forward-proxy-session-management.md)
- [Learn about Proxy Automatic Configuration (PAC)](concept-proxy-automatic-configuration-files.md)
- [Learn how to configure Explicit Forward Proxy](how-to-configure-explicit-forward-proxy.md)
- [Learn how to configure HTTP Header session management](how-to-configure-explicit-forward-proxy-headers.md)

---
title: Explicit Forward Proxy Overview
description: Learn about Explicit Forward Proxy concepts.
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# Explicit Forward Proxy (preview) overview

Explicit Forward Proxy is a traffic acquisition mechanism that's useful in scenarios where installation of the Global Secure Access client is difficult or not possible. Explicit Forward Proxy helps protect internet traffic when users use browsers to access resources from:

* Multi-session virtual desktop infrastructure (VDI)
* Kiosks
* Browsers on Linux desktops
* Lightly managed devices
* Bring-your-own devices with Microsoft Edge and Intune app policies

Explicit Forward Proxy relies on proxy automatic configuration (PAC) files to configure browsers for Microsoft Entra Internet Access connectivity. It uses the HTTP CONNECT protocol to facilitate network communication between the user and the Microsoft Entra Internet Access service. It uses Microsoft Entra ID and Microsoft Entra Conditional Access to authenticate and authorize user access to internet resources.

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Traffic flow

| Step | Details |
| --- | --- |
| 1 | Explicit Forward Proxy PAC configuration and intermediate certificate used for Transport Layer Security (TLS) inspection are delivered to the device. |
| 2 | User attempts to access an internet resource. Explicit Forward Proxy redirects the user to Microsoft Entra ID. |
| 3 | User signs in to Microsoft Entra ID either explicitly or via single sign-on. Microsoft Entra ID checks Conditional Access policies to authorize user access. |
| 4 | User is redirected to Explicit Forward Proxy with the Microsoft Entra ID authorization code. |
| 5 | Microsoft Entra Internet Access security policies are applied and an access decision is made. If access is allowed, the user can retrieve the internet resource. |

## PAC file hosting

Browsers need to retrieve the proxy configuration at the time of startup. There are two main approaches to PAC file hosting:

* **Explicit Forward Proxy hosting of PAC files**. You can configure browsers with tenant-specific PAC file URLs that Microsoft Entra Internet Access hosts. These PAC files contain the recommended configuration for Explicit Forward Proxy.
* **Self-hosting of PAC files**. You can host PAC files on a web server that you manage. Choose this approach if you need to customize the PAC file contents.

Features of smart session management require that you use Explicit Forward Proxy hosting of PAC files.

## Session management

Modern web applications are complex. Interactive redirection to Microsoft Entra ID for user authorization isn't possible in all use cases. Explicit Forward Proxy uses several mechanisms to balance the user session affinity while maintaining an optimal user experience.

A foundational element of Explicit Forward Proxy session management is source IP affinity. Smart session management and header-based session affinity are built on it.

Smart session management is enabled by default when you enable Explicit Forward Proxy. This feature relies on Explicit Forward Proxy PAC file hosting. It introduces a random session identifier each time the PAC file is requested, to ensure that each user in your organization always has a unique proxy address. This unique proxy address allows Explicit Forward Proxy to use that unique identifier, together with the source IP, to maintain the session after initial user authorization. When Explicit Forward Proxy detects a user-specific session identifier, it applies a user-specific security profile.

Optionally, you can also enable header-based session affinity and configure your egress proxy to send the user's private IP address in a specific HTTP header on all traffic to the Explicit Forward Proxy service domains. If Explicit Forward Proxy detects that HTTP header, it applies a user-specific security profile.

If both smart session management and header-based session affinity are disabled, Explicit Forward Proxy falls back to source IP affinity. After the user is authenticated initially, the egress IP address that's visible to Explicit Forward Proxy is cached in relation to that user session.

Because multiple users or devices might be using a particular IP address, you should configure a Microsoft Entra Conditional Access policy to allow company networks to access resources only by using Explicit Forward Proxy as the network channel. If Explicit Forward Proxy can't establish a session management mechanism beyond the source IP address of the user, only the baseline security profile applies.

> [!IMPORTANT]
> Explicit Forward Proxy session management relies on IP affinity as one of the session management anchors. We recommend that you configure a Conditional Access policy that restricts the use of Explicit Forward Proxy to networks you trust. For more information, see [Explicit Forward Proxy (preview) session management](/entra/global-secure-access/concept-explicit-forward-proxy-session-management) and [Configure a Microsoft Entra Conditional Access policy for Explicit Forward Proxy (preview)](/entra/global-secure-access/how-to-configure-conditional-access-policy-for-explicit-forward-proxy).

Smart session management and HTTP headers can be enabled simultaneously. If Explicit Forward Proxy detects both HTTP headers and random session identifier, it prefers the random session identifier for session management.

| Explicit Forward Proxy session management features enabled | Affinity method | Security profiles applied |
| --- | --- | --- |
| None | Source IP | Baseline only |
| Smart session management | Source IP + session ID | User-specific supported |
| HTTP header | Source IP + private IP from HTTP header | User-specific supported |
| Smart session management and HTTP header | Same as HTTP header. Source IP + session ID takes precedence. | User-specific supported |

> [!NOTE]
> Even with smart session management and HTTP header-based session affinity enabled, if a particular request is missing both values, Explicit Forward Proxy reverts to relying on source IP-based affinity and baseline policies.

## Session lifetime and access revocation

Users must authenticate with Microsoft Entra ID to use Explicit Forward Proxy. Session management artifacts, such as smart session management, source IP, or HTTP headers, rely on the lifetime of the Microsoft Entra ID access token. The default lifetime of this token is set randomly between 60 and 90 minutes.

During the session lifetime, Explicit Forward Proxy attempts to revalidate the user at regular intervals by using single sign-on. If validation is successful, Explicit Forward Proxy extends the user's cache entry by the lifetime of the new access token.

Explicit Forward Proxy supports *continuous access evaluation*. With continuous access evaluation, the user's Explicit Forward Proxy session terminates with identity change events detected by Microsoft Entra ID and sent as a signal to Explicit Forward Proxy. These events include password reset/change, reset of multifactor authentication methods, session revocation, and user risk change. In that case, explicit navigation to a new web resource triggers the authentication flow in 2 to 5 minutes and requires the user to sign in to Microsoft Entra ID.

## Limitations

* All traffic that Explicit Forward Proxy processes is TLS terminated. To bypass TLS termination, you must host your own PAC file and exclude specific destinations in the PAC file.
* Microsoft Entra ID traffic must bypass Explicit Forward Proxy to authorize the user before allowing the connection.
* Explicit Forward Proxy doesn't support acquisition of Microsoft 365 traffic.

## Related content

* [Learn about Explicit Forward Proxy session management concepts](concept-explicit-forward-proxy-session-management.md)
* [Learn about proxy automatic configuration (PAC)](concept-proxy-automatic-configuration-files.md)
* [Learn how to configure Explicit Forward Proxy](how-to-configure-explicit-forward-proxy.md)
* [Learn how to configure HTTP header session management](how-to-configure-explicit-forward-proxy-headers.md)

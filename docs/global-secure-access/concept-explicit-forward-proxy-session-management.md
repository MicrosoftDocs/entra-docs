---
title: Explicit Forward Proxy Session Management Concepts
description: Learn about Explicit Forward Proxy session management concepts.
ms.topic: concept-article
ms.date: 04/06/2026
ms.reviewer: alexpav
---

# Explicit Forward Proxy (preview) session management

Explicit Forward Proxy uses Microsoft Entra ID authentication and authorization to validate user access before allowing network traffic. This validation method allows for adaptive policies in Microsoft Entra Conditional Access, modern credentials like passkeys, and Continuous Access Evaluation with session revocation. Classic proxy authorization methods, such as basic, digest, NTLM, or Kerberos, aren't supported.

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Session management settings

Explicit Forward Proxy supports smart session management (enabled by default), HTTP header-based session affinity (can be enabled), IP-based session affinity (enabled by default), and cookie-based session affinity. Available capabilities depend on the affinity method.

| Capability | IP affinity | Session ID | HTTP header |
| --- | --- | --- | --- |
| Enabled by default | Yes | Yes | No |
| Can be disabled | No | Yes | Yes |
| Supports user profile assignments | No | Yes | Yes |
| Relies on Explicit Forward Proxy-based proxy automatic configuration (PAC) hosting | No | Yes | No |

> [!IMPORTANT]
> We recommend that you enable a Conditional Access policy that allows access to Explicit Forward Proxy only from your trusted networks.

## Smart session management

Browsers request PAC files when the browser is first started, upon change of network location, upon change in power state of the device, and every 12 hours. When you use Explicit Forward Proxy for PAC file hosting, Explicit Forward Proxy returns a unique session ID as part of the proxy endpoint defined in the PAC file.

Each time a PAC file is requested, a new session ID is generated. Using unique session identifiers allows Explicit Forward Proxy to map unique browsing sessions to specific authenticated users.

## HTTP header session management

You can configure your organization's outbound proxy service to inject the `x-ms-gsa-efp-forwarded-for` header to all traffic for `*.interent.efp.globalsecureaccess.microsoft.com` with a unique IP address of the device (for example, internal IP address). This configuration allows Explicit Forward Proxy to use `x-ms-gsa-efp-forwarded-for` values to map authenticated users to Explicit Forward Proxy sessions.

## IP-based session affinity

After the user session is authenticated and authorized, Explicit Forward Proxy records the source IP of that user connection. Subsequent requests from the same IP address are allowed. If no other session management mechanism can be negotiated besides the source IP, Explicit Forward Proxy falls back to baseline security profile enforcement.

## Continuous Access Evaluation

If the user session is revoked (for example, due to disabling of the user account, password reset/change, reset of multifactor authentication methods, or user risk change), Explicit Forward Proxy receives a Continuous Access Evaluation signal from Microsoft Entra ID and invalidates sessions associated with that user identity in near real time (2 to 5 minutes). After that, the user must reauthenticate with Microsoft Entra ID. If the reauthentication is successful, Explicit Forward Proxy connectivity is re-established.

## Related content

- [Learn how to configure Explicit Forward Proxy](how-to-configure-explicit-forward-proxy.md)

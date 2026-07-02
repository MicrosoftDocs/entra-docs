---
title: Configure Explicit Forward Proxy HTTP Header Session Management
description: Learn how to configure HTTP header session management for Explicit Forward Proxy.
ms.topic: concept-article
ms.date: 04/06/2026
ms.reviewer: alexpav
---

# Configure HTTP header session management

You can configure Explicit Forward Proxy (preview) to rely on the private IP addresses of devices on your network to associate authenticated users with their devices. To use HTTP header session management with Explicit Forward Proxy, you need to securely communicate the private IP address of the device to the Explicit Forward Proxy feature.

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- The account that you use to configure HTTP header session management has an active Global Secure Access Administrator role assignment.
- Your organization has an existing proxy service that can perform Transport Layer Security (TLS) inspection and header injection before sending traffic to Explicit Forward Proxy.
- Client devices that use Explicit Forward Proxy with HTTP header session management trust the TLS certificate's root certificate authority.

## Configuration steps

1. Go to the Microsoft Entra admin center. Under **Global Secure Access** > **Session management** > **Explicit Forward Proxy**, select the **HTTP Header Session Management** checkbox.

1. Configure your outbound proxy service to intercept traffic to `*.internet.efp.globalsecureaccess.microsoft.com`.

1. Configure your outbound proxy service to inject the `x-ms-gsa-efp-forwarded-for` header with the value of the private IP address detected on the incoming connection.

1. Configure the Microsoft Entra Conditional Access policy to allow authentication to Explicit Forward Proxy only from the known networks that your organization trusts.

> [!IMPORTANT]
> Don't skip the step for configuring the Conditional Access policy. HTTP headers can be easily manipulated, so it's essential that `x-ms-gsa-efp-forwarded-for` is sent only from networks that you trust.

## Related content

- [Learn about Explicit Forward Proxy session management concepts](concept-explicit-forward-proxy-session-management.md)

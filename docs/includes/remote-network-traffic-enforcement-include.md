---
ms.author: jayrusso
author: HULKsmashGithub
ms.service: global-secure-access
ms.topic: include
ms.date: 03/31/2026
ms.custom: include file
---

<!-- REVIEW NOTE: [NEW CONTENT] Traffic profile enforcement blurb added for GA of internet support for remote networks (ADO #564642) -->

### Traffic profile enforcement on remote network IPsec tunnels

Global Secure Access enforces traffic forwarding profiles at the gateway level for all traffic received over IPsec tunnels associated with a remote network. Only traffic types that match an enabled and associated traffic forwarding profile are forwarded. All other traffic is dropped at the Global Secure Access gateway.

This enforcement means:

- If only the **Microsoft traffic profile** is associated with a remote network, any non-Microsoft traffic (such as general internet traffic) sent over the IPsec tunnel is dropped by the Global Secure Access gateway.
- If only the **Internet Access traffic profile** is associated with a remote network, any Microsoft traffic sent over the IPsec tunnel is dropped by the Global Secure Access gateway.

> [!IMPORTANT]
> To avoid unintended traffic loss, associate **both** the Microsoft and Internet Access traffic forwarding profiles with your remote network if your license permits. This ensures all traffic forwarded over the IPsec tunnel is handled by the appropriate profile rather than silently dropped at the gateway.

For details on available traffic forwarding profiles and their configuration, see [Global Secure Access traffic forwarding profiles](../global-secure-access/concept-traffic-forwarding.md).

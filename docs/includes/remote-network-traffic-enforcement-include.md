---
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.service: global-secure-access
ms.topic: include
ms.date: 04/01/2026
ms.custom: include file

---

### Traffic profile enforcement on remote network IPsec tunnels

Global Secure Access enforces traffic forwarding profiles at the gateway level for all traffic received over IPsec tunnels associated with a remote network. It forwards only traffic types that match an enabled and associated traffic forwarding profile. The Global Secure Access gateway drops all other traffic.

This enforcement means:

- If you associate only the **Microsoft traffic profile** with a remote network, the Global Secure Access gateway drops any non-Microsoft traffic (such as general internet traffic) sent over the IPsec tunnel.
- If you associate only the **Internet Access traffic profile** with a remote network, the Global Secure Access gateway drops any Microsoft traffic sent over the IPsec tunnel.

> [!IMPORTANT]
> To avoid unintended traffic loss, associate **both** the **Microsoft traffic profile** and the **Internet Access traffic profile** with your remote network if your license permits. This configuration ensures that the appropriate profile handles all traffic forwarded over the IPsec tunnel rather than silently dropping it at the gateway.

For details on available traffic forwarding profiles and their configuration, see [Global Secure Access traffic forwarding profiles](/entra/global-secure-access/concept-traffic-forwarding).

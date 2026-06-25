---
title: Proxy Automatic Configuration (PAC) 
description: Learn about Explicit Forward Proxy PAC file concepts.
ms.topic: concept-article
ms.date: 04/06/2026
ms.reviewer: alexpav
---

# Introduction to proxy automatic configuration (PAC) files

A proxy automatic configuration (PAC) file is a mechanism for automatically determining which proxy server a web browser or application should use for a request. PAC files are an integral part of Explicit Forward Proxy configuration, where they enable flexible and dynamic traffic-steering decisions. In the context of Global Secure Access, PAC files are similar to the traffic forwarding policies of the Global Secure Access client.

## How PAC files work

After you configure PAC files, they operate by providing browsers with a JavaScript function called `FindProxyForURL`. When a browser requests a resource, it calls this function. The function then evaluates conditions such as destination address, protocol, or host name. The function returns a directive that indicates which proxy (or proxies) to use, or whether to connect directly (bypass).

This approach allows for granular control over network traffic, so that you can define routing logic that's tailored to your specific needs.

## PAC file structure and syntax

The core of a PAC file is the JavaScript block that defines the `FindProxyForURL(url, host)` function. Within this function, you can use JavaScript constructs like `if` statements, regular expressions, and built-in helper functions (for example, `dnsDomainIs`, `isInNet`, `shExpMatch`) to determine proxy behavior. The function returns a string that specifies proxy settings, such as `"PROXY <tenantID>.internet.efp.globalsecureaccess.microsoft.com:443\"` for proxy use or `"DIRECT"` for direct connections.

The following example PAC file snippet shows a configuration where a Microsoft Entra ID sign-in is allowed to be accessed directly (required for Explicit Forward Proxy for Internet Access), while all other URLs are accessed via Explicit Forward Proxy:

```javascript
function FindProxyForURL(url, host) {

if (dnsDomainIs(host, \"login.microsoftonline.com\"))

return \"DIRECT\";

else

return \"PROXY *tenantId*.internet.efp.globalsecureaccess.microsoft.com:443\";

}
```

## Applying PAC file settings to browsers

The mechanism for applying PAC file settings varies depending on device management and browser type.

On managed devices, such as those governed by browser policy or enterprise mobility management, you can distribute PAC file URLs or content through centralized configuration tools.

For unmanaged devices, you can instruct users to manually enter the PAC file location in browser settings or rely on a network-provided configuration. A network-provided configuration might be Dynamic Host Configuration Protocol (DHCP) or Web Proxy Auto-Discovery (WPAD).

## Related content

- [Learn how to configure Explicit Forward Proxy](how-to-configure-explicit-forward-proxy.md)
- [Learn how to configure a Microsoft Edge application management policy for Explicit Forward Proxy](how-to-configure-explicit-forward-proxy-intune-policy.md)

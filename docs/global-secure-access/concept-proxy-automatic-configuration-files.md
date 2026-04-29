---
title: Learn about Proxy Automatic Configuration (PAC) 
description: Learn about Explicit Forward Proxy PAC file concepts
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# Introduction to Proxy Automatic Configuration (PAC) Files

A PAC file is a mechanism used to automatically determine which proxy server a web browser or application should use for a given request. PAC files are an integral part of Explicit Forward Proxy configuration, enabling flexible and dynamic traffic steering decisions. In the context of Global Secure Access, PAC files are similar to the traffic forwarding policies of the GSA client.

## How PAC files work

Once configured, PAC files operate by providing browsers with a JavaScript function called **FindProxyForURL**. When a browser requests a resource, it calls this function, which then evaluates conditions---such as destination address, protocol, or hostname---and returns a directive indicating which proxy (or proxies) to use, or whether to connect directly (bypass). This approach allows for granular control over network traffic, enabling you to define routing logic tailored to your specific needs.

## PAC file structure and syntax

The core of a PAC file is the JavaScript block that defines the **FindProxyForURL(url, host)** function. Within this function, you can use JavaScript constructs like **if** statements, regular expressions, and built-in helper functions (e.g., **dnsDomainIs**, **isInNet**, **shExpMatch**) to determine proxy behavior. The function returns a string specifying proxy settings, such as **\"PROXY *tenantID*.internet.efp.globalsecureaccess.microsoft.com:443\"** for proxy use or **\"DIRECT\"** for direct connections.

The example PAC file snippet shows a configuration where Entra ID login is allowed to be accessed directly (required for EFP for Internet Access), while all other URLs are accessed via EFP:

```javascript
function FindProxyForURL(url, host) {

if (dnsDomainIs(host, \"login.microsoftonline.com\"))

return \"DIRECT\";

else

return \"PROXY *tenantId*.internet.efp.globalsecureaccess.microsoft.com:443\";

}
```

## Applying PAC file settings to browsers

The mechanism for applying PAC file settings varies depending on device management and browser type. On managed devices, such as those governed by browser policy or enterprise mobility management, you can distribute PAC file URLs or content through centralized configuration tools. For unmanaged devices, you can instruct end users to manually enter the PAC file location in browser settings or rely on network-provided configuration (such as DHCP or WPAD).

## Next steps

[Learn How to Configure Explicit Forward Proxy](how-to-configure-explicit-forward-proxy.md)
[Configure Microsoft Edge MAM policy for explicit forward proxy](how-to-configure-explicit-forward-proxy-intune-policy.md)

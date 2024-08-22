---
title: Global Secure Access known limitations
description: This article details the known issues and limitations you might encounter when using Global Secure Access.
author: HULKsmashGithub
ms.topic: reference
ms.author: jayrusso
manager: amycolannino
ms.date: 08/22/2024
ms.service: global-secure-access

---
# Global Secure Access known limitations

Global Secure Access is the unifying term used for both Microsoft Entra Internet Access and Microsoft Entra Private Access. 

This article details the known issues and limitations you might encounter when using Global Secure Access.

## Global Secure Access client
The Global Secure Access client is available on multiple platforms. Expand each header for details about the known limitations for each platform.    
### [Android client](#tab/android-client)
Known limitations for the Global Secure Access client for Android include:
- Mobile devices running *Android (Go edition)* aren't currently supported.
- Microsoft Defender for Endpoint on Android *on shared devices* isn't currently supported.
- Tunneling IPv6 traffic isn't currently supported.
- Private Domain Name System (DNS) must be disabled on the device. This setting is often found in the System > Network and Internet options.
- Running non-Microsoft endpoint protection products alongside Microsoft Defender for Endpoint might cause performance problems and unpredictable system errors.   

### [Windows client](#tab/windows-client)
Known limitations for the Global Secure Access client for Windows include:
#### Secure Domain Name System (DNS)
The Global Secure Access client doesn't currently support secure DNS in its different versions, such as DNS over HTTPS (DoH), DNS over TLS (DoT), or DNS Security Extensions (DNSSEC). To configure the client so it can acquire network traffic, you must disable secure DNS. To disable DNS in the browser, see [Secure DNS disabled in browsers](troubleshoot-global-secure-access-client-diagnostics-health-check.md#secure-dns-disabled-in-browsers-microsoft-edge-chrome-firefox). 

#### DNS over TCP
DNS uses port 53 UDP for name resolution. Some browsers have their own DNS client that also supports port 53 TCP. Currently the Global Secure Access client doesn't support DNS port 53 TCP. As a mitigation, disable the browser's DNS client by setting the following registry values:
- Microsoft Edge   
``[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge]   
"BuiltInDnsClientEnabled"=dword:00000000``
- Chrome   
``[HKEY_CURRENT_USER\Software\Policies\Google\Chrome]   
"BuiltInDnsClientEnabled"=dword:00000000``   
Also add browsing `chrome://flags` and disabling `Async DNS resolver`.

#### IPv6 not supported
The client tunnels only IPv4 traffic. IPv6 traffic isn't acquired by the client and is therefore transferred directly to the network. To enable all relevant traffic to be tunneled, set the network adapter properties to [IPv4 preferred](troubleshoot-global-secure-access-client-diagnostics-health-check.md#ipv4-preferred).

#### Connection fallback
If there's a connection error to the cloud service, the client falls back to either direct Internet connection or blocking the connection, based on the ***hardening*** value of the matching rule in the forwarding profile.

#### Geolocation
For network traffic that is tunneled to the cloud service, the application server (website) detects the connection's source IP as the edge's IP address (and not as the user-device's IP address). This scenario might affect services that rely on geolocation.
> [!TIP]
> For Microsoft 365 and Microsoft Entra to detect the device's true source IP, consider enabling [Source IP restoration](how-to-source-ip-restoration.md).

#### Virtualization support
You can't install the Global Secure Access client on a device that hosts virtual machines. However, you can install the Global Secure Access client on a virtual machine, as long as the client isn't installed on the host machine. For the same reason, a Windows Subsystem for Linux (WSL) doesn't acquire traffic from a client installed on the host machine.

#### Proxy
If a proxy is configured at the application level (such as a browser) or at the OS level, configure a proxy auto configuration (PAC) file to exclude all FQDNs and IPs that you expect the client to tunnel.

To prevent HTTP requests for specific FQDNs/IPs from tunneling to the proxy, add the FQDNs/IPs to the PAC file as exceptions. (These FQDNs/IPs are in the forwarding profile of Global Secure Access for tunneling). For example:

```http
function FindProxyForURL(url, host) {   
        if (isPlainHostName(host) ||   
            dnsDomainIs(host, ".microsoft.com") || // tunneled 
            dnsDomainIs(host, ".msn.com")) // tunneled 
           return "DIRECT";                    // If true, sets "DIRECT" connection 
        else                                   // If not true... 
           return "PROXY 10.1.0.10:8080";  // forward the connection to the proxy
}
```
If a direct internet connection isn't possible, configure the client to connect to the Global Secure Access service through a proxy. For example, set the `grpc_proxy` system variable to match the value of the proxy, such as `http://proxy:8080`.

To apply the configuration changes, restart the Global Secure Access client Windows services.

#### Packet injection
The client only tunnels traffic sent using sockets. It doesn't tunnel traffic injected to the network stack using a driver (for example, some of the traffic generated by Network Mapper (Nmap)). Injected packets go directly to the network.

#### Multi-session
The Global Secure Access client doesn't support concurrent sessions on the same machine. This limitation applies to RDP servers and VDI solutions like Azure Virtual Desktop (AVD) that are configured for multi-session.

#### Arm64
The Global Secure Access client doesn't support Arm64 architecture.

#### QUIC not supported for Internet Access
Since QUIC isn't yet supported for Internet Access, traffic to ports 80 UDP and 443 UDP can't be tunneled.
> [!TIP]
> QUIC is currently supported in Private Access and Microsoft 365 workloads.

Administrators can disable QUIC protocol triggering clients to fall back to HTTPS over TCP, which is fully supported in Internet Access. For more information, see [QUIC not supported for Internet Access](troubleshoot-global-secure-access-client-diagnostics-health-check.md#quic-not-supported-for-internet-access).
    
---    

## Remote networks
- The maximum number of remote networks per tenant is 10. The maximum number of device links per remote network is four.
- Microsoft traffic is accessed through remote network connectivity without the Global Secure Access client. However, the Conditional Access policy isn't enforced. In other words, Conditional Access policies for the Global Secure Access Microsoft traffic are only enforced when a user has the Global Secure Access client.
- You must use the Global Secure Access client for Microsoft Entra Private Access. Remote network connectivity only supports Microsoft Entra Internet Access.
- At this time, remote networks can only be assigned to the Microsoft traffic forwarding profile.

## Access controls
- Continuous access evaluation isn't currently supported for Universal Conditional Access for Microsoft traffic.
- Applying Conditional Access policies to Private Access traffic isn't currently supported. To model this behavior, you can apply a Conditional Access policy at the application level for Quick Access and Global Secure Access apps. For more information, see [Apply Conditional Access to Private Access apps](how-to-target-resource-private-access-apps.md).
- Microsoft traffic can be accessed through remote network connectivity without the Global Secure Access Client; however the Conditional Access policy isn't enforced. In other words, Conditional Access policies for the Global Secure Access Microsoft traffic are only enforced when a user has the Global Secure Access Client.
- Compliant network check data plane enforcement (preview) with Continuous Access Evaluation is supported for SharePoint Online and Exchange Online.
- Enabling Global Secure Access Conditional Access signaling enables signaling for both authentication plane (Microsoft Entra ID) and data plane signaling (preview). It isn't currently possible to enable these settings separately.
- Compliant network check is currently not supported for Private Access applications.
- When source IP restoration is enabled, you can only see the source IP. The IP address of the Global Secure Access service isn't visible. If you want to see the Global Secure Access service IP address, disable source IP restoration.
- Source IP restoration is currently supported for only [Microsoft traffic](/microsoft-365/enterprise/urls-and-ip-address-ranges), like SharePoint Online, Exchange Online, Teams, and Microsoft Graph. If you have any IP location-based Conditional Access policies for non-Microsoft resources protected by continuous access evaluation (CAE), these policies aren’t evaluated at the resource as the source IP address isn’t known to the resource.
- If you're using CAE’s [strict location enforcement](../identity/conditional-access/concept-continuous-access-evaluation-strict-enforcement.md), users are blocked despite being in a trusted IP range. To resolve this condition, do one of the following recommendations:
    - If you have IP location-based Conditional Access policies targeting non-Microsoft resources, don't enable strict location enforcement.  
    - Ensure that the traffic is supported by Source IP Restoration, or don't send the relevant traffic through Global Secure Access.
- At this time, connecting through the Global Secure Access client is required to acquire Private Access traffic.
- Data plane protection capabilities are in preview (authentication plane protection is generally available).
- If you enabled universal tenant restrictions and you access the Microsoft Entra admin center for a tenant on the allowlist, you might see an "Access denied" error. To correct this error, add the following feature flag to the Microsoft Entra admin center:
    - `?feature.msaljs=true&exp.msaljsexp=true`
    - For example, you work for Contoso. Fabrikam, a partner tenant, is on the allowlist. You might see the error message for the Fabrikam tenant's Microsoft Entra admin center.
        - If you received the "access denied" error message for the URL `https://entra.microsoft.com/`, then add the feature flag as follows:   `https://entra.microsoft.com/?feature.msaljs%253Dtrue%2526exp.msaljsexp%253Dtrue#home`

## Traffic forwarding profiles
- Individual services are added to the Microsoft traffic profile on an ongoing basis. Currently, Microsoft Entra ID, Microsoft Graph, Exchange Online and SharePoint Online are supported as part of the Microsoft traffic profile
- At this time, Private Access traffic can only be acquired with the Global Secure Access client. Private Access traffic can't be acquired from remote networks.
- Tunneling traffic to Private Access destinations by IP address is supported only for IP ranges outside of the end-user device local subnet. 
- You must disable DNS over HTTPS (Secure DNS) to tunnel network traffic based on the rules of the fully qualified domain names (FQDNs) in the traffic forwarding profile.

## Private Access
- Avoid overlapping app segments between Quick Access and Global Secure Access apps.
- Avoid overlapping app segments between Quick Access and per-app access.
- Tunneling traffic to Private Access destinations by IP address is supported only for IP ranges outside of the end-user device local subnet.
- At this time, Private Access traffic can only be acquired with the Global Secure Access client. Remote networks can't be assigned to the Private access traffic forwarding profile.

## Internet Access
- The platform assumes standard ports for HTTP/S traffic (ports 80 and 443).
- IPv6 isn't supported on this platform yet.
- UDP isn't supported on this platform yet.
- User-friendly end-user notifications are in development.
- Remote network connectivity for Internet Access is in development.
- Transport Layer Security (TLS) termination is in development.
- URL path based filtering and URL categorization for HTTP and HTTPS traffic are in development.
- Currently, an admin can create up to 100 web content filtering policies and up to 1,000 rules based on up to 8,000 total FQDNs. Admins can also create up to 256 security profiles.
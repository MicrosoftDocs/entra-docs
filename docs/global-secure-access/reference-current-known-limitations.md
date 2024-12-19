---
title: Global Secure Access known limitations
description: This article details the known issues and limitations you might encounter when using Global Secure Access.
author: HULKsmashGithub
ms.topic: reference
ms.author: jayrusso
manager: amycolannino
ms.date: 12/18/2024
ms.service: global-secure-access

---
# Global Secure Access known limitations

Global Secure Access is the unifying term used for both Microsoft Entra Internet Access and Microsoft Entra Private Access. 

This article details the known issues and limitations you might encounter when using Global Secure Access.

## Global Secure Access client limitations
The Global Secure Access client is available on multiple platforms. Expand each header for details about the known limitations for each platform.    

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

#### Name Resolution Policy Table rules in Group Policy not supported
The Global Secure Access client for Windows does not support Name Resolution Policy Table (NRPT) rules in Group Policy. To support private DNS, the client configures local NRPT rules on the device. These rules redirect relevant DNS queries to the private DNS. If NRPT rules are configured in Group Policy, they override local NRPT rules configured by the client and private DNS doesn't work.   

In addition, NRPT rules that were configured and deleted in old versions of Windows created an empty list of NRPT rules in the `registry.pol` file. If this Group Policy Object (GPO) is applied on the device, the empty list overrides the local NRPT rules and private DNS doesn't work.

##### Mitigation steps
1. If the following registry key exists on the end-user device, a GPO is configured to apply NRPT rules:
`HKLM\Software\Policies\Microsoft\Windows NT\DNSClient\DnsPolicyConfig`
1. To find which GPOs are configured with NRPT rules:
    1. Use `gpresult`.
    2. Run the following script that detects the paths of all registry.pol files in sysvol that contain NRPT rules. Note: remember to change the sysvolPath variable to meet the configuration of your network.
1. Edit each of the GPOs found in the previous section:
    1. If the NRPT section is empty, create a new fictive rule, update the policy, delete the fictive rule and update again. This will remove the DnsPolicyConfig from the registry.pol file (Which was created in one of the legacy version of Windows)
    2. If the NRPT section is not empty and contains rules, confirm that you still need these rules. If they are not needed, delete them. If they are needed and the GPO is applied on a device with GSA client, the private DNS option will not function.
:::image type="content" source="media/reference-current-known-limitations/limitations-create-rule.png" alt-text="Screenshot of the Name Resolution Policy Rules dialog with the Create and Apply buttons highlighted." lightbox="media/reference-current-known-limitations/limitations-create-rule-expanded.png":::

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

#### Virtualization support
Hyper-V support: 
1. External virtual switch: The Global Secure Access Windows client doesn't currently support host machines that have a Hyper-V external virtual switch. However, the client can be installed on the virtual machines to tunnel traffic to Global Secure Access.   
1. Internal virtual switch: The Global Secure Access Windows client can be installed on host and guest machines. The client tunnels only the network traffic of the machine it's installed on. In other words, a client installed on a host machine doesn’t tunnel the network traffic of the guest machines.      

The Global Secure Access Windows client supports Azure Virtual Machines. 

The Global Secure Access Windows client supports Azure Virtual Desktop (AVD).
> [!NOTE]
> AVD multi-session is not supported.

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

#### WSL 2 connectivity
When the Global Secure Access client for Windows is enabled on the host machine, outgoing connections from the Windows Subsystem for Linux (WSL) 2 environment might be blocked. To mitigate this occurrence, create a `.wslconfig` file that sets dnsTunneling to **false**. This way, all traffic from the WSL bypasses Global Secure Access and goes directly to the network. For more information, see [Advanced settings configuration in WSL](/windows/wsl/wsl-config#wslconfig).

### [macOS client](#tab/macos-client)
Known limitations for the Global Secure Access client for macOS include:

#### Secure Domain Name System (DNS)
If Secure DNS is enabled on the browser or in macOS and the DNS server supports Secure DNS, then the client doesn't tunnel traffic set to be acquired by FQDN. (Network traffic that's acquired by IP isn't affected and is tunneled according to the forwarding profile.) To mitigate the Secure DNS issue, disable Secure DNS, set a DNS server that doesn't support Secure DNS, or create rules based on IP.

#### IPv6 not supported
The client tunnels only IPv4 traffic. IPv6 traffic isn't acquired by the client and therefore routed directly to the network.
To make sure that all traffic is routed to Global Secure Access, disable IPv6.

#### Connection fallback
If there's a connection error to the cloud service, the client falls back to either direct Internet connection or blocking the connection, based on the ***hardening*** value of the matching rule in the forwarding profile.

#### Geolocation of source IP address
For network traffic that is tunneled to the cloud service, the application server (website) detects the connection's source IP as the edge's IP address (and not as the user-device's IP address). This scenario might affect services that rely on geolocation.
> [!TIP]
> For Office 365 and Entra to detect the device's true source IP, consider enabling [Source IP restoration](how-to-source-ip-restoration.md).

#### Virtualization support with UTM
- When the network is in **bridged** mode and Global Secure Access client is installed on the host machine:
    - If the Global Secure Access client is installed on the virtual machine, network traffic of the virtual machine is subject to its local policy. The host machine's policy doesn't affect the forwarding profile on the virtual machine.
    - If the Global Secure Access client *isn't* installed on the virtual machine, network traffic of the virtual machine is bypassed.
- The Global Secure Access client doesn't support network **shared** mode because it might block the network traffic of the virtual machine.
- If the network is in **shared** mode, you can install the Global Secure Access client on a virtual machine running macOS, as long as the client isn't also installed on the host machine.

#### QUIC not supported for Internet Access
Since QUIC isn't yet supported for Internet Access, traffic to ports 80 UDP and 443 UDP can't be tunneled.
> [!TIP]
> QUIC is currently supported in Private Access and Microsoft 365 workloads.
Administrators can disable QUIC protocol on browsers, triggering clients to fall back to HTTPS over TCP, which is fully supported in Internet Access. For more information, see [QUIC not supported for Internet Access](troubleshoot-global-secure-access-client-diagnostics-health-check.md#quic-not-supported-for-internet-access).

### [Android client](#tab/android-client)
Known limitations for the Global Secure Access client for Android include:
- Mobile devices running *Android (Go edition)* aren't currently supported.
- Microsoft Defender for Endpoint on Android *on shared devices* isn't currently supported.
- Tunneling IPv6 traffic isn't currently supported.
- Private Domain Name System (DNS) must be disabled on the device. This setting is often found in the System > Network and Internet options.
- Running non-Microsoft endpoint protection products alongside Microsoft Defender for Endpoint might cause performance problems and unpredictable system errors.   

### [iOS client](#tab/ios-client)
Known limitations for the Global Secure Access client for Android include:
- Tunneling Quick User Datagram Protocol (UDP) Internet Connections (QUIC) traffic (except for Exchange Online) isn't supported.
- Global Secure Access (GSA) coexistence with Microsoft Tunnel isn't currently supported. For more information, see [Prerequisites for the Microsoft Tunnel in Intune](/mem/intune/protect/microsoft-tunnel-prerequisites).
    
---    

## Remote network limitations   
Known limitations for remote networks include:   
- The maximum number of remote networks per tenant is 10. The maximum number of device links per remote network is four.
- Microsoft traffic is accessed through remote network connectivity without the Global Secure Access client. However, the Conditional Access policy isn't enforced. In other words, Conditional Access policies for the Global Secure Access Microsoft traffic are only enforced when a user has the Global Secure Access client.
- You must use the Global Secure Access client for Microsoft Entra Private Access. Remote network connectivity only supports Microsoft Entra Internet Access.
- At this time, remote networks can only be assigned to the Microsoft traffic forwarding profile.

## Access control limitations
Known limitations for access controls include:   
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

## Traffic forwarding profile limitations
Known limitations for traffic forwarding profiles include:   
- Individual services are added to the Microsoft traffic profile on an ongoing basis. Currently, Microsoft Entra ID, Microsoft Graph, Exchange Online and SharePoint Online are supported as part of the Microsoft traffic profile
- At this time, Private Access traffic can only be acquired with the Global Secure Access client. Private Access traffic can't be acquired from remote networks.
- Tunneling traffic to Private Access destinations by IP address is supported only for IP ranges outside of the end-user device local subnet. 
- You must disable DNS over HTTPS (Secure DNS) to tunnel network traffic based on the rules of the fully qualified domain names (FQDNs) in the traffic forwarding profile.

## Private Access limitations
Known limitations for Private Access include:   
- Avoid overlapping app segments between Quick Access and Global Secure Access apps.
- Avoid overlapping app segments between Quick Access and per-app access.
- Tunneling traffic to Private Access destinations by IP address is supported only for IP ranges outside of the end-user device local subnet.
- At this time, Private Access traffic can only be acquired with the Global Secure Access client. Remote networks can't be assigned to the Private access traffic forwarding profile.

## Internet Access limitations
Known limitations for Internet Access include:   
- The platform assumes standard ports for HTTP/S traffic (ports 80 and 443).
- IPv6 isn't supported on this platform yet.
- UDP isn't supported on this platform yet.
- User-friendly end-user notifications are in development.
- Remote network connectivity for Internet Access is in development.
- Transport Layer Security (TLS) termination is in development.
- URL path based filtering and URL categorization for HTTP and HTTPS traffic are in development.
- Currently, an admin can create up to 100 web content filtering policies and up to 1,000 rules based on up to 8,000 total FQDNs. Admins can also create up to 256 security profiles.
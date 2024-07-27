---
title: The Global Secure Access client for Windows
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the Windows client.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 07/26/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazb


# Customer intent: Windows users, I want to download and install the Global Secure Access client.
---
# Global Secure Access client for Windows

The Global Secure Access client, an essential component of Global Secure Access, helps organizations manage and secure network traffic on end-user devices. The client's main role is to route traffic that needs to be secured by Global Secure Access to the cloud service. All other traffic goes directly to the network. The [Forwarding Profiles](concept-traffic-forwarding.md), configured in the portal, determine which traffic is routed to the cloud service.

This article describes how to download and install the Global Secure Access client for Windows.

## Prerequisites

- An Entra tenant onboarded to Global Secure Access.
- A managed device joined to the tenant above. The device must be either Microsoft Entra joined or Microsoft Entra hybrid joined. 
   - Microsoft Entra registered devices aren't supported.
- The Global Secure Access client requires a 64-bit versions of Windows 10 or Windows 11.
   - Azure Virtual Desktop single-session is supported.
   - Azure Virtual Desktop multi-session isn't supported.
   - Windows 365 is supported.
- Local administrator credentials are required to install or upgrade the client.
- The Global Secure Access client requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

### Known limitations
This is a list of the known limitations of the current version of the Global Secure Access client.

- **Secure DNS**: Secure DNS in its different versions (DNS over HTTPS, DNS over TLS, DNSSEC) is currently not supported. For the client to work correctly and acquire network traffic, Secure DNS must be disabled. To disable DNS, see [DNS over HTTPS not supported](troubleshoot-global-secure-access-client-diagnostics-health-check.md#dns-over-https-not-supported).
- **DNS over TCP**: DNS uses port 53 UDP for name resolution. Some browsers have their own DNS client that also supports port 53 TCP. Currently the client doesn't support DNS port 53 TCP. As a mitigation, disable the browser's DNS client by setting the following registry values:
    - **Edge**
    ``[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge]
      "BuiltInDnsClientEnabled"=dword:00000000``
    - **Chrome** 
    ``[HKEY_CURRENT_USER\Software\Policies\Google\Chrome]
      "BuiltInDnsClientEnabled"=dword:00000000``
- **IPv6 is not supported**: The client tunnels only IPv4 traffic. IPv6 traffic is not acquired by the client and therefore transferred directly to the network. To prefer IPv4 over IPV6, so all relevant traffic will be tunneled, set network adapter properties, see [IPv4 preferred](troubleshoot-global-secure-access-client-diagnostics-health-check.md#ipv4-preferred).
- **Connection fallback**: If there's a connection error to the cloud service, the client falls back to either direct Internet connection or blocking the connection, based on the ***hardening*** value of the matching rule in the forwarding profile.
- **Geolocation**: For network traffic that is tunneled to the cloud service, the application server (website) detects the connection's source IP as the edge's IP address (and not as the user-device's IP address). This might affect services that rely on geolocation.
> [!TIP]
> For Office 365 and Entra to detect the device's true source IP, consider enabling [Source IP restoration](how-to-source-ip-restoration.md) .

- **Virtualization support**:
    - Installing the client on a device that hosts virtual machine is currently not supported.
    - You can install the client in virtual machines as long as it is not installed on the host.
    - For the same reason, traffic from WSL (Windows Subsystem for Linux) is not acquired by a client installed on the host machine.

- **Proxy**: If a proxy is configured at the application level (ex. browser) or at the OS level, a PAC file should be configured to allow correct functioning of the client. The PAC file should be configured to exclude all FQDNs and IPs that are expected to be tunneled by the client.

- 
- Multiple user sessions on the same device, like those from a Remote Desktop Server (RDP), aren't supported.
- Networks that use a captive portal, like some guest wireless network solutions, might cause the client connection to fail. As a workaround you can [pause the Global Secure Access client](#troubleshooting).
- Virtual machines where both the host and guest Operating Systems have the Global Secure Access client installed aren't supported. Individual virtual machines with the client installed are supported.
- The service *bypasses* the traffic if the Global Secure Access client isn't able to connect to the service (for example due to an authorization or Conditional Access failure). Traffic is sent direct-and-local instead of being blocked. In this scenario, you can create a Conditional Access policy for the [compliant network check](how-to-compliant-network.md), to block traffic if the client isn't able to connect to the service.
- The Global Secure Access client on ARM64 architecture isn't yet supported. However, ARM64 is on the roadmap.


There are several other limitations based on the traffic forwarding profile in use:

| Traffic forwarding profile | Limitation |
| --- | --- |
| [Microsoft traffic profile](how-to-manage-microsoft-profile.md) | Tunneling [IPv6 traffic isn't currently supported](#disable-ipv6-and-secure-dns). |
| [Microsoft traffic profile](how-to-manage-microsoft-profile.md) and [Private access](how-to-manage-private-access-profile.md) | To tunnel network traffic based on rules of FQDNs (in the forwarding profile), [Domain Name System (DNS) over HTTPS (Secure DNS) needs to be disabled](#disable-ipv6-and-secure-dns). |
| [Microsoft](how-to-manage-microsoft-profile.md) and [Private access](how-to-manage-private-access-profile.md) | If the end-user device is configured to use a proxy server, locations that you wish to tunnel using the Global Secure Access client must be excluded from that configuration. For examples, see [Proxy configuration example](#proxy-configuration-example). |
| [Private access](how-to-manage-private-access-profile.md) | Single label domains, like `https://contosohome` for private apps aren't supported. Instead use a fully qualified domain name (FQDN), like `https://contosohome.contoso.com`. Administrators can also choose to append DNS suffixes via Windows. |

## Download the client

The most current version of the Global Secure Access client can be downloaded from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select **Download Client**.
:::image type="content" source="media/how-to-install-windows-client/client-download-screen.png" alt-text="Screenshot of the Client download screen with the Download Client button hilighted.":::
    
## Install the client

Organizations can install the client interactively, silently with the `/quiet` switch, or use mobile device management platforms like [Microsoft Intune to deploy it](/mem/intune/apps/apps-win32-app-management) to their devices.

1. Copy the Global Secure Access client setup file to your client machine.
1. Run the *GlobalSecureAccessClient.exe* setup file. Accept the software license terms.
1. The client is installed and you are prompted to sign in with your Microsoft Entra credentials.
1. Sign in and the connection icon turns green. 
1. Double-click the connection icon to open a notification with client information showing a connected state.
:::image type="content" source="media/how-to-install-windows-client/install-windows-client-client-status.png" alt-text="Screenshot showing the client is connected.":::


## Troubleshooting

To troubleshoot the Global Secure Access client, right-click the client icon in the taskbar.

:::image type="content" source="media/how-to-install-windows-client/client-install-menu-options.png" alt-text="Screenshot showing the context menu of the Global Secure Access client.":::

- **Login as different user**
   - Forces sign-in screen to change user or reauthenticate the existing user.
- **Pause**
   - This option can be used to temporarily disable traffic tunneling. As this client is part of your organization's security posture we recommend leaving it running always.
   - This option stops the Windows services related to client. When these services are stopped, traffic is no longer tunneled from the client machine to the cloud service. Network traffic behaves as if the client isn't installed while the client is paused. If the client machine is restarted, the services automatically restart with it.
- **Resume**
   - This option starts the underlying services related to the Global Secure Access client. This option would be used to resume after temporarily pausing the client for troubleshooting. Traffic resumes tunneling from the client to the cloud service.
- **Restart**
   - This option stops and starts the Windows services related to client.
- **Collect logs**
   - Collect logs for support and further troubleshooting. These logs are collected and stored in `C:\Program Files\Global Secure Access Client\Logs` by default.
      - These logs include information about the client machine, the related event logs for the services, and registry values including the traffic forwarding profiles applied.
- **Client Checker**
   - Runs a script to test client components ensuring the client is configured and working as expected. 
- **Connection Diagnostics** provides a live display of client status and connections tunneled by the client to the Global Secure Access service
   - **Summary** tab shows general information about the client configuration including: policy version in use, last policy update date and time, and the ID of the tenant the client is configured to work with.
      - The hostname acquisition state changes to green when new traffic acquired by FQDN is tunneled successfully, based on a match of the destination FQDN in a traffic forwarding profile.
   - **Flows** show a live list of connections initiated by the end-user device and tunneled by the client to the Global Secure Access edge. Each connection is new row.
      - **Timestamp** is the time when the connection was first established.
      - **Fully Qualified Domain Name (FQDN)** of the destination of the connection. If the decision to tunnel the connection was made based on an IP rule in the forwarding policy not by an FQDN rule, the FQDN column shows N/A.
      - **Source** port of the end-user device for this connection. 
      - **Destination IP** is the destination of the connection.
      - **Protocol** only Transmission Control Protocol (TCP) is supported currently.
      - **Process** name that initiated the connection. 
      - **Flow** active provides a status of whether the connection is still open.
      - **Sent data** provides the number of bytes sent by the end-user device over the connection. 
      - **Received data** provides the number of bytes received by the end-user device over the connection. 
      - **Correlation ID** is provided to each connection tunneled by the client. This ID allows tracing of the connection in the client logs. The client logs consist of event viewer, event trace (ETL), and the [Global Secure Access traffic logs (preview)](how-to-view-traffic-logs.md).
      - **Flow ID** is the internal ID of the connection used by the client shown in the ETL file.
      - **Channel name** identifies the traffic forwarding profile to which the connection is tunneled. This decision is taken according to the rules in the forwarding profile. 
   - **HostNameAcquisition** provides a list of hostnames that the client acquired based on the FQDN rules in the forwarding profile. Each hostname is shown in a new row. Future acquisition of the same hostname creates another row if DNS resolves the hostname (FQDN) to a different IP address.
      - **Timestamp** is the time when the connection was first established.
      - **FQDN** that is resolved.
      - **Generated IP address** is an IP address generated by the client for internal purposes. This IP is shown in flows tab for connections that are established to the relative FQDN.
      - **Original IP address** is the first IPv4 address in the DNS response when querying the FQDN. If the DNS server that the end-user device points to doesn’t return an IPv4 address for the query, the original IP address shows `0.0.0.0`.
   - **Services** shows the status of the Windows services related to the Global Secure Access client. Services that are started have a green status icon, services that are stopped show a red status icon. All three Windows services must be started for the client to function.
   - **Channels** list the traffic forwarding profiles assigned to the client and the state of the connection to the Global Secure Access edge.

### Event logs

Event logs related to the Global Secure Access client can be found in the Event Viewer under `Applications and Services/Microsoft/Windows/Global Secure Access Client/Operational`. These events provide useful detail regarding the state, policies, and connections made by the client.

### Disable IPv6 and secure DNS

If you need assistance disabling IPv6 or secure DNS on Windows devices, the following script provides assistance.

```powershell
function CreateIfNotExists
{
    param($Path)
    if (-NOT (Test-Path $Path))
    {
        New-Item -Path $Path -Force | Out-Null
    }
}

$disableBuiltInDNS = 0x00

# Prefer IPv4 over IPv6 with 0x20, disable  IPv6 with 0xff, revert to default with 0x00. 
# This change takes effect after reboot. 
$setIpv6Value = 0x20
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -Type DWord -Value $setIpv6Value

# This section disables browser based secure DNS lookup.
# For the Microsoft Edge browser.
CreateIfNotExists "HKLM:\SOFTWARE\Policies\Microsoft"
CreateIfNotExists "HKLM:\SOFTWARE\Policies\Microsoft\Edge"

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "DnsOverHttpsMode" -Value "off"

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "BuiltInDnsClientEnabled" -Type DWord -Value $disableBuiltInDNS

# For the Google Chrome browser.

CreateIfNotExists "HKLM:\SOFTWARE\Policies\Google"
CreateIfNotExists "HKLM:\SOFTWARE\Policies\Google\Chrome"

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "DnsOverHttpsMode" -Value "off"

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BuiltInDnsClientEnabled" -Type DWord -Value $disableBuiltInDNS
```

### Proxy configuration example

Example proxy PAC file containing exclusions:

```http
function FindProxyForURL(url, host) {  // basic function; do not change
   if (isPlainHostName(host) ||
      dnsDomainIs(host, ".contoso.com") || //tunneled
      dnsDomainIs(host, ".fabrikam.com"))  // tunneled
      return "DIRECT";                     // If true, sets "DIRECT" connection
      else                                 // for all other destinations  
      return "PROXY 10.1.0.10:8080";  // transfer the traffic to the proxy. 
}
```

Organizations must then create a system variable named `grpc_proxy` with a value like `http://10.1.0.10:8080` that matches your proxy server's configuration on end-user machines to allow the Global Secure Access client services to use the proxy by configuring the following.



## Next steps

The next step for getting started with Microsoft Entra Internet Access is to [enable universal tenant restrictions](how-to-universal-tenant-restrictions.md).

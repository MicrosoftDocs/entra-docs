---
title: Known Limitations for Global Secure Access
description: This article details the known issues and limitations you might encounter when using Global Secure Access.
author: HULKsmashGithub
ms.topic: reference
ms.author: jayrusso
manager: dougeby
ms.date: 06/13/2025
ms.service: global-secure-access



# Customer intent: As an administrator, I want to access the known limitations for Global Secure Access in one place. This article gathers all known issues and limitations into a single reference point. Global Secure Access articles with a "known limitations" section point to this article. 
---
# Known limitations for Global Secure Access

Global Secure Access is the unifying term used for both Microsoft Entra Internet Access and Microsoft Entra Private Access. 

This article details the known issues and limitations you might encounter when using Global Secure Access.

## Global Secure Access client limitations
The Global Secure Access client is available on multiple platforms. Select each tab for details about the known limitations for each platform.    

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
The Global Secure Access client for Windows doesn't support Name Resolution Policy Table (NRPT) rules in Group Policy. To support private DNS, the client configures local NRPT rules on the device. These rules redirect relevant DNS queries to the private DNS. If NRPT rules are configured in Group Policy, they override local NRPT rules configured by the client and private DNS doesn't work.   

In addition, NRPT rules that were configured and deleted in older versions of Windows created an empty list of NRPT rules in the `registry.pol` file. If this Group Policy Object (GPO) is applied on the device, the empty list overrides the local NRPT rules and private DNS doesn't work.

As a mitigation:
1. If the registry key `HKLM\Software\Policies\Microsoft\Windows NT\DNSClient\DnsPolicyConfig` exists on the end-user device, configure a GPO to apply NRPT rules.
1. To find which GPOs are configured with NRPT rules:
    1. Run `gpresult /h GPReport.html` on the end-user device and look for an NRPT configuration.
    2. Run the following script that detects the paths of all `registry.pol` files in `sysvol` that contain NRPT rules.
> [!NOTE]
> Remember to change the `sysvolPath` variable to meet the configuration of your network.

```PowerShell
# =========================================================================
# THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER 
# EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES 
# OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
#
# This sample is not supported under any Microsoft standard support program 
# or service. The code sample is provided AS IS without warranty of any kind. 
# Microsoft further disclaims all implied warranties including, without 
# limitation, any implied warranties of merchantability or of fitness for a 
# particular purpose. The entire risk arising out of the use or performance
# of the sample and documentation remains with you. In no event shall 
# Microsoft, its authors, or anyone else involved in the creation, 
# production, or delivery of the script be liable for any damages whatsoever 
# (including, without limitation, damages for loss of business profits, 
# business interruption, loss of business information, or other pecuniary 
# loss) arising out of  the use of or inability to use the sample or 
# documentation, even if Microsoft has been advised of the possibility of 
# such damages.
#========================================================================= 

# Define the sysvol share path.
# Change the sysvol path per your organization, for example: 
# $sysvolPath = "\\dc1.contoso.com\sysvol\contoso.com\Policies"
$sysvolPath = "\\<DC FQDN>\sysvol\<domain FQDN>\Policies"  ## Edit

# Define the search string.
$searchString = "dnspolicyconfig"

# Define the name of the file to search.
$fileName = "registry.pol"

# Get all the registry.pol files under the sysvol share.
$files = Get-ChildItem -Path $sysvolPath -Recurse -Filter $fileName -File

# Array to store paths of files that contain the search string.
$matchingFiles = @()

# Loop through each file and check if it contains the search string.
foreach ($file in $files) {
    try {
        # Read the content of the file.
        $content = Get-Content -Path $file.FullName -Encoding Unicode
        
        # Check if the content contains the search string.
        if ($content -like "*$searchString*") {
            $matchingFiles += $file.FullName
        }
    } catch {
        Write-Host "Failed to read file $($file.FullName): $_"
    }
}

# Output the matching file paths.
if ($matchingFiles.Count -eq 0) {
    Write-Host "No files containing '$searchString' were found."
} else {
    Write-Host "Files containing '$searchString':"
    $matchingFiles | ForEach-Object { Write-Host $_ }
}

```

3. Edit each of the GPOs found in the previous section:
    1. If the NRPT section is empty, create a new fictive rule, update the policy, delete the fictive rule, and update the policy again. These steps remove the `DnsPolicyConfig` from the `registry.pol` file (which was created in a legacy version of Windows).
    2. If the NRPT section isn't empty and contains rules, confirm that you still need these rules. If you *don't* need the rules, delete them. If you *do* need the rules and apply the GPO on a device with Global Secure Access client, the private DNS option doesn't work.
:::image type="content" source="media/reference-current-known-limitations/limitations-create-rule.png" alt-text="Screenshot of the Name Resolution Policy Rules dialog with the Create and Apply buttons highlighted." lightbox="media/reference-current-known-limitations/limitations-create-rule-expanded.png":::

#### Connection fallback
If there's a connection error to the cloud service, the client falls back to either direct Internet connection or blocking the connection, based on the ***hardening*** value of the matching rule in the forwarding profile.

#### Geolocation
For network traffic that is tunneled to the cloud service, the application server (website) detects the connection's source IP as the edge's IP address (and not as the user-device's IP address). This scenario might affect services that rely on geolocation.
> [!TIP]
> For Microsoft Entra and Microsoft Graph to detect the device's true original public egress (source) IP, consider enabling [Source IP restoration](how-to-source-ip-restoration.md).

#### Virtualization support
You can't install the Global Secure Access client on a device that hosts virtual machines. However, you can install the Global Secure Access client on a virtual machine, as long as the client isn't installed on the host machine. For the same reason, a Windows Subsystem for Linux (WSL) doesn't acquire traffic from a client installed on the host machine.

Hyper-V support: 
1. External virtual switch: The Global Secure Access Windows client doesn't currently support host machines that have a Hyper-V external virtual switch. However, the client can be installed on the virtual machines to tunnel traffic to Global Secure Access.   
1. Internal virtual switch: The Global Secure Access Windows client can be installed on host and guest machines. The client tunnels only the network traffic of the machine it's installed on. In other words, a client installed on a host machine doesn’t tunnel the network traffic of the guest machines.      

The Global Secure Access Windows client supports Azure Virtual Machines and Azure Virtual Desktop (AVD).
> [!NOTE]
> The Global Secure Access Windows client doesn't support AVD multi-session.

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
The Global Secure Access client doesn't support concurrent sessions on the same machine. This limitation applies to Remote Desktop Protocol (RDP) servers and Virtual Desktop Infrastructure (VDI) solutions like Azure Virtual Desktop (AVD) that are configured for multi-session.

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

#### Connection fallback
If there's a connection error to the cloud service, the client falls back to either direct Internet connection or blocking the connection, based on the ***hardening*** value of the matching rule in the forwarding profile.

#### Geolocation of source IP address
For network traffic that is tunneled to the cloud service, the application server (website) detects the connection's source IP as the edge's IP address (and not as the user-device's IP address). This scenario might affect services that rely on geolocation.
> [!TIP]
> For Office 365 and Microsoft Entra to detect the device's true source IP, consider enabling [Source IP restoration](how-to-source-ip-restoration.md).

#### Virtualization support with UTM
- If the network is in **bridged** mode and Global Secure Access client is installed on the host machine:
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
- Private Domain Name System (DNS) must be disabled on the device. This setting is often found in the System > Network and Internet options.
- Running non-Microsoft endpoint protection products alongside Microsoft Defender for Endpoint might cause performance problems and unpredictable system errors.  
- Global Secure Access coexistence with Microsoft Tunnel isn't currently supported. For more information, see [Prerequisites for the Microsoft Tunnel in Intune](/mem/intune/protect/microsoft-tunnel-prerequisites). 

### [iOS client](#tab/ios-client)
Known limitations for the Global Secure Access client for iOS include:
- Tunneling Quick User Datagram Protocol (UDP) Internet Connections (QUIC) traffic (except for Exchange Online) isn't supported.
- Global Secure Access coexistence with Microsoft Tunnel isn't currently supported. For more information, see [Prerequisites for the Microsoft Tunnel in Intune](/mem/intune/protect/microsoft-tunnel-prerequisites).
    
---    

## Remote networks limitations   
Known limitations for remote networks include:   
- The maximum number of remote networks per tenant is 10. The maximum number of device links per remote network is four.
- Microsoft traffic is accessed through remote network connectivity without the Global Secure Access client. However, the Conditional Access policy isn't enforced. In other words, Conditional Access policies for the Global Secure Access Microsoft traffic are only enforced when a user has the Global Secure Access client.
- You must use the Global Secure Access client for Microsoft Entra Private Access. Remote network connectivity only supports Microsoft Entra Internet Access.
- At this time, remote networks can only be assigned to the Microsoft traffic forwarding profile.

## Access controls limitations
Known limitations for access controls include:   
- Applying Conditional Access policies to Private Access traffic isn't currently supported. To model this behavior, you can apply a Conditional Access policy at the application level for Quick Access and Global Secure Access apps. For more information, see [Apply Conditional Access to Private Access apps](how-to-target-resource-private-access-apps.md).
- Microsoft traffic can be accessed through remote network connectivity without the Global Secure Access Client; however the Conditional Access policy isn't enforced. In other words, Conditional Access policies for the Global Secure Access Microsoft traffic are only enforced when a user has the Global Secure Access Client.
- Compliant network check is currently not supported for Private Access applications.
- When source IP restoration is enabled, you can only see the original public egress (source) IP. The IP address of the Global Secure Access service isn't visible. If you want to see the Global Secure Access service IP address, disable source IP restoration.
- Currently only [Microsoft resources](/microsoft-365/enterprise/urls-and-ip-address-ranges) evaluate IP location-based Conditional Access policies, as the original source IP address isn't known to non-Microsoft resources protected by continuous access evaluation (CAE).
- If you're using CAE’s [strict location enforcement](../identity/conditional-access/concept-continuous-access-evaluation-strict-enforcement.md), users are blocked despite being in a trusted IP range. To resolve this condition, do one of the following recommendations:
    - If you have IP location-based Conditional Access policies targeting non-Microsoft resources, don't enable strict location enforcement.  
    - Ensure that Source IP Restoration supports the traffic. If not, don't send the relevant traffic through Global Secure Access.
- At this time, connecting through the Global Secure Access client is required to acquire Private Access traffic.
- If you enabled Universal Tenant Restrictions and you access the Microsoft Entra admin center for a tenant on the allowlist, you might see an "Access denied" error. To correct this error, add the following feature flag to the Microsoft Entra admin center:
    - `?feature.msaljs=true&exp.msaljsexp=true`
    - For example, you work for Contoso. Fabrikam, a partner tenant, is on the allowlist. You might see the error message for the Fabrikam tenant's Microsoft Entra admin center.
        - If you received the "access denied" error message for the URL `https://entra.microsoft.com/`, then add the feature flag as follows:   `https://entra.microsoft.com/?feature.msaljs%253Dtrue%2526exp.msaljsexp%253Dtrue#home`
- Starting with version 1.8.239.0 on Windows and version 1.1.25060400 on macOS, the Global Secure Access client supports Universal CAE. On other platforms, the Global Secure Access client uses regular access tokens.
- Microsoft Entra ID issues short-lived tokens for Global Secure Access. The lifetime for a Universal CAE access token is between 60 and 90 minutes, with support for near real-time revocation.
- It takes approximately two to five minutes for the Microsoft Entra ID signal to reach the Global Secure Access client and prompt the user to reauthenticate.
- The Global Secure Access client prompts the user three times to authenticate with a 2-minute grace period each time. This means that the entire CAE flow includes 4-5 minutes to signal the Global Secure Access client, then up to a 6-minute grace period, resulting in a disconnect after approximately 10 minutes.
## Traffic forwarding profile limitations
Known limitations for traffic forwarding profiles include:
- At this time, Private Access traffic can only be acquired with the Global Secure Access client. Private Access traffic can't be acquired from remote networks.
- Tunneling traffic to Private Access destinations by IP address is supported only for IP ranges outside of the end-user device local subnet. 
- You must disable DNS over HTTPS (Secure DNS) to tunnel network traffic based on the rules of the fully qualified domain names (FQDNs) in the traffic forwarding profile.

## Private Access limitations
Known limitations for Private Access include:   
- Avoid overlapping app segments between Global Secure Access apps.
- Tunneling traffic to Private Access destinations by IP address is supported only for IP ranges outside of the end-user device local subnet.
- At this time, Private Access traffic can only be acquired with the Global Secure Access client. Remote networks can't be assigned to the Private access traffic forwarding profile.   

## Internet Access limitations
Known limitations for Internet Access include:   
- Currently, an admin can create up to 100 web content filtering policies and up to 1,000 rules based on up to 8,000 total FQDNs. Admins can also create up to 256 security profiles.
- The platform assumes standard ports for HTTP/S traffic (ports 80 and 443).
- The Global Secure Access client doesn't support IPv6. The client tunnels only IPv4 traffic. IPv6 traffic isn't acquired by the client and is therefore transferred directly to the network. To make sure that all traffic is routed to Global Secure Access, set the network adapter properties to [IPv4 preferred](troubleshoot-global-secure-access-client-diagnostics-health-check.md#ipv4-preferred).   
- UDP isn't supported on this platform yet.
- User-friendly end-user notifications are in development.
- Remote network connectivity for Internet Access is in development.
- Transport Layer Security (TLS) inspection is in development.
- URL path based filtering and URL categorization for HTTP and HTTPS traffic are in development.
- Traffic available for acquisition in the Microsoft traffic profile isn't available for acquisition in the Internet Access traffic profile.

---
title: "Troubleshoot the Global Secure Access client: Health check"
description: Troubleshoot the Global Secure Access client using the Health check tab in the Advanced diagnostics utility.\
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 07/24/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazb


# Customer intent: I want to troubleshoot the Global Secure Access client using the Health check tab in the Advanced diagnostics utility.
---
# Troubleshoot the Global Secure Access client: Health check tab
This document provides troubleshooting guidance for the Global Secure Access client using the **Health check** tab in the Advanced diagnostics utility.

## Introduction
The Advanced diagnostics Health check executes tests to verify that the Global Secure Access client is working correctly and that its components are running.

## Run the health check
To run a health check for the Global Secure Access client:
1. Right-click the Global Secure Access client system tray icon and select **Advanced Diagnostics**.
1. A User Account Control dialog box opens. Select **Yes** to allow the client application to make changes to your device.
1. In the **Global Secure Access Client - Advanced diagnostics** dialog box, select the **Health check** tab. Switching tabs runs the health check.

### Resolution process
Most of the Health check tests depend on one another. If tests fail:
1. Resolve the first failed test.
1. Select **Refresh** to view the updated test status.
1. Repeat until you have resolved all failed tests.
:::image type="content" source="media/troubleshoot-global-secure-access-client-advanced-diagnostics-health-check/troubleshoot-health-check-refresh.png" alt-text="Screenshot of the Global Secure Access Health check tab with the Refresh button highlighted.":::

### Check the Event Viewer
As part of the troubleshooting process, it can be useful to check the Event Viewer for the Global Secure Access client. The log contains valuable events regarding errors and their cause.
1. Navigate to **Control Panel** > **System and Security** > **Windows Tools**.
1. Launch **Event Viewer**.
1. Navigate to **Applications and Services Logs** > **Microsoft** > **Windows** > **Global Secure Access Client**.
1. Select **Operational**.

## Health check tests
The following checks verify the health of the Global Secure Access client.

### Device is Microsoft Entra joined
The Windows client authenticates the user and the device to Global Secure Access services. The device authentication, based on a device token, requires that the device is either Microsoft Entra joined or Microsoft Entra hybrid joined. Microsoft Entra registered devices are currently not supported.
To check the status of your device, enter the following command in the Command Prompt: `dsregcmd.exe /status`.
:::image type="content" source="media/troubleshoot-global-secure-access-client-advanced-diagnostics-health-check/troubleshoot-health-entra-joined.png" alt-text="Screenshot of the Command Prompt with the Device State, AzureAdJoined : Yes, highlighted.":::

To join your device to a Microsoft Entra tenant, see [Join your Windows machine to Azure Active Directory](https://identitydivision.visualstudio.com/IdentityWiki/_wiki/wikis/IdentityWiki.wiki/44817/Join-your-windows-machine-to-AAD).
> [!WARNING]
> The above link goes to a wiki page, NOT a public article. **Guidance needed**: Which public article should I replace this URL with? Or should I remove mention of the reference? Also, old branding: **the image shows "Azure AD" instead of Entra ID.**

### Can Connect to the internet
This check indicates whether or not the device is connected to the internet. An Internet connection is obligatory to connect to Global Secure Access.
This test is based on the [Network Connectivity Status Indicator (NCSI)](/windows-server/networking/ncsi/ncsi-overview) feature. 

### Tunneling service running
Global Secure Access Tunneling service must be running.
1. To verify that this service running, enter the following command in the Command Prompt: `sc query GlobalSecureAccessTunnelingService`.
1. If the Global Secure Access Tunneling service isn't running, start it from the `services.msc`.
1. If the service fails to start, look for errors in the Event Viewer.

### Management service running
Global Secure Access Management service must be running.
1. To verify that this service running, enter the following command in the Command Prompt: `sc query GlobalSecureAccessManagementService`.
1. If the Global Secure Access Management Service isn't running, start it from the `services.msc`.
1. If the service fails to start, look for errors in the Event Viewer.

### Policy Retriever service running
Global Secure Access Policy Retriever service must be running.
1. To verify that this service running, enter the following command in the Command Prompt: `sc query GlobalSecureAccessPolicyRetrieverService`.
1. If the Global Secure Access Policy Retriever service isn't running, start it from the `services.msc`.
1. If the service fails to start, look for errors in the Event Viewer.

### Driver running
The Global Secure Access driver must be running.
To verify that this service running, enter the following command in the Command Prompt: `sc query GlobalSecureAccessDriver`.

If the driver isn't running:
1. Open the Event Viewer and search the Global Secure Access client log for **event 304**.
1. If the driver isn't running, reboot the machine.
1. Run the `sc query GlobalSecureAccessDriver` command again.
1. If the issue remains unresolved, reinstall the Global Secure Access client.

### Client tray application running
The GlobalSecureAccessClient.exe process runs the client UX in the system tray.
If you can't see the Global Secure Access icon in the system tray, you can run it from the following path: `C:\Program Files\Global Secure Access Client\GlobalSecureAccessClient.exe`.

### Forwarding profile registry exists
This test verifies that the following registry key exists:
`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\ForwardingProfile`.

If the key doesn't exist, try to force forwarding policy retrieval:
1. Delete the `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\ForwardingProfileVersion` registry key, if it exists.
1. Restart the service, `Global Secure Access Policy Retriever Service`.
1. Check if the two registry keys are created.
1. If not, look for errors in the Event Viewer.

### Forwarding profile matches expected schema
This test verifies that the forwarding profile in the registry has a valid format that can be read by the client.

If this test fails, make sure you're using the most updated forwarding profile of your tenant by following these steps:

1. Delete the `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\ForwardingProfile` registry key.
1. Delete the `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\ForwardingProfileVersion` registry key.
1. Restart the service `Global Secure Access Policy Retriever Service`.
1. Restart the Global Secure Access client.
1. Run the health check again.
1. If the steps above don't solve the problem, upgrade the Global Secure Access client to the latest version.
1. If the problem still exists, contact Microsoft Support.

### Breakglass mode disabled
Break-glass mode prevents the Global Secure Access client from tunneling network traffic to the Global Secure Access cloud service. In Break-glass mode, all traffic profiles in the Global Secure Access portal have been unchecked and the Global Secure Access client isn't expected to tunnel any traffic. 

To set the client to acquire traffic and tunnel that traffic to the Global Secure Access service:
1. Sign in to the Micorsoft Entra portal as a tenant administrator.
1. Navigate to Global Secure **Access** > **Connect** > **Traffic forwarding**.
1. Enable at least one of the traffic profiles to match your organization's needs.

The client should recieve the updated forwarding profile within 1 hour after you make changes in the portal.

### Diagnostic URLs in forwarding profile
For each channel activated in the forwarding profile, this test checks that the configuration contains a URI to probe the service's health. 

To view the health status, double-click the Global Secure Access client system tray icon.
:::image type="content" source="media/troubleshoot-global-secure-access-client-advanced-diagnostics-health-check/troubleshoot-health-client-status.png" alt-text="Screenshot of the Global Secure Access client system tray icon along with the current health status of Connected.":::

If this test fails, it's usually an internal problem with Global Secure Access. Contact Microsoft Support.

### Authentication certificate exists
This test verifies that a certificate exists on the device for the Mutual Transport Layer Security (MTLS) connection to the Global Secure Access cloud service.
> [!TIP]
> This test doesn't appear if mTLS isn't enabled for your tenant yet.

If this test fails, enroll in a new certificate by completing the following steps:
1. Enter the following command in the Command Prompt: `certlm.msc` to launch the Microsoft Management console.
1. In the **certlm** window, navigate to **Personal** > **Certificates**.
1. Delete the certificate that ends with **gsa.client**.
:::image type="content" source="media/troubleshoot-global-secure-access-client-advanced-diagnostics-health-check/troubleshoot-health-check-gsa-client.png" alt-text="Screenshot of the list of certificates with the gsa.client certificate highlighted.":::
1. Delete the following registry key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\CertCommonName`.
1. Restart the Global Secure Access Management Service in the services MMC.
1. Refresh the certificates MMC to verify that a new certificate was created. *The refresh might take few minutes.*
1. Check the Global Secure Access client event log for errors.
1. Run the Health check tests again.

### Authentication certificate is valid
This test verifies that the authentication certificate used for the MTLS connection to the Global Secure Access cloud service is valid.
> [!TIP]
> This test doesn't appear if mTLS isn't enabled for your tenant yet.

If this test fails, enroll in a new certificate by completing the following steps:
1. Enter the following command in the Command Prompt: `certlm.msc` to launch the Microsoft Management console.
1. In the **certlm** window, navigate to **Personal** > **Certificates**.
1. Delete the certificate that ends with **gsa.client**.
:::image type="content" source="media/troubleshoot-global-secure-access-client-advanced-diagnostics-health-check/troubleshoot-health-check-gsa-client.png" alt-text="Screenshot of the list of certificates with the gsa.client certificate highlighted.":::
1. Delete the following registry key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\CertCommonName`.
1. Restart the Global Secure Access Management Service in the services MMC.
1. Refresh the certificates MMC to verify that a new certificate was created. *The refresh might take few minutes.*
1. Check the Global Secure Access client event log for errors.
1. Run the Health check tests again.

### DNS over HTTPS not supported
For the Global Secure Access client to acquire network traffic by a fully qualified domain name (FQDN) destination (as opposed to an IP destination), the client needs to read the DNS requests sent by the device to the DNS server. This means that DNS over HTTPS must be disabled if the forwarding profile contains FQDNs rules.

#### Secure DNS disabled in OS
To disable DNS over HTTPS in Windows, refer to [Secure DNS Client over HTTPS (DoH)](/windows-server/networking/dns/doh-client-support#configure-the-dns-client-to-support-doh.md).
> [!IMPORTANT]
> You must disable DNS over HTTPS to successfully run the Global Secure Access client Health check.

#### Secure DNS disabled in browsers (Microsoft Edge, Chrome, Firefox)
Check that Secure DNS is disabled for each of the following browsers:

##### Secure DNS disabled in Microsoft Edge
To disable DNS over HTTPS in Microsoft Edge:
1. Launch Microsoft Edge.
1. Open the **Settings and more** menu and select **Settings**.
1. Select **Privacy, search, and services**.
1. In the **Security** section, set the **Use secure DNS to specify how to lookup the network address for websites** toggle to off.

##### Secure DNS disabled in Chrome
To disable DNS over HTTPS in Google Chrome:
1. Open Chrome.
1. Select **Customize and control Google Chrome** and then select **Settings**.
1. Select **Privacy and security**.
1. Select **Security**.
1. In the **Advanced** section, set the **Use secure DNS** toggle to off.

##### Secure DNS disabled in Firefox
To disable DNS over HTTPS in Mozilla Firefox:
1. Open Firefox.
1. Select the **Open application menu** button and then select **Settings**.
1. Select **Privacy & Security**.
1. In the **DNS over HTTPS** section, select **Off**.

### DNS Responsive
This test checks whether the DNS server configured to Windows returns a DNS response.

If this test fails:
1. Pause the Global Secure Access client.
1. Check if the DNS server configured to Windows is reachable. For example, try resolving "microsoft.com" using the `nslookup` tool.
1. Check that a firewall isn't blocking traffic to the DNS server.
1. Configure an alternate DNS server and test again.
1. Resume the Global Secure Access client.

### Magic IP received
This check verifies that the client is able to acquire traffic from a fully qualified domain name (FQDN).

If the test fails:
1. Restart the client and test again.
1. Restart Windows. This might be necessary in rare cases to delete volatile cache.

### Cached token
This test verifies that the client authenticated successfully to Microsoft Entra.

If the cached token test fails:
1. The services and the driver are running.
1. The system tray icon is present.
1. If the sign-in notification appears, select **Sign in**.
image.png
1. If the sign-in notification doesn't appear, check if it is in the notification center and select **Sign in**.
image.png
1. Complete the sign-in process with Entra user of the same tenant that the device is joined to.
image.png
1. Make sure you're connected to the network.
1. Hover over the system tray icon and verify that the client isn't disabled by your organization.
image.png
1. Restart the client and wait for a few seconds.
1. Look for errors in the Event Viewer.

### IPv4 preferred
Global Secure Access doesn't yet support traffic acquisition for destinations with IPv6 addresses. We recommend that you configure the client to prefer IPv4 over IPv6, if:
1. The forwarding profile is set to acquire traffic by IPv4 (as opposed to by FQDN).
1. The FQDN that is resolved to this IP, is also resolved to an IPv6 address.

To configure the client to prefer IPv4 over IPv6, set the following registry key.

``HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\
Name: DisabledComponents
Type: REG_DWORD
Value: 0x20 (Hex)``

> [!IMPORTANT]
> Changes of the registry value above require computer restart. 
For more information, see [Guidance for configuring IPv6 in Windows for advanced users](/troubleshoot/windows-server/networking/configure-ipv6-in-windows).


### Private access edge hostname resolved by DNS
If this test fails, the hostnames of the Global Secure Access cloud service can't be resolved by the DNS and therefore the service isn't reachable. This could be a problem of Internet connectivity or a DNS server that doesn't resolve public Internet hostnames.
This test is conducted for all the different traffic types active for the user: Microsoft 365, Private Access, and Internet Access.

To verify that the name resolution works correctly:

Pause the client
Run the PowerShell command: Resolve-DnsName -Name <edge's FQDN>
If the name resolution fails, try running: Resolve-DnsName -Name microsoft.com
Verify the DNS servers configured for this machine ipconfig /all
Consider setting another public DNS server.

### Private access edge is reachable
If this test fails, the device doesn't have network connection to the Global Secure Access cloud service.
This test is conducted for all the different traffic types active for the user: Microsoft 365, Private Access, and Internet Access.

If the test fails, possible reasons could be:

Verify that the device has internet connection.
Verify that the firewall or proxy doesn't block your connection to the edge.
Make sure IPv4 is active on the device. Currently the edge works only with an IPv4 address.
Stop the client and retry ``Test-NetConnection -ComputerName <edge's fqdn> -Port 443``.
Try the PowerShell command from another device connected to the internet from a public network.

### Proxy disabled
This test checks whether the proxy is configured on the device. If the end-user device is configured to use a proxy for outgoing traffic to the internet, the destination IPs/FQDNs acquired by the client need to be excluded by a Proxy Auto-Configuration (PAC) file or with the Web Proxy Auto-Discovery (WPAD) protocol.

#### Change the PAC file
Add the FQDNs/IPs to be tunneled to Global Secure Access edge as exclusions in the PAC file, so that HTTP requests for these destinations won’t be redirected to the proxy. (These FQDNs/IPs are also set to be tunneled to Global Secure Access in the forwarding profile).
For the client's status health to be shown properly, add the FQDN used for health probing to the exclusions list: edgediagnostic.globalsecureaccess.microsoft.com 

Example PAC file containing exclusions:

```http
function FindProxyForURL(url, host) {  
        if (isPlainHostName(host) ||   
            dnsDomainIs(host, ".edgediagnostic.globalsecureaccess.microsoft.com") || //tunneled
            dnsDomainIs(host, ".contoso.com") || //tunneled 
            dnsDomainIs(host, ".fabrikam.com")) // tunneled 
           return "DIRECT";                    // For tunneled destinations, use "DIRECT" connection (and not the proxy)
        else                                   // for all other destinations 
           return "PROXY 10.1.0.10:8080";  // route the traffic to the proxy.
}
```
 
#### Add a system variable
Configuring the Global Secure Access client to route Global Secure Access traffic through a proxy:
1. Set a system environment variable in Windows named `grpc_proxy` to the value of the proxy address. For example, 'http://10.1.0.10:8080'.
1. Restart the Global Secure Access client.
image.png

### Tunneling succeeded Private Access
This test is conducted for each active traffic profile in the forwarding profile (M366, Private Access, Internet Access), verifying that connections to the health service of the corresponding channel are tunneled successfully.
In case of a failure:

Check the Event Viewer for errors.
Restart the client and try again.

### Global Secure Access processes healthy (last 24h)
This indicates that at least one process of the client crashed in the last 24 hours.
If all other tests pass, the client should be currently functioning but investigating the dump file of the process should be helpful to gain more stability in the future and to better understand why the process crashed.
First, we need to ask Windows to generate dump files when a process crashes.

 Configure user mode dumps:
Add the following registry key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps
Add a REG_SZ DumpFolder registry value, and set its data to an existing folder where you want the dump files to be created.
image.png
 Reproduce the issue and expect a .dmp file to be created in the dumpFolder.
 Open a ticket for Microsoft support attaching the dump files and the steps to reproduce.
 Access Application Event Viewer logs and filter crash events (Filter current logs: Event ID = 1000)
image.png
 Save filtered log as file (add it to the logs attached to the ticket)
image.png

### QUIC not supported for Internet Access
Since QUIC isn't yet supported for Internet Access, traffic to ports 80 UDP and 443 UDP can't be tunneled 
> [!TIP]
> QUIC is currently supported in Private Access and Microsoft 365 workloads.

Administrators can disable QUIC protocol triggering clients to fall back to HTTPS over TCP which is fully supported in Internet Access.

#### QUIC disabled in Microsoft Edge
To disable QUIC in Microsoft Edge:
Open Microsoft Edge
Access to: edge://flags/#enable-quic
Choose Disable

#### QUIC disabled in Chrome
To disable QUIC in Google Chrome:
Open Google Chrome
Access to: chrome://flags/#enable-quic
Choose Disable

#### QUIC disabled in Mozilla Firefox
To disable QUIC in Mozilla Firefox:
Open Firefox
Access to: about:config
Turn off network.http.http3.enable

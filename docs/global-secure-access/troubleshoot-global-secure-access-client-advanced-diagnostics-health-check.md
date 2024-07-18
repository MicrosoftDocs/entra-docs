---
title: Troubleshoot the Global Secure Access client with the advanced diagnostics Health check tab
description: Troubleshoot the Global Secure Access client using the **Health check** tab in the Advanced diagnostics utility.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 07/18/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazb
---
# Troubleshoot the Global Secure Access client with the advanced diagnostics Health check tab
This document provides troubleshooting guidance for the Global Secure Access client using the **Health check** tab in the Advanced diagnostics utility.

## Introduction
The Advanced diagnostics Health check executes tests to verify that the Global Secure Access client is working correctly and that its components are running.

## Verify the health of the Global Secure Access client
To run the client health check:
1. Right-click the Global Secure Access client system tray icon and select **Advanced Diagnostics**.
1. A User Account Control dialog box opens. Select **Yes** to allow the client app to make changes to your device.
1. In the **Global Secure Access Client - Advanced diagnostics** dialog box, select the **Health check** tab. Switching tabs runs the health tests.

## Resolution process
Most of the tests depend on one another. If there are failed tests:
1. Resolve the first failed test that failed and then 
1. Select **Refresh** to view the updated test status.
1. Repeat until you have resolved all failed tests.
image.png

As part of the troubleshooting process, it can be useful to review the event log for the Global Secure Access client. The event log contains valuable events regarding errors and their cause.
image.png

## Health check tests
The following checks verify the health of the Global Secure Access client.

### Device is Microsoft Entra joined
The Windows client authenticates the user and the device to Global Secure Access services. The device authentication (based on device token) requires that the device is either Microsoft Entra joined or Microsoft Entra hybrid joined. Microsoft Entra registered devices are currently not supported.
To check the status of your device, run the following command in an elevated cmd : dsregcmd.exe /status
image.png

To join your device to a Microsoft Entra tenant, follow this article

### Can Connect to the internet
Indicates whether the device is connected to the Internet or not. An Internet connection is obligatory to connect to Global Secure Access.
This test is based on the Network Connectivity Status Indicator 

### Tunneling service running
Global Secure Access Tunneling service must be running.

You can verify that this service is running by the following command:
sc query GlobalSecureAccessTunnelingService
If the Global Secure Access Tunneling Service isn't running, start it from the services.msc.
If the service fails to start, look for errors in the event viewer.

### Management service running
Global Secure Access Management service must be running.

You can verify that this service is running by the following command:
sc query GlobalSecureAccessManagementService
If the Global Secure Access Management Service isn't running, start it from the services.msc.
If the service fails to start, look for errors in the event viewer.

### Policy Retriever service running
Global Secure Access Policy Retriever service must be running.

You can verify if this service is running by the following command:
sc query GlobalSecureAccessPolicyRetrieverService
If the Global Secure Access Policy Retriever Service isn't running, start it from the services.msc.
If the service fails to start, look for errors in the event viewer.

### Driver running
You can verify that the driver is running by using the following command:
sc query GlobalSecureAccessDriver
If the driver isn't running:

Search for event 304 in the Global Secure Access client in the event log.
If the driver isn't running, reboot the machine.
Run sc query GlobalSecureAccessDriver again.
If the issue isn't resolved, reinstall the client.

### Client tray application running
The GlobalSecureAccessClient.exe process runs the client UX (the system tray icon).
If you can't see the Global Secure Access icon in the system tray, you can run it from the following path:
C:\Program Files\Global Secure Access Client\GlobalSecureAccessClient.exe

### Forwarding profile registry exists
This test verifies that the following registry key exists:
Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\ForwardingProfile

If the key doesn't exist, try to force forwarding policy retrieval:

Delete the Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\ForwardingProfileVersion registry key, if it exists.
Restart the service Global Secure Access Policy Retriever Service
Check if the registry keys above were created.
If not, look for errors in the event viewer.

### Forwarding profile matches expected schema
This test verifies that the forwarding profile in the registry has a valid format that can be read by the client.

If this test fails, make sure you're using the most updated forwarding profile of your tenant by following these steps:

Delete the Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\ForwardingProfile registry key.
Delete the Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\ForwardingProfileVersion registry key.
Restart the service Global Secure Access Policy Retriever Service
Restart the client
Run the client checker again
If the steps above don't solve the problem, upgrade the client to the latest version.

If the problem still exists, contact Microsoft support.

### Breakglass mode disabled
Break-glass mode allows the IT admin to stop the client from tunneling any network traffic to the Global Secure Access cloud service. This is done by unchecking all the traffic profiles in Global Secure Access portal, which results in a forwarding profile that doesn't contain rules to tunnel any traffic.

If break-glass mode is enabled, the client isn't expected to tunnel any traffic.

If you would like the client to acquire traffic and send it to Global Secure Access service, enable at least one of the traffic profile according to your organization's needs.
This setting can be modified by the tenant admin in the Entra portal, under Global Secure Access, Connect, Traffic forwarding.

After the change in the portal, the updated forwarding profile should be received by the clients within 1 hour.

### Diagnostic URLs in forwarding profile
This test is conducted for each channel activated in the forwarding profile, checking that the configuration contains a URI for probing the service's health. The health status can be viewed by double-clicking on the system tray icon.
If this test fails, it's usually an internal problem in Global Secure Access and Microsoft support team needs to be contacted.

### Secure DNS disabled in OS
To disable DNS over HTTPS in Windows, refer to [Secure DNS Client over HTTPS (DoH)](/windows-server/networking/dns/doh-client-support#configure-the-dns-client-to-support-doh.md).
> [!IMPORTANT]
> You must disable DNS over HTTPS to successfully run the client Health check.

### Secure DNS disabled in browsers (Microsoft Edge, Chrome, Firefox)
Secure DNS disabled in Microsoft Edge
To disable DNS over HTTPS in Microsoft Edge:

Open Microsoft Edge
At the top right, open the menu (…) and click Settings
Click Privacy, search and services
Scroll down to the Security section
Turn off "Use secure DNS to specify how to look up the network address for website"
Secure DNS disabled in Chrome
To disable DNS over HTTPS in Google Chrome use the following instructions as described in this Google’s article  in the "Use a secure connection to look up sites' IP addresses" section.

Open Chrome.
At the top right, select More and then Settings.
Click Privacy and security
Click Security.
Turn off "Use Secure DNS".
Secure DNS disabled in Firefox
To disable DNS over HTTPS in Mozilla Firefox use the following instructions as described in this Mozilla article.

Open Firefox.
Click the menu button image.png at the top right of the screen.
Click Settings.
Click Privacy & Security on the left.
Scroll down to the DNS over HTTPS section.
Click "Off"

### DNS Responsive
A test that checks whether the DNS server that the OS is configured to work with, returns a DNS response.

If this test fails

Pause the client.
Check if the DNS server Windows is configured to work with is reachable. For example, try resolving "microsoft.com " using nslookup.
Check that a firewall doesn't block traffic to the DNS server.
Try to configure a different DNS server and test again.
Resume the client.

### Magic IP received for FQDN
This check verifies that the client is able to acquire traffic by FQDN.
If the test fails:

Restart the client and test again.
Restart Windows, this might be needed in some rare cases to delete volatile cache.
(INTERNAL ONLY DOCUMENTATION: - a restart might be needed if magic IP range is exhausted or if the magic IP range changes)

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
> Changes of the registry value above require computer restart. For information, see [Guidance for configuring IPv6 in Windows for advanced users](https://learn.microsoft.com/troubleshoot/windows-server/networking/configure-ipv6-in-windows).

Cached token
This test verifies that the client authenticated successfully to Microsoft Entra.

If the cached token test fails, check the following:

The services and the driver are running.
The system tray icon is present.
If the sign-in notification appears, press sign in:
image.png
If the sign-in notification doesn't appear, check if it is in the notification center and press sign in.
image.png
Then complete the sign in with Entra user of the same tenant that the device is joined to.
image.png
Make sure you're connected to the network.
Hover the system tray icon and verify that the client isn't disabled by your organization.
image.png
Restart the client and wait for few seconds.
Look for errors in the event viewer.
Microsoft Edge hostnames are resolved by DNS
If this test fails, the hostnames of the Global Secure Access cloud service can't be resolved by the DNS and therefore the service isn't reachable. This could be a problem of Internet connectivity or a DNS server that doesn't resolve public Internet hostnames.
This test is conducted for all the different traffic types active for the user: Microsoft 365, Private Access, and Internet Access.

To verify that the name resolution works correctly:

Pause the client
Run the PowerShell command: Resolve-DnsName -Name <edge's FQDN>
If the name resolution fails, try running: Resolve-DnsName -Name microsoft.com
Verify the DNS servers configured for this machine ipconfig /all
Consider setting another public DNS server.
Edges are reachable
If this test fails, the device doesn't have network connection to the Global Secure Access cloud service.
This test is conducted for all the different traffic types active for the user: Microsoft 365, Private Access, and Internet Access.

If the test fails, possible reasons could be:

Verify that the device has internet connection.
Verify that the firewall or proxy doesn't block your connection to the edge.
Make sure IPv4 is active on the device. Currently the edge works only with an IPv4 address.
Stop the client and retry Test-NetConnection -ComputerName <edge's fqdn> -Port 443.
Try the PowerShell command from another device connected to the internet from a public network.
Proxy disabled
A test that checks whether proxy is configured on the device. If the end-user device is configured to use a proxy for outgoing traffic to the internet, the destination IPs/FQDNs acquired by the client need to be excluded by a PAC file (or WPAD).

Changes to PAC file:
Add the FQDNs/IPs to be tunneled to Global Secure Access edge as exclusions in the PAC file, so that HTTP requests for these destinations won’t be redirected to the proxy. (These FQDNs/IPs are also set to be tunneled to Global Secure Access in the forwarding profile).
For the client's status health to be shown properly, add the FQDN used for health probing to the exclusions list: edgediagnostic.globalsecureaccess.microsoft.com 
Example for a PAC file containing exclusions:

function FindProxyForURL(url, host) {  
        if (isPlainHostName(host) ||   
            dnsDomainIs(host, ".edgediagnostic.globalsecureaccess.microsoft.com") || //tunneled
            dnsDomainIs(host, ".contoso.com") || //tunneled 
            dnsDomainIs(host, ".fabrikam.com")) // tunneled 
           return "DIRECT";                    // For tunneled destinations, use "DIRECT" connection (and not the proxy)
        else                                   // for all other destinations 
           return "PROXY 10.1.0.10:8080";  // route the traffic to the proxy.
} 
Add system variable
Configuring the Global Secure Access client to route Global Secure Access traffic through a proxy:

Set a system environment variable in Windows named grpc_proxy to the value of the proxy address, example:
http://10.1.0.10:8080 

Restart the Global Secure Access client.
image.png

Tunneling succeeded
This test is conducted for each active traffic profile in the forwarding profile (M366, Private Access, Internet Access), verifying that connections to the health service of the corresponding channel are tunneled successfully.
In case of a failure:

Check the event viewer for errors.
Restart the client and try again.
GlobalSecureAccess Processes are healthy and not crashing in the last 24 hours.
This indicates that at least one process of the client crashed in the last 24 hours.
If all other tests pass, the client should be currently functioning but investigating the dump file of the process should be helpful to gain more stability in the future and to better understand why the process crashed.
First, we need to ask Windows to generate dump files when a process crashes.

 Configure user mode dumps:
Add the following registry key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps
Add a REG_SZ DumpFolder registry value, and set its data to an existing folder where you want the dump files to be created.
image.png
 Reproduce the issue and expect a .dmp file to be created in the dumpFolder.
 Open a ticket for Microsoft support attaching the dump files and the steps to reproduce.
 Access Application event viewer logs and filter crash events (Filter current logs: Event ID = 1000)
image.png
 Save filtered log as file (add it to the logs attached to the ticket)
image.png
QUIC not supported for Internet Access
Since QUIC isn't yet supported for Internet Access, traffic to ports 80 UDP and 443 UDP can't be tunneled (note: It's supported in Private Access and Microsoft 365 workloads).

Administrators can disable QUIC protocol triggering clients to fall back to HTTPS over TCP which is fully supported in Internet Access.

QUIC disabled in Microsoft Edge
To disable QUIC in Microsoft Edge:

Open Microsoft Edge
Access to: edge://flags/#enable-quic
Choose Disable
QUIC disabled in Chrome
To disable QUIC in Google Chrome:

Open Google Chrome
Access to: chrome://flags/#enable-quic
Choose Disable
QUIC disabled in Mozilla Firefox
To disable QUIC in Mozilla Firefox:

Open Firefox
Access to: about:config
Turn off network.http.http3.enable

### Authentication certificate exists
This test verifies that a certificate exists on the device for mTLS connection to the Global Secure Access cloud service.
Note: If this test doesn't appear, mTLS wasn't enabled for your tenant yet.

If this test fails, try enrolling a new certificate by the following steps:

Run the command certlm.msc
Go to personal -> Certificates
image.png
Delete the certificate that has "issued to" field that ends with "gsa.client"
image.png
Delete the following registry key:
Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\CertCommonName
Restart the Global Secure Access Management Service in the services MMC
Refresh the certificates MMC to verify that a new certificate was created (this might take few minutes)
Check the Global Secure Access client event log for errors
Run the **Health check** tests again

### Authentication certificate is valid
This test verifies that the Global Secure Access certificate (used for mTLS connection to the Global Secure Access cloud service) is valid.
Note: If this test doesn't appear, mTLS wasn't enabled for your tenant yet.

If this test fails, try enrolling a new certificate by the following steps:

1. Run the command ``certlm.msc``
1. Go to personal -> Certificates
image.png
1. Delete the certificate that has "issued to" field that ends with "gsa.client"
image.png
1. Delete the following registry key:
``Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Global Secure Access Client\CertCommonName``
1. Restart the Global Secure Access Management Service in the services MMC
1. Refresh the certificates MMC to verify that a new certificate was created (this might take few minutes)
1. Check the Global Secure Access client event log for errors
1. Run the **Health check** tests again.

### Disable DNS over HTTPS
For the client to acquire network traffic by FQDN destination (as opposed to IP destination), the client needs to read the DNS requests sent by the device to the DNS server. Hence, DNS over HTTPS needs to be disabled, if the forwarding profile contains FQDNs rules.
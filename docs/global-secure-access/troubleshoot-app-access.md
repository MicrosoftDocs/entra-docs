---
title: Troubleshoot application access
description: Learn how to troubleshoot application access problems with the Global Secure Access Windows client.
author: jricketts
manager: martinco
ms.author: jricketts
ms.service: global-secure-access
ms.topic: troubleshooting-general
ms.date: 03/05/2025
ms.reviewer: andresc

#CustomerIntent: As an IT admin, I want troubleshoot application access for the Global Secure Access Windows client so that I can ensure its proper operation.

---
# Troubleshoot application access

This article helps you to identify and resolve application access problems with the Global Secure Access Windows client.

## Troubleshoot client connection

To check that the client successfully connects to all channels, double-click the tray icon. Reference [Troubleshoot the Global Secure Access client: Health check tab](troubleshoot-global-secure-access-client-diagnostics-health-check.md) for known issue troubleshooting guidance for the **Health check** tab in the Advanced diagnostics utility.

Review Global Secure Access Windows client [known limitations](how-to-install-windows-client.md#known-limitations).

## Does Global Secure Access acquire application traffic?

This section helps you to understand whether Global Secure Access acquires the traffic that the application generates.

1. To troubleshoot client traffic, go to **Advanced diagnostics** > **Traffic**.
1. Start the traffic collection. 
1. Reproduce what you are trying to do.
1. Observe **Traffic** activity.
1. If you know to which target IPs and ports your app should connect, filter by them and remove unrelated traffic, which makes troubleshooting easier. In the following example screenshot, filter `Destination Port == 3389` helps to troubleshoot Remote Desktop Protocol (RDP) connections.

   :::image type="content" source="media/troubleshoot-app-access/network-traffic-destination-port.png" alt-text="Screenshot of Network traffic Destination port filter." lightbox="media/troubleshoot-app-access/network-traffic-destination-port-expanded.png":::

In the previous example screenshot, the default filter `Action==Tunnel` results with a line (or flow) that indicates the Global Secure Access client is:

- Seeing the traffic.
- Evaluating the protocol and destination IP/FQDN and port against the traffic forwarding rules.
- Determining that the traffic should tunnel to the Global Secure Access service. Otherwise, the **Connection Status** would say **Bypassed**.

If you don't know the destination IPs or ports, you can try filtering by process name. In the previous example, you can filter by process name `mstsc.exe`.

## Other traffic bypass problems

In **Traffic forwarding** > **Microsoft traffic profile** and **Internet access profile**, you can configure bypass rules to defined destinations that Global Secure Access clients shouldn't handle. This scenario might cause the Global Secure Access client to not acquire and tunnel traffic.

:::image type="content" source="media/troubleshoot-app-access/internet-access-policies-bypass.png" alt-text="Screenshot of Internet access policies Internet traffic profile." lightbox="media/troubleshoot-app-access/internet-access-policies-bypass-expanded.png":::

## App connectivity requirements

This section helps you to understand how apps might require connectivity to destinations not included in existing app segments.

Applications might require connectivity to different services with multiple destination IPs or ports or that use User Datagram Protocol (UDP) or Transmission Control Protocol (TCP).

It's common to have applications that require connectivity to destinations not included in existing app segments. Follow these steps to determine if this scenario applies to you.

In the following example, the client successfully created and tunneled an RDP connection. However, the user reported performance problems. To understand if traffic is being bypassed, you can remove the default `Action==Tunnel` filter, add a process name filter, and reproduce the problem. Then you can observe that `mstsc.exe` is trying to send traffic to the RDP server on 3389/UDP. The Global Secure Access client bypassed the traffic because it doesn't match a forwarding profile rule.

:::image type="content" source="media/troubleshoot-app-access/network-traffic-process-name.png" alt-text="Screenshot of Network traffic Process name filter." lightbox="media/troubleshoot-app-access/network-traffic-process-name-expanded.png":::

In some cases, it's not as easy to spot missing traffic because the process that initiates the connection isn't the application process. A common example is authentication traffic.

Your application traffic might be correctly tunneled. If the app fails because of authentication failure, you might need to add filters to eliminate unrelated traffic from the collection. This approach might make it easier to spot what else is happening or what the Global Secure Access client bypassed.

For example, a user accesses a file share from a Windows 11 device. Observe the following conditions:

- Windows tries Server Message Block (SMB) over QUIC, which uses 443/UDP.
- `lsass.exe` (Local Security Authority process) initiates connections to domain controllers on port 88/TCP (Kerberos).
- In this case, the authentication traffic is being tunneled because the corresponding rules are created. If this case isn't true, Windows generally falls back to NTLM which doesn't require other ports but, depending on configuration, this case might not true.
- We see a connection on 445/TCP, which is the SMB protocol used for file share access.

:::image type="content" source="media/troubleshoot-app-access/network-traffic-filter-kerberos.png" alt-text="Screenshot of Network traffic filter for Kerberos." lightbox="media/troubleshoot-app-access/network-traffic-filter-kerberos-expanded.png":::

## Flows with 0 sent or received bytes

Flows showing some sent bytes and 0 received bytes might indicate a server or Private Connector problem. Use the Correlation Vector ID to investigate with [Traffic logs](how-to-view-traffic-logs.md). Correlation Vector ID is called **Connection ID** in Traffic logs.

In some cases, you might see traffic that the Global Secure Access client acquired but see no outbound packets. In the example, **Bytes sent** is 0. This behavior might occur when a Windows Firewall rule drops or blocks specific traffic. In the previous example, a Windows Firewall rule was blocking RDP.

:::image type="content" source="media/troubleshoot-app-access/network-traffic-bytes-sent.png" alt-text="Screenshot of Network traffic Bytes sent." lightbox="media/troubleshoot-app-access/network-traffic-bytes-sent-expanded.png":::

## How does DNS work with Global Secure Access?

The Global Secure Access client has generally two ways to work with fully qualified domain names (FQDN).

If you created rules (app segments) with FQDNs, then the client intercepts DNS query responses sent to the DNS server defined on the device, usually with Dynamic Host Configuration Protocol (DHCP). If the query (for example, `fs.contoso.local`) matches a rule, irrespective of the result (for example, a user at home isn't typically able to resolve corporate network names), the Global Secure Access rewrites the query response to a dynamic synthetic IP. Then, if the destination protocol and port matches a rule, the Global Secure Access cloud service for Internet traffic, or a private network connector for Microsoft Entra Private Access, resolves the name.

If you use private DNS, things get more interesting. For each configured private DNS suffix, the Global Secure Access client adds a Name Resolution Policy Table (NRPT) rule to direct those queries to a synthetic IP (usually `6.6.255.254`). The NRPT allows you to configure name resolution request routing to specified DNS servers for specified namespaces. It overrides the default behavior of sending these requests to the DNS server configured on your computer's network adapter.

Global Secure Access uses NRPT policies to direct all name resolution for private DNS suffixes to a specific server. A private network connector uses the DNS server configured on the server to tunnel and resolve these queries.

To check NRPT rules, run `Get-DnsClientNrptPolicy`. In the following example, we see that Global Secure Access created two NRPT policies:

- One for a suffix configured on private DNS.
- One to send unqualified names (also known as *single label*) through the tunnel. The Global Secure Access client adds a DNS search suffix for `AppId.globalsecureaccess.local`.

:::image type="content" source="media/troubleshoot-app-access/nrpt-policies.png" alt-text="Screenshot of Name Resolution Policy Table policy." lightbox="media/troubleshoot-app-access/nrpt-policies-expanded.png":::

After queries resolve, Global Secure Access continues with the IP/port/protocol evaluation to determine if it should acquire and tunnel the traffic.

To troubleshoot DNS resolution, use these options:

- The `Resolve-DnsName` PowerShell command follows NRPT rules.
- `NSLOOKUP` doesn't follow NRPT rules. To force queries with the tunnel, use `nslookup fs.contoso.local 6.6.255.254`.

For more advanced troubleshooting, use the DNS Client log provider. This method helps you to understand the DNS servers used, queries sent while certain activity generates (for example, trying to open a file share), and responses.

- To enable the DNS Client log provider, run `wevtutil sl Microsoft-Windows-DNS-Client/Operational /enabled:true`. Remember to disable it after you finish troubleshooting.
- After you reproduce your problem, use PowerShell to filter and display the relevant logs. In the following example, we get logs from the last three minutes, filtered by queries that contain `contoso.local`.

```powershell
    $StartDate = (Get-Date).AddMinutes(-3) ; Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-DNS-Client/Operational';StartTime=$Startdate} | where Message -Match contoso.local | Out-GridView
```

## Microsoft Entra Private Access resource access failure

Accessing resources through Private Access might fail for other reasons. Traffic logs can help you to troubleshoot issues that might be unrelated to client-side problems. Here are some troubleshooting steps you can follow. Reference [Troubleshoot Global Secure Access client: Advanced Diagnostics](troubleshoot-global-secure-access-client-advanced-diagnostics.md).

- Capture traffic with the **Advanced Diagnostics** tool. Ensure that it acquires and tunnels the flows.
Get and use the **Correlation vector ID** to look up Global Secure Access traffic logs on the Microsoft Entra admin center. Traffic logs show what connector handled the traffic and if errors occurred.
- If there are no errors on traffic logs pointing at problems communicating with private network connectors, obtain and analyze a network capture to see the actual conversations going through the tunnel.

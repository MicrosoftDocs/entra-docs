---
title: "Troubleshoot the Global Secure Access Client for Windows: Advanced Diagnostics"
description: Troubleshoot the Global Secure Access client using the health check tab in the advanced diagnostics utility.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 06/18/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: lirazbarak
ms.custom: sfi-image-nochange
# Customer intent: I want to troubleshoot the Global Secure Access client using the Advanced diagnostics utility.
---
# Troubleshoot the Global Secure Access client for Windows: Advanced diagnostics
This article provides troubleshooting guidance for the Global Secure Access client for Windows. It explores each tab of the Advanced diagnostics utility.

## Introduction
The Global Secure Access client runs in the background, routing relevant network traffic to Global Secure Access without requiring user interaction. Use the advanced diagnostics tool to gain visibility into the client's behavior and troubleshoot issues effectively.  

## Launch the advanced diagnostics tool
There are two ways to launch the advanced diagnostics tool:
1. Right-click the **Global Secure Access client** icon in the system tray.
1. Select **Advanced Diagnostics**. If enabled, User Account Control (UAC) prompts you to elevate privileges.

Or
1. Select the **Global Secure Access client** icon in the system tray.
1. Switch to the **Troubleshooting** view.
1. Under **Advanced diagnostics tool**, select **Run tool**.

## Overview tab
The advanced diagnostics **Overview** tab shows general configuration details for the Global Secure Access client:
- **Username**: The Microsoft Entra user principal name of the user who authenticated to the client.
- **Device ID**: The ID of the device in Microsoft Entra. The device must be joined to the tenant.
- **Tenant ID**: The ID of the tenant that the client points to, which is the same tenant the device is joined to.
- **Forwarding Profile ID**: The ID of the forwarding profile currently in use by the client.
- **Forwarding Profile last checked**: The time the client last checked for an updated forwarding profile.
- **Client version**: The version of the Global Secure Access client that is currently installed on the device.
   
:::image type="content" source="media/troubleshoot-global-secure-access-client-advanced-diagnostics/global-secure-access-client-advanced-diagnostics-overview-tab.png" alt-text="Screenshot of the Global Secure Access Client - Advanced diagnostics dialog box on the Overview tab.":::

## Health check tab
The **Health check** tab runs common tests to verify that the client and its components are functioning correctly. For more information, see [Troubleshoot the Global Secure Access client: Health check tab](troubleshoot-global-secure-access-client-diagnostics-health-check.md).  

## Forwarding profile tab
The **Forwarding profile** tab shows the list of active rules set for the forwarding profile. The tab includes the following information:
- **Forwarding profile ID**: The ID of the forwarding profile currently in use by the client.
- **Forwarding profile last checked**: The time when the client last checked for an updated forwarding profile.
- **Refresh details**: Select to reload the forwarding data from the client's cache if it was updated since the last refresh.
- **Policy tester**: Select to show the active rule for a connection to a specific destination.
- **Add filter**: Select to set filters to see only a subset of the rules according to a specific set of filter properties.
- **Columns**: Select to pick which columns to display in the table.

:::image type="content" source="media/troubleshoot-global-secure-access-client-advanced-diagnostics/global-secure-access-client-advanced-diagnostics-forwarding-profile-tab.png" alt-text="Screenshot of the Global Secure Access Client - Advanced diagnostics dialog box on the Forwarding profile tab.":::

The rules section lists rules grouped by workload (**M365 rules**, **Private access rules**, **Internet access rules**). This list only includes rules for the workloads activated in your tenant.
> [!TIP]
> If a rule includes multiple destinations, like a fully qualified domain name (FQDN) or an IP range, the rule spans several rows with one row per destination.

For each rule, the available columns include:
- **Priority**: The priority of the rule. Rules with higher priority (smaller numerical value) take precedence over rules with lower priority.
- **Destination (IP/FQDN)**: The destination of the traffic by FQDN or by IP.
- **Protocol**: The network protocol for the traffic: TCP or UDP.
- **Port**: The destination port of the traffic.
- **Action**: The action the client takes when outgoing traffic matches the destination, protocol, and port. The supported actions are **tunnel** (route to Global Secure Access) or **bypass** (go directly to the destination).
- **Hardening**: The action when traffic should be tunneled (routed to Global Secure Access) but the connection to the cloud service fails. Supported hardening actions are **block** (drop the connection) or **bypass** (allow the connection to go directly to the network).
- **Rule ID**: The unique identifier of the rule in the forwarding profile.
- **Application ID**: The ID of the private application associated with the rule. This column is relevant only for private applications.

## Hostname acquisition tab
The Hostname acquisition tab lets you collect a live list of client-acquired hostnames based on the FQDN rules in the forwarding profile. Each hostname appears in a new row.
- **Start collecting**: Select to begin the live collection of acquired hostnames.
- **Export CSV**: Select to export the list of acquired hostnames to a CSV file.
- **Clear table**: Select to clear the acquired hostnames displayed in the table.
- **Add filter**: Select to filter the acquired hostnames based on specific properties.
- **Columns**: Select to choose the columns to display in the table.

For each hostname, the available columns include:
- **Timestamp**: The date and time of each FQDN hostname acquisition.
- **FQDN**: The FQDN of acquired hostname.
- **Generated IP address**: The IP address generated by the client for internal purposes. This IP appears in the traffic tab for connections established to the corresponding FQDN.
- **Acquired**: Shows **Yes** or **No** to indicate if an FQDN matches a rule in the forwarding profile.
- **Original IP address**: The first IPv4 address in the DNS response for the FQDN query. If the end-user device DNS server doesn't return an IPv4 address for the query, the original IP address column is blank.

## Traffic tab
The traffic tab lets you collect a live list of connections opened by the device based on the rules in the forwarding profile. Each connection appears in a new row.
- **Start collecting**: Select to begin the live collection of connections.
- **Export CSV**: Select to export the list of connections to a CSV file.
- **Clear table**: Select to clear the connections displayed in the table.
- **Add filter**: Select to set filters and view a subset of the connections based on specific filter properties.
- **Columns**: Select to choose the columns to display in the table.

For each connection, the available columns include:
- **Timestamp begin**: The time the operating system opened the connection.
- **Timestamp end**: The time when the operating system closed the connection.
- **Connection status**: Indicates whether the connection is still active or is already closed.
- **Protocol**: The network protocol for the connection; either TCP or UDP.
- **Destination FQDN**: The destination FQDN for the connection.
- **Source port**: The source port for the connection.
- **Destination IP**: The destination IP for the connection.
- **Destination port**: The destination port for the connection.
- **Correlation vector ID**: a unique ID attributed to each connection that can be correlated with Global Secure Access traffic logs in the portal. Microsoft Support can also use this ID to investigate internal logs related to a specific connection.
- **Process name**: The name of the process that opened the connection.
- **Process ID**: The ID number for the process that opened the connection.
- **Bytes sent**: The number of bytes sent from the device to the destination.
- **Bytes received**: The number of bytes received by the device from the destination.
- **Channel**: The channel to which the connection was tunneled; can be Microsoft 365, Private Access, or Internet Access.
- **Flow ID**: The internal ID number for the connection.
- **Rule ID**: The identifier for the forwarding profile rule used to determine the actions for this connection.
- **Action**: The action that was taken for this connection; possible actions are:
    - **Tunnel**: The client tunneled the connection to the Global Secure Access service in the cloud.
    - **Bypass**: The connection goes directly to the destination through the device's network with no intervention by the client.
    - **Block**: The client blocked the connection (only possible in Hardening mode).
- **Hardening**: Indicates whether hardening is applied to this connection; can be Yes or No. Hardening applies when the Global Secure Access service isn't reachable from the device.

## Advanced log collection tab
The advanced log collection tab lets you collect verbose logs of the client, operating systems, and network traffic during a specific period. The logs are archived in a ZIP file that you can send to the admin or Microsoft Support for investigation.
- **Start recording**: Select to begin recording the verbose logs. Reproduce the issue while recording. If the issue doesn't occur, collect logs until it reappears. Log collection includes several hours of Global Secure Access activity.
- **Stop recording**: After reproducing the issue, select this button to stop the recording and save the collected logs to a ZIP file. Share the ZIP file with support for troubleshooting assistance.

:::image type="content" source="media/troubleshoot-global-secure-access-client-advanced-diagnostics/global-secure-access-client-advanced-advanced-log-collection-tab.png" alt-text="Screenshot showing the Global Secure Access Client - Advanced diagnostics dialog box on the Advanced log collection tab.":::

When advanced log collection stops, the folder containing the log files opens. By default, the folder is *C:\Program Files\Global Secure Access Client\Logs*. The folder contains a zip file and two event trace log (ETL) files. If needed, you can remove the zip files after resolving the issues. It's best to leave the ETL files because they're circular logs, and removing them might create issues with future log collection. 

The following files are collected:

|File |Description |
| - | - |
|Application-Crash.evtx |Application log filtered by event ID 1001. This log is useful when services are crashing. |
|BindingNetworkDrivers.txt |Result of "Get-NetAdapterBinding -AllBindings -IncludeHidden" showing all the modules bound to network adapters. This output is useful to identify if non-Microsoft drivers are bound to the network stack. |
|ClientChecker.log|Results of the Global Secure Access client health checks. These results are easier to analyze if you load the zip file in the Global Secure Access client. See [Analyze Global Secure Access client logs on a different device than where they were collected](#analyze-global-secure-access-client-logs-on-a-different-device-than-where-they-were-collected).|
|DeviceInformation.log |Environment variables including OS version and Global Secure Access client version.|
|dsregcmd.txt|Output of dsregcmd /status showing device state including Microsoft Entra Joined, Hybrid Joined, PRT details, and Windows Hello for Business details. |
|filterDriver.txt |Windows Filtering Platform filters |
|ForwardingProfile.json |The json policy that was delivered to the Global Secure Access client and includes the Global Secure Access service edge IP address your Global Secure Access client is connecting to (*.globalsecureaccess.microsoft.com) and forwarding profile rules. |
|GlobalSecureAccess-Boot-Trace.etl |Global Secure Access client debug logging |
|GlobalSecureAccess-Boot-Trace.etl |Global Secure Access client debug logging |
|Multiple .reg files |Global Secure Access client registry exports |
|hosts |Host file |
|installedPrograms.txt |Windows installed apps, which can be useful to understand what might be causing issues. |
|ipconfig.txt |Ipconfig /all output including IP address and DNS servers that have been assigned to the device. |
|Kerberos_info.txt |Output of klist, klist tgt, and klist cloud_debug. This output is useful for troubleshooting kerberos issues, and SSO with Windows Hello for Business. |
|LogsCollectorLog.log and LogsCollectorLog.log.x |Logs for the log collector process itself. These logs are useful if you're having issues with Global Secure Access log collection. |
|Multiple .evtx |Exports of multiple Windows event logs. |
|NetworkInformation.log |Output of route print, Name Resolution Policy Table (NRPT) table, and latency results for Global Secure Access connectivity test. This output is useful to troubleshoot NRPT issues. |
|RunningProcesses.log |Running processes |
|systeminfo.txt |System information including hardware, OS versions, and patches. |
|systemWideProxy.txt |Output of netsh winhttp show proxy |
|userConfiguredProxy |Output of proxy settings in the registry |
|userSessions.txt |User session list |
|DNSClient.etl |DNS client logs. These logs are useful for diagnosing DNS resolution issues. Open with Event Log viewer, or filter to the specific names of interest with PowerShell: `Get-WinEvent -Path .\DNSClient.etl -Oldest | where Message -Match replace with name/FQDN | Out-GridView`|
|InternetDebug.etl |Logs collected using "netsh trace start scenario=internetClient_dbg capture=yes persistent=yes". |
|NetworkTrace.etl |Net capture taken with pktmon |
|NetworkTrace.pcap |Network capture including traffic inside the tunnel |
|NetworkTrace.txt |Pkmon trace in text format |
|wfplog.cab |Windows Filtering Platform logs |

### Useful Network Traffic Analyzer filters
In some instances, you need to investigate traffic within the Global Secure Access service tunnel. By default, a network capture only shows encrypted traffic. Instead, analyze the network capture created by Global Secure Access advanced log collection in a network traffic analyzer. 

### Analyze Global Secure Access client logs on a different device than where they were collected
You might need to use your own device to analyze the data your users collect. To analyze the user-collected data, open the Global Secure Access client on your device, open the Advanced Diagnostic tool, and then select the folder icon to the far right of the menu bar. From here, you can navigate to the zip file or the GlobalSecureAccess-Trace.etl file. Loading the zip file also loads information including tenant ID, device ID, client version, health check, and forwarding profile rules as if you were troubleshooting locally on the device used for data collection.

## Related content
- [Troubleshoot the Global Secure Access Mobile Client: Advanced Diagnostics](troubleshoot-global-secure-access-mobile-client-advanced-diagnostics.md)

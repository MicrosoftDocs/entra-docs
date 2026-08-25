---
title: Integrate Global Secure Access with Microsoft Sentinel
description: Strengthen your organization's security posture by integrating Global Secure Access with Microsoft Sentinel using preconfigured workbooks and analytics rules.
ms.topic: how-to
ms.date: 06/04/2026
ms.reviewer: kerenSemel
ai-usage: ai-assisted

#customer intent: As a Microsoft Sentinel user, I want to strengthen my organization's security posture by installing the Global Secure Access solution from the Content hub so that I can use preconfigured workbooks and analytics rules.

---

# Enhance threat detection with Global Secure Access in Microsoft Sentinel

Global Secure Access integrates with Microsoft Sentinel, so organizations can stream network traffic logs, audit logs, and alerts directly into Sentinel. This integration uses Microsoft Entra diagnostic settings and a Global Secure Access content hub package with preconfigured workbooks and analytics rules to enhance security monitoring and visualization. Organizations can use this integration to correlate Global Secure Access data with other Microsoft security services to improve threat detection and response across their environments.

## Prerequisites

To integrate Global Secure Access with Microsoft Sentinel, you need the following configurations and permissions:
- Microsoft Sentinel, enabled on a Log Analytics workspace. For more information, see [create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace).
- Global Secure Access, configured with traffic forwarding profiles such as Microsoft 365, Internet Access, and Private Access.
- A Microsoft Entra ID data connector, configured according to the instructions in [Send data to Microsoft Sentinel using the Microsoft Entra ID data connector](/azure/sentinel/connect-azure-active-directory).
- An active Azure subscription.
- **Microsoft Entra Security Administrator** role to configure diagnostic settings.
- **Microsoft Sentinel Contributor** permissions for the resource group that the workspace belongs to, to install or manage solutions and configure analytics in the content hub.
- **Contributor** permissions for the subscription where the Microsoft Sentinel workspace resides to enable Microsoft Sentinel.

## Configure Microsoft Entra diagnostic settings

To configure Microsoft Entra diagnostic settings so Global Secure Access can stream data to your Log Analytics workspace:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Entra ID** > **Monitoring & health** > **Diagnostic settings**. The **General** settings appear by default.
1. Select **Add diagnostic setting** to create a new setting.
1. Enter a **Diagnostic setting name**.
1. In the **Logs** section, select the following **Categories**:

   | Diagnostic setting category | Sentinel or Log Analytics table | Microsoft Entra navigation | What the portal shows | Main use cases |
   |---|---|---|---|---|
   | [NetworkAccessTrafficLogs](how-to-view-traffic-logs.md) | `NetworkAccessTraffic` | **Global Secure Access** > **Monitor** > **Traffic logs** | Transaction-level visibility for every HTTP and HTTPS request that flows through Global Secure Access (Internet, Microsoft 365, and Private Access). Shows destination, full URL (when TLS-inspected), user, device, app, policy, action, bytes, threat intelligence, and AI or agent signals. | Traffic investigation and forensics. Policy enforcement validation. Shadow IT and shadow AI discovery. Threat detection (command and control, risky destinations). Data exfiltration analysis. |
   | [NetworkAccessConnectionEvents](how-to-view-traffic-logs.md) | `NetworkAccessConnectionEvents` | **Global Secure Access** > **Monitor** > **Connection logs** | Connection-level lifecycle view (start and end) with identity, device, point of presence (PoP) region, security profile, and policy decisions. One connection can map to many traffic rows. | Troubleshoot access and policy issues. Add device and user context to traffic. Cross-tenant access visibility. Geographic and PoP analysis. |
   | [NetworkAccessGenerativeAIInsights](concept-generative-ai-insights.md) | `NetworkAccessGenerativeAIInsights` | **Global Secure Access** > **Monitor** > **Gen AI insights logs** | Visibility into generative AI and Model Context Protocol (MCP) activity, including prompt content, MCP client and server names, tool invocations, and transaction linkage to traffic logs. | Shadow AI and shadow MCP discovery. AI usage auditing and governance. Prompt-level inspection. AI agent behavior profiling. |
   | [RemoteNetworkHealthLogs](how-to-remote-network-health-logs.md) | `RemoteNetworkHealthLogs` | **Global Secure Access** > **Monitor** > **Remote network health logs** | Health and performance of IPsec tunnels and Border Gateway Protocol (BGP) sessions for branch and remote networks, including status, uptime, throughput, and connect or disconnect events. | Branch and site connectivity monitoring. Tunnel-flapping detection. Service-level agreement (SLA) and availability tracking. Network operations troubleshooting. |
   | [NetworkAccessAlerts](concept-alerts.md) | `NetworkAccessAlerts` | **Global Secure Access** > **Monitor** > **Alerts** | Security and policy alerts that Global Secure Access generates natively, with severity, description, related entities, and timestamps. Examples include the **Increased External Tenant Activity** alert, the **Token or Device Inconsistency** alert, and the **Unhealthy Remote Network** alert. | Real-time threat detection. Alert triage. Incident response. |

1. In the **Destination details** section, select **Send to Log Analytics workspace**.
1. From the **Log Analytics workspace** menu, select your Sentinel workspace. 
1. Select **Save**.   
:::image type="content" source="media/how-to-sentinel-integration/diagnostic-settings.png" alt-text="Screenshot of the Diagnostic setting screen showing the selected log categories and destination details." lightbox="media/how-to-sentinel-integration/diagnostic-settings.png":::

## Install the Global Secure Access solution from the Sentinel content hub
 
The Global Secure Access solution includes three workbooks and seven analytics rules. To install the solution:
 
 1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
 1. Browse to **Microsoft Sentinel** > **Content management** > **Content hub**.
 1. In the **Search** field, enter **Global Secure Access** to filter the catalog.
    :::image type="content" source="media/how-to-sentinel-integration/solution-search-result.png" alt-text="Screenshot of the Global Secure Access solution as a search result." lightbox="media/how-to-sentinel-integration/solution-search-result.png":::
 1. Select the **Global Secure Access** solution. Its description opens.
 1. Select **Install** to add the solution to your workspace.
    :::image type="content" source="media/how-to-sentinel-integration/install-solution.png" alt-text="Screenshot of the solution description with the Install button highlighted." lightbox="media/how-to-sentinel-integration/install-solution-expanded.png":::
 
After the solution installs, you can enable its workbooks and analytics rules. The **Network Traffic Insights** and **MCP Servers Dashboard** workbooks need only the Global Secure Access diagnostic settings you already configured. The **Enriched Microsoft 365 logs** workbook also requires Microsoft 365 audit data, which you enable through a separate Sentinel data connector. See the next section.
 
 ### Enable enriched Microsoft 365 logs (optional)
 
 The **Enriched Microsoft 365 logs** workbook correlates Microsoft 365 audit events in the `OfficeActivity` table with Global Secure Access traffic in the `NetworkAccessTraffic` table. This correlation enriches Microsoft 365 events with device ID, operating system, and original source IP address. It helps you diagnose blocked access, troubleshoot performance issues, and investigate user activity with full network context.
 
 `OfficeActivity` isn't a Microsoft Entra diagnostic category. The Microsoft Sentinel **Microsoft 365** (Office 365) data connector populates it and streams the Microsoft 365 unified audit log (Exchange, SharePoint, and Teams activity) into your Log Analytics workspace.
 
 To enable enriched Microsoft 365 logs:
 
 1. Confirm that [Microsoft 365 unified audit logging](/purview/audit-log-enable-disable) is turned on for your tenant. Unified audit logging is on by default for most tenants.
 1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
 1. Browse to **Microsoft Sentinel** > **Configuration** > **Data connectors**.
 1. Search for and open the **Microsoft 365** (Office 365) data connector. Select **Open connector page**.
 1. Under **Configuration**, select the workloads you want to stream (**Exchange**, **SharePoint**, and **Teams**), and then select **Apply Changes**. For full guidance, see [Connect Office 365 logs to Microsoft Sentinel](/azure/sentinel/connect-office-365).
 1. Confirm that the same Microsoft Sentinel workspace receives both `NetworkAccessTraffic` and `OfficeActivity` data. The workbook can only correlate events that land in the same workspace.
 
To verify that `OfficeActivity` is ingesting data, follow [Validate the data flow](#validate-the-data-flow) and confirm that `OfficeActivity` appears in **Advanced hunting** > **Log Management** alongside the Global Secure Access tables.

## Validate the data flow

To validate the data flow from Global Secure Access to Microsoft Sentinel:

1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
1. Browse to **Microsoft Sentinel** > **Configuration** > **Tables**.
1. In the **Tables** view, use filters or search to confirm that the following Sentinel tables are in the workspace: 
    - `NetworkAccessTraffic`
    - `NetworkAccessConnectionEvents`
    - `NetworkAccessGenerativeAIInsights` (preview)
    - `RemoteNetworkHealthLogs`
    - `NetworkAccessAlerts`
    - `OfficeActivity` (if you enabled enriched Microsoft 365 logs)
   
:::image type="content" source="media/how-to-sentinel-integration/workspace-tables.png" alt-text="Screenshot of the workspace tables showing the Sentinel tables." lightbox="media/how-to-sentinel-integration/workspace-tables.png":::

> [!NOTE]
> Microsoft Sentinel creates tables when it ingests data into the Log Analytics workspace. If there's no data ingestion, the table doesn't exist in the workspace.

### Enable analytics rules

You can enable or customize analytics rules from the Global Secure Access solution. For more information, see [Create and manage analytics rules in Microsoft Sentinel](/azure/sentinel/tutorial-detect-threats). 

:::image type="content" source="media/how-to-sentinel-integration/analytics-rules.png" alt-text="Screenshot of Global Secure Access-related analytics rules." lightbox="media/how-to-sentinel-integration/analytics-rules.png":::

The Global Secure Access solution includes the following analytics rules:

| Rule name | Severity | Description | MITRE ATT&CK |
|---|---|---|---|
| TI Domain Entity Match | Medium | Correlates Global Secure Access `DestinationFqdn` against threat intelligence domain-name indicators of compromise (IOCs) from the `ThreatIntelIndicators` table. | Command and Control (T1071) |
| TI IP Entity Match | Medium | Correlates Global Secure Access `DestinationIp` against threat intelligence IP address IOCs from the `ThreatIntelIndicators` table. | Command and Control (T1071) |
| TI URL Entity Match | Medium | Correlates Global Secure Access `DestinationUrl` against threat intelligence URL IOCs from the `ThreatIntelIndicators` table. | Command and Control (T1071) |
| Abnormal Deny Rate for Source-to-Destination IP | Medium | Detects statistical anomalies in deny rates between source and destination IPs. Learns a baseline over five days and flags deviations. | Initial Access, Exfiltration, Command and Control (T1571) |
| Protocol Changes for Destination Ports | Medium | Detects protocol mismatches on destination ports compared to the learned baseline. Indicates potential protocol abuse or tunneling. | Defense Evasion, Exfiltration, Command and Control (T1571) |
| Source IP Scanning Multiple Open Ports | Medium | Identifies a source IP that scans 100 or more distinct ports in 30 seconds. Detects reconnaissance and port scanning through Global Secure Access. | Discovery (T1046) |
| Connections Outside Operational Hours | High | Flags connections that occur before 8 AM or after 6 PM. Indicates potential unauthorized access or compromised credentials. | Initial Access (T1078, T1133) |

### View the preconfigured workbooks

The Global Secure Access solution includes the following preconfigured workbooks. Each workbook provides a different view of Global Secure Access activity to support security operations.

#### Network Traffic Insights

An interactive dashboard that provides an end-to-end view of Global Secure Access traffic across Internet, Microsoft 365, and Private Access. Use this workbook as the operational pane for Global Secure Access traffic to identify anomalies, traffic spikes, policy drift, and misuse.

- **Primary data source**: `NetworkAccessTrafficLogs` diagnostic setting category, which streams to the `NetworkAccessTraffic` Sentinel table.
- **Use this workbook to**:
  - Get an overview of traffic and analyze volume.
  - Identify top destinations and bandwidth consumers.
  - Detect blocked traffic and validate policy impact.
  - Monitor traffic trends and access patterns.
- **Requirements**: Global Secure Access diagnostic settings enabled, with `NetworkAccessTrafficLogs` streamed to Microsoft Sentinel.

####  Enriched Microsoft 365 logs Workbook

Correlates Microsoft 365 audit events with Global Secure Access network traffic to add user, device, and network context to Microsoft 365 activity. Use this workbook to combine network telemetry with audit evidence for stronger investigations.

- **Primary data sources**: `NetworkAccessTrafficLogs` and Microsoft 365 audit logs, which stream to the `NetworkAccessTraffic` and `OfficeActivity` Sentinel tables.
- **Correlation key**: `UniqueTokenId`.
- **Use this workbook to**:
  - Investigate Microsoft 365 access with the original source IP address.
  - Identify who accessed which resource, and from which device.
  - Combine audit logs with network evidence for forensics.
  - Strengthen incident investigations and threat hunting with full context.
- **Requirements**: Both `NetworkAccessTrafficLogs` and Microsoft 365 `OfficeActivity` logs streamed to the same Microsoft Sentinel workspace. To enable Microsoft 365 logs, see [Enable enriched Microsoft 365 logs (optional)](#enable-enriched-microsoft-365-logs-optional).

#### MCP Servers Dashboard (preview)

Visualizes Model Context Protocol (MCP) traffic that AI agents and users generate across the organization. Use this workbook to improve visibility into AI-driven traffic and identify unmanaged or noncompliant MCP services.

- **Primary data source**: `NetworkAccessGenerativeAIInsights` diagnostic setting category, which streams to the `NetworkAccessGenerativeAIInsights` Sentinel table.
- **Use this workbook to**:
  - Monitor MCP client and server traffic.
  - Identify AI agent usage patterns.
  - Detect shadow MCP servers.
  - Analyze generative AI application activity.
- **Requirements**: Generative AI and MCP logging enabled in Global Secure Access, with `NetworkAccessGenerativeAIInsights` streamed to Microsoft Sentinel.

To view a workbook dashboard:
1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
1. Browse to **Microsoft Sentinel** > **Content management** > **Content hub**.
1. In the **Content hub**, expand the **Global Secure Access** solution.
1. Select one of the preconfigured workbooks.
1. Select **View Template**. The workbook dashboard opens.

:::image type="content" source="media/how-to-sentinel-integration/workbook-dashboard.png" alt-text="Screenshot of the Network Traffic Insights dashboard showing a graph of usage over time." lightbox="media/how-to-sentinel-integration/workbook-dashboard-expanded.png":::

## Related content

- [What is Microsoft Sentinel?](/azure/sentinel/overview)
- [Configure Microsoft Entra diagnostic settings for activity logs](../identity/monitoring-health/howto-configure-diagnostic-settings.md)
- [Microsoft Sentinel in the Microsoft Defender portal](/azure/sentinel/microsoft-sentinel-defender-portal)
- [Create and manage analytics rules in Microsoft Sentinel](/azure/sentinel/tutorial-detect-threats)

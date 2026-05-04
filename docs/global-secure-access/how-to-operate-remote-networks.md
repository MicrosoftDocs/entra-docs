---
title: Operate Microsoft Entra Global Secure Access remote networks
description: "Post-deployment operations guide for Global Secure Access remote networks (GRE/IPsec branch site connectivity), covering tunnel monitoring, alerting, capacity management, and automation."
ms.topic: how-to
ms.date: 05/04/2026
ms.reviewer: luflores
ai-usage: ai-assisted
---

# Operate Microsoft Entra Global Secure Access remote networks

This guide covers day-to-day operations for Global Secure Access remote networks after deployment. Remote networks provide branch site connectivity to Global Secure Access via Generic Routing Encapsulation (GRE) or IPsec tunnels, enabling site-level traffic forwarding without requiring a per-device client agent.

For initial deployment and tunnel configuration, see the [Global Secure Access deployment guide](/entra/architecture/gsa-deployment-guide-intro). For shared operational topics (roles, change management, metrics framework), see the [Common operations guide](how-to-operations-common.md). This article uses *GSA* as the abbreviation for Global Secure Access.

Use the role assignments in this guide to identify the primary owner for each task. Role definitions live in the [Common operations guide](how-to-operations-common.md#roles-and-responsibilities). If your operating model uses different role names, map them to the ones used here.

## Alerting and monitoring

Remote Networks operations should start with alerts that identify branch connectivity failures before users report them. Use this section to:

- Define the critical tunnel and site-level alerts.
- Deploy the supporting Kusto Query Language (KQL) queries for ongoing monitoring.
- Establish the daily and weekly checks that help you track tunnel stability, capacity, and failover readiness across each remote site.

### Critical alerts to configure

| Alert | Condition | Role | What to do next |
| --- | --- | --- | --- |
| Tunnel down | A GRE or IPsec tunnel disconnected for more than 5 minutes | Network Security Engineer | 1. Check the on-premises CPE (Customer Premises Equipment) device status. 2. Verify the public IP and tunnel configuration didn't change. 3. Check internet service provider (ISP) connectivity at the branch. 4. If using redundant tunnels, verify traffic failed over. |
| All tunnels for a site down | No active tunnels remain for a remote network location | Network Security Engineer | **Severity: Critical.** All users at the site lose GSA-secured connectivity. 1. Escalate immediately. 2. Check for site-wide network outage. 3. Activate fallback plan (direct internet egress or backup VPN). |
| Tunnel flapping | A tunnel goes up and down more than three times in 1 hour | Network Security Engineer | 1. Check the CPE device logs for IKE/IPsec negotiation errors. 2. Verify the tunnel keepalive and Dead Peer Detection (DPD) settings. 3. Check for ISP instability or MTU issues. 4. If flapping persists, engage your network provider. |
| Tunnel bandwidth near capacity | Sustained throughput exceeds 80% of the tunnel's provisioned bandwidth for 30+ minutes | Platform Ops / Monitoring Engineer | 1. Review top traffic consumers at the site using KQL queries. 2. Determine if the traffic is legitimate growth or an anomaly. 3. Plan to add a second tunnel or upgrade bandwidth. |
| Border Gateway Protocol (BGP) session down (if applicable) | BGP peering session with GSA drops | Network Security Engineer | 1. Check BGP configuration on the CPE device. 2. Verify the peer IP and Autonomous System Number (ASN) settings. 3. Review route advertisements for changes. |
| Tunnel MTU-related packet drops | High rate of fragmented or dropped packets on the tunnel | Network Security Engineer | 1. Reduce the tunnel MTU on the CPE device (recommended: 1,400 bytes for GRE, 1,380 for IPsec). 2. Enable Transmission Control Protocol (TCP) Maximum Segment Size (MSS) clamping if not already configured. |

### KQL queries for remote network monitoring

**Tunnel status—identify disconnected tunnels:**

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(1h)
| where Type == "RemoteNetworkHealthLogs"
| where TimeGenerated < ago(10m)
| project TimeGenerated, RemoteNetworkId, SourceIp, DestinationIp, Status
| order by TimeGenerated desc
```

**Tunnel bandwidth utilization—hourly trend:**

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(24h)
| where Type == "RemoteNetworkHealthLogs"
| summarize
    TotalMB = sum(SentBytes + ReceivedBytes) / 1048576.0,
    SessionCount = count()
    by bin(TimeGenerated, 1h), RemoteNetworkId
| order by TimeGenerated asc
```

**Top traffic consumers at a branch site:**

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(24h)
| where Type == "RemoteNetworkHealthLogs"
| where RemoteNetworkId == "<your-remote-network-id>"
| summarize TotalMB = sum(SentBytes + ReceivedBytes) / 1048576.0 by DestinationIp
| order by TotalMB desc
| take 20
```

**30-day traffic baseline per site:**

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(30d)
| where Type == "RemoteNetworkHealthLogs"
| summarize
    DailyMB = sum(SentBytes + ReceivedBytes) / 1048576.0,
    SessionCount = count(),
    UniqueUsers = dcount(SourceIp)
    by bin(TimeGenerated, 1d), RemoteNetworkId
| order by TimeGenerated asc
```

> [!IMPORTANT]
> Establish per-site traffic baselines during the first 30 days. Branch sites vary significantly in traffic volume based on user count and workload. Per-site baselines are essential for meaningful capacity alerts.

## Maintenance and health checks

### Daily checks

| Check | Role | Procedure | What to do if it fails |
| --- | --- | --- | --- |
| Tunnel status | Platform Ops / Monitoring Engineer | Entra admin center > **Global Secure Access** > **Connect** > **Remote networks**. Verify all tunnels show **Connected**. | Check CPE device status and ISP connectivity at the affected site. |
| High-severity alerts | SOC Analyst | Review Sentinel or your security information and event management (SIEM) platform for P1/P2 remote network alerts. | Ensure each alert is assigned. Escalate unassigned alerts older than 4 hours. |
| Site traffic volume | Platform Ops / Monitoring Engineer | Spot-check traffic volumes for your largest sites against the baseline. | Investigate significant drops (possible outage) or spikes (possible anomaly). |

### Weekly checks

| Check | Role | Procedure | What to do if it fails |
| --- | --- | --- | --- |
| Tunnel stability | Network Security Engineer | Review tunnel flap history in logs. Count up/down transitions per tunnel. | Investigate tunnels with more than two transitions in the week. Check CPE logs and ISP stability. |
| Bandwidth utilization trend | Platform Ops / Monitoring Engineer | Run the bandwidth KQL query for the past seven days. | If any site exceeds 70% sustained utilization, plan capacity expansion. |
| CPE device health | Network Security Engineer | Check CPU, memory, and interface errors on branch CPE devices via your network management tool. | Address devices nearing resource limits. Plan firmware updates if available. |
| Configuration backup | Platform Ops / Monitoring Engineer | Verify that CPE device configurations are backed up (via network management tool). Also run the [GSA configuration export](#automation-playbooks). | Troubleshoot backup failures. |

### Monthly checks

| Check | Role | Procedure | What to do if it fails |
| --- | --- | --- | --- |
| Tunnel redundancy validation | Network Security Engineer | For sites with redundant tunnels, verify failover works. See [Tunnel failover testing](#tunnel-failover-testing). | Investigate and resolve failover issues before the next maintenance window. |
| CPE firmware review | Network Security Engineer | Check current firmware versions against vendor-recommended versions. | Schedule firmware upgrades during maintenance windows. |
| Capacity planning review | Platform Ops / Monitoring Engineer | Compare 30-day traffic trend against provisioned bandwidth for each site. | Initiate bandwidth upgrades or add tunnels for sites approaching limits. |
| Remote network inventory | Network Security Engineer | Compare the list of active remote networks in the Entra admin center against your site inventory. | Remove entries for decommissioned sites. Add entries for new sites. |
| IKE/IPsec security association review | Network Security Engineer | Verify that Security Association (SA) lifetimes and ciphers align with your security policy. | Update tunnel parameters to meet current security standards. |

### Tunnel failover testing

> [!WARNING]
> Only perform tunnel failover testing during a scheduled maintenance window. Confirm that the site has redundant tunnels configured and that fallback routing is in place before disabling a tunnel.

1. Identify the site and verify it has at least two tunnels configured (primary and secondary).
2. Notify affected users and the site IT contact of the maintenance window.
3. On the CPE device, administratively disable the primary tunnel interface.
4. Wait 2–5 minutes. Verify that traffic shifted to the secondary tunnel.
5. Test user connectivity from the site—users should have uninterrupted access.
6. Check `NetworkAccessTraffic` to confirm traffic is flowing through the secondary tunnel.
7. Re-enable the primary tunnel interface. Verify it re-establishes and traffic rebalances.
8. Document results: failover time, user impact (if any), and issues observed.

### Capacity thresholds

| Metric | Target | Warning threshold | Critical threshold |
| --- | --- | --- | --- |
| Tunnel bandwidth utilization | < 60% of provisioned | > 70% sustained 30 min | > 85% sustained 15 min |
| Tunnel uptime per site | > 99.9% | < 99.5% in any week | < 99.0% in any week |
| Tunnel flap count | 0 per week | > 2 per week | > 5 per week |
| Active tunnels per site | 2+ (minimum for redundancy) | Only one active tunnel | No active tunnels |
| CPE device CPU | < 50% average | > 70% sustained | > 85% sustained |

## Integration and automation

### Export remote network configuration via Graph API

```powershell
# Prerequisites — install and import the Graph Beta Network Access module
Install-Module Microsoft.Graph.Beta.NetworkAccess -Scope CurrentUser -Force
Import-Module Microsoft.Graph.Beta.NetworkAccess

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "NetworkAccess.ReadWrite.All" -UseDeviceCode

# Export remote network configurations
$response = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/networkAccess/connectivity/remoteNetworks"
$remoteNetworks = $response.value
$remoteNetworks | ConvertTo-Json -Depth 5 | Out-File "RemoteNetworks_$(Get-Date -Format 'yyyyMMdd').json"

# Export device links (tunnel configurations) for each remote network
foreach ($rn in $remoteNetworks) {
    $deviceLinks = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/networkAccess/connectivity/remoteNetworks/$($rn.id)/deviceLinks"
    $exportObj = @{
        RemoteNetworkName = $rn.name
        RemoteNetworkId = $rn.id
        DeviceLinks = $deviceLinks.value
    }
    $exportObj | ConvertTo-Json -Depth 5 | Out-File "RemoteNetwork_$($rn.name)_Links_$(Get-Date -Format 'yyyyMMdd').json"
}

Write-Host "Remote network configuration export complete."
```

### Automation playbooks

| # | Scenario | Implementation | Trigger |
| --- | --- | --- | --- |
| 1 | **Tunnel down notification** | Logic Apps playbook: sends Teams alert and email with site name, tunnel ID, and last-seen time | Sentinel alert: tunnel offline > 5 min |
| 2 | **Auto-create ITSM ticket for site outage** | Logic Apps playbook: creates a ServiceNow incident for all-tunnels-down at a site | Sentinel alert: all tunnels for a site offline |
| 3 | **Weekly configuration backup** | Azure Automation runbook: exports remote network and device link config via Graph API | Scheduled: weekly |
| 4 | **Capacity alert escalation** | Logic Apps playbook: notifies the network planning team when a tunnel exceeds 80% bandwidth for 24 hours | Sentinel alert: bandwidth threshold exceeded |
| 5 | **Monthly site inventory reconciliation** | PowerShell script: compares active remote networks in GSA against a master site list, outputs discrepancies | Scheduled: monthly |
| 6 | **Tunnel flap report** | Azure Automation runbook: queries tunnel status transitions over the past seven days, generates a summary report | Scheduled: weekly |

### Network management tool integration

If your organization uses a network management platform like SolarWinds, Paessler Router Traffic Grapher (PRTG), or ThousandEyes:

1. **Tunnel health monitoring**: Configure your network tool to monitor the GRE/IPsec tunnel endpoints as monitored interfaces. This integration gives you a second monitoring layer alongside Sentinel.
2. **CPE device health**: Monitor branch CPE devices for CPU, memory, and interface errors. Set thresholds that trigger alerts into your standard network operations workflow.
3. **End-to-end path monitoring**: To verify end-to-end connectivity and measure latency, use synthetic transactions or ping monitors from branch sites through the GSA tunnels.

## Operational metrics

| Metric | How to measure | Target | Review cadence |
| --- | --- | --- | --- |
| Tunnel availability per site | % time at least one tunnel is active per site | > 99.9% | Weekly |
| Mean time to detect tunnel failure | Time from tunnel disconnect to alert firing | < 5 minutes | Monthly |
| Mean time to restore tunnel | Time from alert to tunnel reestablished | < 30 minutes | Monthly |
| Tunnel flap rate | Tunnel transitions per week across all sites | < 2 per site per week | Weekly |
| Bandwidth utilization per site | Peak and average utilization vs. provisioned | < 70% average | Weekly |
| Configuration backup success | Successful backups / scheduled backups | 100% | Weekly |
| Failover test success rate | Successful failover tests / tests conducted | 100% | Quarterly |

## Troubleshooting quick reference

| Symptom | Likely cause | Resolution |
| --- | --- | --- |
| Tunnel doesn't establish | Internet Key Exchange (IKE) or IPsec parameter mismatch, wrong pre-shared key (PSK), or blocked port (User Datagram Protocol [UDP] 500/4500) | 1. Verify IKE version, ciphers, and PSK match the GSA configuration. 2. Check firewall rules at the branch for UDP 500/4500. 3. Review CPE device logs for IKE negotiation errors. |
| Tunnel established but no traffic flows | Routing issue—traffic not being directed into the tunnel, or source NAT misconfiguration | 1. Verify route table on the CPE sends target traffic into the tunnel. 2. Check source NAT/PAT settings if necessary. 3. Test with a packet capture on the CPE. |
| Intermittent connectivity at a site | Tunnel flapping, ISP instability, or MTU issues | 1. Check tunnel flap count. 2. Review ISP performance. 3. Adjust MTU settings (1400 for GRE, 1380 for IPsec). Enable TCP MSS clamping. |
| Slow performance at a branch site | Tunnel bandwidth saturation or suboptimal routing | 1. Check bandwidth utilization. 2. Review top consumers. 3. Add a second tunnel or upgrade bandwidth if at capacity. |
| One site can't reach resources other sites can | Site-specific tunnel configuration issue or local network problem | 1. Verify the tunnel is up. 2. Check routing on the CPE. 3. Compare the site's traffic forwarding profile assignment against working sites. |

## Related content

- [Common operations guide](how-to-operations-common.md)—Roles, change management, metrics framework
- [Private Access operations](how-to-operate-private-access.md)
- [Internet Access operations](how-to-operate-internet-access.md)
- [Microsoft Traffic operations](how-to-operate-microsoft-traffic.md)
- [Daily health check template](reference-daily-health-check.md)
- [Global Secure Access documentation](/entra/global-secure-access/)
- [GSA Deployment Guide](/entra/architecture/gsa-deployment-guide-intro)

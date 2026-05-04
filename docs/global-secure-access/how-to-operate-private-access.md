---
title: Operate Microsoft Entra Private Access
description: "Post-deployment operations guide for Microsoft Entra Private Access (ZTNA), covering alerting, health checks, integration, automation, and operational metrics."
ms.topic: how-to
ms.date: 05/04/2026
ms.reviewer: plenzke
ai-usage: ai-assisted
---

# Operate Microsoft Entra Private Access

## Overview

This guide covers day-to-day operations for Microsoft Entra Private Access after deployment. It provides prescriptive procedures for alerting, health checks, integration, and automation specific to Private Access connectors, application segments, and connector groups.

For initial deployment and configuration, see the [Global Secure Access deployment guide](/entra/architecture/gsa-deployment-guide-intro). For shared operational topics (roles, change management, metrics framework), see the [Common operations guide](how-to-operations-common.md).

### How to use this guide

Every section helps you answer three questions:

- **What needs to be checked?** — See [Automated posture assessment](#automated-posture-assessment), [Alerting and monitoring](#alerting-and-monitoring), and [Maintenance and health checks](#maintenance-and-health-checks).
- **Who performs the check?** — The **Role** column on every table names the owner. Role definitions live in the [Common operations guide](how-to-operations-common.md#roles-and-responsibilities). If your operating model uses different role names, map them to the ones here.
- **How is failure reported automatically?** — The **Automated by** column points to the Sentinel analytics rule, Azure Monitor alert, Zero Trust Assessment check, or [playbook](#automation-playbooks) that reports the failure. Any row marked *Manual* is a candidate to automate.

> [!IMPORTANT]
> Operating Private Access is not a dashboard-watching exercise. Before you add a recurring task to an operator's calendar, check whether it is already covered by the [Zero Trust Assessment](#automated-posture-assessment), a built-in Sentinel analytics rule, or a scheduled [playbook](#automation-playbooks).

### Application models

Private Access supports two application models. Your operational procedures must cover both:

| Model | When to use | Operational implication |
| --- | --- | --- |
| **Quick Access** | Single enterprise application containing multiple application segments (FQDNs, IPs, IP ranges) used to enable VPN replacement. Shared Conditional Access policy across all segments. | Simpler to manage, but a policy change affects all associated application segments. Monitor as a single unit. |
| **Per-app enterprise applications** | Individual enterprise applications that include smaller groups of application segments facilitating customer move to ZTNA. | Granular policy control is configurable per enterprise application (for example, different MFA or device compliance requirements). Each app must be monitored and maintained independently. |

Both models often coexist in the same environment. When performing application segment inventories, configuration exports, or policy reviews, ensure you cover both Quick Access segments and enterprise app segments.
In order to leverage full ZTNA application segmentation, it is recommended to migrate from Quick Access to Per-app enterprise applications. The Zero Trust Assessment will help you tracking these efforts.

## Automated posture assessment

The [Zero Trust Assessment](/security/zero-trust/assessment/overview) continuously evaluates your tenant against the [Protect networks](/entra/fundamentals/configure-security#protect-networks) pillar, which includes a dedicated set of Private Access checks. **Running the Zero Trust Assessment replaces most of the manual configuration-review work that used to fall on Private Access operators.** Use it as your primary *"is my configuration correct?"* control — you do not need to build these checks yourself.

For the full list of checks and the latest additions, see [Configure Microsoft Entra for increased security — Protect networks](/entra/fundamentals/configure-security#protect-networks). The **Automated by** column in the tables throughout this guide calls out which specific Zero Trust Assessment check covers each operational task.

### Schedule the assessment and deliver results

By default the Zero Trust Assessment runs interactively. For operations, schedule it and deliver the results to the team — see [Playbook 7: Scheduled Zero Trust Assessment digest](#playbook-7-scheduled-zero-trust-assessment-digest).

> [!IMPORTANT]
> The Zero Trust Assessment is a configuration-posture check, not a real-time detector. Pair it with the real-time alerts in [Alerting and monitoring](#alerting-and-monitoring) — posture tells you *"is it configured right?"*, alerts tell you *"is it working right now?"*.

## Alerting and monitoring

Lead your operational practice with alerts — don't rely on manually watching dashboards to discover issues. Configure alerts first, then use dashboards for trend analysis and management reporting.

### Critical alerts to configure

Configure the following alerts and document the response action for each. Use [Microsoft Sentinel](/azure/sentinel/) with the [Global Secure Access Sentinel integration](/entra/global-secure-access/how-to-sentinel-integration), or Azure Monitor alert rules.

| Alert | Condition | Role | Automated by | What to do next |
| --- | --- | --- | --- | --- |
| Connector offline | A Private Access connector stops sending heartbeats for more than 5 minutes | Network Ops L1 | Sentinel analytics rule *Connector health degradation* (content hub) | 1. Check the connector server: verify the `Microsoft Entra private network connector` Windows service is running. 2. Check outbound connectivity to `*.msappproxy.net` on port 443. 3. Review Windows Event Logs on the connector host. 4. If the connector can't be recovered, verify traffic has failed over to another connector in the group (see [Failover validation](#failover-validation)). See [Microsoft Entra private network connectors](https://learn.microsoft.com/entra/global-secure-access/concept-connectors#maintenance) and [Troubleshoot problems installing the private network connector](https://learn.microsoft.com/entra/global-secure-access/troubleshoot-connectors#troubleshooting-connector-functionality). |
| All connectors in a group offline | No connectors in a connector group are sending heartbeats | Network Ops L2 + Incident Commander | Sentinel analytics rule *Connector group offline* + [Playbook 2](#playbook-2-auto-create-itsm-ticket-for-connector-group-failure) | **Severity: Critical.** All users of applications assigned to this group lose access. 1. Escalate immediately per your incident management process. 2. Check for common root cause: network outage, firewall change, or server patching affecting all connector hosts. 3. If recovery isn't immediate, activate your fallback connectivity plan (for example, temporary VPN access). |
| Connector high resource usage | CPU > 80% or memory > 85% sustained for 15+ minutes on a connector host | Network Ops L1 | Azure Monitor alert ([Playbook 5](#playbook-5-connector-group-capacity-alert)) | 1. Check the number of active sessions on the connector. 2. Redistribute load by adding another connector to the group. 3. Investigate if a specific application is generating unusual traffic volume. |
| Application segment unreachable | Users receive connection failures for a specific Private Access application | Network Ops L1 → App Owner | Sentinel analytics rule *Private access segment failures* | 1. Verify the backend application server is running and reachable from the connector host. 2. Test DNS resolution from the connector host for the application FQDN. 3. Check the application segment configuration in the Entra admin center for correct IP/FQDN and port ranges. See [Troubleshoot application access](https://learn.microsoft.com/entra/global-secure-access/troubleshoot-app-access#how-does-dns-work-with-global-secure-access) and [Troubleshoot problems installing the private network connector](https://learn.microsoft.com/entra/global-secure-access/troubleshoot-connectors#troubleshooting-connector-functionality). |
| Unusual access denials spike | Access denial count for Private Access applications increases by more than 50% compared to the 7-day baseline | IAM Ops + SOC | Sentinel scheduled analytics rule *Unusual private access denials* (derived from the top-denied-apps KQL) | 1. Review `NetworkAccessTraffic` for the denied sessions — identify the users, apps, and denial reasons. 2. Determine if this is a policy misconfiguration (legitimate users blocked) or a security event (unauthorized access attempts). 3. For policy issues, adjust the Conditional Access or app assignment. For security events, escalate to your SOC. |
| Unauthorized configuration change | A Private Access configuration change is made by an unexpected identity or without a matching change ticket | SOC + IAM Admin | [Playbook 8: Private Access configuration change alert](#playbook-8-private-access-configuration-change-alert) | 1. Identify the actor and change details in Entra audit logs. 2. Verify whether the change was approved through your change management process. 3. If unauthorized, revert the change and investigate the identity compromise. See [How to access the Global Secure Access audit logs](https://learn.microsoft.com/entra/global-secure-access/how-to-access-audit-logs#overview), [Microsoft Entra audit log categories and activities](https://learn.microsoft.com/entra/identity/monitoring-health/reference-audit-activities#global-secure-access), and [Entra Security Operations Guide](https://aka.ms/AzureADSecOps). |

> [!TIP]
> Use [Microsoft Security Copilot](/security-copilot/) to investigate alert context. Security Copilot can correlate Private Access connection failures with identity risk signals and summarize cross-data findings. For example, prompt: *"Summarize the risk context for users with denied Private Access connections and elevated identity risk in the last 24 hours."*

### KQL queries for Private Access monitoring

Use these queries in Microsoft Sentinel or Log Analytics to monitor Private Access operations.

**Connector health — identify offline connectors:**
> [!IMPORTANT]
> Connector status (Active/Inactive) is determined by heartbeats between the connector service and the Entra cloud. This status is visible in the Entra admin center and via Graph API, but is **not** written to a Log Analytics table. To monitor connector host availability via KQL, deploy [Azure Monitor Agent](/azure/azure-monitor/agents/agents-overview) on each connector host and configure a data collection rule that sends `Heartbeat` data to your Log Analytics workspace.

```kusto
let connectorHosts = dynamic(["connector-host-01", "connector-host-02", "connector-host-03"]); // replace with your hostnames
Heartbeat
| where TimeGenerated > ago(30m)
| where Computer in~ (connectorHosts)
| summarize LastHeartbeat = max(TimeGenerated) by Computer, ComputerIP
| extend MinutesSilent = datetime_diff('minute', now(), LastHeartbeat)
| where MinutesSilent > 10
| project Computer, ComputerIP, LastHeartbeat, MinutesSilent
| order by MinutesSilent desc
```

**Application access failures — top denied applications:**

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(24h)
| where TrafficType == "private"
| where Action == "Denied"
| extend Destination = coalesce(DestinationFqdn, DestinationIp)
| summarize DenialCount = count() by Destination, UserId, PolicyName
| order by DenialCount desc
| take 20
```

**Traffic volume baseline — establish a 30-day baseline in your first month:**

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(30d)
| where TrafficType == "private"
| summarize
    SessionCount = count(),
    TotalBytesSent = sum(SentBytes),
    TotalBytesReceived = sum(ReceivedBytes)
    by bin(TimeGenerated, 1d)
| extend BytesSent = format_bytes(TotalBytesSent), BytesReceived = format_bytes(TotalBytesReceived)
| project TimeGenerated, SessionCount, BytesSent, BytesReceived
| order by TimeGenerated asc
```

> [!IMPORTANT]
> Establish your traffic baseline during the first 30 days of operations. Record typical daily session counts, peak hours, and byte volumes. Use this baseline to set meaningful alert thresholds for anomaly detection.

**Audit log — detect configuration changes:**

```kusto
AuditLogs
| where TimeGenerated > ago(24h)
| where TargetResources has "PrivateAccess" or TargetResources has "connector" or TargetResources has "applicationSegment"
| project TimeGenerated, OperationName, InitiatedBy.user.userPrincipalName, TargetResources
| order by TimeGenerated desc
```

**Cross-data correlation — Private Access failures with identity risk signals:**

This query identifies users whose Private Access connections were denied *and* who have elevated identity risk — helping you distinguish between policy misconfigurations and genuine security events.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(24h)
| where TrafficType == "private"
| where Action == "Denied"
| join kind=inner (
    SigninLogs
    | where TimeGenerated > ago(24h)
    | where RiskLevelDuringSignIn in ("medium", "high")
    | project RiskUserId = UserId, RiskLevelDuringSignIn, RiskDetail, RiskIPAddress = IPAddress
) on $left.UserId == $right.RiskUserId
| extend Destination = coalesce(DestinationFqdn, DestinationIp)
| project TimeGenerated, UserId, Destination, Action, RiskLevelDuringSignIn, RiskDetail, SourceIp, RiskIPAddress
| order by RiskLevelDuringSignIn desc, TimeGenerated desc
```

**Connector group load distribution — identify hot connectors:**

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(7d)
| where TrafficType == "private"
| summarize
    SessionCount = count(),
    TotalBytes = sum(SentBytes + ReceivedBytes),
    DistinctUsers = dcount(UserId)
    by ConnectorId, ConnectorName, bin(TimeGenerated, 1h)
| summarize
    AvgHourlySessions = avg(SessionCount),
    MaxHourlySessions = max(SessionCount),
    AvgHourlyBytes = avg(TotalBytes),
    PeakUsers = max(DistinctUsers)
    by ConnectorId, ConnectorName
| extend AvgHourlyTraffic = format_bytes(tolong(AvgHourlyBytes))
| project ConnectorId, ConnectorName, AvgHourlySessions, MaxHourlySessions, AvgHourlyTraffic, PeakUsers
| order by MaxHourlySessions desc
```

> [!NOTE]
> After setting up Sentinel integration (see [Sentinel integration](#sentinel-integration--step-by-step)), open **Workbooks** > **My workbooks** > **Global Secure Access** and pin the Private Access views to a shared dashboard. Use workbooks for weekly trend reviews and management reporting — not as your primary alerting mechanism.

## Maintenance and health checks

If required by your organization, you can use the [Private Access health check template](reference-private-access-health-check.md) to record results for each check. Also see the [Daily health check template](reference-daily-health-check.md) to record results of cross-capability daily checks if needed.

### Daily checks

| Check | Role | Automated by | Procedure | What to do if it fails |
| --- | --- | --- | --- | --- |
| Connector heartbeat status | Network Ops L1 | Sentinel analytics rule *Connector health degradation* + ZT Assessment *Private network connectors are active and healthy* | Alerts fire automatically. Spot-check: Entra admin center > **Global Secure Access** > **Connect** > **Connectors**. | Restart the `Microsoft Entra private network connector` service on the affected host. If still offline, check network connectivity and review Windows Event Logs. |
| High-severity incident triage | SOC | Sentinel incidents (auto-assigned via automation rule) | Review P1/P2 Private Access incidents from the last 24 hours. | Ensure each incident is assigned and under investigation. Unassigned incidents older than 4 hours should be escalated. |
| Configuration-change review | IAM Admin | [Playbook 8: Private Access configuration change alert](#playbook-8-private-access-configuration-change-alert) (near real-time) | Rule fires on every Private Access config change. No daily manual query required. | Verify each flagged change maps to an approved change request. Revert and investigate unauthorized changes. |

### Weekly checks

| Check | Role | Automated by | Procedure | What to do if it fails |
| --- | --- | --- | --- | --- |
| Connector resource utilization trend | Network Ops L2 | Azure Monitor alert ([Playbook 5](#playbook-5-connector-group-capacity-alert)) | Review the week's alert history for sustained trends, not isolated spikes. | If any host trends above 70% CPU or 80% memory, plan to add a connector. Use the [Private Access Sizing Planner](https://github.com/FranckhDev/GSA-Private-Access-Sizing-Planner). |
| Policy efficacy digest | IAM Admin | [Playbook 9: Weekly policy-efficacy digest](#playbook-9-weekly-policy-efficacy-digest) (email) | Review the weekly digest of top denied apps/users. | Adjust policies for persistent false positives. Investigate repeated unauthorized access attempts. |
| Configuration backup compliance | Network Ops L2 | [Playbook 3](#playbook-3-weekly-configuration-backup) + [`Test-GsaBackupCompliance.ps1`](scripts/powershell-test-gsa-backup-compliance.md) | Backup compliance script runs after Playbook 3 and alerts if files are missing or stale. | Troubleshoot the runbook or script. Manually export via Graph API as a fallback. |
| Alert noise ratio | SOC | [`Test-GsaAlertNoiseRatio.ps1`](scripts/powershell-test-gsa-alert-noise-ratio.md) scheduled weekly | Script reports analytic-rule-to-incident ratio per Private Access rule. | Tune high-noise rules. Close the loop with Sentinel tuning recommendations. |
| Application segment inventory | App Owner (via IAM Admin) | ZT Assessment *Application segments ...* + [Playbook 6](#playbook-6-stale-application-segment-cleanup) | Assessment flags missing assignments; Playbook 6 flags zero-traffic segments. | Add segments for newly onboarded apps. Remove decommissioned segments after app-owner confirmation. |

### Monthly checks

| Check | Role | Automated by | Procedure | What to do if it fails |
| --- | --- | --- | --- | --- |
| Connector software version | Network Ops L2 | ZT Assessment *Private network connectors are running the latest version* | Assessment flags outdated connectors in the weekly digest ([Playbook 7](#playbook-7-scheduled-zero-trust-assessment-digest)). | Schedule connector updates during a maintenance window. Update one connector at a time per group to maintain availability. |
| Failover validation | Network Ops L2 | **Manual — requires maintenance window** (no safe way to automate disruption testing in production) | See [Failover validation](#failover-validation). | Investigate connector group assignment and network routing before the next maintenance window. |
| RBAC review | IAM Admin | ZT Assessment *Application admin rights are constrained* + [`Test-GsaRbacHygiene.ps1`](scripts/powershell-test-gsa-rbac-hygiene.md) | Assessment checks role-scope hygiene; script reports standing assignments, stale admins, and admins without phishing-resistant MFA. | Remove access for accounts that no longer require it. Enforce phishing-resistant MFA for all admins. |
| Capacity assessment | Network Ops L2 + Capacity Planner | [Playbook 10: Monthly capacity trend report](#playbook-10-monthly-capacity-trend-report) (email) | Review the monthly capacity-trend email. | If any connector group is consistently above 70% capacity, plan to add connectors. See [Capacity thresholds](#capacity-thresholds). |
| Performance baseline comparison | Network Ops L2 | Sentinel workbook *GSA traffic trend* against the [30-day baseline query](#kql-queries-for-private-access-monitoring) | Compare the current month to the baseline captured in your first month. | Investigate significant deviations. Update the baseline after approved growth events (for example, new user populations). |
| DR / fallback plan review | Network Ops Lead | Manual — documentation review | Confirm the fallback connectivity plan and contacts are current. | Update the plan and re-test the fallback path. |
| New feature and functionality review | Network Ops L2 + IAM Admin | Manual — documentation review | Review the [What's new in Microsoft Entra](/entra/fundamentals/whats-new) page and the [Global Secure Access documentation](/entra/global-secure-access/) for new Private Access features, preview announcements, deprecations, and breaking changes. Document relevant items and assess impact on your environment. | Create change requests for features that improve your security posture or operational efficiency. Plan adoption of new GA features and evaluate previews for future roadmap. Update runbooks and procedures to reflect any deprecations or behavioral changes. |

### Failover validation

> [!WARNING]
> Only perform failover testing during a scheduled maintenance window. Before testing, confirm that your connector group has at least two healthy connectors and that you have communicated the maintenance to affected users.

1. Identify the connector group to test. Verify at least two connectors are **Active**.
2. Notify affected users and support teams of the maintenance window.
3. On one connector host, stop the `Microsoft Entra private network connector` service.
4. Wait 5 minutes. Verify in the Entra admin center that the connector shows as **Inactive**.
5. Test application access from a user device — access should continue through the remaining connector(s).
6. Check `NetworkAccessTraffic` to confirm traffic is flowing through the remaining connector.
7. **Rollback:** Restart the connector service on the test host. Verify it returns to **Active** status.
8. Document the results: failover time, user impact (if any), and any issues observed.

### Capacity thresholds

| Metric | Target | Warning threshold | Critical threshold |
| --- | --- | --- | --- |
| Connector CPU | < 50% average | > 70% sustained 30 min | > 85% sustained 15 min |
| Connector memory | < 60% average | > 75% sustained 30 min | > 85% sustained 15 min |
| Concurrent sessions per connector | Varies by server spec | > 70% of tested maximum | > 85% of tested maximum |
| Connectors per group | 2+ (minimum for HA) | Only 2 active (no spare) | Only 1 active (no HA) |

<!-- Configure the CPU and memory thresholds in Azure Monitor metric alerts on each connector host VM as described in [Playbook 5: Connector group capacity alert](#playbook-5-connector-group-capacity-alert); use the Sentinel integration in this guide for log collection, incident correlation, and workflow automation, not for the host metric thresholds themselves. -->

> [!TIP]
> Connector sizing depends on the host server specifications and workload. Use the [Private Access Sizing Planner](https://github.com/FranckhDev/GSA-Private-Access-Sizing-Planner) to estimate connector requirements based on your user counts and application patterns. For general connector architecture guidance, see [Understand the Microsoft Entra private network connector](/entra/global-secure-access/concept-connectors). As a starting point, a 4-vCPU / 16 GB RAM server can handle approximately 200–300 concurrent connections, but always validate with your own workload.

## Integration and automation

Integration and automation are the core operational value of a cloud-delivered ZTNA service. Automate routine tasks to reduce human error and free your team for higher-value work.

### Export Private Access configuration via Graph API

Back up your Private Access configuration regularly using Microsoft Graph API. This enables rollback if a change causes issues.

**Prerequisites:** An app registration with `Directory.ReadWrite.All` and `NetworkAccess.ReadWrite.All` permissions, or a user account with Global Secure Access Administrator role.

```powershell
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Directory.ReadWrite.All","NetworkAccess.ReadWrite.All"

# Export connector groups
$connectorGroups = Get-MgBetaOnPremisePublishingProfileConnectorGroup -OnPremisesPublishingProfileId "applicationProxy"
$connectorGroups | ConvertTo-Json -Depth 5 | Out-File "ConnectorGroups_$(Get-Date -Format 'yyyyMMdd').json"

# Export application segments
$apps = Get-MgBetaServicePrincipal -Filter "tags/any(t: t eq 'IsAccessibleViaZTNAClient')"
foreach ($app in $apps) {
    $appReg = Get-MgBetaApplication -Filter "appId eq '$($app.AppId)'"
    $uri = "https://graph.microsoft.com/beta/applications/$($appReg.Id)/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments"
    $segments = (Invoke-MgGraphRequest -Method GET -Uri $uri).value
    $exportObj = @{
        AppName = $app.DisplayName
        AppId = $app.AppId
        Segments = $segments
    }
    $exportObj | ConvertTo-Json -Depth 5 | Out-File "AppSegments_$($app.DisplayName)_$(Get-Date -Format 'yyyyMMdd').json"
}

Write-Host "Configuration export complete. Files saved to current directory."
```

> [!IMPORTANT]
> APIs under the `/beta` version in Microsoft Graph are subject to change. Use of these APIs in production applications is not supported. To determine whether an API is available in v1.0, use the **Version** selector.

> [!NOTE]
> Schedule this script to run weekly (for example, via Azure Automation or a scheduled task on a management server). Store exports in a secured location with versioning (for example, an Azure Storage account with soft delete enabled).

### Sentinel integration — step by step

For the full walkthrough, see [Configure Microsoft Sentinel for Global Secure Access](/entra/global-secure-access/how-to-sentinel-integration).

1. **Enable diagnostic settings** for Global Secure Access: In the Entra admin center, go to **Global Secure Access** > **Settings** > **Diagnostic settings**. Add a setting that sends `NetworkAccessTrafficLogs` and `AuditLogs` to your Log Analytics workspace.
2. **Install the content pack**: In Microsoft Sentinel, go to **Content hub**, search for **Global Secure Access**, and install the solution. This adds analytics rules, workbooks, and hunting queries.
3. **Enable analytics rules**: Go to **Analytics** > **Rule templates**. Enable the Private Access-related rules (for example, "Connector health degradation," "Unusual private access patterns").
4. **Configure automation rules**: For each enabled analytics rule, create an automation rule to assign incidents to your operations team and optionally trigger a Logic Apps playbook for notification.

### Automation playbooks

#### Playbook 1: Connector offline notification

| Field | Value |
| --- | --- |
| **Trigger** | Sentinel alert: connector heartbeat missing > 5 minutes |
| **Frequency** | Event-driven (real-time) |
| **Required permissions** | Logic Apps managed identity with `SecurityAlert.Read.All`; Microsoft Teams connector or Exchange `Mail.Send` permission |

**Steps:**

1. In Microsoft Sentinel, go to **Analytics** > **Rule templates** and enable the **Connector health degradation** rule.
2. Open the enabled rule, select **Automated response** > **Add new**.
3. Create an automation rule: condition **Incident created**, action **Run playbook**.
4. In Logic Apps, create a new playbook with trigger **When a Microsoft Sentinel incident is created**.
5. Add a **Post message in a channel** Teams action. Include: connector name, connector group, last-seen timestamp (from incident entities), and a direct link to the Sentinel incident.
6. Add a **Send an email (V2)** action to the on-call distribution list with the same details.
7. Save, enable, and test by disabling a connector in a non-production connector group.

---

#### Playbook 2: Auto-create ITSM ticket for connector group failure

| Field | Value |
| --- | --- |
| **Trigger** | Sentinel alert: all connectors in a connector group are offline |
| **Frequency** | Event-driven (real-time) |
| **Required permissions** | Logic Apps managed identity with `SecurityAlert.Read.All`; ServiceNow Logic Apps connector configured with valid ServiceNow credentials |

**Steps:**

1. In Microsoft Sentinel, verify the **Connector group offline** analytics rule is enabled (see [Sentinel integration](#sentinel-integration--step-by-step)).
2. Under **Automated response** for the rule, create an automation rule that runs a Logic Apps playbook.
3. In Logic Apps, add the **ServiceNow - Create Record** action (or equivalent ITSM connector).
4. Map Sentinel incident fields to the ITSM record: **Category** = `Network`, **Severity** = `1 - Critical`, **Description** = affected connector group name and the list of impacted applications.
5. Add a follow-up action to post the ITSM incident URL to your Teams operations channel.
6. Test in a non-production environment by disabling all connectors in a test group.

---

#### Playbook 3: Weekly configuration backup

| Field | Value |
| --- | --- |
| **Trigger** | Scheduled: every Sunday at 02:00 UTC |
| **Frequency** | Weekly |
| **Required permissions** | Azure Automation account managed identity with `NetworkAccess.ReadWrite.All` (Microsoft Graph) and `Storage Blob Data Contributor` on the target storage account |

**Steps:**

1. In Azure Automation, create a new runbook of type **PowerShell** using the [configuration export script](#export-private-access-configuration-via-graph-api). Replace `Out-File` calls with `Set-AzStorageBlobContent` to upload to Azure Blob Storage.
2. Assign the Automation account managed identity `NetworkAccess.ReadWrite.All` on Microsoft Graph and `Storage Blob Data Contributor` on the backup storage account.
3. Create a schedule: weekly, Sunday 02:00 UTC. Link the schedule to the runbook.
4. Run a test execution and verify JSON files appear in the storage container.
5. Enable soft delete on the storage container to retain 90 days of backup versions.
6. Schedule [`Test-GsaBackupCompliance.ps1`](scripts/powershell-test-gsa-backup-compliance.md) to run the day after each backup. The script verifies that expected files landed in the container, are non-empty, and are newer than the previous run \u2014 and raises an alert if not. This closes the loop so missing backups surface as an incident, not during the next weekly check.

---

#### Playbook 4: Application segment onboarding

| Field | Value |
| --- | --- |
| **Trigger** | Manual: initiated by an approved change request |
| **Frequency** | As needed |
| **Required permissions** | Service principal or user account with `NetworkAccess.ReadWrite.All` |

**Steps:**

1. Prepare a CSV file with columns: `AppName`, `FQDN`, `IPRange`, `Ports`, `Protocol`, `ConnectorGroup`.
2. For each row, call the Graph API to create or update the application segment:
   ```
   PATCH https://graph.microsoft.com/beta/applications/{appId}/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/{segmentId}
   ```
3. After import, verify each segment appears in the Entra admin center under **Global Secure Access** > **Applications**.
4. Test user access for each newly added segment from a client device before closing the change request.
5. Record the new segments in your CMDB.

---

#### Playbook 5: Connector group capacity alert

| Field | Value |
| --- | --- |
| **Trigger** | CPU > 70% or memory > 80% sustained for 30 minutes on a connector host |
| **Frequency** | Event-driven (continuous evaluation) |
| **Required permissions** | `Monitoring Contributor` on the connector host resource or resource group |

**Steps:**

1. In the Azure portal, go to **Monitor** > **Alerts** > **Create** > **Alert rule**.
2. Select the connector host VM as the scope.
3. For CPU: set condition **Percentage CPU**, operator **Greater than** `70`, aggregation **Average**, evaluation period **30 minutes**.
4. For memory: add a second alert rule using the **Available Memory Bytes** metric. Calculate your threshold in bytes based on host RAM (for example, 20% of 16 GB = 3,200,000,000 bytes).
5. Set the action group to notify the operations team via email and Teams webhook.
6. Set the alert description to include a link to the [Capacity thresholds](#capacity-thresholds) table and instructions to add a connector to the group.

---

#### Playbook 6: Stale application segment cleanup

| Field | Value |
| --- | --- |
| **Trigger** | Scheduled: first Monday of each month |
| **Frequency** | Monthly |
| **Required permissions** | `Log Analytics Reader` on the Log Analytics workspace; `NetworkAccess.ReadWrite.All` to remove segments after review |

**Steps:**

1. Run the following KQL query to identify applications with no Private Access traffic in the past 90 days:

   ```kusto
   NetworkAccessTraffic
   | where TimeGenerated > ago(90d)
   | where TrafficType == "private"
   | extend Destination = coalesce(DestinationFqdn, DestinationIp)
   | summarize LastSeen = max(TimeGenerated) by Destination
   | where LastSeen < ago(90d)
   | project Destination, LastSeen
   | order by LastSeen asc
   ```

2. Export the results and route to application owners for confirmation that the applications are decommissioned.
3. For confirmed decommissioned applications, remove the segment in the Entra admin center: **Global Secure Access** > **Applications** > select app > **Application segments** > delete.
4. Log each removal as a change record in your ITSM.
5. Re-run the [connector group load distribution query](#kql-queries-for-private-access-monitoring) to confirm traffic patterns are unchanged after removal.

---

#### Playbook 7: Scheduled Zero Trust Assessment digest

| Field | Value |
| --- | --- |
| **Trigger** | Scheduled: every Monday at 06:00 UTC |
| **Frequency** | Weekly |
| **Required permissions** | Azure Automation managed identity with `Policy.Read.All`, `Directory.Read.All`, `NetworkAccess.Read.All`, `SecurityEvents.Read.All` on Microsoft Graph; Logic Apps connector for email and ITSM |

**Steps:**

1. In Azure Automation, create a PowerShell runbook that installs and invokes the [Zero Trust Assessment](/security/zero-trust/assessment/overview) module on a schedule.
2. Filter the output to the **Protect networks** pillar and the checks tagged with *Microsoft Entra Private Access* licensing (see [Automated posture assessment](#automated-posture-assessment) for the full list).
3. Post an HTML summary email to the Network Ops and IAM Admin distribution lists: pass/fail totals, diffs since last run, and links to each failing check's remediation guidance.
4. For each *Fail* finding, open an ITSM ticket via the Logic Apps ServiceNow (or equivalent) connector with severity set by the Zero Trust Assessment severity.
5. Store the raw JSON in Azure Blob Storage with versioning enabled for trend analysis.
6. Add a [Grafana](/azure/managed-grafana/) or Sentinel-workbook tile showing "Zero Trust Assessment pass rate (Private Access)" \u2014 this becomes the single posture number for management reporting.

---

#### Playbook 8: Private Access configuration change alert

| Field | Value |
| --- | --- |
| **Trigger** | Any `AuditLogs` entry targeting a Private Access object (connector, connector group, application segment, CA policy bound to a Private Access app) |
| **Frequency** | Near real-time \u2014 Sentinel scheduled analytics rule with 5-minute query frequency and 5-minute lookback |
| **Required permissions** | Microsoft Sentinel Contributor; Logic Apps access to your ITSM/CMDB API |

**Steps:**

1. In Microsoft Sentinel, create a **Scheduled** analytics rule using the [audit log KQL query](#kql-queries-for-private-access-monitoring); change `ago(24h)` to `ago(5m)` and set frequency/period to 5 minutes.
2. Rule settings: severity **Medium**, entities = **Account** (mapped to `InitiatedBy.user.userPrincipalName`), **IP** (`InitiatedBy.user.ipAddress`).
3. Create an automation rule that calls [Playbook 1](#playbook-1-connector-offline-notification) for notification.
4. Add a Logic Apps action that queries your ITSM Change Management API for an open change ticket referencing the affected object. If no ticket exists, escalate severity to **High** and page the on-call IAM Admin.
5. This replaces the previous *daily manual audit-log review* \u2014 operators do not need to run the KQL query manually anymore.

---

#### Playbook 9: Weekly policy-efficacy digest

| Field | Value |
| --- | --- |
| **Trigger** | Scheduled: every Monday at 07:00 UTC |
| **Frequency** | Weekly |
| **Required permissions** | `Log Analytics Reader` on the workspace; Logic Apps email connector |

**Steps:**

1. In Logic Apps, create a recurrence-triggered workflow.
2. Run the [application access failures query](#kql-queries-for-private-access-monitoring) against a 7-day window.
3. Also run the [cross-data correlation query](#kql-queries-for-private-access-monitoring) so IAM Admin sees denials alongside identity-risk context.
4. Format results as an HTML table: application, user count, denial reason, risk context.
5. Email to the IAM Admin distribution list with subject `Private Access policy efficacy — week of yyyy-MM-dd`.
6. Include a one-click link to the Sentinel workbook view for deeper drill-down.

---

#### Playbook 10: Monthly capacity trend report

| Field | Value |
| --- | --- |
| **Trigger** | Scheduled: first business day of each month, 06:00 UTC |
| **Frequency** | Monthly |
| **Required permissions** | `Log Analytics Reader` on the workspace; `Storage Blob Data Reader` on the baseline storage account; Logic Apps email connector |

**Steps:**

1. Run the [connector group load distribution query](#kql-queries-for-private-access-monitoring) against the last 30 days.
2. Load the 30-day baseline captured in your first month (stored in Azure Blob Storage per [performance baseline](#kql-queries-for-private-access-monitoring)).
3. Generate a report showing per-connector-group: current utilization as % of [capacity threshold](#capacity-thresholds), month-over-month growth, and recommended action (for example, *"Add a connector to group X — sustained > 70% for 14 days"*).
4. Email to the Network Ops Lead and Capacity Planner.
5. File an ITSM change request automatically if any group exceeds the Warning threshold for more than 14 consecutive days.

### ITSM integration

If your organization uses ServiceNow, Microsoft System Center Service Manager, or another ITSM tool:

1. **Alert-to-ticket**: Use [Playbook 2](#playbook-2-auto-create-itsm-ticket-for-connector-group-failure) as a starting point. Extend the same pattern with the [ServiceNow connector for Logic Apps](/connectors/service-now/) to cover additional Private Access alerts.
2. **Change tracking**: Log all Private Access configuration changes as change records in your ITSM. Use the [audit log KQL query](#kql-queries-for-private-access-monitoring) to generate a daily change summary.
3. **CMDB entries**: Register each connector server and connector group as configuration items in your CMDB. Associate Private Access applications with their connector groups for impact analysis.

## Operational metrics

Track these metrics specific to Private Access. For the broader metrics framework and reporting cadence, see the [Common operations guide](how-to-operations-common.md#metrics-and-reporting).

| Metric | Role (owner) | How to measure | Target | Review cadence |
| --- | --- | --- | --- | --- |
| Connector availability | Network Ops L2 | % time all connectors in a group are Active | > 99.9% | Weekly |
| Mean time to detect connector failure | SOC | Time between connector going offline and alert firing | < 5 minutes | Monthly |
| Application access success rate | IAM Admin | Successful connections / total connection attempts | > 99.5% | Weekly |
| Configuration backup success rate | Network Ops L2 | Successful automated backups / scheduled backups | 100% | Weekly |
| Change success rate | Change Manager | Changes completed without rollback or incident / total changes | > 95% | Monthly |
| Mean time to restore after connector failure | Network Ops Lead | Time from alert to restored service | < 30 minutes | Quarterly |
| Stale application segments | App Owner (via IAM Admin) | Count of segments with zero traffic in 90 days | Trending toward 0 | Monthly |
| Zero Trust Assessment pass rate (Private Access checks) | Network Ops Lead | Passing checks / total Private Access checks | > 95% | Weekly |

## Related content

- [Common operations guide](how-to-operations-common.md) — Roles, change management, metrics framework
- [Internet Access operations](how-to-operate-internet-access.md)
- [Remote Networks operations](how-to-operate-remote-networks.md)
- [Microsoft Traffic operations](how-to-operate-microsoft-traffic.md)
- [Private Access health check template](reference-private-access-health-check.md)
- [Daily health check template (all capabilities)](reference-daily-health-check.md)
- [Global Secure Access documentation](/entra/global-secure-access/)
- [GSA Deployment Guide](/entra/architecture/gsa-deployment-guide-intro)
- [Entra Security Operations Guide](https://aka.ms/AzureADSecOps)

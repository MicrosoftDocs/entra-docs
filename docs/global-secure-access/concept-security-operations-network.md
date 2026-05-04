---
title: Security operations for Microsoft Entra Global Secure Access
description: "Security operations guide for Global Secure Access covering detection patterns and Sentinel analytics for Private Access, Internet Access, Remote Networks, and Microsoft Traffic."
ms.topic: concept-article
ms.date: 05/04/2026
ms.reviewer: jebley
ai-usage: ai-assisted
---

# Security operations for Microsoft Entra Global Secure Access

This guide provides security monitoring and detection guidance for Microsoft Entra Global Secure Access (GSA). It covers what to monitor, where to look, and the analytics rules that surface network-layer threats across all GSA capabilities.

This guide is a companion to the [Entra Security Operations Guide](https://aka.ms/AzureADSecOps), which covers identity-centric signals. Use both guides together — identity signals and network signals often need to be correlated to determine the scope and impact of a security event.

For day-to-day operational procedures (health checks, change management, capacity planning), see the [GSA operations guides](overview-operations.md).

> [!IMPORTANT]
> This guide focuses on **detection** — what to monitor, how to detect it, and where the signal originates. It is not an incident response (IR) guide. When a detection fires and you need to contain, eradicate, and recover, use the [Microsoft Incident Response Playbooks](https://aka.ms/IRPlaybooks) and your organization's IR runbooks. Each detection in this guide ends with a brief next-step pointer rather than a full IR procedure.

## Who this guide is for

| Role | How to use this guide |
| --- | --- |
| **SOC Analyst** | Primary audience. Use the detection queries, alert rules, and investigation procedures to monitor and respond to GSA-related threats. |
| **Network Security Engineer** | Use as a reference when tuning policies, reviewing alert efficacy, and supporting SOC investigations with infrastructure context. Owns the Remote Networks and Internet Access detections in this guide. |
| **Identity Admin** | Owns the identity-bound detections in this guide — compliant-network bypass, **Token / Device Inconsistency**, **Increased External Tenant Activity**, and the GSA admin-operation rules under [Detect unauthorized configuration changes](#detect-unauthorized-configuration-changes). Investigate in Microsoft Entra ID Protection and Conditional Access; collaborate with SOC on response. |

## How this guide relates to the Entra SecOps Guide

The [Entra Security Operations Guide](https://aka.ms/AzureADSecOps) covers security monitoring for:

- User accounts, privileged identities, and authentication (sign-in anomalies, risky users)
- Application registrations, service principals, and consent grants
- Devices and Conditional Access evaluation

This guide extends that coverage to the **network layer** — specifically, the traffic that flows through GSA.

## Where to look

Global Secure Access exposes five native diagnostic categories. Each maps to a dedicated Log Analytics table and surfaces a different layer of network telemetry. Combine them with the Entra identity tables and CPE (customer premises equipment — the [branch routers that terminate Remote Network tunnels](/entra/global-secure-access/quickstart-remote-network)) syslog where applicable.

| Source | What it contains | When to use it |
| --- | --- | --- |
| `NetworkAccessTraffic` | Transaction-level events for every HTTP request through GSA: user, device, destination, URL, bytes, action, applied policy, threat type, TLS inspection result, cloud app risk score, initiating process | Primary table for traffic, threat, and policy detections across all GSA capabilities |
| `NetworkAccessConnectionEvents` | Connection lifecycle events with device context (OS, join type, name), the security profile / policy / rule that was applied, PoP region, cross-tenant access, and Intelligent Local Access (`IsLocal`) | Add device and policy context to traffic-based detections; investigate B2B and PoP routing anomalies. Join to `NetworkAccessTraffic` on `ConnectionId` |
| `RemoteNetworkHealthLogs` | IPsec tunnel and BGP session state, heartbeats, advertised route counts, throughput per remote network | Primary source for branch tunnel and BGP detections — replaces or supplements CPE-side `CommonSecurityLog` |
| `NetworkAccessAlerts` | GSA-generated alerts: malicious URL, malware, phishing, **Increased External Tenant Activity**, **Token / Device Inconsistency**, **Unhealthy Remote Network** | Primary feed for native GSA threat alerts — pair with the [Sentinel Content hub Global Secure Access solution](/azure/sentinel/sentinel-solutions-deploy) for prebuilt rules |
| `NetworkAccessGenerativeAIInsights` (Preview) | Generative AI prompts, MCP client/server activity, AI tool and sub-activity metadata | Shadow AI detection, MCP governance, prompt monitoring, AI usage compliance |
| `SigninLogs` | Entra ID sign-in events with GSA-aware fields (`IsThroughGlobalSecureAccess`, `NetworkLocationDetails`) | Correlate identity risk with network activity |
| `AuditLogs` | Entra admin operations: GSA filtering and forwarding policies, profiles, remote networks, certificates, onboarding/offboarding | Detect unauthorized configuration changes (see [Detect unauthorized configuration changes](#detect-unauthorized-configuration-changes)) |
| `EnrichedMicrosoft365AuditLogs` | M365 audit events enriched with GSA network metadata | Microsoft Traffic anomalies |
| `CommonSecurityLog` | CEF-formatted logs from branch CPE devices | Supplement `RemoteNetworkHealthLogs` with CPE-side IKE/IPsec events |

The Azure portal and Microsoft Sentinel offer several integration points for these data sources:

- [Microsoft Sentinel](/azure/sentinel/overview) — install the [**Global Secure Access** solution from the Sentinel Content hub](/azure/sentinel/sentinel-solutions-deploy) for prebuilt analytics rules, workbooks, and hunting queries that complement this guide.
- [Azure Monitor](/azure/azure-monitor/overview) — for workbook-based dashboards and alert rules over Log Analytics.
- [Azure Event Hubs](/azure/event-hubs/event-hubs-about) — to stream GSA logs to third-party SIEMs (Splunk, ArcSight, QRadar, Sumo Logic).
- [Microsoft Security Copilot](/security-copilot/) — for cross-table investigation and natural-language triage.

> [!NOTE]
> **Field-name and enum validation.** Column names and enum values referenced in this guide come from the GSA diagnostic settings integration guide and the Microsoft Sentinel content pack — they may differ between tenants and change as the service evolves. Before turning any KQL in this guide into a Sentinel analytics rule, run `<TableName> | take 10` against your tenant and confirm the columns and values used. Common values to spot-check:
>
> - `NetworkAccessTraffic.TrafficType`: `private`, `internet`, `microsoft365`, `remoteNetwork`.
> - `NetworkAccessTraffic.Action`: typically `Allow` or `Block`. Some tenants also emit content-inspection actions; confirm before using the value as a filter.
> - `NetworkAccessAlerts.AlertType`, `Severity`, `AlertDescription`: alert-table column names are not yet documented — verify against `NetworkAccessAlerts | take 10`.
> - `NetworkAccessConnectionEvents` columns (`DeviceJoinType`, `SecurityProfileName`, `PolicyName`, `PopProcessingRegion`, `IsLocal`): verify before enabling the join detection in the Private Access section.
> - `NetworkAccessGenerativeAIInsights` (Preview): the entire schema is subject to change.
> - Cross-table joins on `UserId`: `SigninLogs.UserId` is a GUID. Confirm GSA tables expose the same `UserId` column; if not, fall back to joining on `UserPrincipalName`.
> - JSON columns like `SourceLocationDetails`: if the column is already a `dynamic` object, drop the `parse_json(...)` wrapper.

## Enable GSA diagnostic logs

All detections in this guide require that one or more GSA diagnostic categories are streamed to your Log Analytics workspace. Configure diagnostic settings once, then enable the categories you need for security monitoring.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) with the **Global Secure Access Administrator** role.
2. Go to **Global Secure Access** > **Monitor** > **Diagnostic settings**.
3. Select **+ Add diagnostic setting** and give it a descriptive name (for example, `GSA-to-Sentinel`).
4. Enable the categories you need:

   | Category | Log Analytics table | Recommended for SOC |
   | --- | --- | --- |
   | Transaction Logs | `NetworkAccessTraffic` | Required |
   | Connection Logs | `NetworkAccessConnectionEvents` | Recommended |
   | Network Health Logs | `RemoteNetworkHealthLogs` | Required if you use Remote Networks |
   | Security Alert Logs | `NetworkAccessAlerts` | Required |
   | Generative AI Insights (Preview) | `NetworkAccessGenerativeAIInsights` | Recommended where AI governance applies |

5. Send the data to the **Log Analytics workspace** connected to Microsoft Sentinel. Each category can target multiple destinations simultaneously — add an **Event Hub** destination if you also need to forward to a third-party SIEM, and a **Storage Account** destination for long-term archival.
6. Save. Logs typically begin flowing within 2–5 minutes.

> [!TIP]
> Use multiple diagnostic settings on the same resource when you need to route different categories to different destinations (for example, archive `NetworkAccessTraffic` to Storage but send `NetworkAccessAlerts` to both Sentinel and an Event Hub for SIEM correlation).

### Ingestion cost and retention considerations

Enabling all five GSA diagnostic categories on a mid-size tenant produces multiple GB per day of Log Analytics ingest. Plan capacity and retention before turning everything on.

- **Estimate ingest volume.** `NetworkAccessTraffic` is by far the highest-volume category. Run the [Cross-cutting baseline](#cross-cutting-baseline-all-capabilities) for one week against a sample of your tenant traffic to project monthly volume.
- **Pick the right destination per category.** Send investigation-grade categories (`NetworkAccessAlerts`, `AuditLogs`, `RemoteNetworkHealthLogs`) to Log Analytics. Archive high-volume `NetworkAccessTraffic` to a Storage Account if you don't need real-time KQL on the full firehose, or use Sentinel's [Auxiliary Logs / basic logs](/azure/azure-monitor/logs/basic-logs-configure) tier for cost-aware querying.
- **Set retention by category.** SOC investigation typically needs 90–180 days of `NetworkAccessTraffic`. Audit and certificate operations should be retained for the full compliance window your organization requires (often 1–2 years) — use Log Analytics archive tier or Storage Account export.
- **Monitor cost with Azure Cost Management.** Tag the diagnostic destinations and review monthly; spikes often indicate noisy traffic patterns worth investigating in their own right.

## Define a baseline

Before tuning alert thresholds, establish a **30-day baseline** of normal activity for your environment. The thresholds in every alert table in this guide are starting values — replace them with values derived from your baseline.

Run the cross-cutting baseline below during your first month and record the results in a workbook or spreadsheet. Each capability section also opens with a focused per-capability baseline that grounds the Critical and High alerts in that section.

### Cross-cutting baseline (all capabilities)

This single query captures the headline signals shared by every capability: session volume, block and failure ratios, user reach, bytes, **TLS inspection failure rate**, and **threat intelligence match volume**. A sustained increase in `TlsFailureRatePct` is itself a content-inspection signal — set an alert at 2x the 30-day mean.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(30d)
| extend TlsInspected = iif(isnotempty(TlsAction) and TlsAction != "Bypass", 1, 0)
| extend TlsFailed    = iif(isnotempty(TlsStatus) and TlsStatus != "Success" and TlsInspected == 1, 1, 0)
| extend ThreatHit    = iif(isnotempty(ThreatType) and ThreatType != "NoneFound", 1, 0)
| extend SessionFailed = iif(
        (isnotnull(ResponseCode) and ResponseCode >= 400)
        or (isnotnull(KerberosErrorCode) and KerberosErrorCode != 0),
        1, 0)
| summarize
    SessionCount         = count(),
    BlockedSessions      = countif(Action == "Block"),
    FailedSessions       = sum(SessionFailed),
    DistinctUsers        = dcount(UserPrincipalName),
    TotalBytesSent       = sum(SentBytes),
    TotalBytesReceived   = sum(ReceivedBytes),
    TlsInspectedSessions = sum(TlsInspected),
    TlsFailedSessions    = sum(TlsFailed),
    ThreatIntelMatches   = sum(ThreatHit)
    by bin(TimeGenerated, 1d), TrafficType
| extend TlsFailureRatePct = round(100.0 * todouble(TlsFailedSessions)
        / iif(TlsInspectedSessions == 0, 1.0, todouble(TlsInspectedSessions)), 2)
| order by TimeGenerated asc, TrafficType asc
```

Record per traffic type: daily sessions, blocked-session ratio, distinct users, bytes, TLS inspection failure rate, and threat intelligence match volume.

> [!NOTE]
> Re-run this baseline and the per-capability baselines after any of the following: a Global Secure Access service update, a major policy change, a user-population growth event, or onboarding/offboarding a Remote Network. If you don't track service updates actively, **re-baseline at least once per quarter**. Stale baselines are the leading cause of false positives.
>
> **Get notified of service changes automatically:**
>
> - Configure [Azure Service Health alerts](/azure/service-health/alerts-activity-log-service-notifications-portal) for the **Global Secure Access** service to receive incident, planned-maintenance, and health-advisory notifications in your monitoring channel.
> - For tenant-level admin announcements, monitor the [Microsoft 365 Message Center](/microsoft-365/admin/manage/message-center) filtered to Microsoft Entra and Global Secure Access.

## Private Access security detections

### Per-user activity baseline (Private Access)

Before enabling the Private Access alerts below, capture the typical daily ceiling of per-user activity. The same baseline also applies to the Internet Access detections that follow.

Grounds: brute-force (`> 50 blocks / 5 min`), lateral movement (`> 10 distinct apps / 15 min`), repeated blocks (`> 100 blocks / hour`), data exfiltration (`> 500 MB upload / hour`).

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(30d)
| summarize
    DailyBlocks = countif(Action == "Block"),
    DailyDistinctApps = dcount(AppId),
    DailyUploadBytes = sum(SentBytes),
    DailyDistinctDestinations = dcount(DestinationFqdn)
    by UserPrincipalName, bin(TimeGenerated, 1d), TrafficType
| summarize
    P50_Blocks = percentile(DailyBlocks, 50),
    P95_Blocks = percentile(DailyBlocks, 95),
    P95_DistinctApps = percentile(DailyDistinctApps, 95),
    P95_UploadBytes = percentile(DailyUploadBytes, 95),
    P95_DistinctDestinations = percentile(DailyDistinctDestinations, 95)
    by TrafficType
```

Use the **P95** values as your starting upper bound. If your P95 distinct-apps-per-user is 4, the lateral-movement threshold of `> 10` is reasonable; if it is 12, raise the alert threshold to reduce noise.

### Alert summary

| What to monitor | Severity | Where to look | Filter / Sub-filter | Notes |
| --- | --- | --- | --- | --- |
| Connector compromise indicators | Critical | Connector host telemetry (Defender for Endpoint or equivalent on the connector VM) — not detectable from `NetworkAccessTraffic` alone | Connector host generates outbound traffic to destinations outside `*.msappproxy.net`, `*.servicebus.windows.net`, and known application backends | Investigation pattern — this guide does **not** ship a Sentinel rule because the signal lives on the connector host, not in GSA logs. Configure endpoint detection on the connector hosts and rely on the [**Global Secure Access** Content hub solution](/azure/sentinel/sentinel-solutions-deploy) for any prebuilt connector-aware rules. Hand off to [Microsoft Incident Response Playbooks](https://aka.ms/IRPlaybooks) on confirmed indicators. |
| Lateral movement via Private Access | High | `NetworkAccessTraffic` | Single user accesses > 10 distinct application segments within 15 minutes (see the lateral movement detection query that follows) | Validate with the application owner; if unauthorized, hand off to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1021. |
| Access from risky identity to private apps | High | `NetworkAccessTraffic` joined with `SigninLogs` | User with medium/high `RiskLevelDuringSignIn` successfully connects to Private Access apps | Use the [risky-user cross-signal query](#cross-signal-identity-and-network-correlation). Triage in Microsoft Entra ID Protection. |
| Private application access from a non-managed device | High | `NetworkAccessTraffic` joined with `NetworkAccessConnectionEvents` on `ConnectionId` | Successful Private Access session where `DeviceJoinType` is `unjoined` or empty | Verify with the device owner and endpoint team. If unsanctioned, hand off to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1078. **Validate `NetworkAccessConnectionEvents` column names with `NetworkAccessConnectionEvents &#124; take 10` before enabling.** |
| Off-hours private application access | Medium | `NetworkAccessTraffic` | Access to sensitive application segments outside business hours by a non-service account | Review with application owner; verify authorized access. |
| Brute-force against private app | High | `NetworkAccessTraffic` | > 50 failed connection attempts (`Action == "Block"`) to a single app segment within 5 minutes | Note that `Action == "Block"` records a policy denial, not an authentication failure — always pair with `SigninLogs` for the same user and app. Block the source identity if a credential attack is confirmed; escalate to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1110. Microsoft Sentinel template: [GSA Content hub solution](/azure/sentinel/sentinel-solutions-deploy). |
| Unauthorized connector group change | High | `AuditLogs` | Connector reassigned to a different group by an actor outside the change-management allow list | Revert the change; investigate actor via the [audit log query](#detect-unauthorized-configuration-changes). |

### Detection queries

**Lateral movement — rapid multi-app access:**

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(1h)
| where TrafficType == "private"
| where Action == "Allow"
| summarize
    DistinctApps = dcount(AppId),
    AppList = make_set(AppId, 20),
    SessionCount = count()
    by UserPrincipalName, bin(TimeGenerated, 15m)
| where DistinctApps > 10
| project TimeGenerated, UserPrincipalName, DistinctApps, SessionCount, AppList
| order by DistinctApps desc
```

**Sentinel analytics rule:**

- **Rule name:** GSA — Lateral movement via Private Access
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **Entities:** Account (UserPrincipalName)
- **MITRE ATT&CK:** Lateral Movement — T1021

**Private Access from a non-managed device (joined detection):**

This query joins `NetworkAccessTraffic` to `NetworkAccessConnectionEvents` on `ConnectionId` to add device context (OS, join type, applied security profile, PoP region) to a successful Private Access session.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(1h)
| where TrafficType == "private"
| where Action == "Allow"
| join kind=inner (
    NetworkAccessConnectionEvents
    | where TimeGenerated > ago(1h)
    | project ConnectionId, DeviceJoinType, DeviceOperatingSystem, ClientDeviceName, SecurityProfileName, PolicyName, PopProcessingRegion, IsLocal
) on ConnectionId
| where DeviceJoinType in ("unjoined", "") or isempty(DeviceJoinType)
| project TimeGenerated, UserPrincipalName, AppID, ClientDeviceName, DeviceOperatingSystem, DeviceJoinType, SecurityProfileName, PolicyName, PopProcessingRegion, IsLocal
| order by TimeGenerated desc
```

- **Rule name:** GSA — Private Access from non-managed device
- **Severity:** High
- **Query frequency:** Every 30 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Initial Access — T1078

**Off-hours access to sensitive applications:**

Localize this query to your primary business timezone. `TimeGenerated` is UTC — a UTC `7–19` window does not match local working hours outside the UK during summer time. Set `tzOffsetHours` to your primary office's offset; for tenants with multiple regions, run one variant per region or replace the offset with a per-user lookup.

Replace `<application-segment-id-N>` with the IDs of the application segments you classify as sensitive. Find them in the **Entra admin center > Global Secure Access > Applications** — each application segment has an **Application ID** (GUID) shown on its overview page; copy that value into the `sensitiveApps` array.

```kusto
let tzOffsetHours = -5; // -5 EST, -8 PST, +1 CET, +9 JST, etc. — customize to your environment
let businessHoursStart = 7;
let businessHoursEnd = 19;
let sensitiveApps = dynamic(["<application-segment-id-1>", "<application-segment-id-2>"]); // Application IDs from Entra admin center > Global Secure Access > Applications
NetworkAccessTraffic
| where TimeGenerated > ago(24h)
| where TrafficType == "private"
| where AppId in (sensitiveApps)
| extend LocalHour = (hourofday(TimeGenerated) + 24 + tzOffsetHours) % 24
| where LocalHour < businessHoursStart or LocalHour >= businessHoursEnd
| where UserPrincipalName !contains "_svc" and UserPrincipalName !startswith "svc-" // refine to your service-account naming convention
| project TimeGenerated, UserPrincipalName, AppId, SourceIp, Action
| order by TimeGenerated desc
```

**Brute-force against a private application:**

> [!NOTE]
> `Action == "Block"` in `NetworkAccessTraffic` records a **policy denial**, not an authentication failure. A burst of denials usually indicates a configuration issue (non-compliant device, missing entitlement, stale CA scope) — but the same signal is also produced by automated brute-force tools that have valid credentials but fail Conditional Access. Always pair this rule with `SigninLogs` for the target app to confirm a credential attack.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(15m)
| where TrafficType == "private"
| where Action == "Block"
| summarize FailureCount = count() by UserPrincipalName, AppId, bin(TimeGenerated, 5m)
| where FailureCount > 50
| project TimeGenerated, UserPrincipalName, AppId, FailureCount
```

- **Rule name:** GSA — Private Access brute-force attempt
- **Severity:** High
- **Query frequency:** Every 5 minutes
- **Query period:** Last 15 minutes
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Credential Access — T1110

**Unauthorized connector group change:**

> [!NOTE]
> The `OperationName` filter below uses a `has`-based match against the connector-group operations exposed in `AuditLogs`. Operation strings can change between service updates — validate against `AuditLogs | where OperationName has "connector" | distinct OperationName` in your tenant before enabling, and add any tenant-specific values to the filter.

```kusto
AuditLogs
| where TimeGenerated > ago(1h)
| where OperationName has_any (
    "Update Connector Group",
    "Add a Connector to Connector Group",
    "Delete Connector Group",
    "Add Connector Group"
)
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| extend ConnectorGroupName = tostring(parse_json(tostring(TargetResources[0])).displayName)
| project TimeGenerated, OperationName, Actor, ConnectorGroupName, Result, ResultReason, CorrelationId
| order by TimeGenerated desc
```

- **Rule name:** GSA — Unauthorized connector group change
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **Entities:** Account (Actor)
- **MITRE ATT&CK:** Defense Evasion — T1562; Persistence — T1098

## Internet Access security detections

The Internet Access detections share the [per-user activity baseline](#per-user-activity-baseline-private-access) defined in the Private Access section. Capture that baseline before tuning the thresholds below.

### Alert summary

| What to monitor | Severity | Where to look | Filter / Sub-filter | Notes |
| --- | --- | --- | --- | --- |
| Malware or phishing URL detected | High | `NetworkAccessAlerts` and `NetworkAccessTraffic` | GSA threat intelligence detects an attempted connection to a known malicious URL (`ThreatType` is set and not `NoneFound`) | Check whether the payload was downloaded; coordinate with endpoint protection to scan the device. Hand off to [IR Playbooks](https://aka.ms/IRPlaybooks) on confirmed compromise. Microsoft Sentinel template: [GSA Content hub solution](/azure/sentinel/sentinel-solutions-deploy). |
| Data exfiltration — high upload volume | Critical | `NetworkAccessTraffic` | User uploads > 500 MB to an uncategorized or newly registered domain within 1 hour | Add the destination to the web-filtering block list; engage your DLP team; escalate to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1041. |
| Web filtering policy change — unauthorized | High | `AuditLogs` | Web-filtering policy modified by an identity outside the change-management allow list | Revert change; investigate actor via the [audit log query](#detect-unauthorized-configuration-changes). |
| Repeated blocks from single user | Medium | `NetworkAccessTraffic` | One user triggers > 100 block actions across categories in 1 hour | Distinguish between misconfigured app and deliberate circumvention; review with the user's manager. |

### Detection queries

**Threat intelligence blocks:**

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(15m)
| where TrafficType == "internet"
| where isnotempty(ThreatType) and ThreatType != "NoneFound"
| project UserPrincipalName, ThreatType , DestinationFqdn, DestinationUrl , DestinationIp, Action
```

**Data exfiltration — high upload to uncommon domains:**

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(1h)
| where TrafficType == "internet"
| where Action == "Allow"
| summarize
    TotalUploadBytes = sum(SentBytes),
    SessionCount = count(),
    DistinctDestinations = dcount(DestinationFqdn)
    by UserPrincipalName, DestinationFqdn
| where TotalUploadBytes > 500000000 // 500 MB
| project UserPrincipalName, DestinationFqdn, TotalUploadMB = TotalUploadBytes / 1048576, SessionCount
| order by TotalUploadMB desc
```

- **Rule name:** GSA — Potential data exfiltration via Internet Access
- **Severity:** Critical
- **Query frequency:** Every 30 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Exfiltration — T1041

## Remote Networks security detections

### Per-network health baseline (Remote Networks)

Ground the Remote Network detections by capturing typical tunnel and BGP behavior per site. Sites with healthy networks usually show `0` daily state changes — a single change above zero may already be alert-worthy.

Grounds: tunnel flapping (`> 3 state changes / 15 min`), BGP anomaly (`> 50% route drop`), branch traffic anomaly (`> 200% of 7-day average`), new source IP from branch.

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(30d)
| summarize
    DailyStateChanges = countif(EventType has_any ("TunnelConnected", "TunnelDisconnected")),
    AvgAdvertisedRoutes = avg(AdvertisedRouteCount),
    MinAdvertisedRoutes = min(AdvertisedRouteCount),
    MaxAdvertisedRoutes = max(AdvertisedRouteCount),
    BgpResets = countif(BgpSessionState != "Established")
    by RemoteNetworkId, RemoteNetworkName, bin(TimeGenerated, 1d)
| summarize
    P95_StateChanges = percentile(DailyStateChanges, 95),
    StableRouteCount = round(avg(AvgAdvertisedRoutes)),
    DailyBgpResets_P95 = percentile(BgpResets, 95)
    by RemoteNetworkId, RemoteNetworkName
```

Use the query below to seed the allow list for the **New source IP from branch tunnel** detection.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(30d)
| where TrafficType == "remoteNetwork"
| summarize
    DailyBytes = sum(SentBytes + ReceivedBytes),
    KnownSourceIps = make_set(SourceIp, 50)
    by RemoteNetworkId, bin(TimeGenerated, 1d)
```

> [!IMPORTANT]
> The detection queries below reference `RemoteNetworkHealthLogs`, the native GSA table for tunnel and BGP health. Field names follow the diagnostic settings integration guide and may differ in your tenant — **validate column names** against `RemoteNetworkHealthLogs | take 10` before enabling these as Sentinel analytics rules.

### Alert summary

| What to monitor | Severity | Where to look | Filter / Sub-filter | Notes |
| --- | --- | --- | --- | --- |
| Unhealthy Remote Network alert | High | `NetworkAccessAlerts` | GSA emits an `Unhealthy Remote Network` alert | Native GSA alert — primary tunnel-health signal. Engage branch network team. Hand off to [IR Playbooks](https://aka.ms/IRPlaybooks) only if compromise is suspected. |
| Tunnel flapping | High | `RemoteNetworkHealthLogs` | A remote network records > 3 tunnel state changes within 15 minutes | Verify CPE stability and PSK or certificate validity; investigate ISP and routing changes. |
| BGP session reset or route count drop | High | `RemoteNetworkHealthLogs` | BGP session leaves the `Established` state, or advertised route count drops > 50% from baseline | Verify CPE BGP configuration; confirm no unauthorized router replacement. |
| Unusual traffic volume from branch site | Medium | `NetworkAccessTraffic` | Traffic from a remote network exceeds 200% of 7-day average | Investigate for compromised devices on the branch network; contact the branch network team. |
| New source IP from branch tunnel | High | `NetworkAccessTraffic` | Traffic arrives through an established tunnel from an IP range not in the site's known subnets | Verify with the branch network team; may indicate rogue device or tunnel hijacking. Hand off to [IR Playbooks](https://aka.ms/IRPlaybooks) on confirmation. |
| IKE authentication failure spike (CPE-side) | High | `CommonSecurityLog` | > 10 IKE Phase 1 authentication failures from a branch site within 5 minutes | Verify pre-shared key or certificate validity; if brute-force is confirmed, escalate to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1133. Available only when the CPE forwards CEF logs. |

### Detection queries

**Tunnel flapping (Microsoft side):**

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(15m)
| where EventType has_any ("TunnelConnected", "TunnelDisconnected")
| summarize StateChanges = count(), FirstSeen = min(TimeGenerated), LastSeen = max(TimeGenerated)
    by RemoteNetworkId, RemoteNetworkName
| where StateChanges > 3
| project RemoteNetworkId, RemoteNetworkName, StateChanges, FirstSeen, LastSeen
```

- **Rule name:** GSA — Remote Network tunnel flapping
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 15 minutes
- **Trigger:** Number of results > 0

**BGP session anomaly:**

```kusto
let routeBaseline = RemoteNetworkHealthLogs
    | where TimeGenerated between (ago(7d) .. ago(1d))
    | summarize AvgRoutes = avg(AdvertisedRouteCount) by RemoteNetworkId;
RemoteNetworkHealthLogs
| where TimeGenerated > ago(15m)
| where BgpSessionState != "Established"
    or (isnotempty(AdvertisedRouteCount) and AdvertisedRouteCount > 0)
| join kind=leftouter routeBaseline on RemoteNetworkId
| extend RouteDropRatio = iff(AvgRoutes > 0, 1.0 - (todouble(AdvertisedRouteCount) / AvgRoutes), 0.0)
| where BgpSessionState != "Established" or RouteDropRatio > 0.5
| project TimeGenerated, RemoteNetworkId, RemoteNetworkName, BgpSessionState, AdvertisedRouteCount, AvgRoutes, RouteDropRatio
```

- **Rule name:** GSA — Remote Network BGP session anomaly
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 15 minutes
- **Trigger:** Number of results > 0

**Unusual traffic volume from branch:**

```kusto
let baseline = NetworkAccessTraffic
    | where TimeGenerated between (ago(7d) .. ago(1d))
    | where TrafficType == "remoteNetwork"
    | summarize AvgDailyBytes = avg(SentBytes + ReceivedBytes) by RemoteNetworkId;
NetworkAccessTraffic
| where TimeGenerated > ago(1d)
| where TrafficType == "remoteNetwork"
| summarize TodayBytes = sum(SentBytes + ReceivedBytes) by RemoteNetworkId
| join kind=inner baseline on RemoteNetworkId
| extend Ratio = TodayBytes / AvgDailyBytes
| where Ratio > 2.0
| project RemoteNetworkId, TodayBytesMB = TodayBytes / 1048576, AvgDailyBytesMB = AvgDailyBytes / 1048576, Ratio
```

**IKE authentication failures (CPE-side, optional):**

Use this query only when the branch CPE forwards CEF logs to Sentinel; otherwise rely on `RemoteNetworkHealthLogs` and the native `Unhealthy Remote Network` alert.

```kusto
CommonSecurityLog
| where TimeGenerated > ago(1h)
| where DeviceVendor == "Microsoft" and DeviceProduct == "Global Secure Access"
| where Activity has "IKE" and Activity has "fail"
| summarize FailCount = count() by SourceIP, DeviceName, bin(TimeGenerated, 5m)
| where FailCount > 10
| project TimeGenerated, SourceIP, DeviceName, FailCount
```

- **Rule name:** GSA — Remote Network IKE authentication failure spike
- **Severity:** High
- **Query frequency:** Every 5 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Initial Access — T1133

## Microsoft Traffic security detections

### Microsoft Traffic baseline

Ground the Microsoft Traffic detections by capturing the typical volume of GSA-routed sign-ins, the country distribution of M365 access, and the baseline rate of each native GSA alert. Any non-zero day for `Token / Device Inconsistency` should be treated as Critical regardless of baseline.

Grounds: compliant network bypass (`SigninLogs.IsThroughGlobalSecureAccess == "false"`), M365 access from blocked geography, Token/Device Inconsistency, Increased External Tenant Activity, and Unhealthy Remote Network alert volumes.

```kusto
SigninLogs
| where TimeGenerated > ago(30d)
| where ResultType == 0
| extend ThroughGsa = iif(IsThroughGlobalSecureAccess == "true", 1, 0)
| summarize
    TotalSignins = count(),
    GsaSignins = sum(ThroughGsa),
    NonCompliantSignins = countif(IsThroughGlobalSecureAccess == "false"),
    DistinctUsers = dcount(UserPrincipalName)
    by bin(TimeGenerated, 1d)
| extend NonCompliantPct = round(100.0 * todouble(NonCompliantSignins) / TotalSignins, 2)
```

```kusto
NetworkAccessConnectionEvents
| where TimeGenerated > ago(30d)
| where TrafficType == "m365"
| summarize Sessions = count() by SourceIpCountryCode, bin(TimeGenerated, 1d)
| order by Sessions desc
```

```kusto
NetworkAccessAlerts
| where TimeGenerated > ago(30d)
| where AlertType in ("Token / Device Inconsistency", "Increased External Tenant Activity")
| summarize DailyAlerts = count() by AlertType, bin(TimeGenerated, 1d)
```

> [!NOTE]
> The `Unhealthy Remote Network` alert is a Remote Networks signal — baseline it under [Per-network health baseline (Remote Networks)](#per-network-health-baseline-remote-networks).

### Alert summary

| What to monitor | Severity | Where to look | Filter / Sub-filter | Notes |
| --- | --- | --- | --- | --- |
| Compliant network bypass — successful sign-in | High | `SigninLogs` | Successful sign-in to an app protected by a compliant-network Conditional Access policy where `NetworkLocationDetails` does not contain `compliantNetwork` | Review Conditional Access policies; verify compliant-network enforcement is active. MITRE T1562. Microsoft Sentinel template: [GSA Content hub solution](/azure/sentinel/sentinel-solutions-deploy). |
| Token / Device Inconsistency alert | Critical | `NetworkAccessAlerts` | GSA emits a `Token / Device Inconsistency` alert | High-fidelity token-theft signal. Pair with `SigninLogs.TokenIssuerType` and Microsoft Entra ID Protection. Hand off to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1528 / T1550. |
| Increased External Tenant Activity alert | High | `NetworkAccessAlerts` | GSA emits an `Increased External Tenant Activity` alert | Correlate with `SigninLogs` cross-tenant access events; review B2B and cross-tenant access settings. |
| M365 access from blocked geography | High | `NetworkAccessConnectionEvents` joined with `NetworkAccessTraffic` | Source country in your blocked-country list (`CN`, `RU`, `KP`, `IR`, or your policy) | Review the user's full activity; review Conditional Access geographic block policies. |

### Detection queries

**Compliant network bypass:**

This query detects successful sign-ins to M365 services where the sign-in did not originate from a network marked `compliantNetwork`. Restrict the rule to apps protected by your compliant-network Conditional Access policy — firing it for all apps will produce constant noise from any legitimate sign-in that doesn't traverse GSA.

```kusto
let protectedApps = dynamic(["Office 365 Exchange Online", "Office 365 SharePoint Online", "Microsoft Teams"]);
SigninLogs
| where TimeGenerated > ago(1h)
| where IsThroughGlobalSecureAccess == "false"
| where AppDisplayName has_any (protectedApps)
| where ResultType == 0
| project TimeGenerated, UserPrincipalName, AppDisplayName, IPAddress, Location, DeviceDetail
| order by TimeGenerated desc

```

- **Rule name:** GSA — M365 access from non-compliant network
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Defense Evasion — T1562

**GSA-native alert: Token / Device Inconsistency:**

```kusto
NetworkAccessAlerts
| where TimeGenerated > ago(1h)
| where AlertType == "Token / Device Inconsistency"
| project TimeGenerated, AlertType, Severity, Description
| order by TimeGenerated desc
```

- **Rule name:** GSA — Token / Device Inconsistency
- **Severity:** Critical
- **Query frequency:** Every 5 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Credential Access — T1528; Lateral Movement — T1550

**GSA-native alert: Increased External Tenant Activity:**

```kusto
NetworkAccessAlerts
| where TimeGenerated > ago(1h)
| where AlertType == "Increased External Tenant Activity"
| project TimeGenerated, AlertType, Severity, Description
| order by TimeGenerated desc
```

- **Rule name:** GSA — Increased External Tenant Activity
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Initial Access — T1199 (Trusted Relationship)

**M365 access from blocked geography:**

```kusto
let blockedCountries = dynamic(["cn", "ru", "kp", "ir"]); // customize to your policy — must be lowercase
let lookback = 1h;
NetworkAccessConnectionEvents
| where TimeGenerated > ago(lookback)
| where TrafficType == "m365"
| where SourceIpCountryCode in (blockedCountries)
| project TimeGenerated, ConnectionId, UserPrincipalName, SourceIpCountryCode
| join kind=inner (
    NetworkAccessTraffic
    | where TimeGenerated > ago(lookback)
    | where TrafficType == "microsoft365"
    | project ConnectionId, DestinationFqdn, Action
) on ConnectionId
| project TimeGenerated, UserPrincipalName, SourceIpCountryCode, DestinationFqdn, Action
| order by TimeGenerated desc
```

## Generative AI security detections

### Generative AI baseline (Preview)

Ground the Generative AI detections by capturing typical organization-wide and per-user prompt volume. Use the **P99** per-user daily prompt count as the upper bound for the **anomalous prompt volume** alert; a threshold above 5x the P95 is typical for a tuned rule.

Grounds: Shadow AI usage, unsanctioned MCP server access, anomalous prompt volume per user.

```kusto
NetworkAccessGenerativeAIInsights
| where TimeGenerated > ago(30d)
| summarize
    DailyPrompts = count(),
    DistinctServices = dcount(DestinationUrl),
    DistinctUsers = dcount(UserPrincipalName)
    by bin(TimeGenerated, 1d)
```

```kusto
NetworkAccessGenerativeAIInsights
| where TimeGenerated > ago(30d)
| summarize PerUserDailyPrompts = count() by UserPrincipalName, bin(TimeGenerated, 1d)
| summarize
    P50 = percentile(PerUserDailyPrompts, 50),
    P95 = percentile(PerUserDailyPrompts, 95),
    P99 = percentile(PerUserDailyPrompts, 99)
```

> [!NOTE]
> The `NetworkAccessGenerativeAIInsights` table is in **Preview**. Schema, column names, and operation values can change. **Validate the queries below against `NetworkAccessGenerativeAIInsights | take 10` in your tenant before enabling them as Sentinel analytics rules.** Treat these as a starting template, not a tested production ruleset.
>
> The published table reference exposes `DestinationUrl` and dedicated `McpClientName` / `McpServerName` columns. The queries in this section use those column names. If you need to group by host instead of full URL, derive an FQDN with `parse_url(DestinationUrl).Host`.

### Alert summary

| What to monitor | Severity | Where to look | Filter / Sub-filter | Notes |
| --- | --- | --- | --- | --- |
| Shadow AI — unsanctioned AI tool usage | Medium | `NetworkAccessGenerativeAIInsights` and `NetworkAccessTraffic` | User accesses an AI service that is not on the sanctioned-app list | Review with the user's manager; consider adding the service to the web filtering allow or block list. |
| Unsanctioned MCP server access | High | `NetworkAccessGenerativeAIInsights` | MCP client connects to an MCP server FQDN not in the approved-server list | Block the destination via web filtering; review the user's other AI activity. |
| AI usage by risky user | High | `NetworkAccessGenerativeAIInsights` joined with `SigninLogs` | User with `RiskLevelDuringSignIn` of medium or high generates AI prompts | Recommended path: block the AI service via a **GSA Internet Access web filtering rule** targeting the AI service FQDN — fastest to apply, scoped to GSA-enrolled devices, no app-registration prerequisite. As a backup for unmanaged devices, add a **Conditional Access policy** that blocks the AI app's enterprise app registration for medium/high risk users. Triage in Microsoft Entra ID Protection. |
| Anomalous prompt volume per user | Medium | `NetworkAccessGenerativeAIInsights` | One user issues > 500 prompts in 1 hour, or more than 5x the 7-day per-user average | Verify legitimate use; investigate for automation, scraping, or compromised credentials. |

### Detection queries

**Shadow AI usage:**

```kusto
let sanctionedAiServices = dynamic(["copilot.microsoft.com", "chatgpt.com", "claude.ai"]); // customize to your policy
NetworkAccessGenerativeAIInsights
| where TimeGenerated > ago(24h)
| extend DestinationHost = tostring(parse_url(DestinationUrl).Host)
| where DestinationHost !in (sanctionedAiServices)
| summarize PromptCount = count(), Services = make_set(DestinationHost, 10) by UserPrincipalName
| where PromptCount > 0
| order by PromptCount desc
```

**Unsanctioned MCP server access:**

```kusto
let approvedMcpServers = dynamic(["mcp.contoso.com"]); // customize to your policy
NetworkAccessGenerativeAIInsights
| where TimeGenerated > ago(1h)
| where isnotempty(McpServerName)
| where McpServerName !in (approvedMcpServers)
| project TimeGenerated, UserPrincipalName, McpClientName, McpServerName, DestinationUrl, Activity, SubActivity
| order by TimeGenerated desc
```

**AI usage by risky user:**

```kusto
let riskyUsers = SigninLogs
    | where TimeGenerated > ago(24h)
    | where RiskLevelDuringSignIn in ("medium", "high")
    | summarize RiskLevelDuringSignIn = max(RiskLevelDuringSignIn) by UserPrincipalName;
NetworkAccessGenerativeAIInsights
| where TimeGenerated > ago(24h)
| extend DestinationHost = tostring(parse_url(DestinationUrl).Host)
| join kind=inner riskyUsers on UserPrincipalName
| summarize PromptCount = count(), Services = make_set(DestinationHost, 10) by UserPrincipalName, RiskLevelDuringSignIn
| order by RiskLevelDuringSignIn desc, PromptCount desc
```

> [!TIP]
> Use [Microsoft Security Copilot](/security-copilot/) to correlate AI usage patterns with identity risk signals across `NetworkAccessGenerativeAIInsights` and `SigninLogs`. Prompt example: *"Show me all users with medium or high sign-in risk who accessed unsanctioned AI services in the last 24 hours, and list which services they used."*

## Cross-signal: identity and network correlation

The highest-fidelity detections combine identity signals from `SigninLogs` with network signals from `NetworkAccessTraffic`. These queries identify scenarios that neither log source would surface alone.

### Risky user accessing private applications

```kusto
let riskyUsers = SigninLogs
    | where TimeGenerated > ago(24h)
    | where RiskLevelDuringSignIn in ("medium", "high")
    | summarize RiskLevelDuringSignIn = max(RiskLevelDuringSignIn) by UserPrincipalName;
NetworkAccessTraffic
| where TimeGenerated > ago(24h)
| where TrafficType == "private"
| where Action == "Allow"
| join kind=inner riskyUsers on UserPrincipalName
| summarize
    AppCount = dcount(AppId),
    Apps = make_set(AppId, 10),
    SessionCount = count()
    by UserPrincipalName, RiskLevelDuringSignIn
| order by RiskLevelDuringSignIn desc, AppCount desc
```

### Sign-in outside the GSA path for a GSA-enforced user

This pattern detects a user who normally has GSA traffic but just signed in successfully **without** going through GSA — a real bypass scenario. The seed list is users who generated GSA traffic in the last 24 hours, used as a proxy for "this user is supposed to be on GSA." Tighten the seed list with your own group membership when available.

```kusto
let gsaEnforcedUsers = NetworkAccessTraffic
    | where TimeGenerated > ago(24h)
    | where isnotempty(UserId)
    | distinct UserId;
SigninLogs
| where TimeGenerated > ago(1h)
| where ResultType == 0
| where IsThroughGlobalSecureAccess == "false"
| where UserId in (gsaEnforcedUsers)
| project TimeGenerated, UserPrincipalName, AppDisplayName, IPAddress, Location, DeviceDetail
| order by TimeGenerated desc
```

> [!TIP]
> Use [Microsoft Security Copilot](/security-copilot/) to correlate cross-signal findings at scale. Prompt example: *"For users who were denied by GSA Private Access in the last 24 hours, summarize their identity risk signals and any successful sign-ins from different IP addresses."*

## Detect unauthorized configuration changes

Configuration changes to GSA policies outside your change management process are a high-priority detection. The queries below filter `AuditLogs` on the GSA `OperationName` values listed in the [Entra audit activities reference](/entra/identity/monitoring-health/reference-audit-activities#global-secure-access).

### Audit operations baseline

Before enabling the rules below, capture which GSA operations occur in your tenant, who performs them, and at what frequency. Use the result to seed the **authorized actor allow list** that every detection in this section filters against.

Grounds: unauthorized configuration change, enriched audit logging changed, tenant onboarding/offboarding, TLS certificate operations.

```kusto
AuditLogs
| where TimeGenerated > ago(30d)
| where OperationName has_any (
    "Filtering Policy", "Forwarding Policy", "Forwarding Profile", "Forwarding Rule",
    "Remote Network", "Private Access Policy", "Security Provider",
    "Adaptive Access Policy", "Enriched Audit Logs Settings",
    "Onboarding Process Started", "Offboarding Process Started",
    "Create Certificate", "Update Certificate", "Delete Certificate")
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| summarize Operations = count() by OperationName, Actor, bin(TimeGenerated, 1d)
| order by Operations desc
```

> [!IMPORTANT]
>
> 1. Run each rule as a hunting query for at least 7 days, confirm rows return for known-good admin actions, and adjust `OperationName` strings or filter on `LoggedByService == "Global Secure Access"` if your tenant emits a different value.
> 2. Re-validate after every GSA service update.

### Unauthorized policy or profile change

```kusto
let authorizedActors = dynamic(["change-mgmt-svc@contoso.com"]); // customize to your environment
let gsaPolicyOperations = dynamic([
    "Create Filtering Policy", "Update Filtering Policy", "Delete Filtering Policy",
    "Create Filtering Policy Profile", "Update Filtering Policy Profile", "Delete Filtering Policy Profile",
    "Update Filtering Profile",
    "Delete Forwarding Policy", "Update Forwarding Policy",
    "Update Forwarding Profile", "Update Forwarding Rule",
    "Update Forwarding Options Policy",
    "Create Remote Network", "Update Remote Network", "Delete Remote Network",
    "Update Private Access Policy", "Delete Private Access Policy",
    "Create Security Provider Policy", "Update Security Provider Policy", "Delete Security Provider Policy",
    "Create Registration of Security Provider",
    "Update Adaptive Access Policy"
]);
AuditLogs
| where TimeGenerated > ago(24h)
| where OperationName in (gsaPolicyOperations)
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| where Actor !in (authorizedActors)
| extend Target = tostring(TargetResources[0].displayName)
| project TimeGenerated, Actor, OperationName, Target, Result
| order by TimeGenerated desc
```

- **Rule name:** GSA — Unauthorized network access configuration change
- **Severity:** High
- **Query frequency:** Every 60 minutes
- **Query period:** Last 24 hours
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Defense Evasion — T1562.001

### Anti-forensic — enriched audit logging changed

The `Update Enriched Audit Logs Settings` operation alters which GSA fields are written to audit logs. An unexpected change is a strong anti-forensic indicator.

```kusto
AuditLogs
| where TimeGenerated > ago(24h)
| where OperationName == "Update Enriched Audit Logs Settings"
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, Actor, OperationName, Result, ResultReason
```

- **Rule name:** GSA — Enriched audit logging changed
- **Severity:** Critical
- **Query frequency:** Every 15 minutes
- **Query period:** Last 24 hours
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Defense Evasion — T1562.002

### Tenant-level GSA onboarding or offboarding

`Onboarding Process Started` should appear once per tenant during initial setup; `Offboarding Process Started` disables GSA for the entire tenant. Either operation outside an approved change window is high severity.

```kusto
AuditLogs
| where TimeGenerated > ago(24h)
| where OperationName in ("Offboarding Process Started", "Onboarding Process Started")
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, Actor, OperationName, Result
```

- **Rule name:** GSA — Tenant onboarding/offboarding initiated
- **Severity:** Critical
- **Query frequency:** Every 15 minutes
- **Query period:** Last 24 hours
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Impact — T1531

### TLS inspection certificate change

`Create Certificate`, `Update Certificate`, and `Delete Certificate` under the GSA service correspond to TLS inspection certificate operations. Pair this detection with the [TLS inspection certificate lifecycle](how-to-operate-internet-access.md#tls-inspection-certificate-lifecycle) procedure so SOC and Network Ops see the same signal.

```kusto
AuditLogs
| where TimeGenerated > ago(24h)
| where OperationName in ("Create Certificate", "Update Certificate", "Delete Certificate")
| where Category == "ApplicationManagement"
// The following filter narrows results to GSA-emitted certificate operations.
// If your tenant emits a different LoggedByService value, replace the value below
// (do not remove the filter — "ApplicationManagement" alone covers many other Entra services).
| where LoggedByService == "Global Secure Access"
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, Actor, OperationName, Result
```

- **Rule name:** GSA — TLS inspection certificate operation
- **Severity:** High
- **Query frequency:** Every 60 minutes
- **Query period:** Last 24 hours
- **Trigger:** Number of results > 0

> [!IMPORTANT]
> Maintain an **allow list** of identities authorized to make GSA configuration changes. Filter every query above to exclude authorized actors so each rule only fires for unexpected changes.

## Sample Sentinel analytics rule templates

The table below lists the rules with full Sentinel definitions in this guide (rule name, severity, query frequency, trigger). The remaining detections in this guide are **patterns to operationalize** — alert-table rows or KQL snippets that don't yet ship as importable rules. Pair this guide with the [**Global Secure Access** solution available in the Sentinel Content hub](/azure/sentinel/sentinel-solutions-deploy) for the canonical, Microsoft-maintained rule set.

| Rule name | Capability | Severity | MITRE ATT&CK |
| --- | --- | --- | --- |
| GSA — Lateral movement via Private Access | Private Access | High | T1021 |
| GSA — Private Access brute-force attempt | Private Access | High | T1110 |
| GSA — Private Access from non-managed device | Private Access | High | T1078 |
| GSA — Unauthorized connector group change | Private Access | High | T1562 / T1098 |
| GSA — Potential data exfiltration via Internet Access | Internet Access | Critical | T1041 |
| GSA — Remote Network tunnel flapping | Remote Networks | High | — |
| GSA — Remote Network BGP session anomaly | Remote Networks | High | — |
| GSA — Remote Network IKE authentication failure spike | Remote Networks | High | T1133 |
| GSA — M365 access from non-compliant network | Microsoft Traffic | High | T1562 |
| GSA — Token / Device Inconsistency | Microsoft Traffic | Critical | T1528 / T1550 |
| GSA — Increased External Tenant Activity | Microsoft Traffic | High | T1199 |
| GSA — Unauthorized network access configuration change | All | High | T1562.001 |
| GSA — Enriched audit logging changed | All | Critical | T1562.002 |
| GSA — Tenant onboarding/offboarding initiated | All | Critical | T1531 |
| GSA — TLS inspection certificate operation | Internet Access | High | — |

> [!NOTE]
> Install the [**Global Secure Access** solution from the Sentinel Content hub](/azure/sentinel/sentinel-solutions-deploy) first — it includes prebuilt rules, workbooks, and hunting queries. The rules in this guide supplement the solution for scenarios it doesn't cover. The Content hub solution typically ships workbooks for **traffic analytics**, **threat insights**, and **administrative activity** — import them after enabling diagnostic settings to get a working dashboard before any of the rules in this guide fire.

## Operational alignment

### Alert tuning cadence

| Action | Cadence | Owner |
| --- | --- | --- |
| Review false positive rate for each analytics rule | Weekly | SOC Analyst |
| Adjust thresholds based on baseline trends | Monthly | SOC Analyst + Network Security Engineer |
| Re-run capacity baselines | Quarterly, or after any GSA service update | SOC Analyst + Network Security Engineer |
| Review and update the authorized change actor allow list | After every RBAC change | Network Security Engineer |
| Evaluate new MITRE ATT&CK techniques relevant to network access | Quarterly | SOC Analyst |

## Related content

- [Microsoft Incident Response Playbooks](https://aka.ms/IRPlaybooks)
- [Entra Security Operations Guide](https://aka.ms/AzureADSecOps)
- [Microsoft Entra audit log categories and activities — Global Secure Access](/entra/identity/monitoring-health/reference-audit-activities#global-secure-access)
- [Microsoft Sentinel Content hub](/azure/sentinel/sentinel-solutions-deploy)
- [Log Analytics data retention and archive](/azure/azure-monitor/logs/data-retention-configure)
- [Common operations guide](how-to-operations-common.md)
- [Private Access operations](how-to-operate-private-access.md)
- [Internet Access operations](how-to-operate-internet-access.md)
- [Remote Networks operations](how-to-operate-remote-networks.md)
- [Microsoft Traffic operations](how-to-operate-microsoft-traffic.md)
- [Global Secure Access documentation](/entra/global-secure-access/)
- [MITRE ATT&CK framework](https://attack.mitre.org/)
- [Microsoft Zero Trust — Network pillar](https://zerotrust.microsoft.com/)

## Next steps

See these companion articles in the Microsoft Entra security operations guide series:

- [Security operations for user accounts](/entra/architecture/security-operations-user-accounts)
- [Security operations for privileged accounts](/entra/architecture/security-operations-privileged-accounts)
- [Security operations for applications](/entra/architecture/security-operations-applications)
- [Security operations for devices](/entra/architecture/security-operations-devices)
- [Security operations for infrastructure](/entra/architecture/security-operations-infrastructure)

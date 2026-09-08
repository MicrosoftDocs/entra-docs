---
title: Security operations for network access
description: Security operations guide for Microsoft Entra Global Secure Access covering detection patterns and Sentinel analytics for Private Access, Internet Access, Remote Networks, and Microsoft Traffic.
ms.reviewer: tdetzner, jebley
ms.topic: how-to
ms.date: 06/18/2026
ai-usage: ai-assisted
---

# Security operations for network access

This guide provides security monitoring and detection guidance for Microsoft Entra Global Secure Access. It covers what to monitor, where to look, and the analytics rules that surface identity-aware network access threats across all Global Secure Access capabilities.

This guide is a companion to the [Microsoft Entra Security Operations Guide](https://aka.ms/AzureADSecOps), which covers identity-centric signals. Use both guides together - identity signals and network signals often need to be correlated to determine the scope and impact of a security event.

For day-to-day operational procedures (health checks, change management, capacity planning), see the [Microsoft Entra Global Secure Access operations guide](overview-operations.md).

## Who this guide is for

| Role | How to use this guide |
|---|---|
| **Security operations center (SOC) analyst** | Primary audience. Use the detection queries, alert rules, and investigation procedures to monitor and respond to Global Secure Access-related threats. |
| **Network Security Engineer** | Use as a reference when tuning policies, reviewing alert efficacy, and supporting SOC investigations with infrastructure context. Responsible for the Remote Networks and Internet Access detections in this guide. |
| **Identity Admin** | Responsible for the identity-bound detections in this guide - compliant-network bypass, Token / Device Inconsistency, Increased External Tenant Activity, and the Global Secure Access administrator-operation rules under [Detect unauthorized configuration changes](#detect-unauthorized-configuration-changes). Investigate in Microsoft Entra ID Protection and Conditional Access and collaborate with SOC on response. |


## What to look for

As you monitor Global Secure Access telemetry for security incidents, review the following list to help differentiate normal activity from malicious activity. Each category is covered in detail later in this article.

- [Private Access threats and connector compromise](#private-access)
    - Connector host generating outbound traffic to destinations outside the expected backends
    - [Single user accessing many distinct application segments in a short window](#lateral-movement---rapid-multi-app-access)
    - [Brute-force sign-in attempts against a single Private Access application](#brute-force-against-a-private-application)
    - [Private Access from unmanaged or nonjoined devices](#private-access-from-a-nonmanaged-device-joined-detection)
    - [Off-hours access to sensitive applications by nonservice accounts](#off-hours-access-to-sensitive-applications)
- [Web-layer threats and data exfiltration](#internet-access)
    - [Threat intelligence matches on malicious URLs (`ThreatType` populated)](#threat-intelligence-blocks)
    - Netskope **Threat Protection**, **Data Loss Prevention**, or **Fallback** alerts (when enabled)
    - [High upload volume to a single destination](#data-exfiltration---high-upload-to-uncommon-domains)
    - [Repeated blocked-URL requests from a single user](#repeated-blocks-from-a-single-user)
- [Remote Network tunnel and branch compromise](#remote-networks)
    - [Remote Network tunnel flapping, repeated Internet Key Exchange (IKE) or Internet Protocol Security (IPsec) authentication failures, or Border Gateway Protocol (BGP) session anomalies](#tunnel-flapping)
    - [Unusual traffic volume from a branch site](#unusual-traffic-volume-from-branch)
- [Microsoft 365 traffic and compliant-network enforcement](#microsoft-traffic)
    - [Compliant-network bypass: successful sign-in to a Microsoft 365 service outside the Global Secure Access path](#compliant-network-bypass)
    - [Global Secure Access **Token / Device Inconsistency** or **Increased External Tenant Activity** alerts](#global-secure-access-native-alert-token--device-inconsistency)
    - [Access from blocked geographies](#microsoft-365-access-from-blocked-geography)
- [Generative AI and Model Context Protocol (MCP) misuse](#generative-ai-and-mcp)
    - [Shadow AI: access to unsanctioned AI services](#shadow-ai-usage)
    - [MCP client connecting to unapproved MCP servers](#unsanctioned-mcp-server-access)
    - [AI usage by users with elevated identity risk](#ai-usage-by-risky-user)
    - [Anomalous prompt volume per user](#anomalous-prompt-volume-per-user)
- [Cross-signal correlations](#cross-signal-identity-and-network-correlation)
    - [Risky user (Microsoft Entra ID Protection) successfully accessing Private Access apps](#risky-user-accessing-private-applications)
    - [User enrolled in Global Secure Access enforcement signing in outside the Global Secure Access path](#sign-in-outside-the-global-secure-access-path-for-a-global-secure-access-enforced-user)
- [Unauthorized configuration changes (control plane)](#detect-unauthorized-configuration-changes)
    - [Global Secure Access filtering or forwarding policy changes by an actor outside the change-management allow list](#unauthorized-policy-or-profile-change)
    - [Remote Network configuration change summary](#remote-network-configuration-change-summary)
    - Connector group, application segment, or remote network changes by an unexpected identity
    - [**Global Secure Access traffic heartbeat** - sudden drop in `NetworkAccessTraffic` volume](#tenant-offboarding-and-forwarding-profile-disable-global-secure-access-traffic-heartbeat) (covers tenant offboarding, which has no audit signal, plus profile-disable and platform outages)
    - Transport Layer Security (TLS) inspection certificate creation, rotation, or removal


## Where to look

Global Secure Access exposes several native diagnostic categories. Each maps to a dedicated Log Analytics table and surfaces a different layer of network telemetry. Combine them with the Microsoft Entra identity tables and customer-premises equipment (CPE) syslog where applicable. CPE refers to the [branch routers that terminate Remote Network tunnels](/entra/global-secure-access/quickstart-remote-network).

| Source | What it contains | When to use it |
|---|---|---|
| `NetworkAccessTraffic` | Transaction-level events for every HTTP request through Global Secure Access: user, device, destination, URL, bytes, action, applied policy, threat type, TLS inspection result, cloud app risk score, initiating process | Primary table for traffic, threat, and policy detections across all Global Secure Access capabilities |
| `NetworkAccessConnectionEvents` | Connection lifecycle events with device context (OS, join type, name), the security profile / policy / rule that was applied, point of presence (PoP) region, cross-tenant access, and Intelligent Local Access (`IsLocal`) | Add device and policy context to traffic-based detections; investigate B2B and PoP routing anomalies. Join to `NetworkAccessTraffic` on `ConnectionId` |
| `RemoteNetworkHealthLogs` | IPsec tunnel and BGP session state, heartbeats, advertised route counts, throughput per remote network | Primary source for branch tunnel and BGP detections - replaces or supplements CPE-side `CommonSecurityLog` |
| `NetworkAccessAlerts` | Native Global Secure Access alerts such as **Token / Device Inconsistency**, **Increased External Tenant Activity**, and **Unhealthy Remote Network**, plus supported security-provider alerts such as Netskope **Threat Protection**, **Data Loss Prevention**, and **Fallback** | Review built-in alerts first, then supplement them with Sentinel rules for tenant-specific thresholds and correlation |
| `NetworkAccessGenerativeAIInsights` (Preview) | Generative AI prompts, MCP client/server activity, AI tool and sub-activity metadata | Shadow AI detection, MCP governance, prompt monitoring, AI usage compliance |
| `SigninLogs` | Microsoft Entra ID sign-in events with Global Secure Access-aware fields (`IsThroughGlobalSecureAccess`, `NetworkLocationDetails`) | Correlate identity risk with network activity |
| `AuditLogs` | Microsoft Entra admin operations: Global Secure Access filtering and forwarding policies, profiles, remote networks, certificates, onboarding | Detect unauthorized configuration changes (see [Detect unauthorized configuration changes](#detect-unauthorized-configuration-changes)). **Note:** offboarding does **not** emit an audit log entry - the [Global Secure Access traffic heartbeat](#tenant-offboarding-and-forwarding-profile-disable-global-secure-access-traffic-heartbeat) detection covers that case. |
| Deployment logs | Status of Global Secure Access configuration propagations such as forwarding profile redistribution, remote network changes, and audit-log-setting updates | Confirm whether an authorized or unauthorized change deployed successfully across the service |
| `OfficeActivity` | Microsoft 365 audit events (Exchange, SharePoint, Teams). Join to `NetworkAccessTraffic` on `UniqueTokenId` to add user, device, and network context to Microsoft 365 activity. SharePoint is the only supported workload now. | Enabled via the Microsoft 365 Sentinel data connector - see [Enable enriched Microsoft 365 logs (optional)](/entra/global-secure-access/how-to-sentinel-integration#enable-enriched-microsoft-365-logs-optional). |
| `CommonSecurityLog` | Common Event Format (CEF)-formatted logs from branch CPE devices | Supplement `RemoteNetworkHealthLogs` with CPE-side IKE/IPsec events |

The Azure portal and Microsoft Sentinel offer several integration points for these data sources:

- [Microsoft Sentinel](/azure/sentinel/overview) - install the [**Global Secure Access** solution from the Sentinel Content hub](/azure/sentinel/sentinel-solutions-deploy) for prebuilt analytics rules, workbooks, and hunting queries that complement this guide.
- [Azure Monitor](/azure/azure-monitor/overview) - for workbook-based dashboards and alert rules over Log Analytics.
- [Azure Event Hubs](/azure/event-hubs/event-hubs-about) - to stream Global Secure Access logs to third-party security information and event management (SIEM) tools, such as Splunk, ArcSight, QRadar, and Sumo Logic.
- [Microsoft Entra Health](/entra/identity/monitoring-health/concept-microsoft-entra-health) - built-in tenant-level health signals for Remote Network tunnel and BGP connectivity. Use these signals before layering on custom Remote Network analytics.
- [Microsoft Security Copilot](/security-copilot/) - for cross-table investigation and natural-language triage.

> [!TIP]
> Start with the built-in signals Microsoft already emits: review **Global Secure Access** > **Monitor** > **Alerts**, **Deployment logs**, and the Remote Network scenarios in **Microsoft Entra Health** before enabling custom Sentinel analytics. The custom rules in this guide are meant to extend those signals, not replace them.

## Components of network access

The following components carry dedicated detections in this guide. Treat connector hosts, branch CPE devices, and TLS inspection certificates as Tier 0 assets - a compromise of any of them weakens enforcement across every Global Secure Access capability.

- **Microsoft Entra private network connector** - lightweight Windows service that initiates outbound connections to the Private Access service and carries user-to-app traffic over those established sessions, so the connector host doesn't require inbound ports. Monitor service state, host CPU/memory, and outbound destinations. For more information, see [Microsoft Entra private network connectors](/entra/global-secure-access/concept-connectors).
- **Global Secure Access client** - Windows, macOS, Android, and iOS endpoint agent that tunnels user traffic to Global Secure Access. Used by the [Private Access from nonmanaged device](#detection-queries) detection to confirm device join state. For more information, see [Global Secure Access clients](/entra/global-secure-access/concept-clients).
- **Remote Networks (Generic Routing Encapsulation (GRE) and IPsec tunnels)** - site-to-cloud tunnels that terminate branch traffic into Global Secure Access without per-device clients. Monitor tunnel up/down state, BGP session state, advertised route counts, and IKE authentication failures via `RemoteNetworkHealthLogs` and CPE syslog.
- **Branch customer-premises equipment (CPE)** - routers or firewalls that terminate the tunnel on the branch side. Treat as Tier 0; monitor firmware version, configuration changes, and IKE phase-1/phase-2 failures.
- **Traffic forwarding profiles** - Microsoft 365, Internet, and Private Access profiles that decide which traffic Global Secure Access acquires. Monitor profile enable/disable, deletion, and rule changes via `AuditLogs`, deployment logs, and the [Global Secure Access traffic heartbeat](#tenant-offboarding-and-forwarding-profile-disable-global-secure-access-traffic-heartbeat) detection.
- **Web content filtering policies and security profiles** - categories, custom rules, and bypass entries that gate Internet Access traffic. Monitor for unauthorized rule additions, overly broad allow entries, and security-profile detachments via the [Unauthorized policy or profile change](#unauthorized-policy-or-profile-change) detection.
- **TLS inspection policies and certificates** - enable content inspection for Internet Access and Generative AI scenarios. Monitor certificate creation, rotation, expiry, and bypass-list changes with the [TLS inspection certificate change](#tls-inspection-certificate-change) detection. An expired or removed inspection certificate disables content inspection tenant-wide.

## Define a baseline

Before tuning alert thresholds, establish a **30-day baseline** of normal activity for your environment. The thresholds in every alert table in this guide are starting values - replace them with values derived from your baseline.

Run the cross-cutting baseline during your first month and record the results in a workbook or spreadsheet. Each capability section also opens with a focused per-capability baseline that grounds the Critical and High alerts in that section.

### Cross-cutting baseline (all capabilities)

This single query captures the headline signals shared by every capability: session volume, block and failure ratios, user reach, bytes, **TLS inspection failure rate**, and **threat intelligence match volume**. A sustained increase in `TlsFailureRatePct` is itself a content-inspection signal - set an alert at 2x the 30-day mean.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(30d)
| extend TlsInspected = iif(isnotempty(TlsAction) and TlsAction != "Bypass", 1, 0)
| extend TlsFailed    = iif(isnotempty(TlsStatus) and TlsStatus != "Success" and TlsInspected == 1, 1, 0)
| extend ThreatHit    = iif(isnotempty(ThreatType), 1, 0)
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
> Rerun this baseline and the per-capability baselines after any of the following events: a [Global Secure Access service update](/entra/fundamentals/whats-new), a major policy change, a user-population growth event, or onboarding/offboarding a Remote Network. If you don't track service updates actively, **re-baseline at least once per quarter**. Stale baselines are the leading cause of false positives.

**Get notified of service changes automatically:**

- Subscribe to the [What's new in Microsoft Entra](/entra/fundamentals/whats-new) RSS feed for feature announcements and schema changes, which includes Global Secure Access-related topics.
- Configure [Azure Service Health alerts](/azure/service-health/alerts-activity-log-service-notifications-portal) for the **Global Secure Access** service to receive incident, planned-maintenance, and health-advisory notifications in your monitoring channel.
- For tenant-level admin announcements, monitor the [Microsoft 365 Message Center](/microsoft-365/admin/manage/message-center) filtered to Microsoft Entra and Global Secure Access.

## Private Access

The following detections focus on Private Access application segments, connector infrastructure, and user-to-application traffic patterns.

### Per-user activity baseline (Private Access)

Before enabling the Private Access alerts in this section, capture each user's typical Private Access activity over the last 30 days.

**Threshold baseline:** Derives the numbers you plug into the per-user thresholds in the detections that follow. Run it and record the P95 values. Use the **P95** values as your starting upper bound. If your P95 distinct-apps-per-user is 4, the lateral-movement threshold of `> 10` is reasonable. If it's 12, raise the alert threshold to reduce noise.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(30d)
| where TrafficType == "private"
| summarize
    DailySessions = count(),
    DailyDistinctApps = dcount(AppId),
    DailyUploadBytes = sum(SentBytes)
    by UserPrincipalName, bin(TimeGenerated, 1d)
| summarize
    P95_Sessions = percentile(DailySessions, 95),
    P95_DistinctApps = percentile(DailyDistinctApps, 95),
    P95_UploadMB = round(percentile(DailyUploadBytes, 95) / 1048576.0, 1)
```

**Top users:** Shows who drives the volume, so you can confirm the P95 isn't skewed by a single heavy account, often a service identity, before you trust it.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(30d)
| where TrafficType == "private"
| summarize
    Sessions = count(),
    DistinctApps = dcount(AppId),
    UploadMB = round(sum(SentBytes) / 1048576.0, 1),
    ActiveDays = dcount(bin(TimeGenerated, 1d))
    by UserPrincipalName
| top 20 by Sessions desc
```

### Alert summary

| What to monitor | Risk level | Where to look | Filter / Subfilter | Notes |
|---|---|---|---|---|
| Connector compromise indicators | Critical | Connector host telemetry (Defender for Endpoint or equivalent on the connector virtual machine (VM)) - not detectable from `NetworkAccessTraffic` alone | Connector host generates outbound traffic to destinations outside `*.msappproxy.net`, `*.servicebus.windows.net`, and known application backends | Investigation pattern - this guide does **not** ship a Sentinel rule because the signal lives on the connector host, not in Global Secure Access logs. Configure endpoint detection on the connector hosts and rely on the [**Global Secure Access** Content hub solution](/azure/sentinel/sentinel-solutions-deploy) for any prebuilt connector-aware rules. Hand off to [Microsoft Incident Response Playbooks](https://aka.ms/IRPlaybooks) on confirmed indicators. |
| Lateral movement via Private Access | High | `NetworkAccessTraffic` | Single user accesses > 10 distinct application segments within 15 minutes (see the lateral movement detection query that follows) | Validate with the application owner; if unauthorized, hand off to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1021. |
| Access from risky identity to private apps | High | `NetworkAccessTraffic` joined with `SigninLogs` | User with medium/high `RiskLevelDuringSignIn` successfully connects to Private Access apps | Use the [risky-user cross-signal query](#cross-signal-identity-and-network-correlation). Triage in Microsoft Entra ID Protection. |
| Private application access from a nonmanaged device | High | `NetworkAccessTraffic` joined with `NetworkAccessConnectionEvents` on `ConnectionId` | Successful Private Access session where `DeviceJoinType` is `unjoined` or empty | Verify with the device owner and endpoint team. If unsanctioned, hand off to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1078. **Validate `NetworkAccessConnectionEvents` column names with `NetworkAccessConnectionEvents &#124; take 10` before enabling.** |
| Off-hours private application access | Medium | `NetworkAccessTraffic` | Access to sensitive application segments outside business hours by a nonservice account | Review with application owner; verify authorized access. |
| Brute-force against private app | High | `SigninLogs` | > 50 failed sign-ins (`ResultType != 0`) to a Private Access app's Microsoft Entra application by one user within 5 minutes | Confirm against Microsoft Entra ID Protection risk. If a credential attack is confirmed, block the source identity and escalate to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1110. Microsoft Sentinel template: [Global Secure Access Content hub solution](/azure/sentinel/sentinel-solutions-deploy). |
| Unauthorized connector group change | High | `AuditLogs` | Connector reassigned to a different group by an actor outside the change-management allow list | Revert the change; investigate actor via the [audit log query](#detect-unauthorized-configuration-changes). |
| Unauthorized application segment change | High | `AuditLogs` | Application Proxy application updated - connector group reassignment, backend URL change, or other property modification by an actor outside the change-management allow list | Verify with the application owner; revert if unauthorized. MITRE T1562 / T1098. |

### Detection queries

Use the following queries as starting points. Validate table names, column names, thresholds, and allow lists in your tenant before you enable them as analytics rules.

#### Lateral movement - rapid multi-app access

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

- **Rule name:** Global Secure Access - Lateral movement via Private Access
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **Entities:** Account (UserPrincipalName)
- **MITRE ATT&CK:** Lateral Movement - T1021

#### Private Access from a nonmanaged device (joined detection)

This query joins `NetworkAccessTraffic` to `NetworkAccessConnectionEvents` on `ConnectionId` to add device context (OS, join type, applied security profile, point of presence (PoP) region) to a successful Private Access session.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(1h)
| where TrafficType == "private"
| where Action == "Allow"
| join kind=inner (
    NetworkAccessConnectionEvents
    | where TimeGenerated > ago(1h)
    | project ConnectionId, DeviceJoinType, DeviceOperatingSystem, ClientDeviceName, SecurityProfileName, SecurityPolicyName, PopProcessingRegion
) on ConnectionId
| where DeviceJoinType in ("unjoined", "") or isempty(DeviceJoinType)
| project TimeGenerated, UserPrincipalName, AppId, ClientDeviceName, DeviceOperatingSystem, DeviceJoinType, SecurityProfileName, SecurityPolicyName, PopProcessingRegion
| order by TimeGenerated desc
```

- **Rule name:** Global Secure Access - Private Access from nonmanaged device
- **Severity:** High
- **Query frequency:** Every 30 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Initial Access - T1078

#### Off-hours access to sensitive applications

Localize this query to your primary business timezone. `TimeGenerated` is UTC - a UTC `7–19` window doesn't match local working hours outside the UK during summer time. Set `tzOffsetHours` to the offset for your primary office. For tenants with multiple regions, run one variant per region or replace the offset with a per-user lookup.

Replace `<application-segment-id-N>` with the IDs of the application segments you classify as sensitive. Find them in the **Microsoft Entra admin center > Global Secure Access > Applications** - each application segment has an **Application ID** (GUID) shown on its overview page; copy that value into the `sensitiveApps` array.

```kusto
let tzOffsetHours = -5; // -5 EST, -8 PST, +1 CET, +9 JST, etc. - customize to your environment
let businessHoursStart = 7;
let businessHoursEnd = 19;
let sensitiveApps = dynamic(["<application-segment-id-1>", "<application-segment-id-2>"]); // Application IDs from Microsoft Entra admin center > Global Secure Access > Applications
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

#### Brute-force against a private application

> [!NOTE]
> Detect brute-force against private applications from `SigninLogs`. Scope `privateAppIds` to your Private Access apps' Microsoft Entra application IDs, found under **Microsoft Entra admin center** > **Global Secure Access** > **Applications**.

```kusto
let privateAppIds = dynamic(["<entra-app-id-1>", "<entra-app-id-2>"]); // application IDs of your Private Access apps
SigninLogs
| where TimeGenerated > ago(15m)
| where AppId in (privateAppIds)
| where ResultType != 0    // failed sign-in: for example, 50126 invalid credentials, 50053 lockout, 53003 blocked by Conditional Access
| summarize FailureCount = count(), FailureCodes = make_set(ResultType, 10)
    by UserPrincipalName, AppDisplayName, IPAddress, bin(TimeGenerated, 5m)
| where FailureCount > 50
| project TimeGenerated, UserPrincipalName, AppDisplayName, IPAddress, FailureCount, FailureCodes
| order by FailureCount desc
```

- **Rule name:** Global Secure Access - Private Access brute-force attempt (sign-in failures)
- **Severity:** High
- **Query frequency:** Every 5 minutes
- **Query period:** Last 15 minutes
- **Trigger:** Number of results > 0
- **Entities:** Account (UserPrincipalName), IP (IPAddress)
- **MITRE ATT&CK:** Credential Access - T1110

#### Unauthorized connector group change

> [!NOTE]
> The `OperationName` filter in this query uses a `has`-based match against the connector-group operations exposed in `AuditLogs`. Operation strings can change between service updates - validate against `AuditLogs | where OperationName has "connector" | distinct OperationName` in your tenant before enabling, and add any tenant-specific values to the filter.

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
| extend TargetId = tostring(TargetResources[0].id)
| extend ConnectorId = tostring(parse_json(tostring(parse_json(tostring(TargetResources[0].modifiedProperties))[0].newValue)))
| project TimeGenerated, OperationName, Actor, TargetId, ConnectorId, Result, ResultReason, CorrelationId
| order by TimeGenerated desc
```

- **Rule name:** Global Secure Access - Unauthorized connector group change
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **Entities:** Account (Actor)
- **MITRE ATT&CK:** Defense Evasion - T1562; Persistence - T1098

#### Unauthorized application segment change

This query detects modifications to Application Proxy applications that back Private Access application segments - for example, reassigning an application to a different connector group, changing a backend URL, or toggling security settings. These events appear in `AuditLogs` under `LoggedByService == "Application Proxy"` with `OperationName == "Update application"`.

```kusto
AuditLogs
| where TimeGenerated > ago(1h)
| where LoggedByService == "Application Proxy"
| where OperationName == "Update application"
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| extend AppName = tostring(TargetResources[0].displayName)
| extend AppObjectId = tostring(TargetResources[0].id)
| mv-expand ModifiedProperty = TargetResources[0].modifiedProperties
| extend PropertyName = tostring(ModifiedProperty.displayName)
| extend OldValue = tostring(ModifiedProperty.oldValue)
| extend NewValue = tostring(ModifiedProperty.newValue)
| project TimeGenerated, OperationName, Actor, AppName, AppObjectId, PropertyName, OldValue, NewValue, Result, CorrelationId
| order by TimeGenerated desc
```

- **Rule name:** Global Secure Access - Unauthorized application segment change
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **Entities:** Account (Actor)
- **MITRE ATT&CK:** Defense Evasion - T1562; Persistence - T1098

## Internet Access

The Internet Access detections build on the [cross-cutting baseline](#cross-cutting-baseline-all-capabilities), which breaks session, block, and upload volumes out by traffic type. Capture that baseline before tuning the thresholds in this section.

Start with the built-in alerts surfaced in **Global Secure Access** > **Monitor** > **Alerts**. If you enabled Netskope Advanced Threat Protection and DLP in Global Secure Access, `NetworkAccessAlerts` can also carry the built-in Netskope **Threat Protection**, **Data Loss Prevention**, and **Fallback** alerts described in the product documentation.

### Alert summary

| What to monitor | Risk level | Where to look | Filter / Subfilter | Notes |
|---|---|---|---|---|
| Malware or phishing URL detected | High | `NetworkAccessAlerts` and `NetworkAccessTraffic` | Global Secure Access threat intelligence detects an attempted connection to a known malicious URL (`ThreatType` is populated) | Check whether the payload was downloaded; coordinate with endpoint protection to scan the device. Hand off to [IR Playbooks](https://aka.ms/IRPlaybooks) on confirmed compromise. Microsoft Sentinel template: [Global Secure Access Content hub solution](/azure/sentinel/sentinel-solutions-deploy). |
| Netskope Threat Protection alert | High | `NetworkAccessAlerts` | Built-in Netskope alert type is **Threat Protection** | Requires Netskope Advanced Threat Protection (ATP) in Global Secure Access. Verify whether malicious content was downloaded, coordinate with the endpoint team, and hand off to [IR Playbooks](https://aka.ms/IRPlaybooks) on confirmed compromise. |
| Netskope Data Loss Prevention alert | High | `NetworkAccessAlerts` | Built-in Netskope alert type is **Data Loss Prevention** | Requires Netskope Data Loss Prevention (DLP) in Global Secure Access. Validate whether sensitive data left the tenant, engage the DLP owner, and escalate to [IR Playbooks](https://aka.ms/IRPlaybooks) if data exposure is confirmed. |
| Netskope Fallback alert | Medium | `NetworkAccessAlerts` | Built-in Netskope alert type is **Fallback** | Indicates traffic couldn't be fully inspected because of file size limits, scan timeout, or unsupported content. Review the affected destination and inspection gap, then decide whether to block, bypass intentionally, or tune the integration. |
| Data exfiltration - high upload volume | Critical | `NetworkAccessTraffic` | User uploads > 500 MB to any single destination within 1 hour | Add the destination to the web-filtering block list; engage your DLP team; escalate to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1041. |
| Web filtering policy change - unauthorized | High | `AuditLogs` | Web-filtering policy modified by an identity outside the change-management allow list | Revert change; investigate actor via the [audit log query](#detect-unauthorized-configuration-changes). |
| Repeated blocks from single user | Medium | `NetworkAccessTraffic` | One user triggers > 100 block actions across categories in 1 hour | Distinguish between misconfigured app and deliberate circumvention; review with the user's manager. |

### Detection queries

Use the following queries as starting points. Validate table names, column names, thresholds, and allow lists in your tenant before you enable them as analytics rules.

#### Threat intelligence blocks

> [!NOTE]
> `ThreatType` is populated only when Global Secure Access threat intelligence matches a destination. The column is empty for most traffic. If a lab or low-risk tenant returns zero results over 30 days, the query is wired correctly. Zero results don't mean that detection is broken.

```kusto
NetworkAccessTraffic
| where TimeGenerated > ago(15m)
| where TrafficType == "internet"
| where isnotempty(ThreatType)
| project UserPrincipalName, ThreatType , DestinationFqdn, DestinationUrl , DestinationIp, Action
```

#### Data exfiltration - high upload to uncommon domains

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

- **Rule name:** Global Secure Access - Potential data exfiltration via Internet Access
- **Severity:** Critical
- **Query frequency:** Every 30 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Exfiltration - T1041

#### Repeated blocks from a single user

This detection compares each user's current-hour block count against their own seven-day baseline rather than a single flat threshold. It fires at `5x` the user's P95 hourly block rate with a `100` blocks/hour floor. Per-user tuning suppresses the steady, benign noise that a misconfigured app or blocked content delivery network (CDN) generates for specific users. Run the query at the same one-hour cadence as its period so one sustained burst raises a single incident. For lower latency, shrink both the `lookback` and the period to 15 minutes and scale the floor down (for example, `25`) rather than overlapping a one-hour window every 15 minutes.

```kusto
let lookback = 1h;
let blockBaseline = NetworkAccessTraffic
    | where TimeGenerated between (ago(7d) .. ago(lookback))
    | where TrafficType == "internet"
    | where Action == "Block"
    | summarize HourlyBlocks = count() by UserPrincipalName, bin(TimeGenerated, 1h)
    | summarize P95HourlyBlocks = percentile(HourlyBlocks, 95) by UserPrincipalName;
NetworkAccessTraffic
| where TimeGenerated > ago(lookback)
| where TrafficType == "internet"
| where Action == "Block"
| summarize
    CurrentBlockCount = count(),
    Destinations = make_set(DestinationFqdn, 10)
    by UserPrincipalName
| join kind=leftouter blockBaseline on UserPrincipalName
| extend P95HourlyBlocks = coalesce(todouble(P95HourlyBlocks), 0.0)
| extend Threshold = max_of(P95HourlyBlocks * 5.0, 100.0)
| where CurrentBlockCount > Threshold
| project UserPrincipalName, CurrentBlockCount, P95HourlyBlocks, Threshold, Destinations
| order by CurrentBlockCount desc
```

- **Rule name:** Global Secure Access - Repeated Internet Access blocks from single user
- **Severity:** Medium
- **Query frequency:** Every 1 hour
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Defense Evasion - T1562

## Remote Networks

Lead with the built-in Remote Network signals before adding custom Kusto Query Language (KQL). Microsoft Entra Health exposes tenant-level scenarios for tunnel connectivity and BGP connectivity. Global Secure Access also emits the native **Unhealthy Remote Network** alert into `NetworkAccessAlerts` when hourly health checks detect disconnect conditions.

### Per-network health baseline (Remote Networks)

Ground the Remote Network detections by capturing typical tunnel and BGP behavior per site. Sites with healthy networks usually show `0` daily state changes. A single change over zero might already be alert-worthy.

**Use this baseline to set thresholds for:** tunnel flapping (`> 3 state changes / 15 min`), BGP anomaly (`> 50% route drop`), and branch traffic anomaly (`> 200% of seven-day average`).

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(30d)
| summarize
    DailyStateChanges = countif(Status in ("tunnelConnected", "tunnelDisconnected")),
    AvgAdvertisedRoutes = avg(BgpRoutesAdvertisedCount),
    MinAdvertisedRoutes = min(BgpRoutesAdvertisedCount),
    MaxAdvertisedRoutes = max(BgpRoutesAdvertisedCount),
    BgpResets = countif(Status == "bgpDisconnected")
    by RemoteNetworkId, bin(TimeGenerated, 1d)
| summarize
    P95_StateChanges = percentile(DailyStateChanges, 95),
    StableRouteCount = round(avg(AvgAdvertisedRoutes)),
    DailyBgpResets_P95 = percentile(BgpResets, 95)
    by RemoteNetworkId
```

> [!IMPORTANT]
> The detection queries in this section follow the canonical [`RemoteNetworkHealthLogs`](/azure/azure-monitor/reference/tables/remotenetworkhealthlogs) schema. The `Status` column carries both tunnel and BGP state with these values: `tunnelConnected`, `tunnelDisconnected`, `bgpConnected`, `bgpDisconnected`, `remoteNetworkAlive`, `packetDropped`, `unknownFutureValue`. BGP route counts are exposed as `BgpRoutesAdvertisedCount`. The table doesn't expose `RemoteNetworkName` - use `RemoteNetworkId` and join to a Graph-derived lookup if you need site names.

### Alert summary

| What to monitor | Risk level | Where to look | Filter / Subfilter | Notes |
|---|---|---|---|---|
| Remote Network health scenario alert | High | Microsoft Entra Health | Remote network tunnel connectivity or BGP connectivity scenario enters an unhealthy state | Use the Remote Network health scenario alert as the first built-in signal for branch outage triage. Confirm whether the impact is isolated to one site or systemic, then use the Global Secure Access logs to scope affected tunnels and routes. |
| Unhealthy Remote Network alert | High | `NetworkAccessAlerts` | Global Secure Access emits an `Unhealthy Remote Network` alert | Native Global Secure Access alert - primary tunnel-health signal. Engage branch network team. Hand off to [IR Playbooks](https://aka.ms/IRPlaybooks) only if compromise is suspected. |
| Tunnel flapping | High | `RemoteNetworkHealthLogs` | A remote network records > 3 tunnel state changes within 15 minutes | Verify CPE stability and PSK or certificate validity; investigate ISP and routing changes. |
| BGP session reset or route count drop | High | `RemoteNetworkHealthLogs` | `Status == "bgpDisconnected"`, or `BgpRoutesAdvertisedCount` drops > 50% from baseline | Verify CPE BGP configuration; confirm no unauthorized router replacement. |
| Unusual traffic volume from branch site | Medium | `NetworkAccessTraffic` | Traffic from a remote network exceeds 200% of seven-day average | Investigate for compromised devices on the branch network; contact the branch network team. |
| Repeated tunnel disconnects (IKE failure indicator) | High | `RemoteNetworkHealthLogs` | A remote network records > 5 `tunnelDisconnected` events within 1 hour | Verify preshared key or certificate validity on the CPE; check ISP connectivity. If brute-force is suspected, escalate to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1133. |
| IKE authentication failure spike (CPE-side, optional) | High | `CommonSecurityLog` | > 10 IKE Phase 1 authentication failures from a branch CPE within 5 minutes | Verify preshared key or certificate validity; if brute-force is confirmed, escalate to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1133. Available only when the CPE forwards CEF logs to Sentinel. |

### Detection queries

Use the following queries as starting points. Validate table names, column names, thresholds, and allow lists in your tenant before you enable them as analytics rules.

#### Tunnel flapping

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(15m)
| where Status in ("tunnelConnected", "tunnelDisconnected")
| summarize StateChanges = count(), FirstSeen = min(TimeGenerated), LastSeen = max(TimeGenerated)
    by RemoteNetworkId
| where StateChanges > 3
| project RemoteNetworkId, StateChanges, FirstSeen, LastSeen
```

- **Rule name:** Global Secure Access - Remote Network tunnel flapping
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 15 minutes
- **Trigger:** Number of results > 0

#### BGP session anomaly

```kusto
let routeBaseline = RemoteNetworkHealthLogs
    | where TimeGenerated between (ago(7d) .. ago(1d))
    | where isnotempty(BgpRoutesAdvertisedCount)
    | summarize AvgRoutes = avg(BgpRoutesAdvertisedCount) by RemoteNetworkId;
RemoteNetworkHealthLogs
| where TimeGenerated > ago(15m)
| where Status == "bgpDisconnected"
    or isnotempty(BgpRoutesAdvertisedCount)
| join kind=leftouter routeBaseline on RemoteNetworkId
| extend RouteDropRatio = iff(AvgRoutes > 0, 1.0 - (todouble(BgpRoutesAdvertisedCount) / AvgRoutes), 0.0)
| where Status == "bgpDisconnected" or RouteDropRatio > 0.5
| project TimeGenerated, RemoteNetworkId, Status, BgpRoutesAdvertisedCount, AvgRoutes, RouteDropRatio
```

- **Rule name:** Global Secure Access - Remote Network BGP session anomaly
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 15 minutes
- **Trigger:** Number of results > 0

#### Unusual traffic volume from branch

```kusto
let baseline = NetworkAccessTraffic
    | where TimeGenerated between (ago(7d) .. ago(1d))
    | where isnotempty(RemoteNetworkId)
    | summarize DailyBytes = sum(SentBytes + ReceivedBytes) by RemoteNetworkId, bin(TimeGenerated, 1d)
    | summarize AvgDailyBytes = avg(DailyBytes) by RemoteNetworkId;
NetworkAccessTraffic
| where TimeGenerated > ago(10d)
| where isnotempty(RemoteNetworkId)
| summarize TodayBytes = sum(SentBytes + ReceivedBytes) by RemoteNetworkId
| join kind=inner baseline on RemoteNetworkId
| where AvgDailyBytes > 0
| extend Ratio = todouble(TodayBytes) / todouble(AvgDailyBytes)
| where Ratio > 1
| project RemoteNetworkId, TodayBytesMB = TodayBytes / 1048576.0, AvgDailyBytesMB = AvgDailyBytes / 1048576.0, Ratio
| order by Ratio desc
```

#### Repeated tunnel disconnects (IKE failure indicator)

```kusto
RemoteNetworkHealthLogs
| where TimeGenerated > ago(24h)
| where Status !in ("remoteNetworkAlive", "bgpConnected", "tunnelConnected")
| summarize DisconnectCount = count(), FirstSeen = min(TimeGenerated), LastSeen = max(TimeGenerated)
    by RemoteNetworkId, SourceIp, DestinationIp, Status
| where DisconnectCount > 1
| project RemoteNetworkId, Status, SourceIp, DestinationIp, DisconnectCount, FirstSeen, LastSeen
```

- **Rule name:** Global Secure Access - Remote Network repeated tunnel disconnects
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Initial Access - T1133

#### IKE authentication failures (CPE-side, optional)

Use this query only when the branch CPE forwards CEF logs to Sentinel. Replace `<cpe-vendor>` and `<cpe-product>` with the CPE device's `DeviceVendor` and `DeviceProduct` values (for example, `"Fortinet"` and `"FortiGate"`). Otherwise, rely on the `RemoteNetworkHealthLogs` detection and the native `Unhealthy Remote Network` alert.

```kusto
CommonSecurityLog
| where TimeGenerated > ago(1h)
| where DeviceVendor == "<cpe-vendor>" and DeviceProduct == "<cpe-product>"
| where Activity has "IKE" and Activity has "fail"
| summarize FailCount = count() by SourceIP, DeviceName, bin(TimeGenerated, 5m)
| where FailCount > 10
| project TimeGenerated, SourceIP, DeviceName, FailCount
```

- **Rule name:** Global Secure Access - Remote Network IKE authentication failure spike (CPE-side)
- **Severity:** High
- **Query frequency:** Every 5 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **Prerequisites:** Branch CPE must forward CEF logs to Sentinel via a data connector
- **MITRE ATT&CK:** Initial Access - T1133

> [!NOTE]
> The `Unhealthy Remote Network` alert is a Remote Networks signal - baseline it under [Per-network health baseline (Remote Networks)](#per-network-health-baseline-remote-networks).


## Microsoft Traffic

The following detections focus on Microsoft 365 traffic routed through Global Secure Access and compliant-network enforcement.

### Microsoft Traffic baseline

Ground the Microsoft Traffic detections by capturing the typical volume of Global Secure Access-routed sign-ins, the country distribution of Microsoft 365 access, and the baseline rate of each native Global Secure Access alert.

**Use this baseline to set thresholds for:** compliant network bypass (`SigninLogs.IsThroughGlobalSecureAccess == "false"`), Microsoft 365 access from blocked geography, Increased External Tenant Activity, and Unhealthy Remote Network alert volumes.

Treat `Token / Device Inconsistency` separately from baseline-tuned detections: the expected baseline is zero, and any occurrence should be treated as Critical.

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
| extend NonCompliantPercent = round(100.0 * todouble(NonCompliantSignins) / TotalSignins, 2)
```

```kusto
NetworkAccessConnectionEvents
| where TimeGenerated > ago(30d)
| where TrafficType == "m365"
| summarize Sessions = count() by SourceIpCountryCode, bin(TimeGenerated, 1d), TrafficType
| order by Sessions desc
```

```kusto
NetworkAccessAlerts
| where TimeGenerated > ago(30d)
| where AlertType in ("DeviceTokenInconsistency", "CrossTenantAnomaly")
| summarize DailyAlerts = count() by AlertType, bin(TimeGenerated, 1d)
```

### Alert summary

| What to monitor | Risk level | Where to look | Filter / Subfilter | Notes |
|---|---|---|---|---|
| Compliant network bypass - successful sign-in | High | `SigninLogs` | Successful sign-in to a Microsoft 365 service where `IsThroughGlobalSecureAccess == "false"` | Review Conditional Access policies; verify compliant-network enforcement is active. MITRE T1562. Microsoft Sentinel template: [Global Secure Access Content hub solution](/azure/sentinel/sentinel-solutions-deploy). |
| Token / Device Inconsistency alert | Critical | `NetworkAccessAlerts` | Global Secure Access emits a `Token / Device Inconsistency` alert | High-fidelity token-theft signal. Pair with `SigninLogs.TokenIssuerType` and Microsoft Entra ID Protection. Hand off to [IR Playbooks](https://aka.ms/IRPlaybooks). MITRE T1528 / T1550. |
| Increased External Tenant Activity alert | High | `NetworkAccessAlerts` | Global Secure Access emits an `Increased External Tenant Activity` alert | Correlate with `SigninLogs` cross-tenant access events; review B2B and cross-tenant access settings. |
| Microsoft 365 access from blocked geography | High | `NetworkAccessConnectionEvents` joined with `NetworkAccessTraffic` | Source country in your blocked-country list (`CN`, `RU`, `KP`, `IR`, or your policy) | Review the user's full activity; review Conditional Access geographic block policies. |

### Detection queries

Use the following queries as starting points. Validate table names, column names, thresholds, and allow lists in your tenant before you enable them as analytics rules.

#### Compliant network bypass

This query detects successful sign-ins to Microsoft 365 services where the sign-in didn't originate through Global Secure Access. It filters with `AppDisplayName has_any` against substrings that match the family of Microsoft 365 service principals (`Office 365 Exchange Online`, `Office 365 SharePoint Online`, `Microsoft Teams`, `Microsoft Teams Services`, `Office 365 Shell WCSS-Client`, `OfficeHome`, `Outlook Mobile`, and so on). Substring matching on display names is intentionally broad. In practice, it catches more relevant sign-ins than filtering on a fixed list of first-party `AppId` globally unique identifiers (GUIDs), because Microsoft 365 traffic surfaces under many service-principal IDs that aren't centrally documented. You can also include other apps, such as custom applications or other SaaS apps, where Compliant Network access should be enforced.

Tune the substrings to your tenant - run a 30-day discovery query (`SigninLogs | where AppDisplayName has_any (...) | summarize by AppDisplayName`) before enabling the rule and remove any matches you don't want to monitor.

Zero results is the **healthy** state - it confirms every Microsoft 365 sign-in matching these substrings traversed Global Secure Access. Investigate any row that appears.

```kusto
// Substrings that match the Microsoft 365 service-principal display-name family.
// Tune to your tenant - add or remove tokens based on what your SigninLogs surface.
let protectedAppTokens = dynamic([
    "Exchange", "SharePoint", "Teams", "Office 365", "Outlook"
]);
SigninLogs
| where TimeGenerated > ago(1h)
| where ResultType == 0
| where AppDisplayName has_any (protectedAppTokens)
| where IsThroughGlobalSecureAccess == "false"
| project TimeGenerated, UserPrincipalName, AppDisplayName, AppId, IPAddress, Location, DeviceDetail
| order by TimeGenerated desc
```

- **Rule name:** Global Secure Access - Microsoft 365 access from noncompliant network
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Defense Evasion - T1562

#### Global Secure Access native alert: Token / Device Inconsistency

```kusto
NetworkAccessAlerts
| where TimeGenerated > ago(1h)
| where AlertType == "DeviceTokenInconsistency"
| project TimeGenerated, AlertType, DisplayName, Severity, Description
| order by TimeGenerated desc
```

- **Rule name:** Global Secure Access - Token / Device Inconsistency
- **Severity:** Critical
- **Query frequency:** Every 5 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Credential Access - T1528; Lateral Movement - T1550

#### Global Secure Access native alert: Increased External Tenant Activity

```kusto
NetworkAccessAlerts
| where TimeGenerated > ago(1h)
| where AlertType == "CrossTenantAnomaly"
| project TimeGenerated, AlertType, DisplayName, Severity, Description
| order by TimeGenerated desc
```

- **Rule name:** Global Secure Access - Increased External Tenant Activity
- **Severity:** High
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Initial Access - T1199 (Trusted Relationship)

#### Microsoft 365 access from blocked geography

```kusto
let blockedCountries = dynamic(["cn", "ru", "kp", "ir"]); // customize to your policy - must be lowercase
let lookback = 1h;
NetworkAccessConnectionEvents
| where TimeGenerated > ago(lookback)
| where TrafficType == "m365"
| where SourceIpCountryCode in (blockedCountries)
| project TimeGenerated, ConnectionId, UserPrincipalName, SourceIpCountryCode
| join kind=inner (
    NetworkAccessTraffic
    | where TimeGenerated > ago(lookback)
    | where TrafficType == "m365"
    | project ConnectionId, DestinationFqdn, Action
) on ConnectionId
| project TimeGenerated, UserPrincipalName, SourceIpCountryCode, DestinationFqdn, Action
| order by TimeGenerated desc
```

## Generative AI and MCP

The following detections focus on generative AI usage, Model Context Protocol (MCP) activity, and AI prompt telemetry from Global Secure Access.

### Generative AI baseline (Preview)

Ground the Generative AI detections by capturing typical organization-wide and per-user prompt volume. Use the **P99** per-user daily prompt count as the high end of legitimate usage, then set the **anomalous prompt volume** alert above that level. A threshold higher than `5x` the **P95** is a reasonable starting point for a tuned rule in many environments. For percentile terminology, see [percentile(), percentiles()](/kusto/query/percentiles-aggregation-function?view=microsoft-fabric&preserve-view=true#nearest-rank-percentile).

**Use this baseline to set thresholds for:** Shadow AI usage, unsanctioned MCP server access, anomalous prompt volume per user.

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
> The `NetworkAccessGenerativeAIInsights` table is in **Preview**. Schema, column names, and operation values can change. **Validate the queries in this section against `NetworkAccessGenerativeAIInsights | take 10` in your tenant before enabling them as Sentinel analytics rules.** Treat these queries as a starting template, not a tested production ruleset.
>
> The published table reference exposes `DestinationUrl` and dedicated `McpClientName` / `McpServerName` columns. The queries in this section use those column names. If you need to group by host instead of full URL, derive an FQDN with `parse_url(DestinationUrl).Host`.

### Alert summary

| What to monitor | Risk level | Where to look | Filter / Subfilter | Notes |
|---|---|---|---|---|
| Shadow AI - unsanctioned AI tool usage | Medium | `NetworkAccessGenerativeAIInsights` and `NetworkAccessTraffic` | User accesses an AI service that may not align with organizational policy. | Review with the user's manager; consider adding the service to the web filtering allow or block list. |
| Unsanctioned MCP server access | High | `NetworkAccessGenerativeAIInsights` | MCP client connects to an MCP server FQDN not in the approved-server list | Block the destination via web filtering; review the user's other AI activity. |
| AI usage by risky user | High | `NetworkAccessGenerativeAIInsights` joined with `SigninLogs` | User with `RiskLevelDuringSignIn` of medium or high generates AI prompts | Recommended path: block the AI service via a **Global Secure Access Internet Access web filtering rule** targeting the AI service FQDN - fastest to apply, scoped to Global Secure Access-enrolled devices, no app-registration prerequisite. As a backup for unmanaged devices, add a **Conditional Access policy** that blocks the AI app's enterprise app registration for medium/high risk users. Triage in Microsoft Entra ID Protection. |
| Anomalous prompt volume per user | Medium | `NetworkAccessGenerativeAIInsights` | One user issues > 500 prompts in 1 hour, or more than 5x the seven-day per-user average | Verify legitimate use; investigate for automation, scraping, or compromised credentials. |

### Detection queries

Use the following queries as starting points. Validate table names, column names, thresholds, and allow lists in your tenant before you enable them as analytics rules.

#### Shadow AI usage

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

#### Unsanctioned MCP server access

```kusto
let approvedMcpServers = dynamic(["mcp.contoso.com"]); // customize to your policy
NetworkAccessGenerativeAIInsights
| where TimeGenerated > ago(1h)
| where isnotempty(McpServerName)
| where McpServerName !in (approvedMcpServers)
| project TimeGenerated, UserPrincipalName, McpClientName, McpServerName, DestinationUrl, Activity, SubActivity
| order by TimeGenerated desc
```

#### AI usage by risky user

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

#### Anomalous prompt volume per user

This detection grounds the threshold in two tenant-derived baselines instead of a hardcoded number, matching the [Generative AI baseline](#generative-ai-baseline-preview) guidance. It fires only when a user's current hour exceeds both `5x` their own P95 hourly prompt rate and the tenant-wide P99 hourly floor. The rule self-calibrates as adoption grows and needs no external benchmark. Both baselines use active-hour bins (idle hours produce no rows), describing typical volume *while prompting*. In a small or newly onboarded tenant, the P99 floor can be low. Raise it with `max_of(orgFloor, <minimum>)` if it produces noise, and run the query at the same one-hour cadence as its period to avoid refiring the same hour.

```kusto
let lookback = 1h;
let promptBaseline = NetworkAccessGenerativeAIInsights
    | where TimeGenerated between (ago(7d) .. ago(lookback))
    | where Activity == "Prompt"
    | summarize HourlyPromptCount = count() by UserPrincipalName, bin(TimeGenerated, 1h)
    | summarize P95HourlyPrompts = percentile(HourlyPromptCount, 95) by UserPrincipalName;
let orgFloor = toscalar(
    NetworkAccessGenerativeAIInsights
    | where TimeGenerated between (ago(7d) .. ago(lookback))
    | where Activity == "Prompt"
    | summarize HourlyPromptCount = count() by UserPrincipalName, bin(TimeGenerated, 1h)
    | summarize P99 = percentile(HourlyPromptCount, 99)
    | project coalesce(todouble(P99), 0.0));
NetworkAccessGenerativeAIInsights
| where TimeGenerated > ago(lookback)
| where Activity == "Prompt"
| summarize CurrentPromptCount = count() by UserPrincipalName
| join kind=leftouter promptBaseline on UserPrincipalName
| extend P95HourlyPrompts = coalesce(todouble(P95HourlyPrompts), 0.0)
| extend OrgFloor = orgFloor
| extend Threshold = max_of(P95HourlyPrompts * 5.0, OrgFloor)
| where CurrentPromptCount > Threshold
| project UserPrincipalName, CurrentPromptCount, P95HourlyPrompts, OrgFloor, Threshold
| order by CurrentPromptCount desc
```

- **Rule name:** Global Secure Access - Anomalous generative AI prompt volume per user
- **Severity:** Medium
- **Query frequency:** Every 1 hour
- **Query period:** Last 1 hour
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Collection - T1119

#### Enrich generative AI prompts with traffic context (via `TransactionId`)

Global Secure Access stamps the same `TransactionId` on the `NetworkAccessGenerativeAIInsights` row and its corresponding `NetworkAccessTraffic` row. Joining the two tables adds the prompt-policy verdict (`Action`, `ResponseCode`), TLS inspection result, cloud-app metadata, and originating process to each prompt - context not present in the generative AI insights table alone. A row where the prompt `Content` is populated and the joined `Action == "Block"` with `ResponseCode == 403` is a confirmed prompt-policy block.

> [!NOTE]
> `Activity` values in `NetworkAccessGenerativeAIInsights` are **case-sensitive** and title-cased (`"Prompt"`, `"Mcp"`), even though the raw transaction JSON shows them lowercase. Validate the join in your tenant before promoting to a Sentinel rule. The raw JSON also exposes a `policyRuleName` field, but the Log Analytics schema only surfaces `PolicyRuleId` - use `PolicyName` for triage and `PolicyRuleId` to correlate to a specific rule via Graph.

```kusto
NetworkAccessGenerativeAIInsights
| where TimeGenerated > ago(24h)
| where Activity == "Prompt"
| where isnotempty(Content)
| project TimeGenerated, TransactionId, UserPrincipalName, DestinationUrl, PromptContent = Content
| join kind=inner (
    NetworkAccessTraffic
    | where TimeGenerated > ago(24h)
    | project TransactionId, Action, ResponseCode, PolicyName, PolicyRuleId, TlsAction, TlsStatus, TlsPolicyName, TlsRuleName, CloudAppName, InitiatingProcessName, DeviceOperatingSystem
) on TransactionId
| project TimeGenerated, UserPrincipalName, DestinationUrl, PromptContent, Action, ResponseCode, PolicyName, PolicyRuleId, TlsAction, TlsStatus, TlsPolicyName, TlsRuleName, CloudAppName, InitiatingProcessName, DeviceOperatingSystem
| order by TimeGenerated desc
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

### Sign-in outside the Global Secure Access path for a Global Secure Access-enforced user

This pattern detects a user who normally has Global Secure Access traffic but signed in successfully **without** going through Global Secure Access - a real bypass scenario. The seed list is users who generated Global Secure Access traffic in the last 24 hours, used as a proxy for "this user is supposed to be on Global Secure Access." Tighten the seed list with your own group membership when available.

```kusto
let gsaEnforcedUsers = NetworkAccessTraffic
    | where TimeGenerated > ago(24h)
    | where isnotempty(UserPrincipalName)
    | distinct UserPrincipalName;
SigninLogs
| where TimeGenerated > ago(1h)
| where ResultType == 0
| where IsThroughGlobalSecureAccess == "false"
| where UserPrincipalName in~ (gsaEnforcedUsers)
| project TimeGenerated, UserPrincipalName, AppDisplayName, IPAddress, Location, DeviceDetail
| order by TimeGenerated desc
```

> [!TIP]
> Use [Microsoft Security Copilot](/security-copilot/) to correlate cross-signal findings at scale. Prompt example: *"For users who were denied by Global Secure Access Private Access in the last 24 hours, summarize their identity risk signals and any successful sign-ins from different IP addresses."*

## Detect unauthorized configuration changes

Configuration changes to Global Secure Access policies outside your change management process are a high-priority detection. The queries in this section filter `AuditLogs` on the Global Secure Access `OperationName` values listed in the [Microsoft Entra audit activities reference](/entra/identity/monitoring-health/reference-audit-activities#global-secure-access). Pair `AuditLogs` with **Global Secure Access** > **Monitor** > **Deployment logs** so you can tell whether a change merely started or failed during propagation.

### Audit operations baseline

Before enabling the rules in this section, capture which Global Secure Access operations occur in your tenant, who performs them, and at what frequency. Use the result to seed the **authorized actor allow list** that every detection in this section filters against.

```kusto
AuditLogs
| where TimeGenerated > ago(30d)
| where OperationName has_any (
    "Filtering Policy", "Forwarding Policy", "Forwarding Profile", "Forwarding Rule",
    "Remote Network", "Private Access Policy", "Security Provider",
    "Adaptive Access Policy")
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| summarize Operations = count() by OperationName, Actor, bin(TimeGenerated, 1d)
| order by Operations desc
```

> [!IMPORTANT]
> Run each rule as a hunting query for at least seven days, confirm rows return for known-good admin actions, and adjust `OperationName` strings or filter on `LoggedByService == "Global Secure Access"` if your tenant emits a different value. Revalidate after every Global Secure Access service update.

### Deployment failure after a configuration change

Use deployment logs whenever a Global Secure Access policy-change alert fires. Deployment logs capture the status of forwarding-profile redistributions, remote network changes, audit-log-settings updates, and related configuration pushes that `AuditLogs` don't confirm on their own.

1. Go to **Global Secure Access** > **Monitor** > **Deployment logs**.
2. Filter **Status** to failed deployments and review activities such as **Remote network**, **Forwarding profile**, **Audit Logs Settings**, and **IP Forwarding Options**.
3. Correlate the failed deployment timestamp with the `AuditLogs` actor and `CorrelationId` from the alerting query.

What to do next: If the change was unauthorized, revert it through your approved process and hand off to [IR Playbooks](https://aka.ms/IRPlaybooks). If the change was authorized but the deployment failed, route the incident to the platform owner. Keep the originating alert open until deployment succeeds.

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

- **Rule name:** Global Secure Access - Unauthorized network access configuration change
- **Severity:** High
- **Query frequency:** Every 60 minutes
- **Query period:** Last 24 hours
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Defense Evasion - T1562.001

### Remote Network configuration change summary

The [Unauthorized policy or profile change](#unauthorized-policy-or-profile-change) rule alerts when an unauthorized actor changes any known Global Secure Access operation. This companion hunting query narrows the view to remote networks: every `Create / Update / Delete Remote Network` and device-link edit in the lookback window, grouped by operation, with one `TargetResources` sample per operation so you can read what changed without expanding `modifiedProperties` query-side. Use it as a daily or shift-handover review of remote-network hygiene, or as a hunting starting point when the per-change rule fires on a remote-network operation.

```kusto
AuditLogs
| where TimeGenerated > ago(1d)
| where Category == "RemoteNetworkManagement"
| summarize Count = count(), Sample = take_any(TargetResources) by OperationName
| order by OperationName asc
```

The `Sample` column returns one raw `TargetResources` JSON per operation. Select it in Log Analytics to inspect `modifiedProperties`, `displayName`, `id`, and `type`, including the `DeviceLink` target entries that record device-link adds and deletes inside `Update Remote Network`.

- **Rule name:** Global Secure Access - Remote Network configuration change summary (hunting)
- **Severity:** Informational (hunting query). Promote to a Medium analytics rule only if you scope it further, for example, `| where Count > <baseline>` or join against an approved-actor watchlist.
- **Query frequency:** On demand, or scheduled daily at shift handover
- **Query period:** Last 24 hours
- **MITRE ATT&CK:** Initial Access - T1133 (when the change re-points a tunnel); Defense Evasion - T1562 (when the change disables or weakens the remote network)

What to do next: Review each row against the matching change ticket. When the `Sample` payload shows a device-link IP, peer, or BGP change, or a remote-network delete, confirm in **Global Secure Access** > **Connect** > **Remote networks**. If unauthorized, revert through your approved process and hand off to [IR Playbooks](https://aka.ms/IRPlaybooks).

### Tenant offboarding and forwarding-profile disable (Global Secure Access traffic heartbeat)

Global Secure Access audit logs capture admin-intent operations for **onboarding only** - `Offboarding Process Started` doesn't appear in `AuditLogs`. Detecting offboarding by querying for that operation name is therefore impossible. Instead, detect the **observable consequence** of Global Secure Access being disabled: traffic stops flowing through the service.

This runtime heartbeat also catches:

- A forwarding profile being disabled or deleted. The per-capability detections in [Internet Access](how-to-operate-internet-access.md#alerting-and-monitoring) and [Microsoft Traffic](how-to-operate-microsoft-traffic.md#alerting-and-monitoring) cover the audit-log side. The Global Secure Access traffic heartbeat catches the *outcome* even when no audit row appears.
- Diagnostic settings being removed (log shipping itself broken).
- Broad Global Secure Access platform outage.
- Network connectivity loss between tenant and Global Secure Access PoPs.

Pair this detection with the [Zero Trust Assessment](/security/zero-trust/assessment/overview) configuration-posture check **"Network traffic is routed through Global Secure Access for security policy enforcement"** (assessment ID 25381) and the built-in [Microsoft Entra Health](/entra/identity/monitoring-health/concept-microsoft-entra-health) signals.

- **Rule name:** Global Secure Access - Traffic heartbeat (anti-tamper)
- **Severity:** Drive Sentinel incident severity from the `Severity` column emitted by the query (Critical / High / Medium).
- **Query frequency:** Every 15 minutes
- **Query period:** Last 1 hour (with seven-day rolling baseline)
- **Trigger:** Number of results > 0
- **MITRE ATT&CK:** Impact - T1531 (Account Access Removal at scale); Defense Evasion - T1562 (Impair Defenses)

```kusto
// Global Secure Access traffic heartbeat - alerts when current-hour volume falls below a fraction
// of the seven-day rolling baseline, bucketed into Critical/High/Medium severity.
let baselineWindow      = 168h;  // seven days
let lookback            = 1h;    // current evaluation window
let minBaselineSamples  = 24;    // need at least 1 day of baseline before alerting
let criticalRatio       = 0.10;  // < 10% of baseline → Critical
let highRatio           = 0.25;  // 10–25% of baseline → High
let mediumRatio         = 0.50;  // 25–50% of baseline → Medium (early warning)
let recent = NetworkAccessTraffic
    | where TimeGenerated > ago(lookback)
    | summarize RecentRows = count();
let baseline = NetworkAccessTraffic
    | where TimeGenerated between (ago(baselineWindow + lookback) .. ago(lookback))
    | summarize BaselineRows = count(), Samples = dcount(bin(TimeGenerated, 1h));
recent
| extend joinKey = 1
| join kind=inner (baseline | extend joinKey = 1) on joinKey
| project-away joinKey, joinKey1
| where Samples >= minBaselineSamples
| extend ExpectedRowsPerHour = todouble(BaselineRows) / Samples
| extend DropRatioPct = round(100.0 * todouble(RecentRows) / ExpectedRowsPerHour, 1)
| where DropRatioPct < (mediumRatio * 100.0)
| extend Severity = case(
        RecentRows == 0,                            "Critical (no traffic)",
        DropRatioPct < (criticalRatio * 100.0),     "Critical",
        DropRatioPct < (highRatio * 100.0),         "High",
        "Medium")
| project Severity, DropRatioPct, RecentRows, ExpectedRowsPerHour = toint(ExpectedRowsPerHour), BaselineSamples = Samples, BaselineRows
```

**Reading the output:**

| Column | Meaning |
|---|---|
| `Severity` | Autoclassified verdict - `Critical (no traffic)`, `Critical`, `High`, or `Medium`. Drives Sentinel incident severity. |
| `DropRatioPct` | Current volume as a percentage of the expected hourly baseline. A value of `18.5` means the last hour saw ~18.5% of typical traffic. |
| `RecentRows` | Row count in `NetworkAccessTraffic` for the last `lookback` window (default 1 h). |
| `ExpectedRowsPerHour` | `BaselineRows / BaselineSamples` - the mean per active hour from the rolling baseline. |
| `BaselineSamples` | Distinct hourly bins with data in the baseline window. Healthy production tenants show 100–168 over seven days. Values lower than `minBaselineSamples` (default 24) suppress the alert entirely - the baseline is too thin to be reliable. |
| `BaselineRows` | Total rows in the seven-day baseline window - provides context for whether the mean is built on enough data. |

> [!IMPORTANT]
> Suppress this rule during planned maintenance windows. A scheduled change that intentionally drains traffic (for example, a forwarding profile reassignment during a remediation) triggers the alert otherwise. Use a Sentinel **automation rule** keyed off your change-management calendar, or expand the `baselineWindow` so a single quiet maintenance hour doesn't move the mean.

**Cross-checking with Zero Trust Assessment:** pair with [Zero Trust Assessment](/entra/fundamentals/zero-trust-protect-networks#network-traffic-is-routed-through-global-secure-access-for-security-policy-enforcement) (*Network traffic is routed through Global Secure Access for security policy enforcement*).

What to do next: confirm the current state in **Global Secure Access** > **Connect** > **Traffic forwarding** and **Global Secure Access** > **Settings** > **Diagnostic settings**. If a forwarding profile is disabled, re-enable it and hand off the audit-log review to [IR Playbooks](https://aka.ms/IRPlaybooks). If diagnostic settings were removed, restore them and treat the missing log shipping as the lead indicator of a tamper attempt.

### TLS inspection certificate change

`Create Certificate`, `Update Certificate`, and `Delete Certificate` under the Global Secure Access service correspond to TLS inspection certificate operations. Pair this detection with the [TLS inspection certificate lifecycle](how-to-operate-internet-access.md#tls-inspection-certificate-lifecycle) procedure so SOC and network operations teams see the same signal.

```kusto
AuditLogs
| where TimeGenerated > ago(24h)
| where OperationName in ("Create Certificate", "Update Certificate", "Delete Certificate")
| where Category == "Certificate"
// The following filter narrows results to certificate operations from Global Secure Access.
// If your tenant emits a different LoggedByService value, replace the value in the following line
// (do not remove the filter - "Certificate" alone covers other Microsoft Entra certificate operations).
| where LoggedByService == "Global Secure Access"
| extend Actor = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, Actor, OperationName, Result
```

- **Rule name:** Global Secure Access - TLS inspection certificate operation
- **Severity:** High
- **Query frequency:** Every 60 minutes
- **Query period:** Last 24 hours
- **Trigger:** Number of results > 0

> [!IMPORTANT]
> Maintain an **allow list** of identities authorized to make Global Secure Access configuration changes. Filter every query in this article to exclude authorized actors so each rule only fires for unexpected changes.

## Alert tuning cadence

| Action | Cadence | Owner |
|---|---|---|
| Review false positive rate for each analytics rule | Weekly | SOC analyst |
| Adjust thresholds based on baseline trends | Monthly | SOC analyst + Network Security Engineer |
| Rerun capacity baselines | Quarterly, or after any Global Secure Access service update | SOC analyst + Network Security Engineer |
| Review and update the authorized change actor allow list | After every role-based access control change | Network Security Engineer |
| Evaluate new MITRE ATT&CK techniques relevant to network access | Quarterly | SOC analyst |

## Related content

- [Microsoft Incident Response Playbooks](https://aka.ms/IRPlaybooks)
- [Microsoft Entra Security Operations Guide](https://aka.ms/AzureADSecOps)
- [Enhance threat detection with Global Secure Access in Microsoft Sentinel](/entra/global-secure-access/how-to-sentinel-integration)
- [Common operations for Microsoft Entra Global Secure Access](how-to-operations-common.md)
- [Global Secure Access PowerShell samples](powershell-samples.md)

## Next steps

See these companion articles in the Microsoft Entra security operations guide series:

- [Security operations for user accounts](/entra/architecture/security-operations-user-accounts)
- [Security operations for privileged accounts](/entra/architecture/security-operations-privileged-accounts)
- [Security operations for applications](/entra/architecture/security-operations-applications)
- [Security operations for devices](/entra/architecture/security-operations-devices)
- [Security operations for infrastructure](/entra/architecture/security-operations-infrastructure)

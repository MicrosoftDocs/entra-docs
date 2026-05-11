---
title: Operate Microsoft Entra Global Secure Access Microsoft traffic profile
description: "Post-deployment operations guide for the Microsoft traffic profile in Global Secure Access, covering alerting, health checks, Microsoft 365 traffic optimization, and automation."
ms.topic: how-to
ms.date: 05/04/2026
ms.reviewer: jebley
ai-usage: ai-assisted
---

# Operate Microsoft Entra Global Secure Access Microsoft traffic profile

This guide covers day-to-day operations for the Microsoft traffic profile in Global Secure Access. The Microsoft traffic profile routes Microsoft 365 and other Microsoft service traffic through the Global Secure Access infrastructure, enabling security controls and optimized routing for Microsoft cloud services.

For initial deployment and configuration, see the [Global Secure Access deployment guide](/entra/architecture/gsa-deployment-guide-intro). For shared operational topics (roles, change management, metrics framework), see the [Common operations guide](how-to-operations-common.md). This article uses *GSA* as the abbreviation for Global Secure Access.

Use the role assignments in this guide to identify the primary owner for each task. Role definitions live in the [Common operations guide](how-to-operations-common.md#roles-and-responsibilities). If your operating model uses different role names, map them to the ones used here.

## Alerting and monitoring

This section is organized in the order you should implement monitoring for Microsoft traffic: 1. Review the critical alerts and the required operator response.
2. Use the Kusto Query Language (KQL) queries to create the detections.
3. Follow the automation steps to enable Sentinel-driven notification and response workflows.

> [!IMPORTANT]
> In the first 30 days after deployment, use the [Microsoft traffic volume—daily trend](#kql-queries---non-critical) query to establish a normal traffic baseline before finalizing alert thresholds. The 50-user CA failure threshold in the Conditional Access failure KQL query is a starting point—calibrate it to your organization's actual sign-in volume.

### Critical alerts to configure

| Alert | Condition | Role | What to do next |
| --- | --- | --- | --- |
| Conditional Access policy failure for Microsoft traffic | Conditional Access policy applied to Microsoft traffic is blocking more users than expected | Identity Engineer / Identity Team | 1. Review the Conditional Access policy evaluation in Entra sign-in logs. 2. Check if a recent policy change is causing overblocking. 3. Validate device compliance status for affected users. |
| Audit log: traffic forwarding rule change | A traffic forwarding rule for Microsoft traffic is modified | Network Security Engineer | 1. Verify the change was approved through change management. 2. Confirm the modified rule still includes all required Microsoft 365 service endpoints. 3. Monitor for user-reported issues after the change. |
| Microsoft traffic profile disabled | The Microsoft traffic forwarding profile is disabled | Network Security Engineer | Microsoft 365 traffic is no longer routed through GSA. 1. Re-enable the profile in **Global Secure Access** > **Connect** > **Traffic forwarding**. 2. Check audit logs to identify who disabled it. 3. Verify Microsoft 365 connectivity is restored for users. |
| Conditional Access Signaling disabled | The CA Signaling setting in Global Secure Access is turned off, preventing GSA from providing network location signals to Conditional Access | Identity Engineer / Identity Team | Compliant network Conditional Access policies stop enforcing. 1. Re-enable CA Signaling in **Global Secure Access** > **Settings** > **Session management** > **Adaptive access**. 2. Check audit logs to identify who disabled it. 3. Verify compliant network location signals are appearing in sign-in logs before closing the incident. |
| Universal Tenant Restrictions disabled | The Universal Tenant Restrictions policy is turned off | Identity Engineer / Identity Team | **This is only applicable for organizations using Tenant Restrictions.** External tenant access controls are no longer enforced—users may be able to sign into unauthorized external tenants. 1. Re-enable Universal Tenant Restrictions in **Global Secure Access** > **Settings** > **Session management** > **Universal tenant restrictions**. 2. Check audit logs to identify who disabled it. 3. Review sign-in logs for any external tenant sign-ins that occurred during the gap. |


> [!TIP]
> The Microsoft traffic profile is unique because it handles traffic for services your organization already depends on daily (Teams, Exchange, SharePoint). Any disruption has immediate, visible user impact. Prioritize fast detection and response for this profile.

### KQL queries - Critical Alerts

The following queries implement detection for each [critical alert](#critical-alerts-to-configure). Deploy these queries as Microsoft Sentinel analytics rules.

> [!NOTE]
> The short time windows in these queries (`ago(5m)`, `ago(15m)`) are designed for Sentinel analytics rules, where the rule runs on a matching schedule and looks back exactly that window—giving continuous, nonoverlapping coverage. If you run these queries manually in Log Analytics, extend the window to `ago(24h)` or longer to see historical results.

**Alert: Conditional Access policy failure for Microsoft traffic**

Detects a spike in sign-in failures caused specifically by CA policies that have **Block** as the grant control and **exclude all compliant network locations**. When the affected user count exceeds your configured threshold, it indicates the compliant network signal is missing or not propagating correctly. Set the threshold to a value appropriate for your organization's sign-in volume.

> [!NOTE]
> `SigninLogs` contains per-sign-in evaluation results, not policy definitions. Named location exclusions (condition B) are part of the policy configuration in Entra ID and aren't stored in the log. Populate `TargetPolicyIds` with the identifiers (IDs) of your Block + compliant-network-excluding CA policies. Retrieve them from **Entra admin center** > **Entra ID** > **Conditional Access** > **Policies** > Select a policy > **View policy information**, or via Graph API: `GET https://graph.microsoft.com/v1.0/policies/conditionalAccessPolicies`.

```kql
// IDs of CA policies with Block grant control that exclude all compliant network locations.
// Retrieve from Entra admin center > Protection > Conditional Access, or via Graph API.
let TargetPolicyIds = dynamic([
    "<policy-id-1>",
    "<policy-id-2>"
]);
SigninLogs
| where TimeGenerated > ago(15m)
| where ConditionalAccessStatus == "failure"
| mv-expand Policy = ConditionalAccessPolicies
| where Policy.result == "failure"
| where tostring(Policy.id) in (TargetPolicyIds)
| summarize
    FailureCount = count(),
    AffectedUsers = dcount(UserPrincipalName),
    BlockingPolicies = make_set(tostring(Policy.displayName)),
    BlockedApps = make_set(ResourceDisplayName)
    by bin(TimeGenerated, 5m)
| where AffectedUsers > 50  // Replace 50 with a threshold appropriate for your organization
| project TimeGenerated, AffectedUsers, FailureCount, BlockedApps, BlockingPolicies
| order by TimeGenerated desc
```

**Alert: Traffic forwarding rule change**

Detects any modification to traffic forwarding policies or rules in the Microsoft traffic profile. A single admin action generates multiple audit entries—one per affected rule plus one per affected policy. This query expands all target resources and summarizes by operation to correctly identify which M365 service areas were affected. Every result requires change management verification.

```kql
AuditLogs
| where TimeGenerated > ago(5m)
| where LoggedByService == "Global Secure Access"
| where Category == "ForwardingPolicyManagement"
| where OperationName has_any (
    "Update Forwarding Profile",
    "Update Forwarding Policy",
    "Add Forwarding Policy",
    "Delete Forwarding Policy"
    )
| extend InitiatedByUser = tostring(InitiatedBy.user.userPrincipalName)
// Expand all target resources — a single operation generates one entry per affected rule
// plus one per affected policy. Filter on M365 service names to identify which services changed.
| mv-expand Resource = TargetResources
| extend ResourceName = tostring(Resource.displayName)
| where ResourceName has_any (
    "Exchange Online",
    "SharePoint",
    "OneDrive",
    "Teams",
    "Skype for Business",
    "Microsoft 365 Common",
    "Office Online",
    "M365"
    )
| summarize
    AffectedResources = make_set(ResourceName),
    ChangeCount = count()
    by bin(TimeGenerated, 1m), OperationName, InitiatedByUser, Result
| project TimeGenerated, OperationName, InitiatedByUser, AffectedResources, ChangeCount, Result
| order by TimeGenerated desc
```

**Alert: Microsoft traffic profile disabled**

Detects when the Microsoft traffic forwarding profile is disabled. Any result is a Critical incident—Microsoft 365 traffic is no longer routed through GSA.

> [!NOTE]
> GSA audit logs don't populate `modifiedProperties` for profile state changes. This query alerts on any forwarding profile update or deletion operation. When it fires, verify the current profile state in **Global Secure Access** > **Connect** > **Traffic forwarding**.

```kql
AuditLogs
| where TimeGenerated > ago(5m)
| where LoggedByService == "Global Secure Access"
| where Category == "ForwardingPolicyManagement"
| where OperationName has_any (
    "Update Forwarding Profile",
    "Delete Forwarding Profile"
    )
| extend InitiatedByUser = tostring(InitiatedBy.user.userPrincipalName)
| extend TargetResource = tostring(TargetResources[0].displayName)
| where TargetResource == "Microsoft 365 traffic forwarding profile"
| project TimeGenerated, OperationName, InitiatedByUser, TargetResource, Result
| order by TimeGenerated desc
```

**Alert: Conditional Access Signaling disabled**

Detects when the CA Signaling (Adaptive Access) setting is turned off in Global Secure Access. Any result is a Critical incident—compliant network enforcement stops immediately.

> [!NOTE]
> GSA audit logs don't populate `modifiedProperties` for session management setting changes. This query alerts on any Adaptive Access policy update. When it fires, verify the current CA Signaling state in **Global Secure Access** > **Settings** > **Session management** > **Adaptive access**.

```kql
AuditLogs
| where TimeGenerated > ago(5m)
| where LoggedByService == "Global Secure Access"
| where OperationName has_any (
    "Update Adaptive Access Policy",
    "Update Global Secure Access Settings"
    )
| extend InitiatedByUser = tostring(InitiatedBy.user.userPrincipalName)
| extend TargetResource = tostring(TargetResources[0].displayName)
| project TimeGenerated, OperationName, InitiatedByUser, TargetResource, Result
| order by TimeGenerated desc
```

**Alert: Universal Tenant Restrictions disabled**

Detects when the Universal Tenant Restrictions policy is turned off. Any result is a Critical incident—external tenant sign-in controls are no longer enforced.

> [!NOTE]
> GSA audit logs don't populate `modifiedProperties` for tenant restrictions policy changes. This query alerts on any Universal Tenant Restrictions policy update or deletion. When it fires, verify the current state in **Global Secure Access** > **Settings** > **Session management** > **Universal tenant restrictions**.

```kql
AuditLogs
| where TimeGenerated > ago(5m)
| where LoggedByService == "Global Secure Access"
| where OperationName has_any (
    "Update Universal Tenant Restrictions Policy",
    "Delete Universal Tenant Restrictions Policy"
    )
| extend InitiatedByUser = tostring(InitiatedBy.user.userPrincipalName)
| extend TargetResource = tostring(TargetResources[0].displayName)
| project TimeGenerated, OperationName, InitiatedByUser, TargetResource, Result
| order by TimeGenerated desc
```

### Noncritical alerts to review

Use the following noncritical alerts to detect trends, policy-tuning opportunities, and changes in user behavior that don't usually require immediate incident response.

| Alert | Condition | Role | What to do next |
| --- | --- | --- | --- |
| Microsoft traffic volume change | Daily Microsoft 365 traffic volume changes significantly from the 30-day baseline, but no outage indicators are present | Platform Ops / Monitoring Engineer | 1. Compare the change with expected business events such as a large meeting, migration wave, or return-to-office day. 2. Check whether the change affects one site, user group, or service more than others. 3. Update traffic baselines if the increase or decrease reflects a sustained usage pattern. |
| Microsoft traffic distribution by service | One Microsoft 365 service generates a larger share of traffic than usual | Platform Ops / Monitoring Engineer | 1. Confirm whether the increase is expected for that workload, such as Teams events or SharePoint migrations. 2. Review policy coverage and forwarding behavior for the affected destination fully qualified domain names (FQDNs). 3. If the pattern is unexpected, investigate whether a client, script, or workload is generating abnormal traffic. |
| Tenant restriction blocks trending upward | Sign-ins blocked by tenant restrictions increase over the normal monthly pattern | Identity Engineer / Identity Team | 1. Confirm whether the blocked attempts are tied to approved business scenarios or unauthorized tenant access. 2. Review the affected applications and resource tenants. 3. If legitimate access is being blocked, adjust policy or user guidance; otherwise document the trend as expected enforcement. |
| Foreign tenant usage on your network | Requests to external Microsoft Entra tenants are observed from users on your network, but enforcement remains intact | Identity Engineer / Identity Team | 1. Review which resource tenants and applications users are attempting to access. 2. Distinguish between approved partner scenarios and unapproved external tenant use. 3. Use the results to refine tenant restrictions policy, exception handling, and monthly access reviews. |

### KQL queries - non-critical

**Microsoft traffic volume—daily trend:**

```kql
NetworkAccessTraffic
| where TimeGenerated > ago(30d)
| where TrafficType == "microsoft365"
| summarize
    SessionCount = count(),
    TotalMB = sum(SentBytes + ReceivedBytes) / 1048576.0,
    UniqueUsers = dcount(UserId)
    by bin(TimeGenerated, 1d)
| order by TimeGenerated asc
```

**Microsoft traffic by service—identify which M365 services generate the most traffic:**

```kql
NetworkAccessTraffic
| where TimeGenerated > ago(24h)
| where TrafficType == "microsoft365"
| summarize
    SessionCount = count(),
    TotalMB = sum(SentBytes + ReceivedBytes) / 1048576.0
    by DestinationFqdn
| order by TotalMB desc
```

**Sign-ins blocked by tenant restriction**
```kql
SigninLogs
| where TimeGenerated > ago(30d)
| project ResultType, AppDisplayName, ResourceDisplayName, Identity, ResourceTenantId
| where Identity contains "Tenant Restriction" and ResultType == 5000211
| summarize ["Blocked count"] = count() by ["Application name"] = AppDisplayName, ["Resource name"] = ResourceDisplayName, ["Resource tenant ID"]= ResourceTenantId
| order by ["Blocked count"] desc
```

**Foreign tenant usage on your network​**
```kql
SigninLogs
| where TimeGenerated > ago(30d)
| project Identity, ResourceTenantId, AppDisplayName, ResourceDisplayName, Resource , AppId, ResourceIdentity
| where  Identity contains "Tenant Restriction"
| summarize ["Request count"]=count() by 
    ["Resource tenant ID"] = ResourceTenantId, 
    ["Application name"] = AppDisplayName, 
    ["Application ID"] = AppId, 
    ["Resource name"] = ResourceDisplayName, 
    ["Resource ID"] = ResourceIdentity
| order by ["Request count"]  desc
```

> [!TIP]
> Use Microsoft Security Copilot to correlate `AuditLogs` and `SigninLogs` when investigating CA policy failures alongside configuration changes. Ask: *"Show me Global Secure Access configuration changes in the last 24 hours that coincide with a spike in Conditional Access failures for Microsoft 365 apps."*

### Sentinel workbook

The **Global Secure Access** workbook in Microsoft Sentinel provides operational dashboards for traffic volume, denied sessions, and compliant network coverage. Use it for trend analysis and management reporting—not for primary alerting.

To access the workbook:

1. In Microsoft Sentinel, go to **Threat management** > **Workbooks**.
2. Search for **Global Secure Access** and open the workbook.
3. Use the **Microsoft Traffic** tab to view traffic volume by service, denied session trends, and compliant network coverage over time.

> [!NOTE]
> The workbook requires the Global Secure Access solution to be installed from the Microsoft Sentinel content hub. If the workbook isn't visible, go to **Content management** > **Content hub**, search for **Global Secure Access**, and install the solution.

## Maintenance and health checks

This section defines the recurring checks that keep Microsoft traffic operations stable after deployment. Use the daily, weekly, and monthly procedures in this section to validate:

- Alert handling and user experience.
- Compliant network enforcement.
- Configuration backup and client coverage.
- Alignment between your traffic forwarding rules and Conditional Access design.

### Daily checks

| Check | Role | Procedure | What to do if it fails |
| --- | --- | --- | --- |
| High-severity alerts | SOC Analyst | Review alerts in Sentinel or your security information and event management (SIEM) platform for P1/P2 Microsoft traffic alerts from the last 24 hours. | Ensure each alert is assigned and under investigation. Unassigned alerts older than 4 hours should be escalated. |
| Microsoft 365 user experience | IT Support / Help desk | Check Microsoft 365 service health dashboard and any user-reported issues in your help desk system. | If users report Microsoft 365 performance issues, compare with Global Secure Access traffic logs to determine whether Global Secure Access routing is a factor. |

### Weekly checks

| Check | Role | Procedure | What to do if it fails |
| --- | --- | --- | --- |
| Compliant network failures | Identity Engineer / Identity Team | Review Conditional Access policy failures due to compliant network check. Microsoft traffic denials should be near zero. | Investigate any denials—they usually indicate client connectivity issues or attempts to connect from unauthorized devices. |
| Configuration backup | Platform Ops / Monitoring Engineer | Run the [automated configuration export](#automation-playbooks). | Troubleshoot the export. Manually export traffic forwarding rules. |
| Client agent deployment status | IT Support / Help desk | Review Global Secure Access client deployment coverage in Intune. | Push client updates to devices that aren't reporting or outdated. |

### Monthly checks

| Check | Role | Procedure | What to do if it fails |
| --- | --- | --- | --- |
| Conditional Access policy review | Identity Engineer / Identity Team | Review CA policies that use Block grant control and exclude compliant network locations. Verify the `TargetPolicyIds` in the Conditional Access policy failure KQL query are still current. | Update the KQL query and Sentinel rule if policies changed. Ensure policies are still aligned with your security requirements. |
| Review Universal Tenant Restrictions policy | Identity Engineer / Identity Team | If your organization uses Universal Tenant Restrictions: 1. Review the allowed tenant list and remove any tenants with no access in the last 30 days. 2. Review sign-in logs for blocked access attempts to unauthorized external tenants and investigate any patterns. | Remove stale tenants allowed by Tenant Restrictions policy. For blocked access attempts that appear suspicious, escalate to your security team. |
| Traffic profile rule coverage | Network Security Engineer | Review the traffic forwarding rules for the Microsoft traffic profile. Confirm all expected Microsoft 365 service endpoints are included—specifically Skype for Business Online and Microsoft Teams, SharePoint Online and OneDrive for Business, Exchange Online, and Microsoft 365 Common and Office Online. | Update rules to include any missing endpoints. Check Microsoft's published endpoint lists for changes. |


## Integration and automation

Microsoft traffic operations should rely on integrated monitoring and scheduled automation rather than manual portal checks. The procedures in this section let you:

- Export Microsoft traffic profile configuration for backup and change tracking.
- Connect Microsoft traffic telemetry to Microsoft Sentinel for alerting and correlation with Entra sign-in logs.
- Implement playbooks for routine tasks: policy-failure response, configuration-change notification, profile-state monitoring, and scheduled backup and review workflows.

### Export Microsoft traffic profile configuration via Graph API

```powershell
# TODO: Remove or update $OutputPath before moving to production
$OutputPath = "C:\My Scripts\"

$exportStatus = [ordered]@{
    "Traffic Profile"    = "Not attempted"
    "Policy Links"       = "Not attempted"
    "Destinations"       = "Not attempted"
}

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "NetworkAccess.Read.All"

# Export Microsoft traffic forwarding profile
$profiles = Get-MgBetaNetworkAccessForwardingProfile
$microsoftProfile = $profiles | Where-Object { $_.TrafficForwardingType -eq "m365" }
$profileFile = Join-Path $OutputPath "MicrosoftTrafficProfile_$(Get-Date -Format 'yyyyMMdd').json"
try {
    $microsoftProfile | ConvertTo-Json -Depth 5 | Out-File $profileFile
    $exportStatus["Traffic Profile"] = "Success: $profileFile"
} catch {
    $exportStatus["Traffic Profile"] = "FAILED: $_"
}

if ($microsoftProfile) {
    # Get profile policy links with the nested policy object expanded.
    # Note: Get-MgBetaNetworkAccessForwardingProfilePolicy returns policyLink objects
    # whose .Id is the link ID, not the forwardingPolicy ID. The actual policy ID
    # is at .Policy.Id in the expanded response.
    $policyLinks = Invoke-MgGraphRequest -Method GET `
        -Uri "https://graph.microsoft.com/beta/networkAccess/forwardingProfiles/$($microsoftProfile.Id)/policies?`$expand=policy"

    # Export the raw policy links for reference
    $rulesFile = Join-Path $OutputPath "MicrosoftTrafficRules_$(Get-Date -Format 'yyyyMMdd').json"
    try {
        $policyLinks.value | ConvertTo-Json -Depth 10 | Out-File $rulesFile
        $exportStatus["Policy Links"] = "Success: $rulesFile"
    } catch {
        $exportStatus["Policy Links"] = "FAILED: $_"
    }

    # Retrieve and export policyRules (IPs/FQDNs) for the four core M365 forwarding policies
    $targetPolicies = @(
        "Skype for Business Online and Microsoft Teams",
        "SharePoint Online and OneDrive for Business",
        "Exchange Online",
        "Microsoft 365 Common and Office Online"
    )

    $allDestinations = @()
    foreach ($link in $policyLinks.value) {
        $policyName = $link.policy.name
        $policyId   = $link.policy.id

        if ($policyName -notin $targetPolicies) { continue }

        Write-Host "Processing policy: $policyName (ID: $policyId)"

        try {
            $policyRules = Invoke-MgGraphRequest -Method GET `
                -Uri "https://graph.microsoft.com/beta/networkAccess/forwardingPolicies/$policyId/policyRules"
        } catch {
            Write-Warning "Failed to retrieve policyRules for '$policyName': $_"
            continue
        }

        foreach ($policyRule in $policyRules.value) {
            $destList = if ($policyRule.destinations) { $policyRule.destinations } `
                        elseif ($policyRule.networkDestinations) { $policyRule.networkDestinations } `
                        else { @() }
            foreach ($dest in $destList) {
                $destValue = if ($dest.value) { $dest.value } `
                             elseif ($dest.fqdn) { $dest.fqdn } `
                             elseif ($dest.addressPrefix) { $dest.addressPrefix } `
                             else { ($dest | ConvertTo-Json -Compress) }
                $allDestinations += [PSCustomObject]@{
                    Policy      = $policyName
                    PolicyId    = $policyId
                    RuleName    = $policyRule.name
                    Type        = $dest.'@odata.type'
                    Value       = $destValue
                    Ports       = ($policyRule.ports -join ", ")
                    Protocol    = $policyRule.protocol
                }
            }
        }
    }

    if ($allDestinations.Count -eq 0) {
        Write-Warning "No destinations found. Policy names returned in profile:"
        $policyLinks.value | ForEach-Object { Write-Host "  - $($_.policy.name) (ID: $($_.policy.id))" }
    } else {
        $destinationsFile = Join-Path $OutputPath "MicrosoftTrafficDestinations_$(Get-Date -Format 'yyyyMMdd').json"
        try {
            $allDestinations | ConvertTo-Json -Depth 5 | Out-File $destinationsFile
            $exportStatus["Destinations"] = "Success: $destinationsFile ($($allDestinations.Count) entries)"
        } catch {
            $exportStatus["Destinations"] = "FAILED: $_"
        }
    }
}

Write-Host "`nExport Summary:"
foreach ($entry in $exportStatus.GetEnumerator()) {
    if ($entry.Value -like "Success*") {
        Write-Host "  [OK] $($entry.Key): $($entry.Value)" -ForegroundColor Green
    } elseif ($entry.Value -eq "Not attempted") {
        Write-Host "  [--] $($entry.Key): $($entry.Value)" -ForegroundColor Yellow
    } else {
        Write-Host "  [FAILED] $($entry.Key): $($entry.Value)" -ForegroundColor Red
    }
}
```

### Sentinel integration

Follow the same Sentinel integration steps as the [Private Access guide](how-to-operate-private-access.md#sentinel-integration--step-by-step). For the Microsoft traffic profile, focus on:

1. Enable analytics rules for unusual Microsoft 365 access patterns.
2. Configure alerts for denied Microsoft traffic (which typically indicates a misconfiguration).
3. Correlate Microsoft traffic logs with Entra sign-in logs to validate compliant network enforcement.

### Automation playbooks

#### Playbook 1: CA policy failure response

- **Trigger:** Sentinel alert "Conditional Access policy failure for Microsoft traffic"
- **Frequency:** Event-driven
- **Required permissions:** Microsoft Sentinel Responder on the workspace; Logic App Contributor on the playbook resource group; Teams Incoming Webhook (or Graph `ChannelMessage.Send` on the target channel); `SecurityEvents.Read.All` for sign-in log enrichment
- **Output:** Teams channel message with affected user count, blocked apps, and policy names, plus a deep link to the Entra sign-in log filtered to the impacted policy

**Steps:**

1. Create a Logic App in the playbook resource group and connect it to the Sentinel workspace via the Microsoft Sentinel connector.
2. Configure the trigger as **When a Microsoft Sentinel incident is created** and filter to the analytics rule "Conditional Access policy failure for Microsoft traffic".
3. Add an action to post an Adaptive Card to the GSA operations Teams channel containing the alert entities (`AffectedUsers`, `BlockedApps`, `BlockingPolicies`).
4. Append a Teams action button linking to `https://entra.microsoft.com/#view/Microsoft_AAD_IAM/SignInLogsBlade` with a query string scoped to the impacted policy ID.
5. Bind the playbook to the analytics rule via a Sentinel **automation rule** so it fires automatically on incident creation.

**Script / Request:** Logic App ARM template (link to your repo); no PowerShell required.

#### Playbook 2: Traffic forwarding rule change notification

- **Trigger:** Sentinel alert "Traffic forwarding rule change"
- **Frequency:** Event-driven
- **Required permissions:** Microsoft Sentinel Responder; Logic App Contributor; Teams Incoming Webhook; IT service management (ITSM) connector credentials (ServiceNow, Jira, etc.) with permission to open and close change records
- **Output:** Teams notification with change details (who, what, when) and an autoopened change-management ticket; ticket autocloses if the change is confirmed approved within two hours

**Steps:**

1. Create the Logic App and bind it to the Sentinel automation rule for the "Traffic forwarding rule change" analytics rule.
2. Parse the alert entities (`OperationName`, `InitiatedByUser`, `AffectedResources`).
3. Post the change summary to the GSA change-management Teams channel.
4. Call the ITSM connector to open a verification ticket referencing the alert ID.
5. Add a delayed branch (2 hours) that queries the ITSM system for an approved change record matching the operation; if found, close the verification ticket; if not, escalate to the on-call engineer.

**Script / Request:** Logic App ARM template; ITSM connector configuration is environment-specific.

#### Playbook 3: Microsoft traffic profile disabled response

- **Trigger:** Sentinel alert "Microsoft traffic profile disabled"
- **Frequency:** Event-driven
- **Required permissions:** Microsoft Sentinel Responder; Logic App Contributor; Teams Incoming Webhook; Office 365 Outlook connector (or Graph `Mail.Send`); Log Analytics Reader on the workspace
- **Output:** P1 notification to the GSA admin team via Teams and email, enriched with the initiating user's recent sign-in activity

**Steps:**

1. Create the Logic App and bind it to the automation rule for the "Microsoft traffic profile disabled" analytics rule.
2. Extract `InitiatedByUser` and `TimeGenerated` from the alert.
3. Run a Log Analytics query against `SigninLogs` for the initiating user over the previous 24 hours, returning sign-in count, distinct IPs, and any risky sign-ins.
4. Post the enriched payload to Teams with severity P1 formatting and email the on-call distribution list.

**Script / Request:** Logic App ARM template; embedded KQL provided in the action body.

#### Playbook 4: CA Signaling disabled response

- **Trigger:** Sentinel alert "Conditional Access Signaling disabled"
- **Frequency:** Event-driven
- **Required permissions:** Microsoft Sentinel Responder; Logic App Contributor; Teams Incoming Webhook; Office 365 Outlook connector; Log Analytics Reader
- **Output:** P1 notification to the GSA admin team with a count of CA policy failures observed after the disable event

**Steps:**

1. Create the Logic App and bind it to the automation rule for the "Conditional Access Signaling disabled" analytics rule.
2. Capture the disable event timestamp.
3. Query `SigninLogs` for `ConditionalAccessStatus == "failure"` events occurring after the disable timestamp.
4. Post to Teams and email the on-call list with the failure count and a link to the disabled-state confirmation page in **Global Secure Access** > **Settings** > **Session management** > **Adaptive access**.

**Script / Request:** Logic App ARM template; embedded KQL provided in the action body.

#### Playbook 5: Universal Tenant Restrictions disabled response

- **Trigger:** Sentinel alert "Universal Tenant Restrictions disabled"
- **Frequency:** Event-driven
- **Required permissions:** Microsoft Sentinel Responder; Logic App Contributor; Teams Incoming Webhook; Office 365 Outlook connector; Log Analytics Reader
- **Output:** P1 notification to the GSA admin team appended with any external tenant sign-ins observed after the disable event

**Steps:**

1. Create the Logic App and bind it to the automation rule for the "Universal Tenant Restrictions disabled" analytics rule.
2. Capture the disable event timestamp.
3. Query `SigninLogs` for sign-ins where `ResourceTenantId` isn't the home tenant, after the disable timestamp.
4. Post the enriched payload to Teams and email the security team's distribution list.

**Script / Request:** Logic App ARM template; embedded KQL provided in the action body.

#### Playbook 6: Weekly configuration backup

- **Trigger:** Scheduled
- **Frequency:** Weekly
- **Required permissions:** Graph `NetworkAccess.Read.All` (delegated or application); Storage Blob Data Contributor on the backup storage account; Automation Contributor on the runbook
- **Output:** Date-stamped JSON files (`MicrosoftTrafficProfile_yyyyMMdd.json`, `MicrosoftTrafficRules_yyyyMMdd.json`, `MicrosoftTrafficDestinations_yyyyMMdd.json`) saved to the configured storage account

**Steps:**

1. Create an Azure Automation account with a system-assigned managed identity and grant it the required Graph and Storage permissions.
2. Import the `Microsoft.Graph.Beta.NetworkAccess` and `Az.Storage` modules.
3. Publish the configuration export script ([Export Microsoft traffic profile configuration via Graph API](#export-microsoft-traffic-profile-configuration-via-graph-api)) as a PowerShell runbook, parameterized with the destination storage account and container.
4. Schedule the runbook to run weekly during the maintenance window.
5. Configure an alert on runbook failure that posts to the GSA operations Teams channel.

**Script / Request:** [Export Microsoft traffic profile configuration via Graph API](#export-microsoft-traffic-profile-configuration-via-graph-api).

#### Playbook 7: Monthly tenant restrictions review report

- **Trigger:** Scheduled
- **Frequency:** Monthly
- **Required permissions:** Graph `AuditLog.Read.All` (or Log Analytics Reader on the Sentinel workspace); `Mail.Send` (or SendGrid connector); Automation Contributor on the runbook
- **Output:** HTML report of blocked cross-tenant sign-in attempts grouped by resource tenant, emailed to the security team

**Steps:**

1. In the Azure Automation account, publish a PowerShell runbook that authenticates with the system-assigned managed identity and runs `Invoke-AzOperationalInsightsQuery` against the Sentinel workspace.
2. Use the [Sign-ins blocked by tenant restriction](#kql-queries---non-critical) and [Foreign tenant usage on your network](#kql-queries---non-critical) queries to retrieve the data.
3. Render the result as HTML using `ConvertTo-Html` and send via `Send-MailMessage` (or the SendGrid connector).
4. Schedule the runbook to run on the first business day of each month.

**Script / Request:** Build the runbook from the two KQL queries referenced earlier in this playbook; no published script in this repo yet.

### Microsoft 365 service integration

- **Microsoft 365 network connectivity test**: Periodically run the [Microsoft 365 network connectivity test](https://connectivity.office.com/) from sites that use GSA to validate optimal routing.

## Operational metrics

| Metric | How to measure | Target | Review cadence |
| --- | --- | --- | --- |
| Microsoft traffic profile uptime | % time the profile is enabled and functioning | 100% | Weekly |
| Microsoft traffic denial rate | Denied sessions / total Microsoft traffic sessions | < 1% | Weekly |
| Compliant network check success rate | Sessions with successful compliant network enrichment / total M365 sessions | > 99% | Weekly |
| Configuration backup success | Successful backups / scheduled backups | 100% | Weekly |
| User-reported Microsoft 365 performance issues | Help desk tickets related to Microsoft 365 performance through Global Secure Access | Trending toward 0 | Monthly |

## Related content

- [Common operations guide](how-to-operations-common.md)—Roles, change management, metrics framework
- [Private Access operations](how-to-operate-private-access.md)
- [Internet Access operations](how-to-operate-internet-access.md)
- [Remote Networks operations](how-to-operate-remote-networks.md)
- [Daily health check template](reference-daily-health-check.md)
- [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges)
- [Global Secure Access documentation](/entra/global-secure-access/)
- [GSA Deployment Guide](/entra/architecture/gsa-deployment-guide-intro)

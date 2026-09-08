---
title: PowerShell sample - Calculate the alert noise ratio for Microsoft Entra Global Secure Access detections
description: "Calculate the Microsoft Sentinel alert noise ratio for Global Secure Access detections and send an alert when false positives or informational closures exceed your threshold."
ms.topic: sample
ms.date: 06/17/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Calculate the alert noise ratio for Microsoft Entra Global Secure Access detections

This script queries Microsoft Sentinel incidents in Log Analytics, calculates the ratio of false-positive and informational closures, and identifies the noisiest analytics rules.

The script dot-sources `_GsaOpsHelpers.ps1`, so place the helper file in the same folder before you run this sample.

## Prerequisites

- PowerShell 7.0 or later.
- Install the modules listed in the script's `.NOTES` block.
- Use only permissions and roles that your organization has approved for the task.

## Script

```powershell
<#
.SYNOPSIS
    Calculates the alert noise ratio from Sentinel incidents and alerts on excessive false positives.
.DESCRIPTION
    Queries Log Analytics for Sentinel incident classifications over a configurable lookback
    period. Calculates the ratio of false-positive and informational closures to total incidents.
    If the ratio exceeds the threshold (default 20%), sends an alert email with details on the
    noisiest analytics rules.

    Run this script weekly as an Azure Automation runbook.
.PARAMETER WorkspaceId
    Log Analytics workspace ID containing Sentinel incident data.
.PARAMETER ThresholdPercent
    Maximum acceptable false-positive/informational ratio. Default: 20.
.PARAMETER LookbackDays
    Number of days to analyze. Default: 7.
.PARAMETER AlertRecipient
    Email address to receive the alert when the threshold is exceeded.
.PARAMETER SenderId
    UserId or UPN of the mailbox used to send alert emails.
.EXAMPLE
    .\Test-GsaAlertNoiseRatio.ps1 -WorkspaceId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -AlertRecipient "gsa-ops@contoso.com" -SenderId "gsa-automation@contoso.com"
.NOTES
    Required permissions: Azure — Log Analytics Reader on the workspace; Graph — Mail.Send
    Minimum module versions: Az.Accounts 2.x, Az.OperationalInsights 3.x, Microsoft.Graph.Authentication 2.x, Microsoft.Graph.Users.Actions 2.x
    Dot-sources scripts/automation/_GsaOpsHelpers.ps1 for shared auth and email helpers.
    Author: GSA Operations
#>

[CmdletBinding()]
[OutputType([pscustomobject])]
param(
    [Parameter(Mandatory)]
    [string]$WorkspaceId,

    [int]$ThresholdPercent = 20,

    [int]$LookbackDays = 7,

    [string]$AlertRecipient,

    [string]$SenderId,

    [string]$TenantId,

    [string]$SubscriptionId,

    [switch]$SkipEmail
)

$ErrorActionPreference = 'Stop'

# Load shared helpers (Connect-GsaRuntime, Send-GsaAlertEmail)
. "$PSScriptRoot\_GsaOpsHelpers.ps1"

# Connect only the services we need — skip Graph when -SkipEmail
$svc = if ($SkipEmail) { 'Az' } else { 'Both' }
Connect-GsaRuntime -Service $svc -TenantId $TenantId -SubscriptionId $SubscriptionId

# Ensure the session holds a Log Analytics token (CA policies may require MFA)
Confirm-GsaLogAnalyticsAccess

# KQL query to calculate noise ratio and identify noisy rules
$kqlQuery = @"
SecurityIncident
| where TimeGenerated > ago(${LookbackDays}d)
| where Classification != ""
| extend IsNoise = Classification in ("FalsePositive", "BenignPositive", "InformationalExpectedActivity")
| summarize
    TotalClassified = count(),
    NoiseCount = countif(IsNoise),
    TruePositives = countif(Classification == "TruePositive")
| extend NoiseRatioPercent = round(100.0 * NoiseCount / TotalClassified, 1)
"@

$noisyRulesQuery = @"
SecurityIncident
| where TimeGenerated > ago(${LookbackDays}d)
| where Classification in ("FalsePositive", "BenignPositive", "InformationalExpectedActivity")
| extend RuleName = tostring(parse_json(tostring(AdditionalData)).alertProductNames[0])
| summarize FalsePositiveCount = count() by RuleName
| order by FalsePositiveCount desc
| take 10
"@

# Verify workspace is reachable with a lightweight probe
Write-Verbose "Querying workspace $WorkspaceId in subscription $((Get-AzContext).Subscription.Id)..."
try {
    $null = Invoke-AzOperationalInsightsQuery -WorkspaceId $WorkspaceId -Query 'print probe = "ok"' -ErrorAction Stop
    Write-Verbose "Workspace reachable."
} catch {
    Write-Error "Workspace $WorkspaceId is not reachable. Verify the workspace ID and that you have Log Analytics Reader on subscription $((Get-AzContext).Subscription.Id). Error: $($_.Exception.Message)"
    return
}

# Check that the SecurityIncident table exists (requires Microsoft Sentinel)
Write-Verbose "Checking for SecurityIncident table..."
try {
    $tableCheck = Invoke-AzOperationalInsightsQuery -WorkspaceId $WorkspaceId `
        -Query 'SecurityIncident | take 0' -ErrorAction Stop
    Write-Verbose "SecurityIncident table exists."
} catch {
    Write-Warning "The SecurityIncident table does not exist in workspace $WorkspaceId. Microsoft Sentinel must be enabled and have at least one incident for this script to work."
    [PSCustomObject]@{
        Status       = "NoData"
        CheckedAt    = (Get-Date)
        LookbackDays = $LookbackDays
        Reason       = "SecurityIncident table not found — is Microsoft Sentinel enabled on this workspace?"
    }
    return
}

# Execute queries
try {
    $ratioResult = Invoke-AzOperationalInsightsQuery -WorkspaceId $WorkspaceId -Query $kqlQuery -ErrorAction Stop
} catch {
    Write-Error "Noise ratio query failed. Error: $($_.Exception.Message)"
    return
}

try {
    $noisyRulesResult = Invoke-AzOperationalInsightsQuery -WorkspaceId $WorkspaceId -Query $noisyRulesQuery -ErrorAction Stop
} catch {
    Write-Warning "Noisy-rules query failed (non-fatal): $($_.Exception.Message)"
    $noisyRulesResult = $null
}

$ratioData = $ratioResult.Results
if (-not $ratioData -or $ratioData.Count -eq 0) {
    Write-Verbose "No classified incidents found in the last $LookbackDays days. Skipping noise ratio check."
    [PSCustomObject]@{
        Status            = "NoData"
        CheckedAt         = (Get-Date)
        LookbackDays      = $LookbackDays
    }
    return
}

$noiseRatio = [double]$ratioData[0].NoiseRatioPercent
$totalClassified = [int]$ratioData[0].TotalClassified
$noiseCount = [int]$ratioData[0].NoiseCount

Write-Verbose "Alert noise ratio: $noiseRatio% ($noiseCount noise / $totalClassified total) — threshold: $ThresholdPercent%"

if ($noiseRatio -le $ThresholdPercent) {
    Write-Verbose "Noise ratio is within acceptable range."
    [PSCustomObject]@{
        Status            = "Compliant"
        CheckedAt         = (Get-Date)
        NoiseRatioPercent = $noiseRatio
        TotalClassified   = $totalClassified
        NoiseCount        = $noiseCount
        ThresholdPercent  = $ThresholdPercent
    }
    return
}

# Build alert email with noisy rules table
$noisyRules = if ($noisyRulesResult) { $noisyRulesResult.Results } else { $null }
$rulesTableRows = ""
if ($noisyRules -and $noisyRules.Count -gt 0) {
    $rulesTableRows = ($noisyRules | ForEach-Object {
        "<tr><td>$($_.RuleName)</td><td>$($_.FalsePositiveCount)</td></tr>"
    }) -join "`n"
}

$emailBody = @"
<h2>GSA Alert Noise Ratio Exceeded Threshold</h2>
<p>The alert noise ratio for the past <strong>$LookbackDays days</strong> is <strong>${noiseRatio}%</strong>, exceeding the <strong>${ThresholdPercent}%</strong> threshold.</p>
<ul>
<li>Total classified incidents: <strong>$totalClassified</strong></li>
<li>False positive / informational: <strong>$noiseCount</strong></li>
</ul>
<h3>Top Noisy Analytics Rules</h3>
<table border="1" cellpadding="5" cellspacing="0">
<tr><th>Rule Name</th><th>False Positive Count</th></tr>
$rulesTableRows
</table>
<p><strong>Action required:</strong></p>
<ol>
<li>Open Microsoft Sentinel &gt; Analytics and review the rules listed above.</li>
<li>For each noisy rule, consider: adjusting the query threshold, adding exclusions for known-good patterns, or disabling the rule if it provides no actionable signal.</li>
<li>Re-assess after the next reporting period to confirm the noise ratio has improved.</li>
<li>Update your 30-day baseline if environmental changes (new users, new apps) caused a legitimate shift in alert volume.</li>
</ol>
"@

if ($SkipEmail) {
    Write-Verbose "Skipping alert email (-SkipEmail specified)."
} elseif (-not $SenderId -or -not $AlertRecipient) {
    Write-Warning "Skipping alert email — -SenderId and -AlertRecipient are required when -SkipEmail is not set."
} else {
    try {
        Send-GsaAlertEmail `
            -SenderId  $SenderId `
            -Recipient $AlertRecipient `
            -Subject   "GSA Alert Noise Ratio Alert — ${noiseRatio}% (threshold: ${ThresholdPercent}%)" `
            -HtmlBody  $emailBody
    } catch {
        Write-Warning "Alert email failed (non-fatal): $_"
    }
}

# Return summary
[PSCustomObject]@{
    Status            = "NonCompliant"
    CheckedAt         = (Get-Date)
    NoiseRatioPercent = $noiseRatio
    TotalClassified   = $totalClassified
    NoiseCount        = $noiseCount
    ThresholdPercent  = $ThresholdPercent
    TopNoisyRules     = $noisyRules
}
```

## Related content

- [Global Secure Access PowerShell samples](../powershell-samples.md)
- [Microsoft Entra Global Secure Access operations guide](../overview-operations.md)

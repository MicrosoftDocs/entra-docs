---
title: PowerShell sample - Calculate the alert noise ratio for Global Secure Access detections
description: "Use this PowerShell script to calculate the false-positive ratio of Global Secure Access analytics rules in Microsoft Sentinel and alert when the ratio exceeds a threshold."
ms.topic: sample
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Calculate the alert noise ratio for Global Secure Access detections

Queries Log Analytics for Sentinel incident classifications over a configurable lookback
period. Calculates the ratio of false-positive and informational closures to total incidents.
If the ratio exceeds the threshold (default 20%), sends an alert email with details on the
noisiest analytics rules.

Run this script weekly as an Azure Automation runbook.

## Prerequisites and notes

- **Required permissions**: Azure — Log Analytics Reader on the workspace; Graph — Mail.Send
- **Minimum module versions**: Az.OperationalInsights, Microsoft.Graph 2.x

## Parameters

| Parameter | Description |
| --- | --- |
| `WorkspaceId` | Log Analytics workspace ID containing Sentinel incident data. |
| `ThresholdPercent` | Maximum acceptable false-positive/informational ratio. Default: 20. |
| `LookbackDays` | Number of days to analyze. Default: 7. |
| `AlertRecipient` | Email address to receive the alert when the threshold is exceeded. |
| `SenderId` | UserId or UPN of the mailbox used to send alert emails. |

## Examples

```powershell
.\Test-GsaAlertNoiseRatio.ps1 -WorkspaceId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -AlertRecipient "gsa-ops@contoso.com" -SenderId "gsa-automation@contoso.com"
```

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
    Minimum module versions: Az.OperationalInsights, Microsoft.Graph 2.x
    Author: GSA Operations
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$WorkspaceId,

    [int]$ThresholdPercent = 20,

    [int]$LookbackDays = 7,

    [Parameter(Mandatory)]
    [string]$AlertRecipient,

    [Parameter(Mandatory)]
    [string]$SenderId
)

$ErrorActionPreference = 'Stop'

# Connect to Azure
try {
    Connect-AzAccount -Identity -ErrorAction Stop
    Write-Verbose "Connected to Azure via managed identity."
} catch {
    Write-Warning "Managed identity auth failed. Checking existing Az context. Error: $_"
    $azContext = Get-AzContext
    if (-not $azContext) {
        throw "No Azure context available. Run Connect-AzAccount first."
    }
}

# Connect to Graph for email
try {
    Connect-MgGraph -Identity -NoWelcome -ErrorAction Stop
} catch {
    Write-Warning "Graph managed identity auth failed. Attempting existing context. Error: $_"
}

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

# Execute queries
try {
    $ratioResult = Invoke-AzOperationalInsightsQuery -WorkspaceId $WorkspaceId -Query $kqlQuery -ErrorAction Stop
    $noisyRulesResult = Invoke-AzOperationalInsightsQuery -WorkspaceId $WorkspaceId -Query $noisyRulesQuery -ErrorAction Stop
} catch {
    Write-Error "Failed to query Log Analytics. Verify workspace ID and permissions. Error: $_"
    return
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
$noisyRules = $noisyRulesResult.Results
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

$message = @{
    Message = @{
        Subject = "GSA Alert Noise Ratio Alert — ${noiseRatio}% (threshold: ${ThresholdPercent}%)"
        Body    = @{
            ContentType = "HTML"
            Content     = $emailBody
        }
        ToRecipients = @(@{ EmailAddress = @{ Address = $AlertRecipient } })
    }
    SaveToSentItems = $false
}

try {
    Send-MgUserMail -UserId $SenderId -BodyParameter $message -ErrorAction Stop
    Write-Verbose "Alert email sent to $AlertRecipient."
} catch {
    Write-Error "Failed to send alert email. Error: $_"
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

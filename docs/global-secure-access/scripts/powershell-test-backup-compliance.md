---
title: PowerShell sample - Verify Global Secure Access configuration backup compliance
description: "Verify that your Global Secure Access configuration backup runbook ran successfully. Send an alert when the runbook fails or misses a scheduled run."
ms.topic: sample
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Verify Global Secure Access configuration backup compliance

This script queries Azure Automation for the status of Global Secure Access backup runbook jobs over a configurable lookback window. If any jobs failed or no jobs ran during the expected schedule, the script sends an alert email through Microsoft Graph.

Run this script daily as a secondary watchdog runbook in the same Automation Account or a different one.

## Prerequisites and notes

- **Required permissions**: Azure—Automation Job Operator on the Automation Account; Graph—Mail.Send
- **Minimum module versions**: `Az.Automation`, `Microsoft.Graph` 2.x

## Parameters

| Parameter | Description |
| --- | --- |
| `AutomationAccountName` | Name of the Azure Automation Account running the backup runbooks. |
| `ResourceGroupName` | Resource group containing the Automation Account. |
| `BackupRunbookName` | Name of the runbook that performs Global Secure Access configuration backups. |
| `LookbackHours` | Number of hours to look back for completed jobs. Default: 26 (covers a daily schedule with two-hour buffer). |
| `AlertRecipient` | Email address to receive failure alerts. |
| `SenderId` | UserId or user principal name (UPN) of the mailbox that sends alert emails. |

## Examples

```powershell
.\Test-GsaBackupCompliance.ps1 -AutomationAccountName "gsa-automation" -ResourceGroupName "gsa-ops-rg" -BackupRunbookName "Export-GsaConfiguration" -AlertRecipient "gsa-ops@contoso.com" -SenderId "gsa-automation@contoso.com"
```

## Script

```powershell
<#
.SYNOPSIS
    Monitors GSA configuration backup job results and alerts on failures.
.DESCRIPTION
    Queries Azure Automation for the status of GSA backup runbook jobs over a
    configurable lookback window. If any jobs failed or no jobs ran during the
    expected schedule, sends an alert email via Microsoft Graph.

    Run this script daily as a secondary watchdog runbook in the same (or a
    different) Automation Account.
.PARAMETER AutomationAccountName
    Name of the Azure Automation Account running the backup runbooks.
.PARAMETER ResourceGroupName
    Resource group containing the Automation Account.
.PARAMETER BackupRunbookName
    Name of the runbook that performs GSA configuration backups.
.PARAMETER LookbackHours
    Number of hours to look back for completed jobs. Default: 26 (covers a
    daily schedule with two-hour buffer).
.PARAMETER AlertRecipient
    Email address to receive failure alerts.
.PARAMETER SenderId
    UserId or UPN of the mailbox used to send alert emails.
.EXAMPLE
    .\Test-GsaBackupCompliance.ps1 -AutomationAccountName "gsa-automation" -ResourceGroupName "gsa-ops-rg" -BackupRunbookName "Export-GsaConfiguration" -AlertRecipient "gsa-ops@contoso.com" -SenderId "gsa-automation@contoso.com"
.NOTES
    Required permissions: Azure — Automation Job Operator on the Automation Account; Graph — Mail.Send
    Minimum module versions: Az.Automation, Microsoft.Graph 2.x
    Author: GSA Operations
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$AutomationAccountName,

    [Parameter(Mandatory)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory)]
    [string]$BackupRunbookName,

    [int]$LookbackHours = 26,

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

# Query recent backup jobs
$cutoff = (Get-Date).AddHours(-$LookbackHours)

try {
    $jobs = Get-AzAutomationJob `
        -AutomationAccountName $AutomationAccountName `
        -ResourceGroupName $ResourceGroupName `
        -RunbookName $BackupRunbookName `
        -ErrorAction Stop |
        Where-Object { $_.CreationTime -ge $cutoff }
} catch {
    Write-Error "Failed to query Automation jobs. Error: $_"
    return
}

# Evaluate results
$failedJobs = $jobs | Where-Object { $_.Status -eq 'Failed' }
$noJobsRan = $jobs.Count -eq 0

if (-not $noJobsRan -and $failedJobs.Count -eq 0) {
    Write-Verbose "All $($jobs.Count) backup job(s) in the last $LookbackHours hours completed successfully."
    [PSCustomObject]@{
        Status      = "Compliant"
        CheckedAt   = (Get-Date)
        TotalJobs   = $jobs.Count
        FailedJobs  = 0
    }
    return
}

# Build alert details
$alertReason = if ($noJobsRan) {
    "No backup jobs ran in the last $LookbackHours hours. The scheduled backup may be misconfigured or the Automation Account may be stopped."
} else {
    "$($failedJobs.Count) of $($jobs.Count) backup job(s) failed in the last $LookbackHours hours."
}

$jobDetails = ""
if ($failedJobs.Count -gt 0) {
    $tableRows = ($failedJobs | ForEach-Object {
        "<tr><td>$($_.JobId)</td><td>$($_.Status)</td><td>$($_.CreationTime.ToString('yyyy-MM-dd HH:mm'))</td><td>$($_.Exception)</td></tr>"
    }) -join "`n"
    $jobDetails = @"
<table border="1" cellpadding="5" cellspacing="0">
<tr><th>Job ID</th><th>Status</th><th>Started</th><th>Error</th></tr>
$tableRows
</table>
"@
}

$emailBody = @"
<h2>GSA Backup Compliance Alert</h2>
<p>$alertReason</p>
$jobDetails
<p><strong>Action required:</strong></p>
<ol>
<li>Check the Automation Account <strong>$AutomationAccountName</strong> in resource group <strong>$ResourceGroupName</strong>.</li>
<li>Review the failed job output for error details.</li>
<li>Run the backup manually: <code>Start-AzAutomationRunbook -Name '$BackupRunbookName' -AutomationAccountName '$AutomationAccountName' -ResourceGroupName '$ResourceGroupName'</code></li>
<li>Verify the backup file was created in your backup storage location.</li>
<li>Fix the root cause (expired credentials, API throttling, storage quota) and confirm the next scheduled run succeeds.</li>
</ol>
"@

$message = @{
    Message = @{
        Subject = "GSA Backup Alert — $alertReason"
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
    Status      = "NonCompliant"
    CheckedAt   = (Get-Date)
    TotalJobs   = $jobs.Count
    FailedJobs  = $failedJobs.Count
    Reason      = $alertReason
}
```

---
title: PowerShell sample - Check Global Secure Access RBAC review hygiene
description: "Find Global Secure Access admin role assignments that miss the quarterly review and send an alert when overdue accounts exist."
ms.topic: sample
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Check Global Secure Access RBAC review hygiene

This script queries Microsoft Graph for directory role assignments relevant to Global Secure Access administration. It compares the last review date (stored in a review log file) against the current quarter boundary. When the script finds overdue accounts, it sends an alert email through Microsoft Graph.

Run this script weekly as an Azure Automation runbook or scheduled task.

## Prerequisites and notes

- **Required permissions**: RoleManagement.Read.Directory, Mail.Send
- **Minimum module versions**: Microsoft.Graph 2.x

## Parameters

| Parameter | Description |
| --- | --- |
| `ReviewLogPath` | Path to the JSON file that tracks last-reviewed dates per account. In Azure Automation, point this parameter to an Azure Storage blob or Automation variable. |
| `AlertRecipient` | Email address that receives the alert when overdue accounts exist. |
| `SenderId` | UserId or UPN of the mailbox that sends alert emails. Requires the Mail.Send permission. |

## Examples

```powershell
.\Test-GsaRbacHygiene.ps1 -ReviewLogPath "C:\GsaOps\rbac-review-log.json" -AlertRecipient "gsa-ops@contoso.com" -SenderId "gsa-automation@contoso.com"
```

## Script

```powershell
<#
.SYNOPSIS
    Checks GSA-related admin role assignments and flags accounts not reviewed this quarter.
.DESCRIPTION
    Queries Microsoft Graph for directory role assignments relevant to Global Secure Access
    administration. Compares the last review date (stored in a review log file) against the
    current quarter boundary. Sends an alert email via Microsoft Graph when overdue accounts
    are found.

    Run this script weekly as an Azure Automation runbook or scheduled task.
.PARAMETER ReviewLogPath
    Path to the JSON file tracking last-reviewed dates per account. If running in Azure
    Automation, use an Azure Storage blob or Automation variable.
.PARAMETER AlertRecipient
    Email address to receive the alert when overdue accounts are found.
.PARAMETER SenderId
    UserId or UPN of the mailbox used to send alert emails (requires Mail.Send permission).
.EXAMPLE
    .\Test-GsaRbacHygiene.ps1 -ReviewLogPath "C:\GsaOps\rbac-review-log.json" -AlertRecipient "gsa-ops@contoso.com" -SenderId "gsa-automation@contoso.com"
.NOTES
    Required permissions: RoleManagement.Read.Directory, Mail.Send
    Minimum module versions: Microsoft.Graph 2.x
    Author: GSA Operations
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$ReviewLogPath,

    [Parameter(Mandatory)]
    [string]$AlertRecipient,

    [Parameter(Mandatory)]
    [string]$SenderId
)

$ErrorActionPreference = 'Stop'

# GSA-relevant directory roles
$GSA_ROLE_NAMES = @(
    "Global Secure Access Administrator",
    "Security Administrator",
    "Conditional Access Administrator",
    "Network Administrator",
    "Global Administrator"
)

# Connect using managed identity (Azure Automation) or current context
try {
    Connect-MgGraph -Identity -NoWelcome -ErrorAction Stop
    Write-Verbose "Connected to Microsoft Graph via managed identity."
} catch {
    Write-Warning "Managed identity auth failed. Attempting existing context. Error: $_"
    $context = Get-MgContext
    if (-not $context) {
        throw "No Graph connection available. Run Connect-MgGraph first."
    }
}

# Get current quarter boundary
$now = Get-Date
$quarterStart = Get-Date -Year $now.Year -Month ([Math]::Floor(($now.Month - 1) / 3) * 3 + 1) -Day 1

# Load review log
$reviewLog = @{}
if (Test-Path $ReviewLogPath) {
    $reviewLog = Get-Content $ReviewLogPath -Raw | ConvertFrom-Json -AsHashtable
    Write-Verbose "Loaded review log with $($reviewLog.Count) entries."
} else {
    Write-Warning "No review log found at $ReviewLogPath. All accounts will be flagged as overdue."
}

# Query role assignments for GSA-related roles
$overdueAccounts = [System.Collections.Generic.List[PSCustomObject]]::new()

try {
    $directoryRoles = Get-MgDirectoryRole -All -ErrorAction Stop
} catch {
    Write-Error "Failed to retrieve directory roles. Error: $_"
    return
}

foreach ($role in $directoryRoles) {
    if ($role.DisplayName -notin $GSA_ROLE_NAMES) { continue }

    try {
        $members = Get-MgDirectoryRoleMember -DirectoryRoleId $role.Id -All -ErrorAction Stop
    } catch {
        Write-Error "Failed to retrieve members of role '$($role.DisplayName)'. Error: $_"
        continue
    }

    foreach ($member in $members) {
        $upn = $member.AdditionalProperties["userPrincipalName"]
        if (-not $upn) { continue }

        $lastReviewed = $null
        if ($reviewLog.ContainsKey($upn)) {
            $lastReviewed = [datetime]$reviewLog[$upn]
        }

        if (-not $lastReviewed -or $lastReviewed -lt $quarterStart) {
            $overdueAccounts.Add([PSCustomObject]@{
                UserPrincipalName = $upn
                RoleName          = $role.DisplayName
                LastReviewed      = if ($lastReviewed) { $lastReviewed.ToString("yyyy-MM-dd") } else { "Never" }
                QuarterStart      = $quarterStart.ToString("yyyy-MM-dd")
            })
        }
    }
}

# Output results
if ($overdueAccounts.Count -eq 0) {
    Write-Verbose "All GSA admin accounts have been reviewed this quarter."
    [PSCustomObject]@{
        Status        = "Compliant"
        CheckedAt     = $now
        OverdueCount  = 0
    }
    return
}

Write-Warning "$($overdueAccounts.Count) GSA admin account(s) have not been reviewed this quarter."
$overdueAccounts | Format-Table -AutoSize | Out-String | Write-Verbose

# Build and send alert email
$tableRows = ($overdueAccounts | ForEach-Object {
    "<tr><td>$($_.UserPrincipalName)</td><td>$($_.RoleName)</td><td>$($_.LastReviewed)</td></tr>"
}) -join "`n"

$emailBody = @"
<h2>GSA RBAC Hygiene Alert — Overdue Reviews</h2>
<p><strong>$($overdueAccounts.Count)</strong> admin account(s) with GSA-related roles have not been reviewed since <strong>$($quarterStart.ToString("yyyy-MM-dd"))</strong>.</p>
<table border="1" cellpadding="5" cellspacing="0">
<tr><th>Account</th><th>Role</th><th>Last Reviewed</th></tr>
$tableRows
</table>
<p><strong>Action required:</strong> Review each account's access, confirm the assignment is still needed, and update the review log.</p>
"@

$message = @{
    Message = @{
        Subject = "GSA RBAC Hygiene Alert — $($overdueAccounts.Count) overdue review(s)"
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

# Return summary object
[PSCustomObject]@{
    Status        = "NonCompliant"
    CheckedAt     = $now
    OverdueCount  = $overdueAccounts.Count
    OverdueAccounts = $overdueAccounts
}
```

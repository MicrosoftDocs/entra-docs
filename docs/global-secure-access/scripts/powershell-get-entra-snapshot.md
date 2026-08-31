---
title: PowerShell sample - List Microsoft Entra Backup and Recovery snapshots for Global Secure Access recovery
description: "List Microsoft Entra Backup and Recovery snapshots that can help recover directory objects used by Global Secure Access."
ms.topic: sample
ms.date: 06/17/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# List Microsoft Entra snapshots for Global Secure Access recovery

This script lists Microsoft Entra Backup and Recovery snapshots for the tenant. Use the latest snapshot ID as input to the recovery preview script before you execute a recovery.

The Microsoft Entra Backup and Recovery APIs are in Microsoft Graph beta. Validate permissions and behavior in your tenant before you depend on these APIs in an operations process.

## Prerequisites

- PowerShell 7.0 or later.
- Install the modules listed in the script's `.NOTES` block.
- Use only permissions and roles that your organization has approved for the task.

## Script

```powershell
<#
.SYNOPSIS
    Lists Microsoft Entra Backup and Recovery snapshots for the tenant.
.DESCRIPTION
    Queries the Microsoft Entra Backup and Recovery service (beta) for available
    tenant snapshots. Microsoft Entra automatically creates one snapshot per day
    and retains up to five. Use the returned snapshot IDs as input to
    Start-GsaEntraRecoveryPreview.ps1.

    Output is PowerShell objects suitable for pipeline use. The latest snapshot
    (by creation date) is highlighted in the Latest property.
.PARAMETER TenantId
    Target Microsoft Entra tenant ID. Omit when running under managed identity
    in the same tenant.
.PARAMETER ClientId
    App registration client ID. Required with CertificateThumbprint.
.PARAMETER CertificateThumbprint
    Certificate thumbprint for service principal authentication.
.PARAMETER UseManagedIdentity
    Authenticate using the current managed identity. Use in Azure Automation.
.EXAMPLE
    .\Get-GsaEntraSnapshot.ps1 -UseManagedIdentity
.EXAMPLE
    .\Get-GsaEntraSnapshot.ps1 -TenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -ClientId "yyyy" -CertificateThumbprint "ZZZZ"
.NOTES
    Required Graph permissions:
        EntraBackup.Read.All (application or delegated)
    Required Entra role:
        Entra Backup Reader
    Minimum module versions:
        Microsoft.Graph.Authentication 2.x
    Beta API: subject to change per Microsoft Graph versioning policy.
    Reference: https://learn.microsoft.com/en-us/graph/api/resources/entrarecoveryservices-backup-recovery-overview?view=graph-rest-beta
    Author: GSA Operations
#>

[CmdletBinding(DefaultParameterSetName = 'Interactive')]
[OutputType([pscustomobject])]
param(
    [Parameter(ParameterSetName = 'ServicePrincipal', Mandatory)]
    [Parameter(ParameterSetName = 'Interactive')]
    [string]$TenantId,

    [Parameter(ParameterSetName = 'ServicePrincipal', Mandatory)]
    [string]$ClientId,

    [Parameter(ParameterSetName = 'ServicePrincipal', Mandatory)]
    [string]$CertificateThumbprint,

    [Parameter(ParameterSetName = 'ManagedIdentity', Mandatory)]
    [switch]$UseManagedIdentity
)

$ErrorActionPreference = 'Stop'

# Authenticate
try {
    switch ($PSCmdlet.ParameterSetName) {
        'ManagedIdentity'  { Connect-MgGraph -Identity -NoWelcome | Out-Null }
        'ServicePrincipal' { Connect-MgGraph -TenantId $TenantId -ClientId $ClientId -CertificateThumbprint $CertificateThumbprint -NoWelcome | Out-Null }
        default            { Connect-MgGraph -TenantId $TenantId -Scopes 'EntraBackup.Read.All' -NoWelcome | Out-Null }
    }
    Write-Verbose "Connected to Microsoft Graph."
} catch {
    throw "Failed to authenticate to Microsoft Graph: $_"
}

# List snapshots
try {
    $uri      = 'https://graph.microsoft.com/beta/directory/recovery/snapshots'
    $response = Invoke-MgGraphRequest -Method GET -Uri $uri
    $snapshots = @($response.value)
} catch {
    throw "Failed to retrieve snapshots. Verify the Entra Backup Reader role and EntraBackup.Read.All permission. Error: $_"
}

if ($snapshots.Count -eq 0) {
    Write-Warning "No snapshots returned. Confirm Microsoft Entra Backup and Recovery is enabled for this tenant."
    return
}

$latestId = ($snapshots | Sort-Object createdDateTime -Descending | Select-Object -First 1).id

foreach ($snapshot in $snapshots) {
    [PSCustomObject]@{
        SnapshotId       = $snapshot.id
        CreatedDateTime  = [datetime]$snapshot.createdDateTime
        ChangedObjects   = $snapshot.totalChangedObjectCount
        Latest           = ($snapshot.id -eq $latestId)
    }
}
```

## Related content

- [Global Secure Access PowerShell samples](../powershell-samples.md)
- [Microsoft Entra Global Secure Access operations guide](../overview-operations.md)

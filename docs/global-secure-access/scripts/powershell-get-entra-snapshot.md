---
title: PowerShell sample - List Microsoft Entra Backup and Recovery snapshots for GSA recovery
description: "Use this PowerShell script to list available Microsoft Entra tenant snapshots that you can use to recover Global Secure Access configuration."
ms.topic: sample
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# List Microsoft Entra snapshots for Global Secure Access recovery

Queries the Microsoft Entra Backup and Recovery service (beta) for available
tenant snapshots. Microsoft Entra automatically creates one snapshot per day
and retains up to five. Use the returned snapshot IDs as input to
Start-GsaEntraRecoveryPreview.ps1.

Output is PowerShell objects suitable for pipeline use. The latest snapshot
(by creation date) is highlighted in the Latest property.

## Prerequisites and notes

- **Required Graph permissions**: BackupRestore-Configuration.Read.All (application or delegated)
- **Required Entra role**: Microsoft Entra Backup Reader
- **Minimum module versions**: Microsoft.Graph.Authentication 2.x
- **Beta API**: subject to change per Microsoft Graph versioning policy.
- **Reference**: [Microsoft Entra Backup and Recovery — Graph reference](/graph/api/resources/entrarecoveryservices-backup-recovery-overview?view=graph-rest-beta&preserve-view=true)

## Parameters

| Parameter | Description |
| --- | --- |
| `TenantId` | Target Microsoft Entra tenant ID. Omit when running under managed identity in the same tenant. |
| `ClientId` | App registration client ID. Required with CertificateThumbprint. |
| `CertificateThumbprint` | Certificate thumbprint for service principal authentication. |
| `UseManagedIdentity` | Authenticate using the current managed identity. Use in Azure Automation. |

## Examples

```powershell
.\Get-GsaEntraSnapshot.ps1 -UseManagedIdentity
```

```powershell
.\Get-GsaEntraSnapshot.ps1 -TenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -ClientId "yyyy" -CertificateThumbprint "ZZZZ"
```

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
        BackupRestore-Configuration.Read.All (application or delegated)
    Required Entra role:
        Microsoft Entra Backup Reader
    Minimum module versions:
        Microsoft.Graph.Authentication 2.x
    Beta API: subject to change per Microsoft Graph versioning policy.
    Reference: https://learn.microsoft.com/graph/api/resources/entrarecoveryservices-backup-recovery-overview?view=graph-rest-beta&preserve-view=true
    Author: GSA Operations
#>

[CmdletBinding(DefaultParameterSetName = 'Interactive')]
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
        default            { Connect-MgGraph -TenantId $TenantId -Scopes 'BackupRestore-Configuration.Read.All' -NoWelcome | Out-Null }
    }
    Write-Verbose "Connected to Microsoft Graph."
} catch {
    Write-Error "Failed to authenticate to Microsoft Graph: $_"
    return
}

# List snapshots
try {
    $uri      = 'https://graph.microsoft.com/beta/directory/recovery/snapshots'
    $response = Invoke-MgGraphRequest -Method GET -Uri $uri
    $snapshots = @($response.value)
} catch {
    Write-Error "Failed to retrieve snapshots. Verify the Microsoft Entra Backup Reader role and BackupRestore-Configuration.Read.All permission. Error: $_"
    return
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

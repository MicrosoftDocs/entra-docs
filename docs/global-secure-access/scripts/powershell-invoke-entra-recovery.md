---
title: PowerShell sample - Run a Microsoft Entra recovery for Global Secure Access objects
description: "Run a Microsoft Entra recovery job for directory objects that affect Global Secure Access after reviewing a recovery preview."
ms.topic: sample
ms.date: 06/17/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Run a Microsoft Entra recovery for Global Secure Access objects

This script starts a Microsoft Entra recovery job for selected directory object types from a snapshot. Run the preview script first, review the changes, and execute this recovery script only after approval.

This script can make destructive changes. Use the same scope you reviewed in the preview job and follow your change approval process before running it.

## Prerequisites

- PowerShell 7.0 or later.
- Install the modules listed in the script's `.NOTES` block.
- Use only permissions and roles that your organization has approved for the task.

## Script

```powershell
<#
.SYNOPSIS
    Executes a Microsoft Entra recovery job for GSA-related objects from a snapshot.
.DESCRIPTION
    Creates a recoveryJob that restores the in-scope directory objects to their
    state in the selected snapshot. This is a destructive operation and should
    only be run after a preview job has been reviewed and approved.

    Use Start-GsaEntraRecoveryPreview.ps1 first, review the output of its
    getChanges function, then execute this script with the same SnapshotId and
    EntityTypes.
.PARAMETER SnapshotId
    Snapshot ID returned by Get-GsaEntraSnapshot.ps1.
.PARAMETER EntityTypes
    Directory object types to include in the recovery scope. Must match the
    scope of the previously approved preview job.
.PARAMETER TenantId
    Target Microsoft Entra tenant ID.
.PARAMETER UseManagedIdentity
    Authenticate using the current managed identity. Use in Azure Automation.
.PARAMETER ClientId
    App registration client ID. Required with CertificateThumbprint.
.PARAMETER CertificateThumbprint
    Certificate thumbprint for service principal authentication.
.PARAMETER Force
    Bypass the interactive confirmation prompt. Required for unattended runs.
.EXAMPLE
    .\Invoke-GsaEntraRecovery.ps1 -SnapshotId "MjAyNi0w..." -UseManagedIdentity -Force
.NOTES
    Required Graph permissions:
        EntraBackup.ReadWrite.Recovery (delegated only)
    Required Entra role:
        Entra Backup Administrator
    Minimum module versions:
        Microsoft.Graph.Authentication 2.x
    Beta API: subject to change per Microsoft Graph versioning policy.
    Destructive: always run a preview job first and review the changes.
    Only one preview or recovery job can run per tenant at a time.
    Recovery operations are logged in Entra audit logs under category
    "Backup and Recovery". Recovery operations don't fire Graph subscriptions
    or delta records.
    Reference: https://learn.microsoft.com/en-us/graph/api/resources/entrarecoveryservices-recoveryjob?view=graph-rest-beta
    Author: GSA Operations
#>

[CmdletBinding(DefaultParameterSetName = 'Interactive', SupportsShouldProcess, ConfirmImpact = 'High')]
[OutputType([pscustomobject])]
param(
    [Parameter(Mandatory)]
    [string]$SnapshotId,

    [ValidateSet('conditionalAccessPolicy', 'namedLocationPolicy', 'application', 'servicePrincipal', 'group', 'user', 'appRoleAssignment', 'oAuth2PermissionGrant', 'authenticationMethodPolicy', 'authorizationPolicy', 'authenticationStrengthPolicy')]
    [string[]]$EntityTypes = @('conditionalAccessPolicy', 'namedLocationPolicy', 'application', 'servicePrincipal'),

    [Parameter(ParameterSetName = 'ServicePrincipal', Mandatory)]
    [Parameter(ParameterSetName = 'Interactive')]
    [string]$TenantId,

    [Parameter(ParameterSetName = 'ServicePrincipal', Mandatory)]
    [string]$ClientId,

    [Parameter(ParameterSetName = 'ServicePrincipal', Mandatory)]
    [string]$CertificateThumbprint,

    [Parameter(ParameterSetName = 'ManagedIdentity', Mandatory)]
    [switch]$UseManagedIdentity,

    [switch]$Force
)

$ErrorActionPreference = 'Stop'

if (-not $Force -and -not $PSCmdlet.ShouldProcess("tenant $TenantId, snapshot $SnapshotId, entity types [$($EntityTypes -join ', ')]", "Execute Microsoft Entra recovery job")) {
    Write-Warning "Recovery job not started."
    return
}

# Authenticate
try {
    switch ($PSCmdlet.ParameterSetName) {
        'ManagedIdentity'  { Connect-MgGraph -Identity -NoWelcome | Out-Null }
        'ServicePrincipal' { Connect-MgGraph -TenantId $TenantId -ClientId $ClientId -CertificateThumbprint $CertificateThumbprint -NoWelcome | Out-Null }
        default            { Connect-MgGraph -TenantId $TenantId -Scopes 'EntraBackup.ReadWrite.Recovery' -NoWelcome | Out-Null }
    }
    Write-Verbose "Connected to Microsoft Graph."
} catch {
    throw "Failed to authenticate to Microsoft Graph: $_"
}

# Build scoped recovery job payload
$body = @{
    filteringCriteria = @{
        '@odata.type' = '#microsoft.graph.entraRecoveryServices.recoveryJobEntityNamesFilter'
        entityTypes   = $EntityTypes
    }
} | ConvertTo-Json -Depth 5

# Create recovery job
try {
    $uri      = "https://graph.microsoft.com/beta/directory/recovery/snapshots/$SnapshotId/recoveryJobs"
    $response = Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body -ContentType 'application/json' -ResponseHeadersVariable headers -StatusCodeVariable status
    if ($status -ne 202) {
        throw "Unexpected status code $status when creating recovery job."
    }
} catch {
    throw "Failed to create recovery job. Verify the Microsoft Entra Backup Administrator role, EntraBackup.ReadWrite.Recovery permission, and that no other recovery or preview job is currently running. Error: $_"
}

$jobUrl = $headers.Location | Select-Object -First 1
if (-not $jobUrl) {
    Write-Warning "No Location header returned. Inspect the response manually."
    return
}

[PSCustomObject]@{
    SnapshotId      = $SnapshotId
    EntityTypes     = $EntityTypes
    RecoveryJobUri  = $jobUrl
    StartedAt       = (Get-Date)
    NextSteps       = "Poll RecoveryJobUri until status=succeeded, then call {RecoveryJobUri}/getFailedChanges to review any failures."
}
```

## Related content

- [Global Secure Access PowerShell samples](../powershell-samples.md)
- [Microsoft Entra Global Secure Access operations guide](../overview-operations.md)

---
title: PowerShell sample - Preview a Microsoft Entra recovery for Global Secure Access objects
description: "Use this PowerShell script to create a non-destructive Microsoft Entra recovery preview job scoped to Global Secure Access-related directory objects."
ms.topic: sample
ms.date: 05/04/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Preview a Microsoft Entra recovery for Global Secure Access objects

Creates a recoveryPreviewJob against a chosen tenant snapshot, scoped to
entity types that affect Global Secure Access: Conditional Access policies,
named locations, applications, and service principals. The preview job is a
non-destructive dry run.

After the job reaches status 'succeeded', call the getChanges function
against the returned PreviewJobUri to enumerate the objects and property
changes that a recovery would apply.

Use Get-GsaEntraSnapshot.ps1 to retrieve available SnapshotId values.

## Prerequisites and notes

- **Required Graph permissions**: BackupRestore-Configuration.ReadWrite.All (application or delegated)
- **Required Entra role**: Microsoft Entra Backup Administrator
- **Minimum module versions**: Microsoft.Graph.Authentication 2.x
- **Beta API**: subject to change per Microsoft Graph versioning policy.
- Only one preview or recovery job can run per tenant at a time.
- **Reference**: <https://learn.microsoft.com/graph/api/resources/entrarecoveryservices-recoverypreviewjob?view=graph-rest-beta>

## Parameters

| Parameter | Description |
| --- | --- |
| `SnapshotId` | Snapshot ID from the output of Get-GsaEntraSnapshot.ps1. |
| `EntityTypes` | Directory object types to include in the preview scope. Defaults to the GSA-relevant set. |
| `TenantId` | Target Microsoft Entra tenant ID. |
| `UseManagedIdentity` | Authenticate using the current managed identity. Use in Azure Automation. |
| `ClientId` | App registration client ID. Required with CertificateThumbprint. |
| `CertificateThumbprint` | Certificate thumbprint for service principal authentication. |

## Examples

```powershell
.\Start-GsaEntraRecoveryPreview.ps1 -SnapshotId "MjAyNi0w..." -UseManagedIdentity
```

## Script

```powershell
<#
.SYNOPSIS
    Creates a scoped Microsoft Entra recovery preview job for GSA-related objects.
.DESCRIPTION
    Creates a recoveryPreviewJob against a chosen tenant snapshot, scoped to
    entity types that affect Global Secure Access: Conditional Access policies,
    named locations, applications, and service principals. The preview job is a
    non-destructive dry run.

    After the job reaches status 'succeeded', call the getChanges function
    against the returned PreviewJobUri to enumerate the objects and property
    changes that a recovery would apply.

    Use Get-GsaEntraSnapshot.ps1 to retrieve available SnapshotId values.
.PARAMETER SnapshotId
    Snapshot ID from the output of Get-GsaEntraSnapshot.ps1.
.PARAMETER EntityTypes
    Directory object types to include in the preview scope. Defaults to the
    GSA-relevant set.
.PARAMETER TenantId
    Target Microsoft Entra tenant ID.
.PARAMETER UseManagedIdentity
    Authenticate using the current managed identity. Use in Azure Automation.
.PARAMETER ClientId
    App registration client ID. Required with CertificateThumbprint.
.PARAMETER CertificateThumbprint
    Certificate thumbprint for service principal authentication.
.EXAMPLE
    .\Start-GsaEntraRecoveryPreview.ps1 -SnapshotId "MjAyNi0w..." -UseManagedIdentity
.NOTES
    Required Graph permissions:
        BackupRestore-Configuration.ReadWrite.All (application or delegated)
    Required Entra role:
        Microsoft Entra Backup Administrator
    Minimum module versions:
        Microsoft.Graph.Authentication 2.x
    Beta API: subject to change per Microsoft Graph versioning policy.
    Only one preview or recovery job can run per tenant at a time.
    Reference: https://learn.microsoft.com/graph/api/resources/entrarecoveryservices-recoverypreviewjob?view=graph-rest-beta
    Author: GSA Operations
#>

[CmdletBinding(DefaultParameterSetName = 'Interactive')]
param(
    [Parameter(Mandatory)]
    [string]$SnapshotId,

    [ValidateSet('conditionalAccessPolicy', 'namedLocation', 'application', 'servicePrincipal', 'group', 'user', 'appRoleAssignment', 'oAuth2PermissionGrant')]
    [string[]]$EntityTypes = @('conditionalAccessPolicy', 'namedLocation', 'application', 'servicePrincipal'),

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
        default            { Connect-MgGraph -TenantId $TenantId -Scopes 'BackupRestore-Configuration.ReadWrite.All' -NoWelcome | Out-Null }
    }
    Write-Verbose "Connected to Microsoft Graph."
} catch {
    Write-Error "Failed to authenticate to Microsoft Graph: $_"
    return
}

# Build scoped preview job payload
$body = @{
    filters = @(
        @{
            '@odata.type' = '#microsoft.graph.entraRecoveryServices.entityTypeFilter'
            entityTypes   = $EntityTypes
        }
    )
} | ConvertTo-Json -Depth 5

# Create preview job
try {
    $uri      = "https://graph.microsoft.com/beta/directory/recovery/snapshots/$SnapshotId/recoveryPreviewJobs"
    $response = Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body -ContentType 'application/json' -ResponseHeadersVariable headers -StatusCodeVariable status
    if ($status -ne 202) {
        throw "Unexpected status code $status when creating preview job."
    }
} catch {
    Write-Error "Failed to create recovery preview job. Verify the Microsoft Entra Backup Administrator role and BackupRestore-Configuration.ReadWrite.All permission. Error: $_"
    return
}

$jobUrl = $headers.Location | Select-Object -First 1
if (-not $jobUrl) {
    Write-Warning "No Location header returned. Inspect the response manually."
    return
}

[PSCustomObject]@{
    SnapshotId     = $SnapshotId
    EntityTypes    = $EntityTypes
    PreviewJobUri  = $jobUrl
    CreatedAt      = (Get-Date)
    NextSteps      = "Poll PreviewJobUri until status=succeeded, then call {PreviewJobUri}/getChanges"
}
```

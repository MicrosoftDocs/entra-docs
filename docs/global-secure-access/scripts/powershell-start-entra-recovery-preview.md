---
title: PowerShell sample - Preview a Microsoft Entra recovery for Global Secure Access objects
description: "Create a non-destructive Microsoft Entra recovery preview job scoped to directory objects that affect Global Secure Access."
ms.topic: sample
ms.date: 06/17/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Preview a Microsoft Entra recovery for Global Secure Access objects

This script creates a non-destructive Microsoft Entra recovery preview job against a selected snapshot. Use the preview output to review what a recovery would change before you start a recovery job.

The Microsoft Entra Backup and Recovery APIs are in Microsoft Graph beta. Only one preview or recovery job can run per tenant at a time.

## Prerequisites

- PowerShell 7.0 or later.
- Install the modules listed in the script's `.NOTES` block.
- Use only permissions and roles that your organization has approved for the task.

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
        EntraBackup.ReadWrite.Preview (delegated only)
    Required Entra role:
        Entra Backup Administrator
    Minimum module versions:
        Microsoft.Graph.Authentication 2.x
    Beta API: subject to change per Microsoft Graph versioning policy.
    Only one preview or recovery job can run per tenant at a time.
    Reference: https://learn.microsoft.com/en-us/graph/api/resources/entrarecoveryservices-recoverypreviewjob?view=graph-rest-beta
    Author: GSA Operations
#>

[CmdletBinding(DefaultParameterSetName = 'Interactive')]
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
    [switch]$UseManagedIdentity
)

$ErrorActionPreference = 'Stop'

# Authenticate
try {
    switch ($PSCmdlet.ParameterSetName) {
        'ManagedIdentity'  { Connect-MgGraph -Identity -NoWelcome | Out-Null }
        'ServicePrincipal' { Connect-MgGraph -TenantId $TenantId -ClientId $ClientId -CertificateThumbprint $CertificateThumbprint -NoWelcome | Out-Null }
        default            { Connect-MgGraph -TenantId $TenantId -Scopes 'EntraBackup.ReadWrite.Preview' -NoWelcome | Out-Null }
    }
    Write-Verbose "Connected to Microsoft Graph."
} catch {
    throw "Failed to authenticate to Microsoft Graph: $_"
}

# Build scoped preview job payload
$body = @{
    filteringCriteria = @{
        '@odata.type' = '#microsoft.graph.entraRecoveryServices.recoveryJobEntityNamesFilter'
        entityTypes   = $EntityTypes
    }
} | ConvertTo-Json -Depth 5

# Create preview job
try {
    $uri      = "https://graph.microsoft.com/beta/directory/recovery/snapshots/$SnapshotId/recoveryPreviewJobs"
    $response = Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body -ContentType 'application/json' -ResponseHeadersVariable headers -StatusCodeVariable status
    if ($status -ne 202) {
        throw "Unexpected status code $status when creating preview job."
    }
} catch {
    throw "Failed to create recovery preview job. Verify the Microsoft Entra Backup Administrator role and EntraBackup.ReadWrite.Preview permission. Error: $_"
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

## Related content

- [Global Secure Access PowerShell samples](../powershell-samples.md)
- [Microsoft Entra Global Secure Access operations guide](../overview-operations.md)

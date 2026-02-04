---
title: Restore group policy objects from backups in Microsoft Entra Domain Services | Microsoft Docs
description: Learn how to restore group policy objects in a Microsoft Entra Domain Services managed domain.
author: JamesNyamu

ms.service: entra-id
ms.author: janyamu
ms.topic: how-to
ms.date: 10/07/2025
---

# Group Policy (Private Preview)

Group Policy Objects (GPOs) are collections of policy settings that define how computer systems and user accounts behave within a Windows Active Directory domain environment. GPOs serve as the primary mechanism for centralized configuration management, security enforcement, and administrative control across Windows networks.

## Backup Feature Overview

The Group Policy Backup feature is a new capability added to the Domain Health Monitor that automatically creates and manages backups of Group Policy Objects (GPOs) in Active Directory Domain Services. This feature helps ensure business continuity and disaster recovery by maintaining regular backups of critical group policies.

## File System Structure

### Backup Location

- **Domain Controller**: `\\<PDC-Server>`

- **Network Share**: `GPOBackupsShare$` (hidden share)

- **Full Path**: `\\<PDC-Server>\GPOBackupsShare$\GPO\Backups`


### Directory Structure

```
(omitted for brevity)\GPO\Backups

├── MMddyyyyHHmm\          # Timestamp folder (e.g., 092520251430)

│   ├── {GUID-1}\          # Individual GPO backup folder

│   ├── {GUID-2}\          # Individual GPO backup folder

│   └── ...

├── MMddyyyyHHmm\          # Previous backup

│   └── ...

└── ...
```

## Functionality

#### Network Share Creation

Creates an encrypted SMB (Server Message Block) share with the following characteristics:

- **Share Name**: `GPOBackupsShare$` (hidden)
- **Encryption**: Enabled for security
- **Permissions**:
  - **Full Access**: Domain Admins
  - **Read Access**: AAD (Azure Active Directory) DC Admins

## Security Considerations

### Permissions

- **Folder Permissions**: 
  - Domain Admins: Full Control
  - AAD DC Admins: Read Access

- **Share Permissions**: 
  - Encrypted SMB share for network access
  - Hidden share (`$` suffix) for security through obscurity

### Access Control

The backup location and network share are configured with appropriate Active Directory security groups to ensure only authorized administrators can access the backup data.

## Usage Examples

### Verifying Backups

```powershell
# Check backup location
Get-ChildItem "\\<PDC-Server>\GPOBackupsShare$\GPO\Backups"
```

### Manual Cleanup

```powershell
# The feature handles cleanup automatically, but for manual operations:
Get-ChildItem "\\<PDC-Server>\GPOBackupsShare$\GPO\Backups" | Where-Object { $\_.CreationTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Recurse -Force
```

This section describes how an administrator on a domain-joined computer can discover, access, and restore Group Policy Object (GPO) backups created by this feature. Both GUI (GPMC) and PowerShell workflows are provided.

### Prerequisites

- You have network connectivity to at least one writable domain controller (ideally the PDC (Primary Domain Controller) Emulator).
- Your account is a member of a group with rights to read (AAD DC Admins) or modify (Domain Admins) GPOs.
- RSAT (Remote Server Administration Tools) Group Policy Management Console (GPMC) installed (for GUI restoration).
- PowerShell `GroupPolicy` module available (shipped with RSAT / on domain controllers by default).

### Determining the PDC Emulator (If Needed)

Although the code attempts to resolve and publish the share on the PDC, you can explicitly discover the PDC Emulator using either:

```powershell
Get-ADDomain | Select-Object PDCEmulator
```

Or (legacy / without AD module):

```
nltest /dsgetdc:<yourDomainFQDN> /pdc
```

Take the short hostname (left of the first dot) for UNC (Universal Naming Convention) paths.

### Accessing the Backup Share (Domain-Joined Workstation)

1. Press Win+R, enter a UNC path:

```powershell
"\\<PDC-Server>\GPOBackupsShare$"
```

2. (Optional) Map a drive letter:

```powershell
New-PSDrive -Name GPOBK -PSProvider FileSystem -Root "\\<PDC-Server>\GPOBackupsShare$" -Persist
```

3. Browse timestamp folders (format `MMddyyyyHHmm`). Each subfolder contains GUID-named folders for each backed-up GPO.

### Backup Folder Layout Recap

```powershell
\\<PDC-Server>\GPOBackupsShare$\<TimestampFolder>\{GPO-GUID}\
  +-- backup.xml          (metadata, if present)
  +-- GPO.tmf / Gpt.ini / Machine / User  (typical structural contents)
  +-- (Optional manifest files depending on API)
```

> [!NOTE]
> The exact file set may vary depending on the provider implementation, but a GUID folder per GPO is the key identity.

### Identifying the Correct Backup

You can correlate a GUID to a friendly GPO name:

```powershell
Get-GPO -All | Where-Object Id -eq '{GUID-HERE}' | Select DisplayName, Id
```

Or search by name across GUID folders (if `backup.xml` or `gpreport.xml` exists):

```powershell
Get-ChildItem "\\<PDC-Server>\GPOBackupsShare$" -Directory -Recurse -Depth 2 | Where-Object { Test-Path (Join-Path $\_.FullName 'backup.xml') } |
  ForEach-Object {
    [xml]$meta = Get-Content (Join-Path $\_.FullName 'backup.xml') -ErrorAction SilentlyContinue

    if ($meta.BackupInformation.GPOName) {
      [pscustomobject]@{ Folder=$\_.FullName; GPOName=$meta.BackupInformation.GPOName; GPOId=$meta.BackupInformation.GPOID }
    }
  }
```

If metadata is absent, rely on the GPO GUID from production (`Get-GPO -All`).

### Restoring a GPO via GUI (GPMC)

1. Launch "Group Policy Management" (GPMC.msc).

2. In the left tree, right-click the **Group Policy Objects** container (or an individual GPO if performing an in-place restore).

3. Choose **Manage Backups…**.

4. Click **Browse** and select the timestamp folder path:

```powershell
\\<PDC-Server>\GPOBackupsShare$\<TimestampFolder>
```

5. The list populates with discoverable backups. Select the target GPO backup.

6. Decide between:

    - **Restore**: Overwrites the existing GPO (matching GUID) in-place.
    - **Restore To…**: Lets you restore to a *different* GPO (choose existing target).
    - **Copy** (if available): Create a new GPO from backup (GUID changes; links must be re-established manually).

7. Confirm the operation. Review the results pane for success/failure.

8. Relink or validate security filtering / WMI (Windows Management Instrumentation) filters as needed (see below).

#### Post-Restore Validation

- Run: `gpresult /h report.html` on a target workstation to confirm policy application.
- Use **GPO Status** in GPMC to ensure both User and Computer portions are enabled.
- Validate WMI filter association (WMI filters are not always embedded inside raw file-level backups and may need reassociation).

### Restoring a GPO via PowerShell

The `GroupPolicy` module provides `Restore-GPO`, `Import-GPO`, and `New-GPO` for different scenarios.

#### 1. In-Place Restore (Same GUID)

```powershell
$timestampFolder = '092520251430'              # Example

$pdc = (Get-ADDomain).PDCEmulator.Split('.')[0]

$backupRoot = "\\<PDC-Server>\GPOBackupsShare$\$timestampFolder"

# List available backups in that timestamp folder
Get-GPOBackup -Path $backupRoot | Format-Table DisplayName, Id, CreationTime

# Restore specific GPO by name (must already exist in domain)
Restore-GPO -Name 'My Application Baseline' -Path $backupRoot -Confirm:$false
```

#### 2. Restore When Original GPO Was Deleted

If the original GPO (GUID) is gone, you have two options:
    
1. Recreate with Original GUID (Only if you know the GUID and want to keep it):

```powershell
  $backup = Get-GPOBackup -Path $backupRoot | Where-Object { $\_.DisplayName -eq 'My Application Baseline' }
  
  Restore-GPO -Guid $backup.Id -Path $backupRoot -CreateIfNeeded
```

2. Option B – Create a New GPO and Import Settings:

```powershell
  $newGpo = New-GPO -Name 'My Application Baseline (Restored)'
  
  Import-GPO -TargetName $newGpo.DisplayName -BackupId $backup.Id -Path $backupRoot -CreateIfNeeded
```

#### 3. Select Backup by GUID Only

```powershell
$gpoGuid = '{12345678-90AB-CDEF-1234-567890ABCDEF}'

Restore-GPO -Guid $gpoGuid -Path $backupRoot -Confirm:$false
```

#### 4. Copy Backup to a New GPO (Preserve Original for Forensics)

```powershell
$backup = Get-GPOBackup -Path $backupRoot | Where-Object DisplayName -eq 'Legacy GPO'

$copy = New-GPO -Name "Recovered - $($backup.DisplayName)"

Import-GPO -BackupId $backup.Id -TargetName $copy.DisplayName -Path $backupRoot
```

#### 5. Cross-Domain / Lab Import

Copy the entire timestamp folder to the target domain's admin workstation (retain structure) and run:

```powershell
Get-GPOBackup -Path 'C:\Temp\GPOBackups\092520251430' | ForEach-Object {

  $existing = Get-GPO -All | Where-Object Id -eq $\_.Id -ErrorAction SilentlyContinue

  if ($existing) {
    Restore-GPO -Guid $\_.Id -Path 'C:\Temp\GPOBackups\092520251430' -Confirm:$false
  } else {
    New-GPO -Name $\_.DisplayName | Out-Null

    Import-GPO -BackupId $\_.Id -TargetName $\_.DisplayName -Path 'C:\Temp\GPOBackups\092520251430'
  }
}
```

> [!NOTE]
> Ensure any domain-specific security principals inside the GPO (delegation ACLs, group SIDs (Security Identifier) in preferences) are reviewed after cross-domain imports.

### Handling Linked Objects and Dependencies

Restoring raw GPO content does *not* automatically:

- Relink the GPO to OUs (links are preserved for in-place restore; new GPOs need manual linking).

- Recreate WMI filters (must exist; reassign if lost).

- Rebuild security filtering if domain SIDs differ (in cross-domain scenarios).

#### ReLinking Example

```powershell
New-GPLink -Name 'My Application Baseline (Restored)' -Target 'OU=Workstations,DC=contoso,DC=com' -Enforced:$false
```

#### Re-Associate WMI Filter

```powershell
Set-GPWmiFilter -Guid '{RESTORED-GPO-GUID}' -WmiFilter (Get-GPWmiFilter -All | Where-Object Name -eq 'Win11Only')
```

### Verification and Reporting

To confirm settings, generate an HTML report:

```powershell
Get-GPO -Name 'My Application Baseline' | Get-GPOReport -ReportType Html -Path .\BaselineReport.html

Start-Process .\BaselineReport.html
```

Force a client to refresh and inspect Resultant Set of Policy (RSoP):

```powershell
Invoke-GPUpdate -Computer 'CLIENT01' -RandomDelayInMinutes 0
```

### Rollback Strategy

If a restored GPO introduces issues:

1. Use another (earlier) timestamp folder and rerun `Restore-GPO` with that backup.

2. Or disable the GPO (set both User and Computer configurations to Disabled) while investigating.

3. To ensure easy rollback path, maintain at least two recent timestamp folders.

### Common Restoration Pitfalls

| Issue | Cause | Resolution |
|-------|-------|-----------|
| `Get-GPOBackup` returns nothing | Wrong path depth (pointed at root instead of timestamp folder) | Point `-Path` to specific timestamp folder, not higher-level parent |
| `Access denied` on share | Missing group membership or blocked firewall | Confirm membership in Domain Admins / AAD DC Admins; verify SMB inbound rules |
| GPO links missing after import | Used Import-GPO to new GPO | Re-create links manually with `New-GPLink` |
| WMI filter missing | Not included / not recreated | Recreate filter in GPMC and reassign |
| Security filtering ineffective | SID mismatch (cross-domain) | readd groups from target domain |

### Minimal End-to-End PowerShell Example

```powershell
# Variables

$pdc = (Get-ADDomain).PDCEmulator.Split('.')[0]

$latestTimestamp = Get-ChildItem "\\<PDC-Server>\GPOBackupsShare$" -Directory | Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty Name

$backupPath = "\\<PDC-Server>\GPOBackupsShare$\$latestTimestamp"

$gpoName = 'Baseline Workstation Policy'

# Inspect backups
Get-GPOBackup -Path $backupPath | Where-Object DisplayName -eq $gpoName

# Restore (in-place)
Restore-GPO -Name $gpoName -Path $backupPath -Confirm:$false

# Report
Get-GPO -Name $gpoName | Get-GPOReport -ReportType Html -Path .\Restored.html

Start-Process .\Restored.html
```

---

With these procedures, administrators can reliably identify, retrieve, and restore GPO backups whether performing routine recovery, migration to a lab, or emergency rollback.

# Group Policy Backup Feature

## Overview

The Group Policy Backup feature is a new capability added to the Domain Health Monitor that automatically creates and manages backups of Group Policy Objects (GPOs) in Active Directory Domain Services. This feature helps ensure business continuity and disaster recovery by maintaining regular backups of critical group policies.

## Architecture

The feature consists of three main components:

1. **GroupPolicyBackupEvaluator** - Evaluates whether GPO backups are needed
2. **GroupPolicyBackupRemediator** - Performs the actual backup operations
3. **FileUtilitiesV2** - Provides enhanced file system operations

## Configuration

The feature is controlled by registry settings under the Domain Health Monitor key:

### Registry Key
```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Entra Domain Services\Domain Health Monitor
```

### Registry Values

| Value Name | Type | Default | Description |
|------------|------|---------|-------------|
| `BackupGroupPolicyEnabled` | DWORD | 0 (disabled) | Enables/disables the backup feature (1 = enabled, 0 = disabled) |
| `BackupGroupPolicyTimestampHours` | DWORD | 72 | Backup retention period in hours (default: 3 days) |

## File System Structure

### Backup Location
- **Primary Path**: `F:\GPO\Backups`
- **Network Share**: `GPOBackupsShare$` (hidden share)

### Directory Structure
```
F:\GPO\Backups\
├── MMddyyyyHHmm\          # Timestamp folder (e.g., 092520251430)
│   ├── {GUID-1}\          # Individual GPO backup folder
│   ├── {GUID-2}\          # Individual GPO backup folder
│   └── ...
├── MMddyyyyHHmm\          # Previous backup
│   └── ...
└── ...
```

## Functionality

### GroupPolicyBackupEvaluator

The evaluator runs as part of the Domain Health Monitor evaluation cycle and:

1. **Checks Feature Status**: Reads the `BackupGroupPolicyEnabled` registry value
2. **Validates Existing Backups**: Checks for existing backups in the backup location
3. **Evaluates Backup Age**: Determines if existing backups have expired based on the configured retention period
4. **Triggers Remediation**: If backups are missing or expired, triggers the backup remediator

#### Evaluation Logic
```csharp
bool backupMissing = gpoBackupTimestamp == DateTime.MinValue;
bool backupExpired = (DateTime.Now - gpoBackupTimestamp).TotalHours > groupPolicyBackupTimestampHours;

if (groupPolicyBackupFeatureEnabled && (backupMissing || backupExpired))
{
    // Trigger backup remediation
    return false;
}
```

### GroupPolicyBackupRemediator

The remediator performs the following operations:

1. **Space Monitoring**: Checks available disk space before and after operations
2. **Policy Enumeration**: Retrieves all group policy objects from Active Directory
3. **Selective Backup**: Backs up all GPOs except default domain policies
4. **Cleanup Operations**: Removes expired backups based on retention policy
5. **Share Management**: Ensures network share exists with proper permissions

#### Backup Process

1. **Enumerate GPOs**: Gets all group policy objects from the domain
2. **Filter Policies**: Excludes default domain policies:
   - Default Domain Policy (`{31B2F340-016D-11D2-945F-00C04FB984F9}`)
   - Default Domain Controllers Policy (`{6AC1786C-016F-11D2-945F-00C04fB984F9}`)
3. **Create Timestamped Folder**: Uses format `MMddyyyyHHmm`
4. **Backup Individual Policies**: Each GPO is backed up to its own subfolder named by GUID
5. **Error Handling**: If any backup fails, the entire backup session folder is deleted

#### Cleanup Process

1. **Retention Check**: Compares folder creation timestamps against retention policy
2. **Minimum Backup Preservation**: Always maintains at least one backup copy
3. **Expired Backup Removal**: Deletes backup folders older than the retention period

#### Network Share Creation

Creates an encrypted SMB share with the following characteristics:
- **Share Name**: `GPOBackupsShare$` (hidden)
- **Encryption**: Enabled for security
- **Permissions**:
  - **Full Access**: Domain Admins
  - **Read Access**: AAD DC Admins

### FileUtilitiesV2

Enhanced file system utilities providing:

- **Directory Operations**: Creation, deletion, permission management
- **Space Management**: Drive space monitoring and reporting
- **Timestamp Operations**: File and folder timestamp retrieval
- **Share Management**: SMB share creation and configuration

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

## Error Handling

### Backup Failures
- If any individual GPO backup fails, the entire backup session is rolled back
- Cleanup operations continue even if individual folder deletions fail
- PowerShell execution errors are logged but don't stop the overall process

### Space Management
- Monitors disk space before, during, and after operations
- Reports space usage changes for capacity planning
- Cleanup operations help manage storage consumption

## Logging

The feature provides comprehensive logging throughout the backup process:

- Feature enablement status
- Backup discovery and age evaluation
- Individual GPO backup operations
- Space utilization reporting
- Cleanup operations and decisions
- Share creation and permission setting
- Error conditions and exceptions

## Integration with Domain Health Monitor

### Evaluator Registration
The `GroupPolicyBackupEvaluator` is registered in the `EvaluatorFactory`:

```csharp
new GroupPolicyBackupEvaluator(),
```

### Execution Flow
1. Domain Health Monitor runs its evaluation cycle
2. `GroupPolicyBackupEvaluator` checks backup status
3. If remediation needed, `GroupPolicyBackupRemediator` is triggered
4. Backup operations are performed with full logging
5. Results are reported back to the Domain Health Monitor

## Testing

The implementation includes comprehensive unit tests covering:

### GroupPolicyBackupEvaluatorTests
- Feature enabled/disabled scenarios
- Backup missing conditions
- Backup expiration logic
- Registry value handling

### GroupPolicyBackupRemediatorTests
- Backup process execution
- Error handling and rollback
- Cleanup operations
- Share creation

### DomainControllerObjectTests
- Equality and hash code implementations
- Collection comparison logic

## Usage Examples

### Enabling the Feature
```powershell
# Enable GPO backup feature
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Entra Domain Services\Domain Health Monitor" -Name "BackupGroupPolicyEnabled" -Value 1

# Set retention to 7 days (168 hours)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Entra Domain Services\Domain Health Monitor" -Name "BackupGroupPolicyTimestampHours" -Value 168
```

### Verifying Backups
```powershell
# Check backup location
Get-ChildItem "F:\GPO\Backups" -Directory

# Access via network share (from another machine)
Get-ChildItem "\\PDC-SERVER\GPOBackupsShare$"
```

### Manual Cleanup
```powershell
# The feature handles cleanup automatically, but for manual operations:
Get-ChildItem "F:\GPO\Backups" | Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Recurse -Force
```

## Troubleshooting

### Common Issues

1. **Feature Not Running**
   - Verify registry settings are correctly configured
   - Check Domain Health Monitor logs for evaluation results

2. **Backup Failures**
   - Ensure sufficient disk space on F: drive
   - Verify Domain Health Monitor service has appropriate permissions
   - Check for GPO corruption or access issues

3. **Share Access Issues**
   - Verify network share exists: `Get-SmbShare -Name "GPOBackupsShare$"`
   - Check share permissions match expected security groups
   - Ensure encryption is enabled on the share

4. **Space Issues**
   - Monitor disk space usage in logs
   - Adjust retention period if backups consume too much space
   - Consider external cleanup if automated cleanup fails

### Log Locations
Domain Health Monitor logs contain detailed information about the backup feature operations. Look for entries prefixed with:
- `GroupPolicyBackupEvaluator:`
- `GroupPolicyBackupRemediator:`

## Future Enhancements

Potential improvements to consider:

1. **Compression**: Add backup compression to reduce storage usage
2. **Remote Storage**: Support for backing up to remote/cloud storage
3. **Incremental Backups**: Only backup changed GPOs
4. **Notification**: Email/alert integration for backup success/failure
5. **Restoration Tools**: Automated GPO restoration capabilities
6. **Scheduling**: More granular backup scheduling options

## Accessing the GPO Backup Share & Restoring GPOs

This section describes how an administrator on a domain-joined computer can discover, access, and restore Group Policy Object (GPO) backups created by this feature. Both GUI (GPMC) and PowerShell workflows are provided.

### Prerequisites

- The feature is enabled (`BackupGroupPolicyEnabled=1`).
- You have network connectivity to at least one writable domain controller (ideally the PDC Emulator).
- Your account is a member of a group with rights to read (AAD DC Admins) or modify (Domain Admins) GPOs.
- The hidden backup share `GPOBackupsShare$` exists (created automatically by the remediator).
- RSAT Group Policy Management Console (GPMC) installed (for GUI restoration).
- PowerShell `GroupPolicy` module available (shipped with RSAT / on domain controllers by default).

### Determining the PDC Emulator (If Needed)

Although the code attempts to resolve and publish the share on the PDC, you can explicitly discover the PDC Emulator using either:

```powershell
Get-ADDomain | Select-Object PDCEmulator
```

or (legacy / without AD module):

```powershell
nltest /dsgetdc:<yourDomainFQDN> /pdc
```

Take the short hostname (left of the first dot) for UNC paths.

### Accessing the Backup Share (Domain-Joined Workstation)

1. Press Win+R, enter a UNC path:
    ```
    \\<PDCShortName>\GPOBackupsShare$
    ```
2. (Optional) Map a drive letter:
    ```powershell
    New-PSDrive -Name GPOBK -PSProvider FileSystem -Root "\\<PDCShortName>\GPOBackupsShare$" -Persist
    ```
3. Browse timestamp folders (format `MMddyyyyHHmm`). Each subfolder contains GUID-named folders for each backed-up GPO.

### Backup Folder Layout Recap

```
\\<PDCShortName>\GPOBackupsShare$\<TimestampFolder>\{GPO-GUID}\
      +-- backup.xml          (metadata, if present)
      +-- GPO.tmf / Gpt.ini / Machine / User  (typical structural contents)
      +-- (Optional manifest files depending on API)
```

> Note: The exact file set may vary depending on the provider implementation, but a GUID folder per GPO is the key identity.

### Identifying the Correct Backup

You can correlate a GUID to a friendly GPO name:

```powershell
Get-GPO -All | Where-Object Id -eq '{GUID-HERE}' | Select DisplayName, Id
```

Or search by name across GUID folders (if `backup.xml` or `gpreport.xml` exists):

```powershell
Get-ChildItem "\\<PDCShortName>\GPOBackupsShare$" -Directory -Recurse -Depth 2 | Where-Object { Test-Path (Join-Path $_.FullName 'backup.xml') } |
   ForEach-Object {
      [xml]$meta = Get-Content (Join-Path $_.FullName 'backup.xml') -ErrorAction SilentlyContinue
      if ($meta.BackupInformation.GPOName) {
         [pscustomobject]@{ Folder=$_.FullName; GPOName=$meta.BackupInformation.GPOName; GPOId=$meta.BackupInformation.GPOID }
      }
   }
```

If metadata is absent, rely on the GPO GUID from production (`Get-GPO -All`).

### Restoring a GPO via GUI (GPMC)

1. Launch "Group Policy Management" (GPMC.msc).
2. In the left tree, right-click the **Group Policy Objects** container (or an individual GPO if performing an in-place restore).
3. Choose **Manage Backups…**.
4. Click **Browse** and select the timestamp folder path:
    ```
    \\<PDCShortName>\GPOBackupsShare$\<TimestampFolder>
    ```
5. The list populates with discoverable backups. Select the target GPO backup.
6. Decide between:
    - **Restore**: Overwrites the existing GPO (matching GUID) in-place.
    - **Restore To…**: Lets you restore to a *different* GPO (choose existing target).
    - **Copy** (if available): Create a new GPO from backup (GUID changes; links must be re-established manually).
7. Confirm the operation. Review the results pane for success/failure.
8. Re-link or validate security filtering / WMI filters as needed (see below).

#### Post-Restore Validation

- Run: `gpresult /h report.html` on a target workstation to confirm policy application.
- Use **GPO Status** in GPMC to ensure both User & Computer portions are enabled.
- Validate WMI filter association (WMI filters are not always embedded inside raw file-level backups and may need re-association).

### Restoring a GPO via PowerShell

The `GroupPolicy` module provides `Restore-GPO`, `Import-GPO`, and `New-GPO` for different scenarios.

#### 1. In-Place Restore (Same GUID)

```powershell
$timestampFolder = '092520251430'              # Example
$pdc = (Get-ADDomain).PDCEmulator.Split('.')[0]
$backupRoot = "\\$pdc\GPOBackupsShare$\$timestampFolder"

# List available backups in that timestamp folder
Get-GPOBackup -Path $backupRoot | Format-Table DisplayName, Id, CreationTime

# Restore specific GPO by name (must already exist in domain)
Restore-GPO -Name 'My Application Baseline' -Path $backupRoot -Confirm:$false
```

#### 2. Restore When Original GPO Was Deleted

If the original GPO (GUID) is gone, you have two options:

Option A – Recreate with Original GUID (Only if you know the GUID and want to keep it):
```powershell
$backup = Get-GPOBackup -Path $backupRoot | Where-Object { $_.DisplayName -eq 'My Application Baseline' }
Restore-GPO -Guid $backup.Id -Path $backupRoot -CreateIfNeeded
```

Option B – Create a New GPO and Import Settings:
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
   $existing = Get-GPO -All | Where-Object Id -eq $_.Id -ErrorAction SilentlyContinue
   if ($existing) {
      Restore-GPO -Guid $_.Id -Path 'C:\Temp\GPOBackups\092520251430' -Confirm:$false
   } else {
      New-GPO -Name $_.DisplayName | Out-Null
      Import-GPO -BackupId $_.Id -TargetName $_.DisplayName -Path 'C:\Temp\GPOBackups\092520251430'
   }
}
```

> Ensure any domain-specific security principals inside the GPO (delegation ACLs, group SIDs in preferences) are reviewed after cross-domain imports.

### Handling Linked Objects & Dependencies

Restoring raw GPO content does *not* automatically:

- Re-link the GPO to OUs (links are preserved for in-place restore; new GPOs need manual linking).
- Recreate WMI filters (must exist; reassign if lost).
- Rebuild security filtering if domain SIDs differ (in cross-domain scenarios).

#### Re-Linking Example
```powershell
New-GPLink -Name 'My Application Baseline (Restored)' -Target 'OU=Workstations,DC=contoso,DC=com' -Enforced:$false
```

#### Re-Associate WMI Filter
```powershell
Set-GPWmiFilter -Guid '{RESTORED-GPO-GUID}' -WmiFilter (Get-GPWmiFilter -All | Where-Object Name -eq 'Win11Only')
```

### Verification & Reporting

Generate an HTML report to confirm settings:

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

1. Use another (earlier) timestamp folder and re-run `Restore-GPO` with that backup.
2. Or disable the GPO (set both User & Computer configurations to Disabled) while investigating.
3. Maintain at least two recent timestamp folders to ensure easy rollback path.

### Common Restoration Pitfalls

| Issue | Cause | Resolution |
|-------|-------|-----------|
| `Get-GPOBackup` returns nothing | Wrong path depth (pointed at root instead of timestamp folder) | Point `-Path` to specific timestamp folder, not higher-level parent |
| `Access denied` on share | Missing group membership or blocked firewall | Confirm membership in Domain Admins / AAD DC Admins; verify SMB inbound rules |
| GPO links missing after import | Used Import-GPO to new GPO | Re-create links manually with `New-GPLink` |
| WMI filter missing | Not included / not recreated | Recreate filter in GPMC and reassign |
| Security filtering ineffective | SID mismatch (cross-domain) | Re-add groups from target domain |

### Minimal End-to-End PowerShell Example

```powershell
# Variables
$pdc = (Get-ADDomain).PDCEmulator.Split('.')[0]
$latestTimestamp = Get-ChildItem "\\$pdc\GPOBackupsShare$" -Directory | Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty Name
$backupPath = "\\$pdc\GPOBackupsShare$\$latestTimestamp"
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
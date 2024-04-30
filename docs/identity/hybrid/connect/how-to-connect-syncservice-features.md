---
title: Microsoft Entra Connect Sync service features and configuration
description: Describes service side features for Microsoft Entra Connect Sync service.

author: billmath
manager: amycolannino
ms.assetid: 213aab20-0a61-434a-9545-c4637628da81
ms.service: entra-id
ms.tgt_pltfrm: na
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath


---
# Microsoft Entra Connect Sync service features

The synchronization feature of Microsoft Entra Connect has two components:

* The on-premises component named **Microsoft Entra Connect Sync**, also called **sync engine**.
* The service residing in Microsoft Entra ID also known as **Microsoft Entra Connect Sync service**

This topic explains how the following features of the **Microsoft Entra Connect Sync service** work and how you can configure them using PowerShell.

To see the configuration in your Microsoft Entra directory using the Graph PowerShell, use the following commands:

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.Read.All"

Get-MgDirectoryOnPremiseSynchronization | Select-Object -ExpandProperty Features | Format-List
```

The result looks like this output:

```powershell
BlockCloudObjectTakeoverThroughHardMatchEnabled  : False
BlockSoftMatchEnabled                            : False
BypassDirSyncOverridesEnabled                    : False
CloudPasswordPolicyForPasswordSyncedUsersEnabled : False
ConcurrentCredentialUpdateEnabled                : False
ConcurrentOrgIdProvisioningEnabled               : False
DeviceWritebackEnabled                           : False
DirectoryExtensionsEnabled                       : True
FopeConflictResolutionEnabled                    : False
GroupWriteBackEnabled                            : False
PasswordSyncEnabled                              : True
PasswordWritebackEnabled                         : False
QuarantineUponProxyAddressesConflictEnabled      : False
QuarantineUponUpnConflictEnabled                 : False
SoftMatchOnUpnEnabled                            : True
SynchronizeUpnForManagedUsersEnabled             : False
UnifiedGroupWritebackEnabled                     : True
UserForcePasswordChangeOnLogonEnabled            : False
UserWritebackEnabled                             : True
AdditionalProperties                             : {}
```

After you have enabled a feature, it can't be disabled again.

> [!NOTE]
> From August 24, 2016 the feature *Duplicate attribute resiliency* is enabled by default for new Microsoft Entra directories. This feature will also be rolled out and enabled on directories created before this date. You will receive an email notification when your directory is about to get this feature enabled.
> 
> 

The following settings are configured by Microsoft Entra Connect:

| DirSyncFeature | Comment |
| --- | --- |
| SoftMatchOnUpn |Allows objects to join on userPrincipalName in addition to primary SMTP address. |
| SynchronizeUpnForManagedUsers |Allows the sync engine to update the userPrincipalName attribute for managed/licensed (non-federated) users. |
| DeviceWriteback |[Microsoft Entra Connect: Enabling device writeback](how-to-connect-device-writeback.md) |
| DirectoryExtensions |[Microsoft Entra Connect Sync: Directory extensions](how-to-connect-sync-feature-directory-extensions.md) |
| [DuplicateProxyAddressResiliency<br/>DuplicateUPNResiliency](#duplicate-attribute-resiliency) |Allows an attribute to be quarantined when it's a duplicate of another object rather than failing the entire object during export. |
| Password Hash Sync |[Implementing password hash synchronization with Microsoft Entra Connect Sync](how-to-connect-password-hash-synchronization.md) |
|Pass-through Authentication|[User sign-in with Microsoft Entra pass-through authentication](how-to-connect-pta.md)|
| UnifiedGroupWriteback |Group writeback|
| UserWriteback |Not currently supported. |

## Duplicate attribute resiliency

Instead of failing to provision objects with duplicate UPNs / proxyAddresses, the duplicated attribute is “quarantined” and a temporary value is assigned. When the conflict is resolved, the temporary UPN is changed to the proper value automatically. For more details, see [Identity synchronization and duplicate attribute resiliency](how-to-connect-syncservice-duplicate-attribute-resiliency.md).

## UserPrincipalName soft match

When this feature is enabled, soft-match is enabled for UPN in addition to the [primary SMTP address](https://support.microsoft.com/kb/2641663), which is always enabled. Soft-match is used to match existing cloud users in Microsoft Entra ID with on-premises users.

If you need to match on-premises AD accounts with existing accounts created in the cloud and you aren't using Exchange Online, then this feature is useful. In this scenario, you generally don’t have a reason to set the SMTP attribute in the cloud.

This feature is on by default for newly created Microsoft Entra directories. You can see if this feature is enabled for you by running:  

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.Read.All"

$DirectorySync = Get-MgDirectoryOnPremiseSynchronization
$DirectorySync.Features.SoftMatchOnUpnEnabled
```

If this feature isn't enabled for your Microsoft Entra directory, then you can enable it by running:  

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

$SoftMatchOnUpn = @{ SoftMatchOnUpnEnabled = "true" }
Update-MgDirectoryOnPremiseSynchronization -Features $SoftMatchOnUpn `
   -OnPremisesDirectorySynchronizationId $DirectorySync.Id
```

## BlockSoftMatch

When this feature is enabled, it blocks the Soft Match feature. Customers are encouraged to enable this feature and keep it at enabled until Soft Matching is required again for their tenancy. This flag should be enabled again after any soft matching has completed and is no longer needed.

Example - to block soft matching in your tenant, run this cmdlet:

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

$SoftBlock = @{ BlockSoftMatchEnabled = "true" }
Update-MgDirectoryOnPremiseSynchronization -Features $SoftBlock `
   -OnPremisesDirectorySynchronizationId $DirectorySync.Id
```

## Synchronize userPrincipalName updates

Historically, updates to the UserPrincipalName attribute using the sync service from on-premises has been blocked, unless both of these conditions were true:

* The user is managed (non-federated).
* The user hasn't been assigned a license.

> [!NOTE]
> From March 2019, synchronizing UPN changes for federated user accounts is allowed.
> 

Enabling this feature allows the sync engine to update the userPrincipalName when it is changed on-premises and you use password hash sync or pass-through authentication.

This feature is on by default for newly created Microsoft Entra directories. You can see if this feature is enabled for you by running:  

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.Read.All"

$DirectorySync = Get-MgDirectoryOnPremiseSynchronization
$DirectorySync.Features.SynchronizeUpnForManagedUsersEnabled
```

If this feature isn't enabled for your Microsoft Entra directory, then you can enable it by running:  

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

$SyncUpnManagedUsers = @{ SynchronizeUpnForManagedUsersEnabled = "true" }
Update-MgDirectoryOnPremiseSynchronization -Features $SyncUpnManagedUsers `
   -OnPremisesDirectorySynchronizationId $DirectorySync.Id
```

After enabling this feature, existing userPrincipalName values will remain as-is. On next change of the userPrincipalName attribute on-premises, the normal delta sync on users will update the UPN.  

## See also

* [Microsoft Entra Connect Sync](how-to-connect-sync-whatis.md)
* [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).

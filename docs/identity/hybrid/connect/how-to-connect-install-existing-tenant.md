---
title: Configure Microsoft Entra Connect for an existing tenant
description: Learn how Microsoft Entra Connect matches and synchronizes on-premises objects with an existing Microsoft Entra tenant, and how to resolve hard match conflicts.
ms.custom: has-azure-ad-ps-ref, msecd-doc-authoring-1015
ms.topic: how-to
ms.date: 07/01/2026
ms.subservice: hybrid-connect
ai-usage: ai-assisted
#customer intent: As an IT administrator, I want to understand how Microsoft Entra Connect matches and synchronizes with existing Microsoft Entra ID objects so that I can onboard an existing tenant without data loss or blocked hard matches.
---

# Configure Microsoft Entra Connect for an existing tenant
Most of the articles about how to use Microsoft Entra Connect assume you start with a new Microsoft Entra tenant that has no users or other objects. But if you started with a Microsoft Entra tenant, populated it with users and other objects, and now want to use Connect, this article is for you.

## The basics
An object in Microsoft Entra ID is either managed in the cloud or on-premises. For one single object, you can't manage some attributes on-premises and some other attributes in Microsoft Entra ID. Each object has a flag indicating where the object is managed.

You can manage some users on-premises and others in the cloud. A common scenario for this configuration is an organization with a mix of accounting workers and sales workers. The accounting workers have an on-premises Active Directory (AD) account and the sales workers don't, but both have an account in Microsoft Entra ID. You would manage some users on-premises and some in Microsoft Entra ID.

There are some extra concerns you need to consider when you started to manage users in Microsoft Entra ID that are also present on-premises, and later want to use Microsoft Entra Connect.

<a name='sync-with-existing-users-in-azure-ad'></a>

## Sync with existing users in Microsoft Entra ID
When you start synchronizing with Microsoft Entra Connect, the Microsoft Entra service API checks every new incoming object and tries to find an existing object to match. There are three attributes used for this process: **userPrincipalName**, **proxyAddresses**, and **sourceAnchor**/**immutableID**. A match on **userPrincipalName** or **proxyAddresses** is known as a "**soft match**." A match on **sourceAnchor** is known as "**hard match**." For the **proxyAddresses** attribute, only the value with **SMTP:**, that is the primary email address, is used for the evaluation.

The match is only evaluated for new objects coming from on-premises AD. If you change an existing object so it matches any of these attributes, then you see an error instead.

If Microsoft Entra ID finds an object where the attribute values are the same as the new incoming object from Microsoft Entra Connect, then it takes over the object in Microsoft Entra ID and the previously cloud-managed object is converted to on-premises managed. All attributes in Microsoft Entra ID with a value in on-premises AD are overwritten with the respective on-premises value.

> [!WARNING]
> Since all attributes in Microsoft Entra ID are going to be overwritten by the on-premises value, make sure you have good data on-premises. For example, if you only manage the email address in Microsoft 365 and haven't kept it updated in on-premises Active Directory Domain Services (AD DS), then you lose any values in Microsoft Entra ID / Microsoft 365 that aren't present in AD DS.

> [!IMPORTANT]
> If you use password hash sync, which is always enabled with Express installation, then the password hash in Microsoft Entra ID is overwritten with the password hash from on-premises AD. If your users are used to managing different passwords, then you need to inform them that they should use the on-premises AD password.

Consider the preceding data-loss warning when you plan your deployment. If you made many changes in Microsoft Entra ID that weren't reflected in on-premises AD DS, then to prevent data loss, plan how to populate AD DS with the updated values from Microsoft Entra ID before you sync your objects with Microsoft Entra Connect.

If you matched your objects with a soft match, then the **sourceAnchor** is added to the object in Microsoft Entra ID so a hard match can be used later.

> [!IMPORTANT]
> Microsoft strongly recommends against synchronizing on-premises accounts with preexisting administrative accounts in Microsoft Entra ID.

### Hard match vs soft match
By default, the SourceAnchor value of an object, for example "abcdefghijklmnopqrstuv==", is the Base64 string representation of the mS-Ds-ConsistencyGUID attribute (or ObjectGUID depending on the configuration) from the on-premises Active Directory object. This value is set as the corresponding ImmutableId in Microsoft Entra ID.

When Microsoft Entra Connect or Cloud Sync adds new objects, the Microsoft Entra ID service tries to match the incoming object by using the sourceAnchor value corresponding to the ImmutableId attribute of existent objects in Microsoft Entra ID. If there's a match, Microsoft Entra Connect takes over the source of authority (SoA) of that object and updates it with the properties of the incoming on-premises Active Directory object in what's known as a *hard match*.
When Microsoft Entra ID can't find any object with an ImmutableId that matches the SourceAnchor value, it tries to use the incoming object's userPrincipalName or primary SMTP address to find a match in what's known as a *soft match*.

Both hard match and soft match try to match objects already present and managed in Microsoft Entra ID with the new incoming objects being added that represent the same on-premises entity. If Microsoft Entra ID isn't able to find a *hard match* or *soft match* for the incoming object, it provisions a new object in the Microsoft Entra ID directory.

If Microsoft Entra ID is able to *soft match* the new incoming object based on primary SMTP address with an existent object managed in Microsoft Entra ID, but this new object has a different sourceAnchor value, then Microsoft Entra ID attempts to provision a new object. The provisioning attempt normally results in a conflict where Microsoft Entra ID is unable to create the new object. This conflict occurs in situations such as:

- A different sourceAnchor value was set in `mS-Ds-ConsistencyGuid` attribute, on the original on-premises AD user that has already been synced to Entra ID.

- A new on-premises AD user was created with the same UPN and Primary SMTP address but has a different sourceAnchor and SID.

In such cases, an `AttributeValueMustBeUnique` export error is thrown in Microsoft Entra Connect or Cloud Sync. Depending on the incoming user properties this error might refer to one of the following attribute conflicts:

- *AttributeConflictName = OnPremiseSecurityIdentifier*: the new incoming object has a different sourceAnchor but the same OnPremiseSecurityIdentifier (SID) and primary SMTP address as the existent user in Entra ID directory. 

- *AttributeConflictName = ProxyAddresses*: the new incoming object has a different sourceAnchor and SID but has the same Primary SMTP address as the existent user in Entra ID directory. 

> [!NOTE]
> In some rare situations, an `OnPremiseSecurityIdentifier` conflict occurs due to an issue with on-premises AD RID Pool (for example, a Domain Controller recovered from backup), which can generate a new user with the same SID. In such cases, an `AttributeValueMustBeUnique` error is thrown when trying to provision the user not due to *soft match* attempts but because the `OnPremiseSecurityIdentifier` must be unique in Entra ID directory.

These scenarios typically mean that you're trying to reprovision the same user. To resolve the conflict, you should update the on-premises user's `mS-Ds-ConsistencyGuid` attribute to match the same value as the existent cloud user's ImmutableID. This change allows Microsoft Entra ID to make the correct hard match.

#### Block hard match in Microsoft Entra ID

We added a configuration option to disable the hard matching feature in Microsoft Entra ID. We advise customers to disable hard matching unless they need it to take over cloud-only accounts.

To disable hard matching, use the [Update-MgDirectoryOnPremiseSynchronization](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgdirectoryonpremisesynchronization) Microsoft Graph PowerShell cmdlet:

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.BlockCloudObjectTakeoverThroughHardMatchEnabled = $true
Update-MgDirectoryOnPremiseSynchronization `
    -OnPremisesDirectorySynchronizationId $OnPremSync.Id `
    -Features $OnPremSync.Features
```

#### Block soft match in Microsoft Entra ID

Similarly, we added a configuration option to disable the soft matching option in Microsoft Entra ID. We advise customers to disable soft matching unless they need it to take over cloud-only accounts.

To disable soft matching, use the [Update-MgDirectoryOnPremiseSynchronization](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgdirectoryonpremisesynchronization) Microsoft Graph PowerShell cmdlet:

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.BlockSoftMatchEnabled = $true
Update-MgDirectoryOnPremiseSynchronization `
    -OnPremisesDirectorySynchronizationId $OnPremSync.Id `
    -Features $OnPremSync.Features
```

> [!NOTE]
> BlockCloudObjectTakeoverThroughHardMatchEnabled and BlockSoftMatchEnabled are used to block matching for all objects if enabled for the tenant. Customers are encouraged to disable these features only during the period when a matching procedure is required for their tenancy. This flag should be set to *True* again after any matching has been completed and is no longer needed.

#### Hard match security protections

Beginning July 1, 2026, Microsoft Entra ID adds extra protections for hard match operations. These protections help prevent an on-premises Active Directory object from taking over the wrong cloud account when the target account is risky to reassociate.

A hard match can be blocked when the target cloud account meets one or more of these conditions:

- The cloud account already has `onPremisesObjectIdentifier` set.
- The cloud account is assigned a privileged Microsoft Entra role.
- The cloud account is eligible for a privileged Microsoft Entra role.

These security protections don't disable hard match. Initial hard match for safe targets still works, and ongoing synchronization for users that are already correctly matched isn't affected. Cloud-managed accounts with writeback enabled are excluded from this enforcement. The check is enforced in the cloud, so it applies to both Microsoft Entra Connect Sync and Microsoft Entra Cloud Sync regardless of the client version. [Soft match](#hard-match-vs-soft-match) behavior is unchanged and continues to be governed separately by the `BlockSoftMatchEnabled` feature.

For the exact error messages and error-specific fixes, see [Troubleshoot InvalidHardMatch errors](tshoot-connect-sync-errors.md#invalidhardmatch).

> [!CAUTION]
> Don't use hard match as a general repair mechanism for privileged accounts or for accounts that are already mapped to an on-premises object. If the wrong on-premises object is linked to a cloud account, the account can inherit the wrong source of authority. Confirm the intended mapping before you retry synchronization.

Before you perform a hard match, verify that the target cloud user meets all of the following requirements:

- It represents the same user as the on-premises object.

- The on-premises source anchor value exactly matches the user's `onPremisesImmutableId`.

- It isn't assigned or eligible for a privileged Microsoft Entra role. Remove any privileged role assignments or eligibility before proceeding.

- The cloud account doesn't already have a different `onPremisesObjectIdentifier` populated. Clear the value if necessary before retrying.

<a name='recover-from-a-blocked-hard-match'></a>

#### Hard match scenarios and recovery paths

The following table summarizes common hard match scenarios, whether Microsoft Entra ID allows or blocks each one, and how to recover.

| Scenario | Result | Recovery |
|---|---|---|
| A new on-premises user hard matches to a non-privileged cloud user that isn't already mapped | Hard match continues | No action needed if the match is intentional. |
| The target cloud user has a privileged role assigned | Hard match blocked | Temporarily remove the role, complete the hard match, then reassign it. |
| The target cloud user is eligible for a privileged role | Hard match blocked | Temporarily remove the eligibility, complete the hard match, then restore it. |
| The target cloud user is soft-deleted and privileged | Hard match blocked | Restore the user if needed, then apply the privileged-role recovery. |
| The target cloud user already has `onPremisesObjectIdentifier` set (for example, after an AD user is recreated, a forest or domain move, or a merger) | Remap blocked (`AttributeUpdateNotAllowed`) | Validate the intended source object, clear `onPremisesObjectIdentifier` to `null`, then rerun synchronization. |
| You can't remediate before enforcement | Temporary bypass | Enable `allowOnPremUpdateOfOnPremisesObjectIdentifierEnabled`, then remediate and disable it. |

##### Fix a hard match blocked by a privileged role

If the cloud user has a privileged role assignment or eligibility:

1. Confirm that the on-premises object should be linked to the existing cloud user.
1. If the user is soft-deleted, restore it from the Microsoft Entra ID Recycle Bin.
1. Temporarily remove the privileged role assignment or eligibility from the cloud user.
1. Rerun synchronization to complete the hard match.
1. Reassign the privileged role or restore the eligibility.

> [!IMPORTANT]
> Don't leave privileged access removed longer than necessary. Restore the role assignment or eligibility after the hard match succeeds.

##### Clear onPremisesObjectIdentifier

If the hard match is blocked because `onPremisesObjectIdentifier` is already set, clear the value to `null` and then rerun synchronization. Use Microsoft Graph or ADSyncTools.

To clear `onPremisesObjectIdentifier` with Microsoft Graph so synchronization can proceed, send the following request:

```http
PATCH https://graph.microsoft.com/beta/users/{userId}
Content-Type: application/json

{
  "onPremisesObjectIdentifier": null
}
```

This PATCH request requires the `User-OnPremisesSyncBehavior.ReadWrite.All` Microsoft Graph permission and the Global Administrator or Hybrid Identity Administrator role.

> [!NOTE]
> You can only clear `onPremisesObjectIdentifier` by setting it to `null`. Attempts to set it to another value are blocked. After you clear the value and rerun synchronization, the next successful sync stamps a fresh value.

Alternatively, to clear `onPremisesObjectIdentifier` with ADSyncTools version 2.5.0 or later, run the following commands:

```powershell
# Import ADSyncTools module
Import-Module ADSyncTools -MinimumVersion 2.5

# Provide the user's identity.
$userId = "<userId>"

# Review the current on-premises attributes.
Get-ADSyncToolsOnPremisesAttribute -Id $userId

# Optional: back up the current values before making changes.
Get-ADSyncToolsOnPremisesAttribute -Id $userId | Export-Clixml backupOnpremisesAttributes.Clixml

# Clear onPremisesObjectIdentifier.
Clear-ADSyncToolsOnPremisesAttribute -Id $userId -onPremisesObjectIdentifier
```

After you clear the value, rerun synchronization.

##### Temporarily allow onPremisesObjectIdentifier updates

If you can't remediate affected objects before enforcement, enable the tenant-level feature flag `allowOnPremUpdateOfOnPremisesObjectIdentifierEnabled`. This flag is disabled by default. Leave the flag disabled unless you need a temporary bypass while you complete remediation.

```powershell
# Connect to Microsoft Graph.
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

# Enable the temporary bypass.
$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.AllowOnPremUpdateOfOnPremisesObjectIdentifierEnabled = $true

Update-MgDirectoryOnPremiseSynchronization `
    -OnPremisesDirectorySynchronizationId $OnPremSync.Id `
    -Features $OnPremSync.Features

# Verify the current value.
$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.AllowOnPremUpdateOfOnPremisesObjectIdentifierEnabled
```

To re-enable hard match protection after remediation, set the flag back to `$false`:

```powershell
$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.AllowOnPremUpdateOfOnPremisesObjectIdentifierEnabled = $false

Update-MgDirectoryOnPremiseSynchronization `
    -OnPremisesDirectorySynchronizationId $OnPremSync.Id `
    -Features $OnPremSync.Features
```

> [!WARNING]
> Enabling this feature flag reduces the protection provided by hard match security enforcement. Use it only as a temporary bypass for a validated migration, recovery, or consolidation scenario. Disable the bypass after remediation is complete.

### Other objects than users
For mail-enabled groups and contacts, you can soft match based on proxyAddresses. Hard match isn't applicable since you can only update the sourceAnchor/immutableID (using PowerShell) on users. For groups that aren't mail-enabled, there's no support for soft match or hard match.

### Considerations on soft matching user with Admin role

To protect from untrusted on-premises users, Microsoft Entra ID won't match on-premises users with cloud users that have an admin role. This is the default behavior. To work around it, do the following steps:

1. Remove the directory roles from the cloud-only user object.
1. Hard-delete the new quarantined object created in the cloud.
1. Trigger a new sync cycle.
1. Optionally, add the directory roles back to the user object in the cloud after the matching is done.

<a name='create-a-new-on-premises-active-directory-from-data-in-azure-ad'></a>

## Create a new on-premises Active Directory from data in Microsoft Entra ID
Some customers start with a cloud-only solution with Microsoft Entra ID and they don't have an on-premises AD. Later they want to consume on-premises resources and want to build an on-premises AD based on Microsoft Entra data. Microsoft Entra Connect can't help with this scenario. It doesn't create users on-premises and it doesn't have any ability to set the password on-premises to the same as in Microsoft Entra ID.

If the only reason you plan to add on-premises AD is to support line-of-business (LOB) apps, then consider using [Microsoft Entra Domain Services](~/identity/domain-services/index.yml) instead.

<a name='next-steps'></a>

## Related content
Learn more about [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).

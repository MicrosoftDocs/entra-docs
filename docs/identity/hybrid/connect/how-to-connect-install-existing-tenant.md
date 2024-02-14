---
title: 'Microsoft Entra Connect: When you already have Microsoft Entra ID'
description: This topic describes how to use Connect when you have an existing Microsoft Entra tenant.
author: billmath
ms.service: entra-id
ms.custom: has-azure-ad-ps-ref
manager: amycolannino
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath

---

# Microsoft Entra Connect: When you have an existing tenant
Most of the topics for how to use Microsoft Entra Connect assumes you start with a new Microsoft Entra tenant and that there are no users or other objects there. But if you have started with a Microsoft Entra tenant, populated it with users and other objects, and now want to use Connect, then this topic is for you.

## The basics
An object in Microsoft Entra ID is either mastered in the cloud or on-premises. For one single object, you cannot manage some attributes on-premises and some other attributes in Microsoft Entra ID. Each object has a flag indicating where the object is managed.

You can manage some users on-premises and other in the cloud. A common scenario for this configuration is an organization with a mix of accounting workers and sales workers. The accounting workers have an on-premises AD account, but the sales workers do not, they have an account in Microsoft Entra ID. You would manage some users on-premises and some in Microsoft Entra ID.

If you started to manage users in Microsoft Entra ID that are also in on-premises AD and later want to use Connect, then there are some additional concerns you need to consider.

<a name='sync-with-existing-users-in-azure-ad'></a>

## Sync with existing users in Microsoft Entra ID
When you install Microsoft Entra Connect and you start synchronizing, the Azure AD Sync service (in Microsoft Entra ID) does a check on every new object and tries to find an existing object to match. There are three attributes used for this process: **userPrincipalName**, **proxyAddresses**, and **sourceAnchor**/**immutableID**. A match on **userPrincipalName** or **proxyAddresses** is known as a **soft match**. A match on **sourceAnchor** is known as **hard match**. For the **proxyAddresses** attribute only the value with **SMTP:**, that is the primary email address, is used for the evaluation.

The match is only evaluated for new objects coming from Connect. If you change an existing object so it is matching any of these attributes, then you see an error instead.

If Microsoft Entra ID finds an object where the attribute values are the same for an object coming from Connect and that it is already present in Microsoft Entra ID, then the object in Microsoft Entra ID is taken over by Connect. The previously cloud-managed object is flagged as on-premises managed. All attributes in Microsoft Entra ID with a value in on-premises AD are overwritten with the on-premises value.

> [!WARNING]
> Since all attributes in Microsoft Entra ID are going to be overwritten by the on-premises value, make sure you have good data on-premises. For example, if you only have managed email address in Microsoft 365 and not kept it updated in on-premises AD DS, then you lose any values in Microsoft Entra ID / Microsoft 365 not present in AD DS.

> [!IMPORTANT]
> If you use password sync, which is always used by express settings, then the password in Microsoft Entra ID is overwritten with the password in on-premises AD. If your users are used to manage different passwords, then you need to inform them that they should use the on-premises password when you have installed Connect.

The previous section and warning must be considered in your planning. If you have made many changes in Microsoft Entra not reflected in on-premises AD DS, then you need to plan for how to populate AD DS with the updated values before you sync your objects with Microsoft Entra Connect.

If you matched your objects with a soft-match, then the **sourceAnchor** is added to the object in Microsoft Entra ID so a hard match can be used later.

>[!IMPORTANT]
> Microsoft strongly recommends against synchronizing on-premises accounts with pre-existing administrative accounts in Microsoft Entra ID.

### Hard-match vs Soft-match
By default, the SourceAnchor value of "abcdefghijklmnopqrstuv==" is calculated by Microsoft Entra Connect by using MsDs-ConsistencyGUID attribute (or ObjectGUID depending on the configuration) from on-premises Active Directory. This attribute value will be the corresponding ImmutableId in Microsoft Entra ID.
When Microsoft Entra Connect (sync engine) instructs Microsoft Entra ID to add or update objects, Microsoft Entra ID matches the incoming object by using the sourceAnchor value and matching it to the ImmutableId attribute of existent objects in Microsoft Entra ID. If there is a match Microsoft Entra ID will take over that object and update it with the properties of the incoming on-premises Active Directory object in what is called a ”hard-match”.
When Microsoft Entra ID doesn't find any object with an ImmutableId that matches the same SouceAnchor value of the incoming object, it tries to use the proxyAddresses and userPrincipalName attributes to find a match in what it’s called a ”soft-match”. The soft match tries to match objects already present in Microsoft Entra ID (that are sourced in Microsoft Entra ID) with the new objects being added or updated during synchronization that represent the same entity on-premises (like users and groups).
If Microsoft Entra ID is not able to find a hard match or soft match for the incoming object, it provisions a new object in Microsoft Entra ID directory.
We have added a configuration option to disable the hard matching feature in Microsoft Entra ID. We advise customers to disable hard matching unless they need it to take over cloud only accounts.

To disable hard match, use the [Update-MgDirectoryOnPremiseSynchronization](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgdirectoryonpremisesynchronization) Microsoft Graph PowerShell cmdlet:

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.BlockCloudObjectTakeoverThroughHardMatchEnabled = $true
Update-MgDirectoryOnPremiseSynchronization `
    -OnPremisesDirectorySynchronizationId $OnPremSync.Id `
    -Features $OnPremSync.Features
```



To disable Soft Matching, use the [Update-MgDirectoryOnPremiseSynchronization](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgdirectoryonpremisesynchronization) Microsoft Graph PowerShell cmdlet:

```powershell
Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"

$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.BlockSoftMatchEnabled = $true
Update-MgDirectoryOnPremiseSynchronization `
    -OnPremisesDirectorySynchronizationId $OnPremSync.Id `
    -Features $OnPremSync.Features
```

> [!NOTE]
> 
> blockSoftMatchEnabled - Use to block soft match for all objects if enabled for the tenant. Customers are encouraged to enable this feature and keep it enabled until soft matching is required again for their tenancy. This flag should be enabled again after any soft matching has been completed and is no longer needed.

### Other objects than users
For mail-enabled groups and contacts, you can soft-match based on proxyAddresses. Hard-match is not applicable since you can only update the sourceAnchor/immutableID (using PowerShell) on Users only. For groups that aren't mail-enabled, there is currently no support for soft-match or hard-match.

### Admin role considerations
To prevent untrusted on-premises users from matching with a cloud user that has any admin role, Microsoft Entra Connect will not match on-premises user objects with objects that have an admin role. This is by default. To workaround this behavior you can do the following:

1.    Remove the directory roles from the cloud-only user object.
2.    If there was a failed user sync attempt, hard delete the Quarantined object in the cloud.
3.    Trigger a sync.
4.    Optionally add the directory roles back to the user object in cloud once the matching has occurred.

<a name='create-a-new-on-premises-active-directory-from-data-in-azure-ad'></a>

## Create a new on-premises Active Directory from data in Microsoft Entra ID
Some customers start with a cloud-only solution with Microsoft Entra ID and they do not have an on-premises AD. Later they want to consume on-premises resources and want to build an on-premises AD based on Microsoft Entra data. Microsoft Entra Connect cannot help you for this scenario. It does not create users on-premises and it does not have any ability to set the password on-premises to the same as in Microsoft Entra ID.

If the only reason why you plan to add on-premises AD is to support LOBs (Line-of-Business apps), then maybe you should consider to use [Microsoft Entra Domain Services](~/identity/domain-services/index.yml) instead.

## Next steps
Learn more about [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).

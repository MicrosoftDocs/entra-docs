---
title: 'Microsoft Entra Connect: When you already have Microsoft Entra ID'
description: This topic describes how to use Connect when you have an existing Microsoft Entra tenant.
author: omondiatieno
ms.service: entra-id
ms.custom: has-azure-ad-ps-ref
manager: mwongerapk
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi

---

# Microsoft Entra Connect: When you have an existing tenant
Most of the topics for how to use Microsoft Entra Connect assumes you start with a new Microsoft Entra tenant and that there are no users or other objects there. But if you started with a Microsoft Entra tenant, populated it with users and other objects, and now want to use Connect, then this topic is for you.

## The basics
An object in Microsoft Entra ID is either managed in the cloud or on-premises. For one single object, you can't manage some attributes on-premises and some other attributes in Microsoft Entra ID. Each object has a flag indicating where the object is managed.

You can manage some users on-premises and others in the cloud. A common scenario for this configuration is an organization with a mix of accounting workers and sales workers. The accounting workers have an on-premises AD account, but the sales workers don't, but both have an account in Microsoft Entra ID. You would manage some users on-premises and some in Microsoft Entra ID.

There are some extra concerns you need to consider when you started to manage users in Microsoft Entra ID that are also present on-premises, and later want to use Microsoft Entra Connect.

<a name='sync-with-existing-users-in-azure-ad'></a>

## Sync with existing users in Microsoft Entra ID
When you start synchronizing with Microsoft Entra Connect, the Microsoft Entra service API checks every new incoming object and tries to find an existing object to match. There are three attributes used for this process: **userPrincipalName**, **proxyAddresses**, and **sourceAnchor**/**immutableID**. A match on **userPrincipalName** or **proxyAddresses** is known as a "**soft-match**." A match on **sourceAnchor** is known as "**hard-match**." For the **proxyAddresses** attribute, only the value with **SMTP:**, that is the primary email address, is used for the evaluation.

The match is only evaluated for new objects coming from on-premises AD. If you change an existing object so it matches any of these attributes, then you see an error instead.

If Microsoft Entra ID finds an object where the attribute values are the same as the new incoming object from Microsoft Entra Connect, then it takes over the object in Microsoft Entra ID and the previously cloud-managed object is converted to on-premises managed. All attributes in Microsoft Entra ID with a value in on-premises AD are overwritten with the respective on-premises value.

> [!WARNING]
> Since all attributes in Microsoft Entra ID are going to be overwritten by the on-premises value, make sure you have good data on-premises. For example, if you only have managed email address in Microsoft 365 and not kept it updated in on-premises AD DS, then you lose any values in Microsoft Entra ID / Microsoft 365 that aren't present in AD DS.

> [!IMPORTANT]
> If you use password hash sync, which is always enabled with Express installation, then the password hash in Microsoft Entra ID is overwritten with the password hash from on-premises AD. If your users are used to managing different passwords, then you need to inform them that they should use the on-premises AD password.

The previous section and warning must be considered in your planning. If you made many changes in Microsoft Entra ID which weren't reflected in on-premises AD DS, then to prevent data loss, you need to plan on how to populate AD DS with the updated values from Microsoft Entra ID, before you sync your objects with Microsoft Entra Connect.

If you matched your objects with a soft-match, then the **sourceAnchor** is added to the object in Microsoft Entra ID so a hard match can be used later.

>[!IMPORTANT]
> Microsoft strongly recommends against synchronizing on-premises accounts with preexisting administrative accounts in Microsoft Entra ID.

### Hard-match vs soft-match
By default, the SourceAnchor value of an object, for example "abcdefghijklmnopqrstuv==", is the Base64 string representation of the mS-Ds-ConsistencyGUID attribute (or ObjectGUID depending on the configuration) from the on-premises Active Directory object. This value is set as the corresponding ImmutableId in Microsoft Entra ID.

When Microsoft Entra Connect or Cloud Sync adds new objects, the Microsoft Entra ID service tries to match the incoming object by using the sourceAnchor value corresponding to the ImmutableId attribute of existent objects in Microsoft Entra ID. If there's a match, Microsoft Entra Connect takes over the source or authority (SoA) of that object and updates it with the properties of the incoming on-premises Active Directory object in what is known as *"hard-match."*
When Microsoft Entra ID can't find any object with an ImmutableId that matches the SourceAnchor value, it tries to use the incoming object's userPrincipalName or primary SMTP address to find a match in what it's known as a "*soft-match*." 

Both, the hard-match and soft-match, tries to match objects already present and managed in Microsoft Entra ID with the new incoming objects being added that represent the same on-premises entity. If Microsoft Entra ID isn't able to find a *hard-match* or *soft-match* for the incoming object, it provisions a new object in Microsoft Entra ID directory.

If Microsoft Entra ID is able to "*soft-match*" the new incoming object based on primary SMTP address with an existent object managed in Microsoft Entra ID, but this new object has a different sourceAnchor value, then there's an attempt to provision a new object which normally results in a conflict where Microsoft Entra ID is unable to create the new object. This conflict occurs in situations such as:

- A different sourceAnchor value was set in `mS-Ds-ConsistencyGuid` attribute, on the original on-premises AD user that has already been synced to Entra ID.

- A new on-premises AD user was created with the same UPN and Primary SMTP address but has a different sourceAnchor and SID.

In such cases, an `AttributeValueMustBeUnique` export error is thrown in Microsoft Entra Connect or Cloud Sync. Depending on the incoming user properties this error might refer to one of the following attribute conflicts:

- *AttributeConflictName = OnPremiseSecurityIdentifier*: the new incoming object has a different sourceAnchor but the same OnPremiseSecurityIdentifier (SID) and primary SMTP address as the existent user in Entra ID directory. 

- *AttributeConflictName = ProxyAddresses*: the new incoming object has a different sourceAnchor and SID but has the same Primary SMTP address as the existent user in Entra ID directory. 

> [!NOTE]
> In some rare situations, an `OnPremiseSecurityIdentifier` conflict occurs due to an issue with on-premises AD RID Pool (for example, a Domain Controller recovered from backup), which can generate a new user with the same SID. In such cases, an `AttributeValueMustBeUnique` error is thrown when trying to provision the user not due to "*soft-match*" attempts but because the `OnPremiseSecurityIdentifier` must be unique in Entra ID directory.

These scenarios typically mean that you're trying to reprovision the same user. To resolve the conflict, you should update the on-premises user's `mS-Ds-ConsistencyGuid` attribute to match the same value as the existent cloud user's ImmutableID. This change allows Microsoft Entra ID to make the correct "hard-match".

#### Block hard-match in Microsoft Entra ID

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

#### Block soft-match in Microsoft Entra ID

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

### Other objects than users
For mail-enabled groups and contacts, you can soft-match based on proxyAddresses. Hard match isn't applicable since you can only update the sourceAnchor/immutableID (using PowerShell) on Users only. For groups that aren't mail-enabled, there's currently no support for soft-match or hard-match.

### Admin role considerations
To protect from untrusted on-premises users, Microsoft Entra ID won't match on-premises users with cloud users that have an admin role. This behavior is by default. To work around this, you can do the following steps:

1.    Remove the directory roles from the cloud-only user object.
1. Hard-delete the new quarantined object created in the cloud.

1. Trigger a new sync cycle.

1. Optionally, add the directory roles back to the user object in cloud once the matching is done.

<a name='create-a-new-on-premises-active-directory-from-data-in-azure-ad'></a>

## Create a new on-premises Active Directory from data in Microsoft Entra ID
Some customers start with a cloud-only solution with Microsoft Entra ID and they don't have an on-premises AD. Later they want to consume on-premises resources and want to build an on-premises AD based on Microsoft Entra data. Microsoft Entra Connect can't help you for this scenario. It doesn't create users on-premises and it doesn't have any ability to set the password on-premises to the same as in Microsoft Entra ID.

If the only reason why you plan to add on-premises AD is to support LOBs (Line-of-Business apps), then maybe you should consider to use [Microsoft Entra Domain Services](~/identity/domain-services/index.yml) instead.

## Next steps
Learn more about [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).

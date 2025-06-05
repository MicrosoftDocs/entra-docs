---
title: How to use the BypassDirSyncOverridesEnabled feature of a Microsoft Entra tenant
description: Describes how to use BypassDirSyncOverridesEnabled tenant feature to restore synchronization of Mobile and OtherMobile attributes from on-premises Active Directory.
author: billmath
ms.date: 04/09/2025
ms.author: billmath
ms.topic: how-to
ms.service: entra-id
ms.custom: no-azure-ad-ps-ref, sfi-ga-nochange
ms.subservice: hybrid-connect
---

# How to use the BypassDirSyncOverridesEnabled feature of a Microsoft Entra tenant.

This article describes the *BypassDirSyncOverridesEnabled*  feature and how to restore synchronization of _mobile_ and _otherMobile_ attributes from Microsoft Entra ID to on-premises Active Directory.

Synchronized users properties cannot be changed from Microsoft Entra ID or Microsoft 365 admin portals, neither through any available PowerShell modules. Up until recently, the exception to this was the Microsoft Entra user’s attributes called _MobilePhone_ and _AlternateMobilePhones_. These attributes are synchronized from on-premises Active Directory attributes _mobile_ and _otherMobile_, respectively, but end users used to be able to update their own phone number in _MobilePhone_ attribute in Microsoft Entra ID through their profile page. Changes to _MobilePhone_ and _AlternateMobilePhones_ attributes are no longer possible for Synchronized users except through the use of Microsoft Entra Connect or Microsoft Entra Cloud Sync. 

Previously, administrators and synchronized users had the capability to update the values of the  _MobilePhone_ and _AlternateMobilePhones_ attributes in Microsoft Entra ID. This is no longer possible for synchronized users. When this was possible the synchronization API was not honoring updates to these attributes when they originated from on-premises Active Directory. This was commonly known as a “DirSyncOverrides” feature. Administrators noticed this behavior when updates to _mobile_ or _otherMobile_ attributes in Active Directory did not update the corresponding user’s _MobilePhone_ or _AlternateMobilePhones_ in Microsoft Entra ID accordingly, even though the object was successfully synchronized through Microsoft Entra Connect's engine.

## Identifying users with different Mobile values

You can export a list of users with different Mobile values between Active Directory and Microsoft Entra ID using *‘Compare-ADSyncToolsDirSyncOverrides’* from *ADSyncTools* PowerShell module. This will allow you to determine the users and respective values that are different between on-premises Active Directory and Microsoft Entra ID. This is important to know because enabling the BypassDirSyncOverridesEnabled feature will overwrite all the different values in Microsoft Entra ID with the value coming from on-premises Active Directory.


### Using Compare-ADSyncToolsDirSyncOverrides

As a prerequisite you need to be running Microsoft Entra Connect version 2 or later and install the latest ADSyncTools module from PowerShell Gallery with the following command:

```powershell
Install-Module ADSyncTools 
```

To compare all the synchronized user’s Mobile values, run the following command:

```powershell
Compare-ADSyncToolsDirSyncOverrides
```

This function will export a CSV file with a list of users where Mobile values in on-premises Active Directory are different than the respective _MobilePhone_ in Microsoft Entra ID.

At this stage you can use this data to reset the values of the on-premises Active Directory *Mobile* properties to the values that are present in Microsoft Entra ID. This way you can capture the most updated phone numbers from Microsoft Entra ID and persist this data in on-premises Active Directory, before enabling *BypassDirSyncOverridesEnabled* feature. To do this, import the data from the resulting CSV file and then use the *'Set-ADSyncToolsDirSyncOverrides'* from *ADSyncTools* module to persist the value in on-premises Active Directory.

For example, to import data from the CSV file and extract the values in Microsoft Entra ID for a given UserPrincipalName, use the following command:

```powershell
$upn = '<UserPrincipalName>' 
$user = Import-Csv 'ADSyncTools-DirSyncOverrides_yyyyMMMdd-HHmmss.csv' | where UserPrincipalName -eq $upn | select UserPrincipalName,MobileInEntra  
Set-ADSyncToolsDirSyncOverridesUser -Identity $upn -MobileInAD $user.MobileInEntra
```

## Enabling BypassDirSyncOverridesEnabled feature

By default, *BypassDirSyncOverridesEnabled* feature is turned off. Enabling *BypassDirSyncOverridesEnabled* allows your tenant to bypass any changes made earlier in *MobilePhone* or *AlternateMobilePhones* by users or admins directly in Microsoft Entra ID and honor the values present in on-premises Active Directory *Mobile* or *OtherMobile*.

### Enable the BypassDirSyncOverridesEnabled feature:

To enable BypassDirSyncOverridesEnabled feature, use the [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) module.

```powershell
$directorySynchronization = Get-MgDirectoryOnPremiseSynchronization
$directorySynchronization.Features.BypassDirSyncOverridesEnabled = $true
Update-MgDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $directorySynchronization.Id -Features $directorySynchronization.Features
```

### Verify the status of the BypassDirSyncOverridesEnabled feature:

```powershell
(Get-MgDirectoryOnPremiseSynchronization).Features.BypassDirSyncOverridesEnabled
```

Once the feature is enabled, start a full synchronization cycle in Microsoft Entra Connect using the following command:

```powershell
Start-ADSyncSyncCycle -PolicyType Initial
```

>[!NOTE]
>Only objects with a different *MobilePhone* or *AlternateMobilePhones* value from on-premises Active Directory will be updated.

<a name='managing-mobile-phone-numbers-in-azure-ad-and-on-premises-active-directory'></a>

## Managing mobile phone numbers in Microsoft Entra ID and on-premises Active Directory

To manage the user’s phone numbers, an admin can use the following set of functions from *ADSyncTools* module to read, write and clear the values in on-premises Active Directory, and to read _mobilePhone_ from Microsoft Entra ID.

### Get _Mobile_ property from on-premises Active Directory:

```powershell
Get-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -FromAD
```

<a name='get-mobilephone-property-from-entra-id'></a>

### Get _MobilePhone_ property from Microsoft Entra ID:

```powershell
Get-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -FromEntraID
```

### Set _Mobile_ property in on-premises Active Directory:

```powershell
Set-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -MobileInAD '999888777'
```

### Clear _Mobile_ property in on-premises Active Directory:

```powershell
Clear-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com'
```

## Next Steps

Learn more about [Microsoft Entra Connect: `ADSyncTools` PowerShell module](reference-connect-adsynctools.md)
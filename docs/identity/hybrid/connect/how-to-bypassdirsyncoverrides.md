---
title: How to use the BypassDirSyncOverridesEnabled feature of a Microsoft Entra tenant
description: Describes how to use BypassDirSyncOverridesEnabled tenant feature to restore synchronization of Mobile and OtherMobile attributes from on-premises Active Directory.

author: billmath
ms.date: 11/06/2023
ms.author: billmath
ms.topic: how-to
ms.service: entra-id
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.subservice: hybrid-connect
---

# How to use the BypassDirSyncOverridesEnabled feature of a Microsoft Entra tenant.

This article describes the *BypassDirSyncOverridesEnabled*  feature and how to restore synchronization of Mobile and otherMobile attributes from Microsoft Entra ID to on-premises Active Directory.

Generally, synchronized users cannot be changed from Azure or Microsoft 365 admin portals, neither through PowerShell using Microsoft Entra ID or [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) modules. The exception to this is the Microsoft Entra user’s attributes called *MobilePhone* and *AlternateMobilePhones*. These attributes are synchronized from on-premises Active Directory attributes mobile and otherMobile, respectively, but end users can update their own phone number in *MobilePhone* attribute in Microsoft Entra ID through their profile page. Admins can also update synchronized user’s *MobilePhone* and *AlternateMobilePhones* values in Microsoft Entra ID using theMicrosoft Graph PowerShell module.  

Giving users and admins the ability to update phone numbers directly in Microsoft Entra ID enables enterprises to reduce the administrative overhead of managing user’s phone numbers in local Active Directory as these can change more frequently.

The caveat however, is that once a synchronized user's *MobilePhone* or *AlternateMobilePhones* number is updated via admin portal or PowerShell, the synchronization API will no longer honor updates to these attributes when they originate from on-premises Active Directory. This is commonly known as a *“DirSyncOverrides”* feature. Administrators will notice this behavior when updates to Mobile or otherMobile attributes in Active Directory, do not update the correspondent user’s MobilePhone or AlternateMobilePhones in Microsoft Entra ID accordingly, even though, the object is successfully synchronized through Microsoft Entra Connect's engine.

## Identifying users with different Mobile and otherMobile values

You can export a list of users with different Mobile and otherMobile values between Active Directory and Microsoft Entra ID using *‘Compare-ADSyncToolsDirSyncOverrides’* from *ADSyncTools* PowerShell module. This will allow you to determine the users and respective values that are different between on-premises Active Directory and Microsoft Entra ID. This is important to know because enabling the *BypassDirSyncOverridesEnabled* feature will overwrite all the different values in Microsoft Entra ID with the value coming from on-premises Active Directory.

### Using Compare-ADSyncToolsDirSyncOverrides

As a prerequisite you need to be running Microsoft Entra Connect version 2 or later and install the latest ADSyncTools module from PowerShell Gallery with the following command:

```powershell
Install-Module ADSyncTools 
```

To compare all the synchronized user’s Mobile and OtherMobile values, run the following command:

```powershell
Compare-ADSyncToolsDirSyncOverrides -Credential $(Get-Credential) 
```

>[!NOTE]
> The target API used by this feature does not handle authentication user interactions. MFA or conditional policies will block authentication. When prompted to enter credentials, please use a Global Administrator account that doesn't have MFA enabled or any Conditional Access policy applied. As a last resort, please create a temporary Global Administrator user account without MFA or Conditional Access that can be deleted after completing the desired operations using the BypassDirSyncOverridees feature.

This function will export a CSV file with a list of users where Mobile or OtherMobile values in on-premises Active Directory are different than the respective MobilePhone or AlternateMobilePhones in Microsoft Entra ID.

At this stage you can use this data to reset the values of the on-premises Active Directory *Mobile* and *otherMobile* properties to the values that are present in Microsoft Entra ID. This way you can capture the most updated phone numbers from Microsoft Entra ID and persist this data in on-premises Active Directory, before enabling *BypassDirSyncOverridesEnabled* feature. To do this, import the data from the resulting CSV file and then use the *'Set-ADSyncToolsDirSyncOverrides'* from *ADSyncTools* module to persist the value in on-premises Active Directory.

For example, to import data from the CSV file and extract the values in Microsoft Entra ID for a given UserPrincipalName, use the following command:

```powershell
$upn = '<UserPrincipalName>' 
$user = Import-Csv 'ADSyncTools-DirSyncOverrides_yyyyMMMdd-HHmmss.csv' | 
where UserPrincipalName -eq $upn | 
select UserPrincipalName,*InAAD  
Set-ADSyncToolsDirSyncOverridesUser -Identity $upn -MobileInAD $user.MobileInAAD
```

## Enabling BypassDirSyncOverridesEnabled feature

By default, *BypassDirSyncOverridesEnabled* feature is turned off. Enabling *BypassDirSyncOverridesEnabled* allows your tenant to bypass any changes made in *MobilePhone* or *AlternateMobilePhones* by users or admins directly in Microsoft Entra ID and always honor the values present in on-premises Active Directory *Mobile* or *OtherMobile*.

If you do not wish to have end users updating their own mobile phone number or there is no requirement to have admins updating mobile or alternative mobile phone numbers using PowerShell, you should leave the feature *BypassDirSyncOverridesEnabled* enabled on the tenant.  

With this feature turned on, even if an end user or admin updates either *MobilePhone* or *AlternateMobilePhones* in Microsoft Entra ID, the values synchronized from on-premises Active Directory will persist upon the next sync cycle. This means that any updates to these values only persist when the update is performed in on-premises Active Directory and then synchronized to Microsoft Entra ID.

### Enable the BypassDirSyncOverridesEnabled feature:

To enable BypassDirSyncOverridesEnabled feature, use the [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) module.

```powershell
$directorySynchronization = Get-MgDirectoryOnPremiseSynchronization
$features = @{BypassDirSyncOverridesEnabled=$true}

Update-MgDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $directorySynchronization.Id -Features $features
```

Once the feature is enabled, start a full synchronization cycle in Microsoft Entra Connect using the following command:

```powershell
Start-ADSyncSyncCycle -PolicyType Initial
```

>[!NOTE]
>Only objects with a different *MobilePhone* or *AlternateMobilePhones* value from on-premises Active Directory will be updated.

### Verify the status of the BypassDirSyncOverridesEnabled feature:

```powershell
(Get-MgDirectoryOnPremiseSynchronization).Features.BypassDirSyncOverridesEnabled
```

## Disabling BypassDirSyncOverridesEnabled feature

If you desire to restore the ability to update mobile phone numbers from the portal or PowerShell, you can disable *BypassDirSyncOverridesEnabled* feature using the following [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) module command:

```powershell
$directorySynchronization = Get-MgDirectoryOnPremiseSynchronization
$features = @{BypassDirSyncOverridesEnabled=$false}

Update-MgDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $directorySynchronization.Id -Features $features
```

When this feature is turned off, anytime a user or admin updates the *MobilePhone* or *AlternateMobilePhones* directly in Microsoft Entra ID, a *DirSyncOverrides* is created which prevents any future updates to these attributes coming from on-premises Active Directory. From this point on, a user or admin can only manage these attributes from Microsoft Entra ID as any new updates from on-premises *Mobile* or *OtherMobile* will be dismissed.

<a name='managing-mobile-phone-numbers-in-azure-ad-and-on-premises-active-directory'></a>

## Managing mobile phone numbers in Microsoft Entra ID and on-premises Active Directory

To manage the user’s phone numbers, an admin can use the following set of functions from *ADSyncTools* module to read, write and clear the values in either Microsoft Entra ID or on-premises Active Directory.

### Get _Mobile_ and _OtherMobile_ properties from on-premises Active Directory:

```powershell
Get-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -FromAD
```

<a name='get-mobilephone-and-alternatemobilephones-properties-from-azure-ad'></a>

### Get _MobilePhone_ and _AlternateMobilePhones_ properties from Microsoft Entra ID:

```powershell
Get-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -FromAzureAD
```

<a name='setmobilephone-and-alternatemobilephones-properties-in-azure-ad'></a>

### Set _MobilePhone_ and _AlternateMobilePhones_ properties in Microsoft Entra ID:

```powershell
Set-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -MobilePhoneInAAD '999888777' -AlternateMobilePhonesInAAD '0987654','1234567'
```

### Set _Mobile_ and _otherMobile_ properties in on-premises Active Directory:

```powershell
Set-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -MobileInAD '999888777' -OtherMobileInAD '0987654','1234567'
```

<a name='clear-mobilephone-and-alternatemobilephones-properties-in-azure-ad'></a>

### Clear _MobilePhone_ and _AlternateMobilePhones_ properties in Microsoft Entra ID:

```powershell
Clear-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -MobilePhoneInAAD -AlternateMobilePhonesInAAD
```

### Clear _Mobile_ and _otherMobile_ properties in on-premises Active Directory:

```powershell
Clear-ADSyncToolsDirSyncOverridesUser 'User1@Contoso.com' -MobileInAD -OtherMobileInAD
```

## Next Steps

Learn more about [Microsoft Entra Connect: `ADSyncTools` PowerShell module](reference-connect-adsynctools.md)

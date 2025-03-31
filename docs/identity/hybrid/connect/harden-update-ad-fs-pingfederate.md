---
title: 'Hardening update to Microsoft Entra Connect Sync AD FS and PingFederate configuration'
description: This article describes security improvements to Microsoft Entra Connect Sync ADFS and PingFederate configuration.
author: billmath
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.date: 12/18/2024
ms.subservice: hybrid-connect
ms.author: billmath
---

# Hardening update to Microsoft Entra Connect Sync from April 7, 2025 

In October 2024, we released new versions (2.4.xx.0) of Microsoft Entra Connect Sync. These versions contain a back-end service change that further hardens our services. **All customers are required to upgrade** to the [minimum versions](#minimum-versions) by **April 7, 2025**. 


## Expected impacts 

If Microsoft Entra Connect isn't upgraded to the minimum required version when the service change takes effect, you'll encounter the following impacts:

 - All authentication requests to Microsoft Entra ID on the Microsoft Entra Connect wizard will fail. Some of the capabilities that will be impacted include schema refresh, configuration of staging mode and user sign-in changes.
 - Configuration of Active Directory Federation Services (ADFS) scenarios through Microsoft Entra Connect wizard won't work.
 - Configuration of PingFederate scenarios through the Microsoft Entra Connect wizard won't work.

For example, when calling the MSOnline PowerShell cmdlet `Get-MsolUserRole`, Microsoft Entra Connect wizard throws an error: _"Access Denied. You do not have permissions to call this cmdlet"_

![Screenshot that shows MSOnline PowerShell error in Microsoft Entra Connect Sync wizard.](media/harden-update-ad-fs-pingfederate/msonline-connect-wizard-error.png)


## What won't be impacted
 - Your sync service will run as usual, and changes will continue to sync to Entra
 - The ability to upgrade your Entra Connect Sync instance. You can still perform the upgrade after April 7, 2025
   
>[!NOTE]
>If you're unable to upgrade by the deadline, you can restore the impacted functionalities by upgrading to the [latest version](https://www.microsoft.com/download/details.aspx?id=47594). Failure to update will result in losing the ability to **make changes on the Entra Connect Sync wizard that require user sign in with the Entra ID credentials** during the time period between **April 7, 2025 and when you upgrade**.

### Minimum versions 

To avoid any service impact, customers should be on version by April 7, 2025. 
- Customers in commercial clouds: [2.4.18.0](reference-connect-version-history.md#24180) or higher.
- Customers in noncommercial clouds: [2.4.21.0](reference-connect-version-history.md#24210) or higher. 

To upgrade to the latest version.
> [!div class="nextstepaction"]
> [Install the latest Microsoft Entra Connect Sync](https://www.microsoft.com/download/details.aspx?id=47594)

>[!IMPORTANT]
> Make sure you familiarize yourself with the [minimum requirements](how-to-connect-install-prerequisites.md) for the versions, including but not limited to: 
>
>  - Transport Layer Security,[TLS 1. 2](reference-connect-tls-enforcement.md)
>  - [.NET 4.7.2](https://dotnet.microsoft.com/download/dotnet-framework/net472#:~:text=Downloads%20for%20building%20and%20running%20applications%20with%20.NET%20Framework%204.7.2)

To assist customers with the upgrade process, we occasionally autoupgrade customers where supported. If you would like to be autoupgraded, ensure you have the [autoupgrade feature](how-to-connect-install-automatic-upgrade.md) configured. For [autoupgrade to work](security-updates-pks.md), you should be on version [2.3.20.0](reference-connect-version-history.md#23200) or higher. 

## Consider moving to Microsoft Entra Cloud Sync  

If you're eligible, we recommend migrating from Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync. Microsoft Entra Cloud Sync is the new sync client that works from the cloud and allows customers to set up and manage their sync preferences online. We recommend that you use Cloud Sync because we're introducing new features that improve the sync experiences through Cloud Sync. You can avoid future migrations by choosing Cloud Sync if that's the right option for you. Use the https://aka.ms/EvaluateSyncOptions to see if Cloud Sync is the right sync client for you. 

See the video below to understand how Cloud sync provides value to your business.

> [!VIDEO https://www.youtube.com/embed/9T6lKEloq0Q]

For more information, see [What is cloud sync?](/azure/active-directory/cloud-sync/what-is-cloud-sync)

## Upgrading Microsoft Entra Connect Sync 

If you aren't yet eligible to move to Cloud Sync, use this table for more information on upgrading. 

|Title|Description| 
|-----|-----|
|[Upgrading from a previous version](how-to-upgrade-previous-version.md)|Information on moving from one version of Microsoft Entra Connect to another| 
|[Information on deprecation](deprecated-azure-ad-connect.md)|Information on using a deprecated or unsupported version of Microsoft Entra Connect (some information is applicable to versions that are impacted by a service change)| 


## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Cloud Sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)

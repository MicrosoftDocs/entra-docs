---
title: 'Hardening update to Microsoft Entra Connect Sync AD FS and PingFederate configuration'
description: This article describes security improvements to Microsoft Entra Connect Sync ADFS and PingFederate configuration.
author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 10/07/2024
ms.subservice: hybrid-connect
ms.author: billmath
---

# Hardening update to Microsoft Entra Connect Sync AD FS and PingFederate configuration 

In October 2024, we released new versions (2.4.xx.0) of Microsoft Entra Connect Sync. These versions contain a back-end service change that further hardens our services. **All customers are required to upgrade** to the [minimum versions](#minimum-versions) by **April 7, 2025**. 


## Expected impacts 

If you aren’t upgraded to the minimum required version, you may encounter the following impacts to the Microsoft Entra Connect Sync service when the service change takes effect: 

 - Configuration of AD FS scenarios through the Connect Sync wizard may not work 
 - Configuration of PingFederate scenarios through the Connect Sync wizard may not work 

>[!NOTE]
> If you’re unable to upgrade by the deadline, you can restore the impacted functionalities by upgrading to the latest version. However, you would **lose the ability to configurate AD FS and PingFederate** during the time period between **April 7, 2025 and when you upgrade**. 

### Minimum versions 

To avoid any service impact, customers should be on version by April 7, 2025. 
- Customers in commercial clouds: [2.4.18.0](reference-connect-version-history.md#24180) or higher.
- Customers in non-commercial clouds: [2.4.21.0](reference-connect-version-history.md#24210) or higher. 

To upgrade to the latest version.
> [!div class="nextstepaction"]
> [Install Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594)

>[!IMPORTANT]
> Make sure you familiarize yourself with the [minimum requirements](how-to-connect-install-prerequisites.md) for the versions, including but not limited to: 
>
>  - [.NET 4.7.2](https://dotnet.microsoft.com/download/dotnet-framework/net472#:~:text=Downloads%20for%20building%20and%20running%20applications%20with%20.NET%20Framework%204.7.2)
>  - [TLS 1. 2](reference-connect-tls-enforcement.md)

To assist customers with the upgrade process, we occasionally autoupgrade customers where supported. If you would like to be autoupgraded, ensure you have the [autoupgrade feature](how-to-connect-install-automatic-upgrade.md) configured. For [autoupgrade to work](security-updates-pks.md), you should be on version [2.3.20.0](reference-connect-version-history.md#23200) or higher. 

The 2.4.18.0 and 2.4.21.0 versions have been released for download and not available for autoupgrade. For more more information, review the release status on [Microsoft Entra Connect: Version release history](https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/reference-connect-version-history).

## Consider moving to Microsoft Entra Cloud  

If you're eligible, we recommend migrating from Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync. Microsoft Entra Cloud Sync is the new sync client that works from the cloud and allows customers to set up and manage their sync preferences online. We recommend that you use Cloud Sync because we're introducing new features that improve the sync experiences through Cloud Sync. You can avoid future migrations by choosing Cloud Sync if that's the right option for you. Use the https://aka.ms/EvaluateSyncOptions to see if Cloud Sync is the right sync client for you. 

See the video below to understand how Cloud sync provides value to your business.

> [!VIDEO https://www.youtube.com/embed/9T6lKEloq0Q]

For more information, see [What is cloud sync?](/azure/active-directory/cloud-sync/what-is-cloud-sync)

## Upgrading Microsoft Entra Connect Sync 

If you aren’t yet eligible to move to Cloud Sync, use this table for more information on upgrading. 

|Title|Description| 
|-----|-----|
|[Upgrading from a previous version](how-to-upgrade-previous-version.md)|Information on moving from one version of Microsoft Entra Connect to another| 
|[Information on deprecation](deprecated-azure-ad-connect.md)|Information on using a deprecated or unsupported version of Microsoft Entra Connect (some information is applicable to versions that are impacted by a service change)| 


## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)

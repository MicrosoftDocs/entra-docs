---
title: 'Security hardening to the autoupgrade process for Microsoft Entra Connect and Microsoft Entra Connect Health '
description: This article describes security improvements to improve autoupgrade.
author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath
---

# Security improvements to Microsoft Entra Connect Sync autoupgrade and Microsoft Entra Connect Health alerts 

Since September 2023, we've been autoupgrading Microsoft Entra Connect Sync and Microsoft Entra Connect Health customers to an updated build as part of a precautionary security-related service change. Customers who were autoupgraded won't be impacted by the service change, but if you opted out of autoupgrade or autoupgrade failed, we **strongly recommend** that you upgrade to the [latest versions](reference-connect-version-history.md) by **September 23, 2024**. 


## Expected impacts
The following table provides information on the features and impact to services, you may encounter, if you aren't on the minimum recommended versions.

|Service|Impact|
|-----|-----|
|Microsoft Entra Connect| Autoupgrade stops working. Synchronization isn't impacted|
|Microsoft Entra Connect Health Connect Sync agent|A subset of [alerts](how-to-connect-health-alert-catalog.md#alerts-for-microsoft-entra-connect-sync) are impacted: </br> - Connection to Microsoft Entra ID failed due to authentication failure </br> - High CPU usage detected</br> - High Memory Consumption Detected </br> - Password Hash Synchronization has stopped working </br> - Export to Microsoft Entra ID was Stopped. Accidental delete threshold was reached</br> - Password Hash Synchronization heartbeat was skipped in the last 120 minutes </br> - Microsoft Entra Sync service can't start due to invalid encryption keys </br> - Microsoft Entra Sync service not running: Windows Service account Creds Expired| 
|Microsoft Entra Connect HealthAD DS agent|[All alerts](how-to-connect-health-alert-catalog.md#alerts-for-active-directory-domain-services)|
|Microsoft Entra Connect Health AD FS agent|[All alerts](how-to-connect-health-alert-catalog.md#alerts-for-active-directory-federation-services)|

## Minimum versions
To take advantage of our latest security improvements, we strongly encourage customers to upgrade to the following builds by **September 23, 2024**. To avoid any service impact, you should be using the following minimum versions:

- Microsoft Entra Connect: [version 2.3.2.0](reference-connect-version-history.md#2320) or higher
- Microsoft Entra Connect Health 
     - Connect Sync agent: [4.5.2466.0](https://aka.ms/connecthealth-download) or higher 
     - AD DS agent: version: [4.5.2466.0](https://aka.ms/connecthealth-adds-download) or higher 
     - AD FS agent: version: [4.5.2466.0](https://aka.ms/connecthealth-adfs-download) or higher

To upgrade to the latest version.
> [!div class="nextstepaction"]
> [Install Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594)

>[!IMPORTANT]
>The autoupgrade service of Microsoft Entra Connect Sync and some alerts of Microsoft Entra Connect Health won't work after **September 23, 2024**. To avoid impact you should be at the minimum recommended versions. 
>
>If you're unable to upgrade before the deadline, you can restore the impacted functionalities by upgrading to the latest versions. However, you lose the alerts during the time period between **September 23, 2024** and when you upgrade.


## Consider moving to Microsoft Entra Cloud Sync

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

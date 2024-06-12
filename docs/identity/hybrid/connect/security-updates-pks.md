---
title: 'Security hardening to the auto-upgrade process for Microsoft Entra Connect and Microsoft Entra Connect Health '
description: This article describes security hardening being taken by Microsoft to improve auto-upgrade.
author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath
---

# Security hardening to the auto-upgrade process for Microsoft Entra Connect and Microsoft Entra Connect Health 

As part of Microsoft’s push to harden the security of our features, we are making service changes to Microsoft Entra Connect Sync and Microsoft Entra Connect Health. This includes a change to Product Key Services. PKS is an internal service used by Microsoft Entra Connect Sync and Microsoft Entra Connect Health to auto-upgrade client components to an updated version. We are in the process of deprecating PKS, as the service is currently being replaced by the Hybrid Upgrade Service (HUS). 

Since January 2024, we have been auto-upgrading Microsoft Entra Connect Sync and Microsoft Entra Connect Health to an updated build. For customers who have previously opted out of auto-upgrade or for whom auto-upgrade failed, we **strongly recommend** that you upgrade to the [latest versions](reference-connect-version-history.md) by **September 16, 2024**. 

To take advantage of our latest security improvements, we strongly encourage customers to upgrade to the following builds by **September 16, 2024**. 

- Microsoft Entra Connect: [version 2.3.2.0](reference-connect-version-history.md#2320) or higher
- Microsoft Entra Connect Health 
     - Connect Sync agent: version 2.3.2.0 or higher 
     - AD DS agent: version X or higher 
     - AD FS agent: version X or higher 

To upgrade to the latest version.
> [!div class="nextstepaction"]
> [Install Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594)

## Consider moving to Microsoft Entra Cloud Sync

If you are eligible, we recommend migrating from Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync.  Microsoft Entra Cloud Sync is the new sync client that works from the cloud and allows customers to set up and manage their sync preferences online. We recommend that you use Cloud Sync because we will be introducing new features that will improve the sync experiences through Cloud Sync. You can avoid future migrations by choosing Cloud Sync if that's the right option for you. Please use the https://aka.ms/EvaluateSyncOptions to see if Cloud Sync is the right sync client for you. 

Please see the video below to understand how Cloud sync provides value to your business.

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
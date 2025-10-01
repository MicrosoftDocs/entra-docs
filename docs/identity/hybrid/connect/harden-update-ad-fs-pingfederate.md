---
title: Hardening updates for Microsoft Entra Connect Sync
description: Learn how to upgrade Microsoft Entra Connect Sync to meet the minimum version requirements and prevent synchronization failures after September 30, 2026.
author: omondiatieno
ms.author: jomondi
manager: mwongerapk
ms.reviewer: sharonrutto
ms.date: 09/19/2025
ms.topic: concept-article
ms.service: entra-id
ms.subservice: hybrid-connect

#customer intent: As an IT admin, I want to know the minimum version requirements for Microsoft Entra Connect Sync so that I can ensure compliance.
---
# Hardening update to Microsoft Entra Connect Sync

As part of increasing the security posture of Microsoft Entra Connect, Microsoft deployed a dedicated first-party application to enable the synchronization between Active Directory and Microsoft Entra ID. This new application will manifest as a first party service principal called the "Microsoft Entra AD Synchronization Service" (Application Id: `6bf85cfa-ac8a-4be5-b5de-425a0d0dc016`) and will be visible in the Enterprise Applications experience within the Microsoft Entra admin center. This application is critical for the continued operation of on-premises to Microsoft Entra ID synchronization functionality through Entra Connect.

We have since released a new version (2.5.79.0) of Microsoft Entra Connect that contains this service change.  All customers are required to upgrade to the minimum versions by September 30, 2026 to avoid service disruptions.

## Expected impacts 

If you aren’t upgraded to the minimum required version (2.5.79.0), you might encounter the following impact to the Microsoft Entra Connect Sync service when the service change takes effect:

All synchronization services in Microsoft Entra Connect Sync will fail.

> [!NOTE]
> If you’re unable to upgrade by the deadline, you can restore the impacted functionalities by upgrading to the latest version. However, **all synchronization services will fail** during the period between **September 30, 2026, and when you upgrade**.

## Minimum versions

To avoid any service impact, customers should be on the following version by September 30, 2026:

Version [2.5.79.0](/entra/identity/hybrid/connect/reference-connect-version-history#25790) or higher.

The Microsoft Entra Connect Sync .msi installation file for this version is exclusively available on Microsoft Entra Admin Center under [Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/%7E/GetStarted).

> [!IMPORTANT]
> Make sure you familiarize yourself with the [minimum requirements](/entra/identity/hybrid/connect/how-to-connect-install-prerequisites) for the versions, including but not limited to:

- [.NET framework of 4.7.2](https://dotnet.microsoft.com/en-us/download/dotnet-framework/net472#:~:text=Downloads%20for%20building%20and%20running%20applications%20with%20.NET%20Framework%204.7.2)

- [TLS1.2](/entra/identity/hybrid/connect/reference-connect-tls-enforcement)

To assist customers with the upgrade process, we occasionally auto upgrade customers where supported. If you would like to be auto upgraded, ensure you have the [auto upgrade feature](/entra/identity/hybrid/connect/how-to-connect-install-automatic-upgrade) configured.
For [auto upgrade to work](/entra/identity/hybrid/connect/security-updates-pks), you should be on version [2.3.20.0](/entra/identity/hybrid/connect/reference-connect-version-history#23200) or higher.

## Consider moving to Microsoft Entra Cloud Sync

If you're eligible, we recommend migrating from Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync. Microsoft Entra Cloud Sync is the new sync client that works from the cloud and allows customers to set up and manage their sync preferences online. We recommend that you use Cloud Sync because we're introducing new features that improve the sync experiences through Cloud Sync. You can avoid future migrations by choosing Cloud Sync if that's the right option for you. Use the https://aka.ms/EvaluateSyncOptions to see if Cloud Sync is the right sync client for you. 

See the following video to understand how Cloud sync provides value to your business.

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


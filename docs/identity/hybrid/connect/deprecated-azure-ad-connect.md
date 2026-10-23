---
title: 'Using a deprecated version of Microsoft Entra Connect'
description: Learn what to do when Microsoft Entra Connect is deprecated, how to check your version, and whether Microsoft Entra Cloud Sync meets your synchronization needs.

ms.topic: how-to
ms.date: 10/06/2026
ms.custom: msecd-doc-authoring-1023
ai-usage: ai-assisted
ms.subservice: hybrid-connect
#customer intent: As an IT administrator running Microsoft Entra Connect, I want to check whether my version is deprecated so that I can choose a supported upgrade or migration path.
---




# Using a deprecated version of Microsoft Entra Connect

You may have received a notification email that says that your [Microsoft Entra Connect version is deprecated](whatis-azure-ad-connect-v2.md) and no longer supported.  Or, you may have read a portal recommendation about upgrading your Microsoft Entra Connect version. What is next?

[!INCLUDE [Choose cloud sync](~/includes/choose-cloud-sync.md)]

Using a deprecated and unsupported version of Microsoft Entra Connect isn't recommended and not supported. Deprecated and unsupported versions of Microsoft Entra Connect may **unexpectedly stop working**.  In these instances, you may need to install the latest version of Microsoft Entra Connect as your only remedy to restore your sync process. 

We regularly update Microsoft Entra Connect with [newer versions](reference-connect-version-history.md). The new versions have bug fixes, performance improvements, new functionality, and security fixes, so it's important to stay up to date.

## How to replace your deprecated version


If you're still using a deprecated and unsupported version of Microsoft Entra Connect, here's what you should do:

 1. Check which version to install. Many organizations can use [Microsoft Entra Cloud Sync](/azure/active-directory/cloud-sync/what-is-cloud-sync) instead of Microsoft Entra Connect. Cloud Sync synchronizes users, groups, and contacts from Active Directory to Microsoft Entra ID. When device sync is enabled, it can also synchronize computer objects for Microsoft Entra hybrid join. For device setup, see [Configure device sync with Microsoft Entra Cloud Sync](../cloud-sync/device-sync.md). Cloud Sync uses a lightweight agent, is managed from the cloud, and updates automatically.

 2. If you're not yet eligible for Microsoft Entra Cloud Sync, [download Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594) and install the latest version. For more information, see [Upgrade Microsoft Entra Connect from a previous version](how-to-upgrade-previous-version.md).


## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Cloud Sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)

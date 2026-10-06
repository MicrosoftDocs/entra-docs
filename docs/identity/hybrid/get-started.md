---
title: 'Get started integrating with Microsoft Entra ID'
description: Start integrating on-premises Active Directory with Microsoft Entra ID by choosing and configuring Cloud Sync or Connect Sync for users, groups, and devices.

ms.topic: get-started
ms.tgt_pltfrm: na
ms.date: 10/06/2026
ms.custom: msecd-doc-authoring-1023
ai-usage: ai-assisted
#customer intent: As a hybrid identity administrator, I want to choose and configure a synchronization tool so that Active Directory users, groups, and devices can access Microsoft Entra ID.
---

# Steps to start integrating with Microsoft Entra ID

Use this guide to integrate on-premises Active Directory with Microsoft Entra ID. It explains how to choose between Microsoft Entra Cloud Sync and Microsoft Entra Connect Sync and configure synchronization for users, groups, and devices.

First, use [Choose the right sync tool](common-scenarios.md) to select a synchronization tool. Then follow the section for that tool.

## Cloud Sync
Use these tasks to deploy Cloud Sync and integrate Active Directory with Microsoft Entra ID.

|Task|Description|
|-----|-----|
|[Choose the right sync tool](common-scenarios.md) |Use the wizard to determine whether Cloud Sync or Connect Sync is right for you.|
|[Review Cloud Sync prerequisites](cloud-sync/how-to-prerequisites.md)|Review the prerequisites before you begin.|
|[Download and install the provisioning agent](cloud-sync/how-to-install.md)|Download and install the Microsoft Entra provisioning agent. |
|[Configure Cloud Sync](cloud-sync/how-to-configure.md)|Configure synchronization for your organization.|
|[Configure device sync](cloud-sync/device-sync.md)|Synchronize Active Directory computer objects to Microsoft Entra ID for Microsoft Entra hybrid join.|
|[Verify that users synchronize](cloud-sync/tutorial-single-forest.md#verify-users-are-created-and-synchronization-is-occurring)|Confirm that synchronization is working.|


<a name='azure-ad-connect'></a>

## Microsoft Entra Connect
Use these tasks if you're deploying Microsoft Entra Connect to integrate with Active Directory.

|Task|Description|
|-----|-----|
|[Choose the right sync tool](common-scenarios.md) |Use the wizard to determine whether Cloud Sync or Connect Sync is right for you.|
|[Review the Microsoft Entra Connect prerequisites](connect/how-to-connect-install-prerequisites.md)|Review the necessary prerequisites before getting started.|
|[Review and choose an installation type](connect/how-to-connect-install-select-installation.md)|Determine whether you'll use express or custom installation.|
|[Download Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594)|Download Microsoft Entra Connect.|
|[Install and configure Microsoft Entra Connect express settings](connect/how-to-connect-install-express.md)|If you're using express settings, install and configure Microsoft Entra Connect with express settings.|
|[Install and configure Microsoft Entra Connect custom settings](connect/how-to-connect-install-custom.md)|If you're using custom settings, install and configure Microsoft Entra Connect with express settings.|
|[Perform post installation tasks](connect/how-to-connect-post-installation.md)|Perform the post installation tasks.|
|[Verify users are synchronizing](cloud-sync/tutorial-single-forest.md#verify-users-are-created-and-synchronization-is-occurring)|Make sure it's working.|

## Next steps
- [Common scenarios](common-scenarios.md)
- [Tools for synchronization](sync-tools.md)
- [Choosing the right sync tool](common-scenarios.md)
- [Prerequisites](prerequisites.md)

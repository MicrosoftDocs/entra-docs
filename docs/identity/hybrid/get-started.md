---
title: 'Get started integrating with Microsoft Entra ID'
description: This article describes the steps required to integrate with Active Directory.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.date: 11/06/2023
ms.subservice: hybrid
ms.author: billmath

---

# Steps to start integrating with Microsoft Entra ID

If you're new to hybrid identity, then this documentation is the place that you want to start.  If you haven't done so, it's recommended that you familiarize yourself with the [What is hybrid identity?](whatis-hybrid-identity.md) documentation before jumping in.  

This document provides the steps that are required to integrate your on-premises Active Directory with Microsoft Entra ID.  Integrating with Active Directory is the process of setting up synchronization for users and groups with Microsoft Entra ID.  These steps differ slightly depending on which tool you use.

Use the [Choosing the right sync tool](https://setup.microsoft.com/azure/add-or-sync-users-to-azure-ad) first, to determine which one is right for you.  Use the next section, for the tool that was recommended for you.

## Cloud sync
Use these tasks if you're deploying cloud sync to integrate with Active Directory.

|Task|Description|
|-----|-----|
|[Determine which sync tool is correct for you](https://setup.microsoft.com/azure/add-or-sync-users-to-azure-ad) |Use the wizard to determine whether cloud sync or Microsoft Entra Connect is the right tool for you.|
|[Review the cloud sync prerequisites](cloud-sync/how-to-prerequisites.md)|Review the necessary prerequisites before getting started.|
|[Download and install the provisioning agent](cloud-sync/how-to-install.md)|Download and install the Microsoft Entra provisioning agent. |
|[Configure cloud sync](cloud-sync/how-to-configure.md)|Configure and tailor synchronization for your organization.|
|[Verify users are synchronizing](cloud-sync/tutorial-single-forest.md#verify-users-are-created-and-synchronization-is-occurring)|Make sure it's working.|


<a name='azure-ad-connect'></a>

## Microsoft Entra Connect
Use these tasks if you're deploying Microsoft Entra Connect to integrate with Active Directory.

|Task|Description|
|-----|-----|
|[Determine which sync tool is correct for you](https://setup.microsoft.com/azure/add-or-sync-users-to-azure-ad) |Use the wizard to determine whether cloud sync or Microsoft Entra Connect is the right tool for you.|
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
- [Choosing the right sync tool](https://setup.microsoft.com/azure/add-or-sync-users-to-azure-ad)
- [Prerequisites](prerequisites.md)

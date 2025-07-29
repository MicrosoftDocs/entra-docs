---
title: 'Configure your integration with Active Directory'
description: This article describes how you can configure the synchronization tools with Active Directory.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.date: 04/09/2025
ms.subservice: hybrid
ms.author: jomondi

---

# Configure your integration with Active Directory



How you configure your synchronization, depends on which synchronization tool you're using and what your business goals are.  Use the tables below to determine which features meet your target objectives.


## Cloud sync
After installing the Microsoft Entra provisioning agent, you'll need to configure cloud sync. This configuration is done via the portal. The following table provides a list of features you can use to meet your business goals.  

|Task|Description|
|-----|-----|
|[Configure and new installation cloud sync](cloud-sync/how-to-configure.md)|Configure and tailor synchronization for your organization.|
|[Scoping users and groups](cloud-sync/how-to-configure.md#scope-provisioning-to-specific-users-and-groups)|How to scope cloud sync to specific users and groups|
|[Mapping user and group attributes](cloud-sync/how-to-configure.md#attribute-mapping)|Map attributes for users and groups.|
|[Working with directory extensions and custom attributes](cloud-sync/how-to-configure.md#directory-extensions-and-custom-attribute-mapping)|Use directory extensions and custom attributes|
|[Configure single sign-on](cloud-sync/how-to-sso.md)|Set up cloud sync to use single sign-on|


<a name='azure-ad-connect'></a>

## Microsoft Entra Connect
Several of the configuration tasks used with Microsoft Entra Connect are set up when you install the tool.  You should review the custom installation section to make sure you have the information you'll need when setting up.  Also, the post installation tasks should be reviewed to further validate and customize your specific configuration.
  
|Task|Description|
|-----|-----|
|[Configure sync features](connect/how-to-connect-install-roadmap.md#configure-sync-features)|Review the configurable sync features for Microsoft Entra Connect.|
|[Customize Microsoft Entra Connect Sync](connect/how-to-connect-install-roadmap.md#customize-azure-ad-connect-sync)|How to customize the default configuration.|
|[Configure federation](connect/how-to-connect-install-roadmap.md#configure-federation-features)|How to federate with Microsoft Entra Connect.|
|[Post installation tasks](connect/how-to-connect-post-installation.md)|More tasks for managing Microsoft Entra Connect|
|[Mapping user and group attributes](cloud-sync/how-to-configure.md#attribute-mapping)|Map attributes for users and groups.|
|[Device writeback](connect/how-to-connect-device-writeback.md)|Configure device writeback.|
|[Configure single sign-on](connect/how-to-connect-sso-quick-start.md)|Set up Microsoft Entra Connect to use single sign-on.|

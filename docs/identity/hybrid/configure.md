---
title: 'Configure your integration with Active Directory'
description: Learn how to configure Microsoft Entra Cloud Sync and Connect Sync to synchronize users, groups, and contacts from Active Directory, and how to enable device sync for hybrid join.
ms.topic: concept-article
ms.tgt_pltfrm: na
ms.date: 10/06/2026
ms.custom: msecd-doc-authoring-1023
ai-usage: ai-assisted
#customer intent: As an IT administrator, I want to configure synchronization between Active Directory and Microsoft Entra ID so that users, groups, contacts, and devices stay in sync.
---

# Configure your integration with Active Directory



Choose Microsoft Entra Cloud Sync or Microsoft Entra Connect Sync based on your synchronization goals. The tables below link to configuration tasks for each tool.


## Cloud Sync
After you install the Microsoft Entra provisioning agent, configure Cloud Sync in the Microsoft Entra admin center. The following table lists configuration tasks.

|Task|Description|
|-----|-----|
|[Configure a new Cloud Sync installation](cloud-sync/how-to-configure.md)|Configure synchronization for your organization.|
|[Configure device sync](cloud-sync/device-sync.md)|Synchronize Active Directory computer objects to Microsoft Entra ID for Microsoft Entra hybrid join.|
|[Scope provisioning to specific users and groups](cloud-sync/how-to-configure.md#scope-provisioning-to-specific-users-and-groups)|Scope Cloud Sync to selected users and groups.|
|[Mapping user and group attributes](cloud-sync/how-to-configure.md#attribute-mapping)|Map attributes for users and groups.|
|[Working with directory extensions and custom attributes](cloud-sync/how-to-configure.md#directory-extensions-and-custom-attribute-mapping)|Use directory extensions and custom attributes|
|[Configure single sign-on](cloud-sync/how-to-sso.md)|Set up Cloud Sync single sign-on.|


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

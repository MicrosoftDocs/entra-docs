---
title: Prepare Your Environment for User SOA (Preview)
description: Learn the steps to prepare your environment to use Source of Authority (SOA) for users.
author: owinfreyATL
ms.topic: how-to
ms.service: entra-id
ms.subservice: hybrid
ms.date: 08/14/2025
ms.author: owinfrey
ms.reviewer: dhanyak

#CustomerIntent: As an IT administrator, I want to prepare my environment so that I can minimize my on-premises footprint using user SOA.
---

# Prepare Your Environment for User SOA (Preview)

Once you've decided that you want to minimize your on-premises footprint by using Source of Authority for users, you must prepare your Active Directory environment based on how users are configured. How you choose to prepare your environment is based on many factors. For more information on these factors, see: [Consideration for User SOA](user-source-of-authority-overview.md#consideration-for-user-soa).

The flow for preparing for user SOA is as follows:

:::image type="content" source="media/prepare-user-source-of-authority-environment/prepare-environment-steps.png" alt-text="Screenshot of steps to preparing source of authority.":::


This article walks you through what needs to be completed to prepare Microsoft Exchange, HR, and Microsoft Identity Manager environments before switching user SOA.

## Confirm your AD objects are ready to have their SOA changed 

Before changing the SOA on users, retrieve the objects from your Active Directory domain and check that they’re ready to be transferred by confirming the following information:

- Confirm that the objects are already synchronized to Microsoft Entra. Administrative objects, or those excluded from synchronization, can’t have their SOA changed. 
- Confirm that all attributes you have, or plan to modify, on those users are being synched to Microsoft Entra and are visible as *directory schema extensions*: `/graph/api/resources/extensionproperty` in Microsoft Graph. 
- Confirm there are no reference-valued attributes populated on those objects in Active Directory other than the user’s manager.  
- Confirm that the value of the manager and member attributes, if set, must be references to users in the same Active Directory domain and that they're synchronized to Microsoft Entra. They can’t refer to other object types, or to objects that aren’t synchronized from this domain to Microsoft Entra. 
- Confirm that there are no attributes on the objects that are updated by another Microsoft on-premises technology, other than Active Directory Domain Services (AD DS) itself. For example, don’t change the SOA of a user whose `userCertificate` attribute is maintained by [Active Directory Certificate Services](/windows-server/identity/ad-cs/active-directory-certificate-services-overview). 

## Update Active Directory

If you’re planning to only change the SOA for some Active Directory users, we recommend that you create a new AD DS OU for these objects to avoid inadvertently changing them in Active Directory. Users, whose SOA isn’t changing, can continue to be managed using Active Directory Users and Computers, Active Directory Module for PowerShell, or other Active Directory management tools. After creating an OU, move the objects to that OU. For more information, see: [Move-ADObject](/powershell/module/activedirectory/move-adobject?view=windowsserver2025-ps).

## Prepare your Microsoft Exchange setup

> [!NOTE]
> We recommend that you get rid of exchange server set up before transferring User Source of Authority.

In case you have Exchange Hybrid setup with Microsoft 365 Exchange Online, prepare your Exchange Server and Exchange Online as per the following guidance before switching the SOA of your user accounts.
If you're running an Exchange hybrid configuration, ensure all your mailboxes are migrated to Exchange Online before you switch the SOA for any users to the cloud. After mailbox migration of all users, these users can be managed in Microsoft 365, and you can safely switch SOA of users to cloud. With SOA switched, you disable Exchange Hybrid by completing following steps:

1.	Point the MX and Autodiscover DNS records to Exchange Online instead of Exchange Server. 

1.	Remove the Service Connection Point (SCP) values on Exchange servers. This step ensures that no SCPs are returned, and the Outlook clients use the DNS method for Autodiscover.

1.	(Optional) To secure your environment, remove the inbound and outbound connectors created by the Hybrid Configuration Wizard used for mail flow between Exchange Server and Exchange online.

1.	(Optional) To secure your environment, remove the organization relationship, Fed Trust and oauth trust set up between Exchange Server and Exchange Online by HCW.

1.	Stop writing to on-premises Exchange for the object and sync the object to cloud to ensure EXO has the latest changes from on-premises.

For more information on disabling Exchange Hybrid, see: see: [Manage recipients in Exchange Hybrid environments using Management tools](/Exchange/manage-hybrid-exchange-recipients-with-management-tools).

## Shift Your HR Integration To The Cloud 

The next step in setting up SOA is to determine your provisioning strategy for your HR system. Ideally, you’re already provisioning new employees from your cloud HR system into Microsoft Entra ID directly, and have identified all the users that are no longer needed in Active Directory


### Prep your HR system

When shifting your HR integration to the cloud from Active Directory, you should do the following to your environment:

1.	Make sure you have your cloud HR system ready and in place to initiate provisioning to Microsoft Entra ID.

1.	Go to your HR Provisioning to Active Directory configuration, and remove the users no longer needed in Active Directory from the App-> Active Directory provisioning configuration (for example, Workday to Active Directory). This stops these users from syncing into Active Directory. Apply a phased approach to provision identities from the HR system into Active directory by starting with a few users and then widening your selection criteria to scope users.


## Prepare your MIM setup 

For customers using Microsoft Identity Manager(MIM), you can update the sync rules in MIM to determine which objects continue to be provisioned into Active Directory, and which ones are provisioned into Microsoft Entra ID.  

:::image type="content" source="media/prepare-user-source-of-authority-environment/prepare-identity-setup.png" alt-text="Screenshot of MIM Set up for SOA.":::

To prepare your MIM setup to use user SOA, do the following steps:

1.	Select the attributes that will be the unique identifiers for users that are the same in both Active Directory and Microsoft Entra. 

1.	Add the [Microsoft Identity Manager connector for Microsoft Graph](/microsoft-identity-manager/microsoft-identity-manager-2016-connector-graph) to MIM sync, configure a join of the existing Active Directory users brought in from this connector.  

1.	Check the precedence settings on the user. 

1.	Perform a full import from Microsoft Entra using the Microsoft Graph connector.  

1.	Confirm that all the users planned for the SOA conversion are joined between the metaverse and the Microsoft Graph connector.  

1.	Update the management system for those users (for example, MIM Portal and Service) to add a label to user objects for which the SOA is changing to Microsoft Entra ID. 

1.	Update the sync rules so that you’re no longer syncing those labeled user objects from MIM to Active Directory, but instead synching to the Microsoft Graph connector.

1.	Keep the sync rules deactivated until the SOA transfer is complete.   

1.	After the SOA transfer, resync users. Confirm there are no exports pending to the AD MA for users whose SOA changed, only to the Microsoft Graph connector.

1.	Add to your run profile schedules a run of exporting changes from MIM to Microsoft Entra ID using the Microsoft Graph connector.   

1.	If you’re no longer exporting any changes to other users in Active Directory, then remove the export to AD run profile from your run profile schedules. 


Once these steps are completed, your MIM-synced hybrid environment should follow this diagram:
:::image type="content" source="media/prepare-user-source-of-authority-environment/identity-ready-for-source-of-authority.png" alt-text="Screenshot of a diagram of an environment that's ready to use user SOA.":::


## Prep Sync Client Sequence

Once your environment has been prepped for transferring user SOA, you must make sure your client is also prepped for the change. To prep your sync client, do the following:

1.	Identify the users and/or groups for whom you’re going to Switch the source of authority (SOA) to Microsoft Entra ID. Ensure these users and groups are currently being synced using Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync. 
    > [!NOTE]
    > Note: If you’re moving groups first, we recommend you first Switch the source of authority of the groups’ first before doing it for users 
1.	Remove these users from the App-> AD provisioning configuration (for example, Workday to AD or MIM to AD etc.) so they no longer sync into AD.  
    > [!NOTE]
    > Note: How you remove the users and/or groups from scope depends on the management tool         
1.	Wait for the sync cycle to complete and make sure the object data is the same between AD and Microsoft Entra ID. You can use tools like provision on-demand to do this manually, or do a bulk sync to handle multiple users.
1.	Stop making any changes to these users and/or groups in AD directly.  
1.	Switch the SOA of the users and/or groups.
1.	Confirm that the users and/or groups can now be managed from the cloud by following these steps. 
    1.	Go to the Microsoft Entra admin center and find the user/group you switched SOA of and see if they’re a cloud object and can be edited (or) 
    1.	Run this script to check if the “DirSync” and “isCloudManaged” attribute it set to cloud 
    1.	Check the events listed in the Audit log to see whether the SOA status has changed 
1.	Continue to keep the users and/or groups in scope for Connect/Cloud Sync. This is needed if these objects have references to groups, devices, and contacts managed in AD. 
1.	Change the direction of provisioning for users you stopped syncing in order to ensure these user changes are provisioned directly into Microsoft Entra ID from the corresponding HR systems. 
    1.	Create a new provisioning configuration to provision the users no longer synced from equivalent cloud app system to Microsoft Entra ID using Provisioning API.
    1.	Start provisioning the same users from the cloud system (HR or other apps) into Microsoft Entra directly. 
    1.	At this point, SOA transfer is complete, and the identities have started flowing from Cloud system to Microsoft Entra ID, or Microsoft Entra ID has become the source of authority. 
    


## Related content

- [Configure User Source of Authority (SOA) in Microsoft Entra ID (Preview)](how-to-user-source-of-authority-configure.md)



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

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.

This template provides the basic structure of a How-to article pattern. See the
[instructions - How-to](../level4/article-how-to-guide.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

How-to is a procedure-based article pattern that show the user how to complete a task in their own environment. A task is a work activity that has a definite beginning and ending, is observable, consist of two or more definite steps, and leads to a product, service, or decision.

-->

<!-- 1. H1 -----------------------------------------------------------------------------

Required: Use a "<verb> * <noun>" format for your H1. Pick an H1 that clearly conveys the task the user will complete.

For example: "Migrate data from regular tables to ledger tables" or "Create a new Azure SQL Database".

* Include only a single H1 in the article.
* Don't start with a gerund.
* Don't include "Tutorial" in the H1.

-->

# Prepare Your Environment for User SOA (Preview)


<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what the customer will do. Answer the fundamental “why would I want to do this?” question. Keep it short.

Readers should have a clear idea of what they will do in this article after reading the introduction.

* Introduction immediately follows the H1 text.
* Introduction section should be between 1-3 paragraphs.
* Don't use a bulleted list of article H2 sections.

Example: In this article, you will migrate your user databases from IBM Db2 to SQL Server by using SQL Server Migration Assistant (SSMA) for Db2.

-->

Once you've decided that you want to minimize your on-premises footprint by using Source of Authority for users, you must prepare your environment based on how users are configured within your Active Directory environment. How you choose to prepare your environment is based on many factors. For more information on these factors, see: [Consideration for User SOA](user-source-of-authority-overview.md#consideration-for-user-soa).

This article walks you through how to prepare your environment for user SOA, and walks you through steps you take for synced users synced with Active Directory.



<!---Avoid notes, tips, and important boxes. Readers tend to skip over them. Better to put that info directly into the article text.

-->

## Confirm your AD objects are ready to have their SOA changed 

Before changing the SOA on users, retrieve the objects from your Active Directory domain and check that they’re ready to be converted by confirming the following information:

- Confirm that the objects are already synchronized to Microsoft Entra. Administrative objects, or those excluded from synchronization, can’t have their SOA changed. 
- Confirm that all attributes you have, or plan to modify, on those users are being synched to Microsoft Entra and are visible as [directory schema extensions] `/graph/api/resources/extensionproperty` in Microsoft Graph. 
- Confirm there are no reference-valued attributes populated on those objects in Active Directory other than the user’s manager.  
- Confirm that the value of the manager and member attributes, if set, must be references to users in the same Active Directory domain and that they're synchronized to Microsoft Entra. They can’t refer to other object types, or to objects that aren’t synchronized from this domain to Microsoft Entra. 
- Confirm that there are no attributes on the objects that are updated by another Microsoft on-premises technology, other than Active Directory Domain Services itself. For example, don’t change the SOA of a user whose `userCertificate` attribute is maintained by AD CS. 

## Update Active Directory

If you’re planning to only change the SOA for some Active Directory users, we recommend that you create a new AD DS OU for these objects to avoid inadvertently changing them in Active Directory. Users, whose SOA isn’t changing, can continue to be managed using Active Directory Users and Computers, Active Directory Module for PowerShell, or other Active Directory management tools. After creating an OU, move the objects to that OU. For more information, see: [Move-ADObject](/powershell/module/activedirectory/move-adobject?view=windowsserver2025-ps) .



## Shift Your HR Integration To The Cloud 

The first step in setting up SOA is to determine your provisioning strategy for your HR system. Ideally, you’re already provisioning new employees from your cloud HR system into Microsoft Entra ID directly, and have identified all the users that are no longer needed in Active Directory. If not, our recommendation is to determine your HR strategy first before planning your source of authority change project.  

### Steps to Shift HR Integration to the Cloud

When shifting your HR integration to the cloud from Active Directory, you should do the following to your environment:

1.	Make sure you have your cloud HR system ready and in place to initiate provisioning to Microsoft Entra ID. 

1.	Go to your HR Provisioning to Active Directory configuration, and remove the users no longer needed in Active Directory from the App-> Active Directory provisioning configuration (for example, Workday to Active Directory). This stops these users from syncing into Active Directory. Apply a phased approach to provision identities from the HR system into Active directory by starting with a few users and then widening your selection criteria to scope users. 

1.	With these users stopped from syncing into Active Directory, switch the Source of Authority of the selected users from Active Directory to Microsoft Entra ID. 

1.	In your HR Provisioning configuration, manually Migrate/transfer attribute mappings to ensure the mappings/transformation happens from HR to Microsoft Entra ID. This requires you setting up a new provisioning configuration with the target as Microsoft Entra ID, and setting up the mappings in that configuration.  

1.	If you have switched Active Directory group management to the cloud, ensure these users are provisioned into that group moving forward.


## Prep Your Sync Client

The following sections walk you through preparing for user SOA if your Active Directory environment is currently using a non-HR sync client for users.

### Prepare your MIM setup 

For customers using Microsoft Identity Manager(MIM), you can update the sync rules in MIM to determine which objects continue to be provisioned into Active Directory, and which ones are provisioned into Microsoft Entra ID.  

1.	Select the attributes that will be the unique identifiers for users that are the same in both Active Directory and Microsoft Entra. 

1.	Add the [Microsoft Identity Manager connector for Microsoft Graph](/microsoft-identity-manager/microsoft-identity-manager-2016-connector-graph) to MIM sync, configure a join of the existing Active Directory users brought in from this connector.  

1.	Check the precedence settings on the user. 

1.	Perform a full import from Microsoft Entra using the Microsoft Graph connector.  

1.	Confirm that all the users planned for the SOA conversion have been joined between the metaverse and the Microsoft Graph connector.  

1.	Update the management system for those users (for example, MIM Portal and Service) to add a label to user objects for which the SOA is changing to Microsoft Entra ID. 

1.	Update the sync rules so that you’re no longer syncing those labeled user objects from MIM to Active Directory, but instead synching to the Microsoft Graph connector.

1.	Keep the sync rules deactivated until the SOA transfer is complete.   

1.	After the SOA transfer, resync users. Confirm there are no exports pending to the AD MA for users whose SOA changed, only to the Microsoft Graph connector.

1.	Add to your run profile schedules a run of exporting changes from MIM to Microsoft Entra ID using the Microsoft Graph connector.   

1.	If you’re no longer exporting any changes to other users in Active Directory, then remove the export to AD run profile from your run profile schedules. 

## Prepare your Microsoft Exchange Setup 

In case you have Exchange Hybrid setup with MICROSOFT 365 Exchange Online, prepare your Exchange Server and Exchange Online as per the following guidance before switching the SOA of your user accounts.  

If you're running an Exchange hybrid configuration, ensure all your mailboxes have migrated to Exchange Online before you switch SOA for any users to the cloud. After mailbox migration of all users, these users can be managed in Microsoft 365, and you can safely switch SOA of users to cloud. With SOA switched, you disable Exchange Hybrid by completing following steps:

1.	Point the MX and Autodiscover DNS records to Exchange Online instead of Exchange Server.  

1.	Remove the Service Connection Point (SCP) values on Exchange servers. This step ensures that no SCPs are returned, and the Outlook clients will instead use the DNS method for Autodiscover. 

1.	(Optional) To secure your environment, remove the inbound and outbound connectors created by the Hybrid Configuration Wizard used for mail flow between Exchange Server and Exchange online. 

1.	(Optional) To secure your environment, remove the organization relationship, Fed Trust and oauth trust set up between Exchange Server and Exchange Online by HCW. 

1.	Stop writing to on-premises Exchange for the object and sync the object to cloud to ensure EXO has the latest changes from on-premises.

For more information on disabling Exchange Hybrid, see: [Manage recipients in Exchange Hybrid environments using Management tools](/Exchange/manage-hybrid-exchange-recipients-with-management-tools).


##

##



<!-- 5. Next step/Related content------------------------------------------------------------------------

Optional: You have two options for manually curated links in this pattern: Next step and Related content. You don't have to use either, but don't use both.
  - For Next step, provide one link to the next step in a sequence. Use the blue box format
  - For Related content provide 1-3 links. Include some context so the customer can determine why they would click the link. Add a context sentence for the following links.

-->

## Next step

TODO: Add your next step link(s)

> [!div class="nextstepaction"]
> [Write concepts](article-concept.md)

<!-- OR -->

## Related content

TODO: Add your next step link(s)

- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->


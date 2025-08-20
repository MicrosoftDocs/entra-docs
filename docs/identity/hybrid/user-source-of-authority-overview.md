---
title: Embrace cloud-first posture and convert User Source of Authority (SOA) to the cloud (Preview)
description: Learn about Source of Authority (SOA) for users, including prerequisites and supported scenarios.
author: owinfreyATL
ms.topic: conceptual
ms.date: 08/13/2025
ms.author: owinfrey
ms.reviewer: dhanyak

#CustomerIntent: As an IT administrator, I want to learn about user Source of Authority (SOA) so that I can minimize my on-premises footprint.
---

<!--
Remove all the comments in this template before you sign-off or merge to the  main branch.

This template provides the basic structure of a Concept article pattern. See the [instructions - Concept](../level4/article-concept.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

Concept is an article pattern that defines what something is or explains an abstract idea.

There are several situations that might call for writing a Concept article, including:

* If there's a new idea that's central to a service or product, that idea must be explained so that customers understand the value of the service or product as it relates to their circumstances. A good recent example is the concept of containerization or the concept of scalability.
* If there's optional information or explanations that are common to several Tutorials or How-to guides, this information can be consolidated and single-sourced in a full-bodied Concept article for you to reference.
* If a service or product is extensible, advanced users might modify it to better suit their application. It's better that advanced users fully understand the reasoning behind the design choices and everything else "under the hood" so that their variants are more robust, thereby improving their experience.

-->

<!-- 1. H1
-----------------------------------------------------------------------------

Required. Set expectations for what the content covers, so customers know the content meets their needs. The H1 should NOT begin with a verb.

Reflect the concept that undergirds an action, not the action itself. The H1 must start with:

* "\<noun phrase\> concept(s)", or
* "What is \<noun\>?", or
* "\<noun\> overview"

Concept articles are primarily distinguished by what they aren't:

* They aren't procedural articles. They don't show how to complete a task.
* They don't have specific end states, other than conveying an underlying idea, and don't have concrete, sequential actions for the user to take.

One clear sign of a procedural article would be the use of a numbered list. With rare exception, numbered lists shouldn't appear in Concept articles.

-->

# Embrace cloud-first posture: Convert User Source of Authority to the cloud (Preview)

Modernization requirements have many organizations shifting Identity and Access Management (IAM) solutions from on-premises to the cloud. For the road to the cloud initiative, Microsoft has [modeled five states of transformation](/entra/architecture/road-to-the-cloud-posture#five-states-of-transformation) to align with customer business goals.

To minimize your on-premises infrastructure size and complexity, adopt a cloud-first approach. As your presence in the cloud grows, your on-premises Active Directory Domain Services (AD DS) presence can shrink. This process is called AD DS minimization: only required objects remain in the on-premises domain.

Using User SOA, you can migrate on-premises users to the cloud, and manage them there without having to re-create them in Microsoft Entra ID. By using User SOA, users can be managed within the cloud. If you have already modernized the underlying apps tied to these users, they can be removed from AD once you shift their SOA. By using SOA for these users, there’s no need to make any changes within your sync client.

This article describes how User SOA can help IT administrators transition user management from AD DS to the cloud. Once in the cloud, you can also enable advanced scenarios like access governance with Microsoft Entra ID Governance.



## User SOA Scenario

The next sections explain more details about the scenario that User SOA supports.

### Govern user lifecycle with Microsoft Entra ID Governance

**Scenario**: You modernized some or all your applications and removed the need to use AD DS users for access. For example, these applications now use user [claims with Security Assertion Markup Language (SAML)](/identity-platform/saml-claims-customization) or [OpenID Connect](/identity-platform/v2-protocols-oidc) from Microsoft Entra ID instead of federation systems such as AD FS. However, these apps still rely on the existing synched user to manage access. Using Group SOA, you can make the user editable in the cloud, remove the AD DS user completely, and govern the user through Microsoft Entra ID Governance capabilities.

:::image type="content" source="media/user-source-of-authority-overview/user-soa-minimization.jpg" alt-text="Screenshot of minimization of active directory using user soa.":::

**Solution**: You can use User SOA to make users cloud managed, and remove them from AD DS. At this point new users can be created, and managed, directly in the cloud. For more information, see: [How to create, invite, and delete users](/fundamentals/how-to-create-delete-users).


## Consideration for User SOA

Before you begin converting the SOA for users in your organization, there are certain conditions within your environment that you must consider. The following sections provide more details into what you must consider before implementing user SOA.

### HR-driven Inbound Provisioning

If your organization is using Microsoft Entra HR inbound provisioning from a source such as Workday, or SuccessFactors, you must direct changes to those users directly to Microsoft Entra ID. For more information, see: [Shift Your HR Integration To The Cloud](prepare-user-soa-environment.md#shift-your-hr-integration-to-the-cloud).

### Active Directory Users and Computers or the Active Directory module for PowerShell

If your organization is using AD management tools such as Active Directory Users and Computers or the Active Directory module for PowerShell, then changes made using those tools to AD objects whose SOA has been changed will cause an inconsistency with the Microsoft Entra representation. Prior to performing a SOA change, your organization should move those objects to a designated AD OU that signals those objects should no longer be managed via AD tools.   

### Microsoft Identity Manager with the AD MA

If your organization is using Microsoft Identity Manager with the AD MA to manage AD users and groups, then prior to an SOA change, the organization must configure their sync logic to no longer export changes to those objects from MIM via AD MA. Instead of using the AD MA, you can have MIM update the objects in Microsoft Entra using the [MIM connector for Microsoft Graph](/microsoft-identity-manager/microsoft-identity-manager-2016-connector-graph) so that the changes made by MIM are first sent to Microsoft Entra, and then to Active Directory where needed. For more information, see: [Prepare your MIM setup](prepare-user-soa-environment.md#prepare-your-mim-setup).

### Applications

Your application must be modernized, and you should use [cloud authentication](/entra/architecture/authenticate-applications-and-users) for source of authority to work. If you need to access on-premises resources, you can use Microsoft Entra Kerberos and [Microsoft Entra Private Access](/entra/global-secure-access/concept-private-access) to access Kerberos based AD apps. For LDAP based applications, we recommend using Microsoft Entra Domain Services.  

### Devices

We recommend that customers migrate their devices to the cloud, and use a Microsoft Entra Joined Device setup in order to fully use user SOA capabilities. For groups, there’s no prerequisites around devices.  

### Credentials





## Related content

- [Configure User Source of Authority (SOA) in Microsoft Entra ID (Preview)](how-to-user-source-of-authority-configure.md)

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.

-->

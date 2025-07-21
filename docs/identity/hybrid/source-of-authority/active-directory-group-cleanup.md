---
title: How to clean up unused Active Directory groups in a single domain
description: Step-by-step guide to identifying, triaging, and removing unused security and distribution groups in Active Directory using a structured scream test methodology. Improve security and reduce administrative burden by cleaning up groups no longer needed in your domain.
author: Justinha
manager: dougeby
ms.topic: how-to
ms.date: 07/21/2025
ms.author: justinha
ms.reviewer: justinha
---

# Clean up unused Active Directory groups in a single domain

One challenge many organizations face is the proliferation of groups, particularly security groups, in their Active Directory domains. An organization may create security groups for projects, but over time, they are no longer needed. These groups can linger unmaintained in the domain. 

There's no way to confirm if a particular group is needed to access, for example, an app, or a file on a detached removable drive. So we need another way to identify and clean up these groups that are no longer needed.

This article outlines how to use a *scream test* methodology to clean up groups from an Active Directory domain. Cleanup reduces administrative burden, and the risk of unmanaged groups in that domain. It also prevents these groups from sync with Microsoft Entra. They can be deleted from Microsoft Entra, and they won't appear in the Microsoft Entra admin center or applications.

In this approach, the administrator determines for each group, whether
they are to be maintained and managed with an AD-based management
system, such as Active Directory Users and Computers or Exchange, managed with a cloud-based management system such as Microsoft Entra or Exchange Online, or may no longer be needed. If the group may no longer be
needed, it proceeds through multiple ‘scream test’ processes to determine that it is no longer in active use,before it is deleted from Active Directory.

There are multiple paths to determining whether a group is no longer
needed. In some cases, the scream test may indicate that a group is
still required, and should continue to be maintained in AD, or should be
managed in a cloud service such as Microsoft Entra.

:::image type="content" source="media/active-directory-group-cleanup/paths.png" alt-text="Screenshot of a flowchart diagram showing the process for cleaning up Active Directory groups.":::

## Scope of applicability

- This article focuses on Security and Distribution List (DL) groups in
  an Active Directory topology, with a single forest, single domain.
  Multi-forest, non-AD environments, and local groups on domain-joined
  computers, are outside the scope of this version of the article.

- This article focuses on groups whose members are users and other
  groups, which are in scope for being synched to Microsoft Entra.
  Groups which contain computers, contacts or other objects as members
  are outside the scope of this article.

- This article focuses on groups created in Active Directory by using Active Directory Users and Computers, Microsoft Identity Manager (MIM), or other identity management tools. This article doesn't cover Built-in groups, or groups that get created by other products.

## Prerequisites

These prerequisites must be completed before you start to remove unused groups:

- You need membership in the Domain Admins group, or similar permission to update, move, and delete groups. 

- You need to be able to change the scope of Microsoft Entra Connect Sync or Cloud Sync to include or exclude groups.

- You need to create a Group Policy Object (GPO) for all writable domain controllers to enable change logging and a central repository for logs.

- You need to enable the Active Directory Recycle Bin.

- You need to creat two organizational units (OUs) in the domain – one for temporary Kerberos app scream
  test groups, and another for temporary Lightweight Directory Access Protocol (LDAP) app scream test groups.

## Perform a group analysis for the domain

The goal for group analysis is to review and confirm that groups are:

- Needed for an AD-integrated application and managed by using an
  AD-integrated tool.

- Needed for an AD-integrated application and managed by using
  Microsoft Entra or Exchange Online, with the membership written back
  to Microsoft Entra.

- Potentially no longer needed in the AD domain, but is needed in services that are connected to Microsoft Entra, and could be maintained solely in Microsoft Entra.

- Not needed by any applications that are integrated with AD or Microsoft Entra.

The first step is to identify and categorize the groups in your domains
which have not yet been triaged. For large organizations with many
thousands of groups, you will need to select which order to evaluate the
groups. This can include factors like:

- Group type
- Built-in group vs group created in domain
- OU
- Group size – number of memberships
- Whether the group is a member of another group in AD

Select a reasonable size batch of untriaged groups for analysis. Based upon the type of each group, see the next sections for steps to analyze it for potential cleanup:

- [Analysis for a DL or MESG](#analysis-for-a-dl-or-mesg)
- 

### Analysis for a DL or MESG

1. Check if an owner is set for the group in Exchange or Exchange
   Online. Contact the owner of the group to determine if the
   group is still needed.

1. Check if the group has members. If there are no members, proceed to the cloud
   scream test.

1. Check the Exchange or Exchange Online logs to see if mail was
   sent to the group. If mail was sent, then the group is likely still
   in use. Contact the senders of those mails to determine the
   purpose of the group.

1. Check if the group members include any users, contacts, or groups that aren't
   synced to Microsoft Entra. If the group includes members that aren't synced, it won't be
   converted to a Microsoft 365 group or Exchange Online DL. Perform a Kerberos
   scream test and successor test. After you finish:

   - If the group is still needed, maintain it in the domain by using Exchange on-premises.

   - If the group is still needed, change the sync rules to have the
      members be present in Microsoft Entra and then replace with an Exchange Online
      DL or M365 group.

   - If the group was not needed, remove the group from the domain.

1. If the group is a DL, then even if the members of the group are in
   Microsoft Entra, the group will not be able to have its membership SOA converted
   to Microsoft Entra. You should perform cloud scream test and successor tests, and
   when complete, the options are:

   1. If the group was still needed, replace with an Exchange Online DL

   1. If the group was still needed, replace with a M365 group

   1. If the group was not needed, remove the group from AD and do not
      replace

   Contact your Exchange administrator to determine which option to proceed
   with.

1. If the group is a MESG, then the group will not be able to have its
   membership SOA converted to Microsoft Entra. Perform cloud scream test and
   successor tests, and when complete, the options are:

   1. Replace with a M365 group.

   1. Create separate DL and SG, and process each one separately.

   1. Convert the group to a non mail enabled SG.

   1. remove the group from AD and do not replace.

   Contact your Exchange administrator to determine if the group is still
   needed for Exchange purposes. If so, then proceed with options a or b.
   Otherwise assume that the group will only need to be a security group or
   is no longer needed (options c or d), and proceed with the next section,
   analysis for a security group.

### Analysis for a security group

1. Check the membership of the group.

   If the group has no members, proceed to cloud scream test.

   If the group has as members:

   | **Member object type**                                   | **Recommendations**                                                                                                                                                                                                                 |
   |:--------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
   | One or more Computers                                   | *Group is likely used for group policy or System Center administration. Contact Windows Server and System Center administrators to determine their plans for this group. May replace with a new approach with Azure or Intune.*     |
   | One or more FSP                                         | *If this is a multi-domain environment, then consider flattening domains as Microsoft Entra will not be able to manage group memberships across domains.*                                                                           |
   | One or more Contacts                                    | *If this is a MESG, then those contacts will not be able to authenticate to Microsoft Entra, so should be removed from the group if the group is to be converted to non-mail-enabled.*                                                        |
   | One or more users or groups not synched to Microsoft Entra (excluded from sync scope) | *The group should not have its SOA converted*                                                                                                                                                |
   | Users and groups synched to Microsoft Entra                       | *Plan to perform a scream test for cloud usage.*                                                                                                                                            |

1. Check the change date of the group. If the group has been recently
   modified, check the logs to determine who modified the group, and
   then contact them to determine the purpose of the group, and whether
   it can be converted to a cloud security group.

1. Otherwise, if the group has not been recently modified, check if
   there is an ACL on the group or its containing OU to delegate
   ownership of the group. If there is, contact the owners to determine
   the purpose of the group.

1. Otherwise, check if there is a group which has this group as a
   member, and that group has an identified owner. If so, contact the
   owners of that group.

1. If the group is not a dependent of another group, has not been
   recently changed and has no clear owners, and the group has as
   members only users and groups that were synched to Microsoft Entra, then
   continue at the section below to perform a scream test for cloud
   usage.

1. Otherwise, if the group has user or group members that aren't Microsoft Entra accounts,
   and is not a built-in group, then proceed with the scream test for
   Kerberos apps section.

## Scream test for cloud usage

This test determines if there are users in groups that are used for cloud resources, including privileged roles in an Azure subscription.

1. First, check in Entra if there is a reference to the group

   1. in another cloud group

   1. from an app role

   1. from Conditional Access policy

   1. in PIM

   1. in Lifecycle Workflows, Access Reviews or Entitlement Management

   If so, then contact the administrators of that resource / service to
   determine how the group is used and if it can be replaced with a cloud
   security group.

1. Check if there is a reference to the group from an Azure role in an
   Azure subscription, resource group or resource. If so, contact the
   owners of that Azure subscription.

1. Check with Exchange, SharePoint, Intune, Azure and other
   administrators to determine if the group is needed for the
   administration of their services.

1. Check with the owners of data in Microsoft Online Services to
   determine if they are using the group.

1. Now that you have determined there is no evident use of the group in
   Microsoft Online Services, there may be another service which was
   not evident. In order to detect this, proceed to performing a cloud
   scream test.

1. Change your cloud sync/connect sync configuration to exclude the
   group from being synched.

1. Wait for synchronization and confirm the group is no longer visible
   in Microsoft Entra.

1. Wait N days.

1. If there are complaints, remove the group from exclusion, and
   identify the team relying upon the group, and determine a plan to
   migrate the relying team to use a cloud managed group in future.

1. If there are no complaints about the group no longer being available
   in Microsoft Entra, then proceed to scream test for Kerberos apps.

## Scream test for Kerberos apps

This test determines if there are apps which are relying upon a user
being a member of a security group, where AD provides a Kerberos ticket
containing the group id of this group or another containing it, to the
app.

To perform a Kerberos scream test, follow these steps:

1. Move the group to the OU for groups in Kerberos scream test.

1. Convert the group to a DL, so that the group is no longer included in
   Kerberos tokens. Alternatively, remove all the membership, for
   instance by moving the membership to some adjoining new group
   temporarily.

1. Wait N days.

1. If there are complaints, convert the group type back to SG, re-add the
   members, and identify the team relying upon the group. Work with
   that team to plan to move to cloud managed groups.

1. If there are no complaints, proceed to the scream test for LDAP apps.

## Scream test for LDAP apps

This test determines if there are LDAP apps which are relying upon a
user being a member of a security group.

1. Move group to the OU for groups in LDAP scream test.

1. Empty the membership of the group. For instance, by moving the
   membership to some adjoining new group temporarily.

1. Wait N days.

1. If there are complaints, then restore the membership of the group,
   move it back to its original OU. Identify the team relying upon the
   group.

1. If there are no complaints, then delete the group. The group will go
   to the AD recycle bin.

## Related content

- [Group SOA overview](concept-source-of-authority-overview.md)
- [How to configure Group SOA](how-to-group-source-of-authority-configure.md)
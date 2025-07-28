---
title: How to clean up unused Active Directory groups in a single domain
description: Step-by-step guide to identifying, triaging, and removing unused security and distribution groups in Active Directory using a structured scream test methodology. Improve security and reduce administrative burden by cleaning up groups no longer needed in your domain.
author: Justinha
manager: dougeby
ms.topic: how-to
ms.date: 07/28/2025
ms.author: justinha
ms.reviewer: justinha
---

# Clean up unused Active Directory groups in a single domain

One challenge many organizations face is the proliferation of groups, particularly security groups, in their Active Directory domains. An organization may create security groups for projects, but over time, they are no longer needed. These groups can linger unmaintained in the domain. 

There's no way to confirm if a particular group is needed to access an app or a file. So we need another way to identify and clean up these groups that are no longer needed.

This article outlines how to use a *scream test* methodology to clean up groups from an Active Directory domain. Cleanup reduces administrative burden, and the risk of unmanaged groups in that domain. It also prevents these groups from sync with Microsoft Entra. 

First you determine whether each group needs to be managed with an AD-based management
tool like **Active Directory Users and Computers**, managed in the cloud with Microsoft Entra admin center or Exchange Online, or may no longer needed. If the group may no longer be
needed, you can run multiple scream tests to determine if it's active. If it's no longer active, you can delete it from the Active Directory domain.

There are multiple ways to determine whether a group is no longer
needed. In some cases, the scream test indicates that a group is
still required, and whether to manage it in Microsoft Entra ID or the Active Directory domain.

:::image type="content" source="media/active-directory-group-cleanup/paths.png" alt-text="Screenshot of a flowchart diagram showing the process for cleaning up Active Directory groups.":::

## Scope of applicability

- This article focuses on Security and Distribution List (DL) groups in
  an Active Directory topology, with a single forest, single domain.
  Multiforest, non-AD environments, and local groups on domain-joined
  computers, are outside the scope of this version of the article.

- This article focuses on groups whose members are users and other
  groups that are in scope for sync to Microsoft Entra.
  Groups that contain computers, contacts, or other objects as members
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
that need triage. For large organizations with many
thousands of groups, you need to choose an order to evaluate the
groups. The order can be based on factors like:

- Group type (built-in group vs group created in the Active Directory domain)
- Grooup organizational unit (OU)
- Group size and membership
- Group nesting (the group is a member of another group in the Active Directory domain)

Select a reasonable size batch of untriaged groups for analysis. Based upon the type of each group, see the next sections for steps to analyze it for potential cleanup:

- [Analysis for a Distribution List or Mail-ennabled security group](#analysis-for-a-distribution-list-or-mail-ennabled-security-group)
- [Analysis for a security group](#analysis-for-a-security-group)

### Analysis for a Distribution List or Mail-ennabled security group

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
   Microsoft Entra, the group SOA can't be converted
   to Microsoft Entra. You should perform cloud scream test and successor tests, and
   when complete, the options are:

   - If you still need the group, replace it with an Exchange Online DL or a Microsoft 365 group.
   - If the group was not needed, remove the group from the Active Directory domain and don't replace it. 

   Contact your Exchange administrator to determine which option to proceed
   with.

1. If the group is a MESG, then the group SOA can't be converterd. Perform cloud scream test and
   successor tests, and when complete, the options are:

   - Replace with a Microsoft 365 group.
   - Create separate DL and SG, and process each one separately.
   - Convert the group so it's not a MESG.
   - Remove the group from the Active Directory domain and don't replace it.

   Contact your Exchange administrator to determine if the group is still
   needed for Exchange purposes. If it's still needed for Exchange, replace it with a Microsoft 365 group, or create separate DL and security group, and process each one separately.
   Otherwise, assume that the group only needs to be a security group, or
   it's no longer needed, and proceed with the analysis for a security group.

### Analysis for a security group

1. Check the membership of the group. If the group has no members, proceed to [cloud scream test](#scream-test-for-cloud-usage). Review the recommendations in the following table for other member object types.

   | **Member object type**                                   | **Recommendations**                                                                                                                                                                                                                 |
   |:--------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
   | One or more Computers                                   | Group is likely used for group policy or System Center administration. Contact Windows Server and System Center administrators to determine their plans for this group. May replace with a new approach with Azure or Intune.    |
   | One or more Contacts                                   | If this is a MESG, then those contacts can't to authenticate to Microsoft Entra. Remove them from the group if you plan to convert the group to not be mail-enabled.                                                       |
   | One or more users or groups not synced to Microsoft Entra (excluded from sync scope) | The group shouldn't have its Source of Authority converted.                                                                                                                                           |
   | Users and groups synced to Microsoft Entra                       | Plan to perform a scream test for cloud usage.                                                                                                                                          |

1. Check the change date of the group. If the group is recently
   modified, check the logs to determine who modified the group. Contact them to determine the purpose of the group, and whether
   it can be converted to a cloud security group.

1. Otherwise, if the group isn't recently modified, check if
   there's an access control list on the group or its OU that delegates
   ownership of the group. If there is, contact the owners to determine
   the purpose of the group.

1. Otherwise, check if another group has this group as a
   member, and that group has an identified owner. If so, contact the
   owners of that group.

1. If the group isn't a dependent of another group, isn't
   recently changed, has no clear owner, and the members are only users and groups that are synced to Microsoft Entra, then
   continue to the next section to perform a [scream test for cloud usage](#scream-test-for-cloud-usage).

1. Otherwise, if the group has user or group members that aren't Microsoft Entra accounts,
   and isn't a built-in group, then proceed with the [scream test for Kerberos apps](#scream-test-for-kerberos-apps).

## Scream test for cloud usage

This test determines if there are users in groups that are used for cloud resources, including privileged roles in an Azure subscription.

1. First, check in Microsoft Entra if there's a reference to the group:

   - From an app role
   - From a Conditional Access policy
   - In another cloud group
   - In Privileged Identity Management
   - In lifecycle workflows, access reviews or entitlement management

   If so, then contact the administrators of that resource or service to
   determine how the group is used and if it can be replaced with a cloud
   security group.

1. Check if there'ss a reference to the group from an Azure role in an
   Azure subscription, resource group or resource. If so, contact the
   owners of that Azure subscription.

1. Check with Exchange, SharePoint, Intune, Azure, and other
   administrators to determine if the group is needed for the
   administration of their services.

1. Check with the owners of data in Microsoft Online Services to
   determine if they use the group.

1. After you determine there's no evident use of the group in
   Microsoft Online Services, there may be another service that was
   not evident. To detect if there's another service, proceed to perform a [scream test for cloud usage](#scream-test-for-cloud-usage).

1. Change your Cloud sync or Connect sync configuration to exclude the
   group from being synced.

1. Wait for synchronization and confirm the group is no longer visible
   in Microsoft Entra.

1. Wait *N* days.

1. If there are complaints, remove the group from exclusion. Identify the team that relies upon the group, and determine a plan to
   migrate the team to use a cloud managed group in future.

1. If there are no complaints about the group no longer being available
   in Microsoft Entra, then proceed to the [scream test for Kerberos apps](#scream-test-for-kerberos-apps).

## Scream test for Kerberos apps

This test determines if there are apps that rely upon a user
being a member of a security group, where AD DS provides to the app a Kerberos ticket
that contains the group ID of this group or another group that contains it.

To perform a Kerberos scream test, follow these steps:

1. Move the group to the OU for groups in Kerberos scream test.

1. Convert the group to a DL, so that the group is no longer included in
   Kerberos tokens. Alternatively, remove the members. For example, move the members to another new group
   temporarily.

1. Wait *N* days.

1. If there are complaints, convert the group type back to a security group, re-add the
   members, and identify the team that relies upon the group. Work with
   that team to plan to move to cloud managed groups.

1. If there are no complaints, proceed to the scream test for LDAP apps.

## Scream test for LDAP apps

This test determines if there are LDAP apps that rely upon a
user being a member of a security group.

1. Move group to the OU for groups in LDAP scream test.

1. REmove members from the group. For example, move the members to another new group temporarily.

1. Wait *N* days.

1. If there are complaints, then restore the membership of the group,
   move it back to its original OU. Identify the team that relies upon the
   group.

1. If there are no complaints, then delete the group. The group goes
   to the Active Directory Recycle Bin.

## Related content

- [Group SOA overview](concept-source-of-authority-overview.md)
- [How to configure Group SOA](how-to-group-source-of-authority-configure.md)
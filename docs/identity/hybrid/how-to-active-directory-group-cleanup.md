---
title: How to clean up unused Active Directory Domain Services (AD DS) groups in a single domain
description: Step-by-step guide to identifying, triaging, and removing unused security and distribution groups in Active Directory Domain Services (AD DS) using a structured scream test methodology. Improve security and reduce administrative burden by cleaning up groups no longer needed in your domain.
author: Justinha
manager: dougeby
ms.topic: how-to
ms.date: 07/28/2025
ms.author: justinha
ms.reviewer: justinha
---

# Clean up unused Active Directory Domain Services groups in a single domain

One challenge many organizations face is the proliferation of groups, particularly security groups, in their Active Directory Domain Services (AD DS) domains. An organization might create security groups for projects, but over time, they're no longer needed. These groups can linger unmaintained in the domain. 

There's no way to confirm if a particular group is needed to access an app or a file. So we need another way to identify and clean up these groups that are no longer needed.

This article outlines how to use a *scream test* methodology to clean up groups from an AD DS domain. Cleanup reduces administrative burden, and the risk of unmanaged groups in that domain. It also prevents these groups from being synced into Microsoft Entra. 

First you determine whether each group needs to be managed with an AD-based management tool like **Active Directory Users and Computers**, or managed in the cloud with Microsoft Entra admin center or Exchange Online, or if it might not be needed. If the group might not be needed, you can run multiple scream tests to determine if it's active. If it's no longer active, you can delete it from the AD DS domain.

There are multiple ways to determine whether a group is no longer needed. In some cases, the scream test indicates that a group is still required, and whether to manage it in Microsoft Entra ID or the AD DS domain.

:::image type="content" source="media/active-directory-group-cleanup/paths.png" alt-text="Screenshot of a flowchart diagram showing the process for cleaning up AD DS groups.":::

## Scope of applicability

- This article focuses on Security and Distribution List (DL) groups in
  an AD DS topology, with a single forest, single domain.
  Multiforest, non-AD environments, and local groups on domain-joined
  computers, are outside the scope of this version of the article.

- This article focuses on groups whose members are users and other
  groups that are in scope for sync to Microsoft Entra.
  Groups that contain computers, contacts, or other objects as members
  are outside the scope of this article.

- This article focuses on groups created in AD DS by using Active Directory Users and Computers, Microsoft Identity Manager (MIM), or other identity management tools. This article doesn't cover Built-in groups, or groups that get created by other products.

## Prerequisites

These prerequisites must be completed before you start to remove unused groups with this approach:

- You need membership in the Domain Admins group, or similar permission to update, move, and delete groups. 

- You need to be able to change the scope of Microsoft Entra Connect Sync or Cloud Sync to include or exclude groups.

- You need to create a Group Policy Object (GPO) for all writable domain controllers to enable logging of AD DS object modifications, and set up a central repository for collected logs. For more information, see: 
  - [Configure audit policies for Windows event logs](/defender-for-identity/deploy/configure-windows-event-collection)
  - [Event 5136: A directory service object was modified](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-5136)
  - [Collect Windows events from virtual machine with Azure Monitor](/azure/azure-monitor/vm/data-collection-windows-events)

- You need to [enable the Active Directory Recycle Bin](/windows-server/identity/ad-ds/get-started/adac/active-directory-recycle-bin).

- You need to create two organizational units (OUs) in the domain – one for temporary Kerberos app scream test groups, and another for temporary Lightweight Directory Access Protocol (LDAP) app scream test groups.

## Perform a group analysis for the domain

The goal for group analysis is to review and confirm which of the groups in a domain are:

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

- Group type (security group, mail-enabled security group, or distribution list)
- Group organizational unit (OU)
- Group size and membership
- Group nesting (the group is a member of another group in the AD DS domain)

Select a reasonable size batch of untriaged groups for analysis. Based upon the type of each group, see the next sections for steps to analyze it for potential cleanup:

- [Analysis for a Distribution List or Mail-enabled security group](#analysis-for-a-distribution-list-or-mail-enabled-security-group)
- [Analysis for a security group](#analysis-for-a-security-group)

### Analysis for a Distribution List or Mail-enabled security group

1. See if an owner is set for the group in Exchange or Exchange Online. Contact the owner of the group to determine if the group is still needed.

1. See if the group has members. If there are no members, proceed to the cloud scream test.

1. Search the Exchange or Exchange Online logs to see if mail was sent to the group. You can use [Get-MessageTrackingLog](/powershell/module/exchange/get-messagetrackinglog) to search and analyze the logs. If mail was sent, then the group is likely still in use. Contact the senders of those mails to determine the purpose of the group.

1. See if the group members include any users, contacts, or groups that aren't synced to Microsoft Entra. If the group includes members that aren't synced, its group type isn't updated to a Microsoft 365 group or Exchange Online DL. Perform the Kerberos scream test and the successor tests. After you finish:

   - If the group is still needed, maintain it in the domain by using Exchange on-premises, or replace it with an Exchange Online DL or Microsoft 365 group.

   - If the group isn't needed, remove it from the domain.

1. If the group is a DL, then even if the members of the group are in Microsoft Entra, the group Source of Authority (SOA) can't be converted to Microsoft Entra. You should perform a cloud scream test and the successor tests. When complete, the options are:

   - If you still need the group, replace it with an Exchange Online DL or a Microsoft 365 group.
   - If the group isn't needed, remove it from the AD DS domain, and don't replace it. 

   Contact your Exchange administrator to determine which option to proceed with.

1. If the group is a mail-enabled security group (MESG), then the group SOA can't be converted. Perform a cloud scream test and the successor tests. When complete, the options are:

   - Replace with a Microsoft 365 group.
   - Create separate DL and security group, and process each one separately.
   - Update the group type so it's either a security group or a DL instead of a MESG.
   - Remove the group from the AD DS domain and don't replace it.

   Contact your Exchange administrator to determine if the group is still needed for Exchange purposes. If you still need the group for Exchange, replace it with a Microsoft 365 group, or create separate DL and security group, and process each one separately. Otherwise, assume that the group only needs to be a security group, or it's no longer needed, and proceed with the analysis for a security group.

### Analysis for a security group

1. Review the group members. If the group has no members, proceed to [cloud scream test](#scream-test-for-cloud-usage). Review the recommendations in the following table for other member object types.

   | **Member object type**                                   | **Recommendations**                                                                                                                                                                                                                 |
   |:--------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
   | One or more Computers                                   | Group is likely used for Group Policy or System Center administration. Contact Windows Server and System Center administrators to determine their plans for this group. You might replace it with a new approach with Azure or Intune.    |
   | One or more Contacts                                   | If the group is a MESG, then those contacts can't be used to authenticate to Microsoft Entra. Remove them from the group if you plan to convert the group to not be mail-enabled.                                                       |
   | One or more users or groups not synced to Microsoft Entra (excluded from sync scope) | The group shouldn't have its Source of Authority converted.                                                                                                                                           |
   | Users and groups synced to Microsoft Entra                       | Plan to perform a scream test for cloud usage.                                                                                                                                          |

1. Find the change date of the group. If the group is recently modified, check the logs to determine who modified the group. The security identifier (SID) of the user who modified the group is included in the subject field of [event 5136](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-5136). Contact them to determine the purpose of the group, and whether it can be updated to a cloud security group.

1. Otherwise, if the group isn't recently modified, use [Get-Acl](/powershell/module/microsoft.powershell.security/get-acl) to check if an access control list (ACL) on the group or its OU delegates ownership of the group. If an ACL delegates ownership, contact the owners to determine the purpose of the group.

1. Otherwise, check if another group has this group as a member, and that group has an identified owner. If so, contact the owners of that group.

1. If the group isn't a dependent of another group, isn't recently changed, has no clear owner, and the members are only users and groups that are synced to Microsoft Entra, then continue to the next section to perform a [scream test for cloud usage](#scream-test-for-cloud-usage).

1. Otherwise, if the group has user or group members that aren't Microsoft Entra accounts, and isn't a built-in group, then proceed with the [scream test for Kerberos apps](#scream-test-for-kerberos-apps).

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

1. See if there's a reference to the group from an Azure role in an Azure subscription, resource group, or resource. If so, contact the owners of that Azure subscription.

1. Speak with Exchange, SharePoint, Intune, Azure, and other administrators to determine if the group is needed for the administration of their services.

1. Speak with the admins of other applications in Microsoft Online Services to determine if they use the group.

1. After you determine there's no evident use of the group in Microsoft Online Services, there might be another service that wasn't evident. To detect if there's another service, proceed to perform a [scream test for cloud usage](#scream-test-for-cloud-usage).

1. Change your Cloud sync or Connect sync configuration to exclude the group from being synced.

1. Wait for sync to finish and confirm the group is no longer visible in Microsoft Entra.

1. Wait several days to determine if any users complain that the group is unavailable. For example, see if anyone opens a support ticket with IT helpdesk.

1. If there are complaints, remove the group from exclusion. Identify the team that relies upon the group, and determine a plan to
   migrate the team to use a cloud managed group in future.

1. If there are no complaints about the group no longer being available
   in Microsoft Entra, then proceed to the [scream test for Kerberos apps](#scream-test-for-kerberos-apps).

## Scream test for Kerberos apps

This test determines if there are apps that rely upon a user
being a member of a security group, where AD DS provides to the app a Kerberos ticket
that contains the group ID of this group or another group that contains it.

To perform a Kerberos scream test, follow these steps:

1. Move the group to the OU for groups in the Kerberos scream test.

1. Update the group type to a DL, so that the group is no longer included in Kerberos tokens. Alternatively, remove the members. For example, move the members to another new DL group temporarily.

1. Wait several days to determine if any users complain that the group is unavailable. For example, see if anyone opens a support ticket with IT helpdesk.

1. If there are complaints, change the group type back to a security group or add back the members. Then identify the team that relies upon the group.

1. If there are no complaints, proceed to the scream test for LDAP apps.

## Scream test for LDAP apps

This test determines if there are LDAP apps that rely upon a
user being a member of a security group.

1. Move group to the OU for groups in LDAP scream test.

1. Remove members from the group. For example, move the members to another new group temporarily.

1. Wait several days to determine if any users complain that the group is unavailable. For example, see if anyone opens a support ticket with IT helpdesk.

1. If there are complaints, restore the membership of the group, and
   move it back to its original OU. Identify the team that relies upon the
   group.

1. If there are no complaints, delete the group. The deleted group goes
   to the **Active Directory Recycle Bin**.

## Related content

- [Group SOA overview](concept-source-of-authority-overview.md)
- [How to configure Group SOA](how-to-group-source-of-authority-configure.md)
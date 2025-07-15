---
title: Manage Active Directory security groups with Group Source of Authority (SOA) in Microsoft Entra ID
description: Discover how to manage and transition Active Directory groups to Microsoft Entra ID using Group Source of Authority (SOA). Learn best practices for group management, provisioning, restoring, and rolling back changes in hybrid and cloud environments.
author: justinha
manager: dougeby
ms.topic: conceptual
ms.date: 07/14/2025
ms.author: justinha
ms.reviewer: dahnyahk
---

# Guidance for using Group Source of Authority (SOA)

Managing groups across hybrid environments is essential for organizations that transition from on-premises Active Directory (AD) to the cloud. Group Source of Authority (SOA) in Microsoft Entra ID enables you to transfer group management from AD to the cloud, providing greater flexibility, modern governance, and streamlined administration. This guidance explains how to use Group SOA to manage, provision, restore, and roll back groups in hybrid and cloud environments. You'll learn best practices for group cleanup, transitioning group management, and ensuring secure, efficient access control as you modernize your identity infrastructure.

## AD group cleanup

One challenge many organizations face is the proliferation of groups, particularly security groups, in their Active Directory domains. An organization may create security groups that are no longer needed after projects complete. These groups can linger unmaintained in the domain.

There's no way to confirm if a group is needed to access a resource, like an app or a file. So we need another way to identify and clean up groups that are no longer needed.

One option to clean up groups from an Active Directory domain, is to use a scream test methodology. For more information, see How to remove unused groups from Active Directory.

## Best practices

Follow these best practices to transition group management from on-premises to Microsoft Entra.

### Transition group management

transition my group management capabilities to the cloud and use Microsoft Entra ID Governance to manage and govern all groups, including Distribution Lists (DLs) and Mail-Enabled Security Groups (MESGs)?

Microsoft Entra ID Governance supports governance of groups that are manageable with Microsoft Entra ID, i.e. cloud security groups and Microsoft 365 groups. While Distribution Lists (DLs) and Mail-Enabled Security Groups (MESGs) can exist in the cloud, they are Exchange concepts and cannot be managed through the Entra admin center or MS Graph.

Customers should consider replacing DLs and MESGs with Microsoft 365 groups for collaboration and access management scenarios, as they offer built-in capabilities for governance, collaboration, and self-service. In most cases, DLs and MESGs will need to be recreated as Microsoft 365 groups. However, simple, non-nested cloud managed DLs can be directly upgraded to Microsoft 365 groups. [Learn More.](/exchange/recipients-in-exchange-online/manage-distribution-groups/upgrade-distribution-lists)

### Transition self-service group management

I use self-service group management in Microsoft Identity Manager or other services to manage on-premises AD groups. When I transition to Group SOA and utilize Microsoft Entra ID Governance, can I replicate these functionalities in a cloud environment?

Microsoft Entra ID provides self-service group management through My Groups for Microsoft 365 and non-mail-enabled security groups. Microsoft Entra ID Governance enables access management through My Access, where you can manage groups with access packages. Access packages allow users to request access to groups as part of a structured governance framework. However, these solutions don't exactly replicate the self-service group management capabilities in Microsoft Identity Manager due to differences in on-premises and cloud solutions.

To transition self-service group management from on-premises AD groups, you can modernize applications and leverage cloud-based security groups and Microsoft 365 groups. For more information, see Self-service group management guidance for Group Source of Authority (SOA).

### Manage on-premises apps tied to Microsoft 365 groups

To manage and govern AD-based apps, you can provision Microsoft 365 groups to AD with Group Writeback V1 (GWB) in Microsoft Entra Connect sync. 
But you can't choose which groups to provision to AD.

### On-premises changes to cloud-owned security groups are overwritten
If you provision cloud security groups to AD, and someone with permissions makes a change directly to the AD group, the change is overwritten the next time you provision the cloud group to AD (typically upon the next change to the cloud group). A local AD change doesn't reflect in Microsoft Entra ID.

### Use Group Provisioning to AD to provision nested security groups
Let's say you use **Group Provisioning to AD** to provision a security group named *CloudGroupB*, which has a parent on-premises AD group named *OnPremGroupA*. You transferred SOA for *CloudGroupB*. 

Once you start managing group memberships in Microsoft Entra ID for a transferred group (*CloudGroupB*) and use **Group Provisioning to AD** to provision it as a nested group within an on-premises group (*OnPremGroupA*), the membership reference for *CloudGroupB* doesn't sync when the AD to Microsoft Entra ID sync configuration runs for *OnPremGroupA* that is in-scope for that sync. By design, the sync client doesn't recognize the cloud group membership references.

For more information about how group sync works with SOA in similar uses cases, see [How group sync works with Source of Authority](#how-group-sync-works-with-source-of-authority).

### How SOA applies to nested groups in AD

SOA applies only to the specified direct individual group object without recursion. If you apply SOA to nested groups within the group, they continue to be managed on-premises. Because this methodology is by design, explicitly apply SOA to each group that you want to convert. You might start with the group in the lowest hierarchy, and move up the tree.

### Limitation for custom LDAP connector in Microsoft Entra Connect Sync
I currently use the custom LDAP connector in Microsoft Entra Connect Sync to sync identities and groups into Microsoft Entra ID. Does Group SOA work for this scenario?

Group SOA doesn't support using the custom LDAP connector in Microsoft Entra Connect Sync to sync identities and groups into Microsoft Entra ID. It only supports transfer of SOA of groups that sync from AD to Microsoft Entra ID to be cloud objects. Rollback of SOA operations also only works if the original SOA of the object is AD.

## How group sync works with Source of Authority

The following table explains how sync works in different use cases, depending upon on ownership of the parent and member groups.
	
Use case | Parent group type | Member group type | Job | How sync works
---------|-------------------|-------------------|-----|-----------------------
A cloud-owned parent security group has only cloud-owned members. | Cloud-owned security group |Cloud-owned security group |AAD2ADGroupProvisioning (Group Provisioning to AD) | The job provisions the parent group with all its member references (member groups).
A cloud-owned parent security group has some members that are synced groups. |Cloud-owned security group |AD-owned security groups (synced groups)| AAD2ADGroupProvisioning (Group Provisioning to AD)| The job provisions the parent group, but all the member references (member Groups) that are AD-owned groups aren't provisioned.
A cloud-owned parent security group has some members that are synced groups whose SOA is converted to cloud. |Cloud-owned security group | AD-owned security groups whose SOA is converted to cloud. |AAD2ADGroupProvisioning (Group Provisioning to AD)| The job provisions the parent group with all its member references (member groups).
You convert the SOA of a synced group (parent) that has cloud-owned groups as members. | AD-owned security groups whose SOA is converted to cloud | Cloud-owned security group| AAD2ADGroupProvisioning (Group Provisioning to AD)| The job provisions the parent group with all its member references (member groups).
You convert the SOA of a synced group (parent) that has other synced groups as members. |AD-owned security groups whose SOA is converted to cloud| AD-owned security groups (synced groups) | AAD2ADGroupProvisioning (Group Provisioning to AD) |The job provisions the parent group, but all the member references (member Groups) that are AD-owned groups aren't provisioned.
You convert the SOA of a synced group (parent) whose members are other synced groups that have SOA converted to cloud. | AD-owned security groups whose SOA is converted to cloud | AD-owned security groups whose SOA is converted to cloud | AAD2ADGroupProvisioning (Group Provisioning to AD) | The job provisions the parent group with all its member references (member groups).

## How to manage cloud security groups

Security groups are fundamental for access control, policy management, and other critical functions. In most collaboration scenarios, Microsoft 365 groups are recommended due to their enhanced collaboration features, self-service options, and API capabilities. Distribution groups (DLs) and mail-enabled security groups (MESGs) remain viable options, particularly for Exchange administrators.

When you transition to the cloud, map on-premises groups to modern group types in Microsoft Entra, Exchange Online, and Microsoft 365. The following table provides information about how to map groups and manage them after SOA conversion.

| On-premises group type | Cloud group type | How they are managed after SOA conversion | Description |
|-----------------------|------------------|------------------------------------------|-------------|
| Security group | Microsoft Entra Security Group (not mail enabled) | Microsoft Entra admin center <br> Microsoft Graph APIs | Vital for access control and translate directly as Microsoft Entra security groups, offering management by Microsoft Graph and various admin centers, including the Microsoft Entra admin center. |
| Mail-enabled security group (Exchange on-premises) | Mail-enabled SG (read-only in Microsoft Entra ID and managed in Exchange) | Exchange Online or PowerShell | Can migrate directly, or be recreated as security-enabled Microsoft 365 Groups ([Create group](/graph/api/group-post-groups)). If email functionality is no longer needed, they may be recreated as Microsoft Entra security groups. Mail-enabled security groups are only editable by using Exchange or PowerShell. Security groups and Microsoft 365 groups are managed with Microsoft Graph and various admin centers, including the Microsoft Entra admin center. |
| Distribution List (Exchange on-premises) | Distribution List (read-only for Microsoft Entra and managed in Exchange) | Exchange Online or via PowerShell | Are for email-only communication. They can be migrated as Exchange Online Distribution Lists, and managed by using Exchange Online or Exchange PowerShell. They can then be converted to, or recreated, as Microsoft 365 groups. They enable shared files, calendars, Teams integration, and self-service management with Outlook, Teams, My Groups, or Microsoft Graph. |
| N/A (In the past with v1) | Microsoft 365 groups (cloud only) | Microsoft Entra admin center <br> Microsoft Graph APIs |  |

## Related content

- Group SOA overview
- How to configure Group SOA
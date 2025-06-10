---
title: Transition Active Directory Group Source of Authority to Cloud
description: Learn how to transition Active Directory group management to Microsoft Entra ID using Group Source of Authority, minimize on-premises dependencies, and streamline access governance for hybrid and cloud environments.
author: Justinha
contributors:
ms.topic: conceptual
ms.date: 06/03/2025
ms.author: justinha
ms.reviewer: justinha
---

# Embrace cloud-first posture: Transition AD Group Source of Authority to the cloud

Modernization requirements have many organizations shifting Identity and Access Management (IAM) solutions from on-premises to the cloud. For the road to the cloud initiative, Microsoft has [modeled five states of transformation](/entra/architecture/road-to-the-cloud-posture#five-states-of-transformation) to align with customer business goals.

To minimize your on-premises infrastructure size and complexity, adopt a cloud-first approach. As your presence in the cloud grows, your Active Directory Domain Services (AD DS) presence should shrink. This is known as Active Directory (AD) minimization: only required objects remain in AD DS.

A potential AD minimization approach is to transfer the source of authority for AD DS groups to Microsoft Entra ID. This approach allows you to directly manage those groups in the cloud. Administrators can delete groups from AD DS that they no longer need on-premises. If they want to keep a group in AD DS, they can configure security group provisioning from Microsoft Entra ID to AD. It then reflects changes made to the group in Microsoft Entra ID.

This article describes a new feature, Group Source of Authority (SOA) switch and transfer. Group SOA can help you, as an IT administrator, to transition group management from AD DS to the cloud. You can enable advanced scenarios like access governance with Microsoft Entra ID Governance.

## Streamline AD group migration to the cloud with Group SOA transfer

The Group SOA feature enables organizations to shift on-premises application access governance to the cloud. This feature transfers the source of authority of groups in Active Directory that synchronize to Microsoft Entra ID with Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync. With a phased migration approach, administrators can perform complex migration tasks while minimizing disruptions for end users.

Rather than move the entire directory to the cloud at once, with object-level SOA, you can gradually reduce AD dependencies in a controlled manner. You can use Microsoft Entra ID Governance to manage access governance for both cloud and on-premises applications associated with security groups.

Applying Group SOA to a group that synchronizes from AD converts the group to a cloud object. After it converts, you can edit, delete, and change the cloud group membership directly in the cloud. Microsoft Entra Connect Sync (and soon Microsoft Entra Cloud Sync) respects the conversion and stops synchronizing the object from AD. With Group SOA, you can migrate multiple groups or select specific groups. After transfer, you can perform all operations available for a cloud group. If necessary, you can reverse these changes.

## Group Source of Authority scenarios

### Govern access with Microsoft Entra ID Governance

**Scenario:** There are applications in your portfolio that you can’t modernize or that connect to AD DS. These applications use Kerberos or LDAP to query non-mail-enabled security groups in AD DS to determine access permissions. Your goal is to regulate access to these applications with Microsoft Entra ID and Microsoft Entra ID Governance. This goal necessitates that the group membership information that Microsoft Entra manages be accessible to the applications.

:::image type="content" source="media/group-source-of-authority-guidance/image1.png" alt-text="Screenshot of a scenario where applications use Kerberos or LDAP to query non-mail-enabled security groups in AD DS.":::

**Solution:** You can achieve your goal in one of two ways:

1. Use the Groups SOA Preview instructions document from the Private Preview channel to change the source of authority of the existing AD. Provision the groups back to AD with Group Provision to AD. In this model, you don’t need to change the app or create new groups. For more information, see [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance.](https://microsoft.sharepoint.com/:w:/t/APEXIdentityContent/EZQ-pYTiyPNMozFEU3rMtyUBqY-E3FmeDYk1pA6EJRiItw?e=9ixhbB)

:::image type="content" source="media/group-source-of-authority-guidance/image2.png" alt-text="Screenshot of provisioning groups back to AD with Group Provision to AD.":::

1. To replicate the groups in AD, create them from scratch in Microsoft Entra ID as new cloud security groups. Provision them to AD as Universal groups with Group Provision to AD. In this model, you can change the app to use the new group security identifiers (SID). If you use the account, global, domain local, permission model, nest the newly provisioned group under the existing group. For more information, see [Govern on-premises Active Directory(Kerberos) application access with groups from the cloud - Microsoft Entra ID | Microsoft Learn](/entra/identity/hybrid/cloud-sync/govern-on-premises-groups).

:::image type="content" source="media/group-source-of-authority-guidance/image3.png" alt-text="Screenshot of replicating groups in AD by creating new cloud security groups in Microsoft Entra ID.":::

### AD Minimization

**Scenario:** You modernized some or all your applications and removed the need to use AD groups for access. For example, these applications now use group claims with Security Assertion Markup Language (SAML) or OpenID Connect from Microsoft Entra ID instead of federation systems such as AD FS. However, these apps still rely on the existing synched security group to manage access. Using Group SOA, you can make the security group membership editable in the cloud, remove the AD security group completely, and govern the cloud security group through Microsoft Entra ID Governance capabilities if desired.

:::image type="content" source="media/group-source-of-authority-guidance/image4.png" alt-text="Screenshot of a scenario where applications use group claims with SAML or OpenID Connect from Microsoft Entra ID.":::

**Solution:** You can use Group SOA to make these groups [cloud managed groups](https://microsoft.sharepoint.com/:w:/t/APEXIdentityContent/Ea5gSg0nBRBLk_fXt5XPzBwBOqJ1yQOdQX_X6SaCIFiCtQ?e=LtJeoc) and remove them from AD. You can continue to create new groups directly in the cloud. For more information, see [Best practices for managing groups in the cloud](/entra/fundamentals/concept-learn-about-groups#best-practices-for-managing-groups-in-the-cloud).

:::image type="content" source="media/group-source-of-authority-guidance/image5.png" alt-text="Screenshot of cloud managed groups and best practices for managing groups in the cloud.":::

### Remove on-premises Exchange dependencies

**Scenario:** You migrated all user exchange mailboxes to the cloud. You updated applications that rely on mail routing features to use modern authentication methods like SAML and OpenID Connect. You no longer need to manage Distribution Lists (DLs) and Mail-Enabled Security Groups (MESG) in AD. Your goal is to migrate existing DLs and MESGs to the cloud. Then you either update these groups to Microsoft 365 groups or manage them through Exchange Online.

**Solution:** You can achieve this goal with Group SOA to make these groups [cloud managed groups](#_How_AD_groups) and remove them from AD. You can continue to edit these groups directly in EXO or via Exchange PowerShell modules . These mail objects cannot be managed directly in Microsoft Entra ID or using the MS Graph APIs.

<span class="mark">\<link to how Group SOA helps to reduce Exchange on-premises dependencies\></span>

## How Group SOA works

Conceptually, Group SOA enables you to transfer the source of authority of any supported group from AD to Microsoft Entra ID. After you transfer the group, it becomes a cloud group. You can then map it to the corresponding group type in the cloud. For a list of supported groups types, see [How AD groups translate to cloud groups after SOA transfer](https://microsoft.sharepoint.com/:w:/t/APEXIdentityContent/Ea5gSg0nBRBLk_fXt5XPzBwBOqJ1yQOdQX_X6SaCIFiCtQ?e=LtJeoc).

### Block sync from AD to Microsoft Entra ID after SOA change

After the group has SOA applied and becomes a cloud group, the latest versions of Microsoft Entra Connect Sync and Microsoft Entra Cloud Sync honor the SOA setting and no longer attempt to sync the group. When you no longer need the AD group, you can delete it instead of removing it as out-of-scope in your scoping filters.

### Seamless integration with Security Group Provision to AD

If you need to provision a security group back to AD to keep the AD copy of the group in-sync with Microsoft Entra ID (only for non-mail enabled cloud security groups), add the groups to the Group Provision to AD scoping configuration. Use **Selected Groups** or **All groups** with attribute value scoping. Provision dynamic security groups to AD. Cloud security groups provisioned to AD do so as Universal groups in AD.

When Microsoft Entra Cloud Sync provisions a security group to AD, it recognizes when existing AD groups previously had SOA applied and are provisioned from Microsoft Entra ID to AD. The SID value provides this tie together. Therefore, provisioning the cloud security group to AD does so to the original AD group (if it exists). If it doesn’t find a match in AD, it creates a new on-prem security group.

### Delete and restore groups in AD DS

If an administrator deletes a group in AD DS and subsequently decides to provision it to AD using Group Provision to AD with the same SID, the administrator must ensure that the recycle bin in AD is enabled. The group should then be restored from the recycle bin before being added to the scope for Group Provision to AD.

### Roll back SOA changes

Administrators can revert changes to Group SOA operations. In this scenario, the object source of authority reverts, and AD DS manages it. During the next synchronization cycle of Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync, AD takes control of the object, making it read-only in Microsoft Entra ID. This method ensures that any changes made while the AD group was managed in the cloud are retained and once the object is taken over, any modifications made in the cloud will be overridden.

For step-by-step details and instructions on how to use this feature, see [How to use Group Source of Authority](https://microsoft.sharepoint.com/:w:/t/APEXIdentityContent/EQRNPZ3H-fpFjEsPy46mN8YBJWgbxXmrsEIncXlIFU3EhQ?e=dKl7MU).<span id="_How_AD_groups" class="anchor"></span>

## Frequently Asked Questions

**How can I transition my group management capabilities to the cloud and use Microsoft Entra ID Governance to manage and govern all groups, including Distribution Lists (DLs) and Mail-Enabled Security Groups (MESGs)?**

Microsoft Entra ID Governance supports governance of groups that are manageable with Microsoft Entra ID, i.e. cloud security groups and Microsoft 365 groups. While Distribution Lists (DLs) and Mail-Enabled Security Groups (MESGs) can exist in the cloud, they are Exchange concepts and cannot be managed through the Entra admin center or MS Graph.

Customers should consider replacing DLs and MESGs with Microsoft 365 groups for collaboration and access management scenarios, as they offer built-in capabilities for governance, collaboration, and self-service. In most cases, DLs and MESGs will need to be recreated as Microsoft 365 groups. However, simple, non-nested cloud managed DLs can be directly upgraded to Microsoft 365 groups. [Learn More.](/exchange/recipients-in-exchange-online/manage-distribution-groups/upgrade-distribution-lists)

### I use self-service group management in Microsoft Identity Manager or other services to manage on-premises AD groups. When I transition to Group SOA and utilize Microsoft Entra ID Governance, can I replicate these functionalities in a cloud environment?

Microsoft Entra ID provides self-service group management through My Groups for Microsoft 365 and non-mail-enabled security groups. Microsoft Entra ID Governance enables access management through My Access, where you can manage groups with access packages. This allows users to request access to groups as part of a structured governance framework.  However, these solutions don’t exactly replicate the self-service group management capabilities in Microsoft Identity Manager due to differences in on-prem and cloud solutions.

To transition from on-premises AD groups, you can modernize applications and leverage cloud-based security groups and Microsoft 365 groups.

### I want to use Microsoft 365 groups to manage my on-premises AD apps. How can I manage and govern AD-based apps tied to Microsoft 365 groups (Universal groups)?

Currently, customers can provision Microsoft 365 groups to AD with Group Writeback V1 (GWB) in Microsoft Entra Connect sync. However, admins can’t choose the groups they want to provision to AD.

### What happens if I provision cloud security groups to AD and someone with permissions makes a change directly to the AD group?

Any changes made directly in AD to a group provisioned from Microsoft Entra ID are overwritten the next time you provision the cloud group to AD (typically upon the next change to the cloud group). A local AD change doesn’t reflect in Microsoft Entra ID (there’s no reconciliation feature available yet).

### I use Group Provisioning to AD to provision a security group. This security group had its source of authority transferred and is nested under an on-premises AD group. How does this scenario affect group membership management in Microsoft Entra ID for the transferred group?

Once you start managing group memberships in Microsoft Entra ID for a transferred group (such as CloudGroupA) and use Group Provisioning to AD to provision it as a nested group within an on-premises group (such as OnPremGroupB), the membership reference for CloudGroupA doesn’t sync when the AD to Microsoft Entra ID sync configuration runs for OnPremGroupB that is in-scope for that sync. By design, the sync client doesn’t recognize the cloud group membership references.

### How does SOA apply to nested groups in AD?

SOA applies only to the specified direct individual group object without recursion. If you apply SOA to nested groups within the group, on-prem continues to manage them. Because this methodology is by design, explicitly apply SOA to each group that you want to convert. You might start with the group in the lowest hierarchy and move up the tree.

### I currently use the custom LDAP connector in Microsoft Entra Connect Sync to sync identities and groups into Microsoft Entra ID. Does Group SOA work for this scenario?

This scenario is currently unsupported. We only support transfer of Source of Authority of objects and (users and groups) that sync from AD to Microsoft Entra ID to be cloud objects. Rollback of the source of authority operations will also only work if the original source of authority of the object is Active Directory.

## Related content
---
title: Embrace cloud-first posture and transition AD group Source of Authority (SOA) to the cloud (Preview)
description: Learn about Source of Authority (SOA), including prerequisites, supported scenarios, and step-by-step guidance for IT Architects and Administrators.
author: Justinha
ms.topic: conceptual
ms.date: 07/21/2025
ms.author: justinha
ms.reviewer: justinha
---
# Embrace cloud-first posture: Transition AD Group Source of Authority to the cloud (Preview)

Modernization requirements have many organizations shifting Identity and Access Management (IAM) solutions from on-premises to the cloud. For the road to the cloud initiative, Microsoft has [modeled five states of transformation](/entra/architecture/road-to-the-cloud-posture#five-states-of-transformation) to align with customer business goals.

To minimize your on-premises infrastructure size and complexity, adopt a cloud-first approach. As your presence in the cloud grows, your Active Directory Domain Services (AD DS) presence should shrink. This is known as Active Directory (AD) minimization: only required objects remain in AD DS.

A potential AD minimization approach is to transfer the source of authority for AD DS groups to Microsoft Entra ID. This approach allows you to directly manage those groups in the cloud. Administrators can delete groups from AD DS that they no longer need on-premises. If they want to keep a group in AD DS, they can configure security group provisioning from Microsoft Entra ID to AD. It then reflects changes made to the group in Microsoft Entra ID.

This article describes a new feature, Group Source of Authority (SOA) switch and transfer. Group SOA can help you, as an IT administrator, to transition group management from AD DS to the cloud. You can enable advanced scenarios like access governance with Microsoft Entra ID Governance.

## Streamline AD group migration to the cloud with Group SOA transfer

The Group SOA feature enables organizations to shift on-premises application access governance to the cloud. This feature transfers the source of authority of groups in Active Directory that synchronize to Microsoft Entra ID with Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync. With a phased migration approach, administrators can perform complex migration tasks while minimizing disruptions for end users.

Rather than move the entire directory to the cloud at once, with object-level SOA, you can gradually reduce AD dependencies in a controlled manner. You can use Microsoft Entra ID Governance to manage access governance for both cloud and on-premises applications associated with security groups.

Applying Group SOA to a group that synchronizes from AD converts the group to a cloud object. After it converts, you can edit, delete, and change the cloud group membership directly in the cloud. Microsoft Entra Connect Sync (and soon Microsoft Entra Cloud Sync) respects the conversion and stops synchronizing the object from AD. With Group SOA, you can migrate multiple groups or select specific groups. After transfer, you can perform all operations available for a cloud group. If necessary, you can reverse these changes.

:::image type="content" source="media/concept-source-of-authority-overview/source-of-authority-switch.png" alt-text="Conceptual diagram of switch for Source of Authority." lightbox="media/concept-source-of-authority-overview/source-of-authority-switch.png":::

## Group Source of Authority scenarios

### Govern access with Microsoft Entra ID Governance

**Scenario:** There are applications in your portfolio that you can’t modernize or that connect to AD DS. These applications use Kerberos or LDAP to query non-mail-enabled security groups in AD DS to determine access permissions. Your goal is to regulate access to these applications with Microsoft Entra ID and Microsoft Entra ID Governance. This goal necessitates that the group membership information that Microsoft Entra manages be accessible to the applications.

:::image type="content" source="media/concept-source-of-authority-overview/governance.png" alt-text="Conceptual diagram of on-premises app governance." lightbox="media/concept-source-of-authority-overview/governance.png":::

**Solution:** You can achieve your goal in one of two ways:

- Use the Groups SOA to change the source of authority of the existing AD. Provision the groups back to AD with Group Provision to AD. In this model, you don’t need to change the app or create new groups. For more information, see [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](/entra/id-governance/scenarios/provision-entra-to-active-directory-groups).

  :::image type="content" source="media/concept-source-of-authority-overview/source-of-authority-switch.png" alt-text="Conceptual diagram of switch for Source of Authority." lightbox="media/concept-source-of-authority-overview/source-of-authority-switch.png":::

- To replicate the groups in AD, create them from scratch in Microsoft Entra ID as new cloud security groups. Provision them to AD as Universal groups with Group Provision to AD. In this model, you can change the app to use the new group security identifiers (SID). If you use the account, global, domain local, permission model, nest the newly provisioned group under the existing group. For more information, see [Tutorial - Provision groups to Active Directory using Microsoft Entra Cloud Sync](/entra/identity/hybrid/cloud-sync/tutorial-group-provisioning).


### AD Minimization

**Scenario:** You modernized some or all your applications and removed the need to use AD groups for access. For example, these applications now use group claims with Security Assertion Markup Language (SAML) or OpenID Connect from Microsoft Entra ID instead of federation systems such as AD FS. However, these apps still rely on the existing synched security group to manage access. Using Group SOA, you can make the security group membership editable in the cloud, remove the AD security group completely, and govern the cloud security group through Microsoft Entra ID Governance capabilities if desired.


**Solution:** You can use Group SOA to make them cloud managed groups and remove them from AD. You can continue to create new groups directly in the cloud. For more information, see [Best practices for managing groups in the cloud](/entra/fundamentals/concept-learn-about-groups#best-practices-for-managing-groups-in-the-cloud).

:::image type="content" source="media/concept-source-of-authority-overview/minimization.png" alt-text="Screenshot of cloud managed groups and best practices for managing groups in the cloud.":::

### Remove on-premises Exchange dependencies

**Scenario:** You migrated all user exchange mailboxes to the cloud. You updated applications that rely on mail routing features to use modern authentication methods like SAML and OpenID Connect. You no longer need to manage Distribution Lists (DLs) and Mail-Enabled Security Groups (MESG) in AD. Your goal is to migrate existing DLs and MESGs to the cloud. Then you either update these groups to Microsoft 365 groups or manage them through Exchange Online.

**Solution:** You can achieve this goal with Group SOA to make them cloud managed groups and remove them from AD. You can continue to edit these groups directly in EXO or via Exchange PowerShell modules. These mail objects cannot be managed directly in Microsoft Entra ID or using the MS Graph APIs.


## Related content

- [Guidance for using Group Source of Authority (SOA)](concept-group-source-of-authority-guidance.md)
- [How to configure Group SOA](how-to-group-source-of-authority-configure.md)
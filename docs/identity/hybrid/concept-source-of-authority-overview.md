---
title: Embrace cloud-first posture and convert Group Source of Authority (SOA) to the cloud (Preview)
description: Learn about Source of Authority (SOA), including prerequisites, supported scenarios, and step-by-step guidance for IT Architects and Administrators.
author: justinha
ms.date: 08/19/2025
ms.author: justinha
ms.reviewer: dhanyahk
ms.service: entra-id
ms.topic: article
---
# Embrace cloud-first posture: Convert Group Source of Authority to the cloud (Preview)

Modernization requirements have many organizations shifting Identity and Access Management (IAM) solutions from on-premises to the cloud. For the road to the cloud initiative, Microsoft has [modeled five states of transformation](/entra/architecture/road-to-the-cloud-posture#five-states-of-transformation) to align with customer business goals.

To minimize your on-premises infrastructure size and complexity, adopt a cloud-first approach. As your presence in the cloud grows, your on-premises Active Directory Domain Services (AD DS) presence can shrink. This process is called AD DS minimization: only required objects remain in the on-premises domain.

One AD DS minimization approach is to convert the Group Source of Authority (SOA) to Microsoft Entra ID. This approach lets you directly manage those groups in the cloud. You can delete AD DS groups that you no longer need on-premises. If you need to keep a group on-premises, you can configure security group provisioning from Microsoft Entra ID to AD DS. Then you can make changes to the group in Microsoft Entra ID and have those changes reflected in the on-premises group.

This article describes how Group SOA can help IT administrators transition group management from AD DS to the cloud. You can also enable advanced scenarios like access governance with Microsoft Entra ID Governance.

## Video: Microsoft Entra Group Source of Authority 

Check out our video for an introduction to SOA and how it can help you shift to the cloud. 

> [!VIDEO https://www.youtube.com/embed/VpRDtulXcUw]

## Streamline AD DS group migration to the cloud by converting Group SOA 

The Group SOA feature enables organizations to shift on-premises application access governance to the cloud. This feature converts the source of authority of groups in AD DS that synchronize to Microsoft Entra ID with Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync. With a phased migration approach, administrators can perform complex migration tasks while minimizing disruptions for end users.

Rather than move the entire directory to the cloud at once, with object-level SOA, you can gradually reduce AD DS dependencies in a controlled manner. You can use Microsoft Entra ID Governance to manage access governance for both cloud and on-premises applications associated with security groups.

Applying Group SOA to a group that synchronizes from AD DS converts the group to a cloud object. After it converts, you can edit, delete, and change the cloud group membership directly in the cloud. Microsoft Entra Connect Sync respects the conversion and stops synchronizing the object from AD DS. With Group SOA, you can migrate multiple groups or select specific groups. After you convert SOA, you can perform all operations available for a cloud group. If necessary, you can reverse these changes.

## Group SOA scenarios

The next sections explain more details about the scenarios that Group SOA supports. 

### Govern access with Microsoft Entra ID Governance

**Scenario:** There are applications in your portfolio that you can’t modernize or that connect to AD DS. These applications use Kerberos or LDAP to query non-mail-enabled security groups in AD DS to determine access permissions. Your goal is to regulate access to these applications with Microsoft Entra ID and Microsoft Entra ID Governance. This goal necessitates that the group membership information that Microsoft Entra manages be accessible to the applications.

:::image type="content" source="media/concept-source-of-authority-overview/governance.png" alt-text="Conceptual diagram of on-premises app governance." lightbox="media/concept-source-of-authority-overview/governance.png":::

**Solution:** You can achieve your goal in one of two ways:

- Concert Group SOA of on-premises groups. Provision the groups back to AD DS. In this model, you don’t need to change the app or create new groups. For more information, see [Govern on-premises Active Directory Domain Services based apps (Kerberos) using Microsoft Entra ID Governance](/entra/id-governance/scenarios/provision-entra-to-active-directory-groups).

- To replicate the groups in AD DS, create them from scratch in Microsoft Entra ID as new cloud security groups. Provision them to AD DS as Universal groups. In this model, you can change the app to use the new group security identifiers. If you use the "Account > Global > Domain Local" permission model, nest the newly provisioned group under the existing group. For more information, see [Tutorial - Provision groups to Active Directory Domain Services using Microsoft Entra Cloud Sync](/entra/identity/hybrid/cloud-sync/tutorial-group-provisioning).


### AD DS Minimization

**Scenario:** You modernized some or all your applications and removed the need to use AD DS groups for access. For example, these applications now use group claims with Security Assertion Markup Language (SAML) or OpenID Connect from Microsoft Entra ID instead of federation systems such as AD FS. However, these apps still rely on the existing synched security group to manage access. Using Group SOA, you can make the security group membership editable in the cloud, remove the AD DS security group completely, and govern the cloud security group through Microsoft Entra ID Governance capabilities if desired.


**Solution:** You can use Group SOA to make them cloud managed groups and remove them from AD DS. You can continue to create new groups directly in the cloud. For more information, see [Best practices for managing groups in the cloud](/entra/fundamentals/concept-learn-about-groups#best-practices-for-managing-groups-in-the-cloud).

:::image type="content" source="media/concept-source-of-authority-overview/minimization.png" alt-text="Screenshot of cloud managed groups and best practices for managing groups in the cloud." lightbox="media/concept-source-of-authority-overview/minimization.png":::

### Remove on-premises Exchange dependencies

**Scenario:** You migrated all user Exchange mailboxes to the cloud. You updated applications that rely on mail routing features to use modern authentication methods like SAML and OpenID Connect. You no longer need to manage Distribution Lists (DLs) and Mail-Enabled Security Groups (MESG) in AD DS. Your goal is to migrate existing DLs and MESGs to the cloud. Then you either update these groups to Microsoft 365 groups or manage them through Exchange Online.

**Solution:** You can achieve this goal with Group SOA to make them cloud managed groups and remove them from AD DS. You can continue to edit these groups directly in EXO or via Exchange PowerShell modules. These mail objects cannot be managed directly in Microsoft Entra ID or using the MS Graph APIs.


## Related content

- [Guidance for using Group Source of Authority (SOA)](concept-group-source-of-authority-guidance.md)
- [How to configure Group SOA](how-to-group-source-of-authority-configure.md)
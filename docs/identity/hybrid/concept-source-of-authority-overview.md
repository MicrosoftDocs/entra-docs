---
title: Embrace cloud-first posture and convert Group Source of Authority (SOA) to the cloud (Preview)
description: Learn about Source of Authority (SOA), including prerequisites, supported scenarios, and step-by-step guidance for IT Architects and Administrators.
author: Justinha
ms.topic: conceptual
ms.date: 08/01/2025
ms.author: justinha
ms.reviewer: justinha
---
# Embrace cloud-first posture: Convert Group Source of Authority to the cloud (Preview)

Modernization requirements have many organizations shifting Identity and Access Management (IAM) solutions from on-premises to the cloud. For the road to the cloud initiative, Microsoft has [modeled five states of transformation](/entra/architecture/road-to-the-cloud-posture#five-states-of-transformation) to align with customer business goals.

To minimize your on-premises infrastructure size and complexity, adopt a cloud-first approach. As your presence in the cloud grows, your on-premises Active Directory Domain Services (AD DS) presence can shrink. This process is called AD DS minimization: only required objects remain in the on-premises domain.

One AD DS minimization approach is to convert the Group Source of Authority (SOA) to Microsoft Entra ID. This approach lets you directly manage those groups in the cloud. You can delete AD DS groups that you no longer need on-premises. If you need to keep a group on-premises, you can configure security group provisioning from Microsoft Entra ID to AD DS. Then you can make changes to the group in Microsoft Entra ID and have those changes reflected in the on-premises group.

This article describes how Group SOA can help IT administrators transition group management from AD DS to the cloud. You can also enable advanced scenarios like access governance with Microsoft Entra ID Governance.

## Streamline AD DS group migration to the cloud by converting Group SOA 

The Group SOA feature enables organizations to shift on-premises application access governance to the cloud. This feature converts the source of authority of groups in AD DS that synchronize to Microsoft Entra ID with Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync. With a phased migration approach, administrators can perform complex migration tasks while minimizing disruptions for end users.

Rather than move the entire directory to the cloud at once, with object-level SOA, you can gradually reduce AD DS dependencies in a controlled manner. You can use Microsoft Entra ID Governance to manage access governance for both cloud and on-premises applications associated with security groups.

Applying Group SOA to a group that synchronizes from AD DS converts the group to a cloud object. After it converts, you can edit, delete, and change the cloud group membership directly in the cloud. Microsoft Entra Connect Sync respects the conversion and stops synchronizing the object from AD DS. With Group SOA, you can migrate multiple groups or select specific groups. After you convert SOA, you can perform all operations available for a cloud group. If necessary, you can reverse these changes.

## Group SOA scenarios

To see scenarios that can be unlocked using group SOA, see: [Scenarios you can unlock](guidance-for-it-architects-for-source-of-authority-conversion.md#scenarios-you-can-unlock).

### Remove on-premises Exchange dependencies

**Scenario:** You migrated all user Exchange mailboxes to the cloud. You updated applications that rely on mail routing features to use modern authentication methods like SAML and OpenID Connect. You no longer need to manage Distribution Lists (DLs) and Mail-Enabled Security Groups (MESG) in AD DS. Your goal is to migrate existing DLs and MESGs to the cloud. Then you either update these groups to Microsoft 365 groups or manage them through Exchange Online.

**Solution:** You can achieve this goal with Group SOA to make them cloud managed groups and remove them from AD DS. You can continue to edit these groups directly in EXO or via Exchange PowerShell modules. These mail objects cannot be managed directly in Microsoft Entra ID or using the MS Graph APIs.


## Related content

- [Guidance for using Group Source of Authority (SOA)](concept-group-source-of-authority-guidance.md)
- [How to configure Group SOA](how-to-group-source-of-authority-configure.md)
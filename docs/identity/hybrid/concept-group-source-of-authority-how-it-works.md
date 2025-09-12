---
title: How to use group Source of Authority (SOA) to manage Active Directory Domain Services (AD DS) groups in Microsoft Entra ID (Preview)
description: Learn how to convert group management from Active Directory Domain Services (AD DS) to Microsoft Entra ID using group source of authority (SOA).
author: justinha
manager: dougeby
ms.service: entra-id
ms.subservice: hybrid
ms.topic: conceptual
ms.date: 08/01/2025
ms.author: justinha
ms.reviewer: dahnyahk
---
# How group Source of Authority (SOA) works (Preview)

You can convert the Source of Authority (SOA) of a group from Active Directory Domain Services (AD DS) to Microsoft Entra ID. After you convert the SOA, the group becomes cloud-owned, and you can map it to a corresponding cloud group type in the cloud. For a list of supported groups types, see [How to manage cloud security groups](concept-group-source-of-authority-guidance.md#how-to-manage-cloud-security-groups).

## Block sync from AD DS to Microsoft Entra ID after SOA change

After you convert the group SOA and it becomes a cloud group, the latest versions of Microsoft Entra Connect Sync and Microsoft Entra Cloud Sync honor the SOA setting. They don't continue to sync the group. When you no longer need the AD DS group, you can delete it rather than remove it as out-of-scope in your scoping filters.

## Seamless integration with security group provisioning to AD DS

To provision a cloud security group that's not mail-enabled back to AD DS and sync it with Microsoft Entra ID, add the group to the scoping configuration when you provision groups to AD DS. Use **Selected Groups** or **All groups** with attribute value scoping. Provision dynamic security groups to AD DS. Cloud security groups are provisioned as Universal groups.

When Microsoft Entra Cloud Sync provisions a security group to AD DS, it recognizes when existing domain groups previously had SOA applied and are provisioned from Microsoft Entra ID to AD DS. The security identifier (SID) value correlates them together. Therefore, provisioning the cloud security group to AD DS does so to the original AD group (if it exists). If it doesn’t find a match in AD DS, it creates a new on-premises security group.

## Delete and restore groups in AD DS

Let's suppose you delete an on-premises group in AD DS. Later, you decide to provision the group with the same SID to the AD DS domain using Microsoft Entra Cloud Sync. In this case, you need to be sure that the **Active Directory Recycle Bin** is enabled. You should restore the group from the **Active Directory Recycle Bin** before you add it to the scope for group provisioning to AD DS.

## Roll back SOA changes

You can reverse SOA changes to a group. In this scenario, the group SOA reverts, and AD DS manages it. During the next synchronization cycle, AD DS takes control of the group. In Microsoft Entra ID, the group becomes read-only. 

This method retains any changes made while the group was managed in the cloud. After the object is taken over, any modifications made in the cloud are overridden.

## Related content

- [Guidance for using Group Source of Authority (SOA)](concept-group-source-of-authority-guidance.md)
- [Configure Group Source of Authority](how-to-group-source-of-authority-configure.md)

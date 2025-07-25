---
title: How to use group Source of Authority (SOA) to manage Active Directory groups in Microsoft Entra ID (Preview)
description: Learn how to transfer group management from Active Directory to Microsoft Entra ID using group source of authority (SOA), block sync, provision groups, restore deleted groups, and roll back SOA changes for hybrid and cloud environments.
author: justinha
manager: dougeby
ms.topic: conceptual
ms.date: 07/23/2025
ms.author: justinha
ms.reviewer: dahnyahk
---
# How group Source of Authority (SOA) works (Preview)

Group SOA enables you to transfer the source of authority of any supported group from Active Directory (AD) to Microsoft Entra ID. After you transfer the group, it becomes a cloud group. You can then map it to the corresponding group type in the cloud. For a list of supported groups types, see How AD groups translate to cloud groups after SOA transfer.

## Block sync from AD to Microsoft Entra ID after SOA change

After the group has SOA applied and becomes a cloud group, the latest versions of Microsoft Entra Connect Sync and Microsoft Entra Cloud Sync honor the SOA setting and no longer attempt to sync the group. When you no longer need the AD group, you can delete it instead of removing it as out-of-scope in your scoping filters.

## Seamless integration with Security Group Provision to AD

If you need to provision a security group back to AD to keep the AD copy of the group in-sync with Microsoft Entra ID (only for non-mail enabled cloud security groups), add the groups to the Group Provision to AD scoping configuration. Use **Selected Groups** or **All groups** with attribute value scoping. Provision dynamic security groups to AD. Cloud security groups provisioned to AD do so as Universal groups in AD.

When Microsoft Entra Cloud Sync provisions a security group to AD, it recognizes when existing AD groups previously had SOA applied and are provisioned from Microsoft Entra ID to AD. The SID value provides this tie together. Therefore, provisioning the cloud security group to AD does so to the original AD group (if it exists). If it doesn’t find a match in AD, it creates a new on-prem security group.

## Delete and restore groups in AD DS

If an administrator deletes a group in AD DS and subsequently decides to provision it to AD using Group Provision to AD with the same SID, the administrator must ensure that the recycle bin in AD is enabled. The group should then be restored from the recycle bin before being added to the scope for Group Provision to AD.

## Roll back SOA changes

Administrators can revert changes to Group SOA operations. In this scenario, the object source of authority reverts, and AD DS manages it. During the next synchronization cycle of Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync, AD takes control of the object, making it read-only in Microsoft Entra ID. This method ensures that any changes made while the AD group was managed in the cloud are retained and once the object is taken over, any modifications made in the cloud will be overridden.

## Related content

- [Guidance for using Group Source of Authority (SOA)](concept-group-source-of-authority-guidance.md)
- [Configure Group Source of Authority](how-to-group-source-of-authority-configure.md)

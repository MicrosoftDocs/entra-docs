---
title: Set up group writeback within entitlement management - Microsoft Entra ID
description: Learn how to set up group writeback in entitlement management.
author: owinfreyatl
manager: femila
editor: HANKI
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 07/15/2024
ms.author: owinfrey
ms.reviewer: sponnada
---

# Setting up group writeback within entitlement management

This article shows you how to set up group writeback in entitlement management. Group writeback is a feature that allows you to write cloud groups back to your on-premises Active Directory instance by using Microsoft Entra Cloud Sync.

## Set up group writeback in entitlement management


To set up group writeback for Microsoft 365 groups in access packages, you must complete the following prerequisites:

- Set up group writeback in the Microsoft Entra admin center. 
- The Organizational Unit (OU) that is used to set up group writeback in Microsoft Entra Cloud Sync Configuration.
- Complete the [group writeback enablement steps](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md) for Microsoft Entra Cloud Sync.
 
Using group writeback, you can now sync security groups that are part of access packages to on-premises Active Directory. To sync the groups, follow the steps:

1. Create a Microsoft Entra security group.

1. Set the group to be written back to on-premises Active Directory. For instructions, see [Group writeback in the Microsoft Entra admin center](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md). 

1. Add the group to an access package as a resource role. See [Create a new access package](entitlement-management-access-package-create.md#select-resource-roles) for guidance. 

1. Launch Active Directory Users and Computers, and wait for the resulting new AD group to be created in the AD domain. When it's present, record the distinguished name, domain, account name and SID of the new AD group.

1. Configure the application to use the new group, either by updating the application or adding the group as a member of an existing group, as described in [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](../identity/hybrid/cloud-sync/govern-on-premises-groups.md).

1. Assign the user to the access package. See [View, add, and remove assignments for an access package](entitlement-management-access-package-assignments.md#directly-assign-a-user) for instructions to directly assign a user. 

1. After you've assigned a user to the access package, confirm that the user is now a member of the on-premises group once Microsoft Entra Cloud Sync cycle completes:
    1. View the member property of the group in the on-premises OU OR 
    1. Review the member Of on the user object. 

    > [!NOTE]   
    > Microsoft Entra Cloud Sync's default sync cycle schedule is every 30 minutes. You may need to wait until the next cycle occurs to see results on-premises or choose to run the sync cycle manually to see results sooner.

1. In your AD domain monitoring, allow only the gMSA account that runs the provisioning agent to have authorization to change the membership in the new AD group.

## Next steps

- [Create and manage a catalog of resources in entitlement management](entitlement-management-catalog-create.md)
- [Delegate access governance to access package managers in entitlement management](entitlement-management-delegate-managers.md)

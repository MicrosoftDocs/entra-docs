---
title: Guidance for using user Source of Authority (SOA) in Microsoft Entra ID
description: Streamline user management with User Source of Authority (SOA) in Microsoft Entra ID. Minimize your AD footprint and ensure a smooth migration to the cloud.
author: owinfreyATL
manager: dougeby
ms.topic: article
ms.service: entra-id
ms.subservice: hybrid
ms.date: 09/30/2025
ms.author: owinfrey
ms.reviewer: dahnyahk
---


# Guidance for using user Source of Authority (SOA)

Managing user identities effectively is critical for organizations transitioning to the cloud. This article provides guidance on using user Source of Authority (SOA) to help transition users from on-premises to the cloud. How to minimize your Active Directory (AD) footprint after SOA transfer, adopt best practices for transitioning user management, and ensure a smooth migration of user management to the cloud are also covered in this article. 


## Active Directory user management

One of the key scenarios for transferring SOA for users, is the ability to minimize your AD footprint. Once you complete the SOA transfer, users who no longer require access to Active Directory-specific resources can be disabled within AD, or deleted completely. 

> [!NOTE]
> If users still require access to on-premises resources after SOA transfer, then these attributes must be maintained manually using Microsoft Graph. For more information on these attributes, see: [Clear on-premises attributes for SOA transferred users](how-to-user-source-of-authority-configure.md#clear-on-premises-attributes-for-soa-transferred-users)


## Best practices

Follow these best practices to transition user management from on-premises to Microsoft Entra ID


### Move users to an OU

Using Active Directory management tools like Active Directory Users and Computers or the Active Directory module for PowerShell to modify AD objects with a changed Source of Authority (SOA) can lead to inconsistencies in their Microsoft Entra representation. Before you perform a SOA change, your organization should move those objects to a designated AD OU that signals that those objects should no longer be managed via AD tools. If the user who’s SOA you want to transfer is referenced in an on-premises managed group, then the user should remain in the sync scope. If you delete the on-premises user, then it's also removed from both the on-premises and Microsoft Entra group.


### Transition user management

Before shifting the SOA of users, ensure the sync cycle of the users is complete. Once complete, remove the users from the scope of the HR to AD, or MIM to AD configuration, and add them to your HR->Microsoft Entra ID configuration. If your organization uses Microsoft Identity Manager (MIM) with the Active Directory Management Agent (AD MA) to manage AD users and groups, you must update the sync logic to stop exporting changes to those objects via AD MA before making an SOA change. Instead of using the AD MA, you can have MIM update the objects in Microsoft Entra using the [MIM connector for Microsoft Graph](/microsoft-identity-manager/microsoft-identity-manager-2016-connector-graph) so that the changes made by MIM are first sent to Microsoft Entra, and then to Active Directory where needed. For more information, see: [Prepare your MIM setup](prepare-user-source-of-authority-environment.md#prepare-your-mim-setup). Stop making any changes directly to the user in AD. Once SOA is complete, begin management of users within the cloud.


### Users using LDAP applications

If you want to shift users using on-premises LDAP applications to the cloud, use [Microsoft Entra Domain services](../../identity/domain-services/overview.md) to shift the LDAP application to the cloud before transferring the SOA of users.


### Third-party federated authentication

If your organization uses a third-party federation authentication identity provider and plans to transfer the SOA of users, you must manage the Active Directory account manually and maintain the password using the third-party sync tool. If users are using federated authentication using [Active Directory Federation Service](/windows-server/identity/ad-fs/ad-fs-overview), then transferring SOA isn't supported.


### Devices

We recommend that customers migrate their devices to the cloud, and use a Microsoft Entra Joined Device setup in order to fully use user SOA capabilities. For groups, there’s no prerequisites around devices.

## Related content

- [Configure User Source of Authority (SOA) in Microsoft Entra ID](how-to-user-source-of-authority-configure.md)
- [Prepare Your Environment for User SOA](prepare-user-source-of-authority-environment.md)

---
title: Guidance for using User Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Discover how to manage and transition Active Directory groups to Microsoft Entra ID using Group Source of Authority (SOA). Learn best practices for group management, provisioning, restoring, and rolling back changes in hybrid and cloud environments.
author: owinfreyATL
manager: dougeby
ms.topic: conceptual
ms.date: 09/30/2025
ms.author: owinfrey
ms.reviewer: dahnyahk
---


# Guidance for using User Source of Authority (SOA) (Preview)

TTransitioning to a cloud-first identity management approach is a critical step for modern organizations aiming to enhance security, streamline operations, and reduce reliance on legacy systems. This guidance article builds on the foundational concepts introduced in the "User Source of Authority (SOA) Overview" and provides actionable insights for IT architects and administrators.

By leveraging Microsoft Entra ID as the central identity platform, organizations can modernize their identity and access management (IAM) strategies, enabling advanced governance capabilities, passwordless authentication, and seamless integration with both cloud and on-premises applications. This article outlines best practices, phased migration strategies, and key considerations to help you successfully implement SOA conversion and achieve a cloud-first posture.

Whether you're just beginning your journey or looking to optimize your hybrid environment, this guide will equip you with the tools and knowledge needed to navigate the complexities of SOA conversion and unlock the full potential of cloud-based identity management.

## Active Directory User clean up

One of the key scenarios for transferring SOA for users, is the ability to minimize your AD footprint. Once you have completed SOA transfer, users who no longer require access to Active Directory-specific resources can be disabled within AD, or deleted completely. 

> [!NOTE]
> If users still require access to on-premises resources after SOA transfer, then these attributes must be maintained manually using Microsoft Graph. For more information on these attributes, see: [Clear on-premises attributes for SOA transferred users](how-to-user-source-of-authority-configure.md#clear-on-premises-attributes-for-soa-transferred-users)


## Best practices

Follow these best practices to transition user management from on-premises to Microsoft Entra ID


### Move Users to an OU

Using Active Directory management tools like Active Directory Users and Computers or the Active Directory module for PowerShell to modify AD objects with a changed Source of Authority (SOA) can lead to inconsistencies in their Microsoft Entra representation. Before you perform a SOA change, your organization should move those objects to a designated AD OU that signals that those objects should no longer be managed via AD tools. If the user who’s SOA you want to transfer is referenced in an on-premises managed group, then the user should remain in the sync scope. If you delete the on-premises user, then it's also removed from both the on-premises and Microsoft Entra group.


### Transition user management

Before shifting the SOA of users, ensure the sync cycle of the users are complete. Once complete remove the users from the scope of the HR to AD, or MIM to AD configuration, and add them to your HR->Microsoft Entra ID configuration. Stop making any changes directly to the user in AD. Once SOA is complete, begin management of users within the cloud.

### Users using LDAP applications

If you want to shift users using on-premises LDAP applications to the cloud, use [Microsoft Entra Domain services](../../identity/domain-services/overview.md) to shift the LDAP application to the cloud before transferring the SOA of users.


### Third-party federated authentication

If your organization uses a third-party federation authentication identity provider and plans to transfer the SOA of users, you must manage the Active Directory account manually and maintain the password using the third-party sync tool. If users are using federated authentication using [Active Directory Federation Service](/windows-server/identity/ad-fs/ad-fs-overview), then transferring SOA isn't supported.


### Devices

We recommend that customers migrate their devices to the cloud, and use a Microsoft Entra Joined Device setup in order to fully use user SOA capabilities. For groups, there’s no prerequisites around devices.

## Related content

- [Configure User Source of Authority (SOA) in Microsoft Entra ID (Preview)](how-to-user-source-of-authority-configure.md)

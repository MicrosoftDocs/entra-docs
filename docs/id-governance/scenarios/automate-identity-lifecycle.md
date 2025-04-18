---
title: 'Automate identity lifecycle management with Microsoft Entra ID Governance'
description: Describes overview of identity lifecycle management for Microsoft Entra ID Governance.
ms.service: entra-id-governance
ms.subservice:
author: billmath
manager: femila

ms.workload: identity
ms.topic: overview
ms.date: 04/09/2025
ms.author: billmath
---

# Automate identity lifecycle management with Microsoft Entra ID Governance

The following document provides an overview of how you can [automate identity lifecycle processes](https://youtu.be/NxSu3JEsxmY?si=PELWAnpdI4iAMfki) using Microsoft Entra ID Governance.


## Automatic inbound provisioning from Active Directory
Provisioning from active directory to Microsoft Entra ID can be accomplished in several different ways using any of the following:

 - [Microsoft Entra Cloud Sync](~/identity/hybrid/cloud-sync/what-is-cloud-sync.md)

 - [Microsoft Entra Connect Sync](~/identity/hybrid/connect/whatis-azure-ad-connect-v2.md)

 - [Microsoft Identity Manager](/microsoft-identity-manager/microsoft-identity-manager-2016) to trigger provisioning when a new identity is created in these HR systems. 

## Automatic inbound provisioning from your organization's HR sources
HR driven provisioning is the process of creating digital identities based on a human resources system. The HR systems, become the start-of-authority for these newly created digital identities and is often the starting point for numerous provisioning processes. These HR systems can be either on-premises or cloud based. 

To manage the identity lifecycles of employees, vendors, or contingent workers, [Microsoft Entra user provisioning service](~/identity/app-provisioning/user-provisioning.md) offers integration with cloud-based human resources (HR) applications.

Microsoft on-premises HR provisioning solutions use [Microsoft Identity Manager](/microsoft-identity-manager/microsoft-identity-manager-2016) to trigger provisioning when a new identity is created in these HR systems. Using MIM, you can provision users from your on-premises HR systems to Active Directory or Microsoft Entra ID. Users already present in Active Directory can be automatically created and maintained in Microsoft Entra ID using [inter-directory provisioning](~/identity/hybrid/what-is-inter-directory-provisioning.md).

### Enabled HR scenarios

The Microsoft Entra user provisioning service enables automation of the following HR-based identity lifecycle management scenarios:

- **New employee hiring:** Adding an employee to the cloud HR app automatically creates a user in Active Directory and Microsoft Entra ID. Adding a user account includes the option to write back the email address and username attributes to the cloud HR app.
- **Employee attribute and profile updates:** When an employee record such as name, title, or manager is updated in the cloud HR app, their user account is automatically updated in Active Directory and Microsoft Entra ID.
- **Employee terminations:** When an employee is terminated in the cloud HR app, their user account is automatically disabled in Active Directory and Microsoft Entra ID.
- **Employee rehires:** When an employee is rehired in the cloud HR app, their old account can be automatically reactivated or reprovisioned to Active Directory and Microsoft Entra ID.

For more information see [What is HR driven provisioning?](~/identity/app-provisioning/plan-cloud-hr-provision.md) and [Plan cloud HR application to Microsoft Entra user provisioning](~/identity/app-provisioning/plan-cloud-hr-provision.md)

## Automatic workflow tasks with Lifecycle Workflows

- [Lifecycle workflows](../what-are-lifecycle-workflows.md) automate workflow tasks that run at certain key events, such before a new employee is scheduled to start work at the organization, as they change status during their time in the organization, and as they leave the organization. For example, a workflow can be configured to send an email with a temporary access pass to a new user's manager, or a welcome email to the user, on their first day.

## Automatic assignment policies in entitlement management
- [Automatic assignment policies in entitlement management](../entitlement-management-access-package-auto-assignment-policy.md) add and remove a user's group memberships, application roles, and SharePoint site roles, based on changes to the user's attributes. Users can also upon request, be assigned to groups, Teams, Microsoft Entra roles, Azure resource roles, and SharePoint Online sites, using [entitlement management](../entitlement-management-scenarios.md) and [Privileged Identity Management](~/id-governance/privileged-identity-management/pim-configure.md).

## Automatic provisioning to on-premises apps and other directories
- Once the users are in Microsoft Entra ID with the correct group memberships and app role assignments, [user provisioning](../what-is-provisioning.md) can create, update and remove user accounts in other applications, with connectors to hundreds of cloud and on-premises applications via SCIM, LDAP and SQL.

## Automatic guest user lifecycle rights assignment
- For guest lifecycle, you can specify in [entitlement management](../entitlement-management-overview.md) the other organizations whose users are allowed to request access to your organization's resources. When one of those users's request is approved, they are automatically added by entitlement management as a [B2B](~/external-id/what-is-b2b.md) guest to your organization's directory, and assigned appropriate access. And entitlement management automatically removes the B2B guest user from your organization's directory when their access rights expire or are revoked.

## Automatic reoccurring reviews of users and guests
- [Access reviews](../access-reviews-overview.md) automates recurring reviews of existing guests already in your organization's directory, and removes those users from your organization's directory when they no longer need access.


## License requirements
[!INCLUDE [active-directory-entra-governance-license.md](~/includes/entra-entra-governance-license.md)]

## Next steps

- [What is provisioning?](../what-is-provisioning.md)
- [Govern access for external users in Microsoft Entra entitlement management](../entitlement-management-external-users.md)
- [What is HR driven provisioning?](~/identity/app-provisioning/what-is-hr-driven-provisioning.md)
- [What is app provisioning?](~/identity/app-provisioning/user-provisioning.md)
- [What is inter-directory provisioning?](~/identity/hybrid/what-is-inter-directory-provisioning.md)

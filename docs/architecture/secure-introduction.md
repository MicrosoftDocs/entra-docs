---
title: Introduction to delegated administration and isolated environments
description: Introduction to delegated administration and isolated environments in Microsoft Entra ID.
author: gargi-sinha
manager: martinco
ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 06/27/2024
ms.author: gasinh
ms.reviewer: ajburnle
---

# Introduction to delegated administration and isolated environments

A Microsoft Entra single-tenant architecture with delegated administration often is adequate for separating environments. Your organization might require a degree of isolation not possible in a single tenant.

For this article, it's important to understand:

* How a single tenant works
* How administrative units in Microsoft Entra ID work
* What relationships there are between Azure resources and Microsoft Entra tenants
* What requirements drive isolation

<a name='azure-ad-tenant-as-a-security-boundary'></a>

## Microsoft Entra tenant as a security boundary

A Microsoft Entra tenant provides identity and access management (IAM) capabilities to applications and resources for an organization.

An identity is a directory object authenticated and authorized for access to a resource. There are dentity objects for human and nonhuman identities. To differentiate, human identities are referred to as identities and non-human identities are workload identities. Non-human entities include application objects, Service Principals, managed identities, and devices. Generally, a workload identity is for a software entity to authenticate with a system.

* **Identity** - Objects that represent humans
* **Workload identity** - Workload identities are applications, service principals, and managed identities.
  * The workload identity authenticates and accesses other services and resources

For more information, [learn about workload identities](~/workload-id/workload-identities-overview.md).

The Microsoft Entra tenant is an identity security boundary controled be administrators. In this security boundary, administration of subscriptions, management groups, and resource groups can be delegated to segmented administrative control of Azure resources. These groups depend on tenant-wide configurations of policies and settings, under Microsoft Entra Global Administrators control.

Microsoft Entra ID grants objects access to applications and Azure resources. Azure resources and applications that trust Microsoft Entra ID can be managed with Microsoft Entra ID. Following best practices, set up the the environment with a test environment.

<a name='access-to-apps-that-use-azure-ad'></a>

### Access to apps that use Microsoft Entra ID

Grant identities access to applications:

* Microsoft productivity services such as Exchange Online, Microsoft Teams, and SharePoint Online
* Microsoft IT services such as Azure Sentinel, Microsoft Intune, and Microsoft 365 Defender ATP
* Microsoft developer tools such as Azure DevOps and Microsoft Graph API
* SaaS solutions such as Salesforce and ServiceNow
* On-premises applications integrated with hybrid access capabilities such as Microsoft Entra application proxy
* Custom developed applications

Applications that use Microsoft Entra ID require directory objects configuration and management in the trusted Microsoft Entra tenant. Examples of directory objects include application registrations, service principals, groups, and [schema attribute extensions](/graph/extensibility-overview).

### Access to Azure resources

Grant toles to users, groups, and Service Principal objects (workload identities) in the Microsoft Entra tenant. To learn more, see [Azure role-based access control (RBAC)](/azure/role-based-access-control/overview) and [Azure attribute-based access control (ABAC)](/azure/role-based-access-control/conditions-overview).

Use Azure RBAC to provide access, based on role as determined by security principal, role definition, and scope. Azure ABAC adds role assignment conditions, based on attributes for actions. For more fine-grained access control add role assignment condition. Access Azure resources, resource groups, subscriptions, and management groups with assigned RBAC roles. 

Azure resources that [support managed identities](~/identity/managed-identities-azure-resources/overview.md) allow resources to authenticate, obtain access to, and get assigned roles to other resources in the Microsoft Entra tenant boundary.

Applications using Microsoft Entra ID for sign-in can use Azure resources, such as compute or storage. For example, a custom application that runs in Azure and trusts Microsoft Entra ID for authentication has directory objects and Azure resources. Azure resources in the Microsoft Entra tenant affect tenant-wide [Azure quotas and limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

### Access to directory objects

Identities, resources, and their relationships are represented as directory objects in a Microsoft Entra tenant. Examples include users, groups, Service Principals, and app registrations. Have a set of directory objects in the Microsoft Entra tenant boundary for the following capabilities:

* **Visibility**: Identities can discover or enumerate resources, users, groups, access usage reporting, and audit logs based on permissions. For example, a directory member can discover users in the directory with Microsoft Entra ID [default user permissions](~/fundamentals/users-default-permissions.md).
* **Effects on applications**: As part of their business logic, applications can manipulate directory objects through Microsoft Graph. Typical examples include reading or setting user attributes, updating user calendar, sending emails on behalf of users, and so on. Consent is needed to allow applications to affect the tenant. Administrators can consent for all users. For more information, see [permissions and consent in the Microsoft identity platform](~/identity-platform/v2-admin-consent.md).
* **Throttling and service limits**: Runtime behavior of a resource might trigger [throttling](/graph/throttling) to prevent overuse or service degradation. Throttling can occur at the application, tenant, or entire service level. Generally, it occurs when an application has a large number of requests in or across tenants. Similarly, there are [Microsoft Entra service limits and restrictions](~/identity/users/directory-service-limits-restrictions.md) that might affect application runtime behavior.

   >[!NOTE]
   >Use caution with application permissions. For example, with Exchange Online, [scope application permissions to mailboxes and permissions](/graph/auth-limit-mailbox-access).

## Administrative units for role management

Administrative units (AUs) restrict permissions in a role to a portion of your organization. You can use AUs to delegate the [Helpdesk Administrator](~/identity/role-based-access-control/permissions-reference.md) role to regional support specialists, so they can manage users in the region they support. An AU is a Microsoft Entra resource that can be a container for other Microsoft Entra resources. An AU can contain:

* Users
* Groups
* Devices

In the following diagram, AUs segment the Microsoft Entra tenant based on organizational structure. This is useful when business units or groups have dedicated IT support staff. Use AUs to provide privileged permissions limited to an AU.

   ![Diagram of Microsoft Entra administrative units.](media/secure-introduction/administrative-units.png)

For more information, see [administrative units in Microsoft Entra ID](~/identity/role-based-access-control/administrative-units.md).

### Common reasons for resource isolation

Sometimes you isolate a group of resources from other resources for security reasons, such as the resources have unique access requirements. This is a good use case for AUs. Determine the users and security principal resource access, and in what roles. Reasons to isolate resources:

* Developer teams need to iterate safely. But development and testing of apps that write to Microsoft Entra ID can affect the Microsoft Entra tenant through write operations:
  * New applications that can change Office 365 content such as SharePoint sites, OneDrive, Microsoft Teams, and so on
  * Custom applications that can change user data with MS Graph or similar APIs at scale. For example, applications granted Directory.ReadWrite.All.
  * DevOps scripts that update large sets of objects
  * Developers of Microsoft Entra integrated apps need to create user objects for testing. The user objects don't have access to production resources.
* Nonproduction Azure resources and applications that can affect other resources. For example, a new SaaS app needs isolation from the production instance and user objects
* Secret resources to be shielded from discovery, enumeration, or takeover by administrators

## Configuration in a tenant

Configuration settings in Microsoft Entra ID can affect resources in the Microsoft Entra tenant through targeted, or tenant-wide management actions:

* **External identities**: Administrators identify and control external identities to be provisioned in the tenant
  * Whether to allow external identities in the tenant
  * From which domain(s) external identities are added
  * Whether users can invite users from other tenants
* **Named locations**: Administrators create named locations to:
  * Block sign-in from locations
  * Trigger Conditional Access policies such as multifactor authentication
  * Bypass security requirements
* **Self-service options**: Administrators set self-service-password reset and create Microsoft 365 groups at the tenant level

Some tenant-wide configurations can be scoped if they're not overridden by global policies:

* The tenant is configured to allow external identities. A resource administrator can exclude those identities from access.
* The tenant is configured to allow personal device registration. A resource administrator can exclude devices from access.
* There are configured named locations. A resource administrator can configure policies to allow or exclude access.

### Common reasons for configuration isolation

Configurations controlled by administrators affect resources. While some tenant-wide configuration can be scoped with policies that don't apply or partially apply to a resource, others can't. If a resource has unique configuration, isolate it in a separate tenant. Examples include:

* Resources with requirements that conflict with tenant-wide security or collaboration postures
  * For example allowed authentication types, device management policies, self-service, identity proofing for external identities, etc.
* Compliance requirements that scope certification to the entire environment
  * This action includes all resources and the Microsoft Entra tenant, especially when requirements conflict with, or exclude, other organizational resources
* External user access requirements that conflict with production or sensitive resource policies
* Organizations that span multiple countries or regions, and companies hosted in a Microsoft Entra tenant.
  * For example, settings and licenses used in countries, regions, or business subsidiaries

## Tenant administration

Identities with privileged roles in the Microsoft Entra tenant have the visibility and permissions to execute the configuration tasks described in the previous sections. Administration includes both the administration of identity objects such as users, groups, and devices, and the scoped implementation of tenant-wide configurations for authentication, authorization, and so on.

### Administration of directory objects

Administrators manage how identity objects can access resources, and under what circumstances. They also can disable, delete, or modify directory objects based on their privileges. Identity objects include:

* **Organizational identities**, such as the following, are represented by user objects:
  * Administrators
  * Organizational users
  * Organizational developers
  * Service Accounts
  * Test users
* **External identities** represent users from outside the organization such as:
  * Partners, suppliers, or vendors that are provisioned with accounts local to the organization environment
  * Partners, suppliers, or vendors that are provisioned via Azure B2B collaboration
* **Groups** are represented by objects such as:
  * Security groups
  * [Microsoft 365 groups](/microsoft-365/community/all-about-groups)
  * Dynamic Groups
  * Administrative Units
* **Devices** are represented by objects such as:
  * Microsoft Entra hybrid joined devices (On-premises computers synchronized from on-premises Active Directory)
  * Microsoft Entra joined devices
  * Microsoft Entra registered mobile devices used by employees to access their workplace applications.
  * Microsoft Entra registered down-level devices (legacy). For example, Windows 2012 R2.
* **Workload Identities**
  * Managed identities
  * Service Principals
  * Applications

In a hybrid environment, identities are typically synchronized from the on-premises Active Directory environment using [Microsoft Entra Connect](~/identity/hybrid/connect/whatis-azure-ad-connect.md).

### Administration of identity services

Administrators with appropriate permissions can also manage how tenant-wide policies are implemented at the level of resource groups, security groups, or applications. When considering administration of resources, keep the following in mind. Each can be a reason to keep resources together, or to isolate them.

* A **Global Administrator** can take control of any Azure subscription linked to the Tenant.

* An **identity assigned an Authentication Administrator role** can require nonadministrators to reregister for MFA or FIDO authentication.

* A **Conditional Access Administrator** can create Conditional Access policies that require users signing-in to specific apps to do so only from organization-owned devices. They can also scope configurations. For example, even if external identities are allowed in the tenant, they can exclude those identities from accessing a resource.

* A **Cloud Application Administrator** can consent to application permissions on behalf of all users.

### Common reasons for administrative isolation

Who should have the ability to administer the environment and its resources? There are times when administrators of one environment must not have access to another environment. Examples include:

* Separation of tenant-wide administrative responsibilities to further mitigate the risk of security and operational errors affecting critical resources.

* Regulations that constrain who can administer the environment based on conditions such as citizenship, residency, clearance level, and so on. that can't be accommodated with staff.

## Security and operational considerations

Given the interdependence between a Microsoft Entra tenant and its resources, it's critical to understand the security and operational risks of compromise or error. If you're operating in a federated environment with synchronized accounts, an on-premises compromise can lead to a Microsoft Entra ID compromise.

* **Identity compromise** - Within the boundary of a tenant, any identity can be assigned any role, given the one providing access has sufficient privileges. While the effect of compromised non-privileged identities is largely contained, compromised administrators can have broad implications. For example, if a Microsoft Entra Global Administrator account is compromised, Azure resources can become compromised. To mitigate risk of identity compromise, or bad actors, implement [tiered administration](/security/privileged-access-workstations/privileged-access-access-model) and ensure that you follow principles of least privilege for [Microsoft Entra Administrator Roles](../identity/role-based-access-control/delegate-by-task.md). Similarly, ensure that you create Conditional Access policies that specifically exclude test accounts and test service principals from accessing resources outside of the test applications. For more information on privileged access strategy, see [Privileged access: Strategy](/security/privileged-access-workstations/privileged-access-strategy).

* **Federated environment compromise**

* **Trusting resource compromise** - Human identities aren't the only security consideration. Any compromised component of the Microsoft Entra tenant can affect trusting resources based on its level of permissions at the tenant and resource level. The effect of a compromised component of a Microsoft Entra ID trusting resource is determined by the privileges of the resource; resources that are deeply integrated with the directory to perform write operations can have profound impact in the entire tenant. Following [guidance for zero trust](/azure/architecture/guide/security/conditional-access-zero-trust) can help limit the impact of compromise.

* **Application development** - Early stages of the development lifecycle for applications with writing privileges to Microsoft Entra ID, where bugs can unintentionally write changes to the Microsoft Entra objects, present a risk. Follow [Microsoft identity platform best practices](~/identity-platform/identity-platform-integration-checklist.md) during development to mitigate these risks.

* **Operational error** - A security incident can occur not only due to bad actors, but also because of an operational error by tenant administrators or the resource owners. These risks occur in any architecture. Mitigate these risks with separation of duties, tiered administration, following principles of least privilege, and following best practices before trying to mitigate by using a separate tenant.

Incorporating zero-trust principles into your Microsoft Entra ID design strategy can help guide your design to mitigate these considerations. For more information, visit [Embrace proactive security with Zero Trust](https://www.microsoft.com/security/business/zero-trust).

## Next steps

* [Microsoft Entra fundamentals](./secure-fundamentals.md)

* [Azure resource management fundamentals](secure-resource-management.md)

* [Resource isolation in a single tenant](secure-single-tenant.md)

* [Resource isolation with multiple tenants](secure-multiple-tenants.md)

* [Best practices](secure-best-practices.md)

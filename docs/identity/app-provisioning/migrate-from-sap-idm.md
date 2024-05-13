---
title: Migrate identity management scenarios from SAP IDM to Microsoft Entra
description: Learn the detailed steps for how to bring identities from SAP SuccessFactors and other sources into Microsoft Entra ID and provision those identities with access to SAP ECC, SAP S/4HANA, and other SAP and non-SAP applications, for organizations that were previously using SAP IDM.
author: markwahl-msft
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 05/06/2024
ms.author: mwahl
ms.reviewer: mwahl
---

# Migrate identity management scenarios from SAP IDM to Microsoft Entra

In addition to its business applications, SAP offers a range of identity and access management technologies, including [SAP Cloud Identity Services](https://pages.community.sap.com/topics/cloud-identity-services) and [SAP Identity Management](https://pages.community.sap.com/topics/identity-management) to help their customers maintain the identities in their SAP applications. SAP IDM, which organizations deploy on-premises, historically provided identity and access management for SAP R/3 deployments. SAP will [end maintenance for SAP Identity Management](https://community.sap.com/t5/technology-blogs-by-sap/preparing-for-sap-identity-management-s-end-of-maintenance-in-2027/ba-p/13596101). For those organizations that were using SAP Identity Management, [Microsoft and SAP are collaborating](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/microsoft-and-sap-collaborate-to-modernize-identity-for-sap/ba-p/4056600) to develop guidance for those organizations to migrate their identity management scenarios from SAP Identity Management to Microsoft Entra.

Identity modernization is a critical and essential step towards improving an organization’s security posture and protecting their users and resources from identity threats. It is a strategic investment that can deliver substantial benefits beyond a stronger security posture, like improving user experience and optimizing operational efficiency. Many organizations have expressed interest in moving the center of their identity and access management scenarios entirely to the cloud. Some organizations will no longer have an on-premises environment, while others integrate the cloud-hosted identity and access management with their remaining on-premises applications, directories and databases. For more information on cloud transformation for identity services, see [cloud transformation posture](~/architecture/road-to-the-cloud-posture.md) and [transition to the cloud](~/architecture/road-to-the-cloud-migrate.md).

Microsoft Entra offers a universal cloud-hosted identity platform that provides your people, partners, and customers with a single identity to access cloud and on-premises applications, and collaborate from any platform and device. This document provides guidance on migration options and approaches for moving Identity and Access Management (IAM) scenarios from SAP Identity Management to Microsoft Entra cloud-hosted services, and will be updated as new scenarios become available to migrate.

## Overview of Microsoft Entra and its SAP product integrations

Microsoft Entra is a family of products including Microsoft Entra ID (formerly Azure Active Directory) and Microsoft Entra ID Governance. [Microsoft Entra ID](/entra/fundamentals/whatis) is a cloud-based identity and access management service that employees and guests can use to access resources. It provides strong authentication and secure adaptive access, and integrates with both on-premises legacy apps and thousands of software-as-a-service (SaaS) application, delivering a seamless end-user experience. [Microsoft Entra ID Governance](~/id-governance/identity-governance-overview.md) offers additional capabilities to automatically establish user identities in the apps users need to access, and update and remove user identities as job status or roles change.

Microsoft Entra provides user interfaces, including the Microsoft Entra Admin Center, the myapps and myaccess portals, and provides a REST API for identity management operations and delegated end user self-service. Microsoft Entra ID includes integrations for SuccessFactors, SAP ECC, and through the SAP Cloud Identity Services, can provide provisioning and single sign-on to S/4HANA and many other SAP applications. For more information on these integrations, see [Manage access to your SAP applications](~/id-governance/sap.md). Microsoft Entra also implements standard protocols such as SAML, SCIM, SOAP, and OpenID Connect to directly integrate with many more applications for single sign-on and provisioning. Microsoft Entra also has agents, including [Microsoft Entra Connect cloud sync](~/identity/hybrid/cloud-sync/what-is-cloud-sync.md) and a [provisioning agent](~/identity/hybrid/cloud-sync/what-is-provisioning-agent.md) to connect Microsoft Entra cloud services with an organization's on-premises applications, directories, and databases.

The following diagram illustrates an example topology for user provisioning and single sign-on. In this topology, workers are represented in SuccessFactors, and need to have accounts in a Windows Server Active Directory domain, in Microsoft Entra, SAP ECC, and SAP cloud applications. This example illustrates an organization that has a Windows Server AD domain; however, Windows Server AD is not required.

:::image type="content" source="media/plan-sap-user-source-and-target/end-to-end-integrations.png" alt-text="Diagram showing end-to-end breadth of relevant Microsoft and SAP technologies and their integrations." lightbox="media/plan-sap-user-source-and-target/end-to-end-integrations.png":::

Microsoft and SAP are continuing to evolve their evolution to support integrations with [SAP Cloud Identity Services](https://pages.community.sap.com/topics/cloud-identity-services) and more scenarios.

## Planning a migration of identity management scenarios to Microsoft Entra

Since the introduction of SAP IDM, the identity and access management landscape has evolved with new applications and new business priorities, and so the approaches recommended for addressing IAM use cases will in many cases be different today than those organizations previously implemented for SAP IDM. Therefore, organizations should plan a staged approach for scenario migration. For example, one organization may prioritize migrating an end-user self-service password reset scenario as one step, and then once that is complete, moving a provisioning scenario. For another example, organization may choose to first deploy Microsoft Entra features in a separate staging tenant, operated in parallel with the existing identity management system and the production tenant, and then bring configurations for scenarios one-by-one from the staging tenant to the production tenant and decommission that scenario from the existing identity management system. The order in which an organization chooses to move their scenarios will depend upon their overall IT priorities and the impact on other stakeholders, such as end users needing a training update, or application owners. Organizations may also structure IAM scenario migration alongside other IT modernization, such as moving other scenarios outside of identity management from on-premises SAP technology to SuccessFactors, S/4HANA, or other cloud services. You may also wish to use this opportunity to clean up and remove outdated integrations, access rights or roles, and consolidate where necessary.

To begin migration planning,

 * Identify current and planned IAM use cases in your IAM modernization strategy.
 * Analyze the requirements of those use cases and match those requirements to the capabilities of Microsoft Entra services.
 * Determine timeframes and stakeholders for implementation of new Microsoft Entra capabilities to support migration.
 * Determine the cutover process for your applications to move the single sign-on, identity and access lifecycle controls to Microsoft Entra.

As a SAP IDM migration will likely involve integrations with existing SAP applications, review the [integrations with SAP sources and targets](plan-sap-user-source-and-target.md#plan-the-integrations-with-sap-sources-and-targets) and the guidance for how to [determine the sequence of application onboarding and how applications will integrate with Microsoft Entra](plan-sap-user-source-and-target.md#determine-the-sequence-of-application-onboarding-and-how-applications-will-integrate-with-microsoft-entra).

Partners can also help your organization with planning and deployment. Customers can engage partners listed in the Microsoft Solution Partner finder or can choose from the [services and integration partners](~/id-governance/services-and-integration-partners.md).

## Migration guidance by scenario

The following sections provide links to additional content on how to migrate each SAP IDM scenario to Microsoft Entra. Not all the sections may be relevant to each organization, depending upon the SAP IDM scenarios an organization has deployed.

Be sure to monitor this article, the Microsoft Entra product documentation, and corresponding SAP product documentation, for updates, as capabilities of both products continue to evolve to unblock more migration and net new scenarios, including Microsoft Entra integrations with SAP Access Control (SAP AC) and SAP Cloud Identity Access Governance (SAP IAG).

### Migrate an Identity Store to a Microsoft Entra ID tenant

In SAP IDM, an Identity Store is a repository of identity information, including users, groups, and their audit trail. In Microsoft Entra, a *tenant* is an instance of Microsoft Entra ID in which information about a single organization resides including organizational objects such as users, groups, and devices. A tenant also contains access and compliance policies for resources, such as applications registered in the directory. The primary functions served by a tenant include identity authentication as well as resource access management. Tenants contain privileged organizational data and are securely isolated from other tenants. In addition, tenants can be configured to have data persisted and processed in a specific region or cloud, which enables organizations to use tenants as a mechanism to meet data residency and handling compliance requirements.

Organizations that have Microsoft 365, Microsoft Azure, or other Microsoft Online Services will already have a Microsoft Entra ID tenant that underlies those services. In addition, an organization may have additional tenants, such as a tenant that has specific applications and that has been [configured to meet standards](/entra/standards) such as [PCI-DSS](~/standards/pci-dss-guidance.md) applicable to those applications. For more information on determining whether an existing tenant is suitable, see [resource isolation with multiple tenants](~/architecture/secure-multiple-tenants.md). If your organization does not have yet a tenant, review the [Microsoft Entra deployment plans](~/architecture/deployment-plans.md).

Before migrating scenarios to a Microsoft Entra tenant, you should:

* [Define the organization's policy with user prerequisites and other constraints for access to an application](plan-sap-user-source-and-target.md#define-the-organizations-policy-with-user-prerequisites-and-other-constraints-for-access-to-an-application)
* [Decide on the provisioning and authentication topology](plan-sap-user-source-and-target.md#decide-on-the-provisioning-and-authentication-topology). Similar to SAP IDM [identity lifecycle management](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/687dff86043f49e2982ba7942808e0f6.html), a single Microsoft Entra ID tenant can connect to multiple cloud and on-premises applications for provisioning and single sign-on.
* [Ensure organizational prerequisites are met in that tenant](plan-sap-user-source-and-target.md#ensure-organizational-prerequisites-are-met-before-configuring-microsoft-entra-id)

Once you have a tenant configured, then depending upon your [Microsoft Entra license](~/id-governance/licensing-fundamentals.md#features-by-license) in that tenant, you can use that tenant for:

* [user management](#migrate-user-management-scenarios) including end user self-service
* [user authentication](#migrate-authentication-and-single-sign-on) and single sign-on to applications
* group management
* integration with Windows Server AD
* [inbound provisioning](#integrate-with-sap-hr-sources) from system of record data sources
* outbound provisioning to [SAP](#provision-for-sap-systems) and [non-SAP](#provision-for-non-sap-systems) targets
* identity governance for [access lifecycle management](#migrate-access-lifecycle-management)
* [reporting](#use-microsoft-entra-for-reporting)

### Migrate existing IAM data into Microsoft Entra ID tenant

In SAP IDM, the Identity Store represents identity data through entry types such as `MX_PERSON`, `MX_ROLE`, or `MX_PRIVILEGE`.

* A person is represented in a Microsoft Entra ID tenant as a [User](~/fundamentals/how-to-create-delete-users.yml). If you have existing users who are not yet in Microsoft Entra ID, you can [extend the Microsoft Entra user schema with any additional attributes](~/identity/app-provisioning/plan-sap-user-source-and-target.md#update-the-microsoft-entra-id-user-schema), [bulk create users in Microsoft Entra ID](~/identity/users/users-bulk-add.md) from a CSV file, and then [issue credentials to those new users](~/identity/app-provisioning/plan-sap-user-source-and-target.md#distribute-credentials-to-newly-created-microsoft-entra-users-or-windows-server-ad-users) so they can authenticate to Microsoft Entra ID.

* A business role can be represented in Microsoft Entra ID Governance as an [Entitlement Management access package](~/id-governance/entitlement-management-access-package-create.md). You can [govern access to applications by migrating an organizational role model to Microsoft Entra ID Governance](~/id-governance/identity-governance-organizational-roles.md), which results in an access package for each business role.

* A privilege or technical role in target system could be represented in Microsoft Entra as either an app role or as a security group, depending upon the target system's requirements for how it uses Microsoft Entra ID data for authorization. For more information, see [integrating applications with Microsoft Entra ID and establishing a baseline of reviewed access](~/id-governance/identity-governance-applications-integrate.md).

* In Microsoft Entra, you can automatically maintain collections of users, such as everyone with a particular value of a cost center attribute, using either [Microsoft Entra ID dynamic group](~/identity/users/groups-create-rule.md) or Microsoft Entra ID Governance entitlement management with [access package automatic assignment policies](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md). You can use PowerShell cmdlets to create dynamic groups or create [automatic assignment policies](~/id-governance/entitlement-management-access-package-create-app.md#add-a-policy-to-the-access-packages-for-auto-assignment) in bulk.

### Migrate user management scenarios

Through the Microsoft Entra Admin Center, Microsoft Graph API and PowerShell, administrators can easily perform day-to-day identity management tasks, including creating a user, blocking a user from sign in, adding a user to a group, or deleting a user.

To enable operation at scale, Microsoft Entra enables organizations to automate their identity lifecycle processes.

![Diagram of the Microsoft Entra relationship in provisioning with other sources and targets.](~/id-governance/media/what-is-identity-lifecycle-management/cloud-1-id-governance.png)

In Microsoft Entra ID and Microsoft Entra ID Governance, you can automate identity lifecycle processes using:

- [Inbound provisioning from your organization's HR sources](~/identity/app-provisioning/plan-cloud-hr-provision.md), retrieves worker information from Workday and SuccessFactors, to automatically maintain user identities in both Active Directory and Microsoft Entra ID.
- Users already present in Active Directory can be automatically created and maintained in Microsoft Entra ID using [inter-directory provisioning](~/identity/hybrid/what-is-inter-directory-provisioning.md).
- Microsoft Entra ID Governance [lifecycle workflows](~/id-governance/what-are-lifecycle-workflows.md) automate workflow tasks that run at certain key events, such before a new employee is scheduled to start work at the organization, as they change status during their time in the organization, and as they leave the organization. For example, a workflow can be configured to send an email with a temporary access pass to a new user's manager, or a welcome email to the user, on their first day.
- [Automatic assignment policies in entitlement management](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md) to add and remove a user's group memberships, application roles, and SharePoint site roles, based on changes to the user's attributes. Users can also upon request, be assigned to groups, Teams, Microsoft Entra roles, Azure resource roles, and SharePoint Online sites, using [entitlement management](~/id-governance/entitlement-management-scenarios.md) and [Privileged Identity Management](~/id-governance/privileged-identity-management/pim-configure.md), as shown in the [access lifecycle management](#migrate-access-lifecycle-management).
- Once the users are in Microsoft Entra ID with the correct group memberships and app role assignments, [user provisioning](~/id-governance/what-is-provisioning.md) can create, update, and remove user accounts in other applications, with connectors to hundreds of cloud and on-premises applications via SCIM, LDAP and SQL.
- For guest lifecycle, you can specify in [entitlement management](~/id-governance/entitlement-management-overview.md) the other organizations whose users are allowed to request access to your organization's resources. When one of those users's request is approved, they are automatically added by entitlement management as a [B2B](~/external-id/what-is-b2b.md) guest to your organization's directory, and assigned appropriate access. And entitlement management automatically removes the B2B guest user from your organization's directory when their access rights expire or are revoked.
- [Access reviews](~/id-governance/access-reviews-overview.md) automates recurring reviews of existing guests already in your organization's directory, and removes those users from your organization's directory when they no longer need access.

### Integrate with SAP HR sources

Organizations that have SAP SuccessFactors could use SAP IDM to [bring in employee data](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/4c54e007ab414f7da3854952cad00221.html) from SAP SUccessFactors. Those organizations with SAP SuccessFactors can easily migrate to bring identities for employees [from SuccessFactors into Microsoft Entra ID](~/identity/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md) or [from SuccessFactors into on-premises Active Directory](~/identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md), by using Microsoft Entra ID connectors. The connectors support the following scenarios:

* **Hiring new employees**: When a new employee is added to SuccessFactors, a user account is automatically created in Microsoft Entra ID and optionally Microsoft 365 and [other software as a service (SaaS) applications that Microsoft Entra ID supports](~/identity/app-provisioning/user-provisioning.md). This process includes write-back of the email address to SuccessFactors.
* **Employee attribute and profile updates**: When an employee record is updated in SuccessFactors (such as name, title, or manager), the employee's user account is automatically updated in Microsoft Entra ID and optionally Microsoft 365 and other SaaS applications that Microsoft Entra ID supports.
* **Employee terminations**: When an employee is terminated in SuccessFactors, the employee's user account is automatically disabled in Microsoft Entra ID and optionally Microsoft 365 and other SaaS applications that Microsoft Entra ID supports.
* **Employee rehires**: When an employee is rehired in SuccessFactors, the employee's old account can be automatically reactivated or reprovisioned (depending on your preference) to Microsoft Entra ID and optionally Microsoft 365 and other SaaS applications that Microsoft Entra ID supports.

You can also [write back from Microsoft Entra ID to SAP SuccessFactors](~/identity/saas-apps/sap-successfactors-writeback-tutorial.md).

  :::image type="content" source="media/plan-sap-user-source-and-target/inbound-data-preparation.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to bringing in data about workers to Microsoft Entra ID." lightbox="media/plan-sap-user-source-and-target/inbound-data-preparation.png":::

For step-by-step guidance on the identity lifecycle with SAP SuccessFactors as a source, including setting up new users with appropriate credentials in Windows Server AD or Microsoft Entra ID, see [Plan deploying Microsoft Entra for user provisioning with SAP source and target applications](plan-sap-user-source-and-target.md).

Some organizations also used SAP IDM to read from [SAP Human Capital Management (HCM)](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/490d22699aff42519eb6b328c7f44e24.html). Organizations who still use SAP Human Capital Management (HCM) can also bring identities into Microsoft Entra ID. By using SAP Integration Suite, you can synchronize lists of workers between SAP HCM and SAP SuccessFactors. From there, you can bring identities directly into Microsoft Entra ID or provision them into Active Directory Domain Services by using the native provisioning integrations mentioned earlier.

![Diagram of SAP HR integrations.](~/id-governance/media/sap/sap-hr.png)

If you have other systems of record sources besides SuccessFactors or SAP HCM, you can use the Microsoft Entra [inbound provisioning API](~/identity/app-provisioning/inbound-provisioning-api-concepts.md) to bring in workers from that system of record as users in Windows Server or Microsoft Entra ID.

  :::image type="content" source="media/inbound-provisioning-api-concepts/api-workflow-scenarios.png" alt-text="Diagram showing API workflow scenarios." lightbox="media/inbound-provisioning-api-concepts/api-workflow-scenarios.png":::

### Provision for SAP systems

Most organizations with SAP IDM will have been using it to provision users into SAP ECC, SAP IAS, SAP S/4HANA, or other SAP applications. Microsoft Entra has connectors to SAP ECC, SAP Cloud Identity Services, and SAP SuccessFactors. Provisioning into SAP S/4HANA or other applications is a two step process. Once you have users in Microsoft Entra ID, you can provision those users from Microsoft Entra ID to SAP Cloud Identity Services or SAP ECC, to enable them to sign in to SAP applications. SAP Cloud Identity Services then provisions the users originating from Microsoft Entra ID that are in the SAP Cloud Identity Directory into the downstream SAP applications, including [`SAP S/4HANA Cloud`](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-sap-s-4hana-cloud) and [`SAP S/4HANA On-premise`](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-sap-s-4hana-on-premise).

  :::image type="content" source="media/plan-sap-user-source-and-target/outbound-provisioning-and-sso.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to provisioning identities from Microsoft Entra ID." lightbox="media/plan-sap-user-source-and-target/outbound-provisioning-and-sso.png":::

To provision users into SAP applications integrated with SAP Cloud Identity Services, [confirm the SAP Cloud Identity Services have the necessary schema mappings for those applications](plan-sap-user-source-and-target.md#confirm-the-sap-cloud-identity-services-have-the-necessary-schema-mappings-for-your-applications), and [provision the users from Microsoft Entra ID to SAP Cloud Identity Services](plan-sap-user-source-and-target.md#provision-users-to-sap-cloud-identity-services). SAP Cloud Identity Services will then provision users into the downstream SAP applications as necessary. You can then use HR inbound from SuccessFactors to keep the list of users in Microsoft Entra ID up to date as employees join, move, and leave. If you have Microsoft Entra ID Governance, you can also [automate changes to the application role assignments](plan-sap-user-source-and-target.md#assign-users-the-necessary-application-access-rights-in-microsoft-entra) in Microsoft Entra ID for SAP Cloud Identity Services.

To provision users into SAP ECC, [confirm that necessary BAPIs for SAP ECC are ready](plan-sap-user-source-and-target.md#confirm-that-necessary-bapis-for-sap-ecc-are-ready-for-use-by-microsoft-entra) for Microsoft Entra to use for identity management, then [provision the users from Microsoft Entra ID to SAP ECC](plan-sap-user-source-and-target.md#provision-users-to-sap-ecc).

For step-by-step guidance on the identity lifecycle with SAP applications as the target, see [Plan deploying Microsoft Entra for user provisioning with SAP source and target applications](plan-sap-user-source-and-target.md).

Once you have configured provisioning for users into your SAP applications, you should enable SSO for them. Microsoft Entra ID can serve as the identity provider and authentication authority for your SAP applications. Microsoft Entra ID can integrate with [SAP NetWeaver using SAML or OAuth](~/identity/saas-apps/sap-netweaver-tutorial.md). For more information on how to configure single sign-on to SAP SaaS and modern apps, see [enable SSO](~/id-governance/sap.md#enable-sso).

### Provision for non-SAP systems

Organizations may also be using SAP IDM to provision users to [non-SAP systems](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/2f8af286449c4453a8514ba598938581.html), including Windows Server AD, and other databases, directories, and applications. You can migrate these scenarios to Microsoft Entra ID to have Microsoft Entra ID provision its copy of those users into those repositories.

For organizations with Windows Server AD, the organization may have been using Windows Server AD as a [source for users and groups](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/a42a2432a1a143ceb1d5f3809bf1e82f.html) for SAP IDM to bring into SAP R/3. You can use [Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync](~/identity/hybrid/common-scenarios.md#supported-sync-scenarios) to bring users and groups from Windows Server AD into Microsoft Entra ID. In addition, Microsoft Entra SuccessFactors inbound can be used to [automatically create and update users in Windows Server AD](~/identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md), and you can [manage the memberships of groups in AD](~/id-governance/entitlement-management-group-writeback.md) used by AD-based applications. Exchange Online mailboxes can be created automatically for users via a license assignment, using [group-based licensing](~/fundamentals/concept-group-based-licensing.md).

For organizations with applications relying on other directories, you can configure [Microsoft Entra ID to provision users into LDAP directories](~/identity/app-provisioning/on-premises-ldap-connector-configure.md), including OpenLDAP, Microsoft Active Directory Lightweight Directory Services, 389 Directory Server, Apache Directory Server, IBM Tivoli DS, Isode Directory, NetIQ eDirectory, Novell eDirectory, Open DJ, Open DS, Oracle (previously Sun ONE) Directory Server Enterprise Edition, and RadiantOne Virtual Directory Server (VDS).

For organizations with applications relying upon a SQL database, you can configure [Microsoft Entra ID to provision users into a SQL database](~/identity/app-provisioning/on-premises-sql-connector-configure.md) via the database's ODBC driver. Supported databases include Microsoft SQL Server, Azure SQL, IBM DB2 9.x, IBM DB2 10.x, IBM DB2 11.5, Oracle 10g and 11g, Oracle 12c and 18c, MySQL 5.x, MySQL 8.x, and Postgres. For SAP HANA, see SAP Cloud Identity Services [SAP HANA Database Connector (beta)](https://help.sap.com/docs/identity-provisioning/identity-provisioning/sap-hana-database-beta).

If there are existing users in a non-AD directory or database which were provisioned by SAP IDM and are not already in Microsoft Entra ID and cannot be correlated to a worker in SAP SuccessFactors or other HR source, see [govern an application's existing users](~/id-governance/identity-governance-applications-existing-users.md) for guidance on how to bring those users into Microsoft Entra ID.

Microsoft Entra has built-in provisioning integrations with hundreds of SaaS applications; for a complete list of applications which support provisioning see [Microsoft Entra ID Governance integrations](~/id-governance/apps.md). Microsoft partners also deliver [partner-driven integrations](~/identity/app-provisioning/partner-driven-integrations.md) with additional specialized applications.

For other in-house developed applications, Microsoft Entra can provision to cloud applications via [SCIM](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md), and to on-premises applications via [SCIM](~/identity/app-provisioning/on-premises-scim-provisioning.md), [SOAP or REST](~/identity/app-provisioning/on-premises-web-services-connector.md), [PowerShell](~/identity/app-provisioning/on-premises-powershell-connector.md), or partner-delivered connectors that implement the [ECMA API](~/identity/app-provisioning/on-premises-custom-connector.md). If you had previously been using SPML for provisioning from SAP IDM, we recommend updating applications to support the newer SCIM protocol.

For applications with no provisioning interface, consider using the the Microsoft Entra ID Governance feature to [automate ServiceNow ticket creation](~/id-governance/entitlement-management-ticketed-provisioning.md) to assign a ticket to an application owner when a user is assigned or loses access to an access package.

### Migrate authentication and single sign-on

Microsoft Entra ID acts as a security token service, enabling users to [authenticate to Microsoft Entra ID](~/identity/authentication/overview-authentication.md) with multi-factor and passwordless authentication, and then have single sign-on to all their applications. Microsoft Entra ID single sign-on uses standard protocols including [SAML](~/identity/enterprise-apps/add-application-portal-setup-sso.md), [OpenID Connect](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) and [Kerberos](~/identity/app-proxy/how-to-configure-sso.md). For more information on single sign-on to SAP cloud applications, see [Microsoft Entra single sign-on integration with SAP Cloud Identity Services](~/identity/saas-apps/sap-hana-cloud-platform-identity-authentication-tutorial.md).

Organizations that have an existing identity provider, such as Windows Server AD, for their users can configure hybrid identity authentication, so that Microsoft Entra ID relies upon an existing identity provider. For more information on integration patterns, see [choose the right authentication method for your Microsoft Entra hybrid identity solution](~/identity/hybrid/connect/choose-ad-authn.md).

### Migrate end user self-service

Organizations may have used SAP IDM [Logon Help](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/d0faf50c76ef43f8808165ad855bc8c6.html) to enable their end users to reset their Windows Server AD password.

Microsoft Entra self-service password reset (SSPR) gives users the ability to change or reset their password, without needing administrator or help desk involvement. Once you have configured Microsoft Entra SSPR, you can [require users to register when they sign in](~/identity/authentication/concept-sspr-howitworks.md#require-users-to-register-when-they-sign-in). Then, if a user's account is locked or they forget their password, they can follow prompts to unblock themselves and get back to work. When users change or reset their passwords using SSPR in the cloud, the updated passwords can also be written back to an on-premises AD DS environment. For more information on how SSPR works, see [Microsoft Entra self-service password reset](~/identity/authentication/concept-sspr-howitworks.md).

Microsoft Entra also supports end user self-service for [group management](~/identity/users/groups-self-service-management.md), and self-service access requests, approval, and reviews. For more information on self-service access management through Microsoft Entra ID Governance, see the following section on [access lifecycle management](#migrate-access-lifecycle-management).

### Migrate access lifecycle management

Microsoft Entra includes multiple access lifecycle management technologies to enable organizations to bring their identity and access management scenarios to the cloud. The choice of technologies depends upon your organization's application requirements and Microsoft Entra licenses.

* **Access management through Entra ID security group management.** Traditional Windows Server AD-based applications leveraged security groups for authorization. Microsoft Entra makes group memberships available to applications via SAML claims, provisioning, or by [writing groups to Windows Server AD](~/identity/users/groups-write-back-portal.md). Administrators can [manage group membership](~//identity/users/groups-bulk-import-members.md), create [access reviews of group memberships](~/id-governance/create-access-review.md) and enable [self-service group management](~/identity/users/groups-self-service-management.md) so that the group owners can approve or deny membership requests and delegate control of group membership. You can also use Privileged Identity Management (PIM) [for groups](~/id-governance/privileged-identity-management/groups-discover-groups.md) to manage just-in-time membership in the group or just-in-time ownership of the group.

* **Access management through [Entitlement management](~/id-governance/entitlement-management-overview.md) access packages.**. Entitlement management is an identity governance feature that enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration. <!-- this section is a work in progress -->

### Use Microsoft Entra for reporting

Microsoft Entra includes built-in reports, as well as workbooks that surface in Azure Monitor based on audit, sign-in, and provisioning log data. The reporting options available in Microsoft Entra include:

* Microsoft Entra built-in reports in the admin center, including [usage and insights reports](~/identity/monitoring-health/concept-usage-insights-report.md?tabs=microsoft-entra-admin-center) for an application-centric view on sign-in data. You can use those reports to [monitor for unusual account creation and deletion, and unusual account usage](~/architecture/security-operations-user-accounts.md).
* You can export data from Microsoft Entra admin center for use in generating your own reports. For example, you can [download a list of users and their attributes](~/identity/users/users-bulk-download.md) or [download logs](~/identity/monitoring-health/howto-download-logs.md) from the Microsoft Entra Admin Center.
* You can query Microsoft Graph to obtain data for use in a report. For example, you can [retrieve a list of inactive user accounts in Microsoft Entra ID](~/identity/monitoring-health/howto-manage-inactive-user-accounts.md).
* You can use the PowerShell cmdlets atop Microsoft Graph APIs to export and restructure content suitable for reporting. For example, if you are using Microsoft Entra entitlement management access packages, you can retrieve [a list of assignments to an access package in PowerShell](~/id-governance/entitlement-management-access-package-assignments.md#view-assignments-with-powershell)
* You can use workbooks and custom queries and reports on audit, sign-in, and provisioning logs that have been sent to Azure Monitor. For example, you can [Archive logs and reporting on entitlement management in Azure Monitor](~/id-governance/entitlement-management-logs-and-reporting.md).

### Migrate exchanging identity information across organizational boundaries

Some organizations may be using SAP IDM [identity federation](https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/5674c5a6cf30402390df5abbfded5195.html) to exchange identity information about users across company boundaries.

Microsoft Entra includes capabilities for a [multitenant organization](~/identity/multi-tenant-organizations/overview.md), that more than one instance of Microsoft Entra ID, to bring together users from those tenants for application access or collaboration. The following diagram shows how you can use the multitenant organization cross-tenant synchronization feature to automatically enable users from one tenant to have access to applications in another tenant in your organization.

:::image type="content" source="~/identity/multi-tenant-organizations/media/cross-tenant-synchronization-overview/cross-tenant-synchronization-diagram.png" alt-text="Diagram that shows synchronization of users for multiple tenants." lightbox="~/identity/multi-tenant-organizations/media/cross-tenant-synchronization-overview/cross-tenant-synchronization-diagram.png":::

Microsoft Entra External ID includes [B2B collaboration capabilities](~/external-id/what-is-b2b.md) that allow your workforce to work securely with business partners and guests, and share your company's applications with them. Guest users sign in to your apps and services with their own work, school, or social identities. For partners that have their own Microsoft Entra ID tenant where their users authenticate, you can [configure cross-tenant access settings](~/external-id/cross-tenant-access-overview.md). And for those partners that have their own identity providers, you can configure [federation with SAML/WS-Fed identity providers for guest users](~/external-id/direct-federation.md). Microsoft Entra entitlement management enables you to govern the [identity and access lifecycle for those external users](~/id-governance/entitlement-management-external-users.md), by configuring access package with approvals before a guest can be brought into a tenant, and automatic removal of guests when they are denied ongoing access during an access review.

![Diagram showing the lifecycle of external users](~/id-governance/media/entitlement-management-external-users/external-users-lifecycle.png)

### Extend Microsoft Entra with additional integrations

Microsoft Entra includes multiple interfaces for integration and extension across the cloud services, including:

* [Microsoft Graph API](/graph/overview) for applications to query and update identity information, configuration and policies, and retrieve logs, status and reports
* Provisioning to applications via [SCIM](~/identity/app-provisioning/on-premises-scim-provisioning.md), [SOAP or REST](~/identity/app-provisioning/on-premises-web-services-connector.md), and [ECMA API](~/identity/app-provisioning/on-premises-custom-connector.md)
* the [inbound provisioning API](~/identity/app-provisioning/inbound-provisioning-api-configure-app.md) enables other system of record sources to supply user updates to Microsoft Entra iD
* callouts to custom Azure LogicApps from [entitlement management](~/id-governance/entitlement-management-logic-apps-integration.md) and [lifecycle workflows](~/id-governance/lifecycle-workflow-extensibility.md) allow customization of the user onboarding, offboarding, and access request and assignment policies

## Next steps

* [Plan deploying Microsoft Entra for user identity provisioning with SAP source and target applications](~/identity/app-provisioning/plan-sap-user-source-and-target.md)
* [Manage access to your SAP applications](~/id-governance/sap.md)
* [Migrating from ADFS](~/identity/enterprise-apps/migrate-ad-fs-application-howto.md)
* [Migrating from MIM](/microsoft-identity-manager/migrate-entra-id)

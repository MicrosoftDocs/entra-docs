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

SAP offer a range of identity and access management technologies, including [SAP Cloud Identity Services](https://pages.community.sap.com/topics/cloud-identity-services) and [SAP Identity Management](https://pages.community.sap.com/topics/identity-management), SAP IDM, which organizations deploy on-premises. SAP will [end maintenance for SAP Identity Management](https://community.sap.com/t5/technology-blogs-by-sap/preparing-for-sap-identity-management-s-end-of-maintenance-in-2027/ba-p/13596101). For those organizations that were using SAP Identity Management, [Microsoft and SAP are collaborating](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/microsoft-and-sap-collaborate-to-modernize-identity-for-sap/ba-p/4056600) to develop guidance for those organizations to migrate their identity management scenarios from SAP Identity Management to Microsoft Entra.

Identity modernization is a critical and essential step towards improving an organization’s security posture and protecting their users and resources from identity threats. It is a strategic investment that can deliver substantial benefits beyond a stronger security posture, like improving user experience and optimizing operational efficiency. Many customers have expressed interest in moving the center of their identity and access management scenarios entirely to the cloud. Some customers will no longer have an on-premises environment, while others integrate the cloud-hosted identity and access management with their remaining on-premises applications, directories and databases.

Microsoft Entra offers a universal cloud-hosted identity platform that provides your people, partners, and customers with a single identity to access cloud and on-premises applications, and collaborate from any platform and device. This document provides guidance on migration options and approaches for moving Identity and Access Management (IAM) scenarios from SAP Identity Management to Microsoft Entra cloud-hosted services, and will be updated as new scenarios become available to migrate.

## Overview of Microsoft Entra and its SAP product integrations

Microsoft Entra is a family of products including Microsoft Entra ID (formerly Azure Active Directory) and Microsoft Entra ID Governance. [Microsoft Entra ID](/entra/fundamentals/whatis) is a cloud-based identity and access management service that employees and guests can use to access resources. It provides strong authentication and secure adaptive access, and integrates with both on-premises legacy apps and thousands of software-as-a-service (SaaS) application, delivering a seamless end-user experience. [Microsoft Entra ID Governance](~/id-governance/identity-governance-overview.md) offers additional capabilities to automatically establish user identities in the apps users need to access, and update and remove user identities as job status or roles change.

Microsoft Entra provides user interfaces, including the Microsoft Entra Admin Center, the myapps and myaccess portals, and provides a REST API for identity management operations and delegated end user self-service. Microsoft Entra ID includes integrations for SuccessFactors, SAP ECC, and through the SAP Cloud Identity Services, S/4HANA and many other SAP applications. For more information on these integrations, see [Manage access to your SAP applications](~/id-governance/sap.md). Microsoft Entra also leverages standard protocols such as SAML, SCIM, SOAP and OpenID Connect to directly integrate with many more applications for single sign-on and provisioning. Microsoft Entra also has agents, including [Microsoft Entra Connect cloud sync](~/identity/hybrid/cloud-sync/what-is-cloud-sync.md) and a [provisioning agent](~/identity/hybrid/cloud-sync/what-is-provisioning-agent.md) to connect Microsoft Entra cloud services with an organization's on-premises applications, directories and databases.

The following diagram illustrates an example topology for user provisioning and single sign-on. In this topology, workers are represented in SuccessFactors, and need to have accounts in a Windows Server Active Directory domain, in Microsoft Entra, SAP ECC, and SAP cloud applications. This example illustrates an organization that has a Windows Server AD domain; however, Windows Server AD is not required.

:::image type="content" source="media/plan-sap-user-source-and-target/end-to-end-integrations.png" alt-text="Diagram showing end-to-end breadth of relevant Microsoft and SAP technologies and their integrations." lightbox="media/plan-sap-user-source-and-target/end-to-end-integrations.png":::

Microsoft and SAP are continuing to evolve their evolution to support integrations with [SAP Cloud Identity Services](https://pages.community.sap.com/topics/cloud-identity-services) and more scenarios.

## Planning a migration of identity management scenarios to Microsoft Entra

Since the introduction of SAP IDM, the identity and access management landscape has evolved with new applications and new business priorities, and so the approaches recommended for addressing IAM use cases will in many cases be different today than those organizations previously implemented for SAP IDM. Therefore, organizations should plan a staged approach for scenario migration. For example, one organization may prioritize migrating an end-user self-service password reset scenario as one step, and then once that is complete, moving a provisioning scenario. Organization may deploy Microsoft Entra features in a separate staging tenant, operated in parallel with the existing identity management system and the production tenant, and then bring scenarios from staging tenant one-by-one to the production tenant and decommission that scenario from the existing identity management system. The order in which an organization chooses to move their scenarios will depend upon their overall IT priorities and the impact on other stakeholders, such as end users needing a training update, or application owners.

 * Identify current and planned IAM use cases in your IAM modernization strategy
 * Analyze requirements of those use cases
 * Determine timeframes and stakeholders for implementation of new Microsoft Entra capabilities to support migration

You may also wish to use this opportunity to clean up and remove outdated integrations, access rights or roles, and consolidate where necessary.

<!-- Inventorying current and planned IAM use cases, and updating/modernizing IAM topology -->

<!-- Phased approach by scenario or use case, with key considerations and best practices to avoid business disruption, also how it relates to other migrations an organization might be doing (e.g., R/3->S/4HANA, or SAP HCM to SuccessFactors) -->

<!-- SAP IDM: determine the system landscape, set up the landscape for the use case, set up end user interfaces and reporting >

<!-- 

link to ## Plan the integrations with SAP sources and targets
link to ### Determine the sequence of application onboarding and how applications will integrate with Microsoft Entra
-->

<!-- Process for engaging with trained partners -->

<!-- Timelines and recommendations. -->

## Migration guidance

The following sections provide links to additional content specific to the SAP IDM scenarios an organization has deployed.

### Before you migrate

<!-- Concept: Identity Store ==> tenant -->

<!-- 
link to ### Define the organization's policy with user prerequisites and other constraints for access to an application
link to ### Decide on the provisioning and authentication topology
link to ### Ensure organizational prerequisites are met before configuring Microsoft Entra ID

-->

<!-- 
### Confirm the SAP Cloud Identity Services have the necessary schema mappings for your applications
-->

<!--
### Confirm that necessary BAPIs for SAP ECC are ready for use by Microsoft Entra
### Document the end to end attribute flow and transformations
### Prepare to issue new authentication credentials
## Deploy Microsoft Entra integrations
### Update the Windows Server AD user schema
### Update the Microsoft Entra ID user schema
### Ensure users in Microsoft Entra ID can be correlated with worker records in the HR source
### Set up the prerequisites for identity governance features

-->

<!-- 

### Connect users in Microsoft Entra ID to worker records from the HR source
### Provision users and their access rights to applications and enable them to sign in to those applications
### Provision users to SAP Cloud Identity Services
### Provision users to SAP ECC
### Configure provisioning to SuccessFactors and other applications
### Assign users the necessary application access rights in Microsoft Entra
### Distribute credentials to newly created Microsoft Entra users or Windows Server AD users

-->

### Bring existing data into Microsoft Entra ID


|Type|Microsoft Entra type|Learn more|
|:---|:--|:--|
|Person|User|A|
|Business role|||
|Privilege or technical role in target system|||

|Dynamic group|||

<!-- bulk create users -->
<!-- bulk create business roles and privileges -->
<!-- MX_PERSON, MX_ROLE, MX_PRIVILEGE -->

### Integration with SAP HR sources

<!-- successfactors connector -->

<!-- TC1.17 read data -->
<!-- TC1.26 SAP HCM/SAP SFSF integration -->

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/490d22699aff42519eb6b328c7f44e24.html -->

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/4c54e007ab414f7da3854952cad00221.html SuccessFactors employee central -->

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/40de7837e67f40eeae9f852278520771.html SAP HCM integration -->

Bring the users into Microsoft Entra ID from an authoritative source system.
  :::image type="content" source="media/plan-sap-user-source-and-target/inbound-data-preparation.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to bringing in data about workers to Microsoft Entra ID." lightbox="media/plan-sap-user-source-and-target/inbound-data-preparation.png":::


<!-- Generate a custom username -->

<!-- 

Customers who use SAP SuccessFactors can easily bring identities [from SuccessFactors into Microsoft Entra ID](../identity/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md) or [from SuccessFactors into on-premises Active Directory](../identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md) by using native connectors. The connectors support the following scenarios:

* **Hiring new employees**: When a new employee is added to SuccessFactors, a user account is automatically created in Microsoft Entra ID and optionally Microsoft 365 and [other software as a service (SaaS) applications that Microsoft Entra ID supports](../identity/app-provisioning/user-provisioning.md). This process includes write-back of the email address to SuccessFactors.
* **Employee attribute and profile updates**: When an employee record is updated in SuccessFactors (such as name, title, or manager), the employee's user account is automatically updated in Microsoft Entra ID and optionally Microsoft 365 and other SaaS applications that Microsoft Entra ID supports.
* **Employee terminations**: When an employee is terminated in SuccessFactors, the employee's user account is automatically disabled in Microsoft Entra ID and optionally Microsoft 365 and other SaaS applications that Microsoft Entra ID supports.
* **Employee rehires**: When an employee is rehired in SuccessFactors, the employee's old account can be automatically reactivated or reprovisioned (depending on your preference) to Microsoft Entra ID and optionally Microsoft 365 and other SaaS applications that Microsoft Entra ID supports.

You can also [write back from Microsoft Entra ID to SAP SuccessFactors](../identity/saas-apps/sap-successfactors-writeback-tutorial.md).

### SAP HCM

Customers who still use SAP Human Capital Management (HCM) can also bring identities into Microsoft Entra ID. By using SAP Integration Suite, you can synchronize lists of workers between SAP HCM and SAP SuccessFactors. From there, you can bring identities directly into Microsoft Entra ID or provision them into Active Directory Domain Services by using the native provisioning integrations mentioned earlier.

![Diagram of SAP HR integrations.](./media/sap/sap-hr.png)
-->

### Provisioning for SAP systems

Once you have users in Microsoft Entra ID, you can provision those users from Microsoft Entra ID to SAP Cloud Identity Services or SAP ECC, to enable them to sign in to SAP applications.
  :::image type="content" source="media/plan-sap-user-source-and-target/outbound-provisioning-and-sso.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to provisioning identities from Microsoft Entra ID." lightbox="media/plan-sap-user-source-and-target/outbound-provisioning-and-sso.png":::

<!-- S/4HANA connector -->
<!-- identity authentication connector -->
<!-- SAP HANA -->

<!-- TC1.18 -->
<!-- TC1.19 deactivate vs delete -->
<!-- TC1.20 event-based provisioning -->

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/2f8af286449c4453a8514ba598938581.html -->
<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/030be4215086478589e59ff717dd146b.html enhanced business suite integration -->

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/a42a2432a1a143ceb1d5f3809bf1e82f.html SAP Netweaver portal environment -->


### Provisioning for non-SAP systems

<!-- SCIM connctor -->
<!-- AS JAVA connetor: to J2EE via SPML -->

<!-- SAP IDM adapters to repositories - database, file, LDAP (Sun ONE, Novell eDIrectory), Shell, SOAP and REST -->

<!-- Microsoft Active Directory -->

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/8440dc9e770340ca870b5a0986ecb25b.html connect to AD and Exchange -->

<!-- ? TC1.21 S/4 business partners supported -->

<!-- targets: SQL, LDAP -->
<!-- inbound -->

### Integration with SAP Access Control and SAP Identity Access Governance

<!-- TC 1.25 integration with SAP AC -->
<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/179deb84c0c446c99d3e87f79ed3624a.html -->
<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/bde5bf21a6564295aadc64e27f8d3584.html Integration with SAP Access Control 10.0 or higher -->

### End user authentication and self-service

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/d0faf50c76ef43f8808165ad855bc8c6.html -->

<!-- logon help -->

<!-- TC1.5 self-service password reset -->
<!-- TC1.6 self-service access requests, see below -->

### Exchanging identity information across organizational boundaries

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/d376345fb4e94928a70036ddf91d690b/5674c5a6cf30402390df5abbfded5195.html -->

### Reporting

<!-- TC1.7 -->
<!-- TC1.8 audit reports -->
<!-- Concept: Audit log -->
<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/92e54800d27e4feb8ed373955f387e00.html standard reports -->

<!-- Reports Users Attributes, Users Assignments or Double Privilege Assignment ; for a user User History Attributes or User History Assignments -->

### Identity lifecycle management

<!-- https://help.sap.com/docs/SAP_IDENTITY_MANAGEMENT/4773a9ae1296411a9d5c24873a8d418c/687dff86043f49e2982ba7942808e0f6.html -->

<!-- TC1.15 mass user administration, TC 1.16 transport functionality, -->
<!-- TV1.22 central locking of a user -->
<!-- Concept: inactive user -->

### Access lifecycle management

<!-- TC1.1c, 1.9, 1.10 birthright access -->
<!-- TC1.11,1.12,1.13 business roles -->
<!-- TC1.14 "context based business roles" >
<!-- workflows - TC1.1a,b custom workflow, TC1.2,1.3,1.4 approvals -->

<!-- Concept: Approvals ==> SSGM, PIM and entitlement management approvals -->
<!-- Concept: Attestation ==> Access reviews -->
<!-- Concept: Future assignments ==> entitlement management and PIM -->

### Federation

<!-- Identity federation includes a SAML 2.0 identity provider and a security token service (STS) using the WS-Trust
1.3 standard.
You can use the identity provider for single sign-on (SSO) with SAP or non-SAP service providers. As an
identity provider, SAP Netweaver Application Server (SAP NetWeaver AS) Java can provide cross-domain SSO
in combination with SAML 2.0 service providers and at the same time enable single log-out (SLO) to close all
user sessions in the SAML landscape. -->

For more information, see [](~/identity/saas-apps/sap-hana-cloud-platform-identity-authentication-tutorial.md).

### Integration and extensibility

<!-- Controlling access to information AU? CSA? -->

<!-- APIs, callouts? -->

<!-- TC1.23 building custom forms those attrs and their presentation type -->

<!-- partner-driven integrations /identity/app-provisioning/partner-driven-integrations -->

<!-- custom schema attributes -->

<!-- N/A: custom entry types, attribute ownership, custom forms, lotus notes -->

## Next steps

* [Plan deploying Microsoft Entra for user identity provisioning with SAP source and target applications](~/identity/app-provisioning/plan-sap-user-source-and-target.md)
* [Manage access to your SAP applications](~/id-governance/sap.md)
* [Migrating from ADFS](~identity/enterprise-apps/migrate-ad-fs-application-howto.md)
* [Migrating from MIM](/microsoft-identity-manager/migrate-entra-id)

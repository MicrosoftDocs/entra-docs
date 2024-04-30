---
title: 'Use partner driven integrations to provision accounts into all your applications'
description: Use partner driven integrations to provision accounts into all your applications.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: overview
ms.date: 02/13/2024
ms.subservice: hybrid
ms.author: billmath
ms.collection: M365-identity-device-management
---
# Partner-driven provisioning integrations

The Microsoft Entra provisioning service allows you to provision users and groups into both [SaaS](user-provisioning.md) and [on-premises](on-premises-scim-provisioning.md) applications. There are four integration paths:

**Option 1 - Microsoft Entra Application Gallery:**
Popular third party applications, such as Dropbox, Snowflake, and Workplace by Facebook, are made available for customers through the Microsoft Entra application gallery. New applications can easily be onboarded to the gallery using the [application network portal](~/identity/enterprise-apps/v2-howto-app-gallery-listing.md). 

**Option 2 - Implement a SCIM compliant API for your application:**
If your line-of-business application supports the [SCIM](https://aka.ms/scimoverview) standard, it can easily be integrated with the [Microsoft Entra SCIM client](use-scim-to-provision-users-and-groups.md).

   [![Diagram showing implementation of a SCIM compliant API for your application.](media/partner-driven-integrations/scim-compliant-api-1.png)](media/partner-driven-integrations/scim-compliant-api-1.png#lightbox)

**Option 3 - Use Microsoft Graph:**
Many new applications use Microsoft Graph to retrieve users, groups and other resources from Microsoft Entra ID. You can learn more about what scenarios to use [SCIM and Graph](scim-graph-scenarios.md) in. 

**Option 4 - Use partner-driven connectors:**
In cases where an application doesn't support SCIM, partners have built [custom ECMA connectors](on-premises-custom-connector.md) and SCIM gateways to integrate Microsoft Entra ID with numerous applications. **This document serves as a place for partners to attest to integrations that are compatible with Microsoft Entra ID, and for customers to discover these partner-driven integrations.** Custom ECMA connectors and SCIM gateways are built, maintained, and owned by the third-party vendor. 


   [![Diagram showing gateways between the Microsoft Entra SCIM client and target applications.](media/partner-driven-integrations/partner-driven-connectors-1.png)](media/partner-driven-integrations/partner-driven-connectors-1.png#lightbox)

## Available partner-driven integrations
The descriptions and lists of applications below are provided by the partners themselves. You can use the lists of applications supported to identify a partner that you may want to contact and learn more about.  


### Aquera

#### Description
Aquera is a leading provider of SCIM Gateway Services for Microsoft Entra. The SCIM Gateway for Microsoft Entra from Aquera is a cloud-based service providing out-of-the-box connectivity between Microsoft Entra ID and the provisioning target applications, directories, databases, devices, or third party IDPs that an organization or their partners operate, which are not covered by the Microsoft Entra application gallery. 
The Aquera SCIM Gateway powers Microsoft Entra ID to create, update, deactivate, and delete user accounts via Aquera connectors in any cloud or on-premises application, database, directory, device, or third party IDP via the Microsoft Entra ID SCIM protocol. Aquera has a catalog of over 800 connectors covering these targets, builds additional connectors on-demand, and offers a self-service connector builder for customers to build their own connectors for the Aquera SCIM Gateway. The Aquera connectors support the various integration methods required by each target including REST, SQL, LDAP, SOAP, non-Entra ID compatible SCIM, or web service APIs, admin console automation, SDKs, code libraries, and files via FTP and local file shares. 
Aquera also supports over 40 inbound provisioning HRIS sources of record for Microsoft Entra ID, and further provides deep integration with all the major ITSMs supporting automatic generation of joiner, mover, and leaver work tickets in the ITSMs, and fulfilling ITSM self-service access requests via Entra ID. 

#### Contact Information
* Company website: https://www.aquera.com 
* Azure Marketplace Listings: https://azuremarketplace.microsoft.com/en-us/marketplace/apps?search=aquera&page=1 

#### Popular applications supported
* Over 40 HRIS Applications: Oracle Cloud HCM, Dayforce, UKG Pro/Ready/Pro Workforce, ADP (all US and international versions), Workday, SAP HR, Greenhouse, iCIMS, SuccessFactors, HiBob, BambooHR, Paylocity, Paycor, PeopleSoft, Cornerstone, Lever
* ERPs: Netsuite, Oracle Cloud ERP, Oracle EBS, SAP ECC, SAP S/4HANA, Sage Intacct, PeopleSoft ERP
* EHRs: Epic, Cerner, PointClickCare, MyAvatar, Homecare Homebase
* Student Information Systems: Ellucian Banner, PeopleSoft Campus Solutions
* Databases: Oracle, MySQL, SQLServer, MongoDB, PostgreSQL, AS/400 DB2, DB2, Snowflake, Redshift
* Directories/IDPs: AS/400, RACF, ACF2, TopSecret, OpenLDAP, IDP Directories



### IDMWORKS
#### Description
We Are Experts In Identity & Access Management and Data Center Management.
The Microsoft Entra platform integrates with IDMWORKS IdentityForge (IDF) Gateway for user lifecycle management for Mainframe systems (RACF, Top Secret, ACF2), Midrange system (AS400), Healthcare applications (EPIC/Cerner), Linux/Unix servers, Databases, and dozens of on-premises and cloud applications. IdentityForge provides a central, standardized integration engine and modern identity store that serves as a trusted source for all lifecycle management.
The IDF Gateway for Microsoft Entra ID provides lifecycle management for import sources and provisioning target systems that are not covered by the Microsoft Entra connector portfolio like Mainframe systems (RACF, Top Secret, ACF2) or Healthcare applications (EPIC/Cerner). The IDF Gateway powers Microsoft Entra identity lifecycle management (LCM) to continuously synchronize user account information from Mainframe/Healthcare sources and to automate the account provisioning lifecycle use cases like create, read (import), update, deactivate, delete user accounts and perform group management.

#### Contact information
* Company website: https://www.idmworks.com/identity-forge
* Contact information: https://www.idmworks.com/contacts/

#### Popular applications supported

Leading provider of Mainframe, Healthcare and ERP integrations.  More can be found at https://www.idmworks.com/identity-forge/

* IBM RACF
* CA Top Secret
* CA ACF2
* IBM i (AS/400)
* HP NonStop
* EPIC
* SAP ECC

### KloudIdentity
#### Description

KloudIdentity streamlines enterprise operations by simplifying the onboarding process of on-premises Line of Business (LOB) applications and facilitating outbound provisioning of users and groups through Microsoft Entra ID. It serves as a SCIM gateway, enabling non-SCIM compliant LOB applications to seamlessly integrate with Microsoft Entra ID. This application is founded upon a unique design paradigm known as the universal connector space, which offers a standardized platform for creating connectors for various LOB applications through a template-driven approach. This methodology significantly reduces lead time and costs associated with onboarding non-SCIM compliant LOB applications to Microsoft Entra ID for outbound provisioning.

Integration with LOB applications is primarily achieved through REST APIs, with support also extended to SOAP APIs and PowerShell scripts. Administrators can easily configure attribute mapping templates using a user-friendly web portal. Beyond graphical UI-driven attribute mapping, KloudIdentity offers a customizable policies-based approach, allowing for the configuration of highly tailored sequences of attribute mapping and payload generation.

Furthermore, KloudIdentity provides a Software Development Kit (SDK) to customize the standard connector platform, addressing complex and advanced integration scenarios. This empowers users to make code modifications within the KloudIdentity framework safely and efficiently, enabling seamless integration of LOB applications for users and groups provisioning. The SCIM gateway can be deployed either as a cloud-based solution or within on-premises data centers, supporting a range of deployment options from conventional IIS setups to Kubernetes orchestrated environments

#### Contact information
* Company website: https://www.kloudynet.com/
* Azure Marketplace Listing: https://azuremarketplace.microsoft.com/en-us/marketplace/consulting-services/kloudynettechnologiessdnbhd1588004273044.identity_implementation

#### Popular applications supported
KloudIdentity provides a universal connector platform; Hence any LOB application can be integrated with REST or SOAP APIs, PowerShell scripts, and SDK approach.

### UNIFY Solutions
#### Description

UNIFY Solutions is a leading provider of Identity, Access, Security and Governance solutions.

#### Contact information
* Company website: https://unifysolutions.net/identity/unifyconnect
* Contact information: https://unifysolutions.net/contact/

#### Popular applications supported
* Aurion People & Payroll
* Frontier Software chris21
* TechnologyOne HR
* Ascender HCM
* Fusion5 EmpowerHR
* SAP ERP Human Capital Management

## How-to add partner-driven integrations to this document
If you have built a SCIM Gateway and would like to add it to this list, follow the steps below. 

1. Review the Microsoft Entra SCIM [documentation](use-scim-to-provision-users-and-groups.md) to understand the Microsoft Entra SCIM implementation.
1. Test compatibility between the Microsoft Entra SCIM client and your SCIM gateway.
1. Click the pencil at the top of this document to edit the article
1. Once you're redirected to GitHub, click the pencil at the top of the article to start making changes
1. Make changes in the article using the Markdown language and create a pull request. Make sure to provide a description for the pull request.  
1. An admin of the repository will review and merge your changes so that others can view them.

## Guidelines
* Add any new partners in alphabetical order.
* Limit your entries to 500 words.
* Ensure that you provide contact information for customers to learn more.
* To avoid duplication, only include applications that don't already have out of the box provisioning connectors in the [Microsoft Entra application gallery](~/identity/saas-apps/tutorial-list.md). 

## Disclaimer
For independent software vendors: The Microsoft Entra Application Gallery Terms & Conditions, excluding Sections 2–4, apply to this Partner-Driven Integrations Catalog (the “Integrations Catalog”). References to the “Gallery” shall be read as the “Integrations Catalog” and references to an “App” shall be read as “Integration”.  

If you don't agree with these terms, you shouldn't submit your Integration for listing in the Integrations Catalog. If you submit an Integration to the Integrations Catalog, you agree that you or the entity you represent (“YOU” or “YOUR”) is bound by these terms. 
 
Microsoft reserves the right to accept or reject your proposed Integration in its sole discretion and reserves the right to determine the manner in which Apps are presented, promoted, or featured in this Integrations Catalog. 

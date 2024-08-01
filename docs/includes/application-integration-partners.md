---
title: Include file for application integration partners
description: Include file for application integration partners for identity and access management (IAM), and for identity governance and administration (IGA), using the System for Cross Domain Identity Management (SCIM) protocol to reach more systems. These systems include Enterprise Resource Planning (ERP), Electronic Health Record (EHR), and Human Capital Management (HCM) applications. Partners also have integrations with applications that use the Lightweight Directory Access Protocol (LDAP), or that require integration with software development kits (SDKs).
author: markwahl-msft
ms.service: entra-id
ms.topic: include
ms.date: 05/27/2024
ms.author: mwahl
ms.custom: include file
---

## Available partner-driven integrations
The following descriptions and lists of applications are provided by the partners themselves. You can use the lists of applications supported to identify a partner that you may want to contact and learn more about.


### Aquera

#### Description
Aquera is a leading provider of SCIM Gateway Services for Microsoft Entra. The SCIM Gateway for Microsoft Entra from Aquera is a cloud-based service providing out-of-the-box connectivity between Microsoft Entra ID and the provisioning target applications, directories, databases, devices, or third party identity providers (IDPs) that an organization or their partners operate, which are not covered by the Microsoft Entra application gallery. 
The Aquera SCIM Gateway powers Microsoft Entra ID to create, update, deactivate, and delete user accounts via Aquera connectors in any cloud or on-premises application, database, directory, device, or third party IDP via the Microsoft Entra ID SCIM protocol. Aquera has a catalog of over 800 connectors covering these targets, builds additional connectors on-demand, and offers a self-service connector builder for customers to build their own connectors for the Aquera SCIM Gateway. The Aquera connectors support the various integration methods required by each target including REST, SQL, LDAP, SOAP, SCIM not compatible with Microsoft Entra ID, or web service APIs, admin console automation, SDKs, code libraries, and files via FTP and local file shares. 
Aquera also supports over 40 inbound provisioning HR Information System (HRIS) sources of record for Microsoft Entra ID, and further provides deep integration with all the major IT Service Management systems (ITSMs) supporting automatic generation of joiner, mover, and leaver work tickets in the ITSMs, and fulfilling ITSM self-service access requests via Microsoft Entra ID. 

#### Contact Information
* Company website: https://www.aquera.com 
* Azure Marketplace Listings: https://azuremarketplace.microsoft.com/en-us/marketplace/apps?search=aquera&page=1 

#### Popular applications supported
* HRIS Applications: Over 40 including Oracle Cloud HCM, Dayforce, UKG Pro/Ready/Pro Workforce, ADP (all US and international versions), Workday, SAP HR, Greenhouse, iCIMS, SuccessFactors, HiBob, BambooHR, Paylocity, Paycor, PeopleSoft, Cornerstone, Lever
* ERP Applications: Netsuite, Oracle Cloud ERP, Oracle EBS, SAP ERP Central Component (ECC), SAP S/4HANA, Sage Intacct, PeopleSoft ERP
* EHR Applications: Epic, Cerner, PointClickCare, MyAvatar, Homecare Homebase
* Student Information Systems: Ellucian Banner, PeopleSoft Campus Solutions
* Databases: Oracle, MySQL, SQLServer, MongoDB, PostgreSQL, AS/400 DB2, DB2, Snowflake, Redshift
* Directories and IDPs: AS/400, Resource Access Control Facility (RACF), ACF2, TopSecret, OpenLDAP, IDP Directories



### IDMWORKS
#### Description
We Are Experts In Identity & Access Management and Data Center Management.
The Microsoft Entra platform integrates with IDMWORKS IdentityForge (IDF) Gateway for user lifecycle management for Mainframe systems RACF, Top Secret, and ACF2, Midrange system AS/400, Healthcare applications EPIC and Cerner, Linux and Unix servers, Databases, and dozens of on-premises and cloud applications. IdentityForge provides a central, standardized integration engine and modern identity store that serves as a trusted source for all lifecycle management.
The IDF Gateway for Microsoft Entra ID provides lifecycle management for import sources and provisioning target systems that are not covered by the Microsoft Entra connector portfolio like Mainframe systems RACF, Top Secret, and ACF2, or Healthcare applications EPIC and Cerner. The IDF Gateway powers Microsoft Entra identity lifecycle management (LCM) to continuously synchronize user account information from Mainframe and Healthcare sources and to automate the account provisioning lifecycle use cases like create, read or import, update, deactivate, delete user accounts, and perform group management.

#### Contact information
* Company website: https://www.idmworks.com/identity-forge
* Contact information: https://www.idmworks.com/contacts/

#### Popular applications supported

Leading provider of Mainframe, Healthcare and ERP integrations. More can be found at https://www.idmworks.com/identity-forge/

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

Furthermore, KloudIdentity provides a Software Development Kit (SDK) to customize the standard connector platform, addressing complex and advanced integration scenarios. This SDK empowers users to make code modifications within the KloudIdentity framework safely and efficiently, enabling seamless integration of LOB applications for users and groups provisioning. The SCIM gateway can be deployed either as a cloud-based solution or within on-premises data centers, supporting a range of deployment options from conventional Internet Information Services (IIS) setups to Kubernetes orchestrated environments

#### Contact information
* Company website: https://www.kloudynet.com/
* Azure Marketplace Listing: https://azuremarketplace.microsoft.com/en-us/marketplace/consulting-services/kloudynettechnologiessdnbhd1588004273044.identity_implementation

#### Popular applications supported
KloudIdentity provides a universal connector platform; Hence any LOB application can be integrated with REST or SOAP APIs, PowerShell scripts, and SDK approach.

### Traxion SCIM Gateway
#### Description
At Traxion, we believe that industry-wide standardization plays a big role in the future of Identity and Access Management (IAM). We are determined to help our customers achieve their security goals through the use of best practices and common standards. System for Cross-domain Identity Management (SCIM) is such a standard.

Companies deploying an IGA system are challenged with how hard it can be to connect applications for synchronizing users, groups and other data entities.
The process of connecting and maintaining application integrations has proven to be a challenging, time-consuming, and costly process; not only for the companies deploying an IAM system but also for application vendors and integrators.
It is especially tough when connecting an application that does not support a common standard such as SCIM 2.0.
By using our SCIM Gateway we enable our customers to leverage the benefits of a standardized integration by reducing lead times and overall costs.

Our SCIM Gateway is an easy, secure and standardized solution, that will enable you to synchronize all identity and access information with any non-natively SCIM supporting application.

Integrations include:

- AFAS Profit
- Splunk
- ATS
- Oracle ERP
- SAP SuccessFactors
- Tempus Resources
- Generic connectors (CSV, SQL)
- Develop your own connector using our [public SDK](https://www.nuget.org/packages/Traxion.Scim.Gateway.Connectors.Sdk)

#### Contact information
* Company website: https://www.traxion.com/products/iam-integration/scim-gateway/
* Contact information: https://www.traxion.com/contact/

### UNIFY Solutions
#### Description

UNIFY Solutions is a leading provider of Identity, Access, Security, and Governance solutions.

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

### Custom connectors

Microsoft Entra ID includes connectivity to provision into applications that support protocols and interfaces including SCIM, SQL, LDAP, REST, SOAP, and PowerShell.
For connectivity to applications that don't support one of those protocols and interfaces, customers and [partners](/archive/technet-wiki/1589.fim-2010-mim-2016-management-agents-from-partners) have custom Extensible Connectivity (ECMA) [connectors](/previous-versions/windows/desktop/forefront-2010/hh859557(v=vs.100)) for use with Microsoft Identity Manager (MIM) 2016. Community members have also built ECMA connectors, hosted on their blogs and in public source code repositories. These same ECMA2 connectors can be used to provision into apps with the Microsoft Entra provisioning agent and Extensible Connectivity (ECMA) Connector host, without needing MIM sync deployed. For more information, see [provisioning with the custom connectors](~/identity/app-provisioning/on-premises-custom-connector.md).

If you have been using a custom connector with MIM, then you can [export the MIM connector configuration](~/identity/app-provisioning/on-premises-migrate-microsoft-identity-manager.md) and import it into Microsoft Entra.

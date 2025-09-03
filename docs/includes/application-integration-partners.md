---
title: Include file for application integration partners
description: Include file for application integration partners for identity and access management (IAM), and for identity governance and administration (IGA), using the System for Cross Domain Identity Management (SCIM) protocol to reach more systems. These systems include Enterprise Resource Planning (ERP), Electronic Health Record (EHR), and Human Capital Management (HCM) applications. Partners also have integrations with applications that use the Lightweight Directory Access Protocol (LDAP), or that require integration with software development kits (SDKs).
author: billmath
ms.service: entra-id
ms.topic: include
ms.date: 05/27/2024
ms.author: billmath
ms.custom: include file
---

## Available partner-driven integrations
The following descriptions and lists of applications are provided by the partners themselves. You can use the lists of applications supported to identify a partner that you may want to contact and learn more about.


### Aquera

#### Description
With 1,000+ customer deployments, Aquera delivers HR process and Identity Integration for Microsoft Active Directory (AD) and Microsoft Entra ID. Aquera automates user account provisioning and deprovisioning throughout the employee lifecycle to enable joiner, mover, leaver automation. Aquera’s prebuilt, out-of-the-box [HR Sync Connectors](https://azuremarketplace.microsoft.com/marketplace/apps/aquerainc1584125423571.hr-sync-for-microsoft-entra-id-azure-ad-by-aquera?tab=Overview) enable 50+ HR/HCM systems of record to automate HR-driven user and account inbound provisioning to AD and Microsoft Entra ID. Beyond HR systems of record, Aquera SCIM Gateway for Microsoft Entra ID provisions and deprovisions users, accounts, and groups (where available) to non-gallery apps through industry-standard System for Cross-domain Identity Management (SCIM). Since 2020, [Microsoft and Aquera have extended Microsoft Entra ID connectivity to hundreds of apps not found in the Microsoft Entra App Gallery](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/automate-user-provisioning-for-more-applications-with-our-new/ba-p/1751668).

The Aquera SCIM Gateway delivers out-of-the-box connectivity between Microsoft Entra ID and the provisioning target applications, directories, databases, devices, files, or 3rd-party identity providers (IDPs) for B2B partners, which aren't included in the [Microsoft Entra App Gallery](https://portal.azure.com/#view/Microsoft_AAD_IAM/AppGalleryBladeV2), or where Gallery apps do not support automatic provisioning. Microsoft + Aquera extend [Microsoft Entra ID to scale identity management](https://www.microsoft.com/en-us/security/business/identity-access/microsoft-entra-lifecycle-management-software) as user identities, roles, and entitlements change dynamically.
The Aquera catalog of over 900 prebuilt connectors supports multiple integration methods including REST, SQL, LDAP, SOAP, and SCIM, and SCIM that isn't compatible with Microsoft Entra ID. Additionally, the connectors support web service APIs, admin console automation, SDKs, code libraries, files, and [Microsoft API-driven Inbound Provisioning](~/identity/app-provisioning/inbound-provisioning-api-concepts.md). 


#### Contact Information
* Company website: https://www.aquera.com 
* Azure Marketplace Listings: https://azuremarketplace.microsoft.com/en-us/marketplace/apps?search=aquera&page=1
* AppSource Marketplace Listings: https://appsource.microsoft.com/en-us/marketplace/apps?search=aquera&page=1

#### Popular applications supported
* Human resources information systems applications: Over 40 including Oracle Cloud HCM, Dayforce, UKG Pro/Ready/Pro Workforce, ADP (all US and international versions), Workday, SAP HR, Greenhouse, iCIMS, SuccessFactors, HiBob, BambooHR, Paylocity, Paycor, PeopleSoft, Cornerstone, Lever
* Enterprise resource planning applications: Netsuite, Oracle Cloud ERP, Oracle EBS, SAP ERP Central Component (ECC), SAP S/4HANA, Sage Intacct, PeopleSoft ERP
* Electronic health record applications: Epic, Cerner, PointClickCare, MyAvatar, Homecare Homebase
* Student Information Systems: Ellucian Banner, PeopleSoft Campus Solutions
* Databases: Oracle, MySQL, SQLServer, MongoDB, PostgreSQL, AS/400 DB2, DB2, Snowflake, Redshift
* Directories and IDPs: AS/400, Resource Access Control Facility (RACF), ACF2, TopSecret, OpenLDAP, IDP Directories



### IDMWORKS
#### Description
We're Experts In Identity & Access Management and Data Center Management.
The Microsoft Entra platform integrates with IDMWORKS IdentityForge (IDF) Gateway for user lifecycle management for Mainframe systems RACF, Top Secret, and ACF2, Midrange system AS/400, Healthcare applications EPIC and Cerner, Linux and Unix servers, Databases, and dozens of on-premises and cloud applications. IdentityForge provides a central, standardized integration engine and modern identity store that serves as a trusted source for all lifecycle management.
The IDF Gateway for Microsoft Entra ID provides lifecycle management for import sources and provisioning target systems that aren't covered by the Microsoft Entra connector portfolio like Mainframe systems RACF, Top Secret, and ACF2, or Healthcare applications EPIC and Cerner. The IDF Gateway powers Microsoft Entra identity lifecycle management (LCM) to continuously synchronize user account information from Mainframe and Healthcare sources and to automate the account provisioning lifecycle use cases like create, read or import, update, deactivate, delete user accounts, and perform group management.

#### Contact information
* Company website: https://www.idmworks.com/identity-forge
* Contact information: https://www.idmworks.com/contact/

#### Popular applications supported

Leading provider of Mainframe, Healthcare and ERP integrations. More can be found at https://www.idmworks.com/identity-forge/

* IBM RACF
* CA Top Secret
* CA ACF2
* IBM i (AS/400)
* HP NonStop
* EPIC
* SAP ECC

### Joinly
#### Description
Joinly is a modern Identity and Access Management (IAM) and Identity Governance and Administration (IGA) platform focused on HR-driven provisioning. Joinly integrates Human Capital Management (HCM) systems directly with Microsoft Entra ID to automate the full employee lifecycle: joiner, mover, and leaver.  

The Joinly SCIM Gateway enables provisioning and deprovisioning of users, groups, and access entitlements for applications that don't natively support Microsoft Entra ID or SCIM. The platform also includes functionality for role mining, access reviews, and provisioning logs, making it a suitable choice for mid-market organizations that want advanced IAM capabilities without requiring Microsoft Entra ID P2 licensing.  

Joinly supports hybrid environments by combining SCIM provisioning with Robotic Process Automation (RPA) for systems without APIs, ensuring integration coverage across modern SaaS platforms as well as legacy applications.  

#### Contact information
* Company website: https://joinly.app/en
* SCIM Gateway: https://joinly.app/en/product/scim-gateway
* Contact information: https://joinly.app/en/contact  

#### Popular applications supported
* HR and payroll systems: AFAS, Visma | Raet, Youforce, Personio, Nmbrs  
* IT service management: TOPdesk, IFS Ultimo  
* Collaboration and productivity: Microsoft 365, Google Workspace  
* Finance and ERP: Exact Online, Twinfield  
* Marketing and CRM: HubSpot, Salesforce, ActiveCampaign  
* Education and healthcare: Magister, Nedap ONS  

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

### Quorum Systems Identity DNA
#### Description

Identity DNA is Quorum’s purpose built platform designed to complement and enhance native Microsoft Entra ID Governance capabilities. The service acts as a System for Cross-domain Identity Management (SCIM) gateway, and it is deployed in customer's Azure environment and managed via CICD pipelines.

The Identity DNA platform is designed to handle complex integration scenarios while allowing customers to enhance end to end identity flow, achieving a better user experience and addressing key business and technical challenges.

The Identity DNA platform is able to connect to any application through a number of pre defined connections (REST API, SOAP API, Database, PowerShell, or CSV) to data sources either in the cloud or on-premises. 

Identity DNA then converts that data to a System for Cross-domain Identity Management (SCIM) payload and delivers that to the Entra provisioning service. The Identity DNA platform allows for data between applications to be synced bidirectionally ensuring disparate systems identities are kept up to date with ease.

#### Contact information
* Company website: https://quorumsystems.com.au/
* AppSource Listing: Entra User ID Provisioning https://appsource.microsoft.com/en-us/marketplace/consulting-services/quorumsystemsptyltd1587621343059.entrauseridprovisioning

#### Popular applications supported
Identity DNA can be integrated with any line of business application that has REST or SOAP API's, Databases, PowerShell scripts, or even other directory services such as LDAP.

### Traxion SCIM Gateway
#### Description
At Traxion, we believe that industry-wide standardization plays a large role in the future of Identity and Access Management (IAM). We're determined to help our customers achieve their security goals by using best practices and common standards. System for Cross-domain Identity Management (SCIM) is such a standard.

Companies deploying an IGA system are challenged with how hard it can be to connect applications for synchronizing users, groups, and other data entities.
The process of connecting and maintaining application integrations has proven to be a challenging, time-consuming, and costly process; not only for the companies deploying an IAM system but also for application vendors and integrators.
It's especially tough when connecting an application that doesn't support a common standard such as SCIM 2.0.
By using our SCIM Gateway we enable our customers to leverage the benefits of a standardized integration by reducing lead times and overall costs.

Our SCIM Gateway is an easy, secure, and standardized solution, that will enable you to synchronize all identity and access information with any non-natively SCIM supporting application.

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
For connectivity to applications that don't support one of those protocols and interfaces, customers and [partners](/archive/technet-wiki/1589.fim-2010-mim-2016-management-agents-from-partners) have custom Extensible Connectivity (ECMA) [connectors](/previous-versions/windows/desktop/forefront-2010/hh859557(v=vs.100)) for use with Microsoft Identity Manager (MIM) 2016. Community members have also built ECMA connectors, hosted on their blogs and in public source code repositories. These same ECMA2 connectors can be used to provision into apps with the Microsoft Entra provisioning agent and Extensible Connectivity (ECMA) Connector host, without needing to deploy MIM sync. For more information, see [provisioning with the custom connectors](~/identity/app-provisioning/on-premises-custom-connector.md).

If you have been using a custom connector with MIM, then you can [export the MIM connector configuration](~/identity/app-provisioning/on-premises-migrate-microsoft-identity-manager.md) and import it into Microsoft Entra.

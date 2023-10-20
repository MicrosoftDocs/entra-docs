---
title: Microsoft Entra ID Governance integrations
description: This page provides an overview of the Microsoft Entra ID Governance integrations available to automate provisioning and governance controls.
services: active-directory
author: billmath
manager: amycolannino
ms.service: active-directory
ms.subservice: compliance
ms.topic: overview
ms.workload: identity
ms.date: 08/24/2023
ms.author: billmath
ms.custom: contperf-fy21q3-portal
ms.reviewer: amycolannino
---

# Microsoft Entra ID Governance integrations

[Microsoft Entra ID Governance](identity-governance-applications-prepare.md) allows you to balance your organization's need for security and employee productivity with the right processes and visibility. This page provides an overview of the hundreds of Microsoft Entra ID Governance integrations available. These application integrations are used to automate [identity lifecycle management](what-is-identity-lifecycle-management.md) and implement governance controls across your organization. Through these rich integrations, you can automate providing users [access to applications](entitlement-management-overview.md), perform [periodic reviews](access-reviews-overview.md) of who has access to an application, and secure them with capabilities such as multi-factor authentication. 

## Featured integrations

| Category | Application |
| :--- | :--- |
| HR | [SuccessFactors - User Provisioning](~/identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md) |
| HR | [Workday - User Provisioning](~/identity/saas-apps/workday-inbound-cloud-only-tutorial.md)|
|[LDAP directory](~/identity/app-provisioning/on-premises-ldap-connector-configure.md)| OpenLDAP<br>Microsoft Active Directory Lightweight Directory Services<br>389 Directory Server<br>Apache Directory Server<br>IBM Tivoli DS<br>Isode Directory<br>NetIQ eDirectory<br>Novell eDirectory<br>Open DJ<br>Open DS<br>Oracle (previously Sun ONE) Directory Server Enterprise Edition<br>RadiantOne Virtual Directory Server (VDS) |
| [SQL database](~/identity/app-provisioning/tutorial-ecma-sql-connector.md)| Microsoft SQL Server and Azure SQL<br>IBM DB2 10.x<br>IBM DB2 9.x<br>Oracle 10g and 11g<br>Oracle 12c and 18c<br>MySQL 5.x|
| Cloud platform| [AWS IAM Identity Center](~/identity/saas-apps/aws-single-sign-on-provisioning-tutorial.md) |
| Cloud platform| [Google Cloud Platform - User Provisioning](~/identity/saas-apps/g-suite-provisioning-tutorial.md) |
| Business applications|[SAP Cloud Identity Platform - Provisioning](~/identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md) |
| CRM| [Salesforce - User Provisioning](~/identity/saas-apps/salesforce-provisioning-tutorial.md) |
| ITSM| [ServiceNow](~/identity/saas-apps/servicenow-provisioning-tutorial.md)|


<a name='entra-identity-governance-integrations'></a>

## Microsoft Entra ID Governance integrations
The list below provides key integrations between Microsoft Entra ID Governance and various applications, including both provisioning and SSO integrations. For a full list of applications that Microsoft Entra ID integrates with specifically for SSO, see [here](~/identity/saas-apps/tutorial-list.md). 

Microsoft Entra ID Governance can be integrated with many other applications, using standards such as OpenID Connect, SAML, SCIM, SQL and LDAP. If you're using a SaaS application which isn't listed, then [ask the SaaS vendor to onboard](~/identity/enterprise-apps/v2-howto-app-gallery-listing.md).  For integration with other applications, see [integrating applications with Microsoft Entra ID](identity-governance-applications-integrate.md).

| Application | Automated provisioning | Single Sign On (SSO)|
| :--- | :-:  | :-: |
| 389 directory server ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [4me](~/identity/saas-apps/4me-provisioning-tutorial.md) | ● | ●| 
| [8x8](~/identity/saas-apps/8x8-provisioning-tutorial.md) | ● | ● |
| [15five](~/identity/saas-apps/15five-provisioning-tutorial.md) | ● | ● |
| [Acunetix 360](~/identity/saas-apps/acunetix-360-provisioning-tutorial.md) | ● | ● |
| [Adobe Identity Management](~/identity/saas-apps/adobe-identity-management-provisioning-tutorial.md) | ● | ● |
| [Adobe Identity Management (OIDC)](~/identity/saas-apps/adobe-identity-management-provisioning-oidc-tutorial.md) | ● | ● |
| [Airbase](~/identity/saas-apps/airbase-provisioning-tutorial.md) | ● | ● |
| [Aha!](~/identity/saas-apps/aha-tutorial.md) |  | ● |
| [Airstack](~/identity/saas-apps/airstack-provisioning-tutorial.md) | ● |  |
| [Akamai Enterprise Application Access](~/identity/saas-apps/akamai-enterprise-application-access-provisioning-tutorial.md) | ● | ● |
| [Airtable](~/identity/saas-apps/airtable-provisioning-tutorial.md) | ● | ● |
| [Albert](~/identity/saas-apps/albert-provisioning-tutorial.md) | ● |  |
| [AlertMedia](~/identity/saas-apps/alertmedia-provisioning-tutorial.md) | ● | ● |
| [Alexis HR](~/identity/saas-apps/alexishr-provisioning-tutorial.md) | ● | ● |
| [Alinto Protect (renamed Cleanmail)](~/identity/saas-apps/alinto-protect-provisioning-tutorial.md) | ● | |
| [Alvao](~/identity/saas-apps/alvao-provisioning-tutorial.md) | ● |  |
| [Amazon Business](~/identity/saas-apps/amazon-business-provisioning-tutorial.md) | ● | ● |
| [Amazon Web Services (AWS) - Role Provisioning](~/identity/saas-apps/amazon-web-service-tutorial.md) | ● | ● |
| Apache Directory Server ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [Appaegis Isolation Access Cloud](~/identity/saas-apps/appaegis-isolation-access-cloud-provisioning-tutorial.md) | ● | ● |
| [Apple School Manager](~/identity/saas-apps/apple-school-manager-provision-tutorial.md) | ● |  |
| [Apple Business Manager](~/identity/saas-apps/apple-business-manager-provision-tutorial.md) | ● |  |
| [Ardoq](~/identity/saas-apps/ardoq-provisioning-tutorial.md) | ● | ● |
| [Asana](~/identity/saas-apps/asana-provisioning-tutorial.md) | ● | ● |
| [AskSpoke](~/identity/saas-apps/askspoke-provisioning-tutorial.md) | ● | ● |
| [Atea](~/identity/saas-apps/atea-provisioning-tutorial.md) | ● |  |
| [Atlassian Cloud](~/identity/saas-apps/atlassian-cloud-provisioning-tutorial.md) | ● | ● |
| [Atmos](~/identity/saas-apps/atmos-provisioning-tutorial.md) | ● |  |
| [AuditBoard](~/identity/saas-apps/auditboard-provisioning-tutorial.md) | ● |  |
| [Autodesk SSO](~/identity/saas-apps/autodesk-sso-provisioning-tutorial.md) | ● | ● |
| [Azure Databricks SCIM Connector](/azure/databricks/administration-guide/users-groups/scim/aad) | ● |  |
| [AWS IAM Identity Center](~/identity/saas-apps/aws-single-sign-on-provisioning-tutorial.md) | ● | ● |
| [Axiad Cloud](~/identity/saas-apps/axiad-cloud-provisioning-tutorial.md) | ● | ● |
| [BambooHR](~/identity/saas-apps/bamboo-hr-tutorial.md) |  | ● |
| [BenQ IAM](~/identity/saas-apps/benq-iam-provisioning-tutorial.md) | ● | ● |
| [Bentley - Automatic User Provisioning](~/identity/saas-apps/bentley-automatic-user-provisioning-tutorial.md) | ● |  |
| [Better Stack](~/identity/saas-apps/better-stack-provisioning-tutorial.md) | ● |  |
| [BIC Cloud Design](~/identity/saas-apps/bic-cloud-design-provisioning-tutorial.md) | ● | ● |
| [BIS](~/identity/saas-apps/bis-provisioning-tutorial.md) | ● | ● |
| [BitaBIZ](~/identity/saas-apps/bitabiz-provisioning-tutorial.md) | ● | ● |
| [Bizagi Studio for Digital Process Automation](~/identity/saas-apps/bizagi-studio-for-digital-process-automation-provisioning-tutorial.md) | ● | ● |
| [BLDNG APP](~/identity/saas-apps/bldng-app-provisioning-tutorial.md) | ● |  |
| [Blink](~/identity/saas-apps/blink-provisioning-tutorial.md) | ● | ● |
| [Blinq](~/identity/saas-apps/blinq-provisioning-tutorial.md) | ● |  |
| [BlogIn](~/identity/saas-apps/blogin-provisioning-tutorial.md) | ● | ● |
| [BlueJeans](~/identity/saas-apps/bluejeans-provisioning-tutorial.md) | ● | ● |
| [Bonusly](~/identity/saas-apps/bonusly-provisioning-tutorial.md) | ● | ● |
| [Box](~/identity/saas-apps/box-userprovisioning-tutorial.md) | ● | ● |
| [Boxcryptor](~/identity/saas-apps/boxcryptor-provisioning-tutorial.md) | ● | ● |
| [Bpanda](~/identity/saas-apps/bpanda-provisioning-tutorial.md) | ● |  |
| [Brivo Onair Identity Connector](~/identity/saas-apps/brivo-onair-identity-connector-provisioning-tutorial.md) | ● |  |
| [Britive](~/identity/saas-apps/britive-provisioning-tutorial.md) | ● | ● |
| [BrowserStack Single Sign-on](~/identity/saas-apps/browserstack-single-sign-on-provisioning-tutorial.md) | ● | ● |
| [BullseyeTDP](~/identity/saas-apps/bullseyetdp-provisioning-tutorial.md) | ● | ● |
| [Bustle B2B Transport Systems](~/identity/saas-apps/bustle-b2b-transport-systems-provisioning-tutorial.md) | ● |  |
| [Canva](~/identity/saas-apps/canva-provisioning-tutorial.md) | ● | ● |
| [Cato Networks Provisioning](~/identity/saas-apps/cato-networks-provisioning-tutorial.md) | ● |  |
| [Cerner Central](~/identity/saas-apps/cernercentral-provisioning-tutorial.md) | ● | ● |
| [Cerby](~/identity/saas-apps/cerby-provisioning-tutorial.md) | ● | ● |
| [Chaos](~/identity/saas-apps/chaos-provisioning-tutorial.md) | ● |  |
| [Chatwork](~/identity/saas-apps/chatwork-provisioning-tutorial.md) | ● | ● |
| [CheckProof](~/identity/saas-apps/checkproof-provisioning-tutorial.md) | ● | ● |
| [Cinode](~/identity/saas-apps/cinode-provisioning-tutorial.md) | ● |  |
| [Cisco Umbrella User Management](~/identity/saas-apps/cisco-umbrella-user-management-provisioning-tutorial.md) | ● | ● |
| [Cisco Webex](~/identity/saas-apps/cisco-webex-provisioning-tutorial.md) | ● | ● |
| [Clarizen One](~/identity/saas-apps/clarizen-one-provisioning-tutorial.md) | ● | ● |
| [Cleanmail Swiss](~/identity/saas-apps/cleanmail-swiss-provisioning-tutorial.md) | ● |  |
| [Clebex](~/identity/saas-apps/clebex-provisioning-tutorial.md) | ● | ● |
| [Cloud Academy SSO](~/identity/saas-apps/cloud-academy-sso-provisioning-tutorial.md) | ● | ● |
| [Coda](~/identity/saas-apps/coda-provisioning-tutorial.md) | ● | ● |
| [Code42](~/identity/saas-apps/code42-provisioning-tutorial.md) | ● | ● |
| [Cofense Recipient Sync](~/identity/saas-apps/cofense-provision-tutorial.md) | ● |  |
| [Colloquial](~/identity/saas-apps/colloquial-provisioning-tutorial.md) | ● | ● |
| [Comeet Recruiting Software](~/identity/saas-apps/comeet-recruiting-software-provisioning-tutorial.md) | ● | ● |
| [Connecter](~/identity/saas-apps/connecter-provisioning-tutorial.md) | ● |  |
| [Contentful](~/identity/saas-apps/contentful-provisioning-tutorial.md) | ● | ● |
| [Concur](~/identity/saas-apps/concur-provisioning-tutorial.md) | ● | ● |
| [Cornerstone OnDemand](~/identity/saas-apps/cornerstone-ondemand-provisioning-tutorial.md) | ● | ● |
| [Cybozu](~/identity/saas-apps/cybozu-provisioning-tutorial.md) | ● | ● |
| [CybSafe](~/identity/saas-apps/cybsafe-provisioning-tutorial.md) | ● |  |
| [Dagster Cloud](~/identity/saas-apps/dagster-cloud-provisioning-tutorial.md) | ● | ● |
| [Datadog](~/identity/saas-apps/datadog-provisioning-tutorial.md) | ● | ● |
| [Documo](~/identity/saas-apps/documo-provisioning-tutorial.md) | ● | ● |
| [DocuSign](~/identity/saas-apps/docusign-provisioning-tutorial.md) | ● | ● |
| [Dropbox Business](~/identity/saas-apps/dropboxforbusiness-provisioning-tutorial.md) | ● | ● |
| [Dialpad](~/identity/saas-apps/dialpad-provisioning-tutorial.md) | ● |  |
| [Diffchecker](~/identity/saas-apps/diffchecker-provisioning-tutorial.md) | ● | ● |
| [DigiCert](~/identity/saas-apps/digicert-tutorial.md) | | ● |
| [Directprint.io](~/identity/saas-apps/directprint-io-provisioning-tutorial.md) | ● | ● |
| [Druva](~/identity/saas-apps/druva-provisioning-tutorial.md) | ● | ● |
| [Dynamic Signal](~/identity/saas-apps/dynamic-signal-provisioning-tutorial.md) | ● | ● |
| [Embed Signage](~/identity/saas-apps/embed-signage-provisioning-tutorial.md) | ● | ● |
| [Envoy](~/identity/saas-apps/envoy-provisioning-tutorial.md) | ● | ● |
| [Eletive](~/identity/saas-apps/eletive-provisioning-tutorial.md) | ● |  |
| [Elium](~/identity/saas-apps/elium-provisioning-tutorial.md) | ● | ● |
| [Exium](~/identity/saas-apps/exium-provisioning-tutorial.md) | ● | ● |
| [Evercate](~/identity/saas-apps/evercate-provisioning-tutorial.md) | ● |  |
| [Facebook Work Accounts](~/identity/saas-apps/facebook-work-accounts-provisioning-tutorial.md) | ● | ● |
| [Federated Directory](~/identity/saas-apps/federated-directory-provisioning-tutorial.md) | ● |  |
| [Figma](~/identity/saas-apps/figma-provisioning-tutorial.md) | ● | ● |
| [Flock](~/identity/saas-apps/flock-provisioning-tutorial.md) | ● | ● |
| [Foodee](~/identity/saas-apps/foodee-provisioning-tutorial.md) | ● | ● |
| [Forcepoint Cloud Security Gateway - User Authentication](~/identity/saas-apps/forcepoint-cloud-security-gateway-tutorial.md) | ● | ● |
| [Fortes Change Cloud](~/identity/saas-apps/fortes-change-cloud-provisioning-tutorial.md) | ● | ● |
| [Frankli.io](~/identity/saas-apps/frankli-io-provisioning-tutorial.md) | ● | |
| [Freshservice Provisioning](~/identity/saas-apps/freshservice-provisioning-tutorial.md) | ● | ● |
| [Funnel Leasing](~/identity/saas-apps/funnel-leasing-provisioning-tutorial.md) | ● | ● |
| [Fuze](~/identity/saas-apps/fuze-provisioning-tutorial.md) | ● | ● |
| [G Suite](~/identity/saas-apps/g-suite-provisioning-tutorial.md) | ● |  |
| [Genesys Cloud for Azure](~/identity/saas-apps/purecloud-by-genesys-provisioning-tutorial.md) | ● | ● |
| [getAbstract](~/identity/saas-apps/getabstract-provisioning-tutorial.md) | ● | ● |
| [GHAE](~/identity/saas-apps/ghae-provisioning-tutorial.md) | ● | ● |
| [GitHub](~/identity/saas-apps/github-provisioning-tutorial.md) | ● | ● |
| [GitHub AE](~/identity/saas-apps/github-ae-provisioning-tutorial.md) | ● | ● |
| [GitHub Enterprise Managed User](~/identity/saas-apps/github-enterprise-managed-user-provisioning-tutorial.md) | ● | ● |
| [GitHub Enterprise Managed User (OIDC)](~/identity/saas-apps/github-enterprise-managed-user-oidc-provisioning-tutorial.md) | ● | ● |
| [GoToMeeting](~/identity/saas-apps/citrixgotomeeting-provisioning-tutorial.md) | ● | ● |
| [Global Relay Identity Sync](~/identity/saas-apps/global-relay-identity-sync-provisioning-tutorial.md) | ● |  |
| [Gong](~/identity/saas-apps/gong-provisioning-tutorial.md) | ● |  |
| [GoLinks](~/identity/saas-apps/golinks-provisioning-tutorial.md) | ● | ● |
| [Grammarly](~/identity/saas-apps/grammarly-provisioning-tutorial.md) | ● | ● |
| [Group Talk](~/identity/saas-apps/grouptalk-provisioning-tutorial.md) | ● |  |
| [Gtmhub](~/identity/saas-apps/gtmhub-provisioning-tutorial.md) | ● |  |
| [H5mag](~/identity/saas-apps/h5mag-provisioning-tutorial.md) | ● |  |
| [Harness](~/identity/saas-apps/harness-provisioning-tutorial.md) | ● | ● |
| HCL Domino | ● |  |
| [Headspace](~/identity/saas-apps/headspace-provisioning-tutorial.md) | ● | ● |
| [HelloID](~/identity/saas-apps/helloid-provisioning-tutorial.md) | ● |  |
| [Holmes Cloud](~/identity/saas-apps/holmes-cloud-provisioning-tutorial.md) | ● |  |
| [Hootsuite](~/identity/saas-apps/hootsuite-provisioning-tutorial.md) | ● | ● |
| [Hoxhunt](~/identity/saas-apps/hoxhunt-provisioning-tutorial.md) | ● | ● |
| [Howspace](~/identity/saas-apps/howspace-provisioning-tutorial.md) | ● |  |
| [Humbol](~/identity/saas-apps/humbol-provisioning-tutorial.md) | ● |  |
| [Hypervault](~/identity/saas-apps/hypervault-provisioning-tutorial.md) | ● |  |
| IBM DB2 ([SQL connector](~/identity/app-provisioning/tutorial-ecma-sql-connector.md) ) | ● |  |
| IBM Tivoli Directory Server ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [Ideo](~/identity/saas-apps/ideo-provisioning-tutorial.md) | ● | ● |
| [Ideagen Cloud](~/identity/saas-apps/ideagen-cloud-provisioning-tutorial.md) | ● |  |
| [Infor CloudSuite](~/identity/saas-apps/infor-cloudsuite-provisioning-tutorial.md) | ● | ● |
| [InformaCast](~/identity/saas-apps/informacast-provisioning-tutorial.md) | ● | ● |
| [iPass SmartConnect](~/identity/saas-apps/ipass-smartconnect-provisioning-tutorial.md) | ● | ● |
| [Iris Intranet](~/identity/saas-apps/iris-intranet-provisioning-tutorial.md) | ● | ● |
| [Insight4GRC](~/identity/saas-apps/insight4grc-provisioning-tutorial.md) | ● | ● |
| [Insite LMS](~/identity/saas-apps/insite-lms-provisioning-tutorial.md) | ● |  |
| [introDus Pre and Onboarding Platform](~/identity/saas-apps/introdus-pre-and-onboarding-platform-provisioning-tutorial.md) | ● |  |
| [Invision](~/identity/saas-apps/invision-provisioning-tutorial.md) | ● | ● |
| [InviteDesk](~/identity/saas-apps/invitedesk-provisioning-tutorial.md) | ● |  |
| Isode directory server ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [Jive](~/identity/saas-apps/jive-provisioning-tutorial.md) | ● | ● |
| [Jostle](~/identity/saas-apps/jostle-provisioning-tutorial.md) | ● | ● |
| [Joyn FSM](~/identity/saas-apps/joyn-fsm-provisioning-tutorial.md) | ● |  |
| [Juno Journey](~/identity/saas-apps/juno-journey-provisioning-tutorial.md) | ● | ● |
| [Keeper Password Manager & Digital Vault](~/identity/saas-apps/keeper-password-manager-digitalvault-provisioning-tutorial.md) | ● | ● |
| [Keepabl](~/identity/saas-apps/keepabl-provisioning-tutorial.md) | ● | ● |
| [Kintone](~/identity/saas-apps/kintone-provisioning-tutorial.md) | ● | ● |
| [Kisi Phsyical Security](~/identity/saas-apps/kisi-physical-security-provisioning-tutorial.md) | ● | ● |
| [Klaxoon](~/identity/saas-apps/klaxoon-provisioning-tutorial.md) | ● | ● |
| [Klaxoon SAML](~/identity/saas-apps/klaxoon-saml-provisioning-tutorial.md) | ● | ● |
| [Kno2fy](~/identity/saas-apps/kno2fy-provisioning-tutorial.md) | ● | ● |
| [KnowBe4 Security Awareness Training](~/identity/saas-apps/knowbe4-security-awareness-training-provisioning-tutorial.md) | ● | ● |
| [Kpifire](~/identity/saas-apps/kpifire-provisioning-tutorial.md) | ● | ● |
| [KPN Grip](~/identity/saas-apps/kpn-grip-provisioning-tutorial.md) | ● | |
| [LanSchool Air](~/identity/saas-apps/lanschool-air-provisioning-tutorial.md) | ● | ● |
| [LawVu](~/identity/saas-apps/lawvu-provisioning-tutorial.md) | ● | ● |
| [LDAP](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [LimbleCMMS](~/identity/saas-apps/limblecmms-provisioning-tutorial.md) | ● |  |
| [LinkedIn Elevate](~/identity/saas-apps/linkedinelevate-provisioning-tutorial.md) | ● | ● |
| [LinkedIn Sales Navigator](~/identity/saas-apps/linkedinsalesnavigator-provisioning-tutorial.md) | ● | ● |
| [Litmos](~/identity/saas-apps/litmos-provisioning-tutorial.md) | ● | ● |
| [Lucid (All Products)](~/identity/saas-apps/lucid-all-products-provisioning-tutorial.md) | ● | ● |
| [Lucidchart](~/identity/saas-apps/lucidchart-provisioning-tutorial.md) | ● | ● |
| [LUSID](~/identity/saas-apps/LUSID-provisioning-tutorial.md) | ● | ● |
| [Leapsome](~/identity/saas-apps/leapsome-provisioning-tutorial.md) | ● | ● |
| [LogicGate](~/identity/saas-apps/logicgate-provisioning-tutorial.md) | ● |  |
| [Looop](~/identity/saas-apps/looop-provisioning-tutorial.md) | ● |  |
| [LogMeIn](~/identity/saas-apps/logmein-provisioning-tutorial.md) | ● | ● |
| [M-Files](~/identity/saas-apps/m-files-provisioning-tutorial.md) | ● | ● |
| [Maptician](~/identity/saas-apps/maptician-provisioning-tutorial.md) | ● | ● |
| [Markit Procurement Service](~/identity/saas-apps/markit-procurement-service-provisioning-tutorial.md) | ● |  |
| [MediusFlow](~/identity/saas-apps/mediusflow-provisioning-tutorial.md) | ● |  |
| [MerchLogix](~/identity/saas-apps/merchlogix-provisioning-tutorial.md) | ● | ● |
| [Meta Networks Connector](~/identity/saas-apps/meta-networks-connector-provisioning-tutorial.md) | ● | ● |
| MicroFocus Novell eDirectory ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| Microsoft 365 | ● | ● |
| Microsoft Active Directory Domain Services | | ● |
| Microsoft Azure | ● | ● |
| [Microsoft Entra Domain Services](/entra/identity/domain-services/synchronization) | ● | ● |
| Microsoft Azure SQL ([SQL connector](~/identity/app-provisioning/tutorial-ecma-sql-connector.md) ) | ● |  |
| Microsoft Lightweight Directory Server (ADAM) ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| Microsoft SharePoint Server (SharePoint) | ● |  |
| Microsoft SQL Server ([SQL connector](~/identity/app-provisioning/tutorial-ecma-sql-connector.md) ) | ● |  |
| [Mixpanel](~/identity/saas-apps/mixpanel-provisioning-tutorial.md) | ● | ● |
| [Mindtickle](~/identity/saas-apps/mindtickle-provisioning-tutorial.md) | ● | ● |
| [Miro](~/identity/saas-apps/miro-provisioning-tutorial.md) | ● | ● |
| [Monday.com](~/identity/saas-apps/mondaycom-provisioning-tutorial.md) | ● | ● |
| [MongoDB Atlas](~/identity/saas-apps/mongodb-cloud-tutorial.md) |  | ● |
| [Moqups](~/identity/saas-apps/moqups-provisioning-tutorial.md) | ● | ● |
| [Mural Identity](~/identity/saas-apps/mural-identity-provisioning-tutorial.md) | ● | ● |
| [MX3 Diagnostics](~/identity/saas-apps/mx3-diagnostics-connector-provisioning-tutorial.md) | ● |  |
| [myPolicies](~/identity/saas-apps/mypolicies-provisioning-tutorial.md) | ● | ● |
| MySQL ([SQL connector](~/identity/app-provisioning/tutorial-ecma-sql-connector.md) ) | ● |  |
| NetIQ eDirectory ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [Netpresenter Next](~/identity/saas-apps/netpresenter-provisioning-tutorial.md) | ● |  |
| [Netskope User Authentication](~/identity/saas-apps/netskope-administrator-console-provisioning-tutorial.md) | ● | ● |
| [Netsparker Enterprise](~/identity/saas-apps/netsparker-enterprise-provisioning-tutorial.md) | ● | ● |
| [New Relic by Organization](~/identity/saas-apps/new-relic-by-organization-provisioning-tutorial.md) | ● | ● |
| [NordPass](~/identity/saas-apps/nordpass-provisioning-tutorial.md) | ● | ● |
| [Notion](~/identity/saas-apps/notion-provisioning-tutorial.md) | ● | ● |
| Novell eDirectory ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [Office Space Software](~/identity/saas-apps/officespace-software-provisioning-tutorial.md) | ● | ● |
| [Olfeo SAAS](~/identity/saas-apps/olfeo-saas-provisioning-tutorial.md) | ● | ● |
| [Oneflow](~/identity/saas-apps/oneflow-provisioning-tutorial.md) | ● | ● |
| Open DJ ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| Open DS ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [OpenForms](~/identity/saas-apps/openforms-provisioning-tutorial.md) | ● |  |
| [OpenLDAP](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [OpenText Directory Services](~/identity/saas-apps/open-text-directory-services-provisioning-tutorial.md) | ● | ● |
| [Oracle Cloud Infrastructure Console](~/identity/saas-apps/oracle-cloud-infrastructure-console-provisioning-tutorial.md) | ● | ● |
| Oracle Database ([SQL connector](~/identity/app-provisioning/tutorial-ecma-sql-connector.md) ) | ● |  |
| Oracle E-Business Suite | ● | ● |
| [Oracle Fusion ERP](~/identity/saas-apps/oracle-fusion-erp-provisioning-tutorial.md) | ● | ● |
| [O'Reilly Learning Platform](~/identity/saas-apps/oreilly-learning-platform-provisioning-tutorial.md) | ● | ● |
| Oracle Internet Directory | ● |  |
| Oracle PeopleSoft ERP | ● | ● |
| Oracle SunONE Directory Server ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [PagerDuty](~/identity/saas-apps/pagerduty-tutorial.md) |  | ● |
| [Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service](~/identity/saas-apps/palo-alto-networks-cloud-identity-engine-provisioning-tutorial.md) | ● | ● |
| [Palo Alto Networks SCIM Connector](~/identity/saas-apps/palo-alto-networks-scim-connector-provisioning-tutorial.md) | ● | ● |
| [PaperCut Cloud Print Management](~/identity/saas-apps/papercut-cloud-print-management-provisioning-tutorial.md) | ● |  |
| [Parsable](~/identity/saas-apps/parsable-provisioning-tutorial.md) | ● |  |
| [Peripass](~/identity/saas-apps/peripass-provisioning-tutorial.md) | ● |  |
| [Pingboard](~/identity/saas-apps/pingboard-provisioning-tutorial.md) | ● | ● |
| [Plandisc](~/identity/saas-apps/plandisc-provisioning-tutorial.md) | ● |  |
| [Playvox](~/identity/saas-apps/playvox-provisioning-tutorial.md) | ● |  |
| [Postman](~/identity/saas-apps/postman-provisioning-tutorial.md) | ● | ● |
| [Preciate](~/identity/saas-apps/preciate-provisioning-tutorial.md) | ● |  |
| [PrinterLogic SaaS](~/identity/saas-apps/printer-logic-saas-provisioning-tutorial.md) | ● | ● |
| [Priority Matrix](~/identity/saas-apps/priority-matrix-provisioning-tutorial.md) | ● |  |
| [ProdPad](~/identity/saas-apps/prodpad-provisioning-tutorial.md) | ● | ● |
| [Promapp](~/identity/saas-apps/promapp-provisioning-tutorial.md) | ● |  |
| [Proxyclick](~/identity/saas-apps/proxyclick-provisioning-tutorial.md) | ● | ● |
| [Peakon](~/identity/saas-apps/peakon-provisioning-tutorial.md) | ● | ● |
| [Proware](~/identity/saas-apps/proware-provisioning-tutorial.md) | ● | ● |
| RadiantOne Virtual Directory Server (VDS) ([LDAP connector](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) ) | ● |  |
| [Real Links](~/identity/saas-apps/real-links-provisioning-tutorial.md) | ● | ● |
| [Recnice](~/identity/saas-apps/recnice-provisioning-tutorial.md) | ● |  |
| [Reward Gateway](~/identity/saas-apps/reward-gateway-provisioning-tutorial.md) | ● | ● |
| [RFPIO](~/identity/saas-apps/rfpio-provisioning-tutorial.md) | ● | ● |
| [Rhombus Systems](~/identity/saas-apps/rhombus-systems-provisioning-tutorial.md) | ● | ● |
| [Ring Central](~/identity/saas-apps/ringcentral-provisioning-tutorial.md) | ● | ● |
| [Robin](~/identity/saas-apps/robin-provisioning-tutorial.md) | ● | ● |
| [Rollbar](~/identity/saas-apps/rollbar-provisioning-tutorial.md) | ● | ● |
| [Rouse Sales](~/identity/saas-apps/rouse-sales-provisioning-tutorial.md) | ● |  |
| [Salesforce](~/identity/saas-apps/salesforce-provisioning-tutorial.md) | ● | ● |
| [SafeGuard Cyber](~/identity/saas-apps/safeguard-cyber-provisioning-tutorial.md) | ● | ● |
| [Salesforce Sandbox](~/identity/saas-apps/salesforce-sandbox-provisioning-tutorial.md) | ● | ● |
| [Samanage](~/identity/saas-apps/samanage-provisioning-tutorial.md) | ● | ● |
| SAML-based apps | | ●  |
| [SAP Analytics Cloud](~/identity/saas-apps/sap-analytics-cloud-provisioning-tutorial.md) | ● | ● |
| [SAP Cloud Platform](~/identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md) | ● | ● |
| [SAP R/3 and ERP](~/identity/app-provisioning/on-premises-sap-connector-configure.md) | ● |  |
| [SAP HANA](~/identity/saas-apps/saphana-tutorial.md) | ● | ● |
| [SAP SuccessFactors to Active Directory](~/identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md) | ● | ● |
| [SAP SuccessFactors to Microsoft Entra ID](~/identity/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md) | ● | ● |
| [SAP SuccessFactors Writeback](~/identity/saas-apps/sap-successfactors-writeback-tutorial.md) | ● | ● |
| [SchoolStream ASA](~/identity/saas-apps/schoolstream-asa-provisioning-tutorial.md) | ● | ● |
| [SCIM-based apps in the cloud](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md) | ● |  |
| [SCIM-based apps on-premises](~/identity/app-provisioning/on-premises-scim-provisioning.md) | ● |  |
| [ScreenSteps](~/identity/saas-apps/screensteps-provisioning-tutorial.md) | ● | ● |
| [Secure Deliver](~/identity/saas-apps/secure-deliver-provisioning-tutorial.md) | ● | ● |
| [SecureLogin](~/identity/saas-apps/secure-login-provisioning-tutorial.md) | ● |  |
| [Sentry](~/identity/saas-apps/sentry-provisioning-tutorial.md) | ● | ● |
| [ServiceNow](~/identity/saas-apps/servicenow-provisioning-tutorial.md) | ● | ● |
| [Segment](~/identity/saas-apps/segment-provisioning-tutorial.md) | ● | ● |
| [Shopify Plus](~/identity/saas-apps/shopify-plus-provisioning-tutorial.md) | ● | ● |
| [Sigma Computing](~/identity/saas-apps/sigma-computing-provisioning-tutorial.md) | ● | ● |
| [Signagelive](~/identity/saas-apps/signagelive-provisioning-tutorial.md) | ● | ● |
| [Slack](~/identity/saas-apps/slack-provisioning-tutorial.md) | ● | ● |
| [Smartfile](~/identity/saas-apps/smartfile-provisioning-tutorial.md) | ● | ● |
| [Smartsheet](~/identity/saas-apps/smartsheet-provisioning-tutorial.md) | ● |  |
| [Smallstep SSH](~/identity/saas-apps/smallstep-ssh-provisioning-tutorial.md) | ● |  |
| [Snowflake](~/identity/saas-apps/snowflake-provisioning-tutorial.md) | ● | ● |
| [Soloinsight - CloudGate SSO](~/identity/saas-apps/soloinsight-cloudgate-sso-provisioning-tutorial.md) | ● | ● |
| [SoSafe](~/identity/saas-apps/sosafe-provisioning-tutorial.md) | ● | ● |
| [SpaceIQ](~/identity/saas-apps/spaceiq-provisioning-tutorial.md) | ● | ● |
| [Splashtop](~/identity/saas-apps/splashtop-provisioning-tutorial.md) | ● | ● |
| [StarLeaf](~/identity/saas-apps/starleaf-provisioning-tutorial.md) | ● |  |
| [Storegate](~/identity/saas-apps/storegate-provisioning-tutorial.md) | ● |  |
| [SurveyMonkey Enterprise](~/identity/saas-apps/surveymonkey-enterprise-provisioning-tutorial.md) | ● | ● |
| [Swit](~/identity/saas-apps/swit-provisioning-tutorial.md) | ● | ● |
| [Symantec Web Security Service (WSS)](~/identity/saas-apps/symantec-web-security-service.md) | ● | ● |
| [Tableau Cloud](~/identity/saas-apps/tableau-online-provisioning-tutorial.md) | ● | ● |
| [Tailscale](~/identity/saas-apps/tailscale-provisioning-tutorial.md) | ● |  |
| [Talentech](~/identity/saas-apps/talentech-provisioning-tutorial.md) | ● |  |
| [Tanium SSO](~/identity/saas-apps/tanium-sso-provisioning-tutorial.md) | ● | ● |
| [Tap App Security](~/identity/saas-apps/tap-app-security-provisioning-tutorial.md) | ● | ● |
| [Taskize Connect](~/identity/saas-apps/taskize-connect-provisioning-tutorial.md) | ● | ● |
| [Teamgo](~/identity/saas-apps/teamgo-provisioning-tutorial.md) | ● | ● |
| [TeamViewer](~/identity/saas-apps/teamviewer-provisioning-tutorial.md) | ● | ● |
| [TerraTrue](~/identity/saas-apps/terratrue-provisioning-tutorial.md) | ● | ● |
| [ThousandEyes](~/identity/saas-apps/thousandeyes-provisioning-tutorial.md) | ● | ● |
| [Tic-Tac Mobile](~/identity/saas-apps/tic-tac-mobile-provisioning-tutorial.md) | ● |  |
| [TimeClock 365](~/identity/saas-apps/timeclock-365-provisioning-tutorial.md) | ● | ● |
| [TimeClock 365 SAML](~/identity/saas-apps/timeclock-365-saml-provisioning-tutorial.md) | ● | ● |
| [Templafy SAML2](~/identity/saas-apps/templafy-saml-2-provisioning-tutorial.md) | ● | ● |
| [Templafy OpenID Connect](~/identity/saas-apps/templafy-openid-connect-provisioning-tutorial.md) | ● | ● |
| [TheOrgWiki](~/identity/saas-apps/theorgwiki-provisioning-tutorial.md) | ● |  |
| [Thrive LXP](~/identity/saas-apps/thrive-lxp-provisioning-tutorial.md) | ● | ● |
| [Torii](~/identity/saas-apps/torii-provisioning-tutorial.md) | ● | ● |
| [TravelPerk](~/identity/saas-apps/travelperk-provisioning-tutorial.md) | ● | ● |
| [Tribeloo](~/identity/saas-apps/tribeloo-provisioning-tutorial.md) | ● | ● |
| [Twingate](~/identity/saas-apps/twingate-provisioning-tutorial.md) | ● |  |
| [Uber](~/identity/saas-apps/uber-provisioning-tutorial.md) | ● |  |
| [UNIFI](~/identity/saas-apps/unifi-provisioning-tutorial.md) | ● | ● |
| [uniFlow Online](~/identity/saas-apps/uniflow-online-provisioning-tutorial.md) | ● | ● |
| [uni-tel A/S](~/identity/saas-apps/uni-tel-as-provisioning-tutorial.md) | ● |  |
| [Vault Platform](~/identity/saas-apps/vault-platform-provisioning-tutorial.md) | ● | ● |
| [Vbrick Rev Cloud](~/identity/saas-apps/vbrick-rev-cloud-provisioning-tutorial.md) | ● | ● |
| [V-Client](~/identity/saas-apps/v-client-provisioning-tutorial.md) | ● | ● |
| [Velpic](~/identity/saas-apps/velpic-provisioning-tutorial.md) | ● | ● |
| [Visibly](~/identity/saas-apps/visibly-provisioning-tutorial.md) | ● | ● |
| [Visitly](~/identity/saas-apps/visitly-provisioning-tutorial.md) | ● | ● |
| [VMware](~/identity/saas-apps/vmware-identity-service-provisioning-tutorial.md) | ● | ● |
| [Vonage](~/identity/saas-apps/vonage-provisioning-tutorial.md) | ● | ● |
| [WATS](~/identity/saas-apps/wats-provisioning-tutorial.md) | ● |  |
| [Webroot Security Awareness Training](~/identity/saas-apps/webroot-security-awareness-training-provisioning-tutorial.md) | ● |  |
| [WEDO](~/identity/saas-apps/wedo-provisioning-tutorial.md) | ● | ● |
| [Whimsical](~/identity/saas-apps/whimsical-provisioning-tutorial.md) | ● | ● |
| [Workday to Active Directory](~/identity/saas-apps/workday-inbound-tutorial.md) | ● | ● |
| [Workday to Microsoft Entra ID](~/identity/saas-apps/workday-inbound-cloud-only-tutorial.md) | ● | ● |
| [Workday Writeback](~/identity/saas-apps/workday-writeback-tutorial.md) | ● | ● |
| [Workteam](~/identity/saas-apps/workteam-provisioning-tutorial.md) | ● | ● |
| [Workplace by Facebook](~/identity/saas-apps/workplace-by-facebook-provisioning-tutorial.md) | ● | ● |
| [Workgrid](~/identity/saas-apps/workgrid-provisioning-tutorial.md) | ● | ● |
| [Wrike](~/identity/saas-apps/wrike-provisioning-tutorial.md) | ● | ● |
| [Xledger](~/identity/saas-apps/xledger-provisioning-tutorial.md) | ● |  |
| [XM Fax and XM SendSecure](~/identity/saas-apps/xm-fax-and-xm-send-secure-provisioning-tutorial.md) | ● | ● |
| [Yellowbox](~/identity/saas-apps/yellowbox-provisioning-tutorial.md) | ● |  |
| [Zapier](~/identity/saas-apps/zapier-provisioning-tutorial.md) | ● |  |
| [Zendesk](~/identity/saas-apps/zendesk-provisioning-tutorial.md) | ● | ● |
| [Zenya](~/identity/saas-apps/zenya-provisioning-tutorial.md) | ● | ● |
| [Zero](~/identity/saas-apps/zero-provisioning-tutorial.md) | ● | ● |
| [Zip](~/identity/saas-apps/zip-provisioning-tutorial.md) | ● | ● |
| [Zoho One](~/identity/saas-apps/zoho-one-provisioning-tutorial.md) | ● | ● |
| [Zoom](~/identity/saas-apps/zoom-provisioning-tutorial.md) | ● | ● |
| [Zscaler](~/identity/saas-apps/zscaler-provisioning-tutorial.md) | ● | ● |
| [Zscaler Beta](~/identity/saas-apps/zscaler-beta-provisioning-tutorial.md) | ● | ● |
| [Zscaler One](~/identity/saas-apps/zscaler-one-provisioning-tutorial.md) | ● | ● |
| [Zscaler Private Access](~/identity/saas-apps/zscaler-private-access-provisioning-tutorial.md) | ● | ● |
| [Zscaler Two](~/identity/saas-apps/zscaler-two-provisioning-tutorial.md) | ● | ● |
| [Zscaler Three](~/identity/saas-apps/zscaler-three-provisioning-tutorial.md) | ● | ● |
| [Zscaler ZSCloud](~/identity/saas-apps/zscaler-zscloud-provisioning-tutorial.md) | ● | ● |

## Partner driven integrations
There is also a healthy partner ecosystem, further expanding the breadth and depth of integrations available with Microsoft Entra ID Governance. Explore the [partner integrations](~/identity/app-provisioning/partner-driven-integrations.md) available, including connectors for:
* Epic
* Cerner
* IBM RACF
* IBM i (AS/400)
* Aurion People & Payroll

## Next steps

To learn more about application provisioning, see [What is application provisioning](~/identity/app-provisioning/user-provisioning.md).

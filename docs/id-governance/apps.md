---
title: Microsoft Entra ID Governance integrations
description: This page provides an overview of the Microsoft Entra ID Governance integrations available to automate provisioning and governance controls.
author: billmath
manager: dougeby
ms.service: entra-id-governance
ms.topic: overview
ms.date: 07/18/2025
ms.author: billmath
ms.reviewer: amycolannino
---

# Microsoft Entra ID Governance integrations

[Microsoft Entra ID Governance](identity-governance-applications-prepare.md) allows you to balance your organization's need for security and employee productivity with the right processes and visibility. This page provides an overview of the hundreds of Microsoft Entra ID Governance integrations available. These application integrations are used to automate [identity lifecycle management](scenarios/govern-the-employee-lifecycle.md) and implement governance controls across your organization. Through these rich integrations, you can automate providing users [access to applications](entitlement-management-overview.md), perform [periodic reviews](access-reviews-overview.md) of who has access to an application, and secure them with capabilities such as multifactor authentication. 

## Featured integrations

| Category | Application |
| :--- | :--- |
| HR | [SuccessFactors - User Provisioning](../identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md) |
| HR | [Workday - User Provisioning](../identity/saas-apps/workday-inbound-cloud-only-tutorial.md)|
| HR | [API-driven connector from any HR source](../identity/app-provisioning/inbound-provisioning-api-concepts.md)<br>[Rippling HCM integration with Microsoft Entra ID/Active Directory](../identity/saas-apps/rippling-hcm-microsoft-entra-id-integration-tutorial.md)<br>[Oracle HCM API-driven connector](../identity/saas-apps/oracle-hcm-provisioning-tutorial.md)<br>[Darwinbox to Microsoft Entra ID](../identity/saas-apps/darwinbox-entra-integration-tutorial.md)<br>[SAP HCM to Microsoft Entra ID](../identity/saas-apps/sap-hcm-microsoft-entra-identity-provisioning.md) |
|[LDAP directory](../identity/app-provisioning/on-premises-ldap-connector-configure.md)| OpenLDAP<br>Microsoft Active Directory Lightweight Directory Services<br>389 Directory Server<br>Apache Directory Server<br>IBM Tivoli DS<br>Isode Directory<br>NetIQ eDirectory<br>Novell eDirectory<br>Open DJ<br>Open DS<br>Oracle (previously Sun ONE) Directory Server Enterprise Edition<br>RadiantOne Virtual Directory Server (VDS) |
| [SQL database](../identity/app-provisioning/tutorial-ecma-sql-connector.md)| Microsoft SQL Server and Azure SQL<br>IBM DB2 10.x<br>IBM DB2 9.x<br>Oracle 10g and 11g<br>Oracle 12c and 18c<br>MySQL 5.x|
| Cloud platform| [AWS IAM Identity Center](../identity/saas-apps/aws-single-sign-on-provisioning-tutorial.md) |
| Cloud platform| [Google Cloud Platform - User Provisioning](../identity/saas-apps/g-suite-provisioning-tutorial.md) |
| Business applications|SAP applications integrated with [SAP Cloud Identity Services](../identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md) |
| Business applications|Applications on SAP BTP [using role collections](https://community.sap.com/t5/technology-blogs-by-members/identity-and-access-management-with-microsoft-entra-part-i-managing-access/ba-p/13873276) |
| CRM| [Salesforce - User Provisioning](../identity/saas-apps/salesforce-provisioning-tutorial.md) |
| ITSM| [ServiceNow](../identity/saas-apps/servicenow-provisioning-tutorial.md)|


<a name='entra-identity-governance-integrations'></a>

## Microsoft Entra ID Governance integrations
The list below provides key integrations between Microsoft Entra ID Governance and various applications, including both provisioning and SSO integrations. For a full list of applications that Microsoft Entra ID integrates with specifically for SSO, see [here](../identity/saas-apps/tutorial-list.md). 

Microsoft Entra ID Governance can be integrated with many other applications, using standards such as OpenID Connect, SAML, SCIM, SQL and LDAP. If you're using a SaaS application which isn't listed, then [ask the SaaS vendor to onboard](../identity/enterprise-apps/v2-howto-app-gallery-listing.md).  For integration with other applications, see [integrating applications with Microsoft Entra ID](identity-governance-applications-integrate.md).

| Application | Automated provisioning | Single Sign On (SSO)|
| :--- | :-:  | :-: |
| [10,000 ft Plans](../identity/saas-apps/10000ftplans-tutorial.md) |  | ● |
| [15five](../identity/saas-apps/15five-provisioning-tutorial.md) | ● | ● |
| [123FormBuilder](../identity/saas-apps/123formbuilder-tutorial.md) |  | ● |
| [389 directory server (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [4me](../identity/saas-apps/4me-provisioning-tutorial.md) | ● | ●|
| [8x8](../identity/saas-apps/8x8-provisioning-tutorial.md) | ● | ● |
| [A Cloud Guru](../identity/saas-apps/a-cloud-guru-tutorial.md) |  | ● |
| [ABBYY FlexiCapture Cloud](../identity/saas-apps/abbyy-flexicapture-cloud-tutorial.md) |  | ● |
| [Abintegro](../identity/saas-apps/abintegro-tutorial.md) |  | ● |
| [Academy Attendance](../identity/saas-apps/academy-attendance-tutorial.md) |  | ● |
| [Acadia](../identity/saas-apps/acadia-tutorial.md) |  | ● |
| [Accenture Academy](../identity/saas-apps/accenture-academy-tutorial.md) |  | ● |
| [Acoustic Connect](../identity/saas-apps/acoustic-connect-tutorial.md) |  | ● |
| [Acunetix 360](../identity/saas-apps/acunetix-360-provisioning-tutorial.md) | ● | ● |
| [Adaptive Shield](../identity/saas-apps/adaptive-shield-tutorial.md) |  | ● |
| [Adobe Captivate Prime](../identity/saas-apps/adobecaptivateprime-tutorial.md) |  | ● |
| [Adobe Creative Cloud](../identity/saas-apps/adobe-creative-cloud-tutorial.md) |  | ● |
| [Adobe Experience Manager](../identity/saas-apps/adobeexperiencemanager-tutorial.md) |  | ● |
| [Adobe Identity Management (OIDC)](../identity/saas-apps/adobe-identity-management-provisioning-oidc-tutorial.md) | ● | ● |
| [Adobe Identity Management (SAML)](../identity/saas-apps/adobe-identity-management-provisioning-saml-tutorial.md) | ● | ● |
| [Adobe Sign](../identity/saas-apps/adobe-echosign-tutorial.md) |  | ● |
| [Adoddle cSaas Platform](../identity/saas-apps/adoddle-csaas-platform-tutorial.md) |  | ● |
| [Agiloft Contract Management Suite](../identity/saas-apps/agiloft-tutorial.md) |  | ● |
| [Aha!](../identity/saas-apps/aha-tutorial.md) |  | ● |
| [Airbase](../identity/saas-apps/airbase-provisioning-tutorial.md) | ● | ● |
| [Airstack](../identity/saas-apps/airstack-provisioning-tutorial.md) | ● |  |
| [Airtable](../identity/saas-apps/airtable-provisioning-tutorial.md) | ● | ● |
| [Akamai Enterprise Application Access](../identity/saas-apps/akamai-enterprise-application-access-provisioning-tutorial.md) | ● | ● |
| [Alation Data Catalog](../identity/saas-apps/alation-data-catalog-tutorial.md) |  | ● |
| [Albert](../identity/saas-apps/albert-provisioning-tutorial.md) | ● |  |
| [Alchemer](../identity/saas-apps/alchemer-tutorial.md) |  | ● |
| [AlertMedia](../identity/saas-apps/alertmedia-provisioning-tutorial.md) | ● | ● |
| [AlexisHR](../identity/saas-apps/alexishr-provisioning-tutorial.md) | ● | ● |
| [Alinto Protect (renamed Cleanmail)](../identity/saas-apps/alinto-protect-provisioning-tutorial.md) | ● | |
| [Allbound SSO](../identity/saas-apps/allbound-sso-tutorial.md) |  | ● |
| [Allocadia](../identity/saas-apps/allocadia-tutorial.md) |  | ● |
| [Ally.io](../identity/saas-apps/ally-tutorial.md) |  | ● |
| [Alohi](../identity/saas-apps/alohi-provisioning-tutorial.md) | ● | ● |
| [Altamira HRM](../identity/saas-apps/altamira-hrm-tutorial.md) |  | ● |
| [Alvao](../identity/saas-apps/alvao-provisioning-tutorial.md) | ● |  |
| [Amazon Business](../identity/saas-apps/amazon-business-provisioning-tutorial.md) | ● | ● |
| [Amazon Managed Grafana](../identity/saas-apps/amazon-managed-grafana-tutorial.md) |  | ● |
| [Amazon Web Services (AWS) - Role Provisioning](../identity/saas-apps/amazon-web-service-tutorial.md) | ● | ● |
| [Amplitude](../identity/saas-apps/amplitude-tutorial.md) |  | ● |
| [ANAQUA](../identity/saas-apps/anaqua-tutorial.md) |  | ● |
| [Andromeda](../identity/saas-apps/andromedascm-tutorial.md) |  | ● |
| [Apache Directory Server (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [Apex Portal](../identity/saas-apps/apexportal-tutorial.md) |  | ● |
| [Appaegis Isolation Access Cloud](../identity/saas-apps/appaegis-isolation-access-cloud-provisioning-tutorial.md) | ● | ● |
| [AppBlade](../identity/saas-apps/appblade-tutorial.md) |  | ● |
| [AppDynamics](../identity/saas-apps/appdynamics-tutorial.md) |  | ● |
| [Appian](../identity/saas-apps/appian-tutorial.md) |  | ● |
| [Appinux](../identity/saas-apps/appinux-tutorial.md) |  | ● |
| [Apple Business Manager](../identity/saas-apps/apple-business-manager-provision-tutorial.md) | ● |  |
| [Apple School Manager](../identity/saas-apps/apple-school-manager-provision-tutorial.md) | ● |  |
| [Applitools Eyes](../identity/saas-apps/applitools-eyes-tutorial.md) |  | ● |
| [AppNeta Performance Monitor](../identity/saas-apps/appneta-tutorial.md) |  | ● |
| [ARC Facilities](../identity/saas-apps/arc-facilities-tutorial.md) |  | ● |
| [Arc Publishing - SSO](../identity/saas-apps/arc-tutorial.md) |  | ● |
| [ArcGIS Enterprise](../identity/saas-apps/arcgisenterprise-tutorial.md) |  | ● |
| [Archie](../identity/saas-apps/archie-tutorial.md) |  | ● |
| [Ardoq](../identity/saas-apps/ardoq-provisioning-tutorial.md) | ● | ● |
| [ARES for Enterprise](../identity/saas-apps/ares-for-enterprise-tutorial.md) |  | ● |
| [Aruba User Experience Insight](../identity/saas-apps/aruba-user-experience-insight-tutorial.md) |  | ● |
| [Asana](../identity/saas-apps/asana-provisioning-tutorial.md) | ● | ● |
| [AskSpoke](../identity/saas-apps/askspoke-provisioning-tutorial.md) | ● | ● |
| [Asset Bank](../identity/saas-apps/assetbank-tutorial.md) |  | ● |
| [Asset Planner](../identity/saas-apps/asset-planner-tutorial.md) |  | ● |
| [AssetSonar](../identity/saas-apps/assetsonar-tutorial.md) |  | ● |
| [Astra Schedule](../identity/saas-apps/astra-schedule-tutorial.md) |  | ● |
| [Astro](../identity/saas-apps/astro-provisioning-tutorial.md) | ● | ● |
| [Atea](../identity/saas-apps/atea-provisioning-tutorial.md) | ● |  |
| [Atlassian Cloud](../identity/saas-apps/atlassian-cloud-provisioning-tutorial.md) | ● | ● |
| [Atmos](../identity/saas-apps/atmos-provisioning-tutorial.md) | ● |  |
| [Atomic Learning](../identity/saas-apps/atomiclearning-tutorial.md) |  | ● |
| [ATP SpotLight and ChronicX](../identity/saas-apps/atp-spotlight-and-chronicx-tutorial.md) |  | ● |
| [AuditBoard](../identity/saas-apps/auditboard-provisioning-tutorial.md) | ● |  |
| [Authomize](../identity/saas-apps/authomize-tutorial.md) |  | ● |
| [Autodesk SSO](../identity/saas-apps/autodesk-sso-provisioning-tutorial.md) | ● | ● |
| [AwardSpring](../identity/saas-apps/awardspring-tutorial.md) |  | ● |
| [AWS ClientVPN](../identity/saas-apps/aws-clientvpn-tutorial.md) |  | ● |
| [AWS IAM Identity Center](../identity/saas-apps/aws-single-sign-on-provisioning-tutorial.md) | ● | ● |
| [Axiad Cloud](../identity/saas-apps/axiad-cloud-provisioning-tutorial.md) | ● | ● |
| [Azure Databricks SCIM Connector](/azure/databricks/administration-guide/users-groups/scim/aad) | ● |  |
| [Balsamiq Wireframes](../identity/saas-apps/balsamiq-wireframes-tutorial.md) |  | ● |
| [BambooHR](../identity/saas-apps/bamboo-hr-tutorial.md) |  | ● |
| [Banyan Security Zero Trust Remote Access Platform](../identity/saas-apps/banyan-command-center-tutorial.md) |  | ● |
| [Bealink](../identity/saas-apps/bealink-tutorial.md) |  | ● |
| [Beekeeper Microsoft Entra Data Connector](../identity/saas-apps/beekeeper-azure-ad-data-connector-tutorial.md) |  | ● |
| [Benchling](../identity/saas-apps/benchling-tutorial.md) |  | ● |
| [BenQ IAM](../identity/saas-apps/benq-iam-provisioning-tutorial.md) | ● | ● |
| [Bentley - Automatic User Provisioning](../identity/saas-apps/bentley-automatic-user-provisioning-tutorial.md) | ● |  |
| [Better Stack](../identity/saas-apps/better-stack-provisioning-tutorial.md) | ● |  |
| [BeyondTrust Remote Support](../identity/saas-apps/bomgarremotesupport-tutorial.md) |  | ● |
| [BIC Cloud Design](../identity/saas-apps/bic-cloud-design-provisioning-tutorial.md) | ● | ● |
| [BigPanda](../identity/saas-apps/bigpanda-tutorial.md) |  | ● |
| [BIS](../identity/saas-apps/bis-provisioning-tutorial.md) | ● | ● |
| [BitaBIZ](../identity/saas-apps/bitabiz-provisioning-tutorial.md) | ● | ● |
| [Bitly](../identity/saas-apps/bitly-tutorial.md) |  | ● |
| [Bizagi Studio for Digital Process Automation](../identity/saas-apps/bizagi-studio-for-digital-process-automation-provisioning-tutorial.md) | ● | ● |
| [Blackboard Learn - Shibboleth](../identity/saas-apps/blackboard-learn-shibboleth-tutorial.md) |  | ● |
| [Blackboard Learn](../identity/saas-apps/blackboard-learn-tutorial.md) |  | ● |
| [BLDNG APP](../identity/saas-apps/bldng-app-provisioning-tutorial.md) | ● |  |
| [Blink](../identity/saas-apps/blink-provisioning-tutorial.md) | ● | ● |
| [Blinq](../identity/saas-apps/blinq-provisioning-tutorial.md) | ● |  |
| [Blockbax](../identity/saas-apps/blockbax-tutorial.md) |  | ● |
| [BlogIn](../identity/saas-apps/blogin-provisioning-tutorial.md) | ● | ● |
| [Blue Ocean Brain](../identity/saas-apps/blue-ocean-brain-tutorial.md) |  | ● |
| [Bonusly](../identity/saas-apps/bonusly-provisioning-tutorial.md) | ● | ● |
| [BorrowBox](../identity/saas-apps/borrowbox-tutorial.md) |  | ● |
| [Box](../identity/saas-apps/box-userprovisioning-tutorial.md) | ● | ● |
| [Boxcryptor](../identity/saas-apps/boxcryptor-provisioning-tutorial.md) | ● | ● |
| [Bpanda](../identity/saas-apps/bpanda-provisioning-tutorial.md) | ● |  |
| [BrainStorm Platform](../identity/saas-apps/brainstorm-platform-tutorial.md) |  | ● |
| [Brandfolder](../identity/saas-apps/brandfolder-tutorial.md) |  | ● |
| [Bright Pattern Omnichannel Contact Center](../identity/saas-apps/bright-pattern-omnichannel-contact-center-tutorial.md) |  | ● |
| [Brightidea](../identity/saas-apps/brightidea-tutorial.md) |  | ● |
| [Briq](../identity/saas-apps/briq-tutorial.md) |  | ● |
| [Britive](../identity/saas-apps/britive-provisioning-tutorial.md) | ● | ● |
| [Brivo Onair Identity Connector](../identity/saas-apps/brivo-onair-identity-connector-provisioning-tutorial.md) | ● |  |
| [Broadcom DX SaaS](../identity/saas-apps/broadcom-dx-saas-tutorial.md) |  | ● |
| [BrowserStack Single Sign-on](../identity/saas-apps/browserstack-single-sign-on-provisioning-tutorial.md) | ● | ● |
| [Bugsnag](../identity/saas-apps/bugsnag-tutorial.md) |  | ● |
| [BullseyeTDP](../identity/saas-apps/bullseyetdp-provisioning-tutorial.md) | ● | ● |
| [Burp Suite Enterprise Edition](../identity/saas-apps/burp-suite-enterprise-edition-tutorial.md) |  | ● |
| [Bustle B2B Transport Systems](../identity/saas-apps/bustle-b2b-transport-systems-provisioning-tutorial.md) | ● |  |
| [Bynder](../identity/saas-apps/bynder-tutorial.md) |  | ● |
| [C3M Cloud Control](../identity/saas-apps/c3m-cloud-control-tutorial.md) |  | ● |
| [Canva](../identity/saas-apps/canva-provisioning-tutorial.md) | ● | ● |
| [Canvas LMS](../identity/saas-apps/canvas-lms-tutorial.md) |  | ● |
| [Capriza Platform](../identity/saas-apps/capriza-tutorial.md) |  | ● |
| [Cato Networks Provisioning](../identity/saas-apps/cato-networks-provisioning-tutorial.md) | ● |  |
| [CBRE ServiceInsight](../identity/saas-apps/cbre-serviceinsight-tutorial.md) |  | ● |
| [CCH Tagetik](../identity/saas-apps/cch-tagetik-tutorial.md) |  | ● |
| [Cequence Application Security Platform](../identity/saas-apps/cequence-application-security-tutorial.md) |  | ● |
| [Cerby](../identity/saas-apps/cerby-provisioning-tutorial.md) | ● | ● |
| [Ceridian Dayforce HCM](../identity/saas-apps/ceridiandayforcehcm-tutorial.md) |  | ● |
| [Cerner Central](../identity/saas-apps/cernercentral-provisioning-tutorial.md) | ● | ● |
| [Certify](../identity/saas-apps/certify-tutorial.md) |  | ● |
| [Chaos](../identity/saas-apps/chaos-provisioning-tutorial.md) | ● |  |
| [Chatwork](../identity/saas-apps/chatwork-provisioning-tutorial.md) | ● | ● |
| [Check Point Infinity Portal](../identity/saas-apps/checkpoint-infinity-portal-tutorial.md) |  | ● |
| [CheckProof](../identity/saas-apps/checkproof-provisioning-tutorial.md) | ● | ● |
| [Cheetah For Benelux](../identity/saas-apps/cheetah-for-benelux-tutorial.md) |  | ● |
| [Chengliye Smart SMS Platform](../identity/saas-apps/chengliye-smart-sms-platform-tutorial.md) |  | ● |
| [ChronicX®](../identity/saas-apps/chronicx-tutorial.md) |  | ● |
| [Chronus SAML](../identity/saas-apps/chronus-saml-tutorial.md) |  | ● |
| [Cinode](../identity/saas-apps/cinode-provisioning-tutorial.md) | ● |  |
| [Cisco Cloud](../identity/saas-apps/ciscocloud-tutorial.md) |  | ● |
| [Cisco Expressway](../identity/saas-apps/cisco-expressway-tutorial.md) |  | ● |
| [Cisco Intersight](../identity/saas-apps/cisco-intersight-tutorial.md) |  | ● |
| [Cisco Secure Firewall - Secure Client](../identity/saas-apps/cisco-secure-firewall-secure-client.md) |  | ● |
| [Cisco Umbrella](../identity/saas-apps/cisco-umbrella-tutorial.md) |  | ● |
| [Cisco Unified Communications Manager](../identity/saas-apps/cisco-unified-communications-manager-tutorial.md) |  | ● |
| [Cisco Unity Connection](../identity/saas-apps/cisco-unity-connection-tutorial.md) |  | ● |
| [Cisco User Management for Secure Access](../identity/saas-apps/cisco-user-management-for-secure-access-provisioning-tutorial.md) | ● | ● |
| [Cisco Webex Meetings](../identity/saas-apps/cisco-webex-tutorial.md) |  | ● |
| [Cisco Webex](../identity/saas-apps/cisco-webex-provisioning-tutorial.md) | ● | ● |
| [Citrix ADC SAML Connector for Microsoft Entra ID](../identity/saas-apps/citrix-netscaler-tutorial.md) |  | ● |
| [ClarivateWOS](../identity/saas-apps/clarivatewos-tutorial.md) |  | ● |
| [Clarizen One](../identity/saas-apps/clarizen-one-provisioning-tutorial.md) | ● | ● |
| [Claromentis](../identity/saas-apps/claromentis-tutorial.md) |  | ● |
| [Cleanmail Swiss](../identity/saas-apps/cleanmail-swiss-provisioning-tutorial.md) | ● |  |
| [Clebex](../identity/saas-apps/clebex-provisioning-tutorial.md) | ● | ● |
| [Cloud Service PICCO](../identity/saas-apps/cloud-service-picco-tutorial.md) |  | ● |
| [CMD+CTRL Base Camp](../identity/saas-apps/cmd-ctrl-base-camp-tutorial.md) |  | ● |
| [Coda](../identity/saas-apps/coda-provisioning-tutorial.md) | ● | ● |
| [Code42](../identity/saas-apps/code42-provisioning-tutorial.md) | ● | ● |
| [Cofense Recipient Sync](../identity/saas-apps/cofense-provision-tutorial.md) | ● |  |
| [Coggle](../identity/saas-apps/coggle-tutorial.md) |  | ● |
| [Cognidox](../identity/saas-apps/cognidox-tutorial.md) |  | ● |
| [Cognism](../identity/saas-apps/cognism-tutorial.md) |  | ● |
| [CoLab](../identity/saas-apps/colab-tutorial.md) |  | ● |
| [Collaborative Innovation](../identity/saas-apps/collaborativeinnovation-tutorial.md) |  | ● |
| [Collibra](../identity/saas-apps/collibra-tutorial.md) |  | ● |
| [Colloquial](../identity/saas-apps/colloquial-provisioning-tutorial.md) | ● | ● |
| [Comeet Recruiting Software](../identity/saas-apps/comeet-recruiting-software-provisioning-tutorial.md) | ● | ● |
| [Communifire](../identity/saas-apps/communifire-tutorial.md) |  | ● |
| [Community Spark](../identity/saas-apps/community-spark-tutorial.md) |  | ● |
| [Compliance Genie](../identity/saas-apps/compliance-genie-tutorial.md) |  | ● |
| [Condeco](../identity/saas-apps/condeco-tutorial.md) |  | ● |
| [Confirmit Horizons](../identity/saas-apps/confirmit-horizons-tutorial.md) |  | ● |
| [Connecter](../identity/saas-apps/connecter-provisioning-tutorial.md) | ● |  |
| [Contentful](../identity/saas-apps/contentful-provisioning-tutorial.md) | ● | ● |
| [Contentkalender](../identity/saas-apps/contentkalender-tutorial.md) |  | ● |
| [Contentsquare SSO](../identity/saas-apps/contentsquare-sso-tutorial.md) |  | ● |
| [Contentstack](../identity/saas-apps/contentstack-provisioning-tutorial.md) | ●  | ● |
| [Contrast Security](../identity/saas-apps/contrast-security-tutorial.md) |  | ● |
| [Convene](../identity/saas-apps/convene-tutorial.md) |  | ● |
| [Couchbase Capella - SSO](../identity/saas-apps/couchbase-capella-sso-tutorial.md) |  | ● |
| [Couchbase Server - SSO](../identity/saas-apps/couchbase-server-sso-tutorial.md) |  | ● |
| [Coupa Risk Assess](../identity/saas-apps/coupa-risk-assess-tutorial.md) |  | ● |
| [Coupa](../identity/saas-apps/coupa-tutorial.md) |  | ● |
| [courses.work](../identity/saas-apps/courseswork-tutorial.md) |  | ● |
| [Crayon](../identity/saas-apps/crayon-tutorial.md) |  | ● |
| [CultureHQ](../identity/saas-apps/culturehq-provisioning-tutorial.md) | ● | ● |
| [Curator](../identity/saas-apps/curator-tutorial.md) |  | ● |
| [Cybozu](../identity/saas-apps/cybozu-provisioning-tutorial.md) | ● | ● |
| [CybSafe](../identity/saas-apps/cybsafe-provisioning-tutorial.md) | ● |  |
| [Dagster Cloud](../identity/saas-apps/dagster-cloud-provisioning-tutorial.md) | ● | ● |
| [Databook](../identity/saas-apps/databook-tutorial.md) |  | ● |
| [DataCamp](../identity/saas-apps/datacamp-tutorial.md) |  | ● |
| [Datadog](../identity/saas-apps/datadog-provisioning-tutorial.md) | ● | ● |
| [Datava Enterprise Service Platform](../identity/saas-apps/datava-enterprise-service-platform-tutorial.md) |  | ● |
| [deBroome Brand Portal](../identity/saas-apps/debroome-brand-portal-tutorial.md) |  | ● |
| [Degreed](../identity/saas-apps/degreed-tutorial.md) |  | ● |
| [Delivery Solutions](../identity/saas-apps/delivery-solutions-tutorial.md) |  | ● |
| [Deputy](../identity/saas-apps/deputy-tutorial.md) |  | ● |
| [Descartes](../identity/saas-apps/descartes-tutorial.md) |  | ● |
| [Dialpad](../identity/saas-apps/dialpad-provisioning-tutorial.md) | ● |  |
| [Diffchecker](../identity/saas-apps/diffchecker-provisioning-tutorial.md) | ● | ● |
| [DigiCert](../identity/saas-apps/digicert-tutorial.md) | | ● |
| [Digital Pigeon](../identity/saas-apps/digital-pigeon-tutorial.md) |  | ● |
| [Directory Services Protector](../identity/saas-apps/directory-services-protector-tutorial.md) |  | ● |
| [Directory Services](../identity/saas-apps/directory-services-tutorial.md) |  | ● |
| [directprint.io Cloud Print Administration](../identity/saas-apps/directprint-io-cloud-print-administration-tutorial.md) |  | ● |
| [Directprint.io](../identity/saas-apps/directprint-io-provisioning-tutorial.md) | ● | ● |
| [Docker Business](../identity/saas-apps/docker-tutorial.md) |  | ● |
| [Documo](../identity/saas-apps/documo-provisioning-tutorial.md) | ● | ● |
| [DocuSign](../identity/saas-apps/docusign-provisioning-tutorial.md) | ● | ● |
| [Domo](../identity/saas-apps/domo-tutorial.md) |  | ● |
| [Dotcom-Monitor](../identity/saas-apps/dotcom-monitor-tutorial.md) |  | ● |
| [Dovetale](../identity/saas-apps/dovetale-tutorial.md) |  | ● |
| [Dozuki](../identity/saas-apps/dozuki-tutorial.md) |  | ● |
| [Draup, Inc](../identity/saas-apps/draup-inc-tutorial.md) |  | ● |
| [Drawboard Projects](../identity/saas-apps/drawboard-projects-tutorial.md) |  | ● |
| [Drift](../identity/saas-apps/drift-tutorial.md) |  | ● |
| [Dropbox Business](../identity/saas-apps/dropboxforbusiness-provisioning-tutorial.md) | ● | ● |
| [Druva](../identity/saas-apps/druva-provisioning-tutorial.md) | ● | ● |
| [Dynamic Signal](../identity/saas-apps/dynamic-signal-provisioning-tutorial.md) | ● | ● |
| [Dynatrace](../identity/saas-apps/dynatrace-tutorial.md) |  | ● |
| [EAComposer](../identity/saas-apps/eacomposer-tutorial.md) |  | ● |
| [EasySSO for Bamboo](../identity/saas-apps/easysso-for-bamboo-tutorial.md) |  | ● |
| [EasySSO for Confluence](../identity/saas-apps/easysso-for-confluence-tutorial.md) |  | ● |
| [EasySSO for Jira](../identity/saas-apps/easysso-for-jira-tutorial.md) |  | ● |
| [EBSCO](../identity/saas-apps/ebsco-tutorial.md) |  | ● |
| [Eccentex AppBase for Azure](../identity/saas-apps/eccentex-appbase-for-azure-tutorial.md) |  | ● |
| [eCornell](../identity/saas-apps/ecornell-tutorial.md) |  | ● |
| [EduBrite LMS](../identity/saas-apps/edubrite-lms-tutorial.md) |  | ● |
| [edX for Business SAML Integration](../identity/saas-apps/edx-for-business-saml-integration-tutorial.md) |  | ● |
| [Egnyte](../identity/saas-apps/egnyte-provisioning-tutorial.md) | ● | ● |
| [Egress](../identity/saas-apps/egress-tutorial.md) |  | ● |
| [eKincare](../identity/saas-apps/ekincare-tutorial.md) |  | ● |
| [Eletive](../identity/saas-apps/eletive-provisioning-tutorial.md) | ● |  |
| [Elia](../identity/saas-apps/elia-provisioning-tutorial.md) | ● | ● |
| [Elium](../identity/saas-apps/elium-provisioning-tutorial.md) | ● | ● |
| [Embed Signage](../identity/saas-apps/embed-signage-provisioning-tutorial.md) | ● | ● |
| [Employee Advocacy by Sprout Social](../identity/saas-apps/bambubysproutsocial-tutorial.md) |  | ● |
| [Enterprise Advantage](../identity/saas-apps/enterprise-advantage-tutorial.md) |  | ● |
| [Envoy](../identity/saas-apps/envoy-provisioning-tutorial.md) | ● | ● |
| [Equifax Workforce Solutions](../identity/saas-apps/equifax-workforce-solutions-tutorial.md) |  | ● |
| [ETU Skillsims](../identity/saas-apps/etu-skillsims-tutorial.md) |  | ● |
| [Evercate](../identity/saas-apps/evercate-provisioning-tutorial.md) | ● |  |
| [Exium](../identity/saas-apps/exium-provisioning-tutorial.md) | ● | ● |
| [EZOfficeInventory](../identity/saas-apps/ezofficeinventory-tutorial.md) |  | ● |
| [EZRentOut](../identity/saas-apps/ezrentout-tutorial.md) |  | ● |
| [Facebook Work Accounts](../identity/saas-apps/facebook-work-accounts-provisioning-tutorial.md) | ● | ● |
| [FAX.PLUS](../identity/saas-apps/fax-plus-tutorial.md) |  | ● |
| [Federated Directory](../identity/saas-apps/federated-directory-provisioning-tutorial.md) | ● |  |
| [Fexa](../identity/saas-apps/fexa-tutorial.md) |  | ● |
| [Fidelity NetBenefits](../identity/saas-apps/fidelitynetbenefits-tutorial.md) |  | ● |
| [Fieldglass](../identity/saas-apps/fieldglass-tutorial.md) |  | ● |
| [Figma](../identity/saas-apps/figma-provisioning-tutorial.md) | ● | ● |
| [FileCloud](../identity/saas-apps/filecloud-tutorial.md) |  | ● |
| [FileOrbis](../identity/saas-apps/fileorbis-tutorial.md) |  | ● |
| [FilesAnywhere](../identity/saas-apps/filesanywhere-tutorial.md) |  | ● |
| [Finvari](../identity/saas-apps/finvari-tutorial.md) |  | ● |
| [FiscalNote](../identity/saas-apps/fiscalnote-tutorial.md) |  | ● |
| [Fivetran](../identity/saas-apps/fivetran-tutorial.md) |  | ● |
| [Flexera One](../identity/saas-apps/flexera-one-tutorial.md) |  | ● |
| [Flipsnack SAML](../identity/saas-apps/flipsnack-saml-tutorial.md) |  | ● |
| [Flock Safety](../identity/saas-apps/flock-safety-tutorial.md) |  | ● |
| [Flock](../identity/saas-apps/flock-provisioning-tutorial.md) | ● | ● |
| [Folloze](../identity/saas-apps/folloze-tutorial.md) |  | ● |
| [Foodee](../identity/saas-apps/foodee-provisioning-tutorial.md) | ● | ● |
| [Forcepoint Cloud Security Gateway - User Authentication](../identity/saas-apps/forcepoint-cloud-security-gateway-provisioning-tutorial.md) | ● | ● |
| [ForeSee CX Suite](../identity/saas-apps/foreseecxsuite-tutorial.md) |  | ● |
| [Fortes Change Cloud](../identity/saas-apps/fortes-change-cloud-provisioning-tutorial.md) | ● | ● |
| [FortiSASE](../identity/saas-apps/fortisase-sia-tutorial.md) |  | ● |
| [Fountain](../identity/saas-apps/fountain-tutorial.md) |  | ● |
| [FourKites SAML2.0 SSO for Tracking](../identity/saas-apps/fourkites-tutorial.md) |  | ● |
| [Frankli.io](../identity/saas-apps/frankli-io-provisioning-tutorial.md) | ● | |
| [Freight Audit](../identity/saas-apps/freight-audit-tutorial.md) |  | ● |
| [Freightender SSO for TRP (Tender Response Platform)](../identity/saas-apps/freightender-sso-for-trp-tender-response-platform-tutorial.md) |  | ● |
| [Fresh Relevance](../identity/saas-apps/fresh-relevance-tutorial.md) |  | ● |
| [Freshservice Provisioning](../identity/saas-apps/freshservice-provisioning-tutorial.md) | ● | ● |
| [FTAPI](../identity/saas-apps/ftapi-tutorial.md) |  | ● |
| [Fulcrum](../identity/saas-apps/fulcrum-tutorial.md) |  | ● |
| [Fullstory SAML](../identity/saas-apps/fullstory-saml-tutorial.md) |  | ● |
| [Funnel Leasing](../identity/saas-apps/funnel-leasing-provisioning-tutorial.md) | ● | ● |
| [Fuze](../identity/saas-apps/fuze-provisioning-tutorial.md) | ● | ● |
| [G Suite](../identity/saas-apps/g-suite-provisioning-tutorial.md) | ● |  |
| [GaggleAMP](../identity/saas-apps/gaggleamp-tutorial.md) |  | ● |
| [Genesys Cloud for Azure](../identity/saas-apps/purecloud-by-genesys-provisioning-tutorial.md) | ● | ● |
| [getAbstract](../identity/saas-apps/getabstract-provisioning-tutorial.md) | ● | ● |
| [Getty Images](../identity/saas-apps/getty-images-tutorial.md) |  | ● |
| [GitHub AE](../identity/saas-apps/github-ae-provisioning-tutorial.md) | ● | ● |
| [GitHub Enterprise Cloud - Enterprise Account](../identity/saas-apps/github-enterprise-cloud-enterprise-account-tutorial.md) |  | ● |
| [GitHub Enterprise Managed User (OIDC)](../identity/saas-apps/github-enterprise-managed-user-oidc-provisioning-tutorial.md) | ● | ● |
| [GitHub Enterprise Managed User](../identity/saas-apps/github-enterprise-managed-user-provisioning-tutorial.md) | ● | ● |
| [GitHub Enterprise Server](../identity/saas-apps/github-ae-tutorial.md) |  | ● |
| [GitHub](../identity/saas-apps/github-provisioning-tutorial.md) | ● | ● |
| [Global Relay Identity Sync](../identity/saas-apps/global-relay-identity-sync-provisioning-tutorial.md) | ● |  |
| [GlobalOne](../identity/saas-apps/globalone-tutorial.md) |  | ● |
| [GlobeSmart](../identity/saas-apps/globesmart-tutorial.md) |  | ● |
| [goFLUENT](../identity/saas-apps/gofluent-tutorial.md) |  | ● |
| [GoLinks](../identity/saas-apps/golinks-provisioning-tutorial.md) | ● | ● |
| [Gong](../identity/saas-apps/gong-provisioning-tutorial.md) | ● |  |
| [Google Cloud Platform](../identity/saas-apps/g-suite-provisioning-tutorial.md) | ● | ● |
| [GoProfiles](../identity/saas-apps/goprofiles-tutorial.md) |  | ● |
| [GoSearch](../identity/saas-apps/gosearch-tutorial.md) |  | ● |
| [GoTo](../identity/saas-apps/goto-provisioning-tutorial.md) | ● | ● |
| [Graebel Single Sign On with globalCONNECT](../identity/saas-apps/graebel-single-sign-on-with-globalconnect-tutorial.md) |  | ● |
| [Grammarly](../identity/saas-apps/grammarly-provisioning-tutorial.md) | ● | ● |
| [Granite](../identity/saas-apps/granite-tutorial.md) |  | ● |
| [GreenOrbit](../identity/saas-apps/greenorbit-tutorial.md) |  | ● |
| [Grok Learning](../identity/saas-apps/grok-learning-tutorial.md) |  | ● |
| [Group Talk](../identity/saas-apps/grouptalk-provisioning-tutorial.md) | ● |  |
| [Grovo](../identity/saas-apps/grovo-tutorial.md) |  | ● |
| [Gtmhub](../identity/saas-apps/gtmhub-provisioning-tutorial.md) | ● |  |
| [Guru](../identity/saas-apps/guru-tutorial.md) |  | ● |
| [H5mag](../identity/saas-apps/h5mag-provisioning-tutorial.md) | ● |  |
| [Hackerone](../identity/saas-apps/hackerone-tutorial.md) |  | ● |
| [HappyFox](../identity/saas-apps/happyfox-tutorial.md) |  | ● |
| [Harness](../identity/saas-apps/harness-provisioning-tutorial.md) | ● | ● |
| [hCaptcha Enterprise](../identity/saas-apps/hcaptcha-enterprise-tutorial.md) |  | ● |
| [Headspace](../identity/saas-apps/headspace-provisioning-tutorial.md) | ● | ● |
| [HelloID](../identity/saas-apps/helloid-provisioning-tutorial.md) | ● |  |
| [Help Scout](../identity/saas-apps/helpscout-tutorial.md) |  | ● |
| [Helper Helper](../identity/saas-apps/helper-helper-tutorial.md) |  | ● |
| [Heroku](../identity/saas-apps/heroku-tutorial.md) |  | ● |
| [HeyBuddy](../identity/saas-apps/heybuddy-tutorial.md) |  | ● |
| [Hightail](../identity/saas-apps/hightail-tutorial.md) |  | ● |
| [Hive Learning](../identity/saas-apps/hive-learning-tutorial.md) |  | ● |
| [Hive](../identity/saas-apps/hive-tutorial.md) |  | ● |
| [Holmes Cloud](../identity/saas-apps/holmes-cloud-provisioning-tutorial.md) | ● |  |
| [Hootsuite](../identity/saas-apps/hootsuite-provisioning-tutorial.md) | ● | ● |
| [Hopsworks.ai](../identity/saas-apps/hopsworks-ai-tutorial.md) |  | ● |
| [Hornbill](../identity/saas-apps/hornbill-tutorial.md) |  | ● |
| [Hosted Graphite](../identity/saas-apps/hostedgraphite-tutorial.md) |  | ● |
| [HowNow WebApp SSO](../identity/saas-apps/hownow-webapp-sso-tutorial.md) |  | ● |
| [Howspace](../identity/saas-apps/howspace-provisioning-tutorial.md) | ● |  |
| [Hoxhunt](../identity/saas-apps/hoxhunt-provisioning-tutorial.md) | ● | ● |
| [HSB ThoughtSpot](../identity/saas-apps/hsb-thoughtspot-tutorial.md) |  | ● |
| [Humbol](../identity/saas-apps/humbol-provisioning-tutorial.md) | ● |  |
| [Hype](../identity/saas-apps/hype-tutorial.md) |  | ● |
| [Hypervault](../identity/saas-apps/hypervault-provisioning-tutorial.md) | ● |  |
| [IamIP Platform](../identity/saas-apps/iamip-patent-platform-tutorial.md) |  | ● |
| [IBM DB2 (SQL connector)](../identity/app-provisioning/tutorial-ecma-sql-connector.md) | ● |  |
| [IBM Domino (via MIM)](/microsoft-identity-manager/reference/microsoft-identity-manager-2016-connector-domino) | ● |  |
| [IBM Tivoli Directory Server (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md)  | ● |  |
| [IBMid](../identity/saas-apps/ibmid-tutorial.md) |  | ● |
| [Ideagen Cloud](../identity/saas-apps/ideagen-cloud-provisioning-tutorial.md) | ● |  |
| [Ideo](../identity/saas-apps/ideo-provisioning-tutorial.md) | ● | ● |
| [Igloo Software](../identity/saas-apps/igloo-software-tutorial.md) |  | ● |
| [iGrafx Platform](../identity/saas-apps/igrafx-platform-tutorial.md) |  | ● |
| [iHASCO Training](../identity/saas-apps/ihasco-training-tutorial.md) |  | ● |
| [iLMS](../identity/saas-apps/ilms-tutorial.md) |  | ● |
| [Imagen](../identity/saas-apps/imagen-tutorial.md) |  | ● |
| [Infogix Data3Sixty Govern](../identity/saas-apps/infogix-tutorial.md) |  | ● |
| [Infor CloudSuite](../identity/saas-apps/infor-cloudsuite-provisioning-tutorial.md) | ● | ● |
| [InformaCast](../identity/saas-apps/informacast-provisioning-tutorial.md) | ● | ● |
| [Informatica Intelligent Data Management Cloud](../identity/saas-apps/informatica-intelligent-data-management-cloud-tutorial.md) |  | ● |
| [Innotas](../identity/saas-apps/innotas-tutorial.md) |  | ● |
| [Innovation Hub](../identity/saas-apps/innovationhub-tutorial.md) |  | ● |
| [Insider](../identity/saas-apps/insider-tutorial.md) |  | ● |
| [Insight4GRC](../identity/saas-apps/insight4grc-provisioning-tutorial.md) | ● | ● |
| [InSightly SAML](../identity/saas-apps/insightly-saml-provisioning-tutorial.md) | ● | ● |
| [Insightsfirst](../identity/saas-apps/insightsfirst-tutorial.md) |  | ● |
| [Insite LMS](../identity/saas-apps/insite-lms-provisioning-tutorial.md) | ● |  |
| [InstaVR Viewer](../identity/saas-apps/instavr-viewer-tutorial.md) |  | ● |
| [International SOS Assistance Products](../identity/saas-apps/international-sos-assistance-products-tutorial.md) |  | ● |
| [introDus Pre and Onboarding Platform](../identity/saas-apps/introdus-pre-and-onboarding-platform-provisioning-tutorial.md) | ● |  |
| [IntSights](../identity/saas-apps/intsights-tutorial.md) |  | ● |
| [Invision](../identity/saas-apps/invision-provisioning-tutorial.md) | ● | ● |
| [InviteDesk](../identity/saas-apps/invitedesk-provisioning-tutorial.md) | ● |  |
| [IP Platform](../identity/saas-apps/ip-platform-tutorial.md) |  | ● |
| [iPass SmartConnect](../identity/saas-apps/ipass-smartconnect-provisioning-tutorial.md) | ● | ● |
| [iQualify LMS](../identity/saas-apps/iqualify-tutorial.md) |  | ● |
| [Iris Intranet](../identity/saas-apps/iris-intranet-provisioning-tutorial.md) | ● | ● |
| [IriusRisk](../identity/saas-apps/iriusrisk-tutorial.md) |  | ● |
| [ISG GovernX Federation](../identity/saas-apps/isg-governx-federation-tutorial.md) |  | ● |
| [Island](../identity/saas-apps/island-provisioning-tutorial.md) | ● | ● |
| [Isode directory server (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [IT-Conductor](../identity/saas-apps/it-conductor-tutorial.md) |  | ● |
| [Ivanti Service Manager (ISM)](../identity/saas-apps/ivanti-service-manager-tutorial.md) |  | ● |
| [Javelo](../identity/saas-apps/javelo-tutorial.md) |  | ● |
| [JFrog Artifactory](../identity/saas-apps/jfrog-artifactory-tutorial.md) |  | ● |
| [Jive](../identity/saas-apps/jive-provisioning-tutorial.md) | ● | ● |
| [Jooto](../identity/saas-apps/jooto-tutorial.md) |  | ● |
| [Jostle](../identity/saas-apps/jostle-provisioning-tutorial.md) | ● | ● |
| [Joyn FSM](../identity/saas-apps/joyn-fsm-provisioning-tutorial.md) | ● |  |
| [Juno Journey](../identity/saas-apps/juno-journey-provisioning-tutorial.md) | ● | ● |
| [Kairos Business](../identity/saas-apps/kairos-business-tutorial.md) |  | ● |
| [Kanbanize](../identity/saas-apps/kanbanize-tutorial.md) |  | ● |
| [Keepabl](../identity/saas-apps/keepabl-provisioning-tutorial.md) | ● | ● |
| [Keeper Password Manager & Digital Vault](../identity/saas-apps/keeper-password-manager-digitalvault-provisioning-tutorial.md) | ● | ● |
| [Kendis - Microsoft Entra Integration](../identity/saas-apps/kendis-scaling-agile-platform-tutorial.md) |  | ● |
| [Keystone](../identity/saas-apps/keystone-provisioning-tutorial.md) | ● | ● |
| [Khoros Care](../identity/saas-apps/khoros-care-tutorial.md) |  | ● |
| [Kindling](../identity/saas-apps/kindling-tutorial.md) |  | ● |
| [Kintone](../identity/saas-apps/kintone-provisioning-tutorial.md) | ● | ● |
| [Kion](../identity/saas-apps/cloudtamer-io-tutorial.md) |  | ● |
| [Kisi Physical Security](../identity/saas-apps/kisi-physical-security-provisioning-tutorial.md) | ● | ● |
| [Kiteworks](../identity/saas-apps/kiteworks-tutorial.md) |  | ● |
| [Klaxoon SAML](../identity/saas-apps/klaxoon-saml-provisioning-tutorial.md) | ● | ● |
| [Klaxoon](../identity/saas-apps/klaxoon-provisioning-tutorial.md) | ● | ● |
| [Klue](../identity/saas-apps/klue-tutorial.md) |  | ● |
| [Kno2fy](../identity/saas-apps/kno2fy-provisioning-tutorial.md) | ● | ● |
| [KnowBe4 Security Awareness Training](../identity/saas-apps/knowbe4-security-awareness-training-provisioning-tutorial.md) | ● | ● |
| [Knowledge Anywhere LMS](../identity/saas-apps/knowledge-anywhere-lms-tutorial.md) |  | ● |
| [Knowledge Work](../identity/saas-apps/knowledge-work-tutorial.md) |  | ● |
| [KnowledgeOwl](../identity/saas-apps/knowledgeowl-tutorial.md) |  | ● |
| [Kofax TotalAgility](../identity/saas-apps/kofax-totalagility-tutorial.md) |  | ● |
| [Kpifire](../identity/saas-apps/kpifire-provisioning-tutorial.md) | ● | ● |
| [KPN Grip](../identity/saas-apps/kpn-grip-provisioning-tutorial.md) | ● | |
| [Krisp Technologies](../identity/saas-apps/krisp-technologies-tutorial.md) |  | ● |
| [Kumolus](../identity/saas-apps/kumolus-tutorial.md) |  | ● |
| [LabLog](../identity/saas-apps/lablog-tutorial.md) |  | ● |
| [LambdaTest Single Sign on](../identity/saas-apps/lambda-test-single-sign-on-tutorial.md) |  | ● |
| [LanSchool Air](../identity/saas-apps/lanschool-air-provisioning-tutorial.md) | ● | ● |
| [LaunchDarkly](../identity/saas-apps/launchdarkly-tutorial.md) |  | ● |
| [LawVu](../identity/saas-apps/lawvu-provisioning-tutorial.md) | ● | ● |
| [LDAP](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [Lean](../identity/saas-apps/lean-tutorial.md) |  | ● |
| [Leapsome](../identity/saas-apps/leapsome-provisioning-tutorial.md) | ● | ● |
| [LearnUpon](../identity/saas-apps/learnupon-tutorial.md) |  | ● |
| [Ledgy](../identity/saas-apps/ledgy-tutorial.md) |  | ● |
| [Lessonly](../identity/saas-apps/lessonly-tutorial.md) |  | ● |
| [Lexonis TalentScape](../identity/saas-apps/lexonis-talentscape-provisioning-tutorial.md) | ● | ● |
| [LimbleCMMS](../identity/saas-apps/limblecmms-provisioning-tutorial.md) | ● |  |
| [LinkedIn Elevate](../identity/saas-apps/linkedinelevate-provisioning-tutorial.md) | ● | ● |
| [LinkedIn Learning](../identity/saas-apps/linkedinlearning-tutorial.md) |  | ● |
| [LinkedIn Sales Navigator](../identity/saas-apps/linkedinsalesnavigator-provisioning-tutorial.md) | ● | ● |
| [LinkedIn Talent Solutions](../identity/saas-apps/linkedin-talent-solutions-tutorial.md) |  | ● |
| [Litmos](../identity/saas-apps/litmos-provisioning-tutorial.md) | ● | ● |
| [LogicGate](../identity/saas-apps/logicgate-provisioning-tutorial.md) | ● |  |
| [Looker Analytics Platform](../identity/saas-apps/looker-analytics-platform-tutorial.md) |  | ● |
| [Looop](../identity/saas-apps/looop-provisioning-tutorial.md) | ● |  |
| [Lucid (All Products)](../identity/saas-apps/lucid-all-products-provisioning-tutorial.md) | ● | ● |
| [Lucidchart](../identity/saas-apps/lucidchart-provisioning-tutorial.md) | ● | ● |
| [Lusha](../identity/saas-apps/lusha-tutorial.md) |  | ● |
| [LUSID](../identity/saas-apps/LUSID-provisioning-tutorial.md) | ● | ● |
| [Lynda.com](../identity/saas-apps/lynda-tutorial.md) |  | ● |
| [M-Files](../identity/saas-apps/m-files-provisioning-tutorial.md) | ● | ● |
| [Mailosaur](../identity/saas-apps/mailosaur-tutorial.md) |  | ● |
| [Mapiq](../identity/saas-apps/mapiq-tutorial.md) |  | ● |
| [Maptician](../identity/saas-apps/maptician-provisioning-tutorial.md) | ● | ● |
| [Marker.io](../identity/saas-apps/marker-io-tutorial.md) |  | ● |
| [Markit Procurement Service](../identity/saas-apps/markit-procurement-service-provisioning-tutorial.md) | ● |  |
| [MDComune Business](../identity/saas-apps/mdcomune-business-tutorial.md) |  | ● |
| [MediusFlow](../identity/saas-apps/mediusflow-provisioning-tutorial.md) | ● |  |
| [Mend.io](../identity/saas-apps/mend-io-tutorial.md) |  | ● |
| [Mercell](../identity/saas-apps/mercell-tutorial.md) |  | ● |
| [MerchLogix](../identity/saas-apps/merchlogix-provisioning-tutorial.md) | ● | ● |
| [Meta Networks Connector](../identity/saas-apps/meta-networks-connector-provisioning-tutorial.md) | ● | ● |
| [Metatask](../identity/saas-apps/metatask-tutorial.md) |  | ● |
| [Mevisio](../identity/saas-apps/mevisio-tutorial.md) |  | ● |
| [MIC SAAS Portal](../identity/saas-apps/mic-saas-portal-tutorial.md) |  | ● |
| [MicroFocus Novell eDirectory (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [Microsoft 365](../fundamentals/concept-group-based-licensing.md) | ● | ● |
| [Microsoft Active Directory Domain Services](../identity/domain-services/scoped-synchronization.md) | ● | ● |
| [Microsoft Azure SQL (SQL connector)](../identity/app-provisioning/tutorial-ecma-sql-connector.md) | ● |  |
| [Microsoft Azure](/azure/role-based-access-control/role-assignments-portal) | ● | ● |
| [Microsoft Entra Domain Services](../identity/domain-services/synchronization.md) | ● | ● |
| [Microsoft Lightweight Directory Server (ADAM) (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [Microsoft SharePoint Server on-premises](../identity/saas-apps/sharepoint-on-premises-tutorial.md) | | ●  |
| [Microsoft SQL Server (SQL connector)](../identity/app-provisioning/tutorial-ecma-sql-connector.md) | ● |  |
| [Mindtickle](../identity/saas-apps/mindtickle-provisioning-tutorial.md) | ● | ● |
| [Miro](../identity/saas-apps/miro-provisioning-tutorial.md) | ● | ● |
| [Mixpanel](../identity/saas-apps/mixpanel-provisioning-tutorial.md) | ● | ● |
| [MobileIron](../identity/saas-apps/mobileiron-provisioning-tutorial.md) | ● | ● |
| [Monday.com](../identity/saas-apps/mondaycom-provisioning-tutorial.md) | ● | ● |
| [MongoDB Atlas - SSO](../identity/saas-apps/mongodb-cloud-tutorial.md) |  | ● |
| [MongoDB Atlas](../identity/saas-apps/mongodb-cloud-tutorial.md) |  | ● |
| [Moqups](../identity/saas-apps/moqups-provisioning-tutorial.md) | ● | ● |
| [Movement by project44](../identity/saas-apps/movement-by-project44-tutorial.md) |  | ● |
| [Moveworks](../identity/saas-apps/moveworks-tutorial.md) |  | ● |
| [Mural Identity](../identity/saas-apps/mural-identity-provisioning-tutorial.md) | ● | ● |
| [MX3 Diagnostics](../identity/saas-apps/mx3-diagnostics-connector-provisioning-tutorial.md) | ● |  |
| [My IBISWorld](../identity/saas-apps/my-ibisworld-tutorial.md) |  | ● |
| [myPolicies](../identity/saas-apps/mypolicies-provisioning-tutorial.md) | ● | ● |
| [MySQL (SQL connector)](../identity/app-provisioning/tutorial-ecma-sql-connector.md) | ● |  |
| [MyVR](../identity/saas-apps/myvr-tutorial.md) |  | ● |
| [Navan](../identity/saas-apps/navan-tutorial.md) |  | ● |
| [NAVEX IRM (Lockpath/Keylight)](../identity/saas-apps/navex-irm-keylight-lockpath-tutorial.md) |  | ● |
| [NetIQ eDirectory (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [NetMotion Mobility](../identity/saas-apps/netmotion-mobility-tutorial.md) |  | ● |
| [Netpresenter Next](../identity/saas-apps/netpresenter-provisioning-tutorial.md) | ● |  |
| [Netskope User Authentication](../identity/saas-apps/netskope-administrator-console-provisioning-tutorial.md) | ● | ● |
| [Netsparker Enterprise](../identity/saas-apps/netsparker-enterprise-provisioning-tutorial.md) | ● | ● |
| [Neustar UltraDNS](../identity/saas-apps/neustar-ultradns-tutorial.md) |  | ● |
| [New Relic by Organization](../identity/saas-apps/new-relic-by-organization-provisioning-tutorial.md) | ● | ● |
| [Nimblex](../identity/saas-apps/nimblex-tutorial.md) |  | ● |
| [Nimbus](../identity/saas-apps/nimbus-tutorial.md) |  | ● |
| [Nintex Promapp](../identity/saas-apps/promapp-tutorial.md) |  | ● |
| [Nitro Productivity Suite](../identity/saas-apps/nitro-productivity-suite-tutorial.md) |  | ● |
| [Nomadesk](../identity/saas-apps/nomadesk-tutorial.md) |  | ● |
| [NordPass](../identity/saas-apps/nordpass-provisioning-tutorial.md) | ● | ● |
| [Notion](../identity/saas-apps/notion-provisioning-tutorial.md) | ● | ● |
| [Novatus](../identity/saas-apps/novatus-tutorial.md) |  | ● |
| [Novell eDirectory (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md)  | ● |  |
| [Nuclino](../identity/saas-apps/nuclino-tutorial.md) |  | ● |
| [O'Reilly Learning Platform](../identity/saas-apps/oreilly-learning-platform-provisioning-tutorial.md) | ● | ● |
| [OfficeSpace Software](../identity/saas-apps/officespace-software-provisioning-tutorial.md) | ● | ● |
| [Olfeo SAAS](../identity/saas-apps/olfeo-saas-provisioning-tutorial.md) | ● | ● |
| [OneDesk](../identity/saas-apps/onedesk-tutorial.md) |  | ● |
| [Oneflow](../identity/saas-apps/oneflow-provisioning-tutorial.md) | ● | ● |
| [Oneteam](../identity/saas-apps/oneteam-tutorial.md) |  | ● |
| [OneTrust Privacy Management Software](../identity/saas-apps/onetrust-tutorial.md) |  | ● |
| [Onshape](../identity/saas-apps/onshape-tutorial.md) |  | ● |
| [Onyxia](../identity/saas-apps/onyxia-tutorial.md) |  | ● |
| [Open DJ (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md)  | ● |  |
| [Open DS (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md)  | ● |  |
| [OpenAthens](../identity/saas-apps/openathens-tutorial.md) |  | ● |
| [OpenForms](../identity/saas-apps/openforms-provisioning-tutorial.md) | ● |  |
| [OpenLDAP](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [OpenText Directory Services](../identity/saas-apps/open-text-directory-services-provisioning-tutorial.md) | ● | ● |
| [OptiTurn](../identity/saas-apps/optiturn-tutorial.md) |  | ● |
| [Oracle Access Manager for Oracle E-Business Suite](../identity/saas-apps/oracle-access-manager-for-oracle-ebs-tutorial.md) |  | ● |
| [Oracle Access Manager for Oracle Retail Merchandising](../identity/saas-apps/oracle-access-manager-for-oracle-retail-merchandising-tutorial.md) |  | ● |
| [Oracle Cloud Infrastructure Console](../identity/saas-apps/oracle-cloud-infrastructure-console-provisioning-tutorial.md) | ● | ● |
| [Oracle Database (SQL connector)](../identity/app-provisioning/tutorial-ecma-sql-connector.md) | ● |  |
| [Oracle E-Business Suite](../identity/app-provisioning/on-premises-web-services-connector.md)  | ● | ● |
| [Oracle Fusion ERP](../identity/saas-apps/oracle-fusion-erp-provisioning-tutorial.md) | ● | ● |
| [Oracle IDCS for E-Business Suite](../identity/saas-apps/oracle-idcs-for-ebs-tutorial.md) |  | ● |
| [Oracle IDCS for JD Edwards](../identity/saas-apps/oracle-idcs-for-jd-edwards-tutorial.md) |  | ● |
| [Oracle IDCS for PeopleSoft](../identity/saas-apps/oracle-idcs-for-peoplesoft-tutorial.md) |  | ● |
| [Oracle PeopleSoft ERP](../identity/app-provisioning/on-premises-web-services-connector.md) | ● | ● |
| [Oracle SunONE Directory Server (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [Othership Workplace Scheduler](../identity/saas-apps/othership-workplace-scheduler-tutorial.md) |  | ● |
| [OutSystems](../identity/saas-apps/outsystems-tutorial.md) |  | ● |
| [Overdrive](../identity/saas-apps/overdrive-books-tutorial.md) |  | ● |
| [PagerDuty](../identity/saas-apps/pagerduty-tutorial.md) |  | ● |
| [Palantir Foundry](../identity/saas-apps/palantir-foundry-tutorial.md) |  | ● |
| [Palo Alto Networks - Admin UI](../identity/saas-apps/paloaltoadmin-tutorial.md) |  | ● |
| [Palo Alto Networks - Captive Portal](../identity/saas-apps/paloaltonetworks-captiveportal-tutorial.md) |  | ● |
| [Palo Alto Networks - GlobalProtect](../identity/saas-apps/palo-alto-networks-globalprotect-tutorial.md) |  | ● |
| [Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service](../identity/saas-apps/palo-alto-networks-cloud-identity-engine-provisioning-tutorial.md) | ● | ● |
| [Palo Alto Networks SCIM Connector](../identity/saas-apps/palo-alto-networks-scim-connector-provisioning-tutorial.md) | ● | ● |
| [PandaDoc](../identity/saas-apps/pandadoc-tutorial.md) |  | ● |
| [Panopto](../identity/saas-apps/panopto-tutorial.md) |  | ● |
| [Panorays](../identity/saas-apps/panorays-tutorial.md) |  | ● |
| [PaperCut Cloud Print Management](../identity/saas-apps/papercut-cloud-print-management-provisioning-tutorial.md) | ● |  |
| [Papirfly SSO](../identity/saas-apps/papirfly-sso-tutorial.md) |  | ● |
| [Parkable](../identity/saas-apps/parkable-tutorial.md) |  | ● |
| [Parkalot - Car park management](../identity/saas-apps/parkalot-car-park-management-tutorial.md) |  | ● |
| [Parsable](../identity/saas-apps/parsable-provisioning-tutorial.md) | ● |  |
| [Peakon](../identity/saas-apps/peakon-provisioning-tutorial.md) | ● | ● |
| [Perimeter 81](../identity/saas-apps/perimeter-81-tutorial.md) |  | ● |
| [Peripass](../identity/saas-apps/peripass-provisioning-tutorial.md) | ● |  |
| [Personify Inc](../identity/saas-apps/personify-inc-provisioning-tutorial.md) | ● | ● |
| [Pingboard](../identity/saas-apps/pingboard-provisioning-tutorial.md) | ● | ● |
| [PKSHA Chatbot](../identity/saas-apps/pksha-chatbot-tutorial.md) |  | ● |
| [Plandisc](../identity/saas-apps/plandisc-provisioning-tutorial.md) | ● |  |
| [PlanMyLeave](../identity/saas-apps/planmyleave-tutorial.md) |  | ● |
| [Playvox](../identity/saas-apps/playvox-provisioning-tutorial.md) | ● |  |
| [Pluto](../identity/saas-apps/pluto-tutorial.md) |  | ● |
| [Podbean](../identity/saas-apps/podbean-tutorial.md) |  | ● |
| [PolicyStat](../identity/saas-apps/policystat-tutorial.md) |  | ● |
| [PoliteMail - SSO](../identity/saas-apps/politemail-sso-tutorial.md) |  | ● |
| [Postman](../identity/saas-apps/postman-provisioning-tutorial.md) | ● | ● |
| [Preciate](../identity/saas-apps/preciate-provisioning-tutorial.md) | ● |  |
| [PressReader](../identity/saas-apps/pressreader-tutorial.md) |  | ● |
| [PrinterLogic SaaS](../identity/saas-apps/printer-logic-saas-provisioning-tutorial.md) | ● | ● |
| [PrinterLogic](../identity/saas-apps/printerlogic-saas-tutorial.md) |  | ● |
| [Printix](../identity/saas-apps/printix-tutorial.md) |  | ● |
| [Priority Matrix](../identity/saas-apps/priority-matrix-provisioning-tutorial.md) | ● |  |
| [Prisma Cloud SSO](../identity/saas-apps/prisma-cloud-tutorial.md) |  | ● |
| [ProcessUnity](../identity/saas-apps/processunity-tutorial.md) |  | ● |
| [ProdPad](../identity/saas-apps/prodpad-provisioning-tutorial.md) | ● | ● |
| [productboard](../identity/saas-apps/productboard-tutorial.md) |  | ● |
| [Productive](../identity/saas-apps/productive-tutorial.md) |  | ● |
| [ProductPlan](../identity/saas-apps/productplan-tutorial.md) |  | ● |
| [ProjectPlace](../identity/saas-apps/projectplace-tutorial.md) |  | ● |
| [Promapp](../identity/saas-apps/promapp-provisioning-tutorial.md) | ● |  |
| [Proofpoint Security Awareness Training](../identity/saas-apps/proofpoint-security-awareness-training-tutorial.md) |  | ● |
| [Proware](../identity/saas-apps/proware-provisioning-tutorial.md) | ● | ● |
| [Proxyclick](../identity/saas-apps/proxyclick-provisioning-tutorial.md) | ● | ● |
| [PurelyHR](../identity/saas-apps/purelyhr-tutorial.md) |  | ● |
| [pymetrics](../identity/saas-apps/pymetrics-tutorial.md) |  | ● |
| [QA](../identity/saas-apps/cloud-academy-sso-provisioning-tutorial.md) | ● | ● |
| [Qiita Team](../identity/saas-apps/qiita-team-tutorial.md) |  | ● |
| [Qmarkets Idea & Innovation Management](../identity/saas-apps/qmarkets-idea-innovation-management-tutorial.md) |  | ● |
| [QReserve](../identity/saas-apps/qreserve-tutorial.md) |  | ● |
| [Qualtrics](../identity/saas-apps/qualtrics-tutorial.md) |  | ● |
| [Quarem](../identity/saas-apps/quarem-provisioning-tutorial.md) | ● | ● |
| [QuickHelp](../identity/saas-apps/quickhelp-tutorial.md) |  | ● |
| [Qumu Cloud](../identity/saas-apps/qumucloud-tutorial.md) |  | ● |
| [Radancy's Employee Referrals](../identity/saas-apps/radancys-employee-referrals-tutorial.md) |  | ● |
| [Radiant IOT Portal](../identity/saas-apps/radiant-iot-portal-tutorial.md) |  | ● |
| [RadiantOne Virtual Directory Server (VDS) (LDAP connector)](../identity/app-provisioning/on-premises-ldap-connector-configure.md) | ● |  |
| [raum\]für\[raum](../identity/saas-apps/raumfurraum-tutorial.md) |  | ● |
| [Reach 360](../identity/saas-apps/reach-360-tutorial.md) |  | ● |
| [ReadCube Papers](../identity/saas-apps/readcube-papers-tutorial.md) |  | ● |
| [Real Links](../identity/saas-apps/real-links-provisioning-tutorial.md) | ● | ● |
| [Recnice](../identity/saas-apps/recnice-provisioning-tutorial.md) | ● |  |
| [Redocly](../identity/saas-apps/redocly-tutorial.md) |  | ● |
| [Reprints Desk - Article Galaxy](../identity/saas-apps/reprints-desk-article-galaxy-tutorial.md) |  | ● |
| [Rescana](../identity/saas-apps/rescana-tutorial.md) |  | ● |
| [Resource Central – SAML SSO for Meeting Room Booking System](../identity/saas-apps/resource-central-tutorial.md) |  | ● |
| [Retail Zipline](../identity/saas-apps/retail-zipline-tutorial.md) |  | ● |
| [RevSpace](../identity/saas-apps/revspace-tutorial.md) |  | ● |
| [Reward Gateway](../identity/saas-apps/reward-gateway-provisioning-tutorial.md) | ● | ● |
| [Rewatch](../identity/saas-apps/rewatch-tutorial.md) |  | ● |
| [RFPIO](../identity/saas-apps/rfpio-provisioning-tutorial.md) | ● | ● |
| [Rhombus Systems](../identity/saas-apps/rhombus-systems-provisioning-tutorial.md) | ● | ● |
| [RightCrowd Workforce Management](../identity/saas-apps/rightcrowd-workforce-management-tutorial.md) |  | ● |
| [RingCentral](../identity/saas-apps/ringcentral-provisioning-tutorial.md) | ● | ● |
| [Rise.com](../identity/saas-apps/risecom-tutorial.md) |  | ● |
| [Robin](../identity/saas-apps/robin-provisioning-tutorial.md) | ● | ● |
| [RocketReach SSO](../identity/saas-apps/rocketreach-sso-tutorial.md) |  | ● |
| [RoleMapper](../identity/saas-apps/rolemapper-tutorial.md) |  | ● |
| [Rollbar](../identity/saas-apps/rollbar-provisioning-tutorial.md) | ● | ● |
| [Rootly](../identity/saas-apps/rootly-provisioning-tutorial.md) | ● | ● |
| [Rouse Sales](../identity/saas-apps/rouse-sales-provisioning-tutorial.md) | ● |  |
| [RSA Archer Suite](../identity/saas-apps/rsa-archer-suite-tutorial.md) |  | ● |
| [RStudio Connect SAML Authentication](../identity/saas-apps/rstudio-connect-tutorial.md) |  | ● |
| [S4 - Digitsec](../identity/saas-apps/s4-digitsec-tutorial.md) |  | ● |
| [Saba Cloud](../identity/saas-apps/saba-cloud-tutorial.md) |  | ● |
| [SafeGuard Cyber](../identity/saas-apps/safeguard-cyber-provisioning-tutorial.md) | ● | ● |
| [Salesforce Sandbox](../identity/saas-apps/salesforce-sandbox-provisioning-tutorial.md) | ● | ● |
| [Salesforce](../identity/saas-apps/salesforce-provisioning-tutorial.md) | ● | ● |
| [Samanage](../identity/saas-apps/samanage-provisioning-tutorial.md) | ● | ● |
| [SAML SSO for Bamboo by resolution GmbH](../identity/saas-apps/bamboo-tutorial.md) |  | ● |
| [SAML SSO for Bitbucket by resolution GmbH](../identity/saas-apps/bitbucket-tutorial.md) |  | ● |
| [SAML SSO for Jira by resolution GmbH](../identity/saas-apps/samlssojira-tutorial.md) |  | ● |
| [SAML-based apps](../identity/enterprise-apps/add-application-portal-setup-sso.md) | | ●  |
| [Samsara](../identity/saas-apps/samsara-tutorial.md) |  | ● |
| [SAP Analytics Cloud](../identity/saas-apps/sap-analytics-cloud-provisioning-tutorial.md) | ● | ● |
| [SAP Ariba](../identity/saas-apps/ariba-tutorial.md) |  | ● |
| [SAP Business ByDesign](../identity/saas-apps/sapbusinessbydesign-tutorial.md) |  | ● |
| [SAP Business Technology Platform](../identity/saas-apps/sap-hana-cloud-platform-tutorial.md) |  | ● |
| [SAP Cloud for Customer](../identity/saas-apps/sap-customer-cloud-tutorial.md) |  | ● |
| [SAP Cloud Identity Services](../identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md) | ● | ● |
| [SAP Concur](../identity/saas-apps/sap-concur-provisioning-tutorial.md) | ● | ● |
| [SAP Fieldglass](../identity/saas-apps/fieldglass-tutorial.md) | |  ● |
| [SAP Fiori](../identity/saas-apps/sap-fiori-tutorial.md) |  | ● |
| [SAP HANA](../identity/saas-apps/sap-hana-provisioning-tutorial.md) | | ● |
| [SAP Litmos](../identity/saas-apps/litmos-tutorial.md) |  | ● |
| [SAP NetWeaver](../identity/app-provisioning/on-premises-sap-connector-configure.md) | ● |  ● |
| [SAP R/3 and ERP](../identity/app-provisioning/on-premises-sap-connector-configure.md) | ● | ●  |
| [SAP SuccessFactors to Active Directory](../identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md) | ● | ● |
| [SAP SuccessFactors to Microsoft Entra ID](../identity/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md) | ● | ● |
| [SAP SuccessFactors Writeback](../identity/saas-apps/sap-successfactors-writeback-tutorial.md) | ● | ● |
| [Sapient](../identity/saas-apps/sapient-tutorial.md) |  | ● |
| [SAS Viya](../identity/saas-apps/sas-viya-sso-provisioning-tutorial.md) | ● | ● |
| [Sauce Labs - Mobile and Web Testing](../identity/saas-apps/saucelabs-mobileandwebtesting-tutorial.md) |  | ● |
| [Sauce Labs](../identity/saas-apps/sauce-labs-tutorial.md) |  | ● |
| [Saviynt](../identity/saas-apps/saviynt-tutorial.md) |  | ● |
| [SchoolStream ASA](../identity/saas-apps/schoolstream-asa-provisioning-tutorial.md) | ● | ● |
| [Sciforma](../identity/saas-apps/sciforma-tutorial.md) |  | ● |
| [Scilife Microsoft Entra SSO](../identity/saas-apps/scilife-azure-ad-sso-tutorial.md) |  | ● |
| [SCIM-based apps in the cloud](../identity/app-provisioning/use-scim-to-provision-users-and-groups.md) | ● |  |
| [SCIM-based apps on-premises](../identity/app-provisioning/on-premises-scim-provisioning.md) | ● |  |
| [SciQuest Spend Director](../identity/saas-apps/sciquest-spend-director-tutorial.md) |  | ● |
| [ScreenPal](../identity/saas-apps/screencast-tutorial.md) |  | ● |
| [ScreenSteps](../identity/saas-apps/screensteps-provisioning-tutorial.md) | ● | ● |
| [SDS & Chemical Information Management](../identity/saas-apps/sds-chemical-information-management-tutorial.md) |  | ● |
| [Second Nature AI](../identity/saas-apps/second-nature-ai-tutorial.md) |  | ● |
| [Secure Deliver](../identity/saas-apps/securedeliver-tutorial.md) |  | ● |
| [SecureLogin](../identity/saas-apps/secure-login-provisioning-tutorial.md) | ● |  |
| [SeekOut](../identity/saas-apps/seekout-tutorial.md) |  | ● |
| [Segment](../identity/saas-apps/segment-provisioning-tutorial.md) | ● | ● |
| [SendSafely](../identity/saas-apps/sendsafely-tutorial.md) |  | ● |
| [Sentry](../identity/saas-apps/sentry-provisioning-tutorial.md) | ● | ● |
| [ServiceChannel](../identity/saas-apps/servicechannel-tutorial.md) |  | ● |
| [ServiceNow](../identity/saas-apps/servicenow-provisioning-tutorial.md) | ● | ● |
| [ServusConnect](../identity/saas-apps/servusconnect-tutorial.md) |  | ● |
| [ShareCal](../identity/saas-apps/sharecal-tutorial.md) |  | ● |
| [ShareVault](../identity/saas-apps/sharevault-tutorial.md) |  | ● |
| [SharingCloud](../identity/saas-apps/sharingcloud-tutorial.md) |  | ● |
| [ShipHazmat](../identity/saas-apps/shiphazmat-tutorial.md) |  | ● |
| [Shmoop For Schools](../identity/saas-apps/shmoopforschools-tutorial.md) |  | ● |
| [Shopify Plus](../identity/saas-apps/shopify-plus-provisioning-tutorial.md) | ● | ● |
| [Showpad](../identity/saas-apps/showpad-tutorial.md) |  | ● |
| [Sigma Computing](../identity/saas-apps/sigma-computing-provisioning-tutorial.md) | ● | ● |
| [Signagelive](../identity/saas-apps/signagelive-provisioning-tutorial.md) | ● | ● |
| [SignalFx](../identity/saas-apps/signalfx-tutorial.md) |  | ● |
| [Signiant Media Shuttle](../identity/saas-apps/signiant-media-shuttle-tutorial.md) |  | ● |
| [Sigstr](../identity/saas-apps/sigstr-tutorial.md) |  | ● |
| [Simple In/Out](../identity/saas-apps/simple-in-out-provisioning-tutorial.md) | ● |  |
| [SIS Enterprise](../identity/saas-apps/sis-enterprise-tutorial.md) |  | ● |
| [Sketch](../identity/saas-apps/sketch-tutorial.md) |  | ● |
| [Skilljar](../identity/saas-apps/skilljar-tutorial.md) |  | ● |
| [Skills Base](../identity/saas-apps/skillsbase-tutorial.md) |  | ● |
| [Skopenow](../identity/saas-apps/skopenow-tutorial.md) |  | ● |
| [SKYSITE](../identity/saas-apps/skysite-tutorial.md) |  | ● |
| [Slack](../identity/saas-apps/slack-provisioning-tutorial.md) | ● | ● |
| [Smallstep SSH](../identity/saas-apps/smallstep-ssh-provisioning-tutorial.md) | ● |  |
| [Smart360](../identity/saas-apps/smart360-tutorial.md) |  | ● |
| [SmartDraw](../identity/saas-apps/smartdraw-tutorial.md) |  | ● |
| [Smartfile](../identity/saas-apps/smartfile-provisioning-tutorial.md) | ● | ● |
| [SmartHub INFER](../identity/saas-apps/smarthub-infer-tutorial.md) |  | ● |
| [Smartlook](../identity/saas-apps/smartlook-tutorial.md) |  | ● |
| [Smartplan](../identity/saas-apps/smartplan-tutorial.md) |  | ● |
| [Smartsheet](../identity/saas-apps/smartsheet-provisioning-tutorial.md) | ● |  |
| [Snackmagic](../identity/saas-apps/snackmagic-tutorial.md) |  | ● |
| [Snowflake](../identity/saas-apps/snowflake-provisioning-tutorial.md) | ● | ● |
| [Softeon WMS](../identity/saas-apps/softeon-tutorial.md) |  | ● |
| [Software AG Cloud](../identity/saas-apps/software-ag-cloud-tutorial.md) |  | ● |
| [Soloinsight-CloudGate SSO](../identity/saas-apps/soloinsight-cloudgate-sso-provisioning-tutorial.md) | ● | ● |
| [SoSafe](../identity/saas-apps/sosafe-provisioning-tutorial.md) | ● | ● |
| [SpaceIQ](../identity/saas-apps/spaceiq-provisioning-tutorial.md) | ● | ● |
| [SpectrumU](../identity/saas-apps/spectrumu-tutorial.md) |  | ● |
| [Speexx](../identity/saas-apps/speexx-tutorial.md) |  | ● |
| [Splashtop Secure Workspace](../identity/saas-apps/splashtop-secure-workspace-tutorial.md) |  | ● |
| [Splashtop](../identity/saas-apps/splashtop-provisioning-tutorial.md) | ● | ● |
| [SquaREcruit](../identity/saas-apps/squarecruit-tutorial.md) |  | ● |
| [SSO for Jama Connect®](../identity/saas-apps/sso-for-jama-connect-tutorial.md) |  | ● |
| [Stackby](../identity/saas-apps/stackby-tutorial.md) |  | ● |
| [Stage and Screen](../identity/saas-apps/stage-and-screen-tutorial.md) |  | ● |
| [StarLeaf](../identity/saas-apps/starleaf-provisioning-tutorial.md) | ● |  |
| [Starmind](../identity/saas-apps/starmind-provisioning-tutorial.md) | ● | ● |
| [Stonebranch Universal Automation Center (SaaS Cloud)](../identity/saas-apps/stonebranch-universal-automation-center-saas-cloud-tutorial.md) |  | ● |
| [Storegate](../identity/saas-apps/storegate-provisioning-tutorial.md) | ● |  |
| [Stormboard](../identity/saas-apps/stormboard-tutorial.md) |  | ● |
| [Striim Cloud](../identity/saas-apps/striim-cloud-tutorial.md) |  | ● |
| [Striim Platform](../identity/saas-apps/striim-platform-tutorial.md) |  | ● |
| [Superluminal](../identity/saas-apps/superluminal-tutorial.md) |  | ● |
| [Supermood](../identity/saas-apps/supermood-tutorial.md) |  | ● |
| [Supply Chain Catalyst](../identity/saas-apps/supply-chain-catalyst-tutorial.md) |  | ● |
| [SURFconext](../identity/saas-apps/surfconext-tutorial.md) |  | ● |
| [SurveyMonkey Enterprise](../identity/saas-apps/surveymonkey-enterprise-provisioning-tutorial.md) | ● | ● |
| [Swit](../identity/saas-apps/swit-provisioning-tutorial.md) | ● | ● |
| [Symantec Web Security Service (WSS)](../identity/saas-apps/symantec-web-security-service.md) | ● | ● |
| [Syndio](../identity/saas-apps/syndio-tutorial.md) |  | ● |
| [Synerise AI Growth Operating System](../identity/saas-apps/synerise-ai-growth-ecosystem-tutorial.md) |  | ● |
| [Syniverse Customer Portal](../identity/saas-apps/syniverse-customer-portal-tutorial.md) |  | ● |
| [Tableau Cloud](../identity/saas-apps/tableau-online-provisioning-tutorial.md) | ● | ● |
| [Tailscale](../identity/saas-apps/tailscale-provisioning-tutorial.md) | ● |  |
| [Talent Palette](../identity/saas-apps/talent-palette-tutorial.md) |  | ● |
| [Talentech](../identity/saas-apps/talentech-provisioning-tutorial.md) | ● |  |
| [Tanium SSO](../identity/saas-apps/tanium-sso-provisioning-tutorial.md) | ● | ● |
| [Tap App Security](../identity/saas-apps/tap-app-security-provisioning-tutorial.md) | ● | ● |
| [TargetProcess](../identity/saas-apps/target-process-tutorial.md) |  | ● |
| [TASC (beta)](../identity/saas-apps/tasc-beta-tutorial.md) |  | ● |
| [Taskize Connect](../identity/saas-apps/taskize-connect-provisioning-tutorial.md) | ● | ● |
| [Team Today](../identity/saas-apps/team-today-provisioning-tutorial.md) | ● |  |
| [TeamAlert SSO](../identity/saas-apps/teamalert-sso-tutorial.md) |  | ● |
| [Teamgo](../identity/saas-apps/teamgo-provisioning-tutorial.md) | ● | ● |
| [TeamSlide](../identity/saas-apps/teamslide-tutorial.md) |  | ● |
| [TeamSticker by Communitio](../identity/saas-apps/teamsticker-by-communitio-tutorial.md) |  | ● |
| [TeamViewer](../identity/saas-apps/teamviewer-provisioning-tutorial.md) | ● | ● |
| [Templafy OpenID Connect](../identity/saas-apps/templafy-openid-connect-provisioning-tutorial.md) | ● | ● |
| [Templafy SAML2](../identity/saas-apps/templafy-saml-2-provisioning-tutorial.md) | ● | ● |
| [TencentCloud IDaaS](../identity/saas-apps/tencent-cloud-idaas-tutorial.md) |  | ● |
| [Tendium](../identity/saas-apps/tendium-tutorial.md) |  | ● |
| [Terraform Cloud](../identity/saas-apps/terraform-cloud-tutorial.md) |  | ● |
| [Terraform Enterprise](../identity/saas-apps/terraform-enterprise-tutorial.md) |  | ● |
| [TerraTrue](../identity/saas-apps/terratrue-provisioning-tutorial.md) | ● | ● |
| [tesma](../identity/saas-apps/tesma-tutorial.md) |  | ● |
| [TestingBot](../identity/saas-apps/testingbot-tutorial.md) |  | ● |
| [TextExpander](../identity/saas-apps/textexpander-tutorial.md) |  | ● |
| [Textline](../identity/saas-apps/textline-tutorial.md) |  | ● |
| [TextMagic](../identity/saas-apps/textmagic-tutorial.md) |  | ● |
| [TheOrgWiki](../identity/saas-apps/theorgwiki-provisioning-tutorial.md) | ● |  |
| [Thoropass](../identity/saas-apps/thoropass-tutorial.md) |  | ● |
| [ThousandEyes](../identity/saas-apps/thousandeyes-provisioning-tutorial.md) | ● | ● |
| [ThreatQ Platform](../identity/saas-apps/threatq-platform-tutorial.md) |  | ● |
| [Thrive LXP](../identity/saas-apps/thrive-lxp-provisioning-tutorial.md) | ● | ● |
| [Tic-Tac Mobile](../identity/saas-apps/tic-tac-mobile-provisioning-tutorial.md) | ● |  |
| [TicketManager](../identity/saas-apps/ticketmanager-tutorial.md) |  | ● |
| [TimeClock 365 SAML](../identity/saas-apps/timeclock-365-saml-provisioning-tutorial.md) | ● | ● |
| [TimeClock 365](../identity/saas-apps/timeclock-365-provisioning-tutorial.md) | ● | ● |
| [TimeLive](../identity/saas-apps/timelive-tutorial.md) |  | ● |
| [TimeOffManager](../identity/saas-apps/timeoffmanager-tutorial.md) |  | ● |
| [TIMU](../identity/saas-apps/timu-tutorial.md) |  | ● |
| [TiViTz](../identity/saas-apps/tivitz-tutorial.md) |  | ● |
| [TonicDM](../identity/saas-apps/tonicdm-tutorial.md) |  | ● |
| [Torii](../identity/saas-apps/torii-provisioning-tutorial.md) | ● | ● |
| [Tracker Software Technologies](../identity/saas-apps/tracker-software-technologies-tutorial.md) |  | ● |
| [TrackVia](../identity/saas-apps/trackvia-tutorial.md) |  | ● |
| [Traction Guest](../identity/saas-apps/traction-guest-tutorial.md) |  | ● |
| [Training Platform](../identity/saas-apps/training-platform-tutorial.md) |  | ● |
| [TransPerfect GlobalLink Dashboard](../identity/saas-apps/transperfect-globallink-dashboard-tutorial.md) |  | ● |
| [Tranxfer](../identity/saas-apps/tranxfer-tutorial.md) |  | ● |
| [TravelPerk](../identity/saas-apps/travelperk-provisioning-tutorial.md) | ● | ● |
| [Tribeloo](../identity/saas-apps/tribeloo-provisioning-tutorial.md) | ● | ● |
| [Trisotech Digital Enterprise Server](../identity/saas-apps/trisotechdigitalenterpriseserver-tutorial.md) |  | ● |
| [TrueChoice](../identity/saas-apps/truechoice-tutorial.md) |  | ● |
| [TrustWorks](../identity/saas-apps/trustworks-tutorial.md) |  | ● |
| [Twilio Sendgrid](../identity/saas-apps/twilio-sendgrid-tutorial.md) |  | ● |
| [Twingate](../identity/saas-apps/twingate-provisioning-tutorial.md) | ● |  |
| [Uber](../identity/saas-apps/uber-provisioning-tutorial.md) | ● |  |
| [Udemy Business SAML](../identity/saas-apps/udemy-business-saml-tutorial.md) |  | ● |
| [UKG Pro](../identity/saas-apps/ultipro-tutorial.md) |  | ● |
| [uni-tel A/S](../identity/saas-apps/uni-tel-as-provisioning-tutorial.md) | ● |  |
| [UNIFI](../identity/saas-apps/unifi-provisioning-tutorial.md) | ● | ● |
| [uniFlow Online](../identity/saas-apps/uniflow-online-provisioning-tutorial.md) | ● | ● |
| [Unite Us](../identity/saas-apps/unite-us-tutorial.md) |  | ● |
| [Upwork Enterprise](../identity/saas-apps/upwork-enterprise-tutorial.md) |  | ● |
| [User Interviews](../identity/saas-apps/user-interviews-tutorial.md) |  | ● |
| [V-Client](../identity/saas-apps/v-client-provisioning-tutorial.md) | ● | ● |
| [Vault Platform](../identity/saas-apps/vault-platform-provisioning-tutorial.md) | ● | ● |
| [Vbrick Rev Cloud](../identity/saas-apps/vbrick-rev-cloud-provisioning-tutorial.md) | ● | ● |
| [Velpic SAML](../identity/saas-apps/velpicsaml-tutorial.md) |  | ● |
| [Velpic](../identity/saas-apps/velpic-provisioning-tutorial.md) | ● | ● |
| [Vera Suite](../identity/saas-apps/vera-suite-tutorial.md) |  | ● |
| [Verity](../identity/saas-apps/verity-tutorial.md) |  | ● |
| [Veza](../identity/saas-apps/veza-tutorial.md) |  | ● |
| [VIDA](../identity/saas-apps/vida-tutorial.md) |  | ● |
| [Vidyard](../identity/saas-apps/vidyard-tutorial.md) |  | ● |
| [Virtual Risk Manager - USA](../identity/saas-apps/virtual-risk-manager-usa-tutorial.md) |  | ● |
| [Visibly](../identity/saas-apps/visibly-provisioning-tutorial.md) | ● | ● |
| [Visitly](../identity/saas-apps/visitly-provisioning-tutorial.md) | ● | ● |
| [Visma](../identity/saas-apps/visma-tutorial.md) |  | ● |
| [VMware Identity Service](~/identity/saas-apps/vmware-identity-service-tutorial.md) |  | ● |
| [Vonage](../identity/saas-apps/vonage-provisioning-tutorial.md) | ● | ● |
| [Voyance](../identity/saas-apps/voyance-tutorial.md) |  | ● |
| [Vtiger CRM (SAML)](../identity/saas-apps/vtiger-crm-saml-tutorial.md) |  | ● |
| [WalkMe SAML2.0](../identity/saas-apps/walkme-saml-tutorial.md) |  | ● |
| [WATS](../identity/saas-apps/wats-provisioning-tutorial.md) | ● |  |
| [Way We Do](../identity/saas-apps/waywedo-tutorial.md) |  | ● |
| [Web Cargo Air](../identity/saas-apps/web-cargo-air-provisioning-tutorial.md) | ● | ● |
| [WebCE](../identity/saas-apps/webce-tutorial.md) |  | ● |
| [Webroot Security Awareness Training](../identity/saas-apps/webroot-security-awareness-training-provisioning-tutorial.md) | ● |  |
| [WebTMA](../identity/saas-apps/webtma-tutorial.md) |  | ● |
| [WEDO](../identity/saas-apps/wedo-provisioning-tutorial.md) | ● | ● |
| [Weekdone](../identity/saas-apps/weekdone-tutorial.md) |  | ● |
| [Whimsical](../identity/saas-apps/whimsical-provisioning-tutorial.md) | ● | ● |
| [Whitesource](../identity/saas-apps/whitesource-tutorial.md) |  | ● |
| [WiggleDesk](../identity/saas-apps/wiggledesk-provisioning-tutorial.md) | ● | ● |
| [WireWheel](../identity/saas-apps/wirewheel-tutorial.md) |  | ● |
| [Wistia](../identity/saas-apps/wistia-tutorial.md) |  | ● |
| [Wiz SSO](../identity/saas-apps/wiz-sso-tutorial.md) |  | ● |
| [Wootric](../identity/saas-apps/wootric-tutorial.md) |  | ● |
| [Workable](../identity/saas-apps/workable-tutorial.md) |  | ● |
| [Workday to Active Directory](../identity/saas-apps/workday-inbound-tutorial.md) | ● | ● |
| [Workday to Microsoft Entra ID](../identity/saas-apps/workday-inbound-cloud-only-tutorial.md) | ● | ● |
| [Workday Writeback](../identity/saas-apps/workday-writeback-tutorial.md) | ● | ● |
| [Workday](../identity/saas-apps/workday-tutorial.md) |  | ● |
| [Workgrid](../identity/saas-apps/workgrid-provisioning-tutorial.md) | ● | ● |
| [Workpath](../identity/saas-apps/workpath-tutorial.md) |  | ● |
| [Workplace from Meta](../identity/saas-apps/workplace-by-facebook-provisioning-tutorial.md) | ● | ● |
| [Workshop](../identity/saas-apps/workshop-tutorial.md) |  | ● |
| [Workteam](../identity/saas-apps/workteam-provisioning-tutorial.md) | ● | ● |
| [Worthix App](../identity/saas-apps/worthix-app-tutorial.md) |  | ● |
| [Wrike](../identity/saas-apps/wrike-provisioning-tutorial.md) | ● | ● |
| [Xledger](../identity/saas-apps/xledger-provisioning-tutorial.md) | ● |  |
| [XM Fax and XM SendSecure](../identity/saas-apps/xm-fax-and-xm-send-secure-provisioning-tutorial.md) | ● | ● |
| [Yardi eLearning](../identity/saas-apps/yardielearning-tutorial.md) |  | ● |
| [YardiOne](../identity/saas-apps/yardione-provisioning-tutorial.md) | ● | ● |
| [Yellowbox](../identity/saas-apps/yellowbox-provisioning-tutorial.md) | ● |  |
| [Yonyx Interactive Guides](../identity/saas-apps/yonyx-tutorial.md) |  | ● |
| [YOU at College](../identity/saas-apps/you-at-college-tutorial.md) |  | ● |
| [Zapier](../identity/saas-apps/zapier-provisioning-tutorial.md) | ● |  |
| [Zendesk](../identity/saas-apps/zendesk-provisioning-tutorial.md) | ● | ● |
| [Zenya](../identity/saas-apps/zenya-provisioning-tutorial.md) | ● | ● |
| [Zero](../identity/saas-apps/zero-provisioning-tutorial.md) | ● | ● |
| [Zip](../identity/saas-apps/zip-provisioning-tutorial.md) | ● | ● |
| [Zoho One](../identity/saas-apps/zoho-one-provisioning-tutorial.md) | ● | ● |
| [Zoom for Government](../identity/saas-apps/zoom-for-government-tutorial.md) |  | ● |
| [Zoom](../identity/saas-apps/zoom-provisioning-tutorial.md) | ● | ● |
| [Zscaler B2B User Portal](../identity/saas-apps/zscaler-b2b-user-portal-tutorial.md) |  | ● |
| [Zscaler Beta](../identity/saas-apps/zscaler-beta-provisioning-tutorial.md) | ● | ● |
| [Zscaler Internet Access ZSCloud](../identity/saas-apps/zscaler-internet-access-zscloud-tutorial.md) |  | ● |
| [Zscaler Internet Access ZSNet](../identity/saas-apps/zscaler-internet-access-zsnet-tutorial.md) |  | ● |
| [Zscaler Internet Access ZSOne](../identity/saas-apps/zscaler-internet-access-zsone-tutorial.md) |  | ● |
| [Zscaler Internet Access ZSThree](../identity/saas-apps/zscaler-internet-access-zsthree-tutorial.md) |  | ● |
| [Zscaler Internet Access ZSTwo](../identity/saas-apps/zscaler-internet-access-zstwo-tutorial.md) |  | ● |
| [Zscaler One](../identity/saas-apps/zscaler-one-provisioning-tutorial.md) | ● | ● |
| [Zscaler Private Access](../identity/saas-apps/zscaler-private-access-provisioning-tutorial.md) | ● | ● |
| [Zscaler Three](../identity/saas-apps/zscaler-three-provisioning-tutorial.md) | ● | ● |
| [Zscaler Two](../identity/saas-apps/zscaler-two-provisioning-tutorial.md) | ● | ● |
| [Zscaler ZSCloud](../identity/saas-apps/zscaler-zscloud-provisioning-tutorial.md) | ● | ● |
| [Zscaler](../identity/saas-apps/zscaler-provisioning-tutorial.md) | ● | ● |
| [Zylo](../identity/saas-apps/zylo-tutorial.md) |  | ● |

## Partner driven integrations
There is also a healthy partner ecosystem, further expanding the breadth and depth of integrations available with Microsoft Entra ID Governance. Explore the [partner integrations](../identity/app-provisioning/partner-driven-integrations.md) available, including connectors for:
* Epic
* Cerner
* IBM RACF
* IBM i (AS/400)
* Aurion People & Payroll

## Next steps

To learn more about application provisioning, see [What is application provisioning](../identity/app-provisioning/user-provisioning.md).

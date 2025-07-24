---
title: Backup Authentication System for Microsoft Entra ID
description: Explore the resilience features of Microsoft Entra ID's backup authentication system, designed to maintain authentication availability for users and services.
ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 07/22/2025
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: joroja
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:07/22/2025
  - ai-gen-description
---
# Microsoft Entra ID's backup authentication system

Organizations around the world depend on the high availability of Microsoft Entra authentication for users and services 24 hours a day, seven days a week. We promise a 99.99% service level availability for authentication, and we continuously seek to improve it by enhancing the resilience of our authentication service. To further improve resilience during outages, we implemented a backup system in 2021.

The Microsoft Entra backup authentication system is made up of multiple backup services that work together to increase authentication resilience if there's an outage. This system transparently and automatically handles authentications for supported applications and services if the primary Microsoft Entra service is unavailable or degraded. It adds an extra layer of resilience on top of the multiple levels of existing redundancy. This resilience is described in the blog post [Advancing service resilience in Microsoft Entra ID with its backup authentication service](https://azure.microsoft.com/blog/advancing-service-resilience-in-azure-active-directory-with-its-backup-authentication-service/). This system syncs authentication metadata when the system is healthy and uses that to enable users to continue to access applications during outages of the primary service while still enforcing policy controls.

During an outage of the primary service, users are able to continue working with their applications, as long as they accessed them in the last three days from the same device, and no blocking policies exist that would curtail their access:

In addition to Microsoft applications, we support:

- Native email clients on iOS and Android.
- Software as a service (SaaS) applications available in the app gallery, like ADP, Atlassian, AWS, GoToMeeting, Kronos, Marketo, SAP, Trello, Workday, and more.
- Selected line of business applications, based on their authentication patterns.

Service to service authentication that relies on managed identities for Azure resources or are built on Azure services receive increased resilience from the backup authentication system.

Microsoft is continuously expanding the number of supported scenarios.

## Which non-Microsoft workloads are supported?

The backup authentication system automatically provides incremental resilience to tens of thousands of supported non-Microsoft applications based on their authentication patterns. See the appendix for a list of the most [common non-Microsoft applications and their coverage status](#appendix). For an in depth explanation of which authentication patterns are supported, see the article [Understanding Application Support for the backup authentication system](backup-authentication-system-apps.md) article.

- Native applications using the Open Authorization (OAuth) 2.0 protocol to access resource applications, such as popular non-Microsoft e-mail and IM clients like: Apple Mail, Aqua Mail, Gmail, Samsung Email, and Spark.
- Line of business web applications configured to authenticate with OpenID Connect using only ID tokens.
- Web applications authenticating with the Security Assertion Markup Language (SAML) protocol, when configured for IDP-Initiated single sign-on (SSO) like: ADP, Atlassian Cloud, AWS, GoToMeeting, Kronos, Marketo, Palo Alto Networks, SAP Cloud Identity Services, Trello, Workday, and Zscaler.

### Non-Microsoft application types that aren't protected

The following auth patterns aren't currently supported:

- Web applications that authenticate using OpenID Connect and request access tokens
- Web applications that use the SAML protocol for authentication, when configured as SP-Initiated SSO

## What makes a user supportable by the backup authentication system?

During an outage, a user can authenticate using the backup authentication system if the following conditions are met:

1. The user successfully authenticated using the same app and device in the last three days.
1. The user isn't required to authenticate interactively
1. The user is accessing a resource as a member of their home tenant, rather than exercising a B2B or B2C scenario.
1. The user isn't subject to Conditional Access policies that limit the backup authentication system, like disabling [resilience defaults](~/identity/conditional-access/resilience-defaults.md).
1. The user hasn't been subject to a revocation event, such as a credential change since their last successful authentication.

### How does interactive authentication and user activity affect resilience?

The backup authentication system relies on metadata from a prior authentication to reauthenticate the user during an outage. A user must have authenticated in the last three days using the same app on the same device for the backup service to be effective. Users who are inactive or haven't authenticated to a given app can't use the backup authentication system for that application.

### How do Conditional Access policies affect resilience?

Certain policies can't be evaluated in real-time by the backup authentication system and must rely on prior evaluations of these policies. Under outage conditions, the service uses a prior evaluation by default to maximize resilience. For example, access that is conditioned on a user having a particular role (like Application Administrator) continues during an outage based on the role the user had during that latest authentication. If the outage-only use of a previous evaluation needs to be restricted, tenant administrators can choose a strict evaluation of all Conditional Access policies, even under outage conditions, by disabling resilience defaults. This decision should be taken with care because disabling [resilience defaults](~/identity/conditional-access/resilience-defaults.md) for a given policy disables those users from using backup authentication. Resilience defaults must be reenabled before an outage occurs for the backup system to provide resilience.

Certain other types of policies don't support use of the backup authentication system. Use of the following policies reduce resilience:

- Use of the [sign-in frequency control](~/identity/conditional-access/concept-conditional-access-session.md#sign-in-frequency) as part of a Conditional Access policy.
- Use of the [authentication methods policy](~/identity/conditional-access/concept-conditional-access-grant.md#require-authentication-strength).
- Use of [classic Conditional Access policies](~/identity/conditional-access/policy-migration-mfa.md).

## Workload identity resilience in the backup authentication system

In addition to user authentication, the backup authentication system provides resilience for [managed identities](~/identity/managed-identities-azure-resources/overview.md) and other key Azure infrastructure by offering a regionally isolated authentication service that is redundantly layered with the primary authentication service. This system enables the infrastructure authentication within an Azure region to be resilient to issues that might occur in another region or within the larger Microsoft Entra service. This system complements Azure's cross-region architecture. Building your own applications using MI and following Azure's [best practices for resilience and availability]() ensures your applications are highly resilient. In addition to MI, this regionally resilient backup system protects key Azure infrastructure and services that keep the cloud functional.

### Summary of infrastructure authentication support

- Your services built-on the Azure Infrastructure using managed identities are protected by the backup authentication system.
- Azure services authenticating with each other are protected by the backup authentication system.
- Your services built on or off Azure when the identities are registered as Service Principals and not "managed identities" **aren't protected** by the backup authentication system.

## Cloud environments that support the backup authentication system

The backup authentication system is supported in all cloud environments except Microsoft Azure operated by 21Vianet. The types of identities supported vary by cloud and have separate authentication endpoints, as described in the following table.

| Azure environment | Microsoft 365 environments | Identities protected | Microsoft Entra authentication endpoint |
| --- | --- | --- | --- |
| Azure Commercial | Commercial and M365 Government | Users and managed identities | ```https://login.microsoftonline.com``` |
| Azure Government | M365 GCC High and DoD | Users and managed identities | ```https://login.microsoftonline.us``` |
| Azure Government Secret | M365 Government Secret | Users and managed identities | Not available |
| Azure Government Top Secret | M365 Government Top Secret | Users and managed identities | Not available |
| Azure operated by 21Vianet | Not available | Managed identities | ```https://login.partner.microsoftonline.cn``` | 

## Appendix

### Popular non-Microsoft native client apps and app gallery applications

| App Name | Protected | Why Not protected? |
| --- | --- | --- |
| ABBYY FlexiCapture 12 | No | SAML SP-initiated |
| Adobe Experience Manager | No | SAML SP-initiated |
| Adobe Identity Management (OIDC) | No | OIDC with Access Token |
| ADP | Yes | Protected |
| Apple Business Manager | No | SAML SP-initiated |
| Apple Internet Accounts | Yes | Protected |
| Apple School Manager | No | OIDC with Access Token |
| Aqua Mail | Yes | Protected |
| Atlassian Cloud | Yes \* | Protected |
| Blackboard Learn | No | SAML SP-initiated |
| Box | No | SAML SP-initiated |
| Brightspace by Desire2Learn | No | SAML SP-initiated |
| Canvas | No | SAML SP-initiated |
| Ceridian Dayforce HCM | No | SAML SP-initiated |
| Cisco AnyConnect | No | SAML SP-initiated |
| Cisco Webex | No | SAML SP-initiated |
| Citrix ADC SAML Connector for Azure AD | No | SAML SP-initiated |
| Clever | No | SAML SP-initiated |
| Cloud Drive Mapper | Yes | Protected |
| Cornerstone Single Sign-on | No | SAML SP-initiated |
| Docusign | No | SAML SP-initiated |
| Druva | No | SAML SP-initiated |
| F5 BIG-IP APM Azure AD integration | No | SAML SP-initiated |
| FortiGate SSL VPN | No | SAML SP-initiated |
| Freshworks | No | SAML SP-initiated |
| Gmail | Yes | Protected |
| Google Cloud / G Suite Connector by Microsoft | No | SAML SP-initiated |
| HubSpot Sales | No | SAML SP-initiated |
| Kronos | Yes \* | Protected |
| Madrasati App | No | SAML SP-initiated |
| OpenAthens | No | SAML SP-initiated |
| Oracle Fusion ERP | No | SAML SP-initiated |
| Palo Alto Networks - GlobalProtect | No | SAML SP-initiated |
| Polycom - Skype for Business Certified Phone | Yes | Protected |
| Salesforce | No | SAML SP-initiated |
| Samsung Email | Yes | Protected |
| SAP Cloud Platform Identity Authentication | No | SAML SP-initiated |
| SAP Concur | Yes \* | SAML SP-initiated |
| SAP Concur Travel and Expense | Yes \* | Protected |
| SAP Fiori | No | SAML SP-initiated |
| SAP NetWeaver | No | SAML SP-initiated |
| SAP SuccessFactors | No | SAML SP-initiated |
| Service Now | No | SAML SP-initiated |
| Slack | No | SAML SP-initiated |
| Smartsheet | No | SAML SP-initiated |
| Spark | Yes | Protected |
| UKG pro | Yes \* | Protected |
| VMware Boxer | Yes | Protected |
| walkMe | No | SAML SP-initiated |
| Workday | No | SAML SP-initiated |
| Workplace from Facebook | No | SAML SP-initiated |
| Zoom | No | SAML SP-initiated |
| Zscaler | Yes \* | Protected |
| Zscaler Private Access (ZPA) | No | SAML SP-initiated |
| Zscaler ZSCloud | No | SAML SP-initiated |

> [!NOTE]
> \* Apps configured to authenticate with the SAML protocol are protected when using IDP-Initiated authentication. Service Provider (SP) initiated SAML configurations aren't supported

### Azure resources and their status

| resource | Azure resource name | Status |
| --- | --- | --- |
| Microsoft.ApiManagement | API Management service in Azure Government and China regions | Protected |
| microsoft.app | App Service | Protected |
| Microsoft.AppConfiguration | Azure App Configuration | Protected |
| Microsoft.AppPlatform | Azure App Service | Protected |
| Microsoft.Authorization | Microsoft Entra ID | Protected |
| Microsoft.Automation | Automation Service | Protected |
| Microsoft.AVX | Azure VMware Solution | Protected |
| Microsoft.Batch | Azure Batch | Protected |
| Microsoft.Cache | Azure Cache for Redis | Protected |
| Microsoft.Cdn | Azure Content Delivery Network | Not protected |
| Microsoft.Chaos | Azure Chaos Engineering | Protected |
| Microsoft.CognitiveServices | Azure AI services APIs and Containers | Protected |
| Microsoft.Communication | Azure Communication Services | Not protected |
| Microsoft.Compute | Azure Virtual Machines | Protected |
| Microsoft.ContainerInstance | Azure Container Instances | Protected |
| Microsoft.ContainerRegistry | Azure Container Registry | Protected |
| Microsoft.ContainerService | Azure Kubernetes Service (deprecated) | Protected |
| Microsoft.Dashboard | Azure Dashboards | Protected |
| Microsoft.DatabaseWatcher | Azure SQL Database Automatic Tuning | Protected |
| Microsoft.DataBox | Azure Data Box | Protected |
| Microsoft.Databricks | Azure Databricks | Not protected |
| Microsoft.DataCollaboration | Azure Data Share | Protected |
| Microsoft.Datadog | Datadog | Protected |
| Microsoft.DataFactory | Azure Data Factory | Protected |
| Microsoft.DataLakeStore | Azure Data Lake Storage Gen1 and Gen2 | Not protected |
| Microsoft.DataProtection | Microsoft Defender for Cloud Apps Data Protection API | Protected |
| Microsoft.DBforMySQL | Azure Database for MySQL | Protected |
| Microsoft.DBforPostgreSQL | Azure Database for PostgreSQL | Protected |
| Microsoft.DelegatedNetwork | Delegated Network Management service | Protected |
| Microsoft.DevCenter | Microsoft Store for Business and Education | Protected |
| Microsoft.Devices | Azure IoT Hub and IoT Central | Not protected |
| Microsoft.DeviceUpdate | Windows 10 IoT Core Services Device Update | Protected |
| Microsoft.DevTestLab | Azure DevTest Labs | Protected |
| Microsoft.DigitalTwins | Azure Digital Twins | Protected |
| Microsoft.DocumentDB | Azure Cosmos DB | Protected |
| Microsoft.EventGrid | Azure Event Grid | Protected |
| Microsoft.EventHub | Azure Event Hubs | Protected |
| Microsoft.HealthBot | Health Bot Service | Protected |
| Microsoft.HealthcareApis | FHIR API for Azure API for FHIR and Microsoft Cloud for Healthcare solutions | Protected |
| Microsoft.HybridContainerService | Azure Arc-enabled Kubernetes | Protected |
| Microsoft.HybridNetwork | Azure Virtual WAN | Protected |
| Microsoft.Insights | Application Insights and Log Analytics | Not protected |
| Microsoft.IoTCentral | IoT Central | Protected |
| Microsoft.Kubernetes | Azure Kubernetes Service (AKS) | Protected |
| Microsoft.Kusto | Azure Data Explorer (Kusto) | Protected |
| Microsoft.LoadTestService | Visual Studio Load Testing Service | Protected |
| Microsoft.Logic | Azure Logic Apps | Protected |
| Microsoft.MachineLearningServices | Machine Learning Services on Azure | Protected |
| Microsoft.managed identity | Managed identities for Microsoft Resources | Protected |
| Microsoft.Maps | Azure Maps | Protected |
| Microsoft.Media | Azure Media Services | Protected |
| Microsoft.Migrate | Azure Migrate | Protected |
| Microsoft.MixedReality | Mixed Reality services including Remote Rendering, Spatial Anchors, and Object Anchors | Not protected |
| Microsoft.NetApp | Azure NetApp Files | Protected |
| Microsoft.Network | Azure Virtual Network | Protected |
| Microsoft.OpenEnergyPlatform | Open Energy Platform (OEP) on Azure | Protected |
| Microsoft.OperationalInsights | Azure Monitor Logs | Protected |
| Microsoft.PowerPlatform | Microsoft Power Platform | Protected |
| Microsoft.Purview | Microsoft Purview (formerly Azure Data Catalog) | Protected |
| Microsoft.Quantum | Microsoft Quantum Development Kit | Protected |
| Microsoft.RecommendationsService | Azure AI services Recommendations API | Protected |
| Microsoft.RecoveryServices | Azure Site Recovery | Protected |
| Microsoft.ResourceConnector | Azure Resource Connector | Protected |
| Microsoft.Scom | System Center Operations Manager | Protected |
| Microsoft.Search | Azure Cognitive Search | Not protected |
| Microsoft.Security | Microsoft Defender for Cloud | Not protected |
| Microsoft.SecurityDetonation | Microsoft Defender for Endpoint Detonation Service | Protected |
| Microsoft.ServiceBus | Service Bus messaging service and Event Grid domain topics | Protected |
| Microsoft.ServiceFabric | Azure Service Fabric | Protected |
| Microsoft.SignalRService | Azure SignalR Service | Protected |
| Microsoft.Solutions | Azure Solutions | Protected |
| Microsoft.Sql | SQL Server on Virtual Machines and SQL Managed Instance on Azure | Protected |
| Microsoft.Storage | Azure Storage | Protected |
| Microsoft.StorageCache | Azure Storage Cache | Protected |
| Microsoft.StorageSync | Azure File Sync | Protected |
| Microsoft.StreamAnalytics | Azure Stream Analytics | Not protected |
| Microsoft.Synapse | Synapse Analytics (formerly SQL DW) and Synapse Studio (formerly SQL DW Studio) | Protected |
| Microsoft.UsageBilling | Azure Usage and Billing Portal | Not protected |
| Microsoft.VideoIndexer | Video Indexer | Protected |
| Microsoft.VoiceServices | Azure Communication Services - Voice APIs | Not protected |
| microsoft.web | Web Apps | Protected |

## Next steps

- [Application requirements for the backup authentication system](backup-authentication-system-apps.md)
- [Introduction to the backup authentication system](https://azure.microsoft.com/blog/advancing-service-resilience-in-azure-active-directory-with-its-backup-authentication-service/)
- [Resilience Defaults for Conditional Access](~/identity/conditional-access/resilience-defaults.md)
- [Microsoft Entra service-level agreement (SLA) performance reporting](~/identity/monitoring-health/reference-sla-performance.md)

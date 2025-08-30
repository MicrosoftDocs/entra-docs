---
title: Microsoft Entra ID and data residency
description: Use residency data to manage access, achieve mobility scenarios, and secure your organization.
author: janicericketts
manager: martinco
ms.service: entra
ms.subservice: fundamentals
ms.topic: concept-article
ms.date: 08/25/2024
ms.author: jricketts
ms.reviewer: jricketts
ms.custom: "it-pro"
ms.collection:
# Customer intent: As a cloud administrator, I want to understand how Microsoft Entra ID handles data residency, so that I can ensure compliance with data residency requirements and make informed decisions about storing and managing identity and access data in the cloud.
---

# Microsoft Entra ID and data residency

Microsoft Entra ID is an Identity as a Service (IDaaS) solution that stores and manages identity and access data in the cloud. You can use the data to enable and manage access to cloud services, achieve mobility scenarios, and secure your organization. An instance of the Microsoft Entra ID service, called a [tenant](~/identity-platform/developer-glossary.md#tenant), is an isolated set of directory object data that the customer provisions and owns.

> [!NOTE]
> Microsoft Entra External ID is a customer identity and access management (CIAM) solution that stores and manages data in a separate tenant created for your customer-facing apps and customer directory data. This tenant is called an external tenant. When you create an external tenant, you have the option to select the geographic location (shown as "Country/Region" in the admin portal) for data storage. It’s important to note that the data locations and region availability may differ from those of Microsoft Entra ID, as indicated in this article.

## Core Store

The Core Store is made up of tenants stored in scale units, each of which contains multiple tenants. Update or retrieval data operations in the Microsoft Entra Core Store relate to a single tenant, based on the user's security token, which achieves tenant isolation. Scale units are assigned to a geo-location. Each geo-location uses two or more Azure regions to store the data. In each Azure region, a scale unit data is replicated in the physical datacenters for resiliency and performance, as described in [the Microsoft Entra architecture](/entra/architecture/architecture).

For more information on the Core Store, see [Microsoft Entra Core Store Scale Units](https://www.youtube.com/watch?v=OcKO44GtHh8). For more information on Azure regions, see [Azure geographies](https://azure.microsoft.com/overview/datacenters/how-to-choose/).

Microsoft Entra ID is available in the following clouds:

- Public
- China*
- US government*

*\* Not currently available for external tenants.*

In the public cloud, you're prompted to select a location (shown as "Country/Region" in the admin portal) at the time of tenant creation (for example, signing up for Office 365 or Azure, or creating more Microsoft Entra instances through the Azure portal). Microsoft Entra ID maps the selection to a geo-location and a single scale unit in it. Tenant location can't be changed after it's set.

The location selected during tenant creation will map to one of the following geo-locations:

- Australia*
- Asia/Pacific
- Europe, Middle East, and Africa (EMEA)
- Japan*
- North America
- Worldwide
 
*\* Available for external tenants with the [Go-Local add-on](#go-local-add-on).*

Microsoft Entra ID handles Core Store data based on usability, performance, residency, or other requirements based on geo-location. Microsoft Entra ID replicates each tenant through its scale unit, across datacenters, based on the following criteria:

- Microsoft Entra Core Store data, stored in datacenters closest to the tenant-residency location, to reduce latency and provide fast user sign-in times
- Microsoft Entra Core Store data stored in geographically isolated datacenters to assure availability during unforeseen single-datacenter, catastrophic events
- Compliance with data residency, or other requirements, for specific customers and geo-locations

<a name='azure-ad-cloud-solution-models'></a>

## Microsoft Entra cloud solution models

Use the following table to see Microsoft Entra cloud solution models based on infrastructure, data location, and operational sovereignty.

|Model|Locations|Data location|Operations personnel|Put a tenant in this model|
|---|---|---|---|---|
|Public geo located|Australia (1), North America, EMEA, Japan (1), Asia/Pacific|At rest, in the target location. Exceptions by component service or feature, listed in the next section|Operated by Microsoft. Microsoft datacenter personnel must pass a background check.|Create the tenant in the sign-up experience. Choose the location for data residency.|
|Public worldwide|Worldwide|All locations|Operated by Microsoft. Microsoft datacenter personnel must pass a background check.|Tenant creation available via official support channel and subject to Microsoft discretion.|
|Sovereign or national clouds|US government (2), China (2)|At rest, in the target location. No exceptions.|Operated by a data custodian (3). Personnel are screened according to requirements.|Each national cloud instance has a sign-up experience.|

**Table references**:

- (1) These locations are available for external tenants with the [Go-Local add-on](#go-local-add-on).
- (2) These locations aren't currently available for external tenants.
- (3) **Data custodians**: datacenters in the US government cloud are operated by Microsoft. In China, Microsoft Entra ID is operated through a partnership with [21Vianet](/microsoft-365/admin/services-in-china/services-in-china?redirectSourcePath=%252fen-us%252farticle%252fLearn-about-Office-365-operated-by-21Vianet-a8ab5061-3346-4da0-bb7c-5260822b53ae&view=o365-21vianet&viewFallbackFrom=o365-worldwide&preserve-view=true).

Learn more:

- [Customer data storage and processing for European customers in Microsoft Entra ID](./data-storage-eu.md)
- [Customer data storage for Australian and New Zealand customers in Microsoft Entra ID](./data-storage-australia-newzealand.md) and [Identity data storage for Australian and New Zealand customers in Microsoft Entra ID](./data-storage-australia.md)
- [Customer data storage for Japan customers in Microsoft Entra ID](./data-storage-japan.md)
- [Microsoft Trust Center - Where your data is located](https://www.microsoft.com/en-us/trust-center/privacy/data-location)

<a name='data-residency-across-azure-ad-components'></a>

## Data residency across Microsoft Entra components

Learn more: [Microsoft Entra product overview](https://www.microsoft.com/cloud-platform/azure-active-directory-features)

> [!NOTE]
> To understand service data location for other services beyond Microsoft Entra ID, such as Exchange Online, or Skype for Business, refer to the corresponding service documentation and the [Trust Center](https://www.microsoft.com/trust-center/privacy/data-location).

<a name='azure-ad-components-and-data-storage-location'></a>

### Microsoft Entra components and data storage location

|Microsoft Entra component|Description|Data storage location|
|---|---|---|
|Microsoft Entra authentication Service|This service is stateless. The data for authentication is in the Microsoft Entra Core Store. It has no directory data. Microsoft Entra authentication Service generates log data in Azure Storage, and in the datacenter where the service instance runs. When users attempt to authenticate using Microsoft Entra ID, they're routed to an instance in the geographically nearest datacenter that is part of its Microsoft Entra logical region. |In geo location|
|Microsoft Entra identity and Access Management (IAM) Services|**User and management experiences**: The Microsoft Entra management experience is stateless and has no directory data. It generates log and usage data stored in Azure Tables storage. The user experience is like the Azure portal. <br>**Identity management business logic and reporting services**: These services have locally cached data storage for groups and users. The services generate log and usage data that goes to Azure Tables storage, Azure SQL, and in Microsoft Elastic Search reporting services. |In geo location|
|Microsoft Entra multifactor authentication|For details about multifactor authentication-operations data storage and retention, see [Data residency and customer data for Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-data-residency.md). Microsoft Entra multifactor authentication logs the User Principal Name (UPN), voice-call telephone numbers, and SMS challenges. For challenges to mobile app modes, the service logs the UPN and a unique device token.|North America and/or in geo location|
|Microsoft Entra Domain Services|See regions where Microsoft Entra Domain Services is published on [Products available by region](https://azure.microsoft.com/regions/services/). The service holds system metadata globally in Azure Tables, and it contains no personal data.|In geo location|
|Microsoft Entra Connect Health|Microsoft Entra Connect Health generates alerts and reports in Azure Tables storage and blob storage.|In geo location|
|Microsoft Entra dynamic membership groups, Microsoft Entra self-service group management|Azure Tables storage holds rule definitions for dynamic membership groups.|In geo location|
|Microsoft Entra application proxy|Microsoft Entra application proxy stores metadata about the tenant, connector machines, and configuration data in Azure SQL.|In geo location|
|Microsoft Entra password writeback in Microsoft Entra Connect|During initial configuration, Microsoft Entra Connect generates an asymmetric keypair, using the Rivest–Shamir–Adleman (RSA) cryptosystem. It then sends the public key to the self-service password reset (SSPR) cloud service, which performs two operations: </br></br>1. Creates two Azure Service Bus relays for the Microsoft Entra Connect on-premises service to communicate securely with the SSPR service </br> 2. Generates an Advanced Encryption Standard (AES) key, K1 </br></br> The Azure Service Bus relay locations, corresponding listener keys, and a copy of the AES key (K1) goes to Microsoft Entra Connect in the response. Future communications between SSPR and Microsoft Entra Connect occur over the new ServiceBus channel and are encrypted using SSL. </br> New password resets, submitted during operation, are encrypted with the RSA public key generated by the client during onboarding. The private key on the Microsoft Entra Connect machine decrypts them, which prevents pipeline subsystems from accessing the plaintext password. </br> The AES key encrypts the message payload (encrypted passwords, more data, and metadata), which prevents malicious ServiceBus attackers from tampering with the payload, even with full access to the internal ServiceBus channel. </br> For password writeback, Microsoft Entra Connect need keys and data: </br></br> - The AES key (K1) that encrypts the reset payload, or change requests from the SSPR service to Microsoft Entra Connect, via the ServiceBus pipeline </br> - The private key, from the asymmetric key pair that decrypts the passwords, in reset or change request payloads </br> - The ServiceBus listener keys </br></br> The AES key (K1) and the asymmetric keypair rotate a minimum of every 180 days, a duration you can change during certain onboarding or offboarding configuration events. An example is a customer disables and reenables password writeback, which might occur during component upgrade during service and maintenance. </br> The writeback keys and data stored in the Microsoft Entra Connect database are encrypted by data protection application programming interfaces (DPAPI) (CALG_AES_256). The result is the master ADSync encryption key stored in the Windows Credential Vault in the context of the ADSync on-premises service account. The Windows Credential Vault supplies automatic secret reencryption as the password for the service account changes. To reset the service account password invalidates secrets in the Windows Credential Vault for the service account. Manual changes to a new service account might invalidate the stored secrets.</br> By default, the ADSync service runs in the context of a virtual service account. The account might be customized during installation to a least-privileged domain service account, a managed service account (Microsoft account), or a group managed service account (gMSA). While virtual and managed service accounts have automatic password rotation, customers manage password rotation for a custom provisioned domain account. As noted, to reset the password causes loss of stored secrets. |In geo location|
|Microsoft Entra Device Registration Service |Microsoft Entra Device Registration Service has computer and device lifecycle management in the directory, which enable scenarios such as device-state Conditional Access, and mobile device management.|In geo location|
|Microsoft Entra provisioning|Microsoft Entra provisioning creates, removes, and updates users in systems, such as software as service (software as a service (SaaS)) applications. It manages user creation in Microsoft Entra ID and on-premises Microsoft Windows Server Active Directory from cloud HR sources, like Workday. The service stores its configuration in an Azure Cosmos DB instance, which stores the group membership data for the user directory it keeps. Azure Cosmos DB replicates the database to multiple datacenters in the same region as the tenant, which isolates the data, according to the Microsoft Entra cloud solution model. Replication creates high availability and multiple reading and writing endpoints. Azure Cosmos DB has encryption on the database information, and the encryption keys are stored in the secrets storage for Microsoft.|In geo location|
|Microsoft Entra business-to-business (B2B) collaboration|Microsoft Entra B2B collaboration has no directory data. Users and other directory objects in a B2B relationship, with another tenant, result in user data copied in other tenants, which might have data residency implications.|In geo location|
|Microsoft Entra ID Protection|Microsoft Entra ID Protection uses real-time user log-in data, with multiple signals from company and industry sources, to feed its machine-learning systems that detect anomalous logins. Personal data is scrubbed from real-time log-in data before it's passed to the machine learning system. The remaining log-in data identifies potentially risky usernames and logins. After analysis, the data goes to Microsoft reporting systems. Risky logins and usernames appear in reporting for Administrators.|In geo location|
|Managed identities for Azure resources| Managed identities for Azure resources with managed identities systems can authenticate to Azure services, without storing credentials. Rather than use username and password, managed identities authenticate to Azure services with certificates. The service writes certificates it issues in Azure Cosmos DB in the East US region, which fail over to another region, as needed. Azure Cosmos DB geo-redundancy occurs by global data replication. Database replication puts a read-only copy in each region that Microsoft Entra managed identities runs. To learn more, see [Azure services that can use managed identities to access other services](~/identity/managed-identities-azure-resources/managed-identities-status.md). Microsoft isolates each Azure Cosmos DB instance in a Microsoft Entra cloud solution model. </br> The resource provider, such as the virtual machine (VM) host, stores the certificate for authentication, and identity flows, with other Azure services. The service stores its master key to access Azure Cosmos DB in a datacenter secrets management service. Azure Key Vault stores the master encryption keys.|In geo location|

## Go-Local add-on

The Go-Local add-on is a feature in Microsoft Entra External ID that enables certain customers to configure some services to store their data at rest in a selected geographic location, such as a country or region. This capability is a way of fulfilling corporate policies and compliance requirements. You select the country or region for data storage when you [create an external tenant](../external-id/customers/how-to-create-external-tenant-portal.md).

The Go-Local add-on is a paid add-on, but it's optional. If you choose to use it, you'll incur an extra charge in addition to your Microsoft Entra External ID Basic. For more information, see [Microsoft Entra External ID pricing](https://www.microsoft.com/en-us/security/pricing/microsoft-entra-external-id/).

The following countries/regions currently have the local data residence option:

- Australia
- Japan

## Related resources

For more information on data residency in Microsoft Cloud offerings, see the following articles:

- [Data Residency in Azure | Microsoft Azure](https://azure.microsoft.com/explore/global-infrastructure/data-residency/#overview)
- [Microsoft 365 data locations - Microsoft 365 Enterprise](/microsoft-365/enterprise/o365-data-locations?view=o365-worldwide&preserve-view=true)
- [Microsoft Privacy - Where is Your Data Located?](https://www.microsoft.com/trust-center/privacy/data-location?rtc=1)
- Download PDF: [Privacy considerations in the cloud](https://go.microsoft.com/fwlink/p/?LinkID=2051117&clcid=0x409&culture=en-us&country=US)

## Next steps

- [Microsoft Entra ID and data residency](data-residency.md) (You're here)
- [Data operational considerations](data-operational-considerations.md)
- [Data protection considerations](data-protection-considerations.md)

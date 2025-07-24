---
title: API-driven inbound provisioning concepts
description: An overview of API-driven inbound provisioning.

author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: reference
ms.date: 07/24/2025
ms.author: jfields
ms.reviewer: chmutali
---

# API-driven inbound provisioning concepts

This document provides a conceptual overview of the Microsoft Entra API-driven inbound user provisioning.

## Introduction

Today enterprises have various authoritative systems of record. To establish end-to-end identity lifecycle, strengthen security posture and stay compliant with regulations, identity data in Microsoft Entra ID must be kept in sync with workforce data managed in these systems of record. The *system of record* could be an HR app, a payroll app, a spreadsheet, or SQL tables in a database hosted either on-premises or in the cloud. 

With API-driven inbound provisioning, the Microsoft Entra provisioning service now supports integration with *any* system of record. Customers and partners can use *any* automation tool of their choice to retrieve workforce data from the system of record and ingest it into Microsoft Entra ID. The IT admin has full control on how the data is processed and transformed with attribute mappings. Once the workforce data is available in Microsoft Entra ID, the IT admin can configure appropriate joiner-mover-leaver business processes using [Lifecycle Workflows](~/id-governance/what-are-lifecycle-workflows.md).  

## Supported scenarios

Several inbound user provisioning scenarios are enabled using API-driven inbound provisioning. This diagram demonstrates the most common scenarios.

:::image type="content" source="media/inbound-provisioning-api-concepts/api-workflow-scenarios.png" alt-text="Diagram showing API workflow scenarios." lightbox="media/inbound-provisioning-api-concepts/api-workflow-scenarios.png":::

### Scenario 1: Enable IT teams to import HR data extracts using any automation tool
Flat files, CSV files and SQL staging tables are commonly used in enterprise integration scenarios. Employee, contractor, and vendor information are periodically exported into one of these formats and an automation tool is used to sync this data with enterprise identity directories. With API-driven inbound provisioning, IT teams can use any automation tool of their choice (example: PowerShell scripts or Azure Logic Apps) to modernize and simplify this integration.   

<a name='scenario-2-enable-isvs-to-build-direct-integration-with-azure-ad'></a>

### Scenario 2: Enable ISVs to build direct integration with Microsoft Entra ID
With API-driven inbound provisioning, HR ISVs can ship native synchronization experiences so that changes in the HR system automatically flow into Microsoft Entra ID and connected on-premises Active Directory domains. For example, an HR app or student information systems app can send data to Microsoft Entra ID as soon as a transaction is complete or as end-of-day bulk update. 

### Scenario 3: Enable system integrators to build more connectors to systems of record
Partners can build custom HR connectors to meet different integration requirements around data flow from systems of record to Microsoft Entra ID. 

In all of the above scenarios, integration is simplified as the Microsoft Entra provisioning service takes over the responsibility of performing identity profile comparison, restricting the data sync to scoping logic configured by the IT admin, and executing rule-based attribute flow and transformation managed in the Microsoft Entra admin center.   

## End-to-end flow
:::image type="content" source="media/inbound-provisioning-api-concepts/end-to-end-workflow.png" alt-text="Diagram of the end-to-end workflow of inbound provisioning." lightbox="media/inbound-provisioning-api-concepts/end-to-end-workflow.png":::

### Steps of the workflow

1. IT Admin configures [an API-driven inbound user provisioning app](inbound-provisioning-api-configure-app.md) from the Microsoft Entra Enterprise App gallery. 
1. IT Admin [grants access permissions](inbound-provisioning-api-grant-access.md) and provides endpoint access details to the API developer/partner/system integrator.
1. The API developer/partner/system integrator builds an API client to send authoritative identity data to Microsoft Entra ID.
1. The API client reads identity data from the authoritative source.
1. The API client sends a POST request to provisioning [/bulkUpload](/graph/api/synchronization-synchronizationjob-post-bulkupload) API endpoint associated with the provisioning app. 
     >[!NOTE] 
     > The API client doesn't need to perform any comparisons between the source attributes and the target attribute values to determine what operation (create/update/enable/disable) to invoke. This is automatically handled by the provisioning service. The API client simply uploads the identity data read from the source system by packaging it as bulk request using SCIM schema constructs. 
1. If successful, an ```Accepted 202 Status``` is returned. 
1. The Microsoft Entra provisioning service processes the data received, applies the attribute mapping rules, and completes user provisioning.
1. Depending on the provisioning app that's configured, the user is provisioned either into on-premises Active Directory (for hybrid users) or Microsoft Entra ID (for cloud-only users).
1. The API Client then queries the provisioning logs API endpoint for the status of each record sent.
1. If the processing of any record fails, the API client can check the error details and include records corresponding to the failed operations in the next bulk request (step 5). 
1. At any time, the IT Admin can check the status of the provisioning job and view events in the provisioning logs.

### Key features of API-driven inbound user provisioning

- Available as a provisioning app that exposes an *asynchronous* Microsoft Graph provisioning [/bulkUpload](/graph/api/synchronization-synchronizationjob-post-bulkupload) API endpoint accessed using valid OAuth token.
- Tenant admins must grant API clients interacting with this provisioning app the Graph permissions `SynchronizationData-User.Upload`, `SynchronizationData-User.Upload.OwnedBy` (for ISVs), and `ProvisioningLog.Read.All`. 
- The Graph API endpoint accepts valid bulk request payloads using SCIM schema constructs.
- With SCIM schema extensions, you can send any attribute in the bulk request payload. 
- The bulkUpload API endpoint enforces the following throttling limits:
    - There is a limit of 40 API calls within any 5-second window. If this threshold is exceeded, the service returns an HTTP 429 (Too Many Requests) response. To avoid throttling, implement pacing logic in the client to space out requests - such as adding delays or rate-limit handling between submissions.
    - There is a tenant-level limit of 2,000 API calls per 24-hour period under the Entra ID P1/P2 license, and 6,000 API calls under the Entra ID Governance license. Exceeding these limits results in an HTTP 429 (Too Many Requests) response. To stay within the quota, ensure that your SCIM bulk payloads are optimized to include up to 50 operations per API call.
- Each API endpoint is associated with a specific provisioning app in Microsoft Entra ID. You can integrate multiple data sources by creating a provisioning app for each data source. 
- Incoming bulk request payloads are processed in near real-time.
- Admins can check provisioning progress by viewing the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md). 
- API clients can track progress by querying [provisioning logs API](/graph/api/resources/provisioningobjectsummary).

### License requirements

This feature is available with Microsoft Entra ID P1, P2, and Microsoft Entra ID Governance licenses. To find the right license for your requirements, see [Microsoft Entra ID Governance licensing fundamentals.](https://go.microsoft.com/fwlink/?linkid=2262973)

### API usage guidance

The `/bulkUpload` API endpoint expands the number of ways that you can manage users in Microsoft Entra ID. To help you determine if the `/bulkUpload` API endpoint is right for your integration scenario, refer to this table that compares it with other API-based integration options.

| Use Case Scenario to API mapping | User creation API | HR inbound bulk API |  User invitation API | Direct assignment API |
|-------|-------|-------|-------|-------|
| *When your identity creation scenario is...*  | Ad-hoc user creation in Microsoft Entra ID for a user not associated with any worker in an HR source | Sourcing employee records from an authoritative HR source, and you want those employees to have "member" accounts in Microsoft Entra ID or on-premises Active Directory  | Ad-hoc guest user creation in Microsoft Entra ID, for sharing purposes, where the guest has unique access rights  | Access assignment for existing users, and (preview) guest creation in Microsoft Entra ID, to give the new guest standardized access |
| *...use the API...* | [Create user](https://go.microsoft.com/fwlink/?linkid=2261811) | [Perform bulkUpload](https://go.microsoft.com/fwlink/?linkid=2261471). | [Create invitation](https://go.microsoft.com/fwlink/?linkid=2261635) | [Create accessPackageAssignmentRequest](/graph/api/entitlementmanagement-post-assignmentrequests?view=graph-rest-1.0&tabs=http&preserve-view=true) |
| *The resulting user is first created in...* | Microsoft Entra ID | On-premises Active Directory or Microsoft Entra ID | Microsoft Entra ID | Microsoft Entra ID |
| *The resulting user authenticates to...* | Microsoft Entra ID, with the password you supply | On-premises Active Directory of Microsoft Entra ID, with a [Temporary Access Pass provided by Entra Lifecycle workflows](https://go.microsoft.com/fwlink/?linkid=2261542) | Home tenant or other identity provider | Home tenant or other identity provider | 
| *Subsequent updates to the user can be done via* | Graph API or Microsoft Entra admin center | Graph API or HR inbound bulk API or Microsoft Entra admin center | Graph API or Microsoft Entra admin center | Graph API or Microsoft Entra admin center |
| *The lifecycle of user when their employment starts, is determined by...* | Manual processes | [Entra onboarding Lifecycle workflows](~/id-governance/tutorial-onboard-custom-workflow-portal.md) that trigger based on the `employeeHireDate` attribute | Entitlement management | [Automatic assignment](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md) using Entitlement management access packages |
| *The lifecycle of user when their employment is terminated is determined by...* | Manual processes | [Entra offboarding lifecycle workflows](~/id-governance/tutorial-scheduled-leaver-portal.md) that trigger based on the `employeeLeaveDateTime` attribute | Access reviews | Entitlement management when the user loses their last access package assignment, they're removed |


### Recommended learning path

| # | Learning objective | Guidance |
|-------|-------|-------|
| 1. | You want to learn more about the inbound provisioning API specs. | Refer to [/bulkUpload](/graph/api/synchronization-synchronizationjob-post-bulkupload) API spec document. |
| 2. | You want to get more familiar with the API-driven provisioning concepts, scenarios and limitations. | Refer to  [Frequently asked questions about API-driven inbound provisioning](inbound-provisioning-api-faqs.md). |
| 3. | As an *Admin user*, you want to quickly test the inbound provisioning API. | * Create [API-driven inbound provisioning app](inbound-provisioning-api-configure-app.md) <br> * [Test API using Graph Explorer](inbound-provisioning-api-graph-explorer.md) |
| 4. | With a service account or managed identity, you want to quickly test the inbound provisioning API. | * Create [API-driven inbound provisioning app](inbound-provisioning-api-configure-app.md) <br> * Grant [API permissions](inbound-provisioning-api-grant-access.md) <br> * [Test API using cURL](inbound-provisioning-api-curl-tutorial.md) |
| 5. | You want to extend the API-driven provisioning app to process more custom attributes. | Refer to the tutorial [Extend API-driven provisioning to sync custom attributes](inbound-provisioning-api-custom-attributes.md) |
| 6. | You want to automate data upload from your system of record to the inbound provisioning API endpoint. | Refer to the tutorials <br> * [Quick start with PowerShell](inbound-provisioning-api-powershell.md) <br> * [Quick start with Azure Logic Apps](inbound-provisioning-api-logic-apps.md) |
| 7. | You want to troubleshoot inbound provisioning API issues | Refer to the [Troubleshooting guide](inbound-provisioning-api-issues.md). | 

### External learning resources

The following content, created by our partners and Microsoft MVPs, offers extra guidance on how to deploy and configure API-driven provisioning for various integration scenarios.

- Video tutorials
     - John Savill explains [how API-driven provisioning works](https://www.youtube.com/watch?v=olkOYEyJB1o)
     - Microsoft MVP Nick Ross explains [how to configure API-driven provisioning](https://www.youtube.com/watch?v=4FLEroQ8zmQ)
     - Microsoft MVP Nick Ross explains [how to source HR data from an Excel file in SharePoint using Power Automate and API-driven provisioning](https://www.youtube.com/watch?v=QN6SsamvS9c)
     - Microsoft partner [IdentityXP 4-part series on API-driven provisioning](https://www.youtube.com/watch?v=7ZPDnhwKz_w)

- Blog posts, presentations, and other useful links
     - Microsoft MVP Pim Jacob's article explaining [how to perform Bamboo HR API-driven provisioning to on-premises Active Directory](https://identity-man.eu/2023/10/25/using-the-brand-new-entra-inbound-provisioning-api-for-identity-lifecycle-management/)
     - Microsoft MVP Pim Jacob's presentation on [how to configure the joiner and leaver process using API-driven provisioning and lifecycle workflows](https://github.com/IdentityMan/presentations/blob/main/DutchMicrosoftSecurityMeetup/Dutch%20SecMeetup%20-%20Securing%20Joiner%20&%20Leaver%20process%20with%20Inbound%20Provisioning%20and%20LCW.pdf)
     - Microsoft MVP Marius Solbakken's article explaining [how to source Excel data using PowerShell script and API-driven provisioning](https://goodworkaround.com/2023/08/01/testing-out-the-entra-id-inbound-provisioning-api/)
     - Suryendu Bhattacharyya's article on [how to invoke API-driving provisioning using custom GitHub Action](https://suryendub.github.io/2023-11-25-github-action-for-inbound-api-provisioning/)
     - Microsoft MVP Jan Vidar Elven's [Bicep template for API-driven provisioning](https://github.com/JanVidarElven/ExpertsLiveEurope2023/tree/main/EntraIDGovernance/Elven%20Inbound%20Provisioning%20API)


## Next steps
- [Configure API-driven inbound provisioning app](inbound-provisioning-api-configure-app.md)
- [Frequently asked questions about API-driven inbound provisioning](inbound-provisioning-api-faqs.md)

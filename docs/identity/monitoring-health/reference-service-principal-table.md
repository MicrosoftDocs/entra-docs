---
title: First party app service principal reference table
description: Reference table that maps application IDs to applications and their service principal usage from the sign-in logs.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: reference
ms.subservice: monitoring-health
ms.date: 02/20/2025
ms.author: sarahlipsey
ms.reviewer: dhanyahk
---
# Microsoft service principal sign-in logs table

The Microsoft service principal sign-in logs capture authentication events for Microsoft services. It can be helpful to understand what's happening with some service-to-service authentication events in your tenant. While not necessary for security investigations, the information can be useful for understanding how your services are interacting with each other.

This article provides a table that maps the application IDs from the logs to the application name. A description of the authentication even is also provided.

## How to access the logs

These logs are only available by configuring diagnostic settings in Microsoft Entra to route the logs to an endpoint of your choice. For full guidance on this process, see [Configure diagnostic settings](howto-configure-diagnostic-settings.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Identity** > **Monitoring & health** > **Diagnostics**.
1. Adjust the filters accordingly.
1. Select **+ Add diagnostic setting**.
1. 

## Microsoft service principal sign-in logs

| Application display name | Application ID | Description |
|---|---|---|
| AAD App Management | f0ae4899-d877-4d3c-ae25-679e38eea492 | Provides a single sign-on experience with access management to line of business applications, such as Salesforce or ServiceNow. |
| AAD Applications ARM RP | c8e14c19-0ae6-4966-bd07-17e5ffa8e4ce | Creates and manages first party and non-Microsoft apps in internal Microsoft Services and infrastructure tenants only.<br/>This app does not work outside of allowlisted tenants. |
| App Protection | c6e44401-4d0a-4542-ab22-ecd4c90d28d7 | Automatically disables applications based on user-defined and predefined policies.<br/>This app doesn't create app registrations or service principals in your tenant but can disable a service principal associated with a suspicious application. |
| Azure AD Application Proxy | 47ee738b-3f1a-4fc7-ab11-37e4822b007e | Provides ability to publish applications inside your private network and provides access to users outside your network.<br/>This app is used as part of workflows for both Microsoft Entra Private Access and Microsoft Entra Application Proxy. |
| Azure AD Notification | fc03f97a-9db0-4627-a216-ec98ce54e018 | |
| Azure ESTS Service | fc03f97a-9db0-4627-a216-ec98ce54e018 | Standards compliant authentication service for Microsoft Entra. |
| Azure HDInsight Cluster API | fc03f97a-9db0-4627-a216-ec98ce54e018 | Big data analytics service that includes the Apache Hadoop and Apache Spark ecosystems, which enables the processing of massive amounts of data. |
| Azure Machine Learning | 0736f41a-0425-4b46-bdb5-1563eff02385 | Cloud service for accelerating and managing the machine learning project lifecycle. |
| Azure Security Insights | 98785600-1bb7-4fb9-b9fa-19afe2c8a360 | Cloud-native solution that provides Security Information and Event Management (SIEM) and Security Orchestration, Automation, and Response (SOAR) functionality. |
| Azure SQL Managed Instance to Azure AD Resource Provider | 913c6de4-2a4a-4a61-a9ce-945d2b2ce2e0 | Platform as a service (PaaS) that offers cloud-enhanced SQL Server within an isolated private virtual network environment. |
| Bot Framework Dev Portal |f3723d34-6ff5-4ceb-a148-d99dcd2511fc | Creates an app registration on behalf of the user when the Azure Bot Service (ABS) is asked to create a new app registration during the ABS resource creation process. |
| CPIM Service | bb2a2e3a-c5e7-4f0a-88e0-8e01fd3fc1f4 | The Customer and Partner Identity Management (CPIM) service provides a solution for customers to create user directories for external identities to authenticate to apps registered in their tenant.<br/>These external identity features can include social identity providers, such as Google or Facebook, self-service sign-up, and API connectors in the self-service sign-up flow. |
| Dynamics Lifecycle services | bb2a2e3a-c5e7-4f0a-88e0-8e01fd3fc1f4 | An Azure-based portal that provides a unifying, collaborative environment for customers and partners to manage the application lifecycle of their Microsoft Dynamics implementations. |
| Fabric Identity Management | c0be6b4c-212d-4ca9-8a35-fd260fe22342 | Creates and manages Fabric Workspace Identities. |
| MDATPNetworkScanAgent | 04687a56-4fc2-4e36-b274-b862fb649733 | Creates non-Microsoft apps within the customer tenant for each NetworkScan agent registered at customer sites. |
| Microsoft Rights Management Services | 00000012-0000-0000-c000-000000000000 | Also known as the Azure Rights Management Service, this app applies encryption via Purview labels and other encryption related tasks. |
|



---
title: Office 365 App in Conditional Access reference
description: What are all of the services included in the Office 365 app in Microsoft Entra Conditional Access
ms.topic: reference
ms.date: 06/05/2026
ms.reviewer: kvenkit
ai-usage: ai-assisted
---

# Apps included in Conditional Access Office 365 app suite

Microsoft 365 offers cloud-based productivity and collaboration services like Exchange, SharePoint, and Microsoft Teams. In Conditional Access, the Microsoft 365 suite of applications appears under **Office 365**. These cloud services are deeply integrated, which means some apps like Microsoft Teams depend on others like SharePoint or Exchange.

The Office 365 app grouping makes it possible to target these services all at once. Use the Office 365 grouping instead of targeting individual cloud apps to avoid issues with [service dependencies](service-dependencies.md). Targeting this group helps avoid issues that might arise from inconsistent policies and dependencies. For example, Exchange Online is tied to traditional Exchange Online data like mail, calendar, and contact information, but related metadata might be exposed through different resources like search. Assigning policies to the Office 365 app helps ensure that all related metadata is protected as intended.

For more information about when to use this app grouping, see [Office 365](concept-conditional-access-cloud-apps.md#office-365).

## About this list

The following list includes all services and applications that are part of the Office 365 app in Conditional Access. This list is subject to change as Microsoft adds or removes services. To view the current list of applications in your tenant, go to the [Microsoft Entra admin center](https://entra.microsoft.com) > **Protection** > **Conditional Access** > **Policies** and select the **Office 365** cloud app in the target resources configuration.

> [!NOTE]
> This list includes both user-facing applications and backend services. Some entries might be internal service names that aren't directly visible to end users.

## Included applications

- AI Hub Services
- App Studio for Microsoft Teams
- Augmentation Loop
- Call Recorder
- Connectors
- Copilot Data Platform
- DataSecurityInvestigation
- Device Management Service
- EDU Assignments
- EnrichmentSvc
- Enterprise Copilot Platform
- Groups Service
- IC3 Gateway
- IC3 Gateway Non Cae
- Insights Services
- INT Augmentation Loop 1P
- Legacy Smart Compose
- Loop
- Loop Web Application
- Loop Web Service
- M365 Admin Services
- M365 Auditing Public Protected Web API app
- M365ChatClient
- make.gov.powerapps.us
- make.powerapps.com
- Media Analysis and Transformation Service
- Message Recall
- Messaging Async Media
- MessagingAsyncMediaProd
- Microsoft 365 eSignature
- Microsoft 365 eSignature PPE
- Microsoft 365 Reporting Service
- Microsoft Discovery Service
- Microsoft Exchange Online Protection
- Microsoft Flow Portal
- Microsoft Flow Portal GCC
- Microsoft Forms
- Microsoft Forms Web
- Microsoft Information Protection API
- Microsoft Office
- Microsoft Office 365 Portal
- Microsoft People Cards Service
- Microsoft Planner
- Microsoft Planner Client
- Microsoft SharePoint Online - SharePoint Home
- Microsoft Stream Portal
- Microsoft Stream Service
- Microsoft Teams
- Microsoft Teams - T4L Web Client
- Microsoft Teams - Teams And Channels Service
- Microsoft Teams Analytics
- Microsoft Teams Chat Aggregator
- Microsoft Teams Graph Service
- Microsoft Teams Mailhook
- Microsoft Teams Retail Service
- Microsoft Teams Services
- Microsoft Teams Targeting Application
- Microsoft Teams UIS
- Microsoft Teams Web Client
- Microsoft To-Do web app
- Microsoft Todo web app
- Microsoft Virtual Events Portal
- Microsoft Virtual Events Services
- Microsoft Visio Data Visualizer
- Microsoft Whiteboard Services
- MSAI Substrate Meeting Intelligence
- Natural Language Editor
- O365 Diagnostic Service
- O365 Suite UX
- O365 Suite UX PathFinder
- OCPS Checkin Service
- Office 365
- Office 365 Exchange Microservices
- Office 365 Exchange Online
- Office 365 Search Service
- Office 365 SharePoint Online
- Office Collab Actions
- Office Delve
- Office Hive
- Office Hive Fairfax
- Office MRO Device Manager Service
- Office Notification Service
- Office Online Add-in SSO
- Office Online Augmentation Loop SSO
- Office Online Core SSO
- Office Online Loki SSO
- Office Online Maker SSO
- Office Online Print SSO
- Office Online Search SSO
- Office Online Service
- Office Online Speech SSO
- Office Scripts Service
- Office Scripts Service - INT
- Office Scripts Service - Local
- Office Scripts Service - Test
- Office Shredding Service
- Office.com
- Office365 Shell DoD WCSS-Client
- Office365 Shell WCSS-Client
- OfficeClientService
- OfficeHome
- OfficePowerPointSGS
- OfficeServicesManager
- Olympus
- OMEX External
- One Outlook Web
- OneDrive
- OneDrive SyncEngine
- OneNote
- OneOutlook
- Outlook Browser Extension
- Outlook Service for Exchange
- PowerApps Service
- Project for the web
- ProjectWorkManagement
- ProjectWorkManagement_AdminTools
- ProjectWorkManagement_USGov
- Protection Center
- Reply-At-Mention
- SharePoint Notification Services
- SharePoint Notification Services Fairfax
- SharePoint Online Web Client Extensibility
- SharePoint Online Web Client Extensibility Isolated
- Skype and Teams Tenant Admin API
- Skype for Business
- Skype for Business Online
- Skype Presence Service
- Sway
- Targeted Messaging Service
- Teams CMD Services Artifacts
- Teams Device Management Services
- Teams Walkie Talkie Service
- Teams Walkie Talkie Service - GCC
- Viva Engage

## Look up application IDs in your tenant

The application IDs—also called client IDs—for these apps aren't secrets. They're public identifiers, so you can look them up for the Microsoft apps in your own tenant. The following methods show the names and IDs of the Microsoft service principals in your tenant.

### Browse Microsoft applications in the admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Enterprise applications**.
1. Set the **Application type** filter to **Microsoft Applications**.
1. Add the **Application ID** column to see each app's ID next to its display name.

### Find an application ID in sign-in logs

1. In the [Microsoft Entra admin center](https://entra.microsoft.com), browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Review the **Application** and **Application ID** columns to match an app name to its ID.
1. Select a sign-in to see the full details, including the application ID.

### List Microsoft applications with Microsoft Graph PowerShell

Microsoft first-party service principals are owned by the Microsoft Services tenant `f8cdef31-a31e-4b4a-93e4-5f571e91255a`. Filter on this tenant ID to list the Microsoft apps in your tenant.

```powershell
Connect-MgGraph -Scopes "Application.Read.All"

# List Microsoft applications in your tenant by display name and application ID.
Get-MgServicePrincipal -All |
    Where-Object { $_.AppOwnerOrganizationId -eq 'f8cdef31-a31e-4b4a-93e4-5f571e91255a' } |
    Select-Object DisplayName, AppId |
    Sort-Object DisplayName
```

To resolve a single application ID that you find in a sign-in log, filter by that ID.

```powershell
Get-MgServicePrincipal -Filter "appId eq '<application-id>'" |
    Select-Object DisplayName, AppId
```

> [!NOTE]
> These methods return the Microsoft service principals that exist in your tenant. This set approximates the Office 365 app suite but might not match it exactly. The list in this article reflects the apps that make up the suite.

## Related content

- [Office 365 app in Conditional Access](concept-conditional-access-cloud-apps.md#office-365)
- [Service dependencies in Conditional Access](service-dependencies.md)
- [What is Conditional Access?](overview.md)
- [Verify first-party Microsoft applications in sign-in reports](https://learn.microsoft.com/troubleshoot/azure/entra/entra-id/governance/verify-first-party-apps-sign-in)

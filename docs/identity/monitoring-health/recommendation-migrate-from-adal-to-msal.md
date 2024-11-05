---
title: Migrate from ADAL to MSAL recommendation
description: Learn why you should migrate from the Azure Active Directory Authentication Library to the Microsoft Authentication Libraries.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 05/01/2024
ms.author: sarahlipsey
ms.reviewer: jamesmantu

# Customer intent: As an IT admin, I need to know what services are using ADAL so I can migrate them to MSAL.
---

# Microsoft Entra recommendation: Migrate from the Azure Active Directory Authentication Library to the Microsoft Authentication Libraries

[Microsoft Entra recommendations](overview-recommendations.md) is a feature that provides you with personalized insights and actionable guidance to align your tenant with recommended best practices.

This article covers the recommendation to migrate from the Azure Active Directory Authentication Library (ADAL) to the Microsoft Authentication Libraries (MSAL). This recommendation is called `AdalToMsalMigration` in the recommendations API in Microsoft Graph. 

## Description

The 'migrate from ADAL to MSAL' recommendation is created to raise awareness and alert you about all applications using ADAL within your tenant. This recommendation is triggered for tenants with applications using ADAL. It labels any application that requests a token via ADAL as an "ADAL application," including those applications using both ADAL and MSAL.

Azure Active Directory Authentication Library (ADAL) has been deprecated. We strongly recommend migrating to the Microsoft Authentication Library (MSAL), which replaces ADAL. Microsoft **no longer releases new features and security fixes on ADAL**. Applications using ADAL won't be able to utilize the latest security features, leaving them vulnerable to future security threats. If you have existing applications that use ADAL, be sure to [migrate them to MSAL](~/identity-platform/msal-migration.md). 



## How it works

The system checks daily for new ADAL token requests over the past 30 days. If an application makes no new requests for 30 days, its recommendation status is marked as completed. The overall recommendation status updates to "completed" once all applications meet this criterion. If a new ADAL request is detected for a previously completed application, its status reverts to "active."

## Value 

MSAL is designed to enable a secure solution without developers having to worry about the implementation details. MSAL simplifies how tokens are acquired, managed, cached, and refreshed. MSAL also uses best practices for resilience. For more information on MSAL supported scenarios, see [Migrate applications to MSAL](~/identity-platform/msal-migration.md#why-switch-to-msal).


## Action plan

To identify and get details of all applications in your tenant that are currently using ADAL, you can use Sign-ins Workbook. To get the list of all apps programmatically, you can also use Microsoft Graph API or the Microsoft Graph PowerShell SDK.

### [Sign-ins Workbook](#tab/Sign-ins-Workbook)
The Sign-ins Workbook in the Azure portal consolidates logs from various types of sign-in events, including interactive, non-interactive, and service principal sign-ins. This aggregation offers detailed insights into the usage of ADAL applications across your tenant to help you fully understand and manage migration of your ADAL applications.  For a more detailed analysis and deeper investigation of ADAL app sign-in data, you can enable the [Microsoft Entra Sign-ins workbook](~/identity-platform/howto-get-list-of-all-auth-library-apps.md) in your tenant. This tool supports the migration by providing comprehensive sign-in data insights.


### [Microsoft Graph API](#tab/Microsoft-Graph-API)

You can use Microsoft Graph to identify apps that need to be migrated to MSAL. To get started, see [How to use Microsoft Graph with Microsoft Entra recommendations](howto-use-recommendations.md#how-to-use-microsoft-graph-with-azure-active-directory-recommendations).

1. Sign in to [Graph Explorer](https://aka.ms/ge).
1. Select **GET** as the HTTP method from the dropdown.
1. Set the API version to **beta**.
1. Run the following query in Microsoft Graph, replacing the `<TENANT_ID>` placeholder with your tenant ID. This query returns a list of the impacted resources in your tenant.
    -  `https://graph.microsoft.com/beta/directory/recommendations/<TENANT_ID>_Microsoft.Identity.IAM.Insights.AdalToMsalMigration/impactedResources`


The following response provides the details of the impacted resources using ADAL:

```json
{
    "id": "<APPLICATION_ID>",
    "subjectId": "<APPLICATION_ID>",
    "recommendationId": "TENANT_ID_Microsoft.Identity.IAM.Insights.AdalToMsalMigration",
    "resourceType": "app",
    "addedDateTime": "2023-03-29T09:29:01.1708723Z",
    "postponeUntilDateTime": null,
    "lastModifiedDateTime": "0001-01-01T00:00:00Z",
    "lastModifiedBy": "System",
    "displayName": "sample-adal-app",
    "owner": null,
    "rank": 1,
    "portalUrl": "df.onecloud.azure-test.net/#view/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/~/Branding/appId/{0}",
    "apiUrl": null,
    "status": "completedBySystem",
    "additionalDetails": [
        {
            "key": "Library",
            "value": "ADAL.Net"
        }
    ]
}
```

### [Microsoft Graph PowerShell SDK](#tab/Microsoft-Graph-PowerShell-SDK)

You can run the following set of commands in Windows PowerShell. These commands use the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation) to get a list of all applications in your tenant that use ADAL.

1. Open Windows PowerShell as an administrator.

1. Connect to Microsoft Graph:
    - `Connect-MgGraph-Tenant <YOUR_TENANT_ID>`

1. Select your profile:
    - `Select-MgProfile beta`

1. Get a list of your recommendations:
    - `Get-MgDirectoryRecommendation | Format-List`

1. Update the code for your apps using the instructions in [How to migrate to MSAL](~/identity-platform/msal-migration.md#how-to-migrate-to-msal).

---

## Frequently asked questions

Review the following common questions as you work on ADAL to MSAL migration.

### Why does it take 30 days to change the status to completed?

To reduce false positives, the service uses a 30 day window for ADAL requests. This way, the service can go several days without an ADAL request and not be falsely marked as completed. 

### How do I identify the owner of an application in my tenant?

You can locate owner from the recommendation details. Select the resource, which takes you to the application details. Go to **Manage** > **Owners** to view the current owners. Viewing the owners requires at least the [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator) role.

### Can the status change from *completed* to *active*?

Yes. If an application was marked as completed - so no ADAL requests were made during the 30 day window - that application would be marked as complete. If the service detects a new ADAL request, the status changes back to *active*. Recommendations can only be updated by the system.

### How can I integrate  Microsoft Entra sign-ins workbook?
You can find the detailed steps in the [Microsoft Entra Sign-ins workbook](~/identity-platform/howto-get-list-of-all-auth-library-apps.md). 


### Why is the number of ADAL applications different in the sign-ins workbook and the recommendation?

- **Aggregated Data  vs. Transactional Data:** The recommendation aggregates data over the last 30 days, providing a summarized view of application activities. Conversely, the sign-ins workbook details each sign-in request as a transaction, which allows for a more detailed analysis.

- **Time Frame Flexibility:** The sign-ins workbook data can be filtered from as recently as the last 30 minutes to up to 30 days. This flexibility in selecting the time frame can lead to variations in the application count, potentially skewing the results.

- **Access to Historical Data:** Viewing data older than 7 days in the sign-ins workbook requires a Microsoft Entra ID P1 or P2 tenant subscription. This requirement affects the volume of historical data accessible compared to the aggregated data in the recommendation.



## Related content

- [Learn how to enable Sign-ins Workbook in your tenant](~/identity-platform/howto-get-list-of-all-auth-library-apps.md)
- [Review the Microsoft Entra recommendations overview](overview-recommendations.md)
- [Learn how to use Microsoft Entra recommendations](howto-use-recommendations.md)
- [Explore the Microsoft Graph API properties for recommendations](/graph/api/resources/recommendation)

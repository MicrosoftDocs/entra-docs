---
title: "How to: Get a complete list of all apps using Active Directory Authentication Library (ADAL) in your tenant"
description: In this how-to guide, you get a complete list of all apps that are using ADAL in your tenant.
author: SHERMANOUKO
manager: CelesteDG
ms.author: shermanouko
ms.date: 05/01/2024
ms.reviewer: 
ms.service: identity-platform
ms.topic: how-to
ms.custom: has-adal-ref, sfi-image-nochange
#Customer intent: As an application developer / IT admin, I need to know / identify which of my apps are using ADAL.
---

# Get a complete list of apps using ADAL in your tenant

This article provides guidance on how to use Azure Monitor workbooks to obtain a list of all apps that use ADAL in your tenant.

Azure Active Directory Authentication Library (ADAL) has been deprecated. We strongly recommend migrating to the Microsoft Authentication Library (MSAL), which replaces ADAL. Microsoft **no longer releases new features and security fixes on ADAL**. Applications using ADAL won't be able to utilize the latest security features, leaving them vulnerable to future security threats. If you have existing applications that use ADAL, be sure to [migrate them to MSAL](~/identity-platform/msal-migration.md). 



## Sign-ins workbook

Workbooks are a set of queries that collect and visualize information that is available in Microsoft Entra logs. [Learn more about the sign-in logs schema here](~/identity/monitoring-health/reference-azure-monitor-sign-ins-log-schema.md). 

The Sign-ins Workbook in the Microsoft Entra admin center consolidates logs from various types of sign-in events, including interactive, non-interactive, and service principal sign-ins. This aggregation offers detailed insights into the usage of ADAL applications across your tenant to help you fully understand and manage migration of your ADAL applications. 

Below, we provide comprehensive instructions on accessing the workbook and subsequently demonstrate effective ways for visualizing the list of applications.

## Step 1: Send Microsoft Entra sign-in events to Azure Monitor

Microsoft Entra ID doesn't send sign-in events to Azure Monitor by default, which the Sign-ins Workbook in Azure Monitor requires.

Configure AD to send sign-in events to Azure Monitor by following the steps in [Integrate your Microsoft Entra sign-in and audit logs with Azure Monitor](~/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs.yml). In the **Diagnostic settings** configuration step, select the **SignInLogs** check box.

No sign-in event that occurred *before* you configure Microsoft Entra ID to send the events to Azure Monitor will appear in the Sign-ins workbook.

## Step 2: Access Sign-ins workbook in the Microsoft Entra admin center


Once you integrate your Microsoft Entra sign-in and audit logs with Azure Monitor as specified in the Azure Monitor integration, access the sign-ins workbook:

   1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader).
   1. Browse to **Entra ID** > **Monitoring & health** > **Workbooks**.
   1. In the **Usage** section, open the **Sign-ins** workbook.

   :::image type="content" source="media/howto-get-list-of-all-auth-library-apps/sign-in-workbook.png" alt-text="Screenshot of the Microsoft Entra admin center workbooks interface highlighting the sign-ins workbook.":::

## Step 3: Identify apps that use ADAL

The table at the bottom of the Sign-ins workbook page lists ADAL apps active in last 30 days. You can also export a list of these apps by selecting the download button. Update these apps to use MSAL.
    
:::image type="content" source="media/howto-get-list-of-all-auth-library-apps/active-apps-using-adal.png" alt-text="Screenshot of sign-ins workbook displaying active apps that use Active Directory Authentication Library.":::
    
If there are no apps using ADAL, this section of workbook displays a view as shown: 
    
:::image type="content" source="media/howto-get-list-of-all-auth-library-apps/no-active-apps-using-adal.png" alt-text="Screenshot of sign-ins workbook when no app is using Active Directory Authentication Library.":::

The following section of the workbook shows all the apps sign-in data. This includes total number of apps and sign-in activities including location and device. 

:::image type="content" source="media/howto-get-list-of-all-auth-library-apps/all-apps-sign-in-data.png" alt-text="Screenshot of sign-ins workbook showing detailed sign-in information for your apps.":::

## Step 4: Dive deep to analyze application usage and authentication data
To thoroughly assess the impact of ADAL applications within your tenant, it's crucial to analyze more detailed data beyond mere identification. 

- **Application Id**: Unique identifier for each application.
- **App Display Name**: The name of the application, which helps in easily identifying the app across the organization.
- **SigninCount**: Number of sign-ins per application. 
- **ADAL Version**: Specific version of ADAL used by the application.
- **IP Address**: Displays the client's IP address from which the sign-in attempt originated.
- **Location**: Provides the city, state, country/region and  from where the sign-in request was made.
- **Sign-in by Device**: Shares the details of the OS of the device including the specific version. 

To access this enhanced data view, apply custom filters and queries within the workbook. This information not only aids in identifying critical applications but also helps in planning the migration strategy by prioritizing applications based on their usage and exposure level.


## Step 5: Update your ADAL application

Once you've identified the applications using ADAL, proceed with updating them to MSAL. The migration process varies based on the type of application you are working with. Follow the  guidelines provided below for each application type.

[!INCLUDE [application type](includes/adal-msal-migration.md)]

## Step 6: Monitor to validate successful migration
With the detailed data from Step 4, you can effectively prioritize and manage the migration process of your applications to MSAL. Here’s how you can use this data to investigate sign-in scenarios and ensure a smooth transition:

- **Prioritization**: Applications with a high `SigninCount` and older `ADAL Version` should be prioritized as they represent higher usage and potentially higher risk. Migrate these applications first to minimize the most significant risks to your organization.
- **Security Analysis**: Use the `IP Address` to detect sign-in patterns. For example, if sign-ins request is made from a user or an organization owned service to identify the source of the call. 
- **Compatibility Checks**: Before migrating, assess the `ADAL Version` used by the application. Some versions might have known issues with specific MSAL features. Understanding these nuances will help in planning a migration that minimizes functionality disruptions.
- **Testing Scenarios**: After updating to MSAL, monitor to compare pre-and post-migration behavior. This comparison helps verify that the migration was successful and that the application behaves as expected in the new environment.

By leveraging the detailed data from the Sign-ins workbook, your organization can strategically plan and execute the migration from ADAL to MSAL, ensuring minimal disruption and maintaining robust security protocols.


## Next steps

For more information about MSAL, including usage information and which libraries are available for different programming languages and application types, see:

- [MSAL documentation home page](/entra/msal)
- [Acquire and cache tokens using MSAL](msal-acquire-cache-tokens.md)
- [Application configuration options](msal-client-application-configuration.md)
- [List of MSAL authentication libraries](reference-v2-libraries.md)

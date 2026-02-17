---
title: Application Usage Analytics Overview (Preview)
description: "Gain visibility into application traffic to gain insights into app categories, risk scores, transactions, and organizational usage patterns."
author: HULKsmashGithub
ms.author: jayrusso
ms.topic: overview
ms.date: 12/18/2025
ms.reviewer: kerenSemel

#customer intent: As an IT admin, I want to analyze and visualize application use to better understand organizational usage patterns.
---
<!-- The images in this article use approved, fictitious company names from https://microsoft.sharepoint.com/:b:/r/sites/CELAWeb-Copyrights-Trademarks-And-Patents/Shared%20Documents/Approved%20Fictitious%20Company%20Names%20and%20Domain%20Names%20-%20Oct%202024.pdf?csf=1&web=1&e=2JKgvG. -->

# What is application usage analytics? (preview)
Application usage analytics gives IT admins actionable insights into their organization's app use by analyzing traffic patterns, data usage, and which users access the app. Admins can use these analytics to identify shadow IT, generative AI apps, and potential security or compliance risks. Usage analytics helps organizations increase visibility, improve their security posture, and optimize app use across their environment.

> [!IMPORTANT]
> The application usage analytics feature is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before its release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Insights and Analytics dashboard
To access the **Insights and Analytics** dashboard:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Log Reader](/azure/active-directory/roles/permissions-reference#global-secure-access-log-reader).
1. Browse to **Global Secure Access** > **Applications** > **Insights and Analytics**.

The **Insights and Analytics** dashboard has three widgets:

### Application count 
This widget shows the **Total cloud applications**, **Total private applications**, and the number of **New discovered segments** used within the selected time. To learn more about discovered segments, select the **View details** button to open the **Application discovery** page.   
:::image type="content" source="media/overview-application-usage-analytics/widget-applications-count.png" alt-text="Screenshot of the Applications count widget with information on the total cloud and total private applications.":::   
 
### Application usage distribution
This widget shows application usage by type, with one color for cloud and another for private applications in the selected time range. You can aggregate the view by **Transactions**, **Bytes sent**, or **Bytes received**.   
:::image type="content" source="media/overview-application-usage-analytics/widget-usage-distribution.png" alt-text="Screenshot of the Usage distribution widget with cloud and private applications information aggregated by bytes sent.":::   
 
### Application usage trend
This widget shows application usage over time, with one trend for cloud and another for private applications. You can aggregate the view by **Transactions**, **Users**, **Devices**, **Bytes sent**, or **Bytes received**.   
:::image type="content" source="media/overview-application-usage-analytics/widget-applications-usage-trends.png" alt-text="Screenshot of the Applications usage trends widget showing private and cloud application usage over time.":::   
 
## Private application analytics
Private application analytics gives IT admins visibility and insights into their organization's private enterprise applications onboarded to Microsoft Entra by Global Secure Access. These insights include the application name, application ID, users who access the application, devices used, access type, number of transactions, traffic (bytes sent and received), and the first and last access times. Private application analytics also tracks quick access for customers who configured it.    

### Key capabilities
By using private application analytics, you can:   

- Identify the private applications that users access. Details include **Application name**, **Application ID**, **Traffic type**, **Access type**, the number of **Users**, **Devices**, and **Transactions**, **Sent bytes**, **Received bytes**, **Last access** date, and **First access** date.
:::image type="content" source="media/overview-application-usage-analytics/private-applications-list.png" alt-text="Screenshot of a list of discovered private applications accessed by users.":::   

Select each private application row to open a per-app insight panel with two tabs:

- The **Usage** tab shows a graph with usage information, including insights into the number of transactions, the amount of traffic, and the number of users accessing the applications.
:::image type="content" source="media/overview-application-usage-analytics/usage-statistics.png" alt-text="Screenshot of cloud application usage statistics showing transactions over time.":::

- The **Users** tab shows statistics about the usage of an application segment and which users are accessing it.
:::image type="content" source="media/overview-application-usage-analytics/user-principal-name.png" alt-text="Screenshot of a list of users who accessed the cloud application, the traffic type, and the number of transactions.":::   

## Cloud application analytics
Cloud application analytics give admins visibility and insights into the cloud applications their organization uses, including generative AI applications. These insights include the application category, risk score, number of transactions, traffic (bytes sent and received), and the users who access the applications.   

This information helps admins identify generative AI applications, shadow AI applications, and shadow IT. Insights from the analytics help admins make decisions based on security and compliance status.   

### Key capabilities
By using Cloud application analytics, you can:
- Identify the cloud applications that users access (using the Microsoft Defender for Cloud Apps Cloud app catalog), for both internet and Microsoft 365 traffic. Details include **Name**, **Categories**, **Risk score**, the number of **Users**, **Sent bytes**, **Received bytes**, **Last access** date, and **First access** date.  
:::image type="content" source="media/overview-application-usage-analytics/application-discovery-cloud.png" alt-text="Screenshot of a list of discovered cloud applications accessed by users.":::

- Use the **Generative AI apps only** toggle to identify the generative AI applications that users access, for both internet and Microsoft 365 traffic.   
:::image type="content" source="media/overview-application-usage-analytics/application-discovery-generative-ai.png" alt-text="Screenshot of a list of discovered generative AI applications accessed by users.":::

The links on each cloud application row open to reveal specific details about that application.

#### App details and risk factors
To view app details and risk factors, select the application's **Name** link.
:::image type="content" source="media/overview-application-usage-analytics/cloud-name-link.png" alt-text="Screenshot of the Cloud Apps list with an example Name link highlighted." lightbox="media/overview-application-usage-analytics/cloud-name-link.png":::

The **Microsoft Entra App Gallery** opens, showing the selected application's app details. The app details list the **Overall Risk Score**. You can view further risk-factor details by selecting each of the **General**, **Security**, **Compliance**, or **Legal** tabs.
:::image type="content" source="media/overview-application-usage-analytics/risk-factor-application-details.png" alt-text="Screenshot of the app details view, showing example risk factor scores." lightbox="media/overview-application-usage-analytics/risk-factor-application-details.png":::

#### App user data
To view user data, select the application's **Users** link.
:::image type="content" source="media/overview-application-usage-analytics/cloud-users-link.png" alt-text="Screenshot of the Cloud Apps list with an example Users link highlighted." lightbox="media/overview-application-usage-analytics/cloud-users-link.png":::

The **Users** tab shows statistics about the usage of an application segment and which users access it.
:::image type="content" source="media/overview-application-usage-analytics/user-principal-name.png" alt-text="Screenshot of a list of users who accessed the cloud application, the traffic type, and the number of transactions.":::

#### App usage data
To view usage data, select the application's **Transactions** link.
:::image type="content" source="media/overview-application-usage-analytics/cloud-transactions-link.png" alt-text="Screenshot of the Cloud Apps list with an example Transactions link highlighted." lightbox="media/overview-application-usage-analytics/cloud-transactions-link.png":::

The **Usage** tab opens, showing a graph with usage information, including the number of transactions, the amount of traffic, and the number of users who access the applications.
:::image type="content" source="media/overview-application-usage-analytics/usage-statistics.png" alt-text="Screenshot of cloud application usage statistics showing transactions over time.":::

## Related content
- [Application discovery for Global Secure Access](how-to-application-discovery.md)

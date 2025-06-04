---
title: Application Usage Analytics Overview
description: "Gain visibility into cloud application traffic to gain insights into app categories, risk scores, transactions, and organizational usage patterns."
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: concept-article
ms.date: 06/04/2025
manager: dougeby
ms.reviewer: kerenSemel


#customer intent: As an IT admin, I want to analyze and visualize cloud application use to better understand organizational usage patterns.
---

# Application usage analytics overview
Application usage analytics gives IT admins actionable insights into their organization's cloud application use. By analyzing traffic patterns, app categories, risk scores, and user activity, admins can identify shadow IT, generative AI apps, and potential security or compliance risks. This feature helps organizations enhance visibility, improve security posture, and optimize app use across their environment.

## Cloud application analytics
Cloud application analytics give admins visibility and insights into the cloud applications their organization uses, including generative AI applications. These insights include the application category, risk score, number of transactions, traffic (bytes sent and received), and the users accessing the applications.   

This information helps admins identify generative AI applications, shadow AI applications, and shadow IT. Insights from the analytics help admins check the security and compliance status.   

### Key capabilities
Key capabilities of cloud application analytics include:
<!-- The images in this section have been modified to use approved, fictitious company names from https://microsoft.sharepoint.com/:b:/r/sites/CELAWeb-Copyrights-Trademarks-And-Patents/Shared%20Documents/Approved%20Fictitious%20Company%20Names%20and%20Domain%20Names%20-%20Oct%202024.pdf?csf=1&web=1&e=2JKgvG. -->
- Identify the cloud applications that users access (using the Microsoft Defender for Cloud Apps Cloud app catalog), for both internet and Microsoft 365 traffic. Details include **Name**, **Category**, **Risk score**, and the number of **Users**.  
:::image type="content" source="media/concept-application-usage-analytics/application-discovery-cloud.png" alt-text="Screenshot of a list of discovered cloud applications accessed by users.":::

- Identify the generative AI applications that users access, for both internet and Microsoft 365 traffic.   
:::image type="content" source="media/concept-application-usage-analytics/application-discovery-generative-ai.png" alt-text="Screenshot of a list of discovered generative AI applications accessed by users.":::

- The traffic log includes **Cloud application** information, including application name, category, risk score, security score, legal score, and general score.
:::image type="content" source="media/concept-application-usage-analytics/traffic-logs-enrichment.png" alt-text="Screenshot of the cloud application details of the traffic log.":::

- Report on all discovered cloud applications, including insights into the number of transactions, the amount of traffic, and which users are accessing the applications.
:::image type="content" source="media/concept-application-usage-analytics/usage-statistics.png" alt-text="Screenshot of cloud application usage statistics showing transactions over time.":::

- Show statistics regarding the usage of an application segment and which users are accessing it.
:::image type="content" source="media/concept-application-usage-analytics/user-principal-name.png" alt-text="Screenshot of a list of users who accessed the cloud application, the traffic type, and the number of transactions.":::

- Gain quick insights with dashboard widgets:   
    - Top used cloud applications   
    :::image type="content" source="media/concept-application-usage-analytics/top-used-cloud-applications.png" alt-text="Screenshot of the Top used cloud applications widget.":::   
    - Most used generative AI applications   
    :::image type="content" source="media/concept-application-usage-analytics/top-used-generative.png" alt-text="Screenshot of the Top used generative AI widget.":::   
    - Cloud application status   
    :::image type="content" source="media/concept-application-usage-analytics/total-cloud-widget.png" alt-text="Screenshot of Cloud application status widget showing the total number of cloud, generative AI, and high risk applications.":::


## Private application analytics
Private application analytics gives IT admins visibility and insights into the private enterprise applications their organization uses, including quick access. These insights include the application name, application ID, users accessing the application, devices used, access type, number of transactions, bytes sent and received, and the first and last access times.

The dashboard shows the number of newly discovered network segments that aren't onboarded and includes a link to the Application discovery page.

## Related content
- [Application discovery for Global Secure Access](how-to-application-discovery.md)
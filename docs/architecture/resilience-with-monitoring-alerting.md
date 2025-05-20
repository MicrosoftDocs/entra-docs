---
title: Resilience through monitoring and analytics using Azure AD B2C
description: Resilience through monitoring and analytics using Azure AD B2C
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.date: 05/20/2025
---

# Resilience through monitoring and analytics

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](~/includes/active-directory-b2c-end-of-sale-notice.md)]

Monitoring maximizes the availability and performance of your applications and services. It delivers a comprehensive solution for collecting, analyzing, and acting on telemetry from your infrastructure and applications. Alerts notify you when issues are found with your service or applications. You can identify and address issues before the end users of your service notice them. [Microsoft Entra ID Log Analytics](https://azure.microsoft.com/services/monitor/?OCID=AID2100131_SEM_6d16332c03501fc9c1f46c94726d2264:G:s&ef_id=6d16332c03501fc9c1f46c94726d2264:G:s&msclkid=6d16332c03501fc9c1f46c94726d2264#features) helps you analyze, search the audit logs and sign-in logs, and build custom views.

## Monitor and get notified through alerts

Monitoring your system and infrastructure helps ensure the overall health of your services. It starts with the definition of business metrics, such as, new user arrival, end user authentication rates, and conversion. Configure such indicators to monitor. If you're planning for an upcoming surge because of a promotion or holiday traffic, revise your estimates for the event and corresponding benchmark for the business metrics. After the event, fall back to the previous benchmark.

Similarly, to detect failures or performance disruptions, set up a good baseline and then define alerting. Respond to emerging issues promptly.

### Implement monitoring and alerting

- **Monitoring**: Use [Azure Monitor](/azure/active-directory-b2c/azure-monitor) to continuously monitor health against key Service Level Objectives (SLO). Get notification when a critical change happens. Identify Azure AD B2C policy or an application as a critical component of your business whose health needs to be monitored to maintain SLO. Identify key indicators that align with your SLOs.
For example, track the following metrics, since a sudden drop in either leads to a loss in business.

  - **Total requests**: The total "n" number of requests sent to Azure AD B2C policy.

  - **Success rate (%)**: Successful requests/Total number of requests.

  Access the [key indicators](/azure/active-directory-b2c/view-audit-logs) in [application insights](/azure/active-directory-b2c/analytics-with-application-insights) where Azure AD B2C policy-based logs, [audit logs](/azure/active-directory-b2c/analytics-with-application-insights), and sign-in logs are stored.  

   - **Visualizations**: Use Log Analytics to build dashboards to visually monitor the key indicators.

   - **Current period**: Create temporal charts to show changes in the total requests and success rate (%) in the current period, for example, current week.

   - **Previous period**: Create temporal charts to show changes in the total requests and success rate (%) over some previous period.

- **Alerting**: Using Log Analytics, define [alerts](/azure/azure-monitor/alerts/alerts-create-new-alert-rule) triggered when there are sudden changes in the key indicators. These changes might negatively affect the SLOs. Alerts use various forms of notification methods including email, SMS, and webhooks. Define a criterion as a threshold for the alert trigger. For example:
  - Alert for abrupt drop in total requests: Trigger an alert when total requests drop abruptly. For example, when there's a 25% drop in requests compared to previous period, raise an alert.  
  - Alert for significant drop in success rate (%): Trigger an alert when success rate of the selected policy drops.
  - Upon receiving an alert, troubleshoot the issue using [Log Analytics](/azure/azure-monitor/visualize/workbooks-view-designer-conversion-overview), [Application Insights](/azure/active-directory-b2c/troubleshoot-with-application-insights), and [VS Code extension](https://marketplace.visualstudio.com/items?itemName=AzureADB2CTools.aadb2c) for Azure AD B2C. After you resolve the issue and deploy an updated application or policy, it monitors key indicators until they return to normal range.

- **Service alerts**: Use the [Azure AD B2C service level alerts](/azure/service-health/service-health-overview) to get notified of service issues, planned maintenance, health advisories, and security advisories.

- **Reporting**: [By using Log Analytics](~/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs.yml), build reports about user insights, technical challenges, and growth opportunities.
  - **Azure Dashboard**: Create [custom dashboards using Azure Dashboard](/azure/azure-monitor/app/overview-dashboard#create-custom-kpi-dashboards-using-application-insights) feature, which supports adding charts using Log Analytics queries. For example, identify pattern of successful and failed sign-ins, failure reasons and telemetry about devices used to make the requests.
  - **Abandon Azure AD B2C journeys**: Use the [workbook](https://github.com/azure-ad-b2c/siem#list-of-abandon-journeys) to track abandoned Azure AD B2C journeys wherein users started sign-in or sign-up but never finished it. Find details about policy ID and steps taken by the user before abandoning the journey.
  - **Azure AD B2C monitoring workbooks**: Use the [monitoring workbooks](https://github.com/azure-ad-b2c/siem) that include Azure AD B2C dashboard, multifactor authentication (MFA) operations, Conditional Access reports, and search logs by correlationId. This practice provides better insights into the health of your Azure AD B2C environment.
  
## Next steps

- [Resilience resources for Azure AD B2C developers](resilience-b2c.md)
  - [Resilient end-user experience](resilient-end-user-experience.md)
  - [Resilient interfaces with external processes](resilient-external-processes.md)
  - [Resilience through developer best practices](resilience-b2c-developer-best-practices.md)
- [Build resilience in your authentication infrastructure](resilience-in-infrastructure.md)
- [Increase resilience of authentication and authorization in your applications](resilience-app-development-overview.md)

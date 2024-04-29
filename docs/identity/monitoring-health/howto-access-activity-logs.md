---
title: Access activity logs in Microsoft Entra ID
description: How to choose the right method for accessing and integrating the activity logs in Microsoft Entra ID.
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 12/15/2023
ms.author: sarahlipsey
ms.reviewer: egreenberg

# Customer intent: As an IT admin, I want to learn about the different ways to access activity logs in Microsoft Entra ID so that I can choose the right method for my scenario and organization.

---

# How to access activity logs in Microsoft Entra ID

The data collected in your Microsoft Entra logs enables you to assess many aspects of your Microsoft Entra tenant. To cover a broad range of scenarios, Microsoft Entra ID provides you with several options to access your activity log data. As an IT administrator, you need to understand the intended uses cases for these options, so that you can select the right access method for your scenario.  

You can access Microsoft Entra activity logs and reports using the following methods:

- [Stream activity logs to an **event hub** to integrate with other tools](#stream-logs-to-an-event-hub-to-integrate-with-siem-tools)
- [Access activity logs through the **Microsoft Graph API**](#access-logs-with-microsoft-graph-api)
- [Integrate activity logs with **Azure Monitor logs**](#integrate-logs-with-azure-monitor-logs)
- [Monitor activity in real-time with **Microsoft Sentinel**](#monitor-events-with-microsoft-sentinel)
- [View activity logs and reports in the **Azure portal**](#view-logs-through-the-portal)
- [Export activity logs for **storage and queries**](#export-logs-for-storage-and-queries)

Each of these methods provides you with capabilities that might align with certain scenarios. This article describes those scenarios, including recommendations and details about related reports that use the data in the activity logs. Explore the options in this article to learn about those scenarios so you can choose the right method.

## Prerequisites

[!INCLUDE [Microsoft Entra monitoring and health](../../includes/licensing-monitoring-health.md)]

Audit logs are available for features that you've licensed. To access the sign-in logs using the Microsoft Graph API, your tenant must have a Microsoft Entra ID P1 or P2 license associated with it.

## Stream logs to an event hub to integrate with SIEM tools

Streaming your activity logs to an event hub is required to integrate your activity logs with Security Information and Event Management (SIEM) tools, such as Splunk and SumoLogic. Before you can stream logs to an event hub, you need to [set up an Event Hubs namespace and an event hub](/azure/event-hubs/event-hubs-create) in your Azure subscription.

### Recommended uses

The SIEM tools you can integrate with your event hub can provide analysis and monitoring capabilities. If you're already using these tools to ingest data from other sources, you can stream your identity data for more comprehensive analysis and monitoring. We recommend streaming your activity logs to an event hub for the following types of scenarios:

- If you need a big data streaming platform and event ingestion service to receive and process millions of events per second.
- If you're looking to transform and store data by using a real-time analytics provider or batching/storage adapters.

### Quick steps

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. Create an Event Hubs namespace and event hub.
1. Browse to **Identity** > **Monitoring & health** > **Diagnostic settings**.
1. Choose the logs you want to stream, select the **Stream to an event hub** option, and complete the fields.
    - [Set up an Event Hubs namespace and an event hub](/azure/event-hubs/event-hubs-create)
    - [Learn more about streaming activity logs to an event hub](howto-stream-logs-to-event-hub.md)

 Your independent security vendor should provide you with instructions on how to ingest data from Azure Event Hubs into their tool.

## Access logs with Microsoft Graph API

The Microsoft Graph API provides a unified programmability model that you can use to access data for your Microsoft Entra ID P1 or P2 tenants. It doesn't require an administrator or developer to set up extra infrastructure to support your script or app.  

[!INCLUDE [portal update](../../includes/portal-update.md)]

### Recommended uses

Using Microsoft Graph explorer, you can run queries to help you with the following types of scenarios:

- View tenant activities such as who made a change to a group and when.
- Mark a Microsoft Entra sign-in event as safe or confirmed compromised.
- Retrieve a list of application sign-ins for the last 30 days.

> [!NOTE]
> Microsoft Graph allows you to access data from multiple services that impose their own throttling limits. For more information on activity log throttling, see [Microsoft Graph service-specific throttling limits](/graph/throttling-limits#identity-and-access-service-limits).

### Quick steps

1. [Configure the prerequisites](howto-configure-prerequisites-for-reporting-api.md).
1. Sign in to [Graph Explorer](https://aka.ms/ge).
1. Set the HTTP method and API version.
1. Add a query then select the **Run query** button.
    - [Familiarize yourself with the Microsoft Graph properties for directory audits](/graph/api/resources/directoryaudit)
    - [Complete the MS Graph Quickstart guide](quickstart-access-log-with-graph-api.md)

## Integrate logs with Azure Monitor logs

With the Azure Monitor logs integration, you can enable rich visualizations, monitoring, and alerting on the connected data. Log Analytics provides enhanced query and analysis capabilities for Microsoft Entra activity logs. To integrate Microsoft Entra activity logs with Azure Monitor logs, you need a Log Analytics workspace. From there, you can run queries through Log Analytics.

### Recommended uses

Integrating Microsoft Entra logs with Azure Monitor logs provides a centralized location for querying logs. We recommend integrating logs with Azure Monitor for the following types of scenarios:

- Compare Microsoft Entra sign-in logs with logs published by other Azure services.
- Correlate sign-in logs against Azure Application insights.
- Query logs using specific search parameters.

### Quick steps

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. [Create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace).
1. Browse to **Identity** > **Monitoring & health** > **Diagnostic settings**.
1. Choose the logs you want to stream, select the **Send to Log Analytics workspace** option, and complete the fields.
1. Browse to **Identity** > **Monitoring & health** > **Log Analytics** and begin querying the data.
    - [Integrate Microsoft Entra logs with Azure Monitor logs](howto-integrate-activity-logs-with-azure-monitor-logs.yml)
    - [Learn how to query using Log Analytics](howto-analyze-activity-logs-log-analytics.md)

## Monitor events with Microsoft Sentinel

Sending sign-in and audit logs to Microsoft Sentinel provides your security operations center with near real-time security detection and threat hunting. The term *threat hunting* refers to a proactive approach to improve the security posture of your environment. As opposed to classic protection, threat hunting tries to proactively identify potential threats that might harm your system. Your activity log data might be part of your threat hunting solution.

### Recommended uses

We recommend using the real-time security detection capabilities of Microsoft Sentinel if your organization needs security analytics and threat intelligence. Use Microsoft Sentinel if you need to:

- Collect security data across your enterprise.
- Detect threats with vast threat intelligence.
- Investigate critical incidents guided by AI.
- Respond rapidly and automate protection.

### Quick steps

1. Learn about the [prerequisites](/azure/sentinel/prerequisites), [roles, and permissions](/azure/sentinel/roles).
1. [Estimate potential costs](/azure/sentinel/billing).
1. [Onboard to Microsoft Sentinel](/azure/sentinel/quickstart-onboard).
1. [Collect Microsoft Entra data](/azure/sentinel/connect-azure-active-directory).
1. [Begin hunting for threats](/azure/sentinel/hunting).

## View logs through the Microsoft Entra admin center
<a name='view-logs-through-the-portal'></a>

For one-off investigations with a limited scope, the [Microsoft Entra admin center](https://entra.microsoft.com/) is often the easiest way to find the data you need. The user interface for each of these reports provides you with filter options enabling you to find the entries you need to solve your scenario.

The data captured in the Microsoft Entra activity logs are used in many reports and services. You can review the sign-in, audit, and provisioning logs for one-off scenarios or use reports to look at patterns and trends. The data from the activity logs help populate the Identity Protection reports, which provide information security related risk detections that Microsoft Entra ID can detect and report on. Microsoft Entra activity logs also populate Usage and insights reports, which provide usage details for your tenant's applications.

### Recommended uses

The reports available in the Azure portal provide a wide range of capabilities to monitor activities and usage in your tenant. The following list of uses and scenarios isn't exhaustive, so explore the reports for your needs.

- Research a user's sign-in activity or track an application's usage.
- Review details around group name changes, device registration, and password resets with audit logs.
- Use the Identity Protection reports for monitoring at risk users, risky workload identities, and risky sign-ins.
- You can review the sign-in success rate in the Microsoft Entra application activity (preview) report from Usage and insights to ensure that your users can access the applications in use in your tenant.
- Compare the different authentication methods your users prefer with the Authentication methods report from Usage and insights.

### Quick steps

Use the following basic steps to access the reports in the Microsoft Entra admin center.

#### Microsoft Entra activity logs
<a name='azure-ad-activity-logs'></a>

1. Browse to **Identity** > **Monitoring & health** > **Audit logs**/**Sign-in logs**/**Provisioning logs**.
1. Adjust the filter according to your needs.
    - [Learn how to filter activity logs](howto-customize-filter-logs.md)
    - [Explore the Microsoft Entra audit log categories and activities](reference-audit-activities.md)
    - [Learn about basic info in the Microsoft Entra sign-in logs](concept-sign-in-log-activity-details.md)

Audit logs can be accessed directly from the area of the Microsoft Entra admin center where you're working. For example, if you're in the **Groups** or **Licenses** section of Microsoft Entra ID, you can access the audit logs for those specific activities directly from that area. When you access the audit logs in this way, the filter categories are automatically set. If you're in **Groups**, the audit log filter category is set to **GroupManagement**.

#### Microsoft Entra ID Protection reports
<a name='azure-ad-identity-protection-reports'></a>

1. Browse to **Protection** > **Identity Protection**.
1. Explore the available reports.
    - [Learn more about Identity Protection](../../id-protection/overview-identity-protection.md)
    - [Learn how to investigate risk](../../id-protection/howto-identity-protection-investigate-risk.md)

#### Usage and insights reports

1. Browse to **Identity** > **Monitoring & health** > **Usage and insights**.
1. Explore the available reports.
    - [Learn more about the Usage and insights report](concept-usage-insights-report.md)

## Export logs for storage and queries

The right solution for your long-term storage depends on your budget and what you plan on doing with the data. You've got three options:
  
- Archive logs to Azure Storage
- Download logs for manual storage
- Integrate logs with Azure Monitor logs
  
[Azure Storage](/azure/storage/common/storage-introduction) is the right solution if you aren't planning on querying your data often. For more information, see [Archive directory logs to a storage account](./howto-archive-logs-to-storage-account.md).

If you plan to query the logs often to run reports or perform analysis on the stored logs, you should [integrate your data with Azure Monitor logs](howto-integrate-activity-logs-with-azure-monitor-logs.yml).

If your budget is tight, and you need a cheap method to create a long-term backup of your activity logs, you can [manually download your logs](howto-download-logs.md). The user interface of the activity logs in the portal provides you with an option to download the data as **JSON** or **CSV**. One trade off of the manual download is that it requires more manual interaction. If you're looking for a more professional solution, use either Azure Storage or Azure Monitor.

### Recommended uses

We recommend setting up a storage account to archive your activity logs for those governance and compliance scenarios where long-term storage is required.

If you want to long-term storage *and* you want to run queries against the data, review the section on [integrating your activity logs with Azure Monitor Logs](#integrate-logs-with-azure-monitor-logs).

We recommend manually downloading and storing your activity logs if you have budgetary constraints.

### Quick steps

Use the following basic steps to archive or download your activity logs.

#### Archive activity logs to a storage account

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. Create a storage account.
1. Browse to **Identity** > **Monitoring & health** > **Diagnostic settings**.
1. Choose the logs you want to stream, select the **Archive to a storage account** option, and complete the fields.
    - [Review the data retention policies](reference-reports-data-retention.md)

#### Manually download activity logs

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Identity** > **Monitoring & health** > **Audit logs**/**Sign-in logs**/**Provisioning logs** from the **Monitoring** menu.
1. Select **Download**.
    - [Learn more about how to download logs](howto-download-logs.md).

## Next steps

- [Stream logs to an event hub](howto-stream-logs-to-event-hub.md)
- [Archive logs to a storage account](howto-archive-logs-to-storage-account.md)
- [Integrate logs with Azure Monitor logs](howto-integrate-activity-logs-with-azure-monitor-logs.yml)

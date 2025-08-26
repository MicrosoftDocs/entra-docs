---
title: How to use enriched Microsoft 365 logs
description: Learn how to use enriched Microsoft 365 logs for Global Secure Access.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: how-to
ms.date: 03/19/2025
ms.service: global-secure-access
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# How to use the Global Secure Access enriched Microsoft 365 logs

With your Microsoft traffic flowing through the Microsoft Entra Internet Access for Microsoft Services, you want to gain insights into the performance, experience, and availability of the Microsoft 365 apps your organization uses. With Global Secure Access, Microsoft 365 Audit logs can be easily enriched with the information you need to gain these insights. You can integrate the logs with a third-party security information and event management (SIEM) tool for further analysis.

This article describes the information in the logs and how to use them for the above insights.

## Prerequisites

To use the enriched logs, you need the following roles, configurations, and subscriptions:

### Roles and Permissions

- A **Security Administrator** role is required to export Global Secure Access Network Traffic Logs in Diagnostic Settings.

### Configurations

- **Microsoft Profile** - Ensure the Microsoft traffic profile is enabled. Microsoft traffic forwarding profile is required to capture traffic directed to Microsoft 365 services, which is fundamental for log enrichment. 
- **Tenant sending data** - Confirms that traffic, as configured in forwarding profiles, is accurately tunneled to the Global Secure Access service.
- **Diagnostic Settings Configuration** - Set up Microsoft Entra diagnostic settings to channel the logs to a designated endpoint, like a Log Analytics workspace or Sentinel workspace. The requirements for each endpoint differ and are outlined in the Configure Diagnostic settings section of this article.
- **Export the OfficeActivity log table** - The OfficeActivity table must be exported to the same LogAnalytics or Microsoft Sentinel workspace as the GSA traffic logs, or another third-party SIEM or Log system.

### Subscriptions

- The product requires licensing to enable the traffic forwarding profile for Microsoft Services. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

You must configure the endpoint for where you want to route the logs prior to configuring Diagnostic settings. The requirements for each endpoint vary and are described in the [Configure Diagnostic settings](#configure-diagnostic-settings) section.

## What the logs provide

Microsoft 365 audit logs provide information about Microsoft 365 workloads, so you can review network diagnostic data, performance data, and security events relevant to Microsoft 365 apps. With the enriched properties from Global Secure Access log data includes device information related to the user activities. For example, if access to Microsoft 365 is blocked for a user in your organization, you need visibility into how the user's device is connecting to your network.

These logs provide:

- Additional information added to original logs
- Accurate IP address

Following the steps in this article, the logs are enriched with more information, including the device ID, operating system, and original IP address. Enriched SharePoint logs provide information on files that were downloaded, uploaded, deleted, modified, or recycled. Deleted or recycled list items are also included in the enriched logs.

## How to view the logs

Viewing enriched Microsoft 365 audit logs is a one-time, two-step process. First, you need to collect Global Secure Access Network Traffic logs and Microsoft 365 Unified Audit logs to the same endpoint (Microsoft Sentinel is the recommended workspace). Second, you need to create your own join query to correlate the data between the two tables or use Global Secure Access OOTB Enriched Microsoft 365 Logs workbook that already applies the needed queries.

> [!NOTE]
> At this time, only SharePoint Online logs are available for log enrichment.

> [!NOTE]
> MS365 audit logs have undergone a feature change. Instead of creating a separate new stream of logs, you can now leverage the two existing log tables &mdash; Microsoft  365 OfficeActivity and Global Secure Access NetworkAccessTraffic tables &mdash; then combine the data using a Unique Token Id. 

### Configure Diagnostic settings

To view the enriched Microsoft 365 logs, you must export or stream the logs to an endpoint, such as a Log Analytics workspace or a SIEM tool. The endpoint must be configured before you can configure Diagnostic settings.

### Configure an endpoint

- To integrate logs with Log Analytics, you need a Log Analytics workspace.
  - [Create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace).
  - [Integrate logs with Log Analytics](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics)

- To stream logs to a SIEM tool, you need to create an Azure event hub and an event hub namespace.
  - [Set up an Event Hubs namespace and an event hub](/azure/event-hubs/event-hubs-create).
  - [Stream logs to an event hub](/azure/active-directory/reports-monitoring/tutorial-azure-monitor-stream-logs-to-event-hub)

- To archive logs to a storage account, you need an Azure storage account that you have `ListKeys` permissions for.
  - [Create an Azure storage account](/azure/storage/common/storage-account-create).
  - [Archive logs to a storage account](/azure/active-directory/reports-monitoring/quickstart-azure-monitor-route-logs-to-storage-account)

### Send logs to an endpoint

With your endpoint created, you can configure Diagnostic settings.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](/azure/active-directory/roles/permissions-reference#security-administrator).

1. Browse to **Entra ID** > **Monitoring & health** > **Diagnostic settings**.

1. Select **Add Diagnostic setting**.

1. Give your diagnostic setting a name.

1. Select `NetworkAccessTrafficLogs`.

1. Select the **Destination details** for where you'd like to send the logs. Choose any or all of the following destinations. More fields appear, depending on your selection.

   - **Send to Log Analytics workspace:** Select the appropriate details from the menus that appear.
   - **Archive to a storage account:** Provide the number of days you'd like to retain the data in the **Retention days** boxes that appear next to the log categories. Select the appropriate details from the menus that appear.
   - **Stream to an event hub:** Select the appropriate details from the menus that appear.
   - **Send to partner solution:** Select the appropriate details from the menus that appear.

## Next steps

- [Explore the Global Secure Access logs and monitoring options](concept-global-secure-access-logs-monitoring.md)
- [Learn about Global Secure Access audit logs (preview)](how-to-access-audit-logs.md)
- [Enriched Microsoft 365 audit logs](reference-event-enrichment-logs.md)

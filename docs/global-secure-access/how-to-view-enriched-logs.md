---
title: How to use enriched Microsoft 365 logs
description: Learn how to use enriched Microsoft 365 logs for Global Secure Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 11/02/2023
ms.service: global-secure-access
---

# How to use the Global Secure Access enriched Microsoft 365 logs

With your Microsoft traffic flowing through the Microsoft Entra Private Internet service, you want to gain insights into the performance, experience, and availability of the Microsoft 365 apps your organization uses. The enriched Microsoft 365 logs provide you with the information you need to gain these insights. You can integrate the logs with a third-party security information and event management (SIEM) tool for further analysis.

This article describes the information in the logs and how to export them.

## Prerequisites

To use the enriched logs, you need the following roles, configurations, and subscriptions:

### Roles and Permissions

- A **Global Administrator** role is required to enable the enriched Microsoft 365 logs.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- To use the Microsoft traffic forwarding profile, a Microsoft 365 E3 license is recommended.

### Configurations

- **Microsoft Profile** - Ensure the Microsoft profile is enabled. Microsoft traffic forwarding profile is required to capture traffic directed to Microsoft 365 services, which is fundamental for log enrichment. 
- **Microsoft 365 Common and Office Online Traffic Policy** - Required for log enrichment. Ensure it's enabled. 
- **Tenant sending data** - Confirms that traffic, as configured in forwarding profiles, is accurately tunneled to the Global Secure Access service.
- **Diagnostic Settings Configuration** - Set up Microsoft Entra diagnostic settings to channel the logs to a designated endpoint, like a Log Analytics workspace. The requirements for each endpoint differ and are outlined in the Configure Diagnostic settings section of this article.

### Subscriptions

- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- **Microsoft 365 E3 License** - Recommended for employing the Microsoft traffic forwarding profile. 

You must configure the endpoint for where you want to route the logs prior to configuring Diagnostic settings. The requirements for each endpoint vary and are described in the [Configure Diagnostic settings](#configure-diagnostic-settings) section.

## What the logs provide

The enriched Microsoft 365 logs provide information about Microsoft 365 workloads, so you can review network diagnostic data, performance data, and security events relevant to Microsoft 365 apps. For example, if access to Microsoft 365 is blocked for a user in your organization, you need visibility into how the user's device is connecting to your network.

These logs provide:

- Improved latency
- Additional information added to original logs
- Accurate IP address

These logs are a subset of the logs available in the [Microsoft 365 audit logs](/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?view=0365-worldwide&preserve-view=true). The logs are enriched with more information, including the device ID, operating system, and original IP address. Enriched SharePoint logs provide information on files that were downloaded, uploaded, deleted, modified, or recycled. Deleted or recycled list items are also included in the enriched logs.

## How to view the logs

Viewing the enriched Microsoft 365 logs is a two-step process. First, you need to enable the log enrichment from Global Secure Access. Second, you need to configure Microsoft Entra diagnostic settings to route the logs to an endpoint, such as a Log Analytics workspace.

> [!NOTE]
> At this time, only SharePoint Online logs are available for log enrichment.

### Enable the log enrichment

To enable the Enriched Microsoft 365 logs:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator).
1. Browse to **Global Secure Access** > **Settings** > **Logging**.
1. Select the type of Microsoft 365 logs you want to enable.
1. Select **Save**.

The enriched logs take up to 72 hours to fully integrate with the service.

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

1. Browse to **Identity** > **Monitoring & health** > **Diagnostic settings**.

1. Select **Add Diagnostic setting**.

1. Give your diagnostic setting a name.

1. Select `EnrichedOffice365AuditLogs`.

1. Select the **Destination details** for where you'd like to send the logs. Choose any or all of the following destinations. More fields appear, depending on your selection.

   - **Send to Log Analytics workspace:** Select the appropriate details from the menus that appear.
   - **Archive to a storage account:** Provide the number of days you'd like to retain the data in the **Retention days** boxes that appear next to the log categories. Select the appropriate details from the menus that appear.
   - **Stream to an event hub:** Select the appropriate details from the menus that appear.
   - **Send to partner solution:** Select the appropriate details from the menus that appear.

The following example is sending the enriched logs to a Log Analytics workspace, which requires selecting the Subscription and Log Analytics workspace from the menus that appear.

:::image type="content" source="media/how-to-view-enriched-logs/diagnostic-settings-enriched-logs.png" alt-text="Screenshot of the Microsoft Entra diagnostic settings, with the enriched logs and Log Analytics options highlighted." lightbox="media/how-to-view-enriched-logs/diagnostic-settings-enriched-logs.png":::



## Next steps

- [Explore the Global Secure Access logs and monitoring options](concept-global-secure-access-logs-monitoring.md)
- [Learn about Global Secure Access audit logs (preview)](how-to-access-audit-logs.md)
- [Enriched Microsoft 365 audit logs](reference-event-enrichment-logs.md)


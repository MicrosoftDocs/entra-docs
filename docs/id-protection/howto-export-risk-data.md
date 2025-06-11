---
title: Export and use Microsoft Entra ID Protection data
description: Learn about the many long-term data storage and monitoring options for exporting risk data from Microsoft Entra ID Protection.
ms.service: entra-id-protection
ms.topic: how-to
ms.date: 11/18/2024
author: shlipsey3
ms.author: sarahlipsey
manager: femila
ms.reviewer: cokoopma
ms.custom: sfi-image-nochange
# Customer intent: As an IT admin, I want to know how to export and use Microsoft Entra ID Protection data so that I can investigate using long-term data in Microsoft Entra ID Protection.
---
# How To: Export risk data

Microsoft Entra ID stores reports and security signals for a defined period of time. When it comes to risk information, that period might not be long enough.

| Report / Signal | Microsoft Entra ID Free | Microsoft Entra ID P1 | Microsoft Entra ID P2 |
| --- | --- | --- | --- |
| Audit logs | 7 days | 30 days | 30 days |
| Sign-ins | 7 days | 30 days | 30 days |
| Microsoft Entra multifactor authentication usage | 30 days | 30 days | 30 days |
| Risky sign-ins | 7 days | 30 days | 30 days |

This article describes the available methods for exporting risk data from Microsoft Entra ID Protection for long-term storage and analysis.

## Prerequisites

To export risk data for storage and analysis, you need:

- An Azure subscription to create a Log Analytics workspace, Azure event hub, or Azure storage account. If you don't have an Azure subscription, you can [sign up for a free trial](https://azure.microsoft.com/free/).
- [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) access to create general diagnostic settings for the Microsoft Entra tenant.

## Diagnostic settings

Organizations can choose to store or export **RiskyUsers**, **UserRiskEvents**, **RiskyServicePrincipals**, and **ServicePrincipalRiskEvents** data by configuring diagnostic settings in Microsoft Entra ID to export the data. You can integrate the data with a Log Analytics workspace, archive data to a storage account, stream data to an event hub, or send data to a partner solution.

The endpoint you select for exporting the logs must be set up before you can configure diagnostic settings. For a quick summary of the methods available for log storage and analysis, see [How to access activity logs in Microsoft Entra ID](../identity/monitoring-health/howto-access-activity-logs.md). 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator).

1. Browse to **Entra ID** > **Monitoring & health** > **Diagnostic settings**.

1. Select **+ Add diagnostic setting**.

1. Enter a **Diagnostic setting name**, select the log categories that you want to stream, select a previously configured destination, and select **Save**.

[![Screenshot of the diagnostic settings screen in Microsoft Entra ID.](./media/howto-export-risk-data/change-diagnostic-setting-in-portal.png)](./media/howto-export-risk-data/change-diagnostic-setting-in-portal.png#lightbox)

You might need to wait around 15 minutes for the data to start appearing in the destination you selected. For more information, see [How to configure Microsoft Entra diagnostic settings](../identity/monitoring-health/howto-configure-diagnostic-settings.md). 

## Log Analytics

Integrating risk data with Log Analytics provides robust data analysis and visualization capabilities. The high-level process for using Log Analytics to analyze risk data is as follows:

1. [Create a Log Analytics workspace](../identity/monitoring-health/tutorial-configure-log-analytics-workspace.md).
1. [Configure Microsoft Entra diagnostic settings to export the data](../identity/monitoring-health/howto-configure-diagnostic-settings.md).
1. [Query the data in Log Analytics](/azure/azure-monitor/logs/get-started-queries).

You need to configure a Log Analytics workspace before you can export and then query the data. Once you configured a Log Analytics workspace and exported the data with diagnostic settings, go to [Microsoft Entra admin center](https://entra.microsoft.com) > **Entra ID** > **Monitoring & health** > **Log Analytics**. Then, with Log Analytics, you can query data using built-in or custom Kusto queries.

The following tables are of most interest to Microsoft Entra ID Protection administrators:

- RiskyUsers - Provides data like the **Risky users** report.
- UserRiskEvents - Provides data like the **Risk detections** report.
- RiskyServicePrincipals - Provides data like the **Risky workload identities** report.
- ServicePrincipalRiskEvents - Provides data like the **Workload identity detections** report.

> [!NOTE]
> Log Analytics only has visibility into data as it is streamed. Events prior to enabling the sending of events from Microsoft Entra ID do not appear.

### Sample queries

[![Screenshot of Log Analytics view showing an AADUserRiskEvents query for the top 5 events.](./media/howto-export-risk-data/log-analytics-view-query-user-risk-events.png)](./media/howto-export-risk-data/log-analytics-view-query-user-risk-events.png#lightbox)

In the previous image, the following query was run to show the most recent five risk detections triggered. 

```kusto
AADUserRiskEvents
| take 5
```

Another option is to query the AADRiskyUsers table to see all risky users.

```kusto
AADRiskyUsers
```

View the count of high risk users by day:
 
```kusto
AADUserRiskEvents
| where TimeGenerated > ago(30d)
| where RiskLevel has "high"
| summarize count() by bin (TimeGenerated, 1d)
```

View helpful investigation details, such as user agent string, for detections that are high risk and aren't remediated or dismissed:
 
```kusto
AADUserRiskEvents
| where RiskLevel has "high"
| where RiskState has "atRisk"
| mv-expand ParsedFields = parse_json(AdditionalInfo)
| where ParsedFields has "userAgent"
| extend UserAgent = ParsedFields.Value
| project TimeGenerated, UserDisplayName, Activity, RiskLevel, RiskState, RiskEventType, UserAgent,RequestId
```

Access more queries and visual insights based on AADUserRiskEvents and AADRisky Users logs in the [Impact analysis of risk-based access policies workbook](workbook-risk-based-policy-impact.md).

## Storage account

By routing logs to an Azure storage account, you can keep data for longer than the default retention period.

1. [Create an Azure storage account](/azure/storage/common/storage-account-create).
1. [Archive Microsoft Entra logs to a storage account](../identity/monitoring-health/howto-archive-logs-to-storage-account.md).

## Azure Event Hubs

Azure Event Hubs can look at incoming data from sources like Microsoft Entra ID Protection and provide real-time analysis and correlation.

1. [Create an Azure event hub](/azure/event-hubs/event-hubs-create).
1. [Stream Microsoft Entra logs to an event hub](../identity/monitoring-health/howto-stream-logs-to-event-hub.md).

## Microsoft Sentinel

Organizations can choose to [connect Microsoft Entra data to Microsoft Sentinel](/azure/sentinel/data-connectors/azure-active-directory-identity-protection) for security information and event management (SIEM) and security orchestration, automation, and response (SOAR).

1. [Create a Log Analytics workspace](../identity/monitoring-health/tutorial-configure-log-analytics-workspace.md).
1. [Configure Microsoft Entra diagnostic settings to export the data](../identity/monitoring-health/howto-configure-diagnostic-settings.md).
1. [Connect data sources to Microsoft Sentinel](/azure/sentinel/configure-data-connector).

## Related content

- [Use Microsoft Graph API to programmatically interact with risk events](howto-identity-protection-graph-api.md)
- [Microsoft Entra ID Protection and the Microsoft Graph PowerShell SDK](howto-identity-protection-graph-api.md)
- [Overview of Azure partner solutions for diagnostic settings](/azure/partner-solutions/overview)

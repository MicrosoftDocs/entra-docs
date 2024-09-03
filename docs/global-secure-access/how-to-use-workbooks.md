---
title: How to use workbooks with Global Secure Access
description: Workbooks provide rich, interactive reports for Global Secure Access. Learn how to integrate workbooks with log analytics for Global Secure Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 08/20/2024
ms.service: global-secure-access

#Customer intent: As an IT admin, I need to learn how to use workbooks with Global Secure Access so I can better manage the solution.

---

# How to use workbooks with Global Secure Access

Workbooks combine text, log queries, metrics, and parameters into rich interactive reports. Any team member with access to the required Azure resources can create and edit workbooks. To learn more about Azure Workbooks, see [Overview of Azure Workbooks](/azure/azure-monitor/visualize/workbooks-overview).

## Prerequisites
- Administrators who interact with **Global Secure Access** features must have one or more of the following role assignments depending on the tasks they're performing.
   - The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
   - The [Security Administrator](/azure/active-directory/roles/permissions-reference#security-administrator) to create, edit, and use workbooks.
- An existing Log Analytics workspace. To learn more about Log Analytics, see [Overview of Log Analytics in Azure Monitor](/azure/azure-monitor/logs/log-analytics-overview).
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).


## Export Global Secure Access information to Log Analytics

Global Secure Access workbooks integrate with Log Analytics. This integration allows you to monitor and analyze logs effectively. To learn more about Global Secure Access log integration with Log Analytics, see [Integrate Microsoft Entra logs with Azure Monitor logs](../identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs.yml).

To learn how to send log information to Log Analytics, see [Send logs to Azure Monitor](../identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs.yml#send-logs-to-azure-monitor).

The Global Secure Access categories are: 

|Log type   |Diagnostic settings category   |
|----------|-----------|
|Traffic logs     |`NetworkAccessTrafficLogs`       |
|Audit logs (Preview) | `AuditLogs` |
|Enriched Microsoft 365 logs (Preview) |`EnrichedOffice365AuditLogs`   |
|Remote Network Health Logs (Preview) |`RemoteNetworkHealthLogs` |

:::image type="content" source="media/how-to-use-workbooks/add-diagnostic-setting.png" alt-text="Screenshot of the Microsoft Entra diagnostic settings, with the Global Secure Access logs categories selected." lightbox="media/how-to-use-workbooks/add-diagnostic-setting.png":::

## Global Secure Access workbooks

In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Monitor** > **Workbooks** to view predefined workbooks. Note that you won't see the workbooks unless logging data has been captured.

**Network Traffic Insights workbook** - 
Provides an overview of all traffic logs within your network, offering insights into data transfer, anomalies, and potential threats. 

**Remote Network Health workbook** - 
Monitors the health and performance of remote networks, ensuring that all remote connections are reliable and secure. 

**Clients Activity and Status workbook** - 
Offers an overview of the clients connected to your network, including their health status and activity levels. 

**Discovered Application Segments workbook** - 
Identifies and categorizes application segments discovered within your network, aiding in effective monitoring and management of applications. 

**Enriched Microsoft 365 Logs workbook** - 
Provides a detailed view of Microsoft 365 log data, enriched with contextual information to enhance visibility into user activities and potential security threats. 

## Next steps

- [View network traffic logs](how-to-view-traffic-logs.md)
- [Access the enriched Microsoft 365 logs](how-to-view-enriched-logs.md)

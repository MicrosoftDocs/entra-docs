---
title: Understand how Provisioning integrates with Azure Monitor logs in Microsoft Entra ID.
description: Understand how Provisioning integrates with Azure Monitor logs in Microsoft Entra ID.

author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: conceptual
ms.date: 02/07/2024
ms.author: kenwith
ms.reviewer: arvinh
---

# Understand how provisioning integrates with Azure Monitor logs

Provisioning integrates with Azure Monitor logs and Log Analytics. With Azure monitoring you can do things like create workbooks, also known as dashboards, store provisioning logs for 30+ days, and create custom queries and alerts. This article discusses how provisioning logs integrate with Azure Monitor logs. To learn more about how provisioning logs work in general, see [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md).

## Enabling provisioning logs

You should already be familiar with Azure monitoring and Log Analytics. If not, jump over to learn about them, and then come back to learn about application provisioning logs. To learn more about Azure monitoring, see [Azure Monitor overview](/azure/azure-monitor/overview). To learn more about Azure Monitor logs and Log Analytics, see [Overview of log queries in Azure Monitor](/azure/azure-monitor/logs/log-query-overview).

Once you've configured Azure monitoring, you can enable logs for application provisioning. The option is located on the **Diagnostics settings** page.

:::image type="content" source="media/application-provisioning-log-analytics/diagnostic-settings.png" alt-text="Access diagnostic settings" lightbox="media/application-provisioning-log-analytics/diagnostic-settings.png":::

:::image type="content" source="media/application-provisioning-log-analytics/enable-log-analytics.png" alt-text="Enable application provisioning logs" lightbox="media/application-provisioning-log-analytics/enable-log-analytics.png":::

> [!NOTE]
> If you have just recently provisioned a workspace, it can take some time before you can send logs to it. If you receive an error that the subscription is not registered to use *microsoft.insights* then check back after a few minutes.

## Understanding the data
The underlying data stream that Provisioning sends log viewers is almost identical. Azure Monitor logs gets nearly the same stream as the Azure portal UI and Azure API. There are only a few **differences** in the log fields as outlined in the following table. To learn more about these fields, see [List provisioningObjectSummary](/graph/api/provisioningobjectsummary-list?preserve-view=true&tabs=http&view=graph-rest-beta).

|Azure Monitor logs   |Azure portal UI   |Azure API |
|----------|-----------|------------|
|errorDescription |reason |resultDescription |
|status |resultType |resultType |
|activityDateTime |TimeGenerated |TimeGenerated |


## Azure Monitor workbooks

Azure Monitor workbooks provide a flexible canvas for data analysis. They also provide for the creation of rich visual reports within the Azure portal. To learn more, see [Azure Monitor Workbooks overview](/azure/azure-monitor/visualize/workbooks-overview).

Application provisioning comes with a set of prebuilt workbooks. You can find them on the Workbooks page. To view the data, ensure that all the filters (timeRange, jobID, appName) are populated. Also confirm the app was provisioned, otherwise there isn't any data in the logs.

:::image type="content" source="media/application-provisioning-log-analytics/workbooks.png" alt-text="Application provisioning workbooks" lightbox="media/application-provisioning-log-analytics/workbooks.png":::

:::image type="content" source="media/application-provisioning-log-analytics/report.png" alt-text="Application provisioning dashboard" lightbox="media/application-provisioning-log-analytics/report.png":::

## Custom queries

You can create custom queries and show the data on Azure dashboards. To learn how, see [Create and share dashboards of Log Analytics data](/azure/azure-monitor/logs/get-started-queries). Also, be sure to check out [Overview of log queries in Azure Monitor](/azure/azure-monitor/logs/log-query-overview).

Here are some samples to get started with application provisioning.

Query the logs for a user a based on their ID in the source system:
```kusto
AADProvisioningLogs
| extend SourceIdentity = parse_json(SourceIdentity)
| where tostring(SourceIdentity.Id) == "49a4974bb-5011-415d-b9b8-78caa7024f9a"
```

Summarize count per ErrorCode:
```kusto
AADProvisioningLogs
| summarize count() by ErrorCode = ResultSignature
```

Summarize count of events per day by action:
```kusto
AADProvisioningLogs
| where TimeGenerated > ago(7d)
| summarize count() by Action, bin(TimeGenerated, 1d)
```

Take 100 events and project key properties:
```kusto
AADProvisioningLogs
| extend SourceIdentity = parse_json(SourceIdentity)
| extend TargetIdentity = parse_json(TargetIdentity)
| extend ServicePrincipal = parse_json(ServicePrincipal)
| where tostring(SourceIdentity.identityType) == "Group"
| project tostring(ServicePrincipal.Id), tostring(ServicePrincipal.Name), ModifiedProperties, JobId, Id, CycleId, ChangeId, Action, SourceIdentity.identityType, SourceIdentity.details, TargetIdentity.identityType, TargetIdentity.details, ProvisioningSteps
| take 100
```

Retrieve groups with skipped members due to problems resolving references.
```kusto
AADProvisioningLogs
| where TimeGenerated >= ago(10d)
| where JobId == "Azure2Azure.73f0883f-d67d-4af1-ac8a-45367f8982e0.5ef3be57-f45f-451g-88c4-68a7fda680bb" // Customize by adding a specific app JobId
| extend SourceIdentity = parse_json(SourceIdentity)
| extend ProvisioningSteps = parse_json(ProvisioningSteps)
| where tostring(SourceIdentity.identityType) == "Group"
| where ProvisioningSteps matches regex "UnableToResolveReferenceAttributeValue"
| parse tostring(ProvisioningSteps.[2].description) with "We were unable to assign " userObjectId " as the members of " groupDisplayName "." *
| project groupDisplayName, userObjectId,  JobId
| take 100
```

Summarize actions by application.
```kusto
AADProvisioningLogs
| where TimeGenerated > ago(30d)
| where JobId == "Azure2Azure.73f0883f-d67d-4af1-ac8a-45367f8982e0.5ef3be57-f45f-451g-88c4-68a7fda680bb" // Customize by adding a specific app JobId
| extend ProvisioningSteps = parse_json(ProvisioningSteps)
| extend eventName = tostring(ProvisioningSteps.[-1].name)
| summarize count() by eventName, JobId
| order by JobId asc
| take 5
```

Identify spikes in specific operations. 

```kusto
AADProvisioningLogs
| where TimeGenerated > ago(30d)
| where JobId == "scim.73f0883f-d67d-4af1-ac8a-45367f8982e0.5ef3be57-f45f-451g-88c4-68a7fda680bb" // Customize by adding a specific app JobId
| extend ProvisioningSteps = parse_json(ProvisioningSteps)
| extend eventName = tostring(ProvisioningSteps.[-1].name)
| summarize count() by eventName, bin(TimeGenerated, 1d)
| render timechart
```
## Custom alerts

Azure Monitor lets you configure custom alerts so that you can get notified about key events related to Provisioning. For example, you might want to receive an alert on spikes in failures. Or perhaps spikes in disables or deletes. Another example of where you might want to be alerted is a lack of any provisioning, which indicates something is wrong.

To learn more about alerts, see [Azure Monitor Log Alerts](/azure/azure-monitor/alerts/alerts-create-new-alert-rule).

Alert when there's a spike in failures. Replace the jobID with the jobID for your application.

:::image type="content" source="media/application-provisioning-log-analytics/alert1.png" alt-text="Alert when there's a spike in failures." lightbox="media/application-provisioning-log-analytics/alert1.png":::

There may be an issue that caused the provisioning service to stop running. Use the following alert to detect when there are no provisioning events during a given time interval.

:::image type="content" source="media/application-provisioning-log-analytics/alert2.png" alt-text="There may be an issue that caused the provisioning service to stop running." lightbox="media/application-provisioning-log-analytics/alert2.png":::

Alert when there's a spike in disables or deletes.

:::image type="content" source="media/application-provisioning-log-analytics/alert3.png" alt-text="Alert when there's a spike in disables or deletes." lightbox="media/application-provisioning-log-analytics/alert3.png":::


## Community contributions

We're taking an open source and community-based approach to application provisioning queries and dashboards. Build a query, alert, or workbook that you think is useful to others, then publish it to the [AzureMonitorCommunity GitHub repo](https://github.com/microsoft/AzureMonitorCommunity). Shoot us an email with a link. We review and publish queries and dashboards to the service so others benefit too. Contact us at provisioningfeedback@microsoft.com.

## Next steps

- [Log analytics](~/identity/monitoring-health/howto-analyze-activity-logs-log-analytics.md)
- [Get started with queries in Azure Monitor logs](/azure/azure-monitor/logs/get-started-queries)
- [Create and manage alert groups in the Azure portal](/azure/azure-monitor/alerts/action-groups)
- [Install and use the log analytics views for Microsoft Entra ID](/azure/azure-monitor/visualize/workbooks-view-designer-conversion-overview)
- [Provisioning logs API](/graph/api/resources/provisioningobjectsummary?preserve-view=true&view=graph-rest-beta)

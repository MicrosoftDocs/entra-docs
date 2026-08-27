---
title: View monitor results and manage monitors
titleSuffix: Microsoft Entra ID Governance
description: Learn how to view monitor results and configuration drifts and manage configuration monitors in Microsoft Entra Tenant Governance
ms.topic: how-to
ms.date: 07/28/2026
---

<!-- source: Tenant Governance - View monitor results and manage monitors how-to.docx -->

# View monitor results and manage monitors

Use the monitor experience to review monitor definitions, monitor run results, configuration drifts, baseline details, permissions readiness, settings, and audit logs. This article describes how to use the monitor pages after a monitor is created.

## Prerequisites

- At least one configuration monitor exists in the tenant.
- You can sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with a role that can view Tenant Governance monitor data.
- The Tenant Configuration Management service has the permissions required to run the monitor. If a monitor run fails because of missing service permissions, [update the service permissions](how-to-set-up-permissions-tenant-monitoring.md) before you rely on later run results.

## View monitors

To view the configuration monitors in your tenant, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Tenant Governance** > **Monitors**.
1. On the **Monitors** tab, review monitor definitions, create a monitor, refresh the list, or select a monitor to open its details.

## View monitor results

To review the results of monitor runs, follow these steps:

1. Select the **Monitor results** tab.
1. Review the monitor name, monitor ID, start time, completion time, run status, and number of detected drifts.

A monitor result summarizes a single monitor run. Use this page to identify failed or partially successful runs, and to find runs that detected configuration drift.

## View configuration drifts

To review the configuration drifts a monitor detected, follow these steps:

1. Select the **Configuration drifts** tab.
1. Review the monitor, resource name, resource type, drifted properties, and first detection time.

A drift record identifies the resource and property that differ from the baseline. Use this page when you need to decide which workload administration experience to use for remediation.

## Manage a monitor

To review and manage an individual monitor, follow these steps:

1. Select a monitor from the monitor list.
1. On **Overview**, review the **Details**, **Monitoring**, and **Audit** cards. **Details** shows the display name, description, creation date, and the services whose resources are monitored. The **Monitoring** card shows the last monitor run time, resource type, count, and configuration drifts. The **Audit** card shows audit events, such as monitor creation and update events, from the last 30 days, and the date of the last audit event.
1. On **Monitor results**, review the run history for the selected monitor.
1. On **Configuration drifts**, review the drift records for the selected monitor.
1. On **Baseline**, view, edit, or download the monitor baseline JSON.
1. On **Permissions**, review the service authorization readiness.
1. On **Settings**, view and manage the display name and description for the monitor.
1. On **Audit logs**, review the create and update events for the monitor.

## Correct configuration drift

Tenant Governance reports drift, but remediation happens in the administration experience that owns the drifted resource. For example, use the Microsoft Entra admin center or Microsoft Graph PowerShell to update a Conditional Access policy, or use the Exchange admin center or Exchange Online PowerShell to update an Exchange transport rule.

After you remediate drift, the next monitor run evaluates the tenant again and confirms that the actual resource state matches the baseline.

## Related content

- [Configuration management](configuration-management.md)
- [configurationMonitor](/graph/api/resources/configurationmonitor?view=graph-rest-1.0&preserve-view=true)
- [configurationMonitoringResult](/graph/api/resources/configurationmonitoringresult?view=graph-rest-1.0&preserve-view=true)
- [configurationDrift](/graph/api/resources/configurationdrift?view=graph-rest-1.0&preserve-view=true)
- [Create a configuration monitor](how-to-create-monitor.md)

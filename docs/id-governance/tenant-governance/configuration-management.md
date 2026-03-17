---
title: Configuration management in Tenant Governance (preview)
description: Learn about configuration management capabilities in Microsoft Entra Tenant Governance, including baselines and drift monitoring.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/11/2026
---

# Configuration management (preview)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Configuration management in Microsoft Entra Tenant Governance lets you define configuration baselines, monitor tenants for drift, and generate snapshots of current settings. This article explains the core concepts: resources, baselines, monitors, monitoring results, configuration drifts, and snapshot jobs.

## Resources

A **resource** represents a macro configuration component that you can manage through configuration-as-code. The tenant configuration management solution supports hundreds of resource types that you can include in your configuration baselines. Each resource defines multiple properties that the solution can manage.

For example, a Conditional Access policy in Microsoft Entra ID is represented by the `microsoft.entra.conditionalaccesspolicy` resource. That resource exposes properties such as `ExcludedUsers`, `IncludedGroups`, and `State` that you can define in your configuration baseline. For a full list of resources, see [Overview of Tenant Configuration Management](/graph/unified-tenant-configuration-management-concept-overview).

## Baselines

A **baseline** is the JSON representation of the configuration you want to monitor for a given tenant. It consists of a list of resources and the defined values for their associated properties. A baseline can contain multiple instances of a given resource type.

For example, a configuration baseline can define multiple instances of Exchange Online transport rules as part of its definition. To learn more about configuration baselines, see [Configuration baseline](/graph/api/resources/configurationbaseline?view=graph-rest-beta&preserve-view=true).

## Monitors

**Monitors** are core to the tenant configuration management solution. They run the processes responsible for continuously monitoring your tenants for configuration drifts. Each monitor references a JSON configuration baseline that specifies the resources to validate. The monitor definition also includes a name, description, schedule frequency, and a configuration mode that specifies the actions to perform when drifts are detected.

> [!NOTE]
> The Unified Tenant Configuration Management service principal must have read permissions for the resource types defined in the associated baselines. This requirement applies to both monitors and snapshot jobs. See [Authentication setup](/graph/utcm-authentication-setup) to learn how to grant the required permissions.

To learn more about monitors, see [configurationMonitor](/graph/api/resources/configurationmonitor?view=graph-rest-beta&preserve-view=true).

## Monitoring results

Every time a monitor executes based on its specified schedule, it produces a **monitoring result** that summarizes the execution. A monitoring result contains the execution duration, a status that indicates whether resource evaluation succeeded, and a count of detected drifts.

If drifts are detected, the monitoring result reports their presence but doesn't include drift details. To get detailed information about each drift, query the associated configuration drift objects.

To learn more about monitoring results, see [configurationMonitoringResult](/graph/api/configurationmonitoringresult-get?view=graph-rest-beta&preserve-view=true).

## Configuration drifts

When a delta exists between what a configuration baseline defines and the actual settings on a tenant, Tenant Governance reports a **configuration drift**. Configuration drifts are associated with a monitor and contain detailed information about the detected delta. Each drift object identifies the affected resource and lists each property whose current value differs from the baseline definition.

After you remediate a detected drift, the next monitor execution automatically marks the configuration drift object as `fixed`. To learn more about configuration drifts, see [configurationDrift](/graph/api/resources/configurationdrift?view=graph-rest-beta&preserve-view=true).

## Snapshot jobs

When you initiate a request to generate a snapshot, an asynchronous job collects the current state of the specified resources. This **snapshot job** generates the actual JSON content of the requested snapshot. When the job completes, it returns a status of `succeeded` and a `resourceLocation` URL where you can download the JSON snapshot.

> [!IMPORTANT]
> Snapshot jobs and their associated snapshots have a retention period of 7 days, after which they're deleted. Download and store generated snapshots before the retention period expires.

The generated snapshot schema matches the schema of configuration baselines. Use a snapshot as-is to create monitors.

To learn more about snapshot jobs, see [configurationSnapshotJob](/graph/api/resources/configurationsnapshotjob?view=graph-rest-beta&preserve-view=true).

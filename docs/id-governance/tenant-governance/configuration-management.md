---
title: Configuration management in Tenant Governance
titleSuffix: Microsoft Entra ID Governance
description: Learn about baseline templates, deployments, cross-tenant monitors, and drift detection in Microsoft Entra Tenant Governance.
ms.topic: concept-article
ms.date: 11/12/2026
ai-usage: ai-assisted
# Customer intent: As a tenant administrator, I want to understand baselines, monitors, configuration drifts, and snapshots so that I can plan configuration monitoring for my tenants.
---

# Configuration management

Configuration management in Microsoft Entra Tenant Governance lets you capture current settings, define configuration baselines, standardize baselines as templates, deploy configuration, and monitor tenants for drift.

Configuration management supports operations in the **home tenant** and in **other tenants** that are connected through [governance relationships](governance-relationships.md). The home tenant is the tenant where you manage the operation. Other tenants are governed tenants that you select as targets.

Tenant Governance Basic includes both home-tenant and cross-tenant configuration management. Tenant Governance Premium isn't required solely to manage configuration across governed tenants; Premium licenses add monitoring and snapshot capacity. For details, see [Microsoft Entra Tenant Governance licensing](licensing.md).

The monitor view shows the configuration management navigation, monitor definitions, and entry points for results and drifts.

:::image type="content" source="../media/tenant-governance-configuration-management/monitors-overview.png" alt-text="Screenshot of monitors with Tenant Governance navigation and results and drifts tabs." lightbox="../media/tenant-governance-configuration-management/monitors-overview.png":::

> [!NOTE]
> Configuration management is built on the Microsoft Graph [Tenant Configuration Management APIs](/graph/unified-tenant-configuration-management-concept-overview), which are generally available. These APIs provide the configuration-as-code capabilities described in this article, including snapshots, baselines, monitors, and drift detection.

## Resources

A **resource** represents a macro configuration component that you can manage through configuration-as-code. The tenant configuration management solution supports hundreds of resource types that you can include in your configuration baselines. Each resource defines multiple properties that the solution can manage.

For example, a Conditional Access policy in Microsoft Entra ID is represented by the `microsoft.entra.conditionalaccesspolicy` resource. That resource exposes properties such as `ExcludedUsers`, `IncludedGroups`, and `State` that you can define in your configuration baseline. For a full list of resources, see [Overview of Tenant Configuration Management](/graph/unified-tenant-configuration-management-concept-overview).

## Baselines

A **baseline** is the JSON representation of the configuration you want to monitor or deploy for a given tenant. It consists of a list of resources and the defined values for their associated properties. A baseline can contain multiple instances of a given resource type.

For example, a configuration baseline can define multiple instances of Exchange Online transport rules as part of its definition. To learn more about configuration baselines, see [Configuration baseline](/graph/api/resources/configurationbaseline?view=graph-rest-1.0&preserve-view=true).

## Configuration baseline templates (Preview)

A **configuration baseline template** is a reusable baseline definition. Use Configuration baseline templates to standardize baseline definitions across monitors and deployments. Templates help you reuse approved settings and simplify setup across environments and tenants.

A configuration baseline template defines resource settings. It's different from a [governance policy template](governance-policy-templates.md), which defines access through a governance relationship.

For lifecycle and versioning guidance, see [Configuration baseline templates](configuration-baseline-templates.md).

## Configuration deployments (Preview)

A **configuration deployment** applies baseline-defined settings to a target tenant. Use Configuration deployments to apply baseline-defined configuration to the home tenant or governed tenants.

Deployments change configuration; monitors evaluate it. After deployment, use a monitor to verify that the target tenant aligns with the baseline and to detect later changes. For status and failure handling, see [Configuration deployments](configuration-deployments.md).

## Monitors

**Monitors** are core to the tenant configuration management solution. They run the processes responsible for continuously monitoring your tenants for configuration drifts. Each monitor references a JSON configuration baseline that specifies the resources to validate. The monitor definition also includes a name, description, schedule frequency, and a configuration mode that specifies the actions to perform when drifts are detected.

### Cross-tenant monitors (Preview)

A monitor targets either the home tenant or another tenant connected through an active governance relationship. For other-tenant monitoring, configure the required delegated permissions and workload access before creating the monitor. A relationship alone doesn't grant every workload permission.

Choose **Monitors** under **Tenant management** for the home tenant, or **Monitors (Preview)** under **Other tenants** for a governed tenant. Select a governed target in the other-tenant creation wizard. Review results and drift records in the context of that target tenant.

:::image type="content" source="../media/tenant-governance-configuration-management/governed-tenant-monitors.png" alt-text="Screenshot of governed-tenant monitors with target tenant and run status columns." lightbox="../media/tenant-governance-configuration-management/governed-tenant-monitors.png":::

> [!NOTE]
> The Unified Tenant Configuration Management service principal must have read permissions for the resource types defined in the associated baselines. This requirement applies to both monitors and snapshot jobs. See [Authentication setup](/graph/utcm-authentication-setup) to learn how to grant the required permissions.

To learn more about monitors, see [configurationMonitor](/graph/api/resources/configurationmonitor?view=graph-rest-1.0&preserve-view=true).

## Monitoring results

Every time a monitor executes based on its specified schedule, it produces a **monitoring result** that summarizes the execution. A monitoring result contains the execution duration, a status that indicates whether resource evaluation succeeded, and a count of detected drifts.

Monitoring results can describe runs in the home tenant or governed tenants. Use tenant filters to distinguish results for each target tenant.

If drifts are detected, the monitoring result reports their presence but doesn't include drift details. To get detailed information about each drift, query the associated configuration drift objects.

To learn more about monitoring results, see [configurationMonitoringResult](/graph/api/configurationmonitoringresult-get?view=graph-rest-1.0&preserve-view=true).

## Configuration drifts

When a delta exists between what a configuration baseline defines and the actual settings on a tenant, Tenant Governance reports a **configuration drift**. Configuration drifts are associated with a monitor and contain detailed information about the detected delta. Each drift object identifies the affected resource and lists each property whose current value differs from the baseline definition.

Drift records belong to the monitor's target tenant, whether it's the home tenant or a governed tenant. After you remediate a detected drift, the next monitor execution automatically marks the configuration drift object as `fixed` if the resource matches the baseline. To learn more about configuration drifts, see [configurationDrift](/graph/api/resources/configurationdrift?view=graph-rest-1.0&preserve-view=true).

## Snapshot jobs

When you initiate a request to generate a snapshot, an asynchronous job collects the current state of the specified resources. This **snapshot job** generates the actual JSON content of the requested snapshot. When the job completes, it returns a status of `succeeded` and a `resourceLocation` URL where you can download the JSON snapshot.

> [!IMPORTANT]
> Snapshot jobs and their associated snapshots have a retention period of 7 days, after which they're deleted. Download and store generated snapshots before the retention period expires.

The generated snapshot schema matches the schema of configuration baselines. Use a snapshot to create a baseline template, deployment, or monitor. Review the captured values before using them as your desired configuration.

To learn more about snapshot jobs, see [configurationSnapshotJob](/graph/api/resources/configurationsnapshotjob?view=graph-rest-1.0&preserve-view=true).

## Related content

- [Configure configuration management service permissions](how-to-set-up-permissions-tenant-monitoring.md).
- [Create configuration snapshots](how-to-create-snapshots.md).
- [Use configuration baseline templates](how-to-use-configuration-baseline-templates.md).
- [Create a configuration deployment](how-to-create-configuration-deployment.md).
- [Create a configuration monitor](how-to-create-monitor.md).
- [View monitor results and manage monitors](how-to-see-monitor-results.md).

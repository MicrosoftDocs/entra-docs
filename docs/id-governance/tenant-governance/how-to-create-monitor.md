---
title: Create a configuration monitor
titleSuffix: Microsoft Entra ID Governance
description: Learn how to create a configuration monitor in Microsoft Entra Tenant Governance to evaluate a tenant against a configuration baseline and report drift
ms.topic: how-to
ms.date: 07/28/2026
---

<!-- source: Tenant Governance - Create a new configuration monitor how-to.docx -->

# Create a configuration monitor

Configuration monitors evaluate a tenant against a configuration baseline and report configuration drift. Use a monitor when you want to track whether a tenant stays aligned with a known-good configuration.

## Prerequisites

- The tenant has licenses for **Tenant Governance Basic** or **Tenant Governance Premium**. For current licensing requirements, see [Microsoft Entra Tenant Governance licensing](licensing.md).
- Tenant Governance Basic includes a quota for the number of resources that you can monitor. If the resources in the monitor cause the tenant to exceed its quota, monitor creation fails. An organization gets additional quota for monitored resources for each Tenant Governance Premium license it has.
- The signed-in user is in a Microsoft Entra privileged role and has permission to create configuration monitors. The user must also have read permissions for the resource types included in the monitor's configuration baseline.
- The Tenant Configuration Management service has permissions for the workloads and resource types included in the monitor baseline. To assign or remove permissions for the service, see [Configure configuration management service permissions](how-to-set-up-permissions-tenant-monitoring.md).

## Start monitor creation

To start creating a configuration monitor, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a user with the required role and permissions.
1. Browse to **Tenant Governance** > **Monitors**.
1. Select **New**.

## Complete the monitor wizard

Complete the wizard steps to configure and create the monitor:

1. On **Settings**, enter a unique monitor name of at least eight characters and an optional description.
1. On **Configuration baseline**, upload a baseline JSON file or select **Import from snapshot**. If you select **Import from snapshot**, search by snapshot name, select a snapshot, and then select **Import**. You can use the in-page editor to manually compose or edit the configuration baseline.
1. On **Permissions**, review whether the service has permission to:

   - Read the required Microsoft Graph resources, to monitor Microsoft Entra or Intune resources.
   - Authenticate to Exchange, to monitor Exchange, Defender, or Purview resources.
   - Use the **Teams Reader** role, to monitor Teams resources.

   > [!NOTE]
   > This step doesn't evaluate whether the user is authorized to create a monitor with the selected resources. It also doesn't show or validate whether the permissions assigned to the configuration management service locally within Exchange Online, Defender, or Purview are sufficient to create a monitor with resources in those services.

1. On **Review**, review the summary and create the monitor.

After you create the monitor, it runs automatically on a periodic schedule. Monitor results are available after the monitor runs for the first time, between zero and six hours after creation.

To learn how to review monitor results and configuration drift, see [View monitor results and manage monitors](how-to-see-monitor-results.md).

## Related content

- [Configuration management](configuration-management.md)
- [configurationMonitor](/graph/api/resources/configurationmonitor?view=graph-rest-1.0&preserve-view=true)
- [configurationBaseline](/graph/api/resources/configurationbaseline?view=graph-rest-1.0&preserve-view=true)
- [Configure configuration management service permissions](how-to-set-up-permissions-tenant-monitoring.md)
- [Create configuration snapshots](how-to-create-snapshots.md)

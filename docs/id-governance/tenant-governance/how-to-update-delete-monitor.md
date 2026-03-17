---
title: Update or delete a monitor (preview)
description: Learn how to update or delete a configuration monitor in Microsoft Entra Tenant Governance.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/05/2026
---

# Update or delete a monitor (preview)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes how to update or delete a configuration monitor in the [Microsoft Entra admin center](https://entra.microsoft.com). You might update a monitor when your configuration baseline changes. Delete a monitor when the monitored resources are no longer important for your organization's security or compliance requirements.

## Prerequisites

- Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
- Your tenant must have a license for Microsoft Entra Tenant Governance.
- At least one configuration monitor must exist in your tenant.

## Update a monitor

To update an existing configuration monitor:

1. Browse to **Tenant Governance** > **Configuration management** > **Monitors**.
1. Find the monitor you want to update and select the edit (pencil) icon next to its name.

The update wizard uses the same steps as creating a monitor: **Permissions** → **Configuration baseline** → **Review**.

When you update an existing configuration monitor, the updated settings replace the existing monitor definition.

> [!IMPORTANT]
> When you update an existing monitor, Tenant Governance automatically deletes all previously generated monitor results and configuration drifts. The updated monitor records results and drifts again each time it runs.

## Delete a monitor

Deleting a monitor can't be undone. When you delete a monitor, Tenant Governance also immediately deletes all associated monitor results and configuration drifts.

To delete a configuration monitor:

1. Browse to **Tenant Governance** > **Configuration management** > **Monitors**.
1. Find the monitor you want to delete.
1. Select the checkbox next to the monitor's name, then select **Delete** in the command bar. Alternatively, hover over the monitor name and select the delete icon that appears.
1. In the confirmation dialog, select **Delete**.

## Related content

- [Create a monitor](how-to-create-monitor.md)
- [See monitor results and configuration drifts](how-to-see-monitor-results.md)
- [Set up permissions for tenant monitoring](how-to-setup-permissions-tenant-monitoring.md)
- [Configuration management](configuration-management.md)

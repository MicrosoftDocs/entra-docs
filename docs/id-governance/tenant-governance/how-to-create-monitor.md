---
title: Create a monitor (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn how to create and configure a tenant configuration monitor in Microsoft Entra Tenant Governance to track configuration drift
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: Create_and_Update_Configuration_Monitor_LearnStyle.docx -->

# Create and update a configuration monitor (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

This article describes how to create and update a configuration monitor in the [Microsoft Entra admin center](https://entra.microsoft.com). A configuration monitor periodically evaluates your tenant configuration against a configuration baseline. It records configuration drifts when the actual state differs from the desired state.

## Before you begin

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).

1. Verify that your tenant has a license for Microsoft Entra Tenant Governance.

1. Verify that you have the required Microsoft Graph application permissions for the resource types included in your configuration baseline.

> [!TIP]
> Although you can author a configuration baseline directly in the wizard, in most scenarios it's easiest to prepare the baseline before you start monitor creation. One approach is to copy the baseline from an existing monitor. To learn more, see [Configuration management](configuration-management.md).

## Create a configuration monitor

Use these steps to create a new configuration monitor. The monitor creation wizard guides you through **Permissions**, **Configuration baseline**, and **Review**.

### Step 1: Permissions

On the **Permissions** page, review the Microsoft Graph application permissions required to evaluate the resource types defined in the configuration baseline. Add or remove permissions as needed, then grant all required permissions before you proceed.

Select **Next** to continue.

### Step 2: Configuration baseline

On the **Configuration baseline** page, write, paste, or upload the JSON file that defines the desired configuration state for the resources you want to monitor. The JSON includes the configuration baseline and elements that define the display name and description of the monitor. The monitor evaluates this baseline each time it runs.

After you validate the baseline, select **Next**.

### Step 3: Review

On the **Review** page, confirm the monitor name, description, and configuration baseline. Verify that the resource count matches what you intend.

Select **Create monitor** to create the configuration monitor.

## Update an existing configuration monitor

To update an existing configuration monitor:

1. Browse to **Tenant Governance** > **Configuration management** > **Monitors**.
1. Find the monitor you want to update and select the edit (pencil) icon next to its name.

The update wizard uses the same steps as creating a monitor: **Permissions** → **Configuration baseline** → **Review**.

When you update an existing configuration monitor, the updated settings replace the existing monitor definition.

> [!IMPORTANT]
> When you change an existing monitor, Tenant Governance automatically deletes all previously generated monitor results and configuration drifts. The updated monitor records results and configuration drifts again each time it runs.
>
> After you create or update a monitor, you might need to wait up to six hours for the monitor to run. After the monitor runs, view monitor results and configuration drifts.

## Next steps

- [Configuration management](configuration-management.md)
- [See monitor results and configuration drifts](how-to-see-monitor-results.md)
- [Update or delete a monitor](how-to-update-delete-monitor.md)
- [Set up permissions for tenant monitoring](how-to-set-up-permissions-tenant-monitoring.md)

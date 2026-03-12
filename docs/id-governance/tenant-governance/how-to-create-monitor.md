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

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes how to create and update a configuration monitor in the [Microsoft Entra admin center](https://entra.microsoft.com). A configuration monitor periodically evaluates your tenant configuration against a configuration baseline. It records configuration drifts when the actual state differs from the desired state.

## Before you begin

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).

1. Verify that you have the required Microsoft Graph application permissions for the resource types included in your configuration baseline.

## Create a configuration monitor

Use these steps to create a new configuration monitor. The monitor creation wizard guides you through Permissions, Configuration baseline, and Review.

### Step 1: Permissions

On the **Permissions** page, review the Microsoft Graph application permissions required to evaluate the resource types defined in the configuration baseline. Grant all required permissions before you proceed.

Select **Next** to continue.

### Step 2: Configuration baseline

On the **Configuration baseline** page, upload or edit the JSON file that defines the desired configuration state for the resources you want to monitor. The monitor evaluates this baseline each time it runs.

After you validate the baseline, select **Next**.

### Step 3: Review

On the **Review** page, confirm the monitor name, description, and configuration baseline.

Select **Create monitor** to create the configuration monitor.

## Update an existing configuration monitor

Updating a configuration monitor uses the same wizard flow and steps as creating a monitor: **Permissions → Configuration baseline → Review**.

When you update an existing configuration monitor, the updated settings replace the existing monitor definition.

> [!IMPORTANT]
> When you change an existing monitor, Tenant Governance automatically deletes all previously generated monitor results and configuration drifts. The updated monitor records results and configuration drifts again each time it runs.

## Next steps

- [Author a configuration baseline](how-to-author-configuration-baseline.md)
- [See monitor results and configuration drifts](how-to-see-monitor-results.md)
- [Update or delete a monitor](how-to-update-delete-monitor.md)
- [Set up permissions for tenant monitoring](how-to-setup-permissions-tenant-monitoring.md)

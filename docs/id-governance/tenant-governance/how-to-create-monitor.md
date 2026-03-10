---
title: Create a monitor
description: Learn how to create and configure a tenant configuration monitor in Microsoft Entra tenant governance to track configuration drift
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: Create_and_Update_Configuration_Monitor_LearnStyle.docx -->

# Create and update a configuration monitor

This article describes how to create and update a configuration monitor in the Microsoft Entra admin center. A configuration monitor periodically evaluates your tenant configuration against a configuration baseline and records configuration drifts when the actual state differs from the desired state.

## Before you begin

You must be signed in as a Global Administrator. Ensure that the required Microsoft Graph application permissions are available for the resource types included in your configuration baseline.

## Create a configuration monitor

Use the following steps to create a new configuration monitor. The monitor creation wizard guides you through Permissions, Configuration baseline, and Review.

### Step 1: Permissions

On the **Permissions** page, review the Microsoft Graph application permissions required to evaluate the resource types defined in the configuration baseline. All required permissions must be granted before you can proceed.

Select **Next** to continue.

### Step 2: Configuration baseline

On the **Configuration baseline** page, upload or edit the JSON file that defines the desired configuration state for the resources you want to monitor. This baseline is evaluated each time the monitor runs.

After validating the baseline, select **Next**.

### Step 3: Review

On the **Review** page, confirm the monitor name, description, and configuration baseline.

Select **Create monitor** to create the configuration monitor.

## Update an existing configuration monitor

Updating a configuration monitor uses the same wizard flow and steps as creating a monitor: **Permissions → Configuration baseline → Review**.

When you update an existing configuration monitor, the monitor definition is replaced with the updated settings.

> [!IMPORTANT]
> When an existing monitor is changed, all previously generated monitor results and configuration drifts are automatically deleted. Results and configuration drifts are recorded again each time the updated monitor runs in the future.

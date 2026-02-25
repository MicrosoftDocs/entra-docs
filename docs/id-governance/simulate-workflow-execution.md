---
title: Simulate workflow execution using the What-if tool
description: Learn how to use the What-if tool in Lifecycle Workflows to simulate workflow execution and preview results without impacting actual users.
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 02/25/2026
ms.custom: template-how-to
ai-usage: ai-assisted
---

# Simulate workflow execution using the What-if tool

The What-if tool in Lifecycle Workflows lets you evaluate workflow execution before it runs for your users. Using the What-if tool, you can:

- View which users are currently in the execution scope of a workflow.
- Preview which workflow tasks might fail based on the current configuration.
- Simulate workflow execution for up to 10 users and review results—without impacting actual users.

The primary goal of the What-if tool is to help you identify and resolve misconfigurations and prevent accidental workflow executions before processing begins.

> [!NOTE]
> The What-if tool is currently in private preview. Workflows with change-based trigger types (attribute changes or group membership changes) aren't currently supported.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

You must also have the [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) or Global Administrator role.

## Access the What-if tool

To access the What-if tool for a workflow:

1. Sign in to the [Microsoft Entra admin center](https://aka.ms/LCWWhatifPreview) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow you want to evaluate.

   > [!NOTE]
   > Workflows with attribute changes or group membership changes trigger types aren't currently supported by the What-if tool.

1. On the workflow overview page, select **What if** from the command bar.

   > [!NOTE]
   > If the **What if** button isn't visible, confirm that you signed in using the preview URL: `https://aka.ms/LCWWhatifPreview`.

## Review users in scope

After opening the What-if tool, select the **Users in Scope** tab to see the list of users that would be included in the current execution scope for the selected workflow. This list reflects the users who meet the workflow's execution conditions at the time the tool is run.

You can also review the tasks listed on the What-if page to see which workflow tasks might fail based on the current configuration.

## Run a workflow execution simulation

To simulate workflow execution and preview results for specific users:

1. On the What-if page, select the **Users in Scope** tab.

1. Select up to 10 users from the list.

   > [!NOTE]
   > The **Simulate Workflow Execution** button is disabled if more than 10 users are selected.

1. Select **Simulate Workflow Execution** from the command bar.

1. The simulation starts automatically. Results appear on the **Execution Simulation Results** tab once they're available.

   > [!NOTE]
   > Depending on the workflow tasks, results might take a few seconds up to a couple of minutes to appear. If no results appear after a brief period, select **Refresh** to check for updated results. The **Execution Simulation Results** tab appears only after you run a simulation for the first time. Results are cleared when you run another simulation.

## Next steps

- [Run a workflow on-demand](on-demand-workflow.md)
- [Check execution user scope of a workflow](check-workflow-execution-scope.md)
- [Check the status of a workflow](check-status-workflow.md)

---
title: Simulate workflow execution using the What-if tool (Preview)
description: Learn how to use the What-if tool in Lifecycle Workflows to simulate workflow execution and preview results without impacting actual users.
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 03/12/2026
ms.custom: template-how-to
ai-usage: ai-assisted
#CustomerIntent: As an IT admin, I want to simulate workflow execution using the What-if tool so that I can preview results without impacting actual users.
---

# Simulate workflow execution using the What-if tool (Preview)

The What-if tool in Lifecycle Workflows lets you evaluate workflow execution before it runs for your users. Using the What-if tool, you can:

- View which users are currently in the execution scope of a workflow.
- Preview which workflow tasks might fail based on the current configuration.
- Simulate workflow execution for up to 10 users and review results without impacting actual users.

The primary goal of the What-if tool is to help you identify and resolve misconfigurations and prevent accidental workflow executions before processing begins.

> [!NOTE]
> The What-if tool is currently in public preview. Workflows with change-based trigger types, such as attribute changes and group membership changes, aren't currently supported.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

## Access the What-if tool

To access the What-if tool for a workflow:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow you want to evaluate.

   > [!NOTE]
   > Workflows that use attribute changes or group membership changes as trigger types aren't currently supported by the What-if tool.

1. On the workflow overview page, select **What if** from the command bar.
    :::image type="content" source="media/simulate-workflow-execution/what-if-tool.png" alt-text="Screenshot of the What if tool on a workflow overview page.":::

### Review users in scope

Within the What-if tool, select the **Users in Scope** tab to see the list of users that would be included in the current execution scope for the selected workflow. This list reflects the users who meet the workflow's execution conditions at the time the tool is run.

### Review potential task failures

Within the What-if tool, you can also review the tasks listed on the What-if page to see which workflow tasks might fail based on the current configuration.
:::image type="content" source="media/simulate-workflow-execution/potential-task-failures.png" alt-text="Screenshot of potential task failures within the what if tool.":::

## Run a workflow execution simulation

To simulate workflow execution and preview results for specific users:

1. On the What-if page, select the **Users in Scope** tab.

1. Select up to 10 users from the list.

   > [!NOTE]
   > The **Simulate Workflow Execution** button is disabled if more than 10 users are selected.

1. Select **Simulate Workflow Execution** from the command bar.

1. The simulation starts automatically. Results appear on the **Execution Simulation Results** tab once they're available.
    :::image type="content" source="media/simulate-workflow-execution/execution-simulation-results.png" alt-text="Screenshot of the execution simulation results.":::
   > [!NOTE]
   > Depending on the workflow tasks, results might take a few seconds up to a couple of minutes to appear. If no results appear after a brief period, select **Refresh** to check for updated results. The **Execution Simulation Results** tab appears only after you run a simulation for the first time. Results are cleared when you run another simulation.

## Next steps

- [Run a workflow on-demand](on-demand-workflow.md)
- [Check execution user scope of a workflow](check-workflow-execution-scope.md)
- [Check the status of a workflow](check-status-workflow.md)

---
title: Lifecycle workflow Insights (preview)
description: Conceptual article about Lifecycle Workflows reporting and history capabilities.
author: owinfreyATL
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 05/02/2024
ms.author: owinfrey
ms.reviewer: krbain

#CustomerIntent: As a system administrator, I want to learn what workflow insights can view across my environment so that I know which workflows, or tasks, are being used the most.
---

# Workflow Insights (preview)

With the previous views, you're able to find history of specific workflows. If you want to view workflow history information across all workflows in your tenant, you use **Workflow Insights (preview)**. 

:::image type="content" source="media/lifecycle-workflow-insights/workflow-insights-view.png" alt-text="Screenshot of the Workflow Insights page.":::

With Workflow Insights, you're also able to view aggregate workflow information across your tenant. Workflow Insights allows you to quickly view the following information:

- Summary
- Top Workflows
- Top Tasks
- Workflow by Category

More details about insights found in these sections are discussed in the following sections of this article. For a step by step guide on checking the insights for workflows in your tenant, see: [Check Workflow Insights (preview)](lifecycle-workflow-insights.md).


### Workflow Insights summary

The Workflow Insights summary provides a numerical view of successful workflows, users, and tasks processed within a tenant.

:::image type="content" source="media/lifecycle-workflow-insights/workflow-insights-summary.png" alt-text="Screenshot of a workflow insights summary.":::

This summary can be filtered to show information from either the past, 7, 14, or 30 days.

### Top Workflow Insights summary

The Top Workflows Insights summary lists the top workflows ran in the tenant for a timespan that can be 7, 14, or 30 days. The top workflows can also be filtered in order by total processed, successful runs, or failed runs.

:::image type="content" source="media/lifecycle-workflow-insights/workflow-insights-workflows.png" alt-text="Screenshot of top workflows processed insight summary.":::

When you view the top workflow insights summary, the following information is shown:


|Detail  |Information  |
|---------|---------|
|Workflow     | The name of the workflow.        |
|Total Processed     |  The total runs of the workflow.       |
|Successful     |  The successful runs for the workflow       |
|Failed     |   The failed runs for the workflow      |
|Category     | The workflow's category.        |
|Total Users     |  The total number of users processed by the workflow.       |
|Successful Users     |  The number of successful users processed by the workflow.       |
|Failed Users     |  The number of failed users processed by the workflow.       |


### Top Tasks Insights summary

The Top Tasks Insights summary lists the top tasks ran in the tenant for a timespan that can be 7, 14, or 30 days. The top tasks can also be filtered in order by total processed, successful runs, or failed runs.

:::image type="content" source="media/lifecycle-workflow-insights/workflow-insights-tasks.png" alt-text="Screenshot of workflow insights top tasks summary.":::

When you view the top tasks insights summary, the following information is shown:


|Detail  |Information  |
|---------|---------|
|Task     | The name of the task.        |
|Total Processed     |  The total runs of the task.       |
|Successful     |  The successful runs for the task       |
|Failed     |   The failed runs for the task.      |
|Total Users     |  The total number of users processed by the task.       |
|Successful Users     |  The number of successful users processed by the task.       |
|Failed Users     |  The number of failed users processed by the task.       |

### Workflow Category Insights summary

The Workflow Category Insights summary lists the top workflows run by category using a percentage for a timespan that can be 7, 14, or 30 days.

:::image type="content" source="media/lifecycle-workflow-insights/workflow-insights-category.png" alt-text="Screenshot of a workflow insights by category summary.":::


## Next steps

- [Lifecycle Workflow history](lifecycle-workflow-history.md)

---
title: Check Workflow Insights
description: Learn how to check workflow insights within your Microsoft Entra tenant.
author: owinfreyATL
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 08/12/2024
ms.author: owinfrey
ms.reviewer: krbain

#CustomerIntent: As a system administrator, I want to view insights across my environment so that I know which workflows, or tasks, are being used the most.
---

# Check Workflow Insights

With Workflow Insights, you're able to get a quick view of workflow execution within your environment. With Workflow Insights, you can view information such as:

- Numerical summaries of all successful workflows, users processed, and successful tasks that ran in your environment.
- The top workflows of the past time-span that you define from either 7, 14, or 30 days.
- The top tasks of the past time-span that you define from either 7, 14, or 30 days.
- Number of workflows by categories of the past time-span that you define from either 7, 14, or 30 days.


For more information, see: [Workflow Insights](lifecycle-workflow-insights.md).

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]


## Check Workflow Insights using the Microsoft Entra admin center


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](~/identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Overview**. 

1. On the overview page, select **Workflow Insights**.

1. On the Workflow Insights page, you're able to view workflow information across your environment.

1. When you find the information you want to look further into, you can select the **filter** option and choose which time frame you want to view information from.

1. Along with being able to filter on a time period, for top workflows and tasks, you're also able to filter based on activity.

   :::image type="content" source="media/manage-workflow-insights/timespan-choice.png" alt-text="Screenshot of picking time duration in workflow insights.":::

1. With the activity filter, you can choose to see the top processed workflows or tasks by choosing **Total Processed**, only those which were **Successful**, or only the ones who **Failed**.

1. Under **Workflow Runs by Category** you're able to filter workflows by category. You can filter to see percentage  of workflows **Total Processed**, **Successful** workflow by category, or **Failed** workflow by category.

   :::image type="content" source="media/manage-workflow-insights/workflow-filter-category.png" alt-text="Screenshot of workflows by category insights.":::

## Next step

> [!div class="nextstepaction"]
> [Manage workflow versions](manage-workflow-tasks.md)


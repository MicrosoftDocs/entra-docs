---
title: Automate employee offboarding tasks after their last day of work with the Microsoft Entra admin center
description: Tutorial for post off-boarding users from an organization using Lifecycle workflows with the Microsoft Entra admin center.
author: owinfreyATL
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: tutorial
ms.date: 11/25/2024
ms.author: owinfrey
ms.reviewer: krbain
ms.custom: template-tutorial, sfi-image-nochange
---
# Automate employee offboarding tasks after their last day of work with the Microsoft Entra admin center

This tutorial provides a step-by-step guide on how to configure off-boarding tasks for employees after their last day of work with Lifecycle workflows using the Microsoft Entra admin center.

This post off-boarding scenario runs a scheduled workflow and accomplishes the following tasks:
 
1. Remove all licenses for user
2. Remove user from all Teams
3. Delete user account

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]


##  Before you begin

To complete this tutorial, you must satisfy the prerequisites listed in this section before starting the tutorial as they aren't included in the actual tutorial. As part of the prerequisites for completing this tutorial, you need an account that has licenses and Teams memberships that can be deleted during the tutorial. For more comprehensive instructions on how to complete these prerequisite steps, you can refer to the [Preparing user accounts for Lifecycle workflows tutorial](tutorial-prepare-user-accounts.md).

The scheduled leaver scenario can be broken down into the following sections:
-	**Prerequisite:** Create a user account that represents an employee leaving your organization
-	**Prerequisite:** Prepare the user account with licenses and Teams memberships
- Create the lifecycle management workflow
-	Run the scheduled workflow after last day of work
-	Verify that the workflow was successfully executed

## Create a workflow using scheduled leaver template

Use the following steps to create a scheduled leaver workflow that will automatically perform off-boarding tasks for employees after their last day of work with Lifecycle workflows using the Microsoft Entra admin center.

 1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).
 2. Select **ID Governance**.
 3. Select **Lifecycle workflows**.
 4. On the **Overview** page, select **New workflow**. 
    :::image type="content" source="media/tutorial-lifecycle-workflows/new-workflow.png" alt-text="Screenshot of selecting a new workflow." lightbox="media/tutorial-lifecycle-workflows/new-workflow.png":::

 5. From the templates, select **Select** under **Post-offboarding of an employee**.
   :::image type="content" source="media/tutorial-lifecycle-workflows/select-leaver-template.png" alt-text="Screenshot of selecting a leaver workflow." lightbox="media/tutorial-lifecycle-workflows/select-leaver-template.png":::

 6. Next, you configure the basic information about the workflow. This information includes when the workflow triggers, known as **Days from event**.  So in this case, the workflow will trigger seven days after the employee's leave date. On the post-offboarding of an employee screen, add the following settings and then select **Next: Configure Scope**. 
   :::image type="content" source="media/tutorial-lifecycle-workflows/leaver-basics.png" alt-text="Screenshot of leaver template basics information for a workflow." lightbox="media/tutorial-lifecycle-workflows/leaver-basics.png":::
 
 7. Next, you configure the scope. The scope determines which users this workflow runs against. In this case, it is on all users in the Marketing department. On the configure scope screen, under **Rule** add the following, and then select **Next: Review tasks**. For a full list of supported user properties, see [Supported user properties and query parameters](/graph/api/resources/identitygovernance-rulebasedsubjectset?view=graph-rest-beta&preserve-view=true#supported-user-properties-and-query-parameters)
   :::image type="content" source="media/tutorial-lifecycle-workflows/leaver-scope.png" alt-text="Screenshot of reviewing scope details for a leaver workflow." lightbox="media/tutorial-lifecycle-workflows/leaver-scope.png":::

 8. On the following page, you can inspect the tasks if desired but no additional configuration is needed. Select **Next: Select users** when you're finished.
   :::image type="content" source="media/tutorial-lifecycle-workflows/review-leaver-tasks.png" alt-text="Screenshot of leaver workflow tasks." lightbox="media/tutorial-lifecycle-workflows/review-leaver-tasks.png":::

9. On the review screen, verify the information is correct and select **Create**.
   :::image type="content" source="media/tutorial-lifecycle-workflows/create-leaver-workflow.png" alt-text="Screenshot of a leaver workflow being created." lightbox="media/tutorial-lifecycle-workflows/create-leaver-workflow.png":::

>[!NOTE]
> Select **Create** with the **Enable schedule** box unchecked to run the workflow on-demand. You may enable this setting later after checking the tasks and workflow status. 

## Run the workflow 
Now that the workflow is created, it automatically runs every 3 hours. This means lifecycle workflows check every 3 hours for users in the associated execution condition, and executes the configured tasks for those users.  However, for the tutorial, we would like to run it immediately. To run a workflow immediately, we can use the on-demand feature.

>[!NOTE]
>Be aware that you currently cannot run a workflow on-demand if it is set to disabled.  You need to set the workflow to enabled to use the on-demand feature.

To run a workflow on-demand, for users using the Microsoft Entra admin center, do the following steps:

1. On the workflow screen, select the specific workflow you want to run.
1. Select **Run on demand**.
1. On the **select users** tab, select **add users**.
1. Add a user.
1. Select **Run workflow**.

## Check tasks and workflow status

At any time, you can monitor the status of the workflows and the tasks. As a reminder, there are three different data pivots, users runs, and tasks that are currently available. You can learn more in the how-to guide [Check the status of a workflow](check-status-workflow.md). In the course of this section, we look at the status using the user focused reports.

1. To begin, select the **Workflow history** tab to view the user summary and associated workflow tasks and statuses.
    :::image type="content" source="media/tutorial-lifecycle-workflows/workflow-history-post-offboard.png" alt-text="Screenshot of the workflow history summary." lightbox="media/tutorial-lifecycle-workflows/workflow-history-post-offboard.png":::

1. Once the **Workflow history** tab is selected, you land on the workflow history page as shown:
    :::image type="content" source="media/tutorial-lifecycle-workflows/user-summary-post-offboard.png" alt-text="Screenshot of the workflow history overview." lightbox="media/tutorial-lifecycle-workflows/user-summary-post-offboard.png":::

1. Next, you can select **Total tasks** for the user Jane Smith to view the total number of tasks created and their statuses. In this example, there are three total tasks assigned to the user Jane Smith.  
    :::image type="content" source="media/tutorial-lifecycle-workflows/total-tasks-post-offboard.png" alt-text="Screenshot of workflow's total tasks." lightbox="media/tutorial-lifecycle-workflows/total-tasks-post-offboard.png":::

1. To add an extra layer of granularity, you can select **Failed tasks** for the user Wade Warren to view the total number of failed tasks assigned to the user Wade Warren.
    :::image type="content" source="media/tutorial-lifecycle-workflows/failed-tasks-post-offboard.png" alt-text="Screenshot of workflow failed tasks." lightbox="media/tutorial-lifecycle-workflows/failed-tasks-post-offboard.png":::

1. Similarly, you can select **Unprocessed tasks** for the user Wade Warren to view the total number of unprocessed or canceled tasks assigned to the user Wade Warren.
    :::image type="content" source="media/tutorial-lifecycle-workflows/canceled-tasks-post-offboard.png" alt-text="Screenshot of workflow unprocessed tasks." lightbox="media/tutorial-lifecycle-workflows/canceled-tasks-post-offboard.png":::

## Enable the workflow schedule

After running your workflow on-demand and checking that everything is working fine, you might want to enable the workflow schedule. To enable the workflow schedule, you select the **Enable Schedule** checkbox on the Properties page.

  :::image type="content" source="media/tutorial-lifecycle-workflows/enable-schedule.png" alt-text="Screenshot of workflow enabled schedule." lightbox="media/tutorial-lifecycle-workflows/enable-schedule.png":::

## Next steps
- [Preparing user accounts for Lifecycle workflows](tutorial-prepare-user-accounts.md)
- [Automate employee offboarding tasks after their last day of work using Lifecycle Workflows APIs](/graph/tutorial-lifecycle-workflows-scheduled-leaver)

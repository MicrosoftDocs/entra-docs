---
title: 'Automate employee mover tasks when they change jobs using the Microsoft Entra admin center'
description: Tutorial for moving users that change jobs using Lifecycle workflows with the Microsoft Entra admin center.
author: owinfreyATL
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: tutorial
ms.date: 03/22/2024
ms.author: owinfrey
ms.reviewer: krbain
ms.custom: template-tutorial

#CustomerIntent: As an administrator, I want to automate group and team memberships when an employee changes jobs so that their access to resources are always valid for them .
---

# Automate employee mover tasks when they change jobs using the Microsoft Entra admin center

This tutorial provides a step-by-step guide on how to configure mover tasks for employees when they change jobs with Lifecycle workflows using the Microsoft Entra admin center.

This Mover scenario runs a scheduled workflow and accomplishes the following tasks:
 
1. Send email to notify manager of user move
1. Remove user from selected groups
1. Remove user from selected Teams
1. Request user access package assignment

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

##  Before you begin

Two accounts are required for this tutorial, one account for the user with a job profile change and another account that acts as it's manager. The user account must have the following attributes set:

- Group must be set to sales
- Manager attribute must be set, and the manager account should have a mailbox to receive an email


Detailed breakdown of the relevant attributes:

 | Attribute | Description |Set on|
 |:--- |:---:|-----|
 |mail|Used to notify manager of the new employees temporary access pass|Both|
 |manager|This attribute that is used by the lifecycle workflow|Employee|
 |Group|Used to provide the scope for the workflow|Employee|

The mover scenario can be broken down into the following steps:
  - **Prerequisite:** Create two user accounts, one to represent an employee and one to represent a manager
  - **Prerequisite:** Edit the attributes required for this scenario in the admin center
  - **Prerequisite:** Edit the attributes for this scenario using Microsoft Graph Explorer
  - Create the  workflow
  - Trigger the workflow
  - Verify the workflow was successfully executed


## Create a workflow using the mover template

Use the following steps to create a mover workflow for a user making a job change that is triggered by a group change.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **Identity governance** > **Lifecycle workflows** > **Create workflow**.

1. From the templates, select **select** under **Employee job profile change**.
    :::image type="content" source="media/tutorial-mover-custom-workflow-portal/job-change-template.png" alt-text="Screenshot of selecting the employee job profile change template.":::
1. Next, you configure the basic information about the workflow.  This information includes a name and description. You're also able to choose the **Trigger type** of the workflow, which in this case is the **Group membership change (Preview)** trigger. For **Action** you're given what interaction with the group change triggers the workflow, which in this case is **Removed from group**. After your trigger is set, select **Configure scope**.
    :::image type="content" source="media/tutorial-mover-custom-workflow-portal/job-change-template-basics.png" alt-text="Screenshot of setting group membership trigger in template.":::
1. On the **Configure scope** screen, in the scope details section select **+Add group**. From the groups screen, search for **Sales**, and select the group. When the group is added, select **Review tasks**.
    :::image type="content" source="media/tutorial-mover-custom-workflow-portal/group-scope.png" alt-text="Screenshot of setting group scope.":::
1. On the **Review tasks** screen, you're able to add, edit, or remove tasks. From the default tasks, **Remove user from selected groups**, **Remove user from Selected Teams**, and **Request user access package assignment** require that you select which groups or teams you want the user to be removed from, or which user access package assignment you want to request for the user. When you're finished editing the tasks, select **Review + create**. 
    :::image type="content" source="media/tutorial-mover-custom-workflow-portal/job-change-template-tasks.png" alt-text="Screenshot of job change template tasks.":::

1. On the review screen, verify the information is correct and choose if you want to enable the schedule of the workflow or not. After reviewing,  select **Create**.
    :::image type="content" source="media/tutorial-mover-custom-workflow-portal/job-change-template-review.png" alt-text="Screenshot of reviewing job change template.":::

 ## Run the workflow 
Now that the workflow is created, if you turned on the workflow schedule it will automatically run the workflow every 3 hours. Lifecycle workflows check every 3 hours for users in the associated execution condition, and executes the configured tasks for those users.  However, for the tutorial, we would like to run it immediately. To run a workflow immediately, we can use the on-demand feature.

>[!NOTE]
>Be aware that you currently cannot run a workflow on-demand if it is set to disabled.  You need to set the workflow to enabled to use the on-demand feature.

To run a workflow on-demand, for users using the Microsoft Entra admin center, do the following steps:

 1. On the workflow screen, select the specific workflow you want to run.
 
 1. Select **Run on demand**.
 
 1. On the **select users** tab, select **add users**.

 1. Add a user.
 
 1. Select **Run workflow**.


## Check tasks and workflow status

At any time, you can monitor the status of the workflow, and the tasks. As a reminder, there are three different data pivots: users runs, and tasks that are currently available. You can learn more in the how-to guide [Check the status of a workflow](check-status-workflow.md). In the course of this tutorial, we look at the status using the user focused reports.

1. To begin, select the **Workflow history** tab to view the user summary and associated workflow tasks and statuses. 

1. Once the **Workflow history** tab has been selected, you're presented with the workflow history page.
    :::image type="content" source="media/tutorial-mover-custom-workflow-portal/job-change-history-page.png" alt-text="Screenshot of the workflow history page.":::
1. On this page, you're able to see a general summary, based on users, of total processed, successfully processed, failed to process, successful tasks, and failed tasks.

1. From the list of users processed you can also select a user, see which tasks ran for them, and if they ran successfully. If the task failed, you can see the reason.
    :::image type="content" source="media/tutorial-mover-custom-workflow-portal/job-change-task-status.png" alt-text="Screenshot of task status for a user.":::

## Next steps

- [Tutorial: Preparing user accounts for Lifecycle workflows](tutorial-prepare-user-accounts.md)
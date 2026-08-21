---
title: Create a lifecycle workflow - Microsoft Entra ID
description: This article guides you in creating a lifecycle workflow.
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 08/21/2026
ms.custom: template-how-to
#Customer Intent: As an IT admin, I want to create a lifecycle workflow so that I can automate identity lifecycle processes in my organization.
---

# Create a lifecycle workflow

Lifecycle workflows allow for tasks associated with the lifecycle process to be run automatically for users as they move through their lifecycle in your organization. Workflows consist of:

- **Tasks**: Actions taken when a workflow is triggered.
- **Execution conditions**: The who and when of a workflow. These conditions define which users this workflow should run against, and when (trigger) the workflow should run.

In the Microsoft Entra admin center, you can create and customize workflows for common scenarios by using built-in templates or by cloning an existing workflow. To build a workflow from scratch without using a template or an existing workflow, use Microsoft Graph.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

## Configure a relative time-based trigger in the Microsoft Entra admin center

> [!IMPORTANT]
> Relative time-based triggers are in public preview. For more information about previews, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

To configure a relative time-based trigger for a new or existing workflow:

1. Sign in to the [Microsoft Entra admin center](https://aka.ms/LCWRelativeTimeBasedTrigger) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Select **Create workflow**, or open an existing workflow.

1. Under **Trigger details**, select **Time based attribute V2 (Preview)** as the trigger type.

1. In the trigger timing section, configure the following values:

    - **Operator**: Select **Exactly**, **Between**, or **Less than or equal to**.
    - **Days from event**: Enter the offset in days, from 0 through 180. When you select **Between**, also enter the end of the range in **Days to event**.
    - **Event timing**: Select **Before** or **After** the attribute date. To match the existing time-based trigger on the attribute date, select **Exactly** and enter 0 days. Then select **On**, which is available for this configuration.
    - **Event attribute**: Select the user attribute that the trigger evaluates. Supported attributes include `employeeHireDate`, `employeeLeaveDateTime`, and `createdDateTime`.

1. Select **Next: Configure scope**, and define which users the workflow applies to.

1. Select **Next: Review tasks**, and adjust the tasks for your scenario if needed.

1. Select **Next: Review + create**.

1. To start testing the workflow after creation, select **Enable schedule**.

    > [!NOTE]
    > The workflow and its schedule must both be enabled for time-based triggers to be evaluated.

1. Select **Create**.

## Create a lifecycle workflow by cloning an existing workflow in the Microsoft Entra admin center

You can use an existing workflow as the starting point for a new workflow. The clone option is available only in the Microsoft Entra admin center.

To start cloning from the workflow list:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow that you want to clone, and then select **Clone**.

    :::image type="content" source="media/create-lifecycle-workflow/clone-workflow-list.png" alt-text="Screenshot of a selected workflow and the Clone option on the Lifecycle workflows page." lightbox="media/create-lifecycle-workflow/clone-workflow-list.png":::

You can also start cloning from the workflow creation experience:

1. Browse to **ID Governance** > **Lifecycle workflows** > **Create workflow**.

1. On the **Choose a workflow** page, find the **Clone an existing workflow** card, and then select **Browse workflows**.

    :::image type="content" source="media/create-lifecycle-workflow/clone-workflow-template-card.png" alt-text="Screenshot of the Clone an existing workflow card on the Choose a workflow page." lightbox="media/create-lifecycle-workflow/clone-workflow-template-card.png":::

1. Select the workflow that you want to clone.

After you select a workflow to clone, the **Review + create** tab opens directly. Review the workflow settings, and then select **Create** to create the workflow without making changes.

To customize the workflow before you create it, select the other tabs and update the workflow details or configuration. When you're finished, return to the **Review + create** tab and select **Create**.

## Create a lifecycle workflow by using a template in the Microsoft Entra admin center


If you're using the Microsoft Entra admin center to create a workflow, you can customize existing templates to meet your organization's needs. These templates include one for common pre-hire scenarios.

To create a workflow based on a template:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Create a workflow**.

1. On the **Choose a workflow** page, select the workflow template that you want to use.

    :::image type="content" source="media/create-lifecycle-workflow/templates-list.png" alt-text="Screenshot of a list of lifecycle workflow templates." lightbox="media/create-lifecycle-workflow/templates-list.png":::
1. On the **Basics** tab, enter a unique display name, description, and [administrative scope](manage-delegate-workflow.md) for the workflow, and then select **Next**.

    :::image type="content" source="media/create-lifecycle-workflow/template-basics.png" alt-text="Screenshot of basic information about a workflow template.":::

1. On the **Configure scope** tab, select the trigger type and execution conditions to be used for this workflow. For more information on what you can configure, see [Execution conditions](understanding-lifecycle-workflows.md#execution-conditions).

1. Under **Rule**, enter values for **Property**, **Operator**, and **Value**. The following screenshot gives an example of a rule being set up for a sales department. For a full list of user properties that lifecycle workflows support, see [Supported user properties and query parameters](/graph/api/resources/identitygovernance-rulebasedsubjectset?view=graph-rest-beta&preserve-view=true#supported-user-properties-and-query-parameters).

    :::image type="content" source="media/create-lifecycle-workflow/template-scope.png" alt-text="Screenshot of scope configuration options for a lifecycle workflow template.":::

1. To view your rule syntax, select the **View rule syntax** button. You can copy and paste multiple user property rules on the panel that appears. For more information on which properties you can include, see [User properties](/graph/aad-advanced-queries?tabs=http#user-properties). When you finish adding rules, select **Next**.

    :::image type="content" source="media/create-lifecycle-workflow/template-syntax.png" alt-text="Screenshot of workflow rule syntax.":::

1. On the **Review tasks** tab, you can add a task to the template by selecting **Add task**. To enable an existing task on the list, select **Enable**. To disable a task, select **Disable**. To remove a task from the template, select **Remove**.

    When you're finished with tasks for your workflow, select **Next: Review and create**.

    :::image type="content" source="media/create-lifecycle-workflow/template-tasks.png" alt-text="Screenshot of adding tasks to templates.":::

1. On the **Review and create** tab, review the workflow's settings. You can also choose whether or not to enable the schedule for the workflow. Select **Create** to create the workflow.

    :::image type="content" source="media/create-lifecycle-workflow/template-review.png" alt-text="Screenshot of reviewing and creating a workflow.":::

> [!IMPORTANT]
> By default, a newly created workflow is disabled to allow for the testing of it first on smaller audiences. For more information about testing workflows before rolling them out to many users, see [Run an on-demand workflow](on-demand-workflow.md).

## Create a lifecycle workflow by using Microsoft Graph

To create a lifecycle workflow by using the Microsoft Graph API, see [Create workflow](/graph/api/identitygovernance-lifecycleworkflowscontainer-post-workflows).

## Next steps

- [Manage a workflow's properties](manage-workflow-properties.md)
- [Manage workflow versions](manage-workflow-tasks.md)

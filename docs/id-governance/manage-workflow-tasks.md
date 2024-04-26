---
title: Manage workflow versions
description: This article guides a user on managing workflow versions with Lifecycle Workflows.
author: OWinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 04/26/2024
ms.custom: template-how-to
---

# Manage workflow versions

Workflows created with Lifecycle Workflows are able to grow and change with the needs of your organization. Workflows exist as versions from creation. When making changes to other than basic information, you create a new version of the workflow. For more information, see  [Manage a workflow's properties](manage-workflow-properties.md).

Changing a workflow's tasks or execution conditions requires the creation of a new version of that workflow. Tasks within workflows can be added, reordered, and removed at will. Updating a workflow's tasks or execution conditions within the Microsoft Entra admin center triggers the creation of a new version of the workflow automatically. Making these updates in Microsoft Graph requires the new workflow version to be created manually.


## Edit the tasks of a workflow using the Microsoft Entra admin center

Tasks within workflows can be added, edited, reordered, and removed at will. To edit the tasks of a workflow using the Microsoft Entra admin center, you complete the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **Identity governance** > **Lifecycle workflows** > **workflows**.
    
1. Select the workflow that you want to edit the tasks of and on the left side of the screen, select **Tasks**.

1. You can add a task to the workflow by selecting the **Add task** button.

    :::image type="content" source="media/manage-workflow-tasks/manage-tasks.png" alt-text="Screenshot of adding a task to a workflow." lightbox="media/manage-workflow-tasks/manage-tasks.png":::

1. You can enable and disable tasks as needed by using the **Enable** and **Disable** buttons.

1. You can reorder the order in which tasks are executed in the workflow by selecting the **Reorder** button. You can also remove a task from a workflow by using the **Remove** button. 

    :::image type="content" source="media/manage-workflow-tasks/manage-tasks-reorder.png" alt-text="Screenshot of reordering tasks in a workflow.":::
      
1. After making changes, select **save** to capture changes to the tasks.


## Edit the execution conditions of a workflow using the Microsoft Entra admin center

To edit the execution conditions of a workflow using the Microsoft Entra admin center, you do the following steps:


1. On the left menu of Lifecycle Workflows, select **Workflows**.

1. On the left side of the screen, select **Execution conditions**.
    :::image type="content" source="media/manage-workflow-tasks/execution-conditions-details.png" alt-text="Screenshot of the execution condition details of a workflow." lightbox="media/manage-workflow-tasks/execution-conditions-details.png":::

1. On this screen, you're presented with **Trigger details**. Here we have a trigger type and attribute details. In the template you can edit the attribute details to define when a workflow runs.
    

1. Select the **Scope details** tab.
    :::image type="content" source="media/manage-workflow-tasks/execution-conditions-scope.png" alt-text="Screenshot of the execution scope page of a workflow." lightbox="media/manage-workflow-tasks/execution-conditions-scope.png":::

1. On this screen you can define rules for who the workflow runs. if the trigger **Scope type** is set as Rule-Based you  can define the rule using expressions on user properties. For more information on supported user properties. see: [supported queries on user properties](/graph/aad-advanced-queries#user-properties). If the trigger scope type is group-based, you're able to select which group is the scope of the workflow.

1. After making changes, select **save** to capture changes to the execution conditions.


## See versions of a workflow using the Microsoft Entra admin center

1. On the left menu of Lifecycle Workflows, select **Workflows**.

1. On this page, you see a list of all of your current workflows. Select the workflow that you want to see versions of.
 
1. On the left side of the screen, select **Versions**.

    :::image type="content" source="media/manage-workflow-tasks/manage-versions.png" alt-text="Screenshot of versions of a workflow." lightbox="media/manage-workflow-tasks/manage-versions.png":::

1. On this page, you see a list of the workflow versions.    

    :::image type="content" source="media/manage-workflow-tasks/manage-versions-list.png" alt-text="Screenshot of managing version list of lifecycle workflows." lightbox="media/manage-workflow-tasks/manage-versions-list.png":::


## Create a new version of an existing workflow using Microsoft Graph

To create a new version of a workflow via API using Microsoft Graph, see: [workflow: createNewVersion](/graph/api/identitygovernance-workflow-createnewversion)
    

### List workflow versions using Microsoft Graph

To list workflow versions via API using Microsoft Graph, see: [List versions (of a lifecycle workflow)](/graph/api/identitygovernance-workflow-list-versions)
 


## Next steps

- [Check status of a workflows](check-status-workflow.md)
- [Customize workflow schedule](customize-workflow-schedule.md)

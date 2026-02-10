---
title: Sensitivity Labels in Lifecycle Workflows
description: This article describes sensitivity labels in Workflows, and how to see them during the task creation process.
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/04/2025

#CustomerIntent: As an identity governance administrator, I want to view sensitivity labels of groups or teams so that I can maintain security within my environment.
---

# Sensitivity labels in Lifecycle Workflows

Maintaining and classifying data within your environment is an important part in maintaining a secure environment. Sensitivity labels from Microsoft Purview Information Protection let you classify and protect your organization's data, while making sure that user productivity and their ability to collaborate isn't hindered. With sensitivity labels in Lifecycle Workflows, administrators are able to quickly view the sensitivity labels of groups and teams during workflow creation, and editing. 

The following tasks support viewing sensitivity labels:

- [Add user to groups](lifecycle-workflow-tasks.md#add-user-to-groups)
- [Add user to teams](lifecycle-workflow-tasks.md#add-user-to-teams)
- [Remove user from selected groups](lifecycle-workflow-tasks.md#remove-user-from-selected-groups)
- [Remove user from selected teams](lifecycle-workflow-tasks.md#remove-user-from-selected-teams)

## License requirements

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

## Prerequisites

Along with Microsoft Entra licenses required for Lifecycle workflows, you must also have:

- [A created sensitivity label](/purview/create-sensitivity-labels?tabs=classic-label-scheme#create-and-configure-sensitivity-labels)
- [A sensitivity label applied to the group or team you want to use with a Lifecycle workflow](/purview/sensitivity-labels-teams-groups-sites#using-sensitivity-labels-for-microsoft-teams-microsoft-365-groups-and-sharepoint-sites)

## View assigned sensitivity labels during workflow creation

To view the sensitivity labels of groups and teams using Lifecycle workflows during workflow creation, do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Create a workflow**.

1. On the **Choose a workflow** page, select the workflow template that you want to use.

1. Add Basic information, Trigger type, and scope details for the workflow.

1. On the tasks page, add the task you want to use to view sensitivity labels with. Task availability is based on which template you selected to create your workflow. For more information on workflow templates, see: [Lifecycle Workflows templates and categories](lifecycle-workflow-templates.md).

1.  After adding the group-related tasks to the workflow select the task, and then select **select groups**.
    :::image type="content" source="media/workflow-sensitivity-labels/select-groups-workflow.png" alt-text="Screenshot of selecting group in workflows.":::
1. On the list pane, you're able to see a list of groups or teams that can be selected, and their sensitivity labels.
    :::image type="content" source="media/workflow-sensitivity-labels/add-group-sensitivity-label.png" alt-text="Screenshot of adding groups to workflow along with their sensitivity labels.":::
1. After adding the group or team to the task select **Next** to move to the review screen, and **Create** to create the workflow.

## View assigned sensitivity labels on existing workflow tasks

Sensitivity labels of groups and teams used within existing tasks of a workflow can be viewed by doing the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. Select the workflow that has the task that you want to view.

1. On the workflow overview screen, select **Tasks**.

1. On the tasks screen, select the specific task related to sensitivity you want to view.

1. On the task overview screen, select the group or teams selection option.

1. On the list screen, you're able to see the group currently assigned to the task, a list of groups or teams that can be added to the task, and also their sensitivity labels.
    :::image type="content" source="media/workflow-sensitivity-labels/sensitivity-label-existing-workflow.png" alt-text="Screenshot of teams and sensitivity labels within a task for an existing workflow.":::


## Related content

- [Lifecycle Workflow built-in tasks](lifecycle-workflow-tasks.md)


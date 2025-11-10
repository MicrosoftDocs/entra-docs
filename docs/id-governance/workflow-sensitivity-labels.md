---
title: Sensitivity Labels in Lifecycle Workflows
description: This article describes sensitivity labels in Workflows, and how to see them during the task creation process.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/04/2025

#CustomerIntent: As an identity governance administrator, I want to view sensitivity labels of groups so that I can maintain security of groups within my environment.
---

# Sensitivity labels in Lifecycle Workflows

Maintaining and classifying secure data within your environment is an important part in maintaining a secure environment. Sensitivity labels from Microsoft Purview Information Protection let you classify and protect your organization's data, while making sure that user productivity and their ability to collaborate isn't hindered. With sensitivity labels in Lifecycle Workflows, administrators are able to quickly view the sensitivity labels of groups during creation, and editing, of workflow tasks. 

## License requirements

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

## Prerequisites

Along with Microsoft Entra licenses required for Lifecycle workflows, you must also have:

- [A created sensitivity label](/purview/create-sensitivity-labels?tabs=classic-label-scheme#create-and-configure-sensitivity-labels)
- [A sensitivity applied to the group you want to use within a Lifecycle workflow task](/purview/sensitivity-labels-teams-groups-sites#using-sensitivity-labels-for-microsoft-teams-microsoft-365-groups-and-sharepoint-sites)

## View the sensitivity label of a group used in a workflow task

Sensitivity labels of groups can be viewed when using groups as a scope for workflows, and via specific group workflow tasks. To view the sensitivity labels of groups using Lifecycle workflows, do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Create a workflow**.

1. On the **Choose a workflow** page, select the workflow template that you want to use.

1. Add Basic information, trigger, and scope.

1. If group scope is chosen, when the **+Select group** option is picked you're able to see the sensitivity labels of each group.
    :::image type="content" source="media/workflow-sensitivity-labels/group-sensitivity-labels.png" alt-text="Screenshot of workflow sensitivity label." lightbox="media/workflow-sensitivity-labels/group-sensitivity-labels.png":::
1. If not using a group scope you're also able to see the sensitivity label of groups by selecting a group task, and then adding a group to the task.



## Related content

- [Lifecycle Workflow built-in tasks](lifecycle-workflow-tasks.md)


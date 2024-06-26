---
title: Manage synced on-premises users with workflows (Preview)
description: An how to article on how to edit a user account related task to run for synced on-premises users with Lifecycle workflows.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: entra-id-governance
ms.workload: identity
ms.topic: how-to 
ms.date: 2/14/2024
ms.subservice: lifecycle-workflows
ms.custom: template-how-to 

#CustomerIntent: As an administrator, I want to be able to edit user account tasks in workflows so that they will run for synced on-prem users.

---

# Manage synced on-premises users with workflows (Preview)

Workflows created by Lifecycle workflows can be used to manage the lifecycle of synced on-premises users. Synced on-premises support allows you to use workflow tasks to enable, disable, and delete users. In this article, you're walked through the steps of enabling a user account task to be run for a synced on-premises user.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

While most Lifecycle workflow tasks can manage synced on-premises users without any extra configuration, enabling,disabling, and deleting tasks require some additional configuration. For more information on setting these prerequisites, see:  [User account tasks (preview)](lifecycle-workflow-on-premises.md#user-account-tasks-preview).

## Configure a user account task to manage synced on-premises users using the Microsoft Entra admin center

Account related tasks within workflows can be quickly edited to apply to synced on-premises users. To edit a task in such way using the Microsoft Entra admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](~/identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **Identity governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow you want to edit the task within.

1. On the workflow screen, select **Tasks**.

1. On the Tasks screen, either select an existing task you want to run for synced on-premises users, or create a new one by selecting **Add task**.

1. On the individual task screen, enable the checkbox that corresponds to running for an on-premises account. The following image shows it being enabled for a delete user account task.
    :::image type="content" source="media/manage-workflow-on-premises/delete-user-account-task-flag.png" alt-text="Screenshot of setting on-premises flag to delete account.":::
1. Select **Save**.

## Edit a user account task to be compatible with synced on-premises users using Microsoft Graph

To manage user tasks to be compatible with synced on-premises users via API using Microsoft Graph, see: [Configure the arguments for built-in Lifecycle Workflow tasks](/graph/identitygovernance-lifecycleworkflows-task-arguments).

## Next steps

- [Check status of a workflows](check-status-workflow.md)
- [Customize workflow schedule](customize-workflow-schedule.md)


---
title: Manage synced on-premises users with workflows (preview)
description: A how to article on how to manage synced on-premises users with lifecycle workflows.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: active-directory
ms.workload: identity
ms.topic: how-to 
ms.date: 1/12/2024
ms.subservice: compliance
ms.custom: template-how-to 

#CustomerIntent: As an administrator, I want to be able to create workflows for synced on-prem users so that they can be manged.

---

# Manage synced on-premises users with workflows (preview)

Workflows created by Lifecycle Workflows can be used to manage the lifecycle of synced on-premises users. This allows for greater, and simplified, control of the lifecycle of users within your organization in hybrid environments. In this article, you're walked through the steps of enabling a task to be run for an on-premises user.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

To manage synced on-premises users with Lifecycle workflows, you must first set up hybrid prerequisites within your hybrid environment. For more information on these prerequisites, see:  [Hybrid Prerequisites](lifecycle-workflow-hybrid.md#hybrid-prerequisites).

## Edit a task to be compatible with synced on-premises users using the Microsoft Entra admin center

Account related tasks within workflows can be quickly edited to apply to synced on-premises users. To edit a task in such way using the Microsoft Entra admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](~/identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **Identity governance** > **Lifecycle workflows** > **workflows**.

1. Select the workflow you want to edit the task within.

1. On the workflow screen, select **Tasks**.

1. On the Tasks screen, either select an existing task you want to run for synced on-premises users, or create a new one by selecting **Add task**.

1. On the individual task screen, enable the checkbox that corresponds to running for an on-premises account. The following image shows it being enabled for a delete user account task.
    :::image type="content" source="media/manage-workflow-onprem/delete-user-account-task-flag.png" alt-text="Screenshot of setting on-premises flag to delete account.":::
1. Select **Save**.

## Edit a task to be compatible with synced on-premises users using Microsoft Graph

To manage user tasks to be compatible with synced on-premises users via API using Microsoft Graph, see: [Configure the arguments for built-in Lifecycle Workflow tasks](/graph/identitygovernance-lifecycleworkflows-task-arguments).

## Next steps

- [Check status of a workflows](check-status-workflow.md)
- [Customize workflow schedule](customize-workflow-schedule.md)


---
title: Delete a lifecycle workflow
description: Learn how to delete a lifecycle workflow.
author: owinfreyATL
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 05/31/2023
ms.author: owinfrey
ms.reviewer: krbain
---

# Delete a lifecycle workflow

You can remove workflows that you no longer need. Deleting these workflows helps keep your lifecycle strategy up to date.

When a workflow is deleted, it enters a soft-delete state. During this period, you can still view it in the list of deleted workflows and restore it if needed. A workflow is permanently removed 30 days after it  enters a soft-delete state. If you don't want to wait 30 days for a workflow to be permanently deleted, you can manually delete it.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]


## Delete a workflow by using the Microsoft Entra admin center

[!INCLUDE [portal updates](../includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **Identity governance** > **Lifecycle workflows** > **Workflows**.

1. On the **Workflows** page, select the workflow that you want to delete. Then select **Delete**.

    :::image type="content" source="media/delete-lifecycle-workflow/delete-button.png" alt-text="Screenshot of a list of workflows with one selected, along with the Delete button.":::

1. Confirm that you want to delete the workflow by selecting the **Delete** button.

    :::image type="content" source="media/delete-lifecycle-workflow/delete-workflow.png" alt-text="Screenshot of confirming the deletion of a workflow.":::

## View deleted workflows in the Microsoft Entra admin center

After you delete workflows, you can view them on the **Deleted workflows** page.

1. On the left pane, select **Deleted workflows**.

1. On the **Deleted workflows** page, check the list of deleted workflows. Each workflow has a description, the date of deletion, and a permanent delete date. By default, the permanent delete date for a workflow is 30 days after it was originally deleted.

    :::image type="content" source="media/delete-lifecycle-workflow/deleted-list.png" alt-text="Screenshot of a list of deleted workflows.":::

1. To restore a deleted workflow, select it and then select **Restore workflow**.

   To permanently delete a workflow immediately, select it and then select **Delete permanently**.

## Delete a workflow by using Microsoft Graph

To delete a workflow by using an API via Microsoft Graph, see [Delete a lifecycle workflow](/graph/api/identitygovernance-workflow-delete?view=graph-rest-beta&preserve-view=true).

## View deleted workflows by using Microsoft Graph

To view a list of deleted workflows by using an API via Microsoft Graph, see [List deleted workflows](/graph/api/identitygovernance-lifecycleworkflowscontainer-list-deleteditems).

## Permanently delete a workflow by using Microsoft Graph

To permanently delete a workflow by using an API via Microsoft Graph, see [Permanently delete a deleted workflow](/graph/api/identitygovernance-deleteditemcontainer-delete).

## Restore a deleted workflow by using Microsoft Graph

To restore a deleted workflow by using an API via Microsoft Graph, see [Restore a deleted workflow](/graph/api/identitygovernance-workflow-restore).

> [!NOTE]
> You can't restore permanently deleted workflows.

## Next steps

- [What are lifecycle workflows?](what-are-lifecycle-workflows.md)
- [Manage lifecycle workflow versions](manage-workflow-tasks.md)

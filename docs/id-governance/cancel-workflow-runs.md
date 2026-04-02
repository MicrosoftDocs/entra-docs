---
title: Cancel workflow runs using Lifecycle Workflows (preview)
description: Learn how to cancel in-progress or queued workflow runs in Lifecycle Workflows to prevent the impact of automation errors and misconfigurations.
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 04/01/2026
ai-usage: ai-assisted

#customer intent: As a Lifecycle Workflows Administrator, I want to cancel in-progress or queued workflow runs so that I can prevent or mitigate the impact of automation errors and misconfigurations.

---

# Cancel workflow runs using Lifecycle Workflows (preview)

Lifecycle Workflows allows administrators to cancel in-progress or queued workflow runs to prevent or mitigate the widespread impact of automation errors and misconfigurations.

When you cancel a workflow run, keep the following behavior in mind:

- **In-progress runs**: Canceling an in-progress workflow run cancels any tasks that haven't been processed yet. Tasks that already completed aren't affected.
- **Queued runs**: Queued workflows are runs where execution hasn't started yet. Canceling a queued run cancels the upcoming execution of all tasks for that run.
- **No rollback**: Previously completed changes aren't reversed. Only execution of upcoming changes is halted.
- **Single run selection**: Currently, you can only select a single run to cancel at a time.
- **Run-level cancellation only**: You can't cancel specific tasks or specific users within a run. Cancellation applies to the entire run.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

## Cancel a workflow run in the Microsoft Entra admin center

To cancel a workflow run:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow that contains the run you want to cancel.

    :::image type="content" source="media/cancel-workflow-runs/workflow-list.png" alt-text="Screenshot of the Lifecycle workflows page showing a list of workflows in the Microsoft Entra admin center.":::

1. On the workflow page, select **Workflow History**.

    :::image type="content" source="media/cancel-workflow-runs/workflow-history-cancel.png" alt-text="Screenshot of the workflow overview page with the Workflow history link highlighted in the left navigation.":::

1. Select the **Runs** tab.

1. Select a run that has a status of **In progress** or **Queued**.

    > [!NOTE]
    > The **Cancel** button is only enabled after you select a run that has a status of **In progress** or **Queued**. The **Cancel** button isn't available on the **Users** or **Tasks** tabs because only runs can be canceled.

1. Select **Cancel**.

## Known issues

<!-- TODO: Confirm with the engineering team whether these issues are still active at the time of publication. -->

- The notification shows as successful.
- Filtering by the **Cancellation Requested** status isn't yet supported.

## Related content

- [Lifecycle Workflows history](lifecycle-workflow-history.md)
- [Reprocess workflow runs using Lifecycle Workflows](reprocess-workflow.md)
- [Check the status of a workflow](check-status-workflow.md)

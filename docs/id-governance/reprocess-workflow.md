---
title: Reprocess workflow runs using Lifecycle Workflows
description: This article guides a user on reprocessing workflow runs using Lifecycle Workflows
author: owinfreyATL
ms.author: owinfrey
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 09/06/2025

#CustomerIntent: As a Lifecycle Workflow Administrator, I want to reprocess workflow runs so that I can quickly re-run workflows that may have failed.
---

# Reprocess workflow runs using Lifecycle Workflows



Lifecycle workflows allow you to automate tasks to run for users no matter where they fall in the Joiner-Mover-Leaver (JML) model within your organization. Workflow run history is recorded through the lens of runs, users processed, and tasks. With the reprocess workflow feature, you can run a previous workflow again either entirely, or in the context of a specific user. This allows you to quickly manage previous workflow runs that failed to complete for certain reasons.


## Reprocess a workflow using the Microsoft Entra admin center


To reprocess a workflow run using the Microsoft Entra admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. On the workflow list screen, select the workflow you want to reprocess.

1. On the workflow overview page, select **Workflow history**.

1. On the workflow history screen, the **Users** tab is automatically open and you see a list of users processed by the workflow.

1. To reprocess a workflow for a user, select the user you want to reprocess a workflow for, and select **Reprocess**. 
    :::image type="content" source="media/reprocess-workflow/reprocess-workflow.png" alt-text="Screenshot of reprocessing a workflow.":::
    > [!NOTE]
    > You're able to reprocess up to 10 users at a time.
1. If you want to reprocess a workflow based on a run, select the **Runs** tab.

1. In the runs tab, you're able to see a full list of workflow runs. Select the run you want to reprocess and select **Reprocess**. 
    > [!NOTE]
    > Only a single run can be reprocessed at a time.



## Next steps

- [Lifecycle Workflows history](lifecycle-workflow-history.md)
- [Auditing Lifecycle Workflows](lifecycle-workflow-audits.md)






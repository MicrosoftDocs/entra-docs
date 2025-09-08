---
title: 'Check execution user scope of a workflow - Microsoft Entra ID'
description: Describes how to check the users who fall into the execution scope of a Lifecycle Workflow.
author: owinfreyATL
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 06/25/2025
ms.author: owinfrey
ms.reviewer: krbain
ms.custom: sfi-image-nochange
---

# Check execution user scope of a workflow

Workflow scheduling will automatically process the workflow for users meeting the workflows execution conditions. This article walks you through the steps to check the users who fall into the execution scope of a workflow. For more information about execution conditions, see: [workflow basics](../id-governance/understanding-lifecycle-workflows.md#workflow-basics).

## Check execution user scope of a workflow using the Microsoft Entra admin center


To check the users who fall under the execution scope of a workflow, you'd follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. From the list of workflows, select the workflow you want to check the execution scope of.

1. On the workflow overview page, select **Execution conditions**.

1. On the Execution conditions page, select the **Execution User Scope** tab.

1. On this page you're presented with a list of users who currently meet the scope for execution for the workflow regardless of whether they have already been processed by the workflow.
    :::image type="content" source="media/check-workflow-execution-scope/execution-user-scope-list.png" alt-text="Screenshot of users under scope of workflow execution." lightbox="media/check-workflow-execution-scope/execution-user-scope-list.png":::

> [!NOTE]
> The workflow engine currently has a retroactive window that allows workflows to run for users who previously met the conditions for the workflow. For more information on this window, see: [Lifecycle workflow catch-up window](lifecycle-workflow-execution-conditions.md#lifecycle-workflow-catch-up-window).

## Check execution user scope of a workflow using Microsoft Graph

To check execution user scope of a workflow using API via Microsoft Graph, see: [List executionScope](/graph/api/workflow-list-executionscope).

## Next steps

- [Manage workflow properties](manage-workflow-properties.md)
- [Delete Lifecycle Workflows](delete-lifecycle-workflow.md)

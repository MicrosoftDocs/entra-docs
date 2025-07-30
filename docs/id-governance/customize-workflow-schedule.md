---
title: Customize a workflow schedule
description: Learn how to customize the schedule of a lifecycle workflow.
author: owinfreyATL
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 06/25/2025
ms.author: owinfrey
ms.reviewer: krbain
---

# Customize the schedule of workflows

When you create workflows by using lifecycle workflows, you can fully customize them to match the schedule that fits your organization's needs. By default, workflows are scheduled to run every 3 hours. But you can set the interval to be as frequent as 1 hour or as infrequent as 24 hours.

## Customize the schedule of workflows by using the Microsoft Entra admin center


Workflows that you create within lifecycle workflows follow the same schedule that you define on the **Workflow settings** pane. To adjust the schedule, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows**.

1. On the **Lifecycle workflows** overview page, select **Workflow settings**.

1. On the **Workflow settings** pane, set the schedule of workflows as an interval of 1 to 24.

   :::image type="content" source="media/customize-workflow-schedule/workflow-schedule-settings.png" alt-text="Screenshot of the settings for a workflow schedule.":::
1. Select **Save**.

## Customize the schedule of workflows by using Microsoft Graph

To schedule workflow settings by using the Microsoft Graph API, see [`lifecycleManagementSettings` resource type](/graph/api/resources/identitygovernance-lifecyclemanagementsettings).

## Next steps

- [Manage workflow properties](manage-workflow-properties.md)
- [Delete lifecycle workflows](delete-lifecycle-workflow.md)

---
title: Download workflow history reports (Preview)
description: This article guides a user on downloading the history of a Lifecycle workflow
author: owinfreyATL
ms.author: owinfrey
ms.service: active-directory
ms.workload: identity
ms.topic: how-to 
ms.date: 11/15/2023

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
---

# Download workflow history reports (Preview)

Lifecycle workflow history allows you to view details about the actions of a workflow such as when it runs, processes a task, or processes a user. In the Microsoft Entra admin center you're able to filter this information up to 30 days from when the action was taken. For a step guide on viewing this information in the Microsoft Entra admin center, see: [Check the status of a workflow](check-status-workflow.md). To store this information for a longer period of time, you can save the filtered history as a CSV report. This article walks you through how you can download these reports.

## Download the history report of a workflow using the Microsoft Entra admin center

To download the history report of a workflow using the Microsoft Entra admin center, you'd follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](~/identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **Identity governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow you want to download the history of.

1. On the workflow overview screen, select **Workflow history**.

1. On the Workflow history screen you're able to see a summary and total count of users, runs, or tasks processed by the workflow in the time frame of the filter.
    :::image type="content" source="media/download-workflow-history/workflow-history-screen.png" alt-text="Screenshot of the workflow history screen.":::
1. The default history screen shows **Users**, but you're able to select **Runs**, or **Tasks** to see their information on this screen.
    :::image type="content" source="media/download-workflow-history/task-workflow-history-screen.png" alt-text="Screenshot of the workflow history screen with tasks selected.":::
1. On the page workflow history page that you wish to download a report of set your filters to what you want included in your report and select **Download (Preview)**.
    :::image type="content" source="media/download-workflow-history/workflow-history-screen-download.png" alt-text="Screenshot of download location on workflow history screen.":::
1. On the download pane you see the type of report you're downloading at the top, and it's also present in the default name of the CSV report.
    :::image type="content" source="media/download-workflow-history/history-download-pane.png" alt-text="Screenshot of the workflow history download pane.":::
1. Select **Download**.
 
> [!NOTE]
> You can download up to 100,000 records. If you want to download more use the [Lifecycle Workflow reporting API](/graph/api/resources/identitygovernance-lifecycleworkflows-reporting-overview).

## Next steps


> [Check the status of a workflow](check-status-workflow.md)
> [Lifecycle Workflows history](lifecycle-workflow-history.md)

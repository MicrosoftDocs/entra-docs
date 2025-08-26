---
title: Download workflow history reports
description: This article guides a user on downloading the history of a Lifecycle workflow.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 08/25/2025

#CustomerIntent: As an admin, I want to download history reports as a CSV.
---

# Download workflow history reports

Lifecycle Workflow's history feature allows you to view details about the actions of a workflow such as when it runs, processes a task, or processes a user. From the Microsoft Entra admin center, you're able to filter this information up to 30 days from when the action was taken. To store this information for a longer period of time, you can save the history as a CSV report. This article walks you through how you can download these reports.

## Download the history report of a workflow using the Microsoft Entra admin center

To download the history report of a workflow using the Microsoft Entra admin center, you'd follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow you want to download the history of.

1. On the workflow overview screen, select **Workflow history** under the **Activity** bar on the left.

1. The Workflow history screen shows the history of a workflow from the view of Users, runs, and Tasks. For more information on workflow history, see: [Lifecycle Workflows history](lifecycle-workflow-history.md).
    :::image type="content" source="media/download-workflow-history/workflow-history-screen.png" alt-text="Screenshot of the workflow history screen.":::
1. On the page workflow history page that you wish to download a report of, the applied filters are included in your report. When these selected filters match what you want in your report, select **Download**.
    :::image type="content" source="media/download-workflow-history/workflow-history-screen-download.png" alt-text="Screenshot of download location on workflow history screen.":::
1. On the download pane, you see the type of report you're downloading at the top, and it's also present in the default name of the CSV report.
   
    :::image type="content" source="media/download-workflow-history/history-download-pane.png" alt-text="Screenshot of the workflow history download pane.":::
1. Select **Download**.
 
> [!NOTE]
> You can download up to 100,000 records in a report. If you want to download more, use the [Lifecycle Workflow reporting API](/graph/api/resources/identitygovernance-lifecycleworkflows-reporting-overview).

## Next steps

- [Check the status of a workflow](check-status-workflow.md)
- [Lifecycle Workflows history](lifecycle-workflow-history.md)

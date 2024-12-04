---
title: Improve the performance of Log Analytics and workbooks
description: Learn how to improve the performance of your Log Analytics workspaces and workbooks in Microsoft Entra ID.
ms.service: entra-id
ms.subservice: monitoring-health
ms.topic: tutorial
ms.date: 11/22/2024
ms.author: sarahlipsey
author: shlipsey3
manager: amycolannino
ms.reviewer: sandeo

# Customer intent: As an IT admin, I want to exclude some unnecessary logs from the logs I integrate with Log Analytics so I can improve the performance of my analysis tools.

---
# Tutorial: Improving performance of sign-in logs and Log Analytics

In this tutorial, you learn how to:

> [!div class="checklist"]
> * Set up an Azure event hub for sign-in logs
> * Create a custom Log Analytics table
> * Create an Azure function to connect the event hub with the Log Analytics table
> * Remove Conditional Access policies from the logs

Sign-in and audit logs can generate a large amount of data, so if you're integrating the logs with Log Analytics for analysis, you might want to exclude some unnecessary logs to improve the performance of your analysis tools. This tutorial shows you how to stream your logs through an Azure event hub to a custom Log Analytics table, using an Azure Function to filter out the logs you don't need. 

## Prerequisites

This tutorial includes several advanced steps. To complete the steps in this tutorial, you need the following roles and requirements:

- A working Microsoft Entra tenant with Microsoft Entra ID P1 or trial licenses enabled.
  - If you need to, [create one for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- [Microsoft Entra monitoring and health licensing](../../fundamentals/licensing.md#microsoft-entra-monitoring-and-health)

- [Access to create a Log Analytics workspace](/azure/azure-monitor/logs/manage-access)
    If you haven't already created a Log Analtyics workspace and a custom workbook, complete the [Configure Log Analytics workspace](tutorial-configure-log-analytics-workspace.md) and [Create a Log Analytics workbook](tutorial-create-log-analytics-workbook.md) tutorials.

- The appropriate role for Azure Monitor:
  - Monitoring Reader
  - Log Analytics Reader
  - Monitoring Contributor
  - Log Analytics Contributor

- The appropriate role for Microsoft Entra ID:
  - Reports Reader
  - Security Reader
  - Global Reader
  - Security Administrator

- The final step requires completing a tutorial with a different set of requirements and prerequisites. See [Create a function in Azure with TypeScript using Visual Studio Code](/azure/azure-functions/create-first-function-vs-code-typescript?pivots=nodejs-model-v4#configure-your-environment) for more information.

## Set up an Azure event hub

In this step, you create an Azure event hub and route your sign-in logs. You need to save several details created during this step to use in the next steps.

1. [Create an event hub using the Azure portal](/azure/event-hubs/event-hubs-create).
    - This quickstart guide includes creating the resource group, the Event Hubs namespace, and the event hub itself.
    - Save the **Event Hub namespace name** and **Event Hub name**.

1. Browse to **Subscriptions** and save the **Azure subscription ID**.

1. To stream your sign-in logs to the new event hub, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator).

1. Browse to **Identity** > **Monitoring & health** > **Diagnostic settings**.

1. Select **+ Add diagnostic setting**.

1. Select `SignInLogs` and the **Stream to an event hub** check box.

1. Select the Azure subscription, event hub namespace, and event hub name.

The logs might take several minutes to start flowing into the event hub. 

To verify that the event hub has activity from sign-ins flowing into it:

1. Browse to **Event Hubs** > **Event Hub namespace** > **Event Hubs**.
1. Select the sign-in logs to view the activity on the overview page as it's ingested into Event Hub. 

## Create a custom Log Analytics table

In this step, you create a custom Log Analytics table. You need to save several details created during this step to use in the next steps.

1. Follow the [Send data to Azure Monitor logs with Logs ingestion API](/azure/azure-monitor/logs/tutorial-logs-ingestion-portal) tutorial. 

1. Save the following details:
    - Tenant ID
    - Application ID
    - Application secret
    - Logs ingestion URI
    - DCR `immutableId` value

1. In the [Create new table in Log Analytics workspace](/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#create-new-table-in-log-analytics-workspace) section, use `CaPolicyLogs` as the **Table name**.
    - This name gets updated to `Custom-CaPolicyLogs_CL` within the Azure Function's .env file in the next section.

1. In the [Parse and filter sample data](/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#parse-and-filter-sample-data) section, use the [Log Analytics example JSON](reference-log-analytics-example-json.md) as the data sample.

## Create a new Azure Function

In this step you use a TypeScript function using Visual Studio Code to connect your Azure event hub with your custom Log Analytics table.

1. Follow the [Create a TypeScript function using Visual Studio Code](/azure/azure-functions/create-first-function-vs-code) tutorial.
    - Select **v4** as the programming model option.

1. Provide a globally unique name that is clearly about sign-in logs and Conditional Access policies.

1. Configure the Azure Function to be triggered by an event hub.

1. Save the `app.eventHub` coniguration code from the <YourAzureFunctionName.ts> file.

    > [!IMPORTANT]
    > Make sure you can run the example in the **Run the function in Azure** section and that it successfully deploys before proceeding to the next step. This step starts processing items from the event hub but doesn't yet stream your data into the Log Analytics table.

1. 














## Related content
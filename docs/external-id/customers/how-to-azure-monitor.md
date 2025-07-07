---
title: Azure Monitor in external tenants
description: Learn how to set up Azure Monitor in external tenants to collect and analyze data in your tenant.
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 07/07/2025
ms.author: cmulligan
ms.custom: sfi-ga-nochange, sfi-image-nochange
#Customer intent: As an it admin, I want to learn how to set up Azure Monitor in external tenants to collect and analyze data in this tenant.
---
# Set up Azure Monitor in external tenants (preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[Azure Monitor](/azure/azure-monitor/overview) is a comprehensive solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. The diagnostic settings on the monitored resource specify what data to send and where to send it. For Microsoft Entra, the destination options include [Azure Storage](/azure/storage/blobs/storage-blobs-introduction), [Log Analytics](/azure/azure-monitor/essentials/resource-logs#send-to-log-analytics-workspace) and [Azure Event Hubs](/azure/event-hubs/event-hubs-about).

:::image type="content" source="media/how-to-azure-monitor/azure-monitor-flow.png" alt-text="Diagram of the Azure Monitor flow.":::

When you plan to transfer external tenant logs to different monitoring solutions, or repository, consider that external tenant logs contain personal data. When you process such data, ensure you use appropriate security measures on the personal data. It includes protection against unauthorized or unlawful processing, using appropriate technical or organizational measures.

## Deployment overview

The external tenant uses [Microsoft Entra monitoring](/entra/identity/monitoring-health/overview-monitoring-health). Unlike Microsoft Entra tenants, an external tenant can't have a subscription associated with it. So, we need to take extra steps to enable the integration between external tenant and Log Analytics, which is where we send the logs.
To enable [Diagnostic settings](/azure/azure-monitor/essentials/diagnostic-settings) in workforce tenant within your external tenant, you use [Azure Lighthouse](/azure/lighthouse/overview) to [delegate a resource](/azure/lighthouse/concepts/architecture), which allows your external tenant (the **Service Provider**) to manage a workforce tenant (the **Customer**) resource.

> [!TIP]
> Azure Lighthouse is typically used to manage resources for multiple customers. However, it can also be used to simplify cross-tenant administration [within an enterprise that has multiple Microsoft Entra tenants of its own](/azure/lighthouse/concepts/enterprise). In our case, we're using it to delegate management of a single resource group.

By following the steps in this article, you'll create a new resource group named _ExtIDMonitor_ in your workforce tenant and gain access to the same resource group containing the [Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace) in your external tenant. You'll also be able to transfer the logs from external tenant to your Log Analytics workspace.

During this deployment, you'll authorize a user or group in your external tenant directory to configure the Log Analytics workspace instance within the tenant that contains your Azure subscription. To create the authorization, you deploy an [Azure Resource Manager](/azure/azure-resource-manager/) template to the subscription that contains the Log Analytics workspace.

The following diagram depicts the components you'll configure in your workforce tenant and external tenants.

:::image type="content" source="media/how-to-azure-monitor/resource-group-projection.png" alt-text="Flow chart of the resource group projection.":::

During this deployment, you'll configure your external tenant where logs are generated. You'll also configure your external tenant where the Log Analytics workspace will be hosted. The external tenant accounts used (such as your admin account) should be assigned the [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator) role on the external tenant. The account you'll use to run the deployment in the external tenant must be assigned the [Owner](/azure/role-based-access-control/built-in-roles#owner) role in the Microsoft Entra subscription. It's also important to make sure you're signed in to the correct directory as you complete each step as described.

In summary, you'll use Azure Lighthouse to allow a user or group in your external tenant to manage a resource group in a subscription associated with a different tenant (the workforce tenant). After this authorization is completed, the subscription and log analytics workspace can be selected as a target in the Diagnostic settings in external tenant.

## Prerequisites

- An Azure subscription. If you don't have one, create a <a href="https://azure.microsoft.com/free/?WT.mc_id=A261C142F" target="_blank">free account</a> before you begin.
- A Microsoft Entra account with the [Owner](/azure/role-based-access-control/built-in-roles#owner) role in the Microsoft Entra subscription.
- An account in the external tenant that's been assigned the [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator) role. 

## Configuration overview

To follow the configuration steps in this article, we recommend opening two separate browser windows or tabs: one for the workforce tenant and one for the external tenant. This setup will help you switch between the two tenants as needed.

## Step 1: Workforce tenant configuration - create resource group and logs workspace

### Create a resource group

First, create, or choose a resource group that contains the destination Log Analytics workspace that will receive data from external tenant. You'll specify the resource group name when you deploy the Azure Resource Manager template.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your workforce tenant from the **Directories + subscriptions** menu.
1. [Create a resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups) or choose an existing one. This example uses a resource group named _ExtIDMonitor_.

### Create a Log Analytics workspace

A **Log Analytics workspace** is a unique environment for Azure Monitor log data. You'll use this Log Analytics workspace to collect data from external tenant, and then visualize it with queries.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your workforce tenant from the **Directories + subscriptions** menu.
1. [Create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace). This example uses a Log Analytics workspace named _ExtIDLogAnalytics_, in a resource group named _ExtIDMonitor_.

### Add microsoft.insights as a resource provider

In this step, you choose your external tenant as a **service provider**. You also define the authorizations you need to assign the appropriate built-in roles to groups in your Microsoft Entra tenant.
To see all resource providers, and the registration status for your subscription:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your workforce tenant from the **Directories + subscriptions** menu.
1. On the Azure portal menu, search for **Subscriptions**. 
1. Select the subscription you want to view.
1. On the left menu, under **Settings**, select **Resource providers**.
1. Select the **microsoft.insights** resource provider, and select **Register**.

## Step 2: External tenant configuration - get external tenant ID and create a group for external ID monitoring

### Get your external tenant ID

First, get the **Tenant ID** of your external tenant. You'll need this ID to configure the external tenant to send logs to the Log Analytics workspace in the workforce tenant.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories + subscriptions** menu.
1. Select **Tenant overview** and select **Overview**.
1. Record the **Tenant ID**.

### Create a group for external ID monitoring

Now create a group or user to which you want to give permission to the resource group you created earlier in the directory containing your subscription.

To make management easier, we recommend using Microsoft Entra user _groups_ for each role, allowing you to add or remove individual users to the group rather than assigning permissions directly to that user. In this walkthrough, we'll add a security group.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories + subscriptions** menu.
1. Select **Groups**, and then select a group. If you don't have an existing group, create a **Security** group, then add members. For more information, follow the procedure [Create a basic group and add members using workforce tenant](/entra/fundamentals/how-to-manage-groups).
1. Select **Overview** and record the group's **Object ID**.

## Step 3: Workforce tenant configuration - configure Azure Lighthouse

### Create an Azure Resource Manager template

To create the custom authorization and delegation in Azure Lighthouse, we use an Azure Resource Manager template. This template grants the external tenant access to the Microsoft Entra resource group, which you created earlier, for example, _ExtIDMonitor_. Deploy the template from the GitHub sample by using the **Deploy to Azure** button, which opens the Azure portal and lets you configure and deploy the template directly in the portal. For these steps, make sure you're signed in to your Microsoft Entra workforce tenant (not the external tenant).

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your workforce tenant from the **Directories + subscriptions** menu. 
1. Use the **Deploy to Azure** button to open the Azure portal and deploy the template directly in the portal. For more information, see [create an Azure Resource Manager template](/azure/lighthouse/how-to/onboard-customer#create-an-azure-resource-manager-template).

   [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fexternal-id-azure-monitor%2Fmain%2Ftemplates%2FrgDelegatedResourceManagement.json)

1. On the **Custom deployment** page, enter the following information:

   | Field                 | Definition                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
   | --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
   | Subscription          | Select the directory that contains the Azure subscription where the _ExtIDMonitor_ resource group was created.                                                                                                                                                                                                                                                                                                                                                                                                       |
   | Region                | Select the region where the resource will be deployed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
   | Msp Offer Name        | A name describing this definition. For example, _ExtIDMonitor_. It's the name that will be displayed in Azure Lighthouse.  The **MSP Offer Name** must be unique in your workforce tenant. To monitor multiple external tenants, use different names. |
   | Msp Offer Description | A brief description of your offer. For example, _Enable Azure Monitor in the external tenant_.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
   | Managed By Tenant ID  | The **Tenant ID** of your external tenant (also known as the directory ID).                                                                                                                                                                                                                                                                                                                                                                                                                                              |
   | Authorizations        | Specify a JSON array of objects that include the workforce tenant `principalId`, `principalIdDisplayName`, and Azure `roleDefinitionId`. The `principalId` is the **Object ID** of the group or user that will have access to resources in this Azure subscription. For this walkthrough, specify the group's Object ID that you recorded earlier in the external tenant. For the `roleDefinitionId`, use the [built-in role](/azure/role-based-access-control/built-in-roles) value for the _Contributor role_, `b24988ac-6180-42a0-ab88-20f7382dd24c`. |
   | Rg Name               | The name of the resource group you create earlier in your workforce tenant. For example, _ExtIDMonitor_.                                                                                                                                                                                                                                                                                                                                                                                                |

   The following example demonstrates an Authorizations array with one security group.

   ```json
   [
     {
       "principalId": "<Replace with group's OBJECT ID>",
       "principalIdDisplayName": "external tenant administrators",
       "roleDefinitionId": "b24988ac-6180-42a0-ab88-20f7382dd24c"
     }
   ]
   ```

After you deploy the template, it can take a few minutes (typically no more than five) for the resource projection to complete. You can verify the deployment in your =workforce tenant and get the details of the resource projection. For more information, see [View and manage service providers](/azure/lighthouse/how-to/view-manage-service-providers).

## Step 4: External tenant configuration - select your subscription

After you've deployed the template and waited a few minutes for the resource projection to complete, follow these steps to associate your subscription with your external tenant.

> [!NOTE]
> On the **Portal settings | Directories + subscriptions** page, ensure that your external and workforce tenants are selected under **Current + delegated directories**.

### Select your subscription

1. Sign out of the [Azure portal](https://portal.azure.com) and sign back in with your external tenant administrative account. This account must be a member of the security group you specified previously. Signing out and singing back in allows your session credentials to be refreshed in the next step.
1. Select the **Settings** icon in the portal toolbar.
1. On the **Portal settings | Directories + subscriptions** page, in the **Directory name** list,  find your workforce tenant directory that contains the Azure subscription and the _ExtIDMonitor_ resource group you created, and then select **Switch**.
1. Verify that you've selected the correct directory and your Azure subscription is listed and selected in the **Default subscription filter**.

:::image type="content" source="media/how-to-azure-monitor/default-subscription-filter.png" alt-text="Screenshot of the default subscription filter.":::

### Configure diagnostic settings

Diagnostic settings define where logs and metrics for a resource should be sent. Possible destinations are:

- [Azure storage account](/azure/azure-monitor/essentials/resource-logs#send-to-azure-storage)
- [Event hubs](/azure/azure-monitor/essentials/resource-logs#send-to-azure-event-hubs) solutions
- [Log Analytics workspace](/azure/azure-monitor/essentials/resource-logs#send-to-log-analytics-workspace)

In this example, we use the Log Analytics workspace to create a dashboard. Follow the steps to configure [monitoring settings](/entra/identity/monitoring-health/overview-monitoring-health) for the external tenant activity logs:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories + subscriptions** menu. This account must be a member of the security group you specified previously.
1. Browse to **Diagnostic settings** by navigating to **Entra ID** > **Monitoring & health**.
1. If there are existing settings for the resource, you'll see a list of settings already configured. Either select **Add diagnostic setting** to add a new setting, or select **Edit settings** to edit an existing setting. Each setting can have no more than one of each of the destination types.

    :::image type="content" source="media/how-to-azure-monitor/diagnostic-settings-pane-enabled.png" alt-text="Screenshot of the diagnostics settings.":::

1. Give your setting a name if it doesn't already have one.
1. Select **AuditLogs** and **SignInLogs**.
1. Select **Send to Log Analytics Workspace**, and then:
    1. Under **Subscription**, select your subscription. 
    2. Under **Log Analytics Workspace**, select the name of the workspace you created earlier such as _ExtIDLogAnalytics_.

1. Select **Save**.

> [!NOTE]
> It can take up to 15 minutes after an event is emitted for it to [appear in a Log Analytics workspace](/azure/azure-monitor/logs/data-ingestion-time). While you're waiting, it might be helpful to perform some actions to generate logs. For example, you could follow the [Get started guide](/entra/external-id/customers/quickstart-get-started-guide) to create some configurations and sign up a user.

## Step 5: Workforce tenant configuration – visualize your data

Now you can configure your Log Analytics workspace to visualize your data and set up alerts. You can make these configurations in both your workspace and external tenant.

### Create a query

Log queries help you to fully use the value of the data collected in Azure Monitor Logs. A powerful query language allows you to join data from multiple tables, aggregate large sets of data, and perform complex operations with minimal code. Virtually any question can be answered and analysis performed as long as the supporting data has been collected and you understand how to construct the right query. For more information, see [Get started with log queries in Azure Monitor](/azure/azure-monitor/logs/get-started-queries).

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your workforce tenant from the **Directories + subscriptions** menu.
1. From **Log Analytics workspace** window, select **Logs**
1. In the query editor, paste the following [Kusto Query Language](/azure/data-explorer/kusto/query/) query. This query shows policy usage by operation over the past x days. The default duration is set to 90 days (90d). Notice that the query is focused only on the operation where a token/code is issued by policy.

   ```kusto
   AuditLogs
   | where TimeGenerated  > ago(90d)
   | where OperationName contains "issue"
   | extend  UserId=extractjson("$.[0].id",tostring(TargetResources))
   | extend Policy=extractjson("$.[1].value",tostring(AdditionalDetails))
   | summarize SignInCount = count() by Policy, OperationName
   | order by SignInCount desc  nulls last
   ```

1. Select **Run**. The query results are displayed at the bottom of the screen.
1. To save your query for later use, select **Save**.

  :::image type="content" source="media/how-to-azure-monitor/query-policy-usage.png" alt-text="Screenshot of the Log Analytics log editor.":::

7. Fill in the following details:

   - **Name** - Enter the name of your query.
   - **Save as** - Select `query`.
   - **Category** - Select `Log`.

8. Select **Save**.

You can also change your query to visualize the data by using the [render](/azure/data-explorer/kusto/query/renderoperator?pivots=azuremonitor) operator.

```kusto
AuditLogs
| where TimeGenerated  > ago(90d)
| where OperationName contains "issue"
| extend  UserId=extractjson("$.[0].id",tostring(TargetResources))
| extend Policy=extractjson("$.[1].value",tostring(AdditionalDetails))
| summarize SignInCount = count() by Policy
| order by SignInCount desc  nulls last
| render  piechart
```

  :::image type="content" source="media/how-to-azure-monitor/query-policy-usage.png" alt-text="Screenshot of the Log Analytics log editor pie chart.":::

## Change the data retention period

Azure Monitor Logs are designed to scale and support collecting, indexing, and storing massive amounts of data per day from any source in your enterprise or deployed in Azure. By default, logs are retained for 30 days, but retention duration can be increased to up to two years. Learn how to [manage usage and costs with Azure Monitor Logs](/azure/azure-monitor/logs/cost-logs). After you select the pricing tier, you can [Change the data retention period](/azure/azure-monitor/logs/data-retention-configure).

## Disable monitoring data collection

To stop collecting logs to your Log Analytics workspace, delete the diagnostic settings you created. You'll continue to incur charges for retaining log data you've already collected into your workspace. If you no longer need the monitoring data you've collected, you can delete your Log Analytics workspace and the resource group you created for Azure Monitor. Deleting the Log Analytics workspace deletes all data in the workspace and prevents you from incurring other data retention charges.

### Delete Log Analytics workspace and resource group

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your workforce tenant from the **Directories + subscriptions** menu.
1. Choose the resource group that contains the Log Analytics workspace. This example uses a resource group named _ExtIDMonitor_ and a Log Analytics workspace named _ExtIDLogAnalytics_.
1. [Delete the Logs Analytics workspace](/azure/azure-monitor/logs/delete-workspace).
1. Select the **Delete** button to delete the resource group.

## Related content

- [Use audit logs and access reviews](/entra/external-id/auditing-and-reporting)

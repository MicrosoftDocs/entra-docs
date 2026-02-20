---
title: Azure Monitor in external tenants
description: Learn how to set up Azure Monitor in external tenants to collect and analyze data in your tenant.
ms.topic: how-to
ms.date: 10/01/2025
ms.custom: sfi-ga-nochange, sfi-image-nochange

#Customer intent: As an it admin, I want to learn how to set up Azure Monitor in external tenants to collect and analyze data in this tenant.
---
# Set up Azure Monitor in external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[Azure Monitor](/azure/azure-monitor/overview) provides a comprehensive solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. The diagnostic settings on the monitored resource specify what data to send and where to send it. For Microsoft Entra, you can send data to [Azure Storage](/azure/storage/blobs/storage-blobs-introduction), [Log Analytics](/azure/azure-monitor/essentials/resource-logs#send-to-log-analytics-workspace), or [Azure Event Hubs](/azure/event-hubs/event-hubs-about).

When you transfer external tenant logs to other monitoring solutions or storage locations, be aware that these logs might contain personal data. When processing personal data, use appropriate security measures to protect it. These measures should prevent unauthorized or unlawful processing by using appropriate technical and organizational safeguards.

This article describes how to configure Azure Monitor in an external tenant so you can collect and analyze data in your tenant. It also explains how to configure diagnostic settings to send logs and metrics to a Log Analytics workspace in your workforce tenant.

## Deployment overview

External tenants use [Microsoft Entra monitoring](/entra/identity/monitoring-health/overview-monitoring-health). Unlike workforce tenants, an external tenant can't have an associated subscription. To enable monitoring in an external tenant, sign in to your workforce tenant to authenticate the subscription during configuration.  
You can also use [Azure Lighthouse](/azure/lighthouse/overview) to enable diagnostic settings for a workforce tenant (the Customer) within your external tenant (the Service Provider).

In this configuration, you use a wizard. You can start the wizard from either of these entry points: the **Diagnostic settings** page or the **Security Store** page. This article covers both approaches.

## Prerequisites

- An Azure subscription. If you don't have one, create a <a href="https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn" target="_blank">free account</a> before you begin.
- A Microsoft Entra account with the [Owner](/azure/role-based-access-control/built-in-roles#owner) role in the Microsoft Entra subscription.
- An account in the external tenant that's been assigned the [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator) or the [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) role.

> [!IMPORTANT]
> This feature supports only the new [Azure Role-Based Access Control (RBAC) Owner role](/azure/role-based-access-control/built-in-roles/privileged#owner), not the classic administrator roles. For instructions on converting classic administrator roles to Azure RBAC, see [Azure classic subscription administrators](/azure/role-based-access-control/classic-administrators?tabs=azure-portal). After you complete the conversion, refresh the page to apply the changes.

## Start the wizard to set up Azure Lighthouse

To configure Azure Lighthouse in an external tenant, start the wizard from either the **Diagnostic settings** page or the **Security Store** page. Choose one of the following tabs with the entry points to get started.

# [Diagnostic settings](#tab/diagnostic-settings)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** in your external tenant and select **Monitoring & health** > **Diagnostic settings**.
1. Select **Start set up** to launch the wizard.

# [Security Store](#tab/security-store)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Home** > **Security Store** > **Monitor logs with Azure Monitor**.
1. Select **Get started** to open the **Diagnostic settings** page. If Azure monitoring is already configured, you can select **View logs** to open the logs experience.
1. Select **Start set up** to launch the wizard.

---

:::image type="content" source="media/how-to-azure-monitor/start-set-up.png" alt-text="Screenshot that shows how to start the wizard.":::

## Set up the Azure Lighthouse configuration in the wizard

The following steps guide you through the wizard to set up Azure Lighthouse configuration in your external tenant.

### Step 1: Sign in to your workforce tenant

To set up Azure Lighthouse, sign in with an account that has access to the subscription that owns the external configuration tenant.

:::image type="content" source="media/how-to-azure-monitor/sign-in-to-workforce.png" alt-text="Screenshot that shows how to sign in to your workforce tenant.":::

### Step 2: Fill out the project details

In this step, provide the details of your project. When you create a resource group and a Log Analytics workspace at the same time, you can select only one [location](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/). This location is limited to the regions available for both the resource group and the Log Analytics workspace. To access the full list of locations, create the resource group and the Log Analytics workspace separately beforehand.

1. Select a **Subscription** from the dropdown.
1. Use an existing **Resource Group** or create a new one.
1. Provide a name for the new **Log Analytics workspace**. This name must be unique per resource group.
1. Select an available **Region**.
1. Select **Next**.

  :::image type="content" source="media/how-to-azure-monitor/select-subscription.png" alt-text="Screenshot that shows how to select a subscription.":::

### Step 3: Select user access

Choose the users or groups in your external tenant who can access the [Log Analytics workspace](/azure/azure-monitor/logs/log-analytics-workspace-overview). The selected users need at least the [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator) role to set up diagnostic settings.

Confirm your selection with the **Select** button. After you select the users or groups, assign a role to them. You can choose from the following roles:

- **[Contributor](/azure/role-based-access-control/built-in-roles/privileged#contributor)**: Can read monitoring data and configuration.
- **[Log Analytics Contributor](/azure/azure-monitor/logs/manage-access?tabs=portal#log-analytics-contributor)**: Can read and write monitoring data and configuration.
- **[Monitoring Contributor](/azure/role-based-access-control/built-in-roles/monitor#monitoring-contributor)**: Can read all monitoring data and edit monitoring settings.
- **Monitoring Policy Contributor**: Can manage security-related features, including viewing and managing security alerts and reports.

<!---Check these roles!--->
After you select the users or groups and assign a role, select **Next** to continue.

  :::image type="content" source="media/how-to-azure-monitor/select-users-and-roles.png" alt-text="Screenshot that shows how to add users, groups, and roles.":::

#### Optional: Add tags to your Log Analytics workspace

You can add tags to your Log Analytics workspace. Tags are name/value pairs that help you categorize resources and view consolidated billing by applying the same tag to multiple resources and resource groups. For more information, see [Use tags to organize your Azure resources](/azure/azure-resource-manager/management/tag-resources).

### Step 4: Review and create your Log Analytics workspace

Review your configuration. If you need to make changes, use the **Back** button to return to the previous steps. If everything looks correct, select **Create** to set up the Log Analytics workspace and assign the selected users or groups the specified role. Setting up the Log Analytics workspace and assigning roles might take a few minutes, so don't close the browser window.

  :::image type="content" source="media/how-to-azure-monitor/review-and-create.png" alt-text="Screenshot that shows how to review and create your Log Analytics workspace.":::

When the setup is complete, you see a confirmation message. Select **Done** and configure diagnostic settings to start sending logs and metrics to your Log Analytics workspace.

  :::image type="content" source="media/how-to-azure-monitor/successful-configuration.png" alt-text="Screenshot that shows the setup completion message.":::

## Configure diagnostic settings

[Diagnostic settings](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal) enable you to collect [resource logs](/azure/azure-monitor/platform/resource-logs?tabs=log-analyticsd) and send [platform metrics](/azure/azure-monitor/reference/metrics-index) and the [activity log](/azure/azure-monitor/platform/activity-log?tabs=log-analytics) to different destinations. You can create up to five different diagnostic settings to send various logs and metrics to different destinations. Follow these steps to configure diagnostic settings in your external tenant.

1. Select **Add settings** under **Add diagnostic settings**.
1. If you select **Review** before adding settings, you can see the **Subscription** and **Resource Group** on the right hand side. These fields are read-only. To make changes, remove the existing service provider information and start the wizard again. If you're satisfied with the selection, select **Done** to continue to the next step. This step is optional.

> [!NOTE]
> If you select **Review** before adding settings, the **Subscription** and **Resource group** appear on the right-hand side. These fields are read-only. To make changes, remove the existing service provider information and restart the wizard.  
Keep the window open while the background subscription check runs. If you close or refresh the window before the check finishes, you might need to restart the wizard from **Start setup**.

  :::image type="content" source="media/how-to-azure-monitor/add-diagnostic-settings.png" alt-text="Screenshot that shows the Add diagnostic settings page." lightbox="media/how-to-azure-monitor/add-diagnostic-settings.png":::


3. Select **Add diagnostic setting** to add a new setting or **Edit setting** to edit an existing one. You might need multiple diagnostic settings for a resource if you want to send data to multiple destinations of the same type.
4. Give your setting a descriptive name.
5. **Logs and metrics to route**: For logs, either choose a [category group](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal#category-groups) or select the individual checkboxes for each category of data you want to send to the destinations specified later. The list of categories varies for each Azure service. Select **AllMetrics** if you want to collect platform metrics.
6. **Destination details**: Select the checkbox for each destination that should be included in the diagnostic settings and then provide the details for each. If you select Log Analytics workspace as a destination, then you might need to specify the collection mode. See [Collection mode](/azure/azure-monitor/platform/resource-logs?tabs=log-analytics#collection-mode) for details.

## Visualize your data with log queries

Once you configure your diagnostic settings and data flows into your Log Analytics workspace, use log queries to analyze and visualize your data. Log queries are written in Kusto Query Language (KQL) and can help you gain insights from the logs and metrics collected. You can make these configurations in both your workforce and external tenant.

### Create a query

Log queries help you get the most value from the data collected in Azure Monitor Logs. A powerful query language lets you join data from multiple tables, aggregate large sets of data, and perform complex operations with minimal code. You can answer virtually any question and perform analysis as long as you collect the supporting data and understand how to construct the right query. For more information, see [Get started with log queries in Azure Monitor](/azure/azure-monitor/logs/get-started-queries).

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your workforce tenant from the **Directories + subscriptions** menu.
1. From **Log Analytics workspace** window, select **Logs**
1. In the query editor, paste the following [Kusto Query Language](/azure/data-explorer/kusto/query/) query. This query shows policy usage by operation over the past x days. The default duration is set to 90 days (90d). Notice that the query is focused only on the operation where a token or code is issued by policy.

  ```kusto
  AuditLogs
  | where TimeGenerated  > ago(90d)
  | where OperationName contains "issue"
  | extend  UserId=extractjson("$.[0].id",tostring(TargetResources))
  | extend Policy=extractjson("$.[1].value",tostring(AdditionalDetails))
  | summarize SignInCount = count() by Policy, OperationName
  | order by SignInCount desc  nulls last
  ```

5. Select **Run**. The query results are displayed at the bottom of the screen.
6. To save your query for later use, select **Save**.

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

  :::image type="content" source="media/how-to-azure-monitor/query-policy-usage-pie.png" alt-text="Screenshot of the Log Analytics log editor pie chart.":::

## Change the data retention period

Azure Monitor Logs scale to support collecting, indexing, and storing massive amounts of data each day from any source in your enterprise or deployed in Azure. By default, logs are retained for 30 days, but you can increase the retention duration to up to two years. For more information, see [manage usage and costs with Azure Monitor Logs](/azure/azure-monitor/logs/cost-logs). After you select the pricing tier, you can [Change the data retention period](/azure/azure-monitor/logs/data-retention-configure).

## Disable monitoring data collection

To stop collecting logs to your Log Analytics workspace, delete the diagnostic settings you created. You continue to incur charges for retaining log data you already collected into your workspace. If you no longer need the monitoring data you collected, you can delete your Log Analytics workspace and the resource group you created for Azure Monitor. Deleting the Log Analytics workspace deletes all data in the workspace and prevents you from incurring other data retention charges.

## Using Microsoft Sentinel with External ID

Once External ID logs from an external tenant are sent to a Log Analytics workspace in a workforce tenant, you can ingest them into Microsoft Sentinel for monitoring, incident rules, alerts, and workbooks. You must configure Sentinel from the workforce tenant, as direct setup from the external tenant isn't supported. To use Sentinel:

1. Send logs to a Log Analytics workspace in a workforce tenant via Azure Monitor diagnostic settings. Direct configuration from the external tenant isn't supported.  

1. In the Azure portal, add Microsoft Sentinel to the Log Analytics workspace. For more information, see [Onboard to Microsoft Sentinel](/azure/sentinel/quickstart-onboard?tabs=defender-portal#add-microsoft-sentinel-to-your-log-analytics-workspace).

1. In the Defender Portal, open the Microsoft Sentinel Content Hub and install the Entra ID content pack.

### Supported features

- **Analytics & Alerts:**  Configure incident rules using prebuilt templates; triggered alerts appear correctly.

- **Workbooks:**  Visualize and analyze collected logs using prebuilt workbooks.

For more information, see the [Microsoft Sentinel Documentation](/azure/sentinel).

These steps enable centralized monitoring, incident management, and visualization for External ID logs while using a supported, workforce-tenant setup.

## Related content

- [Use audit logs and access reviews](/entra/external-id/auditing-and-reporting)
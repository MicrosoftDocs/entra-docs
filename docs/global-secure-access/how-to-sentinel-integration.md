---
title: Integrate Global Secure Access with Microsoft Sentinel
description: Strengthen your organization's security posture by integrating Global Secure Access with Microsoft Sentinel using preconfigured workbooks and analytics rules.
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to
ms.date: 12/17/2025
ms.reviewer: kerenSemel
ai-usage: ai-assisted

#customer intent: As a Microsoft Sentinel user, I want to strengthen my organization's security posture by installing the Global Secure Access solution from the Content hub so that I can use preconfigured workbooks and analytics rules.

---

# Enhance threat detection with Global Secure Access in Microsoft Sentinel

Global Secure Access integrates with Microsoft Sentinel, so organizations can stream network traffic logs, audit logs, and alerts directly into Sentinel. This integration uses Microsoft Entra diagnostic settings and a Global Secure Access content hub package with preconfigured workbooks and analytics rules to enhance security monitoring and visualization. By using this integration, organizations can correlate Global Secure Access data with other Microsoft security services to improve threat detection and response across their environments.

## Prerequisites

To integrate Global Secure Access with Microsoft Sentinel, you need the following configurations and permissions:
- Microsoft Sentinel, enabled on a Log Analytics workspace. For more information, see [create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace).
- Global Secure Access, configured with traffic forwarding profiles such as Microsoft 365, Internet Access, and Private Access.
- A Microsoft Entra ID data connector, configured according to the instructions in [Send data to Microsoft Sentinel using the Microsoft Entra ID data connector](/azure/sentinel/connect-azure-active-directory).
- An active Azure subscription.
- **Microsoft Entra Security Administrator** role to configure diagnostic settings.
- **Microsoft Sentinel Contributor** permissions for the resource group that the workspace belongs to, to install or manage solutions and configure analytics in the content hub.
- **Contributor** permissions for the subscription where the Microsoft Sentinel workspace resides to enable Microsoft Sentinel.

## Configure Microsoft Entra diagnostic settings

To configure Microsoft Entra diagnostic settings so Global Secure Access can stream data to your Log analytics workspace:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Entra ID** > **Monitoring & health** > **Diagnostic settings**. The **General** settings appear by default.
1. Select **Add diagnostic setting** to create a new setting.
1. Enter a **Diagnostic setting name**.
1. In the **Logs** section, select the following **Categories**: 
   - [NetworkAccessTrafficLogs](how-to-view-traffic-logs.md) 
   - [RemoteNetworkHealthLogs](how-to-remote-network-health-logs.md)
   - [NetworkAccessAlerts](concept-alerts.md)
   - [NetworkAccessConnectionEvents](how-to-view-traffic-logs.md)   
1. In the **Destination details** section, select **Send to Log Analytics workspace**.
1. From the **Log Analytics workspace** menu, select your Sentinel workspace. 
1. Select **Save**.   
:::image type="content" source="media/how-to-sentinel-integration/diagnostic-settings.png" alt-text="Screenshot of the Diagnostic setting screen showing the selected log categories and destination details." lightbox="media/how-to-sentinel-integration/diagnostic-settings.png":::

## Install the Global Secure Access solution from the Sentinel Content hub

The Global Secure Access solution includes two workbooks and four analytics rules. To install the solution:

1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
1. Browse to **Microsoft Sentinel** > **Content management** > **Content hub**.
1. To find the **Global Secure Access** solution in the Content hub, enter "Global Secure Access" in the **Search** field.   
:::image type="content" source="media/how-to-sentinel-integration/solution-search-result.png" alt-text="Screenshot of the Global Secure Access solution as a search result." lightbox="media/how-to-sentinel-integration/solution-search-result.png":::

1. Select the Global Secure Access solution. Its description opens.
1. To add the solution to your workspace, select **Install**.   
:::image type="content" source="media/how-to-sentinel-integration/install-solution.png" alt-text="Screenshot of the solution description with the Install button highlighted." lightbox="media/how-to-sentinel-integration/install-solution-expanded.png":::

### Enable enriched Microsoft 365 logs (optional)

Enriched Microsoft 365 logs combine Microsoft 365 OfficeActivity data with Global Secure Access NetworkAccessTraffic logs. This enrichment provides more context such as device ID, operating system, and original IP address to audit events. This extra information is critical for diagnosing issues like blocked access or performance anomalies.

To enable this workbook:

1. Follow the steps in [Configure Microsoft Entra diagnostic settings](#configure-microsoft-entra-diagnostic-settings).
1. In the **Logs** section, select the **OfficeActivity** category.
1. From the **Log Analytics workspace** menu, select the same Sentinel workspace. 
1. Select **Save**.

## Validate the data flow

To validate the data flow from Global Secure Access to Microsoft Sentinel:

1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
1. Browse to **Microsoft Sentinel** > **Configuration** > **Tables**.
1. In the **Tables** view, use filters or search to confirm that the following Sentinel tables are in the workspace: 
- NetworkAccessTraffic 
- NetworkAccessAlerts 
- NetworkAccessConnectionEvents 
- RemoteNetworkHealthLogs 
- OfficeActivity (if you enabled enriched Microsoft 365 logs)   
:::image type="content" source="media/how-to-sentinel-integration/workspace-tables.png" alt-text="Screenshot of the workspace tables showing the Sentinel tables." lightbox="media/how-to-sentinel-integration/workspace-tables.png":::

> [!NOTE]
> Microsoft Sentinel creates tables when it ingests data into the Log Analytics workspace. If there's no data ingestion, the table doesn't exist in the workspace.

### Enable analytics rules

You enable or customize analytics rules from the Global Secure Access solution. For more information, see [Create and manage analytics rules in Microsoft Sentinel](/azure/sentinel/tutorial-detect-threats). 

:::image type="content" source="media/how-to-sentinel-integration/analytics-rules.png" alt-text="Screenshot of Global Secure Access-related analytics rules." lightbox="media/how-to-sentinel-integration/analytics-rules.png":::

Analytics rules can:
- Detect abnormal denials from specific source IPs to destination IP addresses.
- Detect a source IP scanning for open ports.
- Detect changes in the protocol used for specific destination ports.
- Detect connections that occur outside the defined operational hours.


### View the preconfigured workbooks

The Global Secure Access solution includes two workbooks: **Enhanced Microsoft 365 logs** and **Network Traffic Insights**. To view a workbook dashboard:
1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
1. Browse to **Microsoft Sentinel** > **Content management** > **Content hub**.
1. In the **Content hub**, expand the **Global Secure Access** solution.
1. Select one of the preconfigured workbooks.
1. Select **View Template**. The workbook dashboard opens.

:::image type="content" source="media/how-to-sentinel-integration/workbook-dashboard.png" alt-text="Screenshot of the Network Traffic Insights dashboard showing a graph of usage over time." lightbox="media/how-to-sentinel-integration/workbook-dashboard-expanded.png":::

## Related content

- [What is Microsoft Sentinel?](/azure/sentinel/overview)
- [Configure Microsoft Entra diagnostic settings for activity logs](../identity/monitoring-health/howto-configure-diagnostic-settings.md)
- [Microsoft Sentinel in the Microsoft Defender portal](/azure/sentinel/microsoft-sentinel-defender-portal)
- [Create and manage analytics rules in Microsoft Sentinel](/azure/sentinel/tutorial-detect-threats)

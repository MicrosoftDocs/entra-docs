---
title: Global Secure Access network traffic logs
description: Learn how to use Global Secure Access traffic logs (preview) to monitor connections to the service, the type of traffic, and who's connecting.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 03/06/2024
ms.service: global-secure-access

#Customer intent: As an IT admin, I want to understand what information the Global Secure Access traffic logs (preview) capture so I can better monitor traffic and connections to our services.

---

# How to use the Global Secure Access traffic logs (preview)

Monitoring the traffic for Global Secure Access is an important activity for ensuring your tenant is configured correctly and that your users are getting the best experience possible. The Global Secure Access traffic logs (preview) provide insight into who is accessing what resources, where they're accessing them from, and what action took place.

This article describes how to use the traffic logs for Global Secure Access.

## Prerequisites 

- A **Global Secure Access Administrator** role in Microsoft Entra ID.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## How the traffic logs work

The Global Secure Access logs provide details of your network traffic. To better understand those details and how you can analyze those details to monitor your environment, it's helpful to look at the three levels of the logs and their relationship to each other.

A user accessing a website represents one *session*, and within that session there may be multiple *connections*, and within that connection there may be multiple *transactions*.

- **Session**: A session is identified by the first URL a user accesses. That session could then open many connections, for example a news site that contains multiple ads from several different sites.
- **Connection**: A connection includes the source and destination IP, source and destination port, and fully qualified domain name (FQDN). The connection components comprise the 5 tuple.
- **Transaction**: A transaction is a unique request and response pair.

Within each log instance, you can see the connection ID and transaction ID in the details. By using the filters, you can look at all connections and transactions for a single session.

## How to view the traffic logs

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](/azure/active-directory/roles/permissions-reference#reports-reader).
1. **Global Secure Access** > **Monitor** > **Traffic logs**.

The top of the page displays a summary of all transactions as well as a breakdown for each type of traffic. Select the **Microsoft 365** or **Private access** buttons to filter the logs to each traffic type.

> [!NOTE]
> At this time, Session ID information is not available in the log details.

### View the log details

Select any log from the list to view the details. These details provide valuable information that can be used to filter the logs for specific details or to troubleshoot a scenario. The details can be added as a column and used to filter the logs.

![Screenshot of the traffic log activity details.](media/how-to-view-traffic-logs/traffic-activity-details.png)

### Filter and column options

The traffic logs can provide many details, so to start only some columns are visible. Enable and disable the columns based on the analysis or troubleshooting tasks you're performing, as the logs could be difficult to view with too many columns selected. The column and filter options align with each item in the Activity details.

Select **Columns** from the top of the page to change the columns that are displayed. 

To filter the traffic logs to a specific detail, select the **Add filter** button and then enter the detail you want to filter by.

For example if you want to look at all the logs from a specific connection:

1. Select the log detail and copy the `connectionId` from the Activity details.
1. Select **Add filter** and choose **Connection ID**. 
1. In the field that appears, paste the `connectionId` and select **Apply**.

    ![Screenshot of the traffic log filter.](media/how-to-view-traffic-logs/traffic-log-filter.png)

### Troubleshooting scenarios

The following details may be helpful for troubleshooting and analysis:

- If you're interested in the size of the traffic being sent and received, enable the **Sent Bytes** and **Received Bytes** columns. Select the column header to sort the logs by the size of the logs.
- If you are reviewing the network activity for a risky user, you can filter the results by user principal name and then review the sites they're accessing.
- To look for traffic to the types of websites that you want to block or allow, enable the **Web category** column.

The log details provide valuable information about your network traffic. Not all details are defined in the list below, but the following details are useful for troubleshooting and analysis:

- **Transaction ID**: Unique identifier representing the request/response pair.
- **Connection ID**: Unique identifier representing the connection that initiated the log.
- **Device category**: Device type where the transaction initiated from. Either **client** or **remote network**.
- **Action**: The action taken on the network session. Either **Allowed** or **Denied**.

## Configure diagnostic settings to export logs

You can export the Global Secure Access traffic logs (preview) to an endpoint for further analysis and alerting. This integration is configured in Microsoft Entra diagnostic settings.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](/azure/active-directory/roles/permissions-reference#security-administrator).
1. Browse to **Identity** > **Monitoring & health** > **Diagnostic settings**.
1. Select **Add Diagnostic setting**.
1. Give your diagnostic setting a name.
1. Select `NetworkAccessTrafficLogs`.
1. Select the **Destination details** for where you'd like to send the logs. Choose any or all of the following destinations. Additional fields appear, depending on your selection.

    * **Send to Log Analytics workspace:** Select the appropriate details from the menus that appear.
    * **Archive to a storage account:** Provide the number of days you'd like to retain the data in the **Retention days** boxes that appear next to the log categories. Select the appropriate details from the menus that appear.
    * **Stream to an event hub:** Select the appropriate details from the menus that appear.
    * **Send to partner solution:** Select the appropriate details from the menus that appear.



## Next steps

- [Learn about the traffic dashboard](concept-traffic-dashboard.md)
- [View the audit logs for Global Secure Access](how-to-access-audit-logs.md)
- [View the enriched Microsoft 365 logs](how-to-view-enriched-logs.md)

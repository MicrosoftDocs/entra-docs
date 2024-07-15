---
title: Global Secure Access logs and monitoring
description: Learn about the available Global Secure Access logs and monitoring options.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: conceptual
ms.date: 04/18/2024
ms.service: global-secure-access
---

# Global Secure Access logs and monitoring

As an IT administrator, you need to monitor the performance, experience, and availability of the traffic flowing through your networks. Within the Global Secure Access logs there are many data points that you can review to gain insights into your network traffic. This article describes the logs and dashboards that are available to you and some common monitoring scenarios.

## Dashboard

The Global Secure Access dashboard provides you with visualizations of the traffic flowing through the Microsoft Entra Private Access and Microsoft Entra Internet Access services, which include Microsoft traffic and Private Access traffic. The dashboard provides a summary of the data related to product deployment and insights. Within these categories you can see the number of users, devices, and applications seen in the last 24 hours. You can also see device activity and cross-tenant access.

For more information, see [Global Secure Access dashboard](concept-traffic-dashboard.md).

## Audit logs (preview)

The Microsoft Entra audit log is a valuable source of information when researching or troubleshooting changes to your Microsoft Entra environment. Changes related to Global Secure Access are captured in the audit logs in several categories, such as filtering policy, forwarding profiles, remote network management, and more.

For more information, see [Global Secure Access audit logs (preview)](how-to-access-audit-logs.md).

## Traffic logs (preview)

The Global Secure Access traffic logs provide a summary of the network connections and transactions that are occurring in your environment. These logs look at *who* accessed *what* traffic from *where* to *where* and with what *result*. The traffic logs provide a snapshot of all connections in your environment and breaks that down into traffic that applies to your traffic forwarding profiles. The logs details provide the traffic type destination, source IP, and more.

For more information, see [Global Secure Access traffic logs (preview)](how-to-view-traffic-logs.md).

## Enriched Office 365 logs (preview)

The *Enriched Office 365 logs* provide you with the information you need to gain insights into the performance, experience, and availability of the Microsoft 365 apps your organization uses. You can integrate the logs with a Log Analytics workspace or third-party SIEM tool for further analysis.

Customers use existing *Office Audit logs* for monitoring, detection, investigation, and analytics. We understand the importance of these logs and have partnered with Microsoft 365 to include SharePoint logs. These enriched logs include details like client information and original public IP details that can be used for troubleshooting security scenarios.

For more information, see [Enriched Office 365 logs](how-to-view-enriched-logs.md).

## Log Retention and Storage

**Traffic Logs and Remote Network Health Logs:** These logs are retained within the system for 30 days. This duration allows for ample time to review and analyze recent activities and network health status.

**Audit Logs:** The retention period for Audit Logs varies depending on your Microsoft Entra ID license. The table provides e breakdown:

|Report Type	| Microsoft Entra ID Free	| Microsoft Entra ID P1	| Microsoft Entra ID P2 |
|----------|-----------|------------|------------|
|Audit Logs |	Seven days | 30 days | 30 days |

**Office Logs:** Office Logs are maintained for a shorter duration, up to only 24 hours. 

**Exporting and Storing Logs for Longer Durations:** As a customer, you have the flexibility to export these logs through the diagnostic settings feature. Exporting logs allows you to maintain records for more extended periods beyond the default retention times. This can be crucial for compliance, auditing, and in-depth analysis purposes. 

## Next steps

- [Learn how to access, store, and analyze activity logs](/azure/active-directory/reports-monitoring/howto-access-activity-logs)

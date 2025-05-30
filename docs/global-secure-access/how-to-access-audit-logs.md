---
title: How to access Global Secure Access audit logs (preview)
description: Learn how to access, archive, and analyze the audit logs for Microsoft's Security Service Edge solution.
author: kenwith
ms.author: kenwith
manager: femila
ms.topic: how-to
ms.date: 02/21/2025
ms.service: global-secure-access
ai-usage: ai-assisted

#Customer intent: As an IT admin, I need to view the logs specific to network access so I can better manage the solution.

---

# How to access the Global Secure Access audit logs (preview)

The Microsoft Entra audit logs are a valuable source of information when investigating or troubleshooting changes to your Microsoft Entra environment. Changes related to Global Secure Access are captured in the audit logs in several categories, such as traffic forwarding profiles, remote network management, and more. This article describes how to use the audit log to track changes to your Global Secure Access environment.

## Prerequisites

To access the audit log for your tenant, you must have one of the following roles: 

- Reports Reader
- Security Reader
- Security Administrator

Audit logs are available in [all editions of Microsoft Entra](/azure/active-directory/reports-monitoring/concept-audit-logs). Storage and integration with analysis and monitoring tools may require additional licenses and roles.

## Access the audit logs

There are several ways to view the audit logs. For more information on the options and recommendations for when to use each option, see [How to access activity logs](/azure/active-directory/reports-monitoring/howto-access-activity-logs).

### Access audit logs from the Microsoft Entra admin center

You can access the audit logs from **Global Secure Access** and from **Microsoft Entra ID Monitoring & health**.

**From Global Secure Access:**
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) using one of the required roles.
1. Browse to **Global Secure Access** > **Monitor** > **Audit logs**. The filters are pre-populated with the categories and activities related to Global Secure Access.

**From Microsoft Entra monitoring and health:**
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) using one of the required roles.
1. Browse to **Entra ID** > **Monitoring & health** > **Audit logs**.
1. Select the **Date** range you want to query.
1. Open the **Service** filter, select **Global Secure Access**, and select **Apply**.
1. Open the **Category** filter, select at least one of the available options, and select **Apply**.

## Save audit logs

Audit log data is only kept for 30 days by default, which may not be long enough for every organization. You may also want to integrate your logs with other services for enhanced monitoring and analysis if you need to view or query logs after 30 days.

- [Stream activity logs to an event hub](/azure/active-directory/reports-monitoring/tutorial-azure-monitor-stream-logs-to-event-hub) to integrate with other tools, like Azure Monitor or Splunk.
- [Export activity logs for storage](/azure/active-directory/reports-monitoring/quickstart-azure-monitor-route-logs-to-storage-account).
- [Monitor activity in real-time with Microsoft Sentinel](/azure/sentinel/quickstart-onboard).



## Next steps

- [View network traffic logs](how-to-view-traffic-logs.md)
- [Access the enriched Microsoft 365 logs](how-to-view-enriched-logs.md)

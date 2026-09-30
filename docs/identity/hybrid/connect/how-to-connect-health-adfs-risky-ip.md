---
title: Microsoft Entra Connect Health with the AD FS Risky IP report
description: This article describes the Microsoft Entra Connect Health AD FS Risky IP report.
ms.reviewer: zhiweiwangmsft
ms.subservice: hybrid-connect
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 09/10/2026
ms.custom: H1Hack27Feb2017
---

# The Risky IP report 

Active Directory Federation Services (AD FS) customers may expose password authentication endpoints to the internet to provide authentication services for end users to access SaaS applications such as Microsoft 365. 

It's possible for a bad actor to attempt logins against your AD FS system to guess an end user’s password and get access to application resources. As of Windows Server 2012 R2, AD FS provides the extranet account lockout functionality to prevent these types of attacks. If you're on an earlier version, we strongly recommend that you upgrade your AD FS system to Windows Server 2016.

Additionally, it's possible for a single IP address to attempt multiple logins against multiple users. In these cases, the number of attempts per user might be under the threshold for account lockout protection in AD FS. 

Microsoft Entra Connect Health now provides the *Risky IP report*, which detects this condition and notifies administrators. Here are the key benefits of using this report: 

- Detects IP addresses that exceed a threshold of failed password-based logins
- Supports failed logins resulting from bad password or extranet lockout state
- Provides email notifications to alert administrators, with customizable email settings
- Provides customizable threshold settings that match the security policy of an organization
- Provides downloadable reports for offline analysis and integration with other systems via automation

> [!NOTE]
> To use this report, you must ensure that AD FS auditing is enabled. For more information, see [Enable auditing for AD FS](how-to-connect-health-adfs.md#enable-auditing-for-ad-fs).
>
> To access this preview release, you need [Security Reader](~/identity/role-based-access-control/permissions-reference.md#security-reader) permissions.  

## What's in the report?

The failed sign-in activity client IP addresses are aggregated through Web Application Proxy servers. Each item in the Risky IP report shows aggregated information about failed AD FS sign-in activities that have exceeded the designated threshold. 

The report provides the following information:

| Report&nbsp;item | Description |
| ------- | ----------- |
| Time Stamp | The time stamp that's based on [Microsoft Entra admin center](https://entra.microsoft.com) local time when the detection time window starts.<br> All daily events are generated at midnight UTC time. <br>Hourly events have the time stamp rounded to the beginning of the hour. You can find the first activity start time from “firstAuditTimestamp” in the exported file. |
| Trigger Type | The type of detection time window. The aggregation trigger types are per hour or per day. They're helpful in differentiating between a high-frequency brute force attack and a slow attack, where the number of attempts is distributed throughout the day. |
| IP Address | The single risky IP address that had either bad password or extranet lockout sign-in activities. It can be either an IPv4 or an IPv6 address. |
| Bad Password Error Count | The count of bad password errors that occur from the IP address during the detection time window. Bad password errors can happen multiple times to certain users. **Note**: This count doesn't include failed attempts resulting from expired passwords. |
| Extranet Lockout Error Count | The count of extranet lockout errors that occur from the IP address during the detection time window. The extranet lockout errors can happen multiple times to certain users. This count is displayed only if Extranet Lockout is configured in AD FS (versions 2012R2 and later). **Note**: We strongly recommend enabling this feature if you allow extranet logins that use passwords. |
| Unique Users Attempted | The count of unique user accounts that are attempted from the IP address during the detection time window. Differentiates between a single user attack pattern and a multi-user attack pattern. |

> [!NOTE]
> - Only activities that exceed the designated threshold are displayed in the report list. 
> - This report tracks the past 30 days at most.
> - This alert report doesn't show Exchange IP addresses or private IP addresses. They are still included in the export list. 

Open [Microsoft Entra Connect Health](https://aka.ms/aadconnecthealth), select **AD FS services**, select a service, and then select the **Risky IP Addresses** report. The command bar provides **Refresh**, **Download Manager**, **Notification Settings**, and **Threshold Settings**.

> [!IMPORTANT]
> The Risky IP report is being deprecated. The page provides a link to the newer [Risky IP report workbook](how-to-connect-health-adfs-risky-ip-workbook.md), which supports customizable queries and expanded visualizations.

:::image type="content" source="media/how-to-connect-health-adfs-risky-ip/connect-health-bad-internet-protocol-addresses.png" alt-text="Screenshot of the Connect Health bad IP addresses report with callouts for the workbook migration notice, report actions, and results table." lightbox="media/how-to-connect-health-adfs-risky-ip/connect-health-bad-internet-protocol-addresses.png":::

## Load balancer IP addresses in the list

Your load balancer aggregate might have failed, causing it to hit the alert threshold. If you're seeing load balancer IP addresses, it's highly likely that your external load balancer isn't sending the client IP address when it passes the request to the Web Application Proxy server. Configure your load balancer correctly to pass forward the client IP address. 

## Download the Risky IP report 

Select **Download Manager** to review the three most recent export requests or request **Download latest report**. Export requests are limited to one per hour. A completed request provides a link to the risky IP address list from the past 30 days. The export includes all failed AD FS sign-in activities in each detection time window so that you can customize filtering offline. It also includes the following details:

| Report Item | Description | 
| ------- | ----------- | 
| firstAuditTimestamp | The first time stamp when the failed activities started during the detection time window. | 
| lastAuditTimestamp | The last time stamp when the failed activities ended during the detection time window. | 
| attemptCountThresholdIsExceeded | The flag if the current activities are exceeding the alerting threshold. | 
| isWhitelistedIpAddress | The flag if the IP address is filtered from alerting and reporting. Private IP addresses (*10.x.x.x, 172.x.x.x* and *192.168.x.x*) and Exchange IP addresses are filtered and marked as *True*. If you're seeing private IP address ranges, it's highly likely that your external load balancer isn't sending the client IP address when it passes the request to the Web Application Proxy server. | 

## Configure notification settings

Select **Notification Settings** to update the report's administrator contacts. By default, the risky IP alert email notification is in an *off* state. You can enable **Get email notifications for IP addresses exceeding failed activity threshold report**.

The panel also lets you enable notifications for new service alerts, notify all Global Administrators, and manage custom email recipients.

## Configure threshold settings

Select **Threshold Settings** to update the alerting thresholds. The system default values are described in the following table.

The risk IP report threshold settings are separated into four categories.

| Threshold setting | Description |
| --- | --- |
| (Bad U/P + Extranet Lockout) / Day | Reports the activity and triggers an alert notification when the count of Bad Password plus the count of Extranet Lockout exceeds the threshold, per *day*. The default value is 100.|
| (Bad U/P + Extranet Lockout) / Hour | Reports the activity and triggers an alert notification when the count of Bad Password plus the count of Extranet Lockout exceeds the threshold, per *hour*. The default value is 50.|
| Extranet Lockout / Day | Reports the activity and triggers an alert notification when the count of Extranet Lockout exceeds the threshold, per *day*. The default value is 50.|
| Extranet Lockout / Hour | Reports the activity and triggers an alert notification when the count of Extranet Lockout exceeds the threshold, per *hour*. The default value is 25.|

> [!NOTE]
> - The change of the report threshold will be applied an hour after the setting change. 
> - Existing reported items will not be affected by the threshold change. 
> - We recommend that you analyze the number of events reported within your environment and adjust the threshold appropriately. 
>
>

## FAQ

**Why am I seeing private IP address ranges in the report?**

Private IP addresses (*10.x.x.x, 172.x.x.x* and *192.168.x.x*) and Exchange IP addresses are filtered and marked as *True* in the IP approved list. If you're seeing private IP address ranges, it's highly likely that your external load balancer isn't sending the client IP address when it passes the request to the Web Application Proxy server.

**Why am I seeing load balancer IP addresses in the report?**

If you're seeing load balancer IP addresses, it's highly likely that your external load balancer isn't sending the client IP address when it passes the request to the Web Application Proxy server. Configure your load balancer correctly to pass forward the client IP address. 

**How can I block the IP address?**

You should add the identified malicious IP address to the firewall or block it in Exchange.

**Why can't I see any items in this report?**

- Failed sign-in activities aren't exceeding the threshold settings.
- Ensure that no “Health service isn't up to date” alert is active in your AD FS server list. Read more about [how to troubleshoot this alert](how-to-connect-health-data-freshness.md).
- Audits aren't enabled in AD FS farms.

**Why can't I access the report?**

You need to have [Security Reader](~/identity/role-based-access-control/permissions-reference.md#security-reader) permissions. 

## Next steps
* [Microsoft Entra Connect Health](./whatis-azure-ad-connect.md)
* [Microsoft Entra Connect Health agent installation](how-to-connect-health-agent-install.md)

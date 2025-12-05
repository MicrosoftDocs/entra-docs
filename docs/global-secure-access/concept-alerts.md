---
title: Learn about Global Secure Access Alerts
description: "Learn how "
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: overview
ms.date: 12/04/2025
manager: dougeby
ms.reviewer: kerenSemel

#customer intent: As an IT admin, I want to 

---

# What are Global Secure Access alerts?
Global Secure Access alerts provide real-time notifications about potential security issues and operational concerns within your organization's network. Alerts include details about severity, related MITRE techniques, provider information, and related entities.

Alerts provide visibility into activities, threats, and entities of interest such as users, devices, and applications. Alerts offer operational insights to resolve deployment and health issues. They also deliver security insights from detections and related activities, strengthening your overall security posture. 

The Global Secure Access alert structure aligns with the [Microsoft Sentinel security alert schema](/azure/sentinel/security-alert-schema), enabling a smooth integration with [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender).

With alerts, Global Secure Access admins can:
- View statistics on alert types and severity.
- Investigate alerts and related data using filters and linked information.
- Export alerts for use with security information and event management (SIEM) tools or other solutions.

## Types of alerts
Global Secure Access includes the following types of alerts:

### Token/Device Inconsistency Alert
Checks if the same access token is used on more than one device.

### Increased External Tenant Activity
Checks for an unusual rise in activity with external tenants. This alert looks at a 14-day sliding window, with access to tenants other  than the home tenant. 

###	Unhealthy Remote Networks
Alerts on deficiencies in remote network availability - checks hourly if there were remote network health events with operation BGPDisconnect or TunnelDisconnect

### Netskope alerts
These alerts require the Netskope ATP & DLP module in Global Secure Access. They include:
- Threat Protection: raised when malware or suspicious content is detected.
- Data Loss Prevention: triggered when sensitive data matches a DLP profile 
- Fallback Alerts: Occur when Netskope cannot process traffic due to conditions like file size limits, timeouts, or unsupported file types.

## View alerts
To view Global Secure Access alerts: 
1. Navigate to 
1. Select **Alerts**. 

You can filter and sort alerts based on severity, date, and type to quickly identify and respond to potential security issues.





## Related content
- 

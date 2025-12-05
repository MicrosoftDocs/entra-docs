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
Global Secure Access alerts provide real-time notifications about potential security issues and operational concerns within your organization's network. Alerts include details including severity, related MITRE techniques, provider information, and related entities. 

## Alert structure
Alerts provide visibility into activities, threats and entities of interest, such as users, devices, and applications. They offer operational insights to address issues related to deployment status and health, and deliver security insights from detections and relevant activities, enhancing the overall security posture. The Global Secure Access alert structure aligns with the [Microsoft Sentinel security alert schema](/azure/sentinel/security-alert-schema), enabling a smooth integration with [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender).

### Token/Device Inconsistency Alert
Checks if same access token is used on more than one device.

### Increased External Tenant Activity
Alerts on an unusual rise in activity with external tenants looking on 14 days sliding window (access to tenants different then the home tenant). 

###	Unhealthy Remote Networks
Alerts on deficiencies in remote network availability - checks hourly if there were remote network health events with operation BGPDisconnect or TunnelDisconnect

### Netskope alerts
These alerts require the Netskope ATP & DLP module in Global Secure Access. They include:
- Threat Protection: raised when malware or suspicious content is detected.
- Data Loss Prevention: triggered when sensitive data matches a DLP profile 
- Fallback Alerts: Occur when Netskope cannot process traffic due to conditions like file size limits, timeouts, or unsupported file types.

## View alerts
To view Global Secure Access alerts: 
1. Navigate to the [Global Secure Access portal](https://portal.globalsecureaccess.microsoft.com).
1. Select **Alerts**. 

You can filter and sort alerts based on severity, date, and type to quickly identify and respond to potential security issues.





## Related content
- 

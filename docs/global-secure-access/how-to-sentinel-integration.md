---
title: Integrate Global Secure Access with Microsoft Sentinel
description: "[Article description]."
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to
ms.date: 08/25/2025
manager: dougeby
ms.reviewer: kerenSemel
ai-usage: ai-assisted

#customer intent: As a <role>, I want <what> so that <why>.

---

# Integrate Global Secure Access with Microsoft Sentinel

Global Secure Access now integrates with Microsoft Sentinel, enabling organizations to stream network traffic logs, audit logs, and alerts directly into Sentinel. This integration leverages Entra diagnostic settings and a Global Secure Access content hub package with pre-configured workbooks and analytics rules to enhance security monitoring and visualization. Through this connection, organizations can correlate Global Secure Access data with other Microsoft security services to improve threat detection and response across their environments.

## Prerequisites

To integrate Global Secure Access with Microsoft Sentinel, you must have:
- A Microsoft Entra Security Administrator role to configure diagnostic settings.
- A Microsoft Sentinel Contributor role to install solutions and configure analytics.
- A Microsoft Sentinel Playbook Operator role for automation workflows.
- Global Secure Access, configured with Traffic Forwarding Profiles, such as Microsoft 365, Internet Access, and Private Access.
- Microsoft Sentinel, enabled on a Log Analytics workspace.

## Configure Microsoft Entra diagnostic settings

To configure Microsoft Entra diagnostic settings so Global Secure Access can stream data in your Log analytics workspace:

1. Navigate to Identity → Monitoring & Health → Diagnostic Settings. 
1. Click Add Diagnostic Setting. 
1. Select Log Categories: 
   - NetworkAccessTrafficLogs 
   - NetworkAccessConnectionEvents 
   - NetworkAccessAlerts 
   - RemoteNetworkHealthLogs 
1. Destination: Send to Log Analytics workspace (select your Sentinel workspace) 
1. Save.

## Install the Global Secure Access solution from the Sentinel Content hub

1. In the Microsoft Sentinel portal, go to the Content hub.
1. Search for the Global Secure Access solution.
1. Click Install to add the solution to your workspace.
1. 

## Validate the data flow

1. In Sentinel, confirm tables (Azure -> Microsoft Sentinel -> Logs or Defender -> Microsoft Sentinel -> configuration->tables):  

- NetworkAccessTraffic 
- NetworkAccessAlerts 
- NetworkAccessConnectionEvents 
- RemoteNetworkHealthLogs 
- OfficeActivity (if enrichment enabled) 

Note: tables are created when data is ingested into the Log Analytics workspace. If there is no data ingestion, the table will not exist in the workspace. 

1. Configure & Save 

    1. Enable or customize analytics rules from the GSA solution 
    1. View and save or customized Workbooks  

## Related content

- [What is Microsoft Sentinel?](/azure/sentinel/overview)
- Related article title

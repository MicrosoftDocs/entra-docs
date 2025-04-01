---
title: "Troubleshoot the Global Secure Access Mobile Client: Advanced Diagnostics"
description: Troubleshoot the Global Secure Access mobile client using the advanced diagnostics utility.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 03/31/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: femila
ms.reviewer: cagautham



# Customer intent: I want to troubleshoot the Global Secure Access mobile client using the Advanced diagnostics utility.
---
# Troubleshoot the Global Secure Access mobile client: Advanced diagnostics
This document provides troubleshooting guidance for the Global Secure Access mobile client for both Android and iOS. It explores each option in the Advanced diagnostics utility.

## Introduction
The Global Secure Access client runs in the background and routes relevant network traffic to Global Secure Access. It doesn't require user interaction. The advanced diagnostics tool makes the client's behavior visible to the administrator and helps with troubleshooting.

## Launch the advanced diagnostics tool
To launch the advanced diagnostics tool:
1. Launch the Microsoft Defender app and select the **Global Secure Access client** tile.   
1. Tap the **Global Secure Access** icon five times to enable **Troubleshooting**.   
1. Select **Advanced diagnostics**.   

## Services option   
The Services option shows the list of current, active services that are set as part of the forwarding profiles. The tab contains the following information: 

## Troubleshooting option   
The Troubleshooting option enables users with multiple options to troubleshoot and share information with the administrator.  

### Collect and send logs   
This option allows users to collect logs from the client and send to Microsoft support for investigation. On sending logs, user gets an Incident ID on the screen which can be shared with the Microsoft support for reference. To navigate: 
1. Go to **MSDefender** > **Global Secure Access** > **Troubleshooting** > **Collect and send logs**. 

:::image type="content" source="media/troubleshoot-global-secure-access-mobile-client-advanced-diagnostics/___.png" alt-text="Screenshot of [].":::

### Advanced diagnostics   
This option lists insights on the health of the client and utility for capturing Network and HOSTNAME traffic. To navigate:
1. Go to **MSDefender** > **Global Secure Access** > **Troubleshooting** > **Advanced diagnostics**. 

:::image type="content" source="media/troubleshoot-global-secure-access-mobile-client-advanced-diagnostics/___.png" alt-text="Screenshot of []."::: 

## Health Check option 
The **Health Check** option under Advanced diagnostics executes common tests to verify that the client works correctly and that its components are running. Select **Refresh Health Check** to view the updated test status. To navigate:
1. Go to MSDefender > Global Secure Access > Troubleshooting > Advanced diagnostics > Health Check. 

:::image type="content" source="media/troubleshoot-global-secure-access-mobile-client-advanced-diagnostics/___.png" alt-text="Screenshot of []."::: 

### Network and hostname traffic 
Using this option, the user can capture network and hostname traffic. We recommend that users start the traffic capture, reproduce the issue, and then stop the capture. Users can review the captured traffic by clicking on the **NETWORK** and **HOSTNAME** tabs. User can then use the DOWNLOAD option to get the captured traffic to share with Microsoft Support. To navigate:
1. Go to MSDefender >  Global Secure Access > Troubleshooting > Advanced diagnostics > Network and hostname traffic.

:::image type="content" source="media/troubleshoot-global-secure-access-mobile-client-advanced-diagnostics/___.png" alt-text="Screenshot of []."::: 

## Related content
* Troubleshoot the Global Secure Access Client for Windows: Advance Diagnostics

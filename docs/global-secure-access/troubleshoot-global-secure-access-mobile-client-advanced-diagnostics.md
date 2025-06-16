---
title: "Troubleshoot the Global Secure Access Mobile Client: Advanced Diagnostics"
description: Discover how to use advanced diagnostics to resolve issues with the Global Secure Access mobile client for Android and iOS.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 04/29/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: cagautham
ai-usage: ai-assisted


# Customer intent: I want to troubleshoot the Global Secure Access mobile client using the Advanced diagnostics utility.
---
# Troubleshoot the Global Secure Access mobile client: Advanced diagnostics
This article explains how to troubleshoot the Global Secure Access mobile client for Android and iOS using the advanced diagnostics utility.

## Introduction
The Global Secure Access client runs in the background and routes relevant network traffic to Global Secure Access. It doesn't require user interaction. The advanced diagnostics tool makes the client's behavior visible to the administrator and helps with troubleshooting.

## Services section   
The **Services** section shows the active services running in the traffic forwarding profiles.

:::image type="content" source="media/troubleshoot-global-secure-access-mobile-client-advanced-diagnostics/services-section.png" alt-text="Screenshot of the Services section in the Global Secure Access mobile client.":::

## Troubleshooting section      
The Troubleshooting section enables users to troubleshoot and share information with the administrator. To view the **Troubleshooting** section:
1. Open the Microsoft Defender app and select the **Global Secure Access client** tile.   
1. Select the **Troubleshooting** section to open it.   

In addition to **Get latest policy** and **Clear cached data**, users can also [collect and send logs](#collect-and-send-logs) and [run advanced diagnostics](#advanced-diagnostics).    

### Collect and send logs   
This troubleshooting function allows users to collect logs from the client and send the logs to Microsoft support for investigation. To access the **Collect and send logs** function: 
1. Open the Microsoft Defender app and select the **Global Secure Access client** tile.
1. Expand the **Troubleshooting** section and select **Collect and send logs**. 

The user can copy and share the Incident ID with Microsoft Support for their reference.

:::image type="content" source="media/troubleshoot-global-secure-access-mobile-client-advanced-diagnostics/incident-id.png" alt-text="Screenshot of a sample pop-up Incident ID message.":::

### Advanced diagnostics   
This troubleshooting function shows the client's health and lets users capture network and hostname traffic. To access the **Advanced diagnostics** function:
1. Open the Microsoft Defender app and select the **Global Secure Access client** tile.
1. Expand the **Troubleshooting** section and select **Advanced diagnostics**. 

#### Health Check tests 
The **Health Check** runs a series of device and policy tests to verify that the client and its components are working correctly. To run the health check:
1. Navigate to the **Advanced diagnostics** view.
1. Select **Health Check**. 

To update the health check status, select **Refresh Health Check**.   

:::image type="content" source="media/troubleshoot-global-secure-access-mobile-client-advanced-diagnostics/refresh-health-check.png" alt-text="Screenshot of the Health Check view showing that the completed device and policy tests passed."::: 

#### Network and hostname traffic 
This function allows users to capture information about their network and hostname traffic. A good practice is to start the traffic capture, reproduce the issue, and then stop the capture. To capture network and hostname traffic:
1. Navigate to the **Advanced diagnostics** view.
1. Select **Network and hostname traffic**.
1. Select **START**.
1. Reproduce the issue.
1. Select **STOP** to stop capturing network and hostname traffic.   

To review the captured traffic, go to the **NETWORK** and **HOSTNAME** tabs.   

To download the captured traffic to share with Microsoft Support, select **DOWNLOAD**.   

:::image type="content" source="media/troubleshoot-global-secure-access-mobile-client-advanced-diagnostics/network-host-name.png" alt-text="Screenshot of Network and hostname traffic view showing a list of sample network traffic."::: 

## Related content
* [Troubleshoot the Global Secure Access Client for Windows: Advanced Diagnostics](troubleshoot-global-secure-access-client-advanced-diagnostics.md)

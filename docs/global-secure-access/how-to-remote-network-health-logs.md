---
title: How to use the remote network health logs
description: Learn how to check the health of your remote networks with the Global Secure Access remote network health logs.
author: shlipsey3
ms.author: sarahlipsey
manager: amycolannino
ms.topic: how-to
ms.date: 11/01/2023
ms.service: network-access
ms.custom: 
ms.reviewer: katabish

# Customer intent: As a network admin, I want to be able to check the health of my remote networks so that I can troubleshoot issues and make improvements to my configurations.

---

# What are remote network health logs?

Remote networks such as a branch office rely on customer premises equipment (CPE) to connect users in those locations to the online resources and services they need. Users expect that CPE to function so they can do their work.

To keep everyone connected, you need to ensure the health of the IPSec tunnel and the BGP route advertisement. This long-running tunnel and routing information are the keys to your remote network health.

## Prerequisites

To view the Remote network health logs, you need:

- One of the following roles: Global Reader, Global Secure Access Administrator, Security Administrator or Global Administrator.
- The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## How to access the logs

To view the **Remote network health logs**, you can use either the Microsoft Entra admin center or the Microsoft Graph API.

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center) 

To view Remote network health logs in Microsoft Entra admin Center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Reader](/azure/active-directory/roles/permissions-reference#global-reader).
1. Browse to **Global Secure Access (preview)** > **Monitor** > **Remote network health logs**.

    ![Screenshot of the Remote network health logs.](media/how-to-remote-network-health-logs/remote-network-health-logs.png)

### [Microsoft Graph API](#tab/microsoft-graph-api)

Global Secure Access remote network health logs can be viewed and managed using Microsoft Graph on the `/beta` endpoint.

1. Sign in to [Graph Explorer](https://aka.ms/ge).
1. Select GET as the HTTP method.
1. Select BETA as the API version.
1. Run the following query:

```http
GET https://graph.microsoft.com/beta/networkAccess/logs/remotenetworks
```

**Response:**

```json
{
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#networkAccess/logs/remoteNetworks",
  "@odata.nextLink": "https://graph.microsoft.com/beta/networkAccess/logs/remotenetworks?$skiptoken=a0850fa33aecaf5fc7240fdd13929d25cc2ffbaa9e985c2fd3787a9283ba28c0",
  "@microsoft.graph.tips": "Use $select to choose only the properties your app needs, as this can lead to performance improvements. For example: GET networkAccess/logs/remoteNetworks?$select=bgpRoutesAdvertisedCount,createdDateTime",
  "value": [
  ]
}
```

---

## How to analyze the logs

Logs can be downloaded for long-term storage. You can download logs as a JSON or CSV file. For more information, see [How to download logs](~/identity/monitoring-health/howto-download-logs.md).

To narrow down the results of the logs, select **Add filter**. You can filter by:

- Description
- Remote network ID
- Source IP
- Destination IP
- BDP routes advertised count

The following table describes each of the fields in the Remote network health logs.

| Name | Description |
| -- | -- |
| Created date time | Time of original event generation |
| Source IP Address | The IP address of the CPE.</br> The Source IP/Destination IP address pair will be unique for each IPsec tunnel. |
| Destination IP Address | The IP address of the Microsoft Entra gateway.</br> The Source IP/Destination IP address pair will be unique for each IPsec tunnel. |
| Status | 5 possible values:</br> **TunnelConnect:** This event is generated when an IPsec tunnel is successfully established.</br> **TunnelDisconnect:** This event is generated when an IPsec tunnel is disconnected.</br> **BGPConnect:** This event is generated when an BGP connectivity is successfully established.</br> **BGPDisconnect:** This event is generated when an BGP connectivity goes down.</br> **Alive:** This is a periodic statistics generated every 15 minutes for all the active tunnels. |
| Description | Optional description of the event. |
| BGP Routes Advertised Count | Optional count of BGP routes advertised over the IPsec tunnel.</br> This value is 0 for TunnelConnect, TunnelDisconnect, BGPConnect and BGPDisconnect events. |
| Sent Bytes | Optional number of bytes sent from source to destination over a tunnel during the last 15 minutes.</br> This value is 0 for TunnelConnect, TunnelDisconnect, BGPConnect and BGPDisconnect events. |
| Received Bytes | Optional number of bytes received by source from destination over a tunnel during the last 15 minutes.</br> This value is 0 for TunnelConnect, TunnelDisconnect, BGPConnect and BGPDisconnect events. |
| Remote network ID | ID of the remote network the tunnel is associated with. |

## Next steps

- [Enable enriched Microsoft 365 logs](how-to-view-enriched-logs.md)
- [Explore Global Secure Access traffic logs](how-to-view-traffic-logs.md)
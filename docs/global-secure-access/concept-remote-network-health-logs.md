---
title: Learn about Microsoft Entra Private Access
description: Learn about how Microsoft Entra Private Access secures access to your private corporate resources through the creation of Quick Access and Global Secure Access apps.
author: shlipsey3
ms.author: sarahlipsey
manager: amycolannino
ms.topic: how-to
ms.date: 07/27/2023
ms.service: network-access
ms.custom: 
ms.reviewer: katabish

---
This article describes how to use remote network health logs for Global Secure Access.

Prerequisite 
• You must have one of the following Entra ID roles to view Remote network health logs - Global Reader, Global Secure Access Administrator, Security Administrator or Global Administrator.

How does remote network health logs work?
IPSec tunnel between customer premise equipment (CPE) and Global Secure Access endpoint is a long running tunnel. Once set up you expect it stay alive as all users sitting in a branch office will be connected to the destination through this tunnel only. So, it is very important for you to be able to  track the health of - (1) IPSec tunnel and (2) BGP route advertisement.
Explanation of different columns you see in Remote network health logs:

Name 	Description 
Created date time	Time of original event generation
Source IP Address 	The IP address of the CPE. The {Source IP address, Destination IP address} pair will be unique for each IPsec tunnel. 
Destination IP Address 	The IP address of the Microsoft Entra gateway. The {Source IP address, Destination IP address} pair will be unique for each IPsec tunnel. 
Status	5 possible values - 
	1. TunnelConnect - This event is generated when an IPsec tunnel is successfully established.
	2. TunnelDisconnect -  This event is generated when an IPsec tunnel is disconnected.
	3. BGPConnect -  This event is generated when an BGP connectivity is successfully established.
	4. BGPDisconnect -  This event is generated when an BGP connectivity goes down.
	5. Alive - This is a periodic statistics generated every 15 minutes for all the active tunnels.
Description 	Optional. Description of the event.
BGP Routes Advertised Count 	Optional. Count of BGP routes advertised over the IPsec tunnel . This will be 0 for TunnelConnect, TunnelDisconnect, BGPConnect and BGPDisconnect events.
Sent Bytes 	Optional. The number of bytes sent from source to destination over a tunnel during the last 15 minutes' window.  This will be 0 for TunnelConnect, TunnelDisconnect, BGPConnect and BGPDisconnect events.
Received Bytes 	Optional. The number of bytes received by source from destination over a tunnel during the last 15 minutes' window.  This will be 0 for TunnelConnect, TunnelDisconnect, BGPConnect and BGPDisconnect events.
Remote network ID  	Id of the remote network of which the tunnel is part of.



How to view remote network health logs?

Microsoft Entra admin center
To view Remote network health logs in Microsoft Entra admin Center:
	• Sign in to the Microsoft Entra admin center with one of the Entra ID roles mentioned in Prerequisites section.
	• Global Secure Access (Preview) > Monitor > Remote network health logs.
	• Select Add filter to apply appropriate filters and fine tune your results.
	• You can choose the download the logs for up to past 1 month by selecting Download button.

Microsoft Graph API
	• Sign in to the Graph Explorer.
	• Select GET as the HTTP method from the dropdown.
	• Set the API version to beta.
	• Enter the following query:
	Request -
	GET https://graph.microsoft.com/beta/networkAccess/logs/remotenetworks
	• Select the Run query button to list the remote networks.

	Response -
	
	{
	    "@odata.context": "https://graph.microsoft.com/beta/$metadata#networkAccess/logs/remoteNetworks",
	    "@odata.nextLink": "https://graph.microsoft.com/beta/networkAccess/logs/remotenetworks?$skiptoken=a0850fa33aecaf5fc7240fdd13929d25cc2ffbaa9e985c2fd3787a9283ba28c0",
	    "@microsoft.graph.tips": "Use $select to choose only the properties your app needs, as this can lead to performance improvements. For example: GET networkAccess/logs/remoteNetworks?$select=bgpRoutesAdvertisedCount,createdDateTime",
	    "value": [
		…
	]
	}


